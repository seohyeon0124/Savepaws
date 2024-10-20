<%@page import="my.animal.AnicateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.animal.AnicateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
 	#table{
 		margin: 0 auto;
 	}
 	.font14{
 		font-size: 14px;
 	}
</style>
<script>
	function check(){
		if($('select[name=cate] option:selected').val()=="선택"){
			alert('카테고리를 선택하세요');
			$('select[name=cate]').focus();
			return false;
		}
		if($('input[name=kind]').val()==""){
			alert('종류를 입력하세요');
			$('input[name=kind]').focus();
			return false;
		}
		if($('input[name=age]').val()==""){ 
			alert('나이를 입력하세요');
			$('input[name=age]').focus();
			return false;
		}
		if($('input[name=place]').val()==""){
			alert('발견장소를 입력하세요');
			$('input[name=place]').focus();
			return false;
		}
		if($('input[name=day]').val()==""){
			alert('구조일을 입력하세요');
			$('input[name=day]').focus();
			return false;
		}
	}
	
	// 현재 날짜를 'yyyy-mm-dd' 형식의 문자열로 가져오기
	var today = new Date().toISOString().slice(0, 10);

	// input 요소 찾기
	var dateInput = document.getElementById('today');

	// 오늘 날짜를 value와 max 속성에 설정
	dateInput.value = today;
	dateInput.max = today;
</script>

<form method="post" action="animalProc.jsp" enctype="multipart/form-data">
<table id="table">
<tr>
  <td><br>
	<div class="input-group mb-2">
	  <label class="input-group-text" for="inputGroupSelect01">동물 카테고리</label>
	  <select name="cate" class="form-select custom-width" id="inputGroupSelect01">
	    <option value="선택" selected>선택</option>
	<%
		AnicateDao adao = AnicateDao.getInstance();
		ArrayList<AnicateBean> cate = adao.getAllAnicate(); 
		for(AnicateBean ab : cate){
	%>
		<option value="<%=ab.getCatecode()%>"><%=ab.getCatename()%>[<%=ab.getCatecode()%>]</option>
	<%
		}
	%>
	  </select>
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">종류</span>
	  <input name="kind" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">나이</span>
	  <input name="age" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">발견장소</span>
	  <input name="place" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">구조일</span>
	  <input type="date" name="day" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
      <label class="input-group-text" for="inputGroupFile01">이미지</label>
      <input name="img" type="file" class="form-control" id="inputGroupFile01">
    </div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">한줄소개</span>
	  <input name="content" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="form-check-group" style="display: flex;">
		색상&nbsp;&nbsp;
	<%
    	String[] color = {"white","gray","black","brown","etc."};
    	for(int i=0; i<color.length; i++){
    %>
    	<div class="form-check">
			<input value="<%=color[i]%>" class="form-check-input" type="checkbox" name="color" id="flexRadioDefault1"> 
			<label class="form-check-label" for="flexRadioDefault1"><%=color[i]%> </label>
		</div>
		&nbsp;&nbsp;
    <%
    	}
    %>
	</div>
  </td>
</tr>
<tr>
  <td class="font14">
	<div class="form-check-group" style="display: flex;">
  	  <font size=3>상태</font>&nbsp;&nbsp;&nbsp;
  	  <%
  		String[] state = {"구조","임시보호","입양","안락사","자연사"};
		for(int i=0; i<state.length; i++){
  	  %>
  	  	<div class="form-check">
			<input value="<%=state[i]%>" class="form-check-input" type="radio" name="state" id="flexRadioDefault1" <%if(i==0){%>checked<%}%>> 
			<label class="form-check-label" for="flexRadioDefault1"><%=state[i]%> </label>
		</div>
		&nbsp;&nbsp;
  	  <%
		}
  	  %>
	</div>
  </td>
</tr>

<tr>
  <td align=center>
    <br>
  	<button type="submit" class="btn btn-outline-dark" onclick="return check()">&nbsp;&nbsp;등록하기&nbsp;&nbsp;</button>
  </td>
</tr>
</table>
</form>


<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>
    
    