package my.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ReviewDao {
	private static ReviewDao instance;
	public static ReviewDao getInstance() {
		if(instance==null) {
			instance = new ReviewDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private ReviewDao() {
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
	} //ReviewDao
	
	public int insertReview(MultipartRequest mr) {
//		System.out.println("mno : " + mr.getParameter("mno"));
//		System.out.println("aname : " + mr.getParameter("aname"));
//		System.out.println("title : " + mr.getParameter("title"));
//		System.out.println("imgFile : " + mr.getOriginalFileName("img"));
//		System.out.println("content : " + mr.getParameter("content"));
		int cnt = -1;
		try {
			String sql = "insert into review(num,mno,aname,title,img,content) "
					+ "values(review_seq.nextval,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("mno"));
			ps.setString(2, mr.getParameter("aname"));
			ps.setString(3, "["+mr.getParameter("plus")+"] "+mr.getParameter("title"));
			ps.setString(4, mr.getOriginalFileName("img"));
			ps.setString(5, mr.getParameter("content"));
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int updateReview(MultipartRequest mr) {
//		System.out.println("num : " + mr.getParameter("num"));
//		System.out.println("mno : " + mr.getParameter("mno"));
//		System.out.println("aname : " + mr.getParameter("aname"));
//		System.out.println("title : " + mr.getParameter("title"));
//		System.out.println("img : " + mr.getOriginalFileName("img"));
//		System.out.println("orimg : " + mr.getParameter("orimg"));
//		System.out.println("content : " + mr.getParameter("content"));
//		System.out.println("day : " + mr.getParameter("day"));
		int cnt = -1;
		try {
			String sql = "update review set title=?,img=?,content=? where num=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "["+mr.getParameter("aname").trim()+"] "+mr.getParameter("title"));
			if(mr.getOriginalFileName("img")!=null) {
				ps.setString(2, mr.getOriginalFileName("img"));
			} else {
				ps.setString(2, mr.getParameter("orimg"));
			}
			ps.setString(3, mr.getParameter("content"));
			ps.setString(4, mr.getParameter("num"));
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int deleteReview(String num) {
		int cnt = -1;
		try {
			String sql = "delete from review where num=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ReviewBean getReviewByNum(String num) {
		ReviewBean rb = null;
		try {
			String sql2 = "update review set read=read+1 where num=?";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, num);
			ps.executeUpdate();
			String sql = "select * from review where num=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				rb = getReviewBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rb;
	}
	
	public ReviewBean getReview(String num) {
		ReviewBean rb = null;
		try {
			String sql = "select * from review where num=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				rb = getReviewBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rb;
	}
	
	public String getTitle(String num) {
	    String title = null;
	    try {
	        String sql = "select title, instr(title, ?) point from review where num = ?";
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, "]");
	        ps.setString(2, num); // num 파라미터를 설정합니다.
	        rs = ps.executeQuery();
	        if(rs.next()) {
	            int point = rs.getInt("point");
	            if (point > 0) { // "]" 문자가 실제로 존재하는 경우에만 수행
	                title = rs.getString("title").substring(point + 1); // point+1을 사용하여 "]" 바로 뒤의 문자열을 추출합니다.
	                System.out.println("title : " + title);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(ps != null) ps.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return title;
	}

	
	public ArrayList<ReviewBean> getAllReview(int start, int end) {
		ArrayList<ReviewBean> list = new ArrayList<ReviewBean>();
		try {
			String sql = "select num,mno,aname,title,img,read,content,day "	        
					+ "from (select rownum as rank,num,mno,aname,title,img,read,content,day "
					+ "from (select num,mno,aname,title,img,read,content,day from review order by num desc)) "
					+ "where rank between ? and ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getReviewBean(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int getAllReviewCount() {
		int count = 0;
		try {
			String sql = "select count(*) from review";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	public long getDay(int num) {
		long daysBetween = 0;
		try {
			String sql = "select day from review where num=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			if (rs.next()) {
				// DB에서 가져온 날짜 정보를 LocalDate 형태로 변환
				LocalDate dbDate = rs.getDate(1).toLocalDate();
				// 현재 날짜 가져오기
				LocalDate today = LocalDate.now();
				// 두 날짜의 차이 계산
				daysBetween = ChronoUnit.DAYS.between(dbDate, today);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return daysBetween;
	}
	
	public ReviewBean getReviewBean(ResultSet rs) throws SQLException {
		ReviewBean rb = new ReviewBean();
		rb.setNum(rs.getInt("num"));
		rb.setMno(rs.getInt("mno"));
		rb.setAname(rs.getString("aname"));
		rb.setTitle(rs.getString("title"));
		rb.setRead(rs.getInt("read"));
		rb.setImg(rs.getString("img")); 
		rb.setContent(rs.getString("content"));
		rb.setDay(String.valueOf(rs.getDate("day")));
		return rb;
	}
}
