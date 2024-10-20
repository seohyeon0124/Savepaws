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

import com.oreilly.servlet.MultipartRequest;

import my.member.MemberDao;

public class AnimalDao {
	private static AnimalDao instance;
	public static AnimalDao getInstance() {
		if(instance==null) {
			instance = new AnimalDao();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	private AnimalDao() {
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
	} //AnimalDao
	
	public int insertAnimal(MultipartRequest mr) {
		int cnt = -1;
		try {
			String content = "";
			if(mr.getParameter("content")==null) {
				content = "소개 글을 입력하세요";
			}else {
				content = mr.getParameter("content");
			}
			String sql = "insert into animal "
					+ "values(animal_seq.nextval,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("cate"));
			ps.setString(2, mr.getParameter("kind"));
			ps.setString(3, mr.getParameter("age"));
			ps.setString(4, mr.getOriginalFileName("img"));
			String color = "";
			String[] checkbox = mr.getParameterValues("color");
			if (checkbox != null) {
			    for (String value : checkbox) {
			        color += value + " ";
			    }
			}
			ps.setString(5, color);
			ps.setString(6, mr.getParameter("state"));
			ps.setString(7, mr.getParameter("place"));
			ps.setString(8, mr.getParameter("day"));
			ps.setString(9, content);
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
	
	// 카테고리+상태+검색어
	public ArrayList<AnimalBean> getAnimal(String cate,String state,String search,int start,int end){
		
		System.out.println("cate3 : " + cate);
		System.out.println("state3 : " + state);
		System.out.println("search3 : " + search);
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		ArrayList<AnimalBean> list = new ArrayList<AnimalBean>();
		boolean cateflag = cate.equals("전체");
		boolean stateflag = state.equals("상태");
		boolean searchflag = search.equals("없음");
		
		try {
			String sql = "select anum,cate,kind,age,img,color,state,place,day,content " ;		        
					sql += "from (select rownum as rank, anum,cate,kind,age,img,color,state,place,day,content ";
					sql += "from (select anum,cate,kind,age,img,color,state,place,day,content ";
					sql += "from animal ";
			if(cateflag) {
				if(stateflag) {
					if(searchflag) {
						sql += "order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setInt(1, start);
						ps.setInt(2, end);
					}else {
						sql += "where kind like ? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "%"+search+"%");
						ps.setInt(2, start);
						ps.setInt(3, end);
					}
				}else {
					if(searchflag) {
						sql += "where state=? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, state);
						ps.setInt(2, start);
						ps.setInt(3, end);
					}else {
						sql += "where state=? and kind like ? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, state);
						ps.setString(2, "%"+search+"%");
						ps.setInt(3, start);
						ps.setInt(4, end);
					}
				}
			}else {
				if(stateflag) {
					if(searchflag) {
						sql += "where cate=? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setInt(2, start);
						ps.setInt(3, end);
					}else {
						sql += "where cate=? and kind like ? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setString(2, "%"+search+"%");
						ps.setInt(3, start);
						ps.setInt(4, end);
					}
				}else {
					if(searchflag) {
						sql += "where cate=? and state=? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setString(2, state);
						ps.setInt(3, start);
						ps.setInt(4, end);
					}else {
						sql += "where cate=? and state=? and kind like ? order by anum desc)) where rank between ? and ? ";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setString(2, state);
						ps.setString(3, "%"+search+"%");
						ps.setInt(4, start);
						ps.setInt(5, end);
					}
				}
			}
				rs = ps.executeQuery();
				while(rs.next()) {
					list.add(getAnimalBean(rs));
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
	
	public AnimalBean getAnimalByAnum(String anum) {
		AnimalBean ab = new AnimalBean();
		try {
			String sql = "select * from animal where anum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, anum);
			rs = ps.executeQuery();
			if(rs.next()) {
				ab = getAnimalBean(rs);
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
		return ab;
	}
	
	public int deleteAnimal(String anum) {
		int cnt = -1;
		try {
			String sql = "delete from animal where anum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, anum);
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
	
	public int updateAnimal(MultipartRequest mr) {
		int cnt = -1;
		try {
			String sql = "update animal set cate=?,kind=?,age=?,img=?,color=?,state=?,place=?,day=?,content=? where anum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("cate"));
			ps.setString(2, mr.getParameter("kind"));
			ps.setString(3, mr.getParameter("age"));
			if(mr.getOriginalFileName("img")!=null) {
				ps.setString(4, mr.getOriginalFileName("img"));
			} else {
				ps.setString(4, mr.getParameter("orimg"));
			}
			String color = "";
			String[] checkbox = mr.getParameterValues("color");
			if (checkbox != null) {
			    for (String value : checkbox) {
			        color += value + " ";
			    }
			}
			ps.setString(5, color);
			ps.setString(6, mr.getParameter("state"));
			ps.setString(7, mr.getParameter("place"));
			ps.setString(8, mr.getParameter("day"));
			ps.setString(9, mr.getParameter("content"));
			ps.setString(10, mr.getParameter("anum"));
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
	
	public ArrayList<AnimalBean> getAllAnimalByMemno(String no){
		ArrayList<AnimalBean> list = new ArrayList<AnimalBean>();
		try {
			MemberDao mdao = MemberDao.getInstance();
			String anilike = mdao.getAnilike(no);
			String[] words = mdao.splitAni(anilike);
			for(String word : words) {
				String sql = "select * from animal where anum=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, word);
				rs = ps.executeQuery();
				if(rs.next()) {
					list.add(getAnimalBean(rs));
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
		return list;
	}
	
	public int getAnimalCount() {
		int count = 0;
		try {
			String sql = "select count(*) from animal";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = Integer.parseInt(rs.getString("count(*)"));
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
	
	public int getAnimalCountByCate(String cate,String state,String search) {
		int count = 0;
		try {
			String sql = "select count(*) from animal ";
			if(cate.equals("전체")) {
				if(state.equals("상태")) {
					if(search.equals("없음")) {
						sql += "order by anum desc";
						ps = conn.prepareStatement(sql);
					}else {
						sql += "where kind like ? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "%"+search+"%");
					}
				}else {
					if(search.equals("없음")) {
						sql += "where state=? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, state);
					}else {
						sql += "where state=? and kind like ? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, state);
						ps.setString(2, "%"+search+"%");
					}
				}
			}else {
				if(state.equals("상태")) {
					if(search.equals("없음")) {
						sql += "where cate=? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
					}else {
						sql += "where cate=? and kind like ? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setString(2, "%"+search+"%");
					}
				}else {
					if(search.equals("없음")) {
						sql += "where cate=? and state=? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setString(2, state);
					}else {
						sql += "where cate=? and state=? and kind like ? order by anum desc";
						ps = conn.prepareStatement(sql);
						ps.setString(1, cate);
						ps.setString(2, state);
						ps.setString(3, "%"+search+"%");
					}
				}
			}			
			rs = ps.executeQuery();
			if(rs.next()) {
				count = Integer.parseInt(rs.getString("count(*)"));
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
	
	public AnimalBean getAnimalBean(ResultSet rs) throws SQLException {
		AnimalBean ab = new AnimalBean();
		ab.setAnum(rs.getInt("anum"));
		ab.setCate(rs.getString("cate"));
		ab.setKind(rs.getString("kind"));
		ab.setAge(rs.getInt("age"));
		ab.setImg(rs.getString("img"));
		ab.setColor(rs.getString("color"));
		ab.setState(rs.getString("state"));
		ab.setPlace(rs.getString("place"));
		ab.setDay(rs.getString("day"));
		ab.setContent(rs.getString("content"));
		return ab;
	}
}

