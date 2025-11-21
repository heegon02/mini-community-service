package kr.study.spring.dao;

import java.sql.Connection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import kr.study.spring.dto.Dto;


public class Dao {

    private DataSource dataSource;
    
    public Dao() {
    	try {
    		String configLocation = "classpath:application.xml";
    		AbstractApplicationContext ctx
    		= new GenericXmlApplicationContext(configLocation);
    		
    		this.dataSource = ctx.getBean("dataSource", DataSource.class);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }

    public void joinAction(String userId, String password, String email, String name,
                           String residentNumber, String address, String detailAddress,
                           Date birth, String interest, String introduce) {

        Connection conn = null;
        PreparedStatement ps = null;

        String sql = "INSERT INTO member (userId, password, email, name, residentNumber, address, detailAddress, birth, interest, introduce) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, userId);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, name);
            ps.setString(5, residentNumber);
            ps.setString(6, address);
            ps.setString(7, detailAddress);
            ps.setDate(8, birth);
            ps.setString(9, interest);
            ps.setString(10, introduce);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
    
    public boolean loginAction(String userId, String password) {
    	Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "select * from member where userId = ? and password = ?";
        
        try {
        	conn = dataSource.getConnection();
        	ps = conn.prepareStatement(sql);
        	
        	ps.setString(1, userId);
        	ps.setString(2, password);
        	
        	rs = ps.executeQuery();
        	
        	if (rs.next()) {
        		return true;
        	} else {
        		return false;
        	}
        	
        } catch(Exception e) {
        	e.printStackTrace();
        	return false;
        } finally {
        	try {
        		if (rs != null) rs.close();
        		if (ps != null) ps.close();
        		if (conn != null) conn.close();
        	} catch (Exception e2) {
        		e2.printStackTrace();
        	}
        }
    }
    
    // 로그인 성공 시 name 가져오기
    public String getName(String userId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT name FROM member WHERE userId = ?";

        try {
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userId);

            rs = ps.executeQuery();

            if(rs.next()) {
                return rs.getString("name");
            }

        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(Exception e2) {
                e2.printStackTrace();
            }
        }
        return null;
    }

    
    public Dto editProfile(String userId) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM member WHERE userId = ?";

        try {
            conn = dataSource.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userId);

            rs = ps.executeQuery();

            if (rs.next()) {
                Dto dto = new Dto();

                dto.setUserId(rs.getString("userId"));
                dto.setPassword(rs.getString("password"));
                dto.setEmail(rs.getString("email"));
                dto.setName(rs.getString("name"));
                dto.setResidentNumber(rs.getString("residentNumber"));
                dto.setAddress(rs.getString("address"));
                dto.setDetailAddress(rs.getString("detailAddress"));
                dto.setBirth(rs.getTimestamp("birth"));  // Timestamp에 맞춤!
                dto.setInterest(rs.getString("interest"));
                dto.setIntroduce(rs.getString("introduce"));

                return dto;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }

        return null;
    }

    
    public void updateProfile(String userId, String password, String email, String name,
            String address, String detailAddress, String interest, String introduce) {

    		Connection conn = null;
    		PreparedStatement ps = null;

    		String sql = "UPDATE member SET password=?, email=?, name=?, address=?, detailAddress=?, interest=?, introduce=? "
    					+ "WHERE userId=?";

    		try {
    			conn = dataSource.getConnection();
    			ps = conn.prepareStatement(sql);

    			ps.setString(1, password);
    			ps.setString(2, email);
    			ps.setString(3, name);
    			ps.setString(4, address);
    			ps.setString(5, detailAddress);
    			ps.setString(6, interest);
    			ps.setString(7, introduce);
    			ps.setString(8, userId);

    			ps.executeUpdate();

    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			try {
    				if (ps != null) ps.close();
    				if (conn != null) conn.close();
    			} catch (Exception e2) {
    				e2.printStackTrace();
    			}
    		}
    }

    
}
