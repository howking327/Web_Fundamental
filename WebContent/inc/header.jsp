<%@page import="kr.co.acorn.dao.DeptDao"%>
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@ page pageEncoding="utf-8"%>

<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <style>
   
  </style>
  <title>Hello, world!</title>
</head>

<body>
  <!-- navbar start -->
  <nav class="navbar navbar-expand-lg navbar-dark " style="background-color: #563d7c;">
    <a class="navbar-brand" href="/index.jsp">(주)에이콘</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02"
      aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
	<%
		String uri = request.getRequestURI();
	%>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
        <li class="nav-item <%if(uri.startsWith("/notice")){%>active<%}%>">
          <a class="nav-link" href="/notice/list.jsp">공지사항 <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item <%if(uri.startsWith("/dept")){%>active<%}%>">
          <a class="nav-link" href="/dept/list.jsp">부서관리</a>
        </li>
        <li class="nav-item <%if(uri.startsWith("/emp")){%>active<%}%>">
          <a class="nav-link" href="/emp/list.jsp">사원관리</a>
        </li>
        <li class="nav-item <%if(uri.startsWith("/member")){%>active<%}%>">
          <a class="nav-link" href="/member/list.jsp">회원관리</a>
        </li>
        <li class="nav-item <%if(uri.startsWith("/crawling")){%>active<%}%>">
          <a class="nav-link" href="/file/index.jsp">파일업로드</a>
        </li>
        <li class="nav-item <%if(uri.startsWith("/crawling")){%>active<%}%>">
          <a class="nav-link" href="/crawling/list.jsp">가상화폐</a>
        </li>
      </ul>
      <ul class='navbar-nav'>
      <% 
      	MemberDto memberDto = (MemberDto)session.getAttribute("member");
      	if(memberDto == null){ 
      %>
      	<li class='nav-item'><a class='nav-link' href='/member/write.jsp'>회원가입</a></li>
      	<li class='nav-item'><a class='nav-link' href='/member/login.jsp'>로그인</a></li>
      <%}else{ %>
      	<li class='nav-item'><a class='nav-link' href='#'><%=memberDto.getName() %>님 환영합니다</a></li>
      	<li class='nav-item'><a class='nav-link' href='/member/logout.jsp'>로그아웃</a></li>
      <%} %>
      </ul>
     
      <form class="form-inline my-2 my-lg-0" name="searchForm" method="post">
			<input class="form-control mr-sm-2" type="search" id="keyWord" name="keyWord" placeholder="부서 검색 "  aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit" id="btnSearch">Search</button>
	  </form>
      
    </div>
  </nav>
  <!-- navbar end -->
