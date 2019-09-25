package com.spring_web.bbs.repository;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.spring_web.bbs.exception.InsertException;
import com.spring_web.bbs.vo.UserVO;

@Repository
public class LoginDAO {
	Connection conn = null;
	PreparedStatement prep = null;
	ResultSet rs = null;
	
	private static LoginDAO instance = new LoginDAO();
	
	public static LoginDAO getInstance() {
		
		return instance;
		
	}
	
	 Connection getConnection() throws SQLException {
        Connection conn = null;

        try {
            Class.forName("org.mariadb.jdbc.Driver");

        
            conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/TestDB", "root", "1234");
        }
        catch (ClassNotFoundException e) {
            System.out.println(" 드라이버 로딩 실패 ");
        }

        return conn;
    }
	
	public int userCheck(UserVO vo) {
		String sql = "select * from testuser where UserId=?;";
		int ok = 0;
		
		try {
			
			conn = getConnection();
			prep = conn.prepareStatement(sql);
			
			prep.setString(1, vo.getUserId());
			rs = prep.executeQuery();
			
				while(rs.next()) {
					if(vo.getUserPw() == null && vo.getUserId() == null) {
						
						ok = -1;
						System.out.println("아이디 또는 비밀번호를 확인-1");
						
					}else if(rs.getString(2).equals(vo.getUserPw())) {
						
	            		System.out.println("로그인 성공");
	            		vo.setUserId(rs.getString(1));
	            		vo.setUserPw(rs.getString(2));
	            		vo.setUserName(rs.getString(3));
	            		ok = 1;
	            		
	            	} else {
	            		
	            		ok = 0;
	            		System.out.println("아이디 또는 비밀번호를 확인0");
	            		System.out.println(rs.getString(3));
	            	}
				}
//				if(rs.getString(1).equals(UserId) && rs.getString("user_pw")!=null && 
//				rs.getString("user_pw").equals(user_pw)) {
				
		}catch(SQLException e){
			//e.printStackTrace();
			throw new InsertException();
		}finally {
			try {
				if(rs != null) rs.close();
				if(prep != null) prep.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return ok;
	}
	
	
	
	
	
	
	
	
	
}
