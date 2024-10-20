package my.free;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;

public class FreeDao {
	private static FreeDao instance;
	public static FreeDao getInstance() {
		if(instance==null) {
			instance = new FreeDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private FreeDao() {
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
	} //FreeDao
	
	public int getAllCount() {
		int cnt = -1;
		try {
			String sql = "select count(*) cnt from free";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
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
		return cnt;
	}
	
	public int getCityCount(String city) {
		int cnt = -1;
		try {
			String sql = "select count(*) cnt from free where city=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,city);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
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
		return cnt;
	}
	
	public int getPlaceCount(String place) {
		int cnt = -1;
		try {
			String sql = "select count(*) cnt from free where place=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,place);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
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
		return cnt;
	}
	
	public ArrayList<FreeBean> getFree(String city, String place, int start, int end) {
		ArrayList<FreeBean> list = new ArrayList<FreeBean>();
		System.out.println("city : " + city);
		System.out.println("place : " + place);
		try {
			String sql = null;
			if(city.equals("전체")) {
				sql = "select no,mno,name,city,place,lat,lng,content,state,img,day,want "
					+ "from (select rownum rank,no,mno,name,city,place,lat,lng,content,state,img,day,want "
					+ "from (select * from free order by no desc)) "
					+ "where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, end);
			}else if(place.equals("전체")) {
				sql = "select no,mno,name,city,place,lat,lng,content,state,img,day,want "
						+ "from (select rownum rank,no,mno,name,city,place,lat,lng,content,state,img,day,want "
						+ "from (select * from free where city=? order by no desc)) "
						+ "where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, city);
				ps.setInt(2, start);
				ps.setInt(3, end);
			}else {
				sql = "select no,mno,name,city,place,lat,lng,content,state,img,day,want "
					+ "from (select rownum rank,no,mno,name,city,place,lat,lng,content,state,img,day,want "
					+ "from (select * from free where city=? and place=? order by no desc)) "
					+ "where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, city);
				ps.setString(2, place);
				ps.setInt(3, start);
				ps.setInt(4, end);
			} 
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getFreeBean(rs));
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
	
	public int insertFree(MultipartRequest mr) {
		int cnt = -1;
		try {
			String sql = "insert into free values(free_seq.nextval,?,?,?,?,?,?,?,'등록',?,sysdate,'-')";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("mno"));
			ps.setString(2, mr.getParameter("name"));
			ps.setString(3, mr.getParameter("city"));
			ps.setString(4, mr.getParameter("place"));
			ps.setString(5, mr.getParameter("lat"));
			ps.setString(6, mr.getParameter("lng"));
			ps.setString(7, mr.getParameter("content"));
			ps.setString(8, mr.getOriginalFileName("img"));
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
	
	public int updateState(String no,String email) {
		int cnt = -1;
		try {
			String sql = "update free set state='신청',want=? where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, no);
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
	
	public ArrayList<JSONObject> getLatLng() {
		ArrayList<JSONObject> list = new ArrayList<JSONObject>();
		try {
			String sql = "select * from free";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("no", rs.getString("no"));
				obj.put("lat", rs.getString("lat"));
	            obj.put("lng", rs.getString("lng"));
	            obj.put("name", rs.getString("name"));
	            obj.put("content", rs.getString("content"));
	            System.out.println("lat:"+rs.getString("lat"));
	            System.out.println("lng:"+rs.getString("lng"));
	            list.add(obj);
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
	
	public FreeBean getFreeByNo(String no) {
		FreeBean fb = new FreeBean();
		try {
			String sql = "select * from free where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			while(rs.next()) {
				fb = getFreeBean(rs);
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
		return fb;
	}
	
	public ArrayList<FreeBean> getFreeByMno(String mno) {
		ArrayList<FreeBean> list = new ArrayList<FreeBean>();
		try {
			String sql = "select * from free where mno=? order by no desc";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mno);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getFreeBean(rs));
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
	
	public ArrayList<FreeBean> getFreeByWant(String email) {
		ArrayList<FreeBean> list = new ArrayList<FreeBean>();
		try {
			String sql = "select * from free where want=? order by no desc";
			ps = conn.prepareStatement(sql);
			ps.setString(1,email);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getFreeBean(rs));
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
	
	public int delFree(String no) {
		int cnt = -1;
		try {
			String sql = "delete from free where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
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
	
	public boolean getlikes(String no,String mno) {
		boolean likes = false;
		try {
			String sql = "select * from free where no=? and likes like ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			ps.setString(2, "% "+mno+" %");
			rs = ps.executeQuery();
			if(rs.next()) {
				likes = true;
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
		return likes;
	}
	
	public FreeBean getFreeBean(ResultSet rs) throws SQLException {
		FreeBean fb = new FreeBean();
		fb.setNo(rs.getInt("no"));
		fb.setMno(rs.getInt("mno"));
		fb.setName(rs.getString("name"));
		fb.setCity(rs.getString("city"));
		fb.setPlace(rs.getString("place"));
		fb.setContent(rs.getString("content"));
		fb.setState(rs.getString("state"));
		fb.setImg(rs.getString("img"));
		fb.setWant(rs.getString("want"));
		fb.setLat(rs.getString("lat"));
		fb.setLng(rs.getString("lng"));
		fb.setDay(String.valueOf(rs.getDate("day")));
		return fb;
	}
}
