package edu.depaul.cdm.se.servlet;
 import java.io.IOException;
import java.util.List;
 import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.depaul.cdm.se.courses.Course;
import edu.depaul.cdm.se.courses.MongoDBCourseDAO;

import com.mongodb.MongoClient;
 @WebServlet("/swappedCourses")
public class SwappedCoursesServlet extends HttpServlet {
 	private static final long serialVersionUID = -6554920927964049383L;
 	
 	static Course c1 = new Course();

 	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String location = request.getParameter("location");
		String professor = request.getParameter("professor");
		String times = request.getParameter("times");
		String description = request.getParameter("description");
		MongoClient mongo = (MongoClient) request.getServletContext()
				.getAttribute("MONGO_CLIENT");
		MongoDBCourseDAO courseDAO = new MongoDBCourseDAO(mongo);
		if(id != null) {
			//Course c1 = new Course();
			c1.setId(id);
			c1.setLocation(location);
			c1.setName(name);
			c1.setProfessor(professor);
			c1.setTimes(times);
			c1.setDescription(description);
			//courseDAO.swapCourseFromEnrolled(c1);
		}
		
//		Course c = new Course();
//		c.setId(id);
//		c = courseDAO.readCourse(c);
//		request.setAttribute("course", c);
		List<Course> swappedCourses = courseDAO.readAllCourse();
		request.setAttribute("swappedCourses", swappedCourses);
 		RequestDispatcher rd = getServletContext().getRequestDispatcher(
				"/swappedCourses.jsp");
		rd.forward(request, response);
	}

 	protected void doPost(HttpServletRequest request,        
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id"); // keep it non-editable in UI
		if (id == null || "".equals(id)) {
			throw new ServletException("id missing for edit operation");
		}
 		String name = request.getParameter("name");
		String location = request.getParameter("location");
 		if ((name == null || name.equals(""))
				|| (location == null || location.equals(""))) {
			request.setAttribute("error", "Name and location can't be empty");
			MongoClient mongo = (MongoClient) request.getServletContext()
					.getAttribute("MONGO_CLIENT");
			MongoDBCourseDAO courseDAO = new MongoDBCourseDAO(mongo);
			Course c = new Course();
			c.setId(id);
			c.setName(name);
			c.setLocation(location);
			request.setAttribute("course", c);
			List<Course> courses = courseDAO.readAllCourse();
			request.setAttribute("courses", courses);
 			RequestDispatcher rd = getServletContext().getRequestDispatcher(
					"/droppedCourses.jsp");
			rd.forward(request, response);
		} else {
			MongoClient mongo = (MongoClient) request.getServletContext()
					.getAttribute("MONGO_CLIENT");
			MongoDBCourseDAO courseDAO = new MongoDBCourseDAO(mongo);
			Course c = new Course();
			c.setId(id);
			c.setName(name);
			c.setLocation(location);
			courseDAO.updateCourse(c);
			System.out.println("Course enrolled successfully with id=" + id);
			request.setAttribute("success", "Course enrolled successfully");
			List<Course> courses = courseDAO.readAllCourse();
			request.setAttribute("courses", courses);
 			RequestDispatcher rd = getServletContext().getRequestDispatcher(
					"/droppedCourses.jsp");
			rd.forward(request, response);
		}
	}
 }