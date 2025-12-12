<%
class MahasiswaObject {
    public String nim;
    public String nama;
    public int kode_jenis_kelamin;
    public int kode_prodi;
    public String username;
    public String[] header() {
    return new String[]{
        "nim",
        "nama",
        "kode_jenis_kelamin",
        "kode_prodi",
        "username"
    };
}

}

class Mahasiswa {
    private Connection conn;

    public Mahasiswa(Connection conn) {
        this.conn = conn;
    }

    

    public List<MahasiswaObject> list() throws Exception {
        List<MahasiswaObject> result = new ArrayList<>();
        String sql = "SELECT nim, nama, kode_jenis_kelamin, kode_prodi, username FROM mahasiswa ORDER BY nim";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            MahasiswaObject obj = new MahasiswaObject();
            obj.nim = rs.getString("nim");
            obj.nama = rs.getString("nama");
            obj.kode_jenis_kelamin = rs.getInt("kode_jenis_kelamin");
            obj.kode_prodi = rs.getInt("kode_prodi");
            obj.username = rs.getString("username");
            result.add(obj);
        }

        rs.close();
        stmt.close();
        return result;
    }

    public void insert(MahasiswaObject m) throws Exception {
        String sql = "INSERT INTO mahasiswa (nim, nama, kode_jenis_kelamin, kode_prodi, username) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, m.nim);
        ps.setString(2, m.nama);
        ps.setInt(3, m.kode_jenis_kelamin);
        ps.setInt(4, m.kode_prodi);
        ps.setString(5, m.username);
        ps.executeUpdate();
        ps.close();
    }

    public void update(MahasiswaObject m) throws Exception {
        String sql = "UPDATE mahasiswa SET nama=?, kode_jenis_kelamin=?, kode_prodi=?, username=? WHERE nim=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, m.nama);
        ps.setInt(2, m.kode_jenis_kelamin);
        ps.setInt(3, m.kode_prodi);
        ps.setString(4, m.username);
        ps.setString(5, m.nim);
        ps.executeUpdate();
        ps.close();
    }

    public MahasiswaObject get(String nim) throws Exception {
        String sql = "SELECT nim, nama, kode_jenis_kelamin, kode_prodi, username FROM mahasiswa WHERE nim=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, nim);

        ResultSet rs = ps.executeQuery();
        MahasiswaObject obj = new MahasiswaObject();

        if (rs.next()) {
            obj.nim = rs.getString("nim");
            obj.nama = rs.getString("nama");
            obj.kode_jenis_kelamin = rs.getInt("kode_jenis_kelamin");
            obj.kode_prodi = rs.getInt("kode_prodi");
            obj.username = rs.getString("username");
        }

        rs.close();
        ps.close();
        return obj;
    }

    public void delete(String nim) throws Exception {
        String sql = "DELETE FROM mahasiswa WHERE nim=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, nim);
        ps.executeUpdate();
        ps.close();
    }

    public void upsert(MahasiswaObject o) throws Exception {
    MahasiswaObject cek = get(o.nim);
    if (cek == null) {
        insert(o);
    } else {
        update(o);
    }
}

}
%>
