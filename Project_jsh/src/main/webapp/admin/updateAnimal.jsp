<%@page import="my.animal.AnicateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnicateDao"%>
<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
	.table{
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	.table th, td {
		text-align: center;
	}
</style>

<% 
	String anum = request.getParameter("anum");
	AnimalDao adao = AnimalDao.getInstance();
	AnimalBean ab = adao.getAnimalByAnum(anum);
%>

<form method="post" action="updateAnimalProc.jsp?anum=<%=anum%>&orimg=<%=ab.getImg()%>" enctype="multipart/form-data">
<table class="table table-bordered">
    <tr>
    	<th class="table-dark align-middle" width=15%>번호</th>
    	<td class="align-middle" width=35%>
    		<input value="<%=ab.getAnum()%>" name="anum" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" disabled>
    	</td>
    	<th class="table-dark align-middle" width=15%>카테고리</th>
    	<td class="align-middle" width=35%>
			<div class="input-group mb-2">
			  <select name="cate" class="form-select custom-width" id="inputGroupSelect01">
			<%
				AnicateDao catedao = AnicateDao.getInstance();
				ArrayList<AnicateBean> cate = catedao.getAllAnicate(); 
				for(AnicateBean cateb : cate){
			%>
				<option value="<%=cateb.getCatecode()%>" <%if(cateb.getCatecode().equals(ab.getCate())){%>selected<%}%>><%=cateb.getCatename()%>[<%=cateb.getCatecode()%>]</option>
			<%
				}
			%>
	  </select>
	</div>
		</td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">종류</th>
    	<td>
    		<input value="<%=ab.getKind()%>" name="kind" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    	<th class="table-dark align-middle">나이</th>
    	<td>
    		<input value="<%=ab.getAge()%>" name="age" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">색상</th>
    	<td>
    		<div style="width:120px;">
    		<%
    			if(ab.getColor()==null){
    				ab.setColor("등록X");
    			}
    			String[] color = {"white","gray","black","brown","etc."};
    			for(int i=0; i<color.length; i++){
    		%>
    			<div class="form-check">
					&nbsp;&nbsp;<input value="<%=color[i]%>" class="form-check-input" type="checkbox" name="color" id="flexRadioDefault1" <%if(ab.getColor().contains(color[i])){%>checked<%}%>> <%=color[i]%>
				</div>
    		<%
    			}
    		%>
			</div>
    	</td>
    	<th class="table-dark align-middle">상태</th>
    	<td>
    		<div style="width:120px;">
    		<%
    			String[] state = {"구조","임시보호","입양","안락사","자연사"};
    			for(int i=0; i<state.length; i++){
    		%>
    			<div class="form-check">
					<input value="<%=state[i]%>" class="form-check-input" type="radio" name="state" id="flexRadioDefault1" <%if(ab.getState().contains(state[i])){%>checked<%}%>> <%=state[i]%>
				</div>
    		<%
    			}
    		%>
			</div>
    	</td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">이미지</th>
    	<td colspan=3>
    		<img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" width=200>
    		<input name="img" type="file" class="form-control" id="inputGroupFile01">
    	</td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">발견장소</th>
    	<td>
    		<input value="<%=ab.getPlace()%>" name="place" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    	<th class="table-dark align-middle" >구조일</th>
    	<td class="align-middle">
    		<input value="<%=ab.getDay()%>" type="date" name="day" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td>
    </tr>
    <tr>
    	<th class="table-dark align-middle">한줄소개</th>
    	<td colspan=3>
    		<input value="<%=ab.getContent()%>" name="content" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
    	</td> 
    </tr>
</table>
<button type="submit" class="btn btn-outline-dark">완료</button>
</form>

    
<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>