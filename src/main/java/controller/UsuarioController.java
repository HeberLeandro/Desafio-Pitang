package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import model.SignInBean;
import model.Usuario;
import repository.UsuarioRepository;


@WebServlet("/usuario")
public class UsuarioController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();
	UsuarioRepository repo = new UsuarioRepository();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String signIn = request.getParameter("signin");
		String signUp = request.getParameter("signup");
		ObjectMapper mapper = new ObjectMapper();
		
		if (signIn != null) {
	
			String signJson = readerToString(request.getReader());
			SignInBean si = gson.fromJson(signJson, SignInBean.class);
	        
	        if (si.getEmail() == null || si.getSenha() == null) {
	        	String responseJson = "{}"; 
		        PrintWriter out = response.getWriter();
				response.setContentType("application/json");
		        out.print(responseJson);
		        out.flush();  
	        }
	        
	        Usuario user = repo.get(si);
	        
	        String responseJson = mapper.writeValueAsString(user);
	        if (responseJson.equals("null")) responseJson = "{}"; 
	        PrintWriter out = response.getWriter();
			response.setContentType("application/json");
	        out.print(responseJson);
	        out.flush();  

	        
		} else if (signUp != null) {
	
			String signUpJson = readerToString(request.getReader());
			
			Usuario us = gson.fromJson(signUpJson, Usuario.class);
	        
	        if (us.getEmail() == null || us.getSenha() == null || us.getSenha() == null || us.getTelefones().isEmpty()) {
				String responseJson = "{}"; 
		        PrintWriter out = response.getWriter();
				response.setContentType("application/json");
		        out.print(responseJson);
		        out.flush();  
	        }
	        
	        Usuario user = repo.add(us);
	        
	        request.setAttribute("usuario", user);
	        
	        String responseJson = mapper.writeValueAsString(user);
	        if (responseJson.equals("null")) responseJson = "{}"; 
	        PrintWriter out = response.getWriter();
			response.setContentType("application/json");
	        out.print(responseJson);
	        out.flush();  
	        
		}
	}
	
	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String attJson = readerToString(request.getReader());
		
		Usuario us = gson.fromJson(attJson, Usuario.class);
        
        if (us.getEmail() == null || us.getSenha() == null || us.getSenha() == null || us.getTelefones().isEmpty()) {
        	String responseJson = "{}"; 
	        PrintWriter out = response.getWriter();
			response.setContentType("application/json");
	        out.print(responseJson);
	        out.flush();  
        }
        try {
        	repo.update(us);
		} catch (Exception e) {
		}
        
        ObjectMapper mapper = new ObjectMapper();
        String responseJson = mapper.writeValueAsString(us);
        if (responseJson.equals("null")) responseJson = "{}"; 
        PrintWriter out = response.getWriter();
		response.setContentType("application/json");
        out.print(responseJson);
        out.flush();  
	}
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cod = request.getParameter("id");
		
		Long id = Long.parseLong(cod);
        
        repo.remove(id);
        
    	String responseJson = "{}"; 
        PrintWriter out = response.getWriter();
		response.setContentType("application/json");
        out.print(responseJson);
        out.flush();
	}
	
	private String readerToString(BufferedReader reader) throws IOException {
		StringBuilder buffer = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        String data = buffer.toString();
        
        return data;
	}
	
}
