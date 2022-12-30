<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");	

PreparedStatement pstmt = null;	

String sql = "delete from cart where id = ?";
pstmt = conn.prepareStatement(sql);

pstmt.setString(1, sessionId);

pstmt.executeUpdate();

if (pstmt != null)
	pstmt.close();
if (conn != null)
	conn.close();

	response.sendRedirect("cart.jsp");
%>
