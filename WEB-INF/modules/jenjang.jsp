<%
class JenjangObject {
    public int kode;
    public String nama;
}

class Jenjang {
    private Connection conn;

    public Jenjang(Connection conn) {
        this.conn = conn;
    }

    public List<JenjangObject> list() throws Exception {
        List<JenjangObject> result = new ArrayList<>();
        String sql = "SELECT kode, nama FROM jenjang ORDER BY kode";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            JenjangObject obj = new JenjangObject();
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
            result.add(obj);
        }

        rs.close();
        stmt.close();
        return result;
    }

    public void insert(JenjangObject j) throws Exception {
        String sql = "INSERT INTO jenjang (kode, nama) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, j.kode);
        ps.setString(2, j.nama);
        ps.executeUpdate();
        ps.close();
    }

    public void update(JenjangObject j) throws Exception {
        String sql = "UPDATE jenjang SET nama=? WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, j.nama);
        ps.setInt(2, j.kode);
        ps.executeUpdate();
        ps.close();
    }

    public JenjangObject get(int kode) throws Exception {
        String sql = "SELECT kode, nama FROM jenjang WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);

        ResultSet rs = ps.executeQuery();
        JenjangObject obj = new JenjangObject();

        if (rs.next()) {
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
        }

        rs.close();
        ps.close();
        return obj;
    }

    public void delete(int kode) throws Exception {
        String sql = "DELETE FROM jenjang WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);
        ps.executeUpdate();
        ps.close();
    }
}
%>
