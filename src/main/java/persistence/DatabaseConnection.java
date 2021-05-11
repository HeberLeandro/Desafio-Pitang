package persistence;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;


public class DatabaseConnection {
	
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("desafioBD");
	private EntityManager em = emf.createEntityManager();
	private EntityTransaction et = em.getTransaction();
	
	private static DatabaseConnection myself = null;
	
	public DatabaseConnection() {
		et.begin();
	}
	
	public static DatabaseConnection getCurrentInstance(){
        if(myself == null)
            myself = new DatabaseConnection();
        
        return myself;
    }

	public EntityManagerFactory getEmf() {
		return emf;
	}
	public EntityManager getEm() {
		return em;
	}
	public EntityTransaction getEt() {
		return et;
	}
	
	
//	public static void main(String[] args) {
//		DatabaseConnection bd = new DatabaseConnection();
//			
//		Usuario us = new Usuario();
//		us.setEmail("email@mail.com");
//		us.setNome("Fulano");
//		us.setSenha("1234");
//		us.addTelefone(85, "123456789");
//		
//		bd.et.begin();
//		bd.em.persist(us);
//		bd.et.commit();
//		
//		List<Usuario> lista = bd.em.createQuery("SELECT u FROM Usuario u", Usuario.class).getResultList();
//		
//		for (Usuario usuario : lista) {
//			System.out.println("User: "+ usuario.getNome() +", email: "+ usuario.getEmail());
//			System.out.print("Telefones: ");
//			for (Telefone t : usuario.getTelefones()) {
//				System.out.print(t.toString() +" | ");
//			}
//			System.out.println("");
//		}
//		
//		
//	}
	
	
 
}
