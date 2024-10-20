package my.animal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AnicateDao {
	private static AnicateDao instance;
	public static AnicateDao getInstance() {
		if(instance==null) {
			instance = new AnicateDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private AnicateDao() {
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
	} //AnicateDao
	
	public ArrayList<AnicateBean> getAllAnicate(){
		ArrayList<AnicateBean> list = new ArrayList<AnicateBean>();
		try {
			String sql = "select * from acate order by catenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getAnicateBean(rs));
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
			String sql = "insert into acate values(acate_seq.nextval,?,?)";
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
			String sql = "delete from acate where catenum=?";
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
	
	public String getAnicateName(String catecode){
		String catename = null;
		try {
			String sql = "select * from acate where catecode=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, catecode);
			rs = ps.executeQuery();
			if(rs.next()) {
				catename = rs.getString("catename");
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
		return catename;
	}
	
	public AnicateBean getAnicateBean(ResultSet rs) throws SQLException {
		AnicateBean ab = new AnicateBean();
		ab.setCatenum(Integer.parseInt(rs.getString("catenum")));
		ab.setCatename(rs.getString("catename"));
		ab.setCatecode(rs.getString("catecode"));
		return ab;
	}
}
