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

public class RequestDao {

	private static RequestDao instance;
	public static RequestDao getInstance() {
		if(instance==null) {
			instance = new RequestDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private RequestDao() {
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
	} //RequestDao
	
	public ArrayList<RequestBean> getRequest() {
		ArrayList<RequestBean> list = new ArrayList<RequestBean>();
		try {
			String sql = "select * from request order by reqno";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getRequestBean(rs));
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
	
	public String getRequestByNo(String no, String anum) {
		String state = null;
		try {
			String sql = "select * from request where memno=? and anino=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			ps.setString(2, anum);
			rs = ps.executeQuery();
			if(rs.next()) {
				state = rs.getString("state");
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
		return state;
	}
	
	public int insertRequest(String no, String anum) {
		int cnt = -1;
		try {
			String sql = "insert into request values(request_seq.nextval,?,?,'신청')";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			ps.setString(2, anum);
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
	
	public int updateState(String reqno, String state) {
		int cnt = -1;
		try {
			String sql = "update request set state=? where reqno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, state);
			ps.setString(2, reqno);
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
	
	public ArrayList<AnimalBean> getAllRequestByNo(String no){
		ArrayList<AnimalBean> list = new ArrayList<AnimalBean>();
		try {
			String sql = "select reqno, memno, anum , kind , img , r.state state "
					+ "from request r inner join animal a on r.anino = a.anum where memno=? "
					+ "order by reqno desc";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			while(rs.next()) {
				AnimalBean ab = new AnimalBean();
				ab.setAge(rs.getInt("reqno")); // 잠깐만 reqno 담는용도로 사용
				ab.setColor(rs.getString("memno")); // 잠깐만 memno 담는용도로 사용
				ab.setAnum(rs.getInt("anum"));
				ab.setKind(rs.getString("kind")); 
				ab.setImg(rs.getString("img"));
				ab.setState(rs.getString("state"));
				list.add(ab);
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
	
	public ArrayList<AnimalBean> getAllRequest(String state,String search,int start,int end){
		ArrayList<AnimalBean> list = new ArrayList<AnimalBean>();
		try {
			String sql = "select reqno, memno, anum , kind , img , state "
					+ "from (select rownum as rank,reqno, memno, anum , kind , img , state "
					+ "from (select reqno, memno, anum , kind , img , r.state state "
					+ "from request r inner join animal a on r.anino = a.anum ";
			if(state.equals("상태")&&search.equals("없음")) {
				sql += "order by reqno)) where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, end);
			}else if(state.equals("상태")&&!search.equals("없음")) {
				sql += "where memno=? order by reqno)) where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, search);
				ps.setInt(2, start);
				ps.setInt(3, end);
			}else if(!state.equals("상태")&&search.equals("없음")) {
				sql += "where r.state=? order by reqno)) where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, state);
				ps.setInt(2, start);
				ps.setInt(3, end);
			}else {
				sql += "where r.state=? and memno=? order by reqno)) where rank between ? and ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, state);
				ps.setString(2, search);
				ps.setInt(3, start);
				ps.setInt(4, end);
			}
			rs = ps.executeQuery();
			while(rs.next()) {
				AnimalBean ab = new AnimalBean();
				ab.setAge(rs.getInt("reqno")); // 잠깐만 reqno 담는용도로 사용
				ab.setColor(rs.getString("memno")); // 잠깐만 memno 담는용도로 사용
				ab.setAnum(rs.getInt("anum"));
				ab.setKind(rs.getString("kind"));
				ab.setImg(rs.getString("img"));
				ab.setState(rs.getString("state"));
				list.add(ab);
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
	
	public int getRequestCount(String state, String search) {
		System.out.println("3:"+state+","+search);
		int count = 0;
		try {
			String sql = "select count(*) count from request ";
			if(!state.equals("상태")) {
				sql += "where state=? ";
				if(!search.equals("없음")) {
					sql += "and reqno=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, state);
					ps.setString(2, search);
				} else {
					ps = conn.prepareStatement(sql);
					ps.setString(1, state);
				}
			} else {
				if(!search.equals("없음")) {
					sql += "and reqno=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, search);
				} else {
					ps = conn.prepareStatement(sql);
				}
			}
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
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
		return count;
	}
	
	public ArrayList<RequestBean> getRequestByNo(String no) {
		ArrayList<RequestBean> list = new ArrayList<RequestBean>();
		try {
			String sql = "select * from request where state='승인' and memno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getRequestBean(rs));
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
	
	public int delRequest(String num,String no) {
		int cnt = -1;
		try {
			String sql = "delete from request where reqno=? and memno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
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
	
	public int delRequest2(String anum,String no) {
		int cnt = -1;
		try {
			String sql = "delete from request where anino=? and memno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, anum);
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
	
	public RequestBean getRequestBean(ResultSet rs) throws SQLException {
		RequestBean rb = new RequestBean();
		rb.setReqno(rs.getInt("reqno"));
		rb.setMemno(rs.getInt("memno"));
		rb.setAnino(rs.getInt("anino"));
		rb.setState(rs.getString("state"));
		return rb;
	}
}
