package com.shopsphere.admin.controller;

import com.shopsphere.admin.dao.JdbcEntityDao;

import java.sql.SQLException;
import java.util.List;

/** Mediates table-screen actions between Swing views and the JDBC model. */
public class EntityController {
    protected final JdbcEntityDao dao;

    public EntityController(JdbcEntityDao dao) {
        this.dao = dao;
    }

    public List<Object[]> listRows() throws SQLException {
        return dao.findAll();
    }

    public void create(Object[] values) throws SQLException {
        dao.insert(values);
    }

    public void edit(Object id, Object[] values) throws SQLException {
        dao.update(id, values);
    }

    public void remove(Object id) throws SQLException {
        dao.delete(id);
    }
}
