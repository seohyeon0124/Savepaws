<%@page import="my.free.FreeDao"%>
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
	
	System.out.println("name : " + mr.getParameter("name"));
	System.out.println("lat : " + mr.getParameter("lat"));
	System.out.println("lng : " + mr.getParameter("lng"));
	
	FreeDao fdao = FreeDao.getInstance();
	int cnt = fdao.insertFree(mr); 
	String str;
	if(cnt>0){
		str = "상품 등록 성공";
	} else{
		str = "상품 등록 실패";
	}
%>
    <script>
    	alert("<%=str%>");
    	location.href = "free_place.jsp";
    </script>
    