package edu.chunjae.model;

import edu.chunjae.dto.Custom;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomDAO {
    static Connection conn = null;
    static PreparedStatement pstmt = null;
    static ResultSet rs = null;

    public List<Custom> getCustomList() {
        List<Custom> cusList = new ArrayList<>();
        DBConnect con = new MariaDBCon();
        conn = con.connect();
        try {
            pstmt = conn.prepareStatement(DBConnect.CUSTOM_SELECT_ALL);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Custom custom = new Custom();
                custom.setId(rs.getString("id"));
                custom.setPw(rs.getString("pw"));
                custom.setName(rs.getString("name"));
                custom.setPoint(rs.getInt("point"));
                custom.setGrade(rs.getString("grade"));
                custom.setTel(rs.getString("tel"));
                custom.setEmail(rs.getString("email"));
                custom.setBirth(rs.getString("birth"));
                custom.setRegdate(rs.getString("regdate"));
                cusList.add(custom);
            }
        } catch (SQLException e) {
            System.out.println("sql 에러");
        } finally {
            con.close(rs, pstmt, conn);
        }
        return cusList;
    }

    public Custom getCustom(String id) {
        Custom custom = new Custom();
        DBConnect con = new MariaDBCon();
        conn = con.connect();
        try {
            pstmt = conn.prepareStatement(DBConnect.CUSTOM_SELECT_ONE);
            pstmt.setString(1,id);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                custom.setId(rs.getString("id"));
                custom.setPw(rs.getString("pw"));
                custom.setName(rs.getString("name"));
                custom.setPoint(rs.getInt("point"));
                custom.setGrade(rs.getString("grade"));
                custom.setTel(rs.getString("tel"));
                custom.setEmail(rs.getString("email"));
                custom.setBirth(rs.getString("birth"));
                custom.setRegdate(rs.getString("regdate"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            con.close(rs, pstmt, conn);
        }
        return custom;
    }

    public boolean login(String id, String pw) {
        boolean pass = false;
        DBConnect con = new MariaDBCon();
        conn = con.connect();
        try {
            pstmt = conn.prepareStatement(DBConnect.CUSTOM_SELECT_LOG);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                pass = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            con.close(rs, pstmt, conn);
        }
        return pass;
    }

    public boolean join(String id, String pw, String name, String tel, String email, String birth, String address) {
        boolean pass = false;
        DBConnect con = new MariaDBCon();
        conn = con.connect();
        try {
            pstmt = conn.prepareStatement(DBConnect.CUSTOM_INSERT);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            pstmt.setString(3, name);
            pstmt.setString(4, tel);
            pstmt.setString(5, email);
            pstmt.setString(6, birth);
            pstmt.setString(7, address);
            int cnt = pstmt.executeUpdate();
            if(cnt > 0) {
                pass = true;
            }
        } catch (SQLException e) {
            System.out.println("sql 에러");
        } finally {
            con.close(pstmt, conn);
        }
        return pass;
    }

    public boolean idCheck(String id) {
        Custom custom = new Custom();
        DBConnect con = new MariaDBCon();
        boolean pass = false;
        conn = con.connect();
        try {
            pstmt = conn.prepareStatement(DBConnect.CUSTOM_SELECT_ONE);
            pstmt.setString(1,id);
            rs = pstmt.executeQuery();
            if(!rs.next()) {
                pass = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            con.close(rs, pstmt, conn);
        }
        return pass;
    }

    public int deleteCustom(String id){
        int cnt = 0;
        DBConnect con = new MariaDBCon();
        conn = con.connect();
        if(conn!=null){
            System.out.println("SQL 연결 성공");
        }

        String sql = "delete from custom where id=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            cnt = pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            con.close(pstmt, conn);
        }
        return cnt;
    }
}
