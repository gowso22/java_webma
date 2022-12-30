<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />

<%@ include file="dbconn.jsp"%>

<%String sessionId = (String) session.getAttribute("sessionId"); %>

<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	
			
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><%=sessionId%>의 장바구니</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
		
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp" class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a   href="./shippingInfo.jsp" class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%	
				PreparedStatement pstmt = null;
				ResultSet rs = null;
			
				String sql = "select p.p_id, p.p_name, p.p_unitPrice, count(c.p_id) from cart as c join product as p on c.p_id = p.p_id where c.id = ? group by c.p_id; ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, sessionId);
				
				rs = pstmt.executeQuery();
				int total = 0;
				int sum = 0;
				while(rs.next()) 
				{
					total = rs.getInt("p.p_unitPrice") * rs.getInt("count(c.p_id)");
					sum = sum + total;
					
					
				%>
				<tr>
					<td><%=rs.getString("p.p_id")%> - <%=rs.getString("p.p_name")%></td>
					<td><%=rs.getInt("p.p_unitprice")%></td>
					<td>
					<%=rs.getInt("count(c.p_id)")%>
					</td>
					<td>
						<%= total %>
					</td>
					<td><a href="./processRemoveCart.jsp?id=<%=rs.getString("p.p_id")%>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%= sum %></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
			
			
				
		</div>
		
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
