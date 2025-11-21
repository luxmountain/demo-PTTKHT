package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import model.Contract;
import model.Racer;
import model.Register;
import model.Result;
import model.Stage;
import model.Team;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ADMIN
 */
public class RegisterDAO extends DAO {

    public RegisterDAO() {
        super();
    }

    /**
     * Get all racers registered for a specific stage with their current results
     * 
     * @param stageId the stage ID
     * @return list of Register objects with Result data
     */
    public List<Register> getRegistersByStage(int stageId) {
        List<Register> registers = new ArrayList<>();

        String sql = "SELECT r.id as register_id, r.dateregistered, r.status, "
                + "r.tblContractid as contract_id, r.tblStageid as stage_id, "
                + "m.id as racer_id, m.name as racer_name, m.username as racer_username, "
                + "m.password as racer_password, m.dob as racer_dob, m.address as racer_address, "
                + "m.email as racer_email, m.phonenumber as racer_phone, "
                + "ra.nationality, ra.shirtnumber, ra.status as racer_status, "
                + "t.id as team_id, t.name as team_name, t.description as team_desc, "
                + "t.nation as team_nation, t.totalpoints, t.status as team_status, "
                + "c.salary, c.startdate, c.enddate, c.status as contract_status, "
                + "s.name as stage_name, s.date as stage_date, s.location, s.description, s.roadmap, s.status as stage_status, s.tblSeasonid, "
                + "r.laps_completed, r.timedone, r.points "
                + "FROM tblregister r "
                + "INNER JOIN tblcontract c ON r.tblContractid = c.id "
                + "INNER JOIN tblracer ra ON c.tblRacerid = ra.id "
                + "INNER JOIN tblmember m ON ra.tblMemberid = m.id "
                + "INNER JOIN tblteam t ON c.tblTeamid = t.id "
                + "INNER JOIN tblstage s ON r.tblStageid = s.id "
                + "WHERE r.tblStageid = ? "
                + "ORDER BY CASE WHEN r.timedone IS NULL THEN 1 ELSE 0 END, r.timedone, m.name";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Register register = new Register();
                register.setId(rs.getInt("register_id"));
                register.setDateRegistered(rs.getDate("dateregistered"));
                register.setStatus(rs.getBoolean("status"));

                // Create Racer object
                Racer racer = new Racer();
                racer.setId(rs.getInt("racer_id"));
                racer.setName(rs.getString("racer_name"));
                racer.setUsername(rs.getString("racer_username"));
                racer.setPassword(rs.getString("racer_password"));
                racer.setDob(rs.getDate("racer_dob"));
                racer.setAddress(rs.getString("racer_address"));
                racer.setEmail(rs.getString("racer_email"));
                racer.setPhonenumber(rs.getString("racer_phone"));
                racer.setNationality(rs.getString("nationality"));
                racer.setShirtnumber(rs.getInt("shirtnumber"));
                racer.setStatus(rs.getBoolean("racer_status"));

                // Create Team object
                Team team = new Team();
                team.setId(rs.getInt("team_id"));
                team.setName(rs.getString("team_name"));
                team.setDescription(rs.getString("team_desc"));
                team.setNation(rs.getString("team_nation"));
                team.setTotalpoints(rs.getInt("totalpoints"));
                team.setStatus(rs.getBoolean("team_status"));

                // Create and set Contract object
                Contract contract = new Contract();
                contract.setId(rs.getInt("contract_id"));
                contract.setSalary(rs.getFloat("salary"));
                contract.setStartdate(rs.getDate("startdate"));
                contract.setEnddate(rs.getDate("enddate"));
                contract.setStatus(rs.getBoolean("contract_status"));
                contract.setRacer(racer);
                contract.setTeam(team);
                register.setContract(contract);

                // Create and set Stage object
                Stage stage = new Stage();
                stage.setId(rs.getInt("stage_id"));
                stage.setName(rs.getString("stage_name"));
                stage.setDate(rs.getDate("stage_date"));
                stage.setLocation(rs.getString("location"));
                stage.setDescription(rs.getString("description"));
                stage.setRoadmap(rs.getString("roadmap"));
                stage.setStatus(rs.getBoolean("stage_status"));
                stage.setSeasonId(rs.getInt("tblSeasonid"));
                register.setStage(stage);

                // Create and set Result object
                Result result = new Result();

                int lapsCompleted = rs.getInt("laps_completed");
                if (!rs.wasNull()) {
                    result.setLapsCompleted(lapsCompleted);
                }

                Time timedone = rs.getTime("timedone");
                result.setTimedone(timedone);

                int points = rs.getInt("points");
                if (!rs.wasNull()) {
                    result.setPoints(points);
                }

                register.setResult(result);
                registers.add(register);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return registers;
    }
}
