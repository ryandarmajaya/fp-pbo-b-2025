<%
class UserObject {
    public String username;
    public String password;
    public int kode_role;
}

class UserLogin {
    public String username;
    public String password;
}

class User {
    private Connection con;

    public User(Connection con) {
        this.con = con;
    }

    public boolean login(UserLogin u) throws Exception {
        String sql = "SELECT username, kode_role FROM user WHERE username=? AND password=MD5(?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, u.username);
        ps.setString(2, u.password);

        ResultSet rs = ps.executeQuery();
        boolean ok = rs.next();
        rs.close();
        ps.close();
        return ok;
    }

    public List<UserObject> list() throws Exception {
        List<UserObject> hasil = new ArrayList<UserObject>();
        String sql = "SELECT username, password, kode_role FROM user";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            UserObject o = new UserObject();
            o.username = rs.getString("username");
            o.password = rs.getString("password");
            o.kode_role = rs.getInt("kode_role");
            hasil.add(o);
        }
        rs.close();
        ps.close();
        return hasil;
    }

    public List<UserObject> listByKodeRole(int role) throws Exception {
        List<UserObject> hasil = new ArrayList<UserObject>();
        String sql = "SELECT username, password, kode_role FROM user WHERE kode_role=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, role);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            UserObject o = new UserObject();
            o.username = rs.getString("username");
            o.password = rs.getString("password");
            o.kode_role = rs.getInt("kode_role");
            hasil.add(o);
        }
        rs.close();
        ps.close();
        return hasil;
    }

    public void insert(UserObject o) throws Exception {
        String sql = "INSERT INTO user(username, password, kode_role) VALUES(?, MD5(?), ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, o.username);
        ps.setString(2, o.password);
        ps.setInt(3, o.kode_role);
        ps.executeUpdate();
        ps.close();
    }

    public void updatePassword(String username, String password) throws Exception {
        String sql = "UPDATE user SET password=MD5(?) WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, password);
        ps.setString(2, username);
        ps.executeUpdate();
        ps.close();
    }

    public void updateKodeRole(String username, int role) throws Exception {
        String sql = "UPDATE user SET kode_role=? WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, role);
        ps.setString(2, username);
        ps.executeUpdate();
        ps.close();
    }

    public UserObject get(String username) throws Exception {
        UserObject o = null;
        String sql = "SELECT username, password, kode_role FROM user WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            o = new UserObject();
            o.username = rs.getString("username");
            o.password = rs.getString("password");
            o.kode_role = rs.getInt("kode_role");
        }
        rs.close();
        ps.close();
        return o;
    }

    public void delete(String username) throws Exception {
        String sql = "DELETE FROM user WHERE username=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ps.executeUpdate();
        ps.close();
    }
}
%>
