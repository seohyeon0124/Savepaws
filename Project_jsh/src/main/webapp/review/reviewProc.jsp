<%@page import="my.review.ReviewDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	//C:\JSP_jsh\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Project_jsh\images
	String uploadDir = config.getServletContext().getRealPath("/images"); // 미리 만들어 놓기
	System.out.println(uploadDir);
	
	// MultipartRequest 객체 생성
	MultipartRequest mr = new MultipartRequest(
			request,
			uploadDir, 
			1024*1024*10,
			"UTF-8",
			new DefaultFileRenamePolicy()
	);
	
	ReviewDao rdao = ReviewDao.getInstance();
	int cnt = rdao.insertReview(mr);
	String str;
	if(cnt>0){
		str = "리뷰 등록 성공";
	} else{
		str = "리뷰 등록 실패";
	}
%>
    <script>
    	alert("<%=str%>");
    	location.href = "review.jsp";
    </script>