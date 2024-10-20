package my.ask;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AskDao {
	private static AskDao instance;
	public static AskDao getInstance() {
		if(instance==null) {
			instance = new AskDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private AskDao() {
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
	} //AskDao
	
	public int getAskCnt() {
		int cnt = 0;
		try {
			String sql = "select count(*) cnt from ask";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ArrayList<AskBean> getAllAsk(int start, int end) {
		ArrayList<AskBean> list = new ArrayList<AskBean>();
		try {
			String sql = "select bno,mno,title,reg_date,readcount,ref,re_step,re_level,content "
					+ "from (select rownum rank,bno,mno,title,reg_date,readcount,ref,re_step,re_level,content "
					+ "from (select * from ask order by ref desc, re_step)) "
					+ "where rank between ? and ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getAskBean(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int insertAsk(AskBean ab, String state) {
		int cnt = -1;
		try {
			int ref = 0;
			String sql2 = "select max(ref) maxref from ask";
			ps = conn.prepareStatement(sql2);
			rs = ps.executeQuery();
			if(rs.next()) {
				ref = rs.getInt("maxref");
			}
			String sql = "insert into ask(bno,mno,title,ref,re_step,re_level,content)"
					+ " values(ask_seq.nextval,?,?,?,0,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ab.getMno());
			if(state==null) {
				ps.setString(2, ab.getTitle());
				ps.setInt(3, ref+1);
				ps.setInt(4, 0);
			}else {
				ps.setString(2, "----> [관리자답변] " + ab.getTitle());
				ps.setString(3, state);
				ps.setInt(4, 1);
			}
			ps.setString(5, ab.getContent());
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int updateAsk(String bno, String title, String content) {
		int cnt = -1;
		try {
			String sql = "update ask set title=?,content=? where bno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, content);
			ps.setString(3, bno);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int deleteAsk(String bno) {
		int cnt = -1;
		try {
			String sql = "delete from ask where bno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public AskBean getAskView(String bno) {
		AskBean ab = new AskBean();
		try {
			String sql2 = "update ask set readcount=readcount+1 where bno=?";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, bno);
			ps.executeUpdate();
			String sql = "select * from ask where bno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			rs = ps.executeQuery();
			if(rs.next()) {
				ab = getAskBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ab;
	}
	
	public AskBean getAskByBno(String bno) {
		AskBean ab = new AskBean();
		// System.out.println("시작 : " + bno);
		try {
			String sql = "select * from ask where bno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			rs = ps.executeQuery();
			if(rs.next()) {
				ab = getAskBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ab;
	}
	
	public AskBean getAskBean(ResultSet rs) throws SQLException {
		AskBean ab = new AskBean();
		ab.setBno(rs.getInt("bno"));
		ab.setMno(rs.getInt("mno"));
		ab.setReadcount(rs.getInt("readcount"));
		ab.setRef(rs.getInt("ref"));
		ab.setRe_step(rs.getInt("re_step"));
		ab.setRe_level(rs.getInt("re_level"));
		ab.setTitle(rs.getString("title"));
		ab.setReg_date(String.valueOf(rs.getDate("reg_date")));
		ab.setContent(rs.getString("content"));
		return ab;
	}
}
