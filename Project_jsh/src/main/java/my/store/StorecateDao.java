package my.store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class StorecateDao {
	private static StorecateDao instance;
	public static StorecateDao getInstance() {
		if(instance==null) {
			instance = new StorecateDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private StorecateDao() {
		Context initContext; 
		try { 
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); 
			conn = ds.getConnection(); 
			System.out.println("드라이버 로드 및 접속 성공");
		} catch (NamingException e) { 
			e.printStackTrace(); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} //StorecateDao
	
	public ArrayList<StorecateBean> getAllStorecate(){
		ArrayList<StorecateBean> list = new ArrayList<StorecateBean>();
		try {
			String sql = "select * from scate order by catenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getStorecateBean(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int insertCate(String catename, String catecode) {
		int cnt = -1;
		try {
			String sql = "insert into scate values(scate_seq.nextval,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, catename);
			ps.setString(2, catecode);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int deleteCate(String catenum) {
		int cnt = -1;
		try {
			String sql = "delete from scate where catenum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, catenum);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public StorecateBean getStorecateBean(ResultSet rs) throws SQLException {
		StorecateBean sb = new StorecateBean();
		sb.setCatenum(Integer.parseInt(rs.getString("catenum")));
		sb.setCatename(rs.getString("catename"));
		sb.setCatecode(rs.getString("catecode"));
		return sb;
	}
}
