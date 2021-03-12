package ru.sapteh.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import ru.sapteh.dao.Dao;
import ru.sapteh.model.Users;

import java.util.List;

public class UsersService implements Dao<Users,Integer> {

    private final SessionFactory factory;

    public UsersService(SessionFactory factory){
        this.factory=factory;
    }


    @Override
    public void create(Users users) {
        try(Session session=factory.openSession()) {
            session.beginTransaction();
            session.save(users);
            session.getTransaction().commit();
        }
    }

    @Override
    public void update(Users users) {

    }

    @Override
    public void delete(Users users) {

    }

    @Override
    public Users read(Integer id) {
        return null;
    }

    @Override
    public List<Users> readByAll() {
       try(Session session=factory.openSession()) {
           Query<Users> query=session.createQuery("from Users ");
           return query.list();
       }
    }
}
