<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <%@ include file="../head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 플러그인 연결-->
    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <!-- datatables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css">
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>

    <!-- 스타일 초기화 -->
    <link rel="stylesheet" href="../css/reset.css">
    <!-- 웹 폰트 -->
    <link rel="stylesheet" href="../css/font.css">

    <!-- css 모듈화 -->
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/hd.css">
    <link rel="stylesheet" href="../css/ft.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height: 100vh; background-image: url("../img/login.jpg");
            background-repeat: no-repeat; background-position: center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 100vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center; padding-top:0.7em; color:#fff;
            padding-bottom: 1.3em; }

        .breadcrumb { clear:both;
            width:1200px; margin: 0 auto; text-align: right; color:#fff;
            padding-top: 28px; padding-bottom: 28px; }
        .breadcrumb a { color:#fff; }

        .tb1 { width:600px; margin:0 auto; font-size: 24px;}
        .tb1 th {line-height: 32px; padding-top:16px; padding-bottom:16px;
            border-bottom: 1px solid #333; border-top: 1px solid #333; box-sizing: border-box; text-align: center;}
        .tb1 td {line-height: 32px; padding-top:16px; padding-bottom:16px;
            border-bottom: 1px solid #333; border-top: 1px solid #333; box-sizing: border-box; text-align: center;}

        .tb1 .item1 { width: 5%;}
        .tb1 .item1 {width: 65%;}
        .tb1 .item1 {width: 10%;}
        .tb1 .item1 {width: 20%;}

        .inbtn { display:block;  border-radius:100px;
            min-width:140px; padding-left: 24px; padding-right: 24px; text-align: center;
            line-height: 48px; background-color: #333; color:#fff; font-size: 18px; }
        .inbtn:first-child { float:right; }
    </style>
</head>

<%
    request.setCharacterEncoding("utf8");
    response.setContentType("text/html;charset=UTF-8");
    response.setCharacterEncoding("utf8");

    List<Board> boardList = new ArrayList<>();

    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();
    if(conn != null){
        System.out.println("DB 연결 성공");
    }

    // 해당 회원의 정보를 db에서 가져옴
    try {
        String sql = "select * from board group by bno desc";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while(rs.next()){
            Board bd = new Board();
            bd.setBno(rs.getInt("bno"));
            bd.setTitle(rs.getString("title"));
            bd.setContent(rs.getString("content"));
            bd.setAuthor(rs.getString("author"));
            bd.setResdate(rs.getString("resdate"));
            bd.setCnt(rs.getInt("cnt"));
            boardList.add(bd);
        }
    } catch(SQLException e) {
        System.out.println("SQL 구문이 처리되지 못했습니다.");
    } finally {
        con.close(rs, pstmt, conn);
    }
%>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="">HOME</a> &gt; <span>공지사항</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">공지사항</h2>
                <table class="tb1" id="myTable">
                    <thead>
                        <tr>
                            <th class="item1">번호</th>
                            <th class="item2">제목</th>
                            <th class="item3">작성자</th>
                            <th class="item4">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
                        for(Board bd:boardList) {
                        Date d = ymd.parse(bd.getResdate());  //날짜데이터로 변경
                        String date = ymd.format(d);    //형식을 포함한 문자열로 변경
                    %>
                    <tr>
                        <td class="item1"><%=bd.getBno()%></td>
                        <td class="item2">
                        <% if(sid!=null) { %>
                        <a href="/board/getBoard.jsp?bno=<%=bd.getBno() %>"><%=bd.getTitle() %></a>
                        <% } else { %>
                        <span><%=bd.getTitle() %></span>
                        <% } %>
                        </td>
                        <td class="item3"><%=bd.getAuthor()%></td>
                        <td class="item4"><%=date %></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable({
                            order: [[0, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
                        });
                    } );
                </script>
                <div class="btn_group">
                    <% if (sid != null && sid.equals("admin")) { %>
                    <a href="/board/addBoard.jsp" class="inbtn"> 글 작성 </a>
                    <% } else {%>
                    <p>관리지만 공지사항의 글을 쓸 수 있습니다.</p>
                    <% } %>
                </div>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>