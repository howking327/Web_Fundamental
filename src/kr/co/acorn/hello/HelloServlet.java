package kr.co.acorn.hello;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
/*
 1.Servlet Annotation => @WebServlet("/hello")
 2.Servlet Annotation 으로 지정된 이름으로 서블릿을 호출할 수 있다.
 3.만약 Servlet Annotation 을 사용하지 않고 서블릿을 호출하려면 web.xml파일(DD파일)에
   서블릿 정보를 추가해야 한다.
 4.url-pattern 지정하는 방법 3가지
 	1)extension matching -> *.do  ,  *.nhn  ,  *.acorn
 	2)exact matching -> /test  ,  /acorn  ,  /test/acorn
 	3)wildcard matching -> /test/*  ,  /acorn/*
 */
@WebServlet("/acorn")
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//응답 MIME 타입과 문자 인코딩을 지정한다.
		response.setContentType("text/html;charset=utf-8");
		//클라이언트에게 응답할 출력객체를 생성한다.
		PrintWriter out = response.getWriter();
		out.print("<!DOCTYPE html>");
		out.print("<html>");
		out.print("<body>");
		out.print("<h1>서버다 이말이란다</h1>");
		String id = request.getParameter("id");
		String age = request.getParameter("age");
		out.println(id + "," + age);
		out.print("</body>");
		out.print("</html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
