package kr.study.spring.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import kr.study.spring.dto.BDto;

public class BDao {

	private DataSource dataSource;
	
	public BDao() {
		try {
			String configLocation = "classpath:application.xml";
			AbstractApplicationContext ctx
			= new GenericXmlApplicationContext(configLocation);
			
			this.dataSource = ctx.getBean("dataSource", DataSource.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void write(String bName, String bTitle, String bContent) {
	      
	      Connection connection = null;
	      PreparedStatement preparedStatement = null;
	      
	      try {
	         connection = dataSource.getConnection();
	         String query 
	         = "insert into board (bName, bTitle, bContent, bHit, bStep, bIndent) "
	               + "values (?, ?, ?, 0, 0, 0 )";
	         preparedStatement = connection.prepareStatement(query);
	         preparedStatement.setString(1, bName);
	         preparedStatement.setString(2, bTitle);
	         preparedStatement.setString(3, bContent);
	         int rn = preparedStatement.executeUpdate();
	         if(rn > 0) {
	            //bgroup 데이터 값, bId하고 동일하게 만들기
	            writeUpdate(connection, preparedStatement); 
	         }
	      } catch (Exception e) {
	         // TODO: handle exception
	         e.printStackTrace();
	      } finally {
	         try {
	            if(preparedStatement != null) preparedStatement.close();
	            if(connection != null) connection.close();
	         } catch (Exception e2) {
	            // TODO: handle exception
	            e2.printStackTrace();
	         }
	      }
	      
	   }

	   public int writeUpdate(Connection connection, PreparedStatement preparedStatement) {
	      int rn = 0;
	      
	      try {
	         String query = "UPDATE board SET bGroup = bId WHERE bId = LAST_INSERT_ID()";
	         preparedStatement = connection.prepareStatement(query);
	         
	         rn = preparedStatement.executeUpdate();
	         
	      }
	      catch (Exception e) {
	         e.printStackTrace();
	      }
	      finally {
	         try {
	            if(preparedStatement != null) preparedStatement.close();
	            if(connection != null) connection.close();
	         } catch (Exception e2) {
	            e2.printStackTrace();
	         }
	      }
	      return rn;
	   }
	
	public ArrayList<BDto> list() {
	      
	      ArrayList<BDto> dtos = new ArrayList<BDto>();
	      Connection connection = null;
	      PreparedStatement preparedStatement = null;
	      ResultSet resultSet = null;
	      
	      try {
	         connection = dataSource.getConnection();
	         
	         String query = "select bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent from board order by bGroup desc, bStep asc";
	         preparedStatement = connection.prepareStatement(query);
	         resultSet = preparedStatement.executeQuery();
	         
	         while (resultSet.next()) {
	            int bId = resultSet.getInt("bId");
	            String bName = resultSet.getString("bName");
	            String bTitle = resultSet.getString("bTitle");
	            String bContent = resultSet.getString("bContent");
	            Timestamp bDate = resultSet.getTimestamp("bDate");
	            int bHit = resultSet.getInt("bHit");
	            int bGroup = resultSet.getInt("bGroup");
	            int bStep = resultSet.getInt("bStep");
	            int bIndent = resultSet.getInt("bIndent");
	            
	            BDto dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);
	            dtos.add(dto);
	         }
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if(resultSet != null) resultSet.close();
	            if(preparedStatement != null) preparedStatement.close();
	            if(connection != null) connection.close();
	         } catch (Exception e2) {
	            // TODO: handle exception
	            e2.printStackTrace();
	         }
	      }
	      return dtos;
	   }
	
	public BDto contentView(String strId) {
		
		upHit(strId); //조회수 증가시키는 함수
		
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
	    BDto dto = null;
	    
	    try {
	    	connection = dataSource.getConnection();
	    	String query = "select * from board where bId = ?";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	preparedStatement.setInt(1, Integer.parseInt(strId));
	        resultSet = preparedStatement.executeQuery();
	        
	        if (resultSet.next()) {
	            int bId = resultSet.getInt("bId");
	            String bName = resultSet.getString("bName");
	            String bTitle = resultSet.getString("bTitle");
	            String bContent = resultSet.getString("bContent");
	            Timestamp bDate = resultSet.getTimestamp("bDate");
	            int bHit = resultSet.getInt("bHit");
	            int bGroup = resultSet.getInt("bGroup");
	            int bStep = resultSet.getInt("bStep");
	            int bIndent = resultSet.getInt("bIndent");
	            
	            dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);
	         }
	        
	    	
	    } catch (Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	try {
	    		if(resultSet != null) resultSet.close();
	    		if(preparedStatement != null) preparedStatement.close();
	    		if(connection != null) connection.close();
	    	} catch (Exception e2) {
	    		e2.printStackTrace();
	    	}
	    }
	    
		return dto;
	}
	
	private void upHit(String bId) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = dataSource.getConnection();
			String query = "update board set bHit = bHit + 1 where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bId);
			
			int rn = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) preparedStatement.close();
				if (connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	private void upStep(String bId) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = dataSource.getConnection();
			String query = "update board set bStep = bStep + 1 where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bId);
			
			int rn = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) preparedStatement.close();
				if (connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	private void upIndent(String bId) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = dataSource.getConnection();
			String query = "update board set bIndent = bIndent + 1 where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bId);
			
			int rn = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) preparedStatement.close();
				if (connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void modify(String bId, String bName, String bTitle, String bContent) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = dataSource.getConnection();
			String query = "update board set bName = ?, bTitle = ?, bContent = ? where bId = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bName);
			preparedStatement.setString(2, bTitle);
			preparedStatement.setString(3, bContent);
			preparedStatement.setString(4, bId);
			
		    preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) preparedStatement.close();
				if (connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		}
	}
	
	public void delete(String bId) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			connection = dataSource.getConnection();
			String query = "delete from board where bId = ?";
			
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bId);
			
			preparedStatement.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null) preparedStatement.close();
				if (connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public void reply(String strId, String bName, String bTitle, String bContent) {

	    Connection connection = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        connection = dataSource.getConnection();

	        String sql = "select bGroup, bStep, bIndent from board where bId =?";
	        pstmt = connection.prepareStatement(sql);
	        pstmt.setInt(1, Integer.parseInt(strId));
	        
	        rs = pstmt.executeQuery();

	        int bGroup = 0;
	        int bStep = 0;
	        int bIndent = 0;

	        if (rs.next()) {
	            bGroup = rs.getInt("bGroup");
	            bStep = rs.getInt("bStep");
	            bIndent = rs.getInt("bIndent");
	        }

	        rs.close();
	        pstmt.close();
	        
	        sql = "update board set bStep = bStep + 1 where bGroup = ? and bStep > ?";
	        pstmt = connection.prepareStatement(sql);
	        pstmt.setInt(1, bGroup);
	        pstmt.setInt(2, bStep);
	        pstmt.executeUpdate();
	        pstmt.close();

	        sql = "insert into board (bName, bTitle, bContent, bGroup, bStep, bIndent, bHit) " +
	              "values (?, ?, ?, ?, ?, ?, 0)";
	        pstmt = connection.prepareStatement(sql);
	        pstmt.setString(1, bName);
	        pstmt.setString(2, bTitle);
	        pstmt.setString(3, bContent);
	        pstmt.setInt(4, bGroup);
	        pstmt.setInt(5, bStep + 1);
	        pstmt.setInt(6, bIndent + 1);

	        pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	}

	
	
	 

	
}
