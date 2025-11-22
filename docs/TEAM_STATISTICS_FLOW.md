# Team Statistics Flow Documentation

## Tổng quan
Hệ thống quản lý thống kê đội đua (team statistics) sử dụng 2 bảng để lưu trữ dữ liệu tổng hợp:
- `tblstatteaminseason`: Thống kê điểm và thứ hạng team theo mùa giải
- `tblstatteaminstage`: Thống kê điểm và thứ hạng team theo chặng đua

## Luồng cập nhật kết quả

### 1. Admin cập nhật kết quả đua (doUpdateResult.jsp)
```
Admin nhập:
- Số vòng đua hoàn thành (laps_completed)
- Thời gian hoàn thành (timedone)

↓ Gọi ResultDAO.updateResult()
↓ Lưu vào tblregister (KHÔNG lưu points)
```

### 2. Tính toán điểm team (ResultDAO.calculateAndUpdatePointsForStage)
```
Sau khi cập nhật tất cả kết quả:

Step 1: Tính điểm từng racer
- Lấy danh sách racers hoàn thành >= total_laps
- Sắp xếp theo timedone ASC
- Áp dụng hệ thống điểm:
  * 1st = 25 điểm
  * 2nd = 18 điểm
  * 3rd = 15 điểm
  * 4th = 12 điểm
  * 5th = 10 điểm
  * 6th = 8 điểm
  * 7th = 6 điểm
  * 8th = 4 điểm
  * 9th = 2 điểm
  * 10th = 1 điểm
  * DNF = 0 điểm

Step 2: Cập nhật tblstatteaminstage
- DELETE dữ liệu cũ của stage này
- INSERT dữ liệu mới:
  * Tính tổng điểm các racers theo team
  * (Không lưu `teamrank`) Lưu `totalpoints` cho mỗi team trong stage; rank sẽ được tính khi truy vấn
  
Step 3: Cập nhật tblstatteaminseason
- DELETE dữ liệu cũ của season này
- INSERT dữ liệu mới:
  * Tổng hợp điểm từ tất cả stages trong season
  * (Không lưu `teamrank`) Lưu `totalpoints` tổng cho mỗi team trong season; rank sẽ được tính khi truy vấn
```

### 3. Hiển thị bảng xếp hạng (teamRanking.jsp)

#### View by Season
```
TeamDAO.getTeamRankingsBySeason(seasonId)
↓
SELECT FROM tblstatteaminseason
JOIN với tblteam, tblstatteaminstage
↓
Hiển thị:
- Rank (từ tblstatteaminseason.teamrank)
- Total Points (từ tblstatteaminseason.totalpoints)
- Stages Participated (đếm từ tblstatteaminstage)
- Wins (đếm teamrank=1 trong stages)
- Rank: computed by ordering `totalpoints` DESC (not stored)
 - Total Points (từ tblstatteaminseason.totalpoints)
 - Stages Participated (đếm từ tblstatteaminstage)
 - Wins: có thể tính bằng cách đếm số chặng mà team có `totalpoints` cao nhất (tùy chọn)
```

#### View by Stage
```
TeamDAO.getTeamRankingsByStage(stageId)
↓
SELECT FROM tblstatteaminstage
JOIN với tblteam, tblregister
↓
Hiển thị:
- Rank (từ tblstatteaminstage.teamrank)
- Total Points (từ tblstatteaminstage.totalpoints)
- Racers Participated (đếm racers trong stage)
- Best Position (MIN position của racers)
 - Rank: computed by ordering `totalpoints` DESC for the stage (not stored)
 - Total Points (từ tblstatteaminstage.totalpoints)
 - Racers Participated (đếm racers trong stage)
 - Best Position (MIN position của racers)
```

## Schema 2 bảng thống kê

### tblstatteaminseason
```sql
CREATE TABLE `tblstatteaminseason` (
  `totalpoints` int DEFAULT NULL,           -- Tổng điểm team trong season
  `tblTeamid` int DEFAULT NULL,             -- Foreign key → tblteam
  `tblSeasonid` int DEFAULT NULL            -- Foreign key → tblseason
);
```

### tblstatteaminstage
```sql
CREATE TABLE `tblstatteaminstage` (
  `totalpoints` int DEFAULT NULL,           -- Tổng điểm team trong stage
  `tblTeamid` int DEFAULT NULL,             -- Foreign key → tblteam
  `tblStageid` int DEFAULT NULL             -- Foreign key → tblstage
);
```

## Lợi ích của kiến trúc này

### 1. Performance
- **Không cần tính toán realtime**: View đọc trực tiếp từ bảng stat
- **Query nhanh hơn**: Không cần JOIN phức tạp qua nhiều bảng
- **Scale tốt**: Với hàng nghìn racers/teams, query vẫn nhanh

### 2. Data Integrity
- **Snapshot điểm**: Lưu điểm tại thời điểm cụ thể
- **Audit trail**: Có thể trace lại điểm team qua từng stage
- **Consistent ranking**: Rank được tính một lần, không thay đổi khi query

### 3. Flexibility
- **Dễ thêm metrics**: Có thể thêm cột như avg_position, podium_count...
- **Support analytics**: Dễ dàng phân tích xu hướng qua các season
- **Cache-friendly**: Dữ liệu đã được tổng hợp sẵn

## Lưu ý quan trọng

### Khi nào cập nhật stats?
- **Sau mỗi lần admin update kết quả stage**
- Tự động gọi `calculateAndUpdatePointsForStage(stageId)`
- Cập nhật cả stage stats VÀ season stats

### Data consistency
- Khi sửa kết quả cũ → Phải re-calculate stats
- Delete cascade: Khi xóa stage → Phải xóa stats tương ứng
- Transaction: Nên wrap trong transaction để đảm bảo consistency

### Validation
- Total laps phải > 0
- Season ID phải tồn tại
- Stage phải thuộc về season đúng

## Testing checklist

- [ ] Cập nhật kết quả stage → Check stats được tạo đúng
- [ ] Racer hoàn thành đủ vòng → Được điểm theo rank
- [ ] Racer DNF → 0 điểm, không ảnh hưởng team rank
- [ ] Nhiều teams trong một stage → Rank đúng
- [ ] Tổng điểm season = Tổng điểm tất cả stages
- [ ] Re-update kết quả → Stats được cập nhật lại
- [ ] Performance với 100+ teams, 20+ stages
