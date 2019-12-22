<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.acorn.dto.CrawlingDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.acorn.dao.CrawlingDao"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page pageEncoding="utf-8"%>
<%@include file="../inc/header.jsp"%>

<%
SimpleDateFormat sdf = new SimpleDateFormat ("yyyy");
Calendar time = Calendar.getInstance();
int year = Integer.parseInt(sdf.format(time.getTime()));

int y1 = 0;
int m1 = 0; 
int d1 = 0;
int y2 = 0;
int m2 = 0;
int d2 = 0;

int dsy = year-1;
int dey = year;
int dm = 1;
int dd = 1;

if(request.getParameter("sy") != null){
	y1 = Integer.parseInt(request.getParameter("sy"));
}
if(request.getParameter("sm") != null){
	m1 = Integer.parseInt(request.getParameter("sm"));
}
if(request.getParameter("sd") != null){
	d1 = Integer.parseInt(request.getParameter("sd"));
}
if(request.getParameter("ey") != null){
	y2 = Integer.parseInt(request.getParameter("ey"));
}
if(request.getParameter("em") != null){
	m2 = Integer.parseInt(request.getParameter("em"));
}
if(request.getParameter("ed") != null){
	d2 = Integer.parseInt(request.getParameter("ed"));
}

int startdate = y1*10000+m1*100+d1; 
int enddate = y2*10000+m2*100+d2; 
if(startdate ==0 && enddate ==0){
	startdate = dsy*10000+dm*100+dd;
	enddate = year*10000+dm*100+dd;
}

CrawlingDao dao = CrawlingDao.getInstance();
ArrayList<CrawlingDto> list = dao.crawl(startdate, enddate); 



%>
<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">가상화폐</li>
	</ol>
</nav>
<!-- breadcrumb end-->

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h4>거래기록</h4>
			<br>
			<form name="f" method="post" action="list.jsp">
			
				<div class="form-group row">
					<label for="no" class="col-sm-3 col-form-label">코인선택</label>
					<div class="form-group col-sm-9">
						<select id="coin" name="coin" class="form-control">
							<option selected>Coin...</option>
							<option value="bitcoin"  selected>비트코인</option>
							<option value="ethereum" >이더리움</option>
							<option value="xrp" >리플</option>
							<option value="tether" >테더</option>
							<option value="bitcoin-cash" >비트코인캐쉬</option>
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label for="no" class="col-sm-3 col-form-label">시작날짜</label>

					<div class="form-group col-sm-3">
						<select id="startYear" name="startYear" class="form-control">
							<option selected>year..</option>
							<%for(int sy=year-4;sy<=year;sy++){ %>
							<option value="<%=sy %>" selected><%=sy %></option>
							<%} %>
						</select>

					</div>
					<div class="form-group col-sm-3">
						<select id="startMonth" name="startMonth" class="form-control">
							<option selected>month..</option>
							<%for(int sm=1 ; sm<=12 ; sm++){ %>
							<option value="<%=sm %>" selected><%=sm %></option>
							<%} %>
						</select>
					</div>

					<div class="form-group col-sm-3">
						<select id="startDay" name="startDay" class="form-control">
							<option selected>day..</option>
							<%for(int sd=1;sd<=31;sd++){ %>
							<option value="<%=sd %>" selected><%=sd %></option>
							<%} %>
						</select>
					</div>

				</div>

				<div class="form-group row">
					<label for="endYear" class="col-sm-3 col-form-label">끝날짜</label>

					<div class="form-group col-sm-3">
						<select id="endYear" name="endYear" class="form-control">
							<option selected>year..</option>
							<%for(int ey=year-4;ey<=year;ey++){ %>
							<option value="<%=ey %>" selected><%=ey %></option>
							<%} %>
						</select>
					</div>

					<div class="form-group col-sm-3">
						<select id="endMonth" name="endMonth" class="form-control">
							<option selected>Month...</option>
							<%for(int em=1;em<=12;em++){ %>
							<option value="<%=em %>" selected><%=em %></option>
							<%} %>
						</select>
					</div>

					<div class="form-group col-sm-3">
						<select id="endDay" name="endDay" class="form-control">
							<option selected>Day...</option>
							<%for(int ed=1;ed<=31;ed++){ %>
							<option value="<%=ed %>" selected><%=ed %></option>
							<%} %>
						</select>
					</div>

				</div>
			</form>

			<div class="text-right">
				<button type="button" id="searchCoin"
					class="btn btn-outline-success">검색</button>
			</div>
			<br>
			<div class="table-responsive-lg">
				<table class="table table-hover">
					<colgroup>
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="14%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">Date</th>
							<th scope="col">Open</th>
							<th scope="col">High</th>
							<th scope="col">Low</th>
							<th scope="col">Close</th>
							<th scope="col">Volume</th>
							<th scope="col">Market Cap</th>
						</tr>
					</thead>
					<tbody>
					<%if(list.size() != 0){ %>
					<%for(CrawlingDto dto : list){ %>
						<tr>
							<td><%=dto.getDate() %></td>
							<td><%=dto.getOpen() %></td>
							<td><%=dto.getHigh() %></td>
							<td><%=dto.getLow() %></td>
							<td><%=dto.getClose() %></td>
							<td><%=dto.getVolume() %></td>
							<td><%=dto.getMarketcap() %></td>
						</tr>
					<%} %>
					<%}else{ %>
					<tr>
						<td colspan="7">데이터가 존재하지 않습니다.</td>
					</tr>
					<%} %>
					</tbody>
				</table>
			</div>

		</div>
	</div>
</div>
<%@include file="../inc/footer.jsp"%>