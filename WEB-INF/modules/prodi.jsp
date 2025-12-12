<%
class ProdiObject {
    public int kode;
    public String nama;
    public int kode_jenjang;
}

class Prodi {
    private Connection conn;

    public Prodi(Connection conn) {
        this.conn = conn;
    }

    public List<ProdiObject> list() throws Exception {
        List<ProdiObject> result = new ArrayList<>();
        String sql = "SELECT kode, nama, kode_jenjang FROM prodi ORDER BY kode";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            ProdiObject obj = new ProdiObject();
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
            obj.kode_jenjang = rs.getInt("kode_jenjang");
            result.add(obj);
        }

        rs.close();
        stmt.close();
        return result;
    }

    public void insert(ProdiObject p) throws Exception {
        String sql = "INSERT INTO prodi (kode, nama, kode_jenjang) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, p.kode);
        ps.setString(2, p.nama);
        ps.setInt(3, p.kode_jenjang);
        ps.executeUpdate();
        ps.close();
    }

    public void update(ProdiObject p) throws Exception {
        String sql = "UPDATE prodi SET nama=?, kode_jenjang=? WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, p.nama);
        ps.setInt(2, p.kode_jenjang);
        ps.setInt(3, p.kode);
        ps.executeUpdate();
        ps.close();
    }

    public ProdiObject get(int kode) throws Exception {
        String sql = "SELECT kode, nama, kode_jenjang FROM prodi WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);

        ResultSet rs = ps.executeQuery();
        ProdiObject obj = new ProdiObject();

        if (rs.next()) {
            obj.kode = rs.getInt("kode");
            obj.nama = rs.getString("nama");
            obj.kode_jenjang = rs.getInt("kode_jenjang");
        }

        rs.close();
        ps.close();
        return obj;
    }

    public void delete(int kode) throws Exception {
        String sql = "DELETE FROM prodi WHERE kode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, kode);
        ps.executeUpdate();
        ps.close();
    }
}
%>
