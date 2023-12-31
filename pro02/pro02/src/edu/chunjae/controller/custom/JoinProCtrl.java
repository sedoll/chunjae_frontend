package edu.chunjae.controller.custom;

import edu.chunjae.model.CustomDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/JoinPro.do")
public class JoinProCtrl extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String tel = request.getParameter("tel");
        String email = request.getParameter("email");
        String birth = request.getParameter("birth");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String postcode = request.getParameter("postcode");
        String msg = "회원가입 페이지";

        CustomDAO dao = new CustomDAO();
        System.out.printf("%s %s %s %s %s %s %s ", id, pw, name, tel, email, birth, (address1 + "<br>" + address2));
        boolean pass = dao.join(id, pw, name, tel, email, birth, (address1 + "<br>" + address2));
        System.out.println(pass);

        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        RequestDispatcher view = null;

        if(pass) {
            msg = "회원가입 성공";
//            session.setAttribute("sid", id);
//            request.setAttribute("msg", msg);
            response.sendRedirect("/pro02");
//            response.setContentType("text/html;charset=UTF-8");
//            response.setCharacterEncoding("UTF-8");
//            view = request.getRequestDispatcher("/pro02");
//            view.forward(request, response);
        } else {
            msg = "회원가입 실패";
            response.sendRedirect("/pro02");
        }
    }
}
