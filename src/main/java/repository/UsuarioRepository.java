package repository;

import java.util.List;

import javax.persistence.TypedQuery;

import model.SignInBean;
import model.Telefone;
import model.Usuario;
import persistence.DatabaseConnection;

public class UsuarioRepository {
	private DatabaseConnection db = DatabaseConnection.getCurrentInstance();

	public Usuario get(SignInBean bean) {
		TypedQuery<Usuario> q = db.getEm().createQuery("SELECT u FROM Usuario u WHERE u.email = ?1 AND u.senha = ?2",
				Usuario.class);
		q.setParameter(1, bean.getEmail());
		q.setParameter(2, bean.getSenha());

		if (q.getResultList().isEmpty()) {
			return new Usuario();
		}

		Usuario tmp = q.getResultList().get(0);

		return tmp;
	}

	public Usuario get(long id) {
		TypedQuery<Usuario> q = db.getEm().createQuery("SELECT u FROM Usuario u WHERE u.id = ?1", Usuario.class);
		q.setParameter(1, id);

		return (q.getResultList().isEmpty()) ? new Usuario() : q.getResultList().get(0);
	}

	public List<Usuario> getAll() {
		TypedQuery<Usuario> q = db.getEm().createQuery("SELECT u FROM Usuario u", Usuario.class);

		List<Usuario> ul = q.getResultList();

		return ul;
	}

	public Usuario add(Usuario usuario) {
		TypedQuery<Usuario> query = db.getEm().createQuery("SELECT u FROM Usuario u WHERE u.email = ?1", Usuario.class);
		query.setParameter(1, usuario.getEmail());

		if (query.getResultList().isEmpty()) {
			for (Telefone t : usuario.getTelefones()) {
				t.setUsuario(usuario);
			}
			db.getEm().persist(usuario);
			db.getEt().commit();
			TypedQuery<Usuario> q = db.getEm().createQuery("SELECT u FROM Usuario u WHERE u.email = ?1", Usuario.class);
			q.setParameter(1, usuario.getEmail());
			Usuario tmp = q.getResultList().get(0);

			return tmp;
		}

		return null;
	}

	public void update(Usuario usuario) {
		Usuario dbUser = db.getEm().find(Usuario.class, usuario.getId());

		if (dbUser == null)
			return;

		dbUser.setNome(usuario.getNome());
		dbUser.setEmail(usuario.getEmail());
		dbUser.setSenha(usuario.getSenha());
		
		for (int i = 0; i < dbUser.getTelefones().size(); i++) {
			dbUser.getTelefones().get(i).setDdd(usuario.getTelefones().get(i).getDdd());
			dbUser.getTelefones().get(i).setNumero(usuario.getTelefones().get(i).getNumero());
		}

		db.getEm().clear();
		db.getEm().merge(dbUser);
		db.getEt().commit();
	}

	public void remove(Long id) {
		Usuario dbUser = db.getEm().find(Usuario.class, id);
		if (dbUser == null)
			return;

		db.getEm().remove(dbUser);
		
	}

}
