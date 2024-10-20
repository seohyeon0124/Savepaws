package my.member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDao {
	
	private static MemberDao instance;
	public static MemberDao getInstance() {
		if(instance==null) {
			instance = new MemberDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private MemberDao() {
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
	} //MemberDao
	
	public String getMemberName(String email) {
		String name = null;
		try {
			String sql = "select * from member where email=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
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
		return name;
	} //getMemberName
	
	public boolean searchEmail(String userEmail) {
		boolean flag = false;
		try {
			String sql = "select * from member where email=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userEmail);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
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
		return flag;
	}
	
	public String getMemberNameByNo(String no) {
		String name = null;
		System.out.println("회원번호:"+no);
		try {
			String sql = "select * from member where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
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
		System.out.println("회원이름:"+name);
		return name;
	} //getMemberName
	
	public String getMemberEmailByNo(String no) {
		String email = null;
		try {
			String sql = "select * from member where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {
				email = rs.getString("email");
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
		return email;
	}
	
	public int getMemberCount() {
		int count = 0;
		try {
			String sql = "select count(*) count from member";
			ps = conn.prepareStatement(sql);
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
	
	public int getMemberCountByName(String search) {
		int count = 0;
		try {
			String sql = "select count(*) count from member where name like ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
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
	
	public ArrayList<MemberBean> getMember(String search,int start,int end) {
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		try {
			String sql = "select no,name,gender,age,phone,email,pw,rrn,anilike,stolike ";        
				sql += "from (select rownum as rank,no,name,gender,age,phone,email,pw,rrn,anilike,stolike ";
				sql += "from (select no,name,gender,age,phone,email,pw,rrn,anilike,stolike ";
				sql += "from member where no>0 order by no)) where ";
			if(search.equals("없음")) {
				sql += "rank between ? and ? "; 
				ps = conn.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, end);
			} else {
				sql += "name like ? and rank between ? and ? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "%"+search+"%");
				ps.setInt(2, start);
				ps.setInt(3, end);
			}
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(getMemberBean(rs));
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
	
	public MemberBean getMemberByEmail(String email, String pw) {
		MemberBean mb = null;
		try {
			String sql = "select * from member where email=? and pw=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			if(rs.next()) {
				mb = new MemberBean();
				mb = getMemberBean(rs);
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
		return mb;
	} //getMemberByEmail
	
	public int insertMember(MemberBean mb) {
		int cnt = -1;
		try {
			String sql = "insert into member(no,name,gender,age,phone,email,pw,rrn) "
					+ "values(member_seq.nextval,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setString(2, mb.getGender());
			ps.setString(3, mb.getAge());
			ps.setString(4, mb.getPhone());
			ps.setString(5, mb.getEmail());
			ps.setString(6, mb.getPw());
			ps.setString(7, mb.getRrn());
			
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
	
	public String findid(String name, String phone, String rrn) {
		String email = null;
		try {
			String sql = "select * from member where name=? and phone=? and rrn=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, phone);
			ps.setString(3, rrn);
			rs = ps.executeQuery();
			if(rs.next()) {
				email = rs.getString("email");
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
		return email;
	}
	
	public String findpw(String email, String name, String phone, String rrn) {
		String pw = null;
		try {
			String sql = "select * from member where email=? and name=? and phone=? and rrn=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, name);
			ps.setString(3, phone);
			ps.setString(4, rrn);
			rs = ps.executeQuery();
			if(rs.next()) {
				pw = rs.getString("pw");
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
		return pw;
	}
	
	public String getAni(String no, String anum) {
		String anilike = null;
		String sql = "select * from member where no=? and anilike like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			ps.setString(2, "% "+anum+" %");
			rs = ps.executeQuery();
			if(rs.next()) {
				anilike = rs.getString("anilike");
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
		return anilike;
	}
	
	public String getNameByNo(String no) {
		String name = null;
		try {
			String sql = "select name from member where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {				
				name = rs.getString("name");
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
		return name;
	}
	
	public String getAnilike(String no) {
		String anilike = null;
		try {
			String sql = "select anilike from member where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {
				if(rs.getString("anilike")==null) {
					anilike = " ";
				} else {					
					anilike = rs.getString("anilike");
				}
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
		return anilike;
	}
	
	public int updateAni(String no,String anum) {
		int cnt = -1;
		try {
			String anilike = getAnilike(no);
			String sql = "update member set anilike=? where no=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, anilike+anum+" ");
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
	
	public String[] splitAni(String anilike) {
		String[] words = anilike.trim().split(" ");
		for(int i=0; i<words.length; i++) {	        	
        	System.out.println("words : " + words[i]);
        }
		return words;
	}
	
	public int deleteAni(String no, String anilike, String anum) {
	    int cnt = -1;
	    System.out.println(no+","+anilike+","+anum);
	    try {
	        String[] words = splitAni(anilike);
	        String newAnilike = " ";
	        for(String word : words) {
	        	if(!word.equals(anum)) {       			
	        		newAnilike += word+" ";
	        		System.out.println("newAnilike : " + newAnilike);
	        	}
	        }
	        String sql = "update member set anilike=? where no=?";
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, newAnilike);
	        ps.setString(2, no);
	        cnt = ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null)
	                ps.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return cnt;
	}

	
	public MemberBean getMemberBean(ResultSet rs) throws SQLException {
		MemberBean mb = new MemberBean();
		mb.setNo(rs.getInt("no"));
		mb.setName(rs.getString("name"));
		mb.setGender(rs.getString("gender"));
		mb.setAge(rs.getString("age"));
		mb.setPhone(rs.getString("phone"));
		mb.setEmail(rs.getString("email"));
		mb.setPw(rs.getString("pw"));
		mb.setRrn(rs.getString("rrn"));
		return mb;
	}
}
