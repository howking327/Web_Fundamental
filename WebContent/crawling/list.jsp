<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<%
String url = "https://coinmarketcap.com/currencies/bitcoin/historical-data/?start=20171101&end=20191203";
Document doc = null;

try {
	doc = Jsoup.connect(url).get();
} catch (IOException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
Elements elements = doc.select(".cmc-table__table-wrapper-outer table tbody tr");
	
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
							<option value="bitcoin" selected>비트코인</option>
							<option value="ethereum">이더리움</option>
							<option value="xrp">리플</option>
							<option value="bitcoin-cash">비트코인캐쉬</option>
							<option value="litecoin">라이트코인</option>
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label for="no" class="col-sm-3 col-form-label">시작날짜</label>

					<div class="form-group col-sm-3">
						<select id="startYear" name="startYear" class="form-control">
							<option selected>Year...</option>
							<option value="2010">2010</option>
						</select>

					</div>
					<div class="form-group col-sm-3">
						<select id="startMonth" name="startMonth" class="form-control">
							<option selected>Month...</option>
							<option value="1">1</option>
						</select>
					</div>

					<div class="form-group col-sm-3">
						<select id="startDay" name="startDay" class="form-control">
							<option selected>Day...</option>
							<option value="1">1</option>
						</select>
					</div>

				</div>

				<div class="form-group row">
					<label for="endYear" class="col-sm-3 col-form-label">끝날짜</label>

					<div class="form-group col-sm-3">
						<select id="endYear" name="endYear" class="form-control">
							<option selected>Year...</option>
							<option value="2010">2010</option>
						</select>
					</div>

					<div class="form-group col-sm-3">
						<select id="endMonth" name="endMonth" class="form-control">
							<option selected>Month...</option>
							<option value="1">1</option>
						</select>
					</div>

					<div class="form-group col-sm-3">
						<select id="endDay" name="endDay" class="form-control">
							<option selected>Day...</option>
							<option value="1">1</option>
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
						<col width="10%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
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

						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>
</div>
<%@ include file="../inc/footer.jsp"%>