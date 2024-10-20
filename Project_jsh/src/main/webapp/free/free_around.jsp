<%@page import="com.google.gson.Gson"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.free.FreeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="free_top.jsp"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7adba8baafcd667f93cfc4b9e153872e&libraries=services"></script>
<%
	FreeDao fdao = FreeDao.getInstance();
	ArrayList<JSONObject> list = fdao.getLatLng();
	String json = new Gson().toJson(list); // list를 JSON 문자열로 변환  
%>

    <div class="container"><br>
        <div class="d-flex align-items-center justify-content-start">
            <h3>내주변 검색</h3>
            <div class="d-flex align-items-center"> 
                <div class="ms-3 d-flex" role="search">
                    <input style="width:300px;" class="form-control me-2" type="text" id="sample5_address" placeholder="주소 입력">
                    <input class="btn btn-outline-success" type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
                </div>
            </div>
        </div>
    </div><br><br>
	<div id="map" style="margin:auto; width:1000px;height:500px;"></div>


<div id="searchMap" style="width:300px;height:300px;margin-top:10px;display:none"></div> 
<script>
var positions = <%=json%>;
</script>
<script src="map.js"></script>

<br><br>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<%@ include file="../bottom.jsp"%>
