<%
class JenisKelaminObject {
    public int kode;
    public String nama;
}

class JenisKelamin {
    private Connection conn;

    public JenisKelamin(Connection conn) {
        this.conn = conn;
    }

    public List<JenisKelaminObject> list() throws Exception {
        List<JenisKelaminObject> result = new ArrayList<>();
        String sql = "SELECT kode, nama FROM jenis_kelamin ORDER BY kode";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            JenisKelaminObject obj = new JenisKelaminObject();
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
            result.add(obj);
        }

        rs.close();
        stmt.close();
        return result;
    }

    public void insert(JenisKelaminObject j) throws Exception {
        String sql = "INSERT INTO jenis_kelamin (kode, nama) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, j.kode);
        ps.setString(2, j.nama);
        ps.executeUpdate();
        ps.close();
    }

    public void update(JenisKelaminObject j) throws Exception {
        String sql = "UPDATE jenis_kelamin SET nama=? WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, j.nama);
        ps.setInt(2, j.kode);
        ps.executeUpdate();
        ps.close();
    }

    public JenisKelaminObject get(int kode) throws Exception {
        String sql = "SELECT kode, nama FROM jenis_kelamin WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);

        ResultSet rs = ps.executeQuery();
        JenisKelaminObject obj = new JenisKelaminObject();

        if (rs.next()) {
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
        }

        rs.close();
        ps.close();
        return obj;
    }

    public void delete(int kode) throws Exception {
        String sql = "DELETE FROM jenis_kelamin WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);
        ps.executeUpdate();
        ps.close();
    }
}
%>
