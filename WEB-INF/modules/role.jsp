<%
class RoleObject {
    public int kode;
    public String nama;
}

class Role {
    private Connection conn;

    public Role(Connection conn) {
        this.conn = conn;
    }

    public List<RoleObject> list() throws Exception {
        List<RoleObject> result = new ArrayList<>();
        String sql = "SELECT kode, nama FROM role ORDER BY kode";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            RoleObject obj = new RoleObject();
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
            result.add(obj);
        }

        rs.close();
        stmt.close();
        return result;
    }

    public void insert(RoleObject r) throws Exception {
        String sql = "INSERT INTO role (kode, nama) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, r.kode);
        ps.setString(2, r.nama);
        ps.executeUpdate();
        ps.close();
    }

    public void update(RoleObject r) throws Exception {
        String sql = "UPDATE role SET nama=? WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, r.nama);
        ps.setInt(2, r.kode);
        ps.executeUpdate();
        ps.close();
    }

    public RoleObject get(int kode) throws Exception {
        String sql = "SELECT kode, nama FROM role WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);

        ResultSet rs = ps.executeQuery();
        RoleObject obj = new RoleObject();

        if (rs.next()) {
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
        }

        rs.close();
        ps.close();
        return obj;
    }

    public void delete(int kode) throws Exception {
        String sql = "DELETE FROM role WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);
        ps.executeUpdate();
        ps.close();
    }
}
%>
