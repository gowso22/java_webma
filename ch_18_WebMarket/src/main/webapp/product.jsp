<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>상품 상세 정보</title>
<script type="text/javascript">
	function addToCart() {
		if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
		} else {		
			document.addForm.reset();
		}
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
		<%@ include file="dbconn.jsp"%>
	<%
		String sessionId = (String) session.getAttribute("sessionId");
		String productId = request.getParameter("id");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		if (rs.next()) {
	%>
	
	<%-- select구문 쓰기 위해 따로 빼 놓았음 <%
		String id = request.getParameter("id");
		ProductRepository dao = ProductRepository.getInstance();
		Product product = dao.getProductById(id);
	%> --%>
	<form name="addForm" action="./processAddCart.jsp?p_id=<%=rs.getString("p_id")%>" method="post">
	<div class="container">
		<div class="row">
		
			<div class="col-md-5">
				<img src="./resources/images/<%=rs.getString("p_filename")%>" style="width: 100%" /> 
			</div>
			<div class="col-md-6">
				<h3><%=rs.getString("p_name")%></h3>
				<p><%=rs.getString("p_description")%>
				<p><b>상품 코드 : </b><span class="badge badge-danger"><%=rs.getString("p_id")%></span>
				<p><b>제조사</b> : <%=rs.getString("p_manufacturer")%>
				<p><b>분류</b> : <%=rs.getString("p_category")%>
			 	<p><b>재고 수</b> : <%=rs.getLong("p_unitsInStock")%>
				<h4><%=rs.getString("p_unitprice")%>원</h4>
				<c:choose>
					<c:when test="${empty sessionId}">
						
					</c:when>
					<c:otherwise>
						<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 주문 &raquo;</a>
						<a href="./cart.jsp" class="btn btn-warning"><%=sessionId%>의 장바구니 &raquo;</a> 
					</c:otherwise>
				</c:choose>
					
					<a href="./products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>			
			</div>
			<%
		}
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	%>
		</div>
		<hr>
	</div>
	
	</form>
	<jsp:include page="footer.jsp" />
</body>
</html>
