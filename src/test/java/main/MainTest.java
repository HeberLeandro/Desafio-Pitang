package main;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import org.junit.Test;
import model.SignInBean;
import model.Usuario;
import repository.UsuarioRepository;

public class MainTest {
	
    @Test
    public void cadastrarUsuarioTest() {
    	UsuarioRepository repo = new UsuarioRepository();
    	Usuario us = criarUsuario();
        Usuario tmp = repo.add(us);
       
        assertNotNull(tmp);
        assertEquals(us.getEmail(), tmp.getEmail());
        
        repo.remove(us.getId());

    }
    
    @Test
    public void signInTest() {
    	UsuarioRepository repo = new UsuarioRepository();
    	Usuario us = criarUsuario();
    	repo.add(us);
    	
    	SignInBean bean = new SignInBean();
    	bean.setEmail(us.getEmail());
    	bean.setSenha(us.getSenha());
    	
        Usuario tmp = repo.get(bean);
       
        assertNotNull(tmp);
        assertEquals(us.getEmail(), tmp.getEmail());
        
        repo.remove(us.getId());

    }
    
    @Test
    public void getByIDTest() {
    	UsuarioRepository repo = new UsuarioRepository();
    	Usuario us = criarUsuario();
    	repo.add(us);
    	
        Usuario tmp = repo.get(us.getId());
       
        assertNotNull(tmp);
        assertEquals(us.getEmail(), tmp.getEmail());
        
        repo.remove(us.getId());
    }
    
    @Test
    public void alterarUsuarioTest() {
    	UsuarioRepository repo = new UsuarioRepository();
    	Usuario us = criarUsuario();
    	repo.add(us);
    	
    	us.setSenha("321");
    	repo.update(us);
    	
    	Usuario tmp = repo.get(us.getId());
       
        assertNotNull(tmp);
        assertEquals(tmp.getSenha(), "321");
        
        repo.remove(us.getId());
    }
    
    @Test
    public void removerUsuarioTest() {
    	UsuarioRepository repo = new UsuarioRepository();
    	Usuario us = criarUsuario();
    	repo.add(us);
    	
    	repo.remove(us.getId());
    	
    	Usuario tmp = repo.get(us.getId());
       
        assertNull(tmp.getEmail());
    }

	private Usuario criarUsuario() {
		
		Usuario u = new Usuario();
		u.setEmail("test1@email.com");
		u.setNome("teste1");
		u.setSenha("123");
		u.addTelefone(85,"988887777");
		
		return u;
	}
}
