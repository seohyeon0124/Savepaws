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

import com.oreilly.servlet.MultipartRequest;

import my.animal.AnimalBean;

public class StoreDao {
	private static StoreDao instance;
	public static StoreDao getInstance() {
		if(instance==null) {
			instance = new StoreDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private StoreDao() {
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
	} //StoreDao
	
	public ArrayList<StoreBean> getAllStore(){
		ArrayList<StoreBean> list = new ArrayList<StoreBean>();
		try {
			String sql = "select * from store order by snum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getStoreBean(rs));
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
	
	public int deleteStore(String snum) {
		int cnt = -1;
		try {
			String sql = "delete from store where snum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, snum);
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
	
	public int insertStore(MultipartRequest mr) {
		int cnt = -1;
		try {
			String sql = "insert into store values(store_seq.nextval,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("name"));
			ps.setString(2, mr.getParameter("cate")+mr.getParameter("code"));
			ps.setString(3, mr.getOriginalFileName("img"));
			ps.setString(4, mr.getParameter("qty"));
			ps.setString(5, mr.getParameter("price"));
			ps.setString(6, mr.getParameter("content"));
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
	
	public StoreBean getStoreBySnum(String snum) {
		StoreBean sb = new StoreBean();
		try {
			String sql = "select * from store where snum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, snum);
			rs = ps.executeQuery();
			if(rs.next()) {
				sb = getStoreBean(rs);
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
		return sb;
	}
	
	public int updateStore(MultipartRequest mr) {
		int cnt = -1;
		try {
			String sql = "update store set name=?,code=?,qty=?,price=?,img=?,content=? where snum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("name"));
			ps.setString(2, mr.getParameter("code"));
			ps.setString(3, mr.getParameter("qty"));
			ps.setString(4, mr.getParameter("price"));
			if(mr.getOriginalFileName("img")!=null) {
				ps.setString(5, mr.getOriginalFileName("img"));
			} else {
				ps.setString(5, mr.getParameter("orimg"));
			}
			ps.setString(6, mr.getParameter("content"));
			ps.setString(7, mr.getParameter("snum"));
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
	
	public StoreBean getStoreBean(ResultSet rs) throws SQLException {
		StoreBean sb = new StoreBean();
		sb.setSnum(rs.getInt("snum"));
		sb.setName(rs.getString("name"));
		sb.setCode(rs.getString("code"));
		sb.setImg(rs.getString("img"));
		sb.setQty(rs.getInt("qty"));
		sb.setPrice(rs.getInt("price"));
		sb.setContent(rs.getString("content"));
		return sb;
	}
}
