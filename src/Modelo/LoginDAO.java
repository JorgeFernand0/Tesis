package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LoginDAO {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Conexion cn = new Conexion();

    public login log(String correo, String pass) {
        login l = new login();
        String sql = "SELECT * FROM usuarios WHERE correo = ? AND pass = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            if (rs.next()) {
                l.setId(rs.getInt("id"));
                l.setNombre(rs.getString("nombre"));
                l.setCorreo(rs.getString("correo"));
                l.setPass(rs.getString("pass"));
                l.setRol(rs.getString("rol"));
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return l;
    }

    public boolean Registrar(login reg) {
        String sqlCheck = "SELECT * FROM usuarios WHERE correo = ?";
        String sqlInsert = "INSERT INTO usuarios (nombre, correo, pass, rol) VALUES (?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sqlCheck);
            ps.setString(1, reg.getCorreo());
            rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Correo ya registrado, intente con un nuevo correo.");
                return false; // Indica que el registro falló debido a que el correo ya está registrado
            } else {
                ps = con.prepareStatement(sqlInsert);
                ps.setString(1, reg.getNombre());
                ps.setString(2, reg.getCorreo());
                ps.setString(3, reg.getPass());
                ps.setString(4, reg.getRol());
                ps.execute();
                return true; // Registro exitoso
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
            return false;
        }
    }

    public List ListarUsuarios() {
        List<login> Lista = new ArrayList();
        String sql = "SELECT * FROM usuarios";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                login lg = new login();
                lg.setId(rs.getInt("id"));
                lg.setNombre(rs.getString("nombre"));
                lg.setCorreo(rs.getString("correo"));
                lg.setRol(rs.getString("rol"));
                Lista.add(lg);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return Lista;
    }
}
