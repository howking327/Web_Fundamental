<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<%
	if(memberDto == null){
		response.sendRedirect("list.jsp?page=1");
		return;
	}
	
	String tempPage = request.getParameter("page");
	String email = request.getParameter("email");
	
	
	if(tempPage == null || tempPage.length()==0){
		tempPage = "1";
	}
	if(email == null || email.length()==0){
		response.sendRedirect("list.jsp?page="+tempPage);
		return;
	}
	
	
	
	
	int cPage = 0;
	
	try{
		cPage = Integer.parseInt(tempPage);
	}catch(NumberFormatException e){
		cPage = 1;
	}
	
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.select(email);
	if(dto == null){
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	String name = dto.getName();
	String password = dto.getPassword();
	String phone = dto.getPhone();
	String regdate = dto.getRegdate();
	
%>

<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">회원관리</li>
	</ol>
</nav>
<!-- breadcrumb end-->


<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>
			회원 상세보기
			</h3>
			<form name="f" method="post">
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-10">
						<input type="text" class="form-control"
							id="name" name="name" value="<%=name%>">
						<div id="nameMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10">
						<input type="email" class="form-control"
							id="email" name="email" value="<%=email%>" readonly="readonly">
						<div id="emailMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="prepassword" class="col-sm-2 col-form-label">이전 비밀번호</label>
					<div class="col-sm-10">
						<input type="password" class="form-control"
							id="prepassword" name="prepassword" value="">
						<div id="prepasswordMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" class="form-control"
							id="password" name="password" value="">
						<div id="passwordMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="repassword" class="col-sm-2 col-form-label">비밀번호 확인</label>
					<div class="col-sm-10">
						<input type="password" class="form-control"
							id="repassword" name="repassword" value="">
						<div id="repasswordMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="phone" class="col-sm-2 col-form-label">휴대폰 번호</label>
					<div class="col-sm-10">
						<input type="tell" class="form-control"
							id="phone" name="phone" value="<%=phone%>">
						<div id="phoneMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="regdate" class="col-sm-2 col-form-label">가입 일자</label>
					<div class="col-sm-10">
						<input type="text" class="form-control"
							id="regdate" name="regdate" readonly="readonly" value="<%=regdate%>">
					</div>
				</div>
				
			</form>
			<div class='text-right'>
				<button type="button" id="prevPage" class="btn btn-secondary btn-sm">이전</button>
			<%if(email.equals(memberDto.getEmail())){ %>	
				<button type="button" id="updateMember" class="btn btn-primary btn-sm">수정</button>
				<button type="button" id="deleteMember" class="btn btn-danger btn-sm">삭제</button>
			<%} %>
			</div>
			

		</div>
	</div>
</div>
<!-- main end -->

<%@ include file="../inc/footer.jsp"%>

<script>
$(function(){
	$("#name").focus();
	$("#prevPage").click(function(){
		history.back(-1);
	});
	$("#updateMember").click(function(){
		//자바스크립트 유효성 검사
		if($("#name").val().length==0){
			$('#name').addClass("is-invalid");
			$('#nameMessage').html("<span class='text-danger'>이름을 입력하세요</span>");
			$("#name").focus();
			return;
		}
		
		if($("#prepassword").val().length==0){
			$('#prepassword').addClass("is-invalid");
			$('#prepasswordMessage').html("<span class='text-danger'>비밀번호를 입력하세요</span>");
			$("#prepassword").focus();
			return;
		}
		if($("#password").val().length!=0 || $("#repassword").val().length!=0){
			if($("#password").val().length==0){
				$('#password').addClass("is-invalid");
				$('#passwordMessage').html("<span class='text-danger'>비밀번호를 입력하세요</span>");
				$("#password").focus();
				return;
			}
			if($("#repassword").val().length==0){
				$('#repassword').addClass("is-invalid");
				$('#repasswordMessage').html("<span class='text-danger'>비밀번호 확인을 입력하세요</span>");
				$("#repassword").focus();
				return;
			}
			if($("#password").val() != $("#repassword").val()){
				$('#repassword').addClass("is-invalid");
				$('#repasswordMessage').html("<span class='text-danger'>비밀번호가 일치하지 않습니다.</span>");
				$("#repassword").val("");
				$("#repassword").focus();
				return;
			}
		}
		if($("#phone").val().length==0){
			$('#phone').addClass("is-invalid");
			$('#phoneMessage').html("<span class='text-danger'>휴대폰 번호를 입력하세요</span>");
			$("#phone").focus();
			return;
		}
		
		f.action ="update.jsp?page=<%=cPage%>&email=<%=email%>";
		
		
		if($("#checkPwd").val() == "no") {
			return;
		}
		
		f.submit();
	});
	
	$("#name").keyup(function(){
		$("#name").removeClass("is-invalid");
		$("#nameMessage").html('');
	});
	
	$("#prepassword").keyup(function(){
		$("#prepassword").removeClass("is-invalid");
		$("#prepasswordMessage").html('');
		
		$.ajax({
			type : "POST",
			url  : 'check_pwd_ajax.jsp',
			data : {"email":"<%=email%>", "password":$("#prepassword").val()},
			dataType : 'json',
			error : function(){
			},
			success : function(json){
				if(json.result == 'ok'){
					$("#prepasswordMessage").html("<span class='text-success'>비밀번호 확인</span>");
					$("#checkPwd").val("yes");
				}else{
					$("#prepassword").addClass("is-invalid");
					$("#prepasswordMessage").html("<span class='text-danger'>비밀번호가 일치하지 않습니다.</span>");
					$("#checkPwd").val("no");
				}
			}
		});
	});
	$("#password").keyup(function(){
		$("#password").removeClass("is-invalid");
		$("#passwordMessage").html('');
	});
	$("#repassword").keyup(function(){
		$("#repassword").removeClass("is-invalid");
		$("#repasswordMessage").html('');
	});
	$("#phone").keyup(function(){
		$("#phone").removeClass("is-invalid");
		$("#phoneMessage").html('');
	});
	
	
	$("#deleteMember").click(function(){
		f.action="delete.jsp";
		f.submit();
	});
});
</script>