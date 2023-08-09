<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.chunjae.db.*"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="/encoding.jsp"%>
<%

    int qno = Integer.parseInt(request.getParameter("qno"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    DBC con = new MariaDBCon();

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = con.connect();
        String sql = "update qna set title=?, content=? where qno=? and lev=0";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setInt(3, qno);
        int cnt = pstmt.executeUpdate();
        if(cnt > 0) {
            System.out.println("질문 수정 완료");
            response.sendRedirect("qnaList.jsp");
        } else {
            System.out.println("질문 수정 실패");
            response.sendRedirect("updateQuestion.jsp");
        }
    } catch (SQLException e) {
        System.out.println("질문 수정: sql 에러");
    } finally {
        con.close(pstmt, conn);
    }

%>