<%@page import="java.io.File"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String anum = request.getParameter("anum");
	String img = request.getParameter("img");
	
	String configFolder = config.getServletContext().getRealPath("/images");
	File file = new File(configFolder,img);
	if(file.exists()) {
	    if(file.delete()){
	    	System.out.println("파일 삭제 성공");
	    }
	}

	String str;
	AnimalDao adao = AnimalDao.getInstance(); 
	int cnt = adao.deleteAnimal(anum); 
	if(cnt>0){
		str = "동물 삭제 성공"; 
	} else{
		str = "동물 삭제 실패";
	}
%>
    <script>
		alert('<%=str%>');
		location.href = "animalList.jsp";
	</script>