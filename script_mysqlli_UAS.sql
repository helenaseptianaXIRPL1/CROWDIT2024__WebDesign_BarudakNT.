create database uas_npm_nama_kelas_prodi_dbms


create table tblpegawai_npm_prodi_kelas 
(
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kode_pegawai VARCHAR(4) NOT NULL UNIQUE,
    nama_pegawai VARCHAR(50) NOT NULL,
    jenis_kelamin VARCHAR(20) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);

create table npm_prodi_kelas_tblbarang
(
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kode_barang VARCHAR(4) NOT NULL UNIQUE,
    nama_barang VARCHAR(50) NOT NULL,
    harga_barang INT(10) NOT NULL,
    stok_barang INT(11)

);

create table tbltransaksi_npm_prodi_kelas
(
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  nomor_transaksi VARCHAR(15) NOT NULL,
  tanggal_transaksi DATE NOT NULL,
  waktu_transaksi TIME NOT NULL,
  kode_barang VARCHAR(10) NOT NULL,
  jumlah_beli INT(11) NOT NULL,
  kode_pegawai VARCHAR(10) NOT NULL,
  FOREIGN KEY (kode_barang) REFERENCES npm_prodi_kelas_tblbarang(kode_barang),
  FOREIGN KEY (kode_pegawai) REFERENCES tblpegawai_npm_prodi_kelas(kode_pegawai)
);

create table npm_prodi_kelas_tblbarangmasuk
(
  id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nomor_masuk VARCHAR(15) NOT NULL,
  tanggal_masuk DATE NOT NULL,
  waktu_masuk TIME NOT NULL,
  kode_barang VARCHAR(10) NOT NULL,
  jumlah_masuk INT(11) NOT NULL,
  kode_pegawai VARCHAR(10) NOT NULL,
  FOREIGN KEY (kode_barang) REFERENCES npm_prodi_kelas_tblbarang(kode_barang),
  FOREIGN KEY (kode_pegawai) REFERENCES tblpegawai_npm_prodi_kelas(kode_pegawai)    
);

create table tbl_log_barang
(
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    operasi VARCHAR(10) NOT NULL,
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,      
    kode_barang VARCHAR(4) NOT NULL ,
    nama_barang VARCHAR(50) NOT NULL,
    harga_barang INT(10) NOT NULL,
    stok_barang INT(11)
);

create table tbl_log_pegawai
(
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    operasi VARCHAR(10) NOT NULL,
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,      
    kode_pegawai VARCHAR(4) NOT NULL ,
    nama_pegawai VARCHAR(50) NOT NULL,
    jenis_kelamin VARCHAR(20) NOT NULL,
    alamat VARCHAR(255) NOT NULL    
);

#Store procedure

#pegawai

DELIMITER $$

CREATE PROCEDURE sp_read_pegawai()
BEGIN
    SELECT * FROM tblpegawai_npm_prodi_kelas;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_simpan_pegawai
(
    var_kode_pegawai VARCHAR(4),
    var_nama_pegawai VARCHAR(50),
    var_jenis_kelamin VARCHAR(20),
    var_alamat VARCHAR(255)
)
BEGIN
    INSERT INTO tblpegawai_npm_prodi_kelas(kode_pegawai,nama_pegawai,jenis_kelamin,alamat)
    VALUES(var_kode_pegawai,var_nama_pegawai,var_jenis_kelamin,var_alamat);     
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_update_pegawai 
(
    var_id INT,
    var_kode_pegawai VARCHAR(4),
    var_nama_pegawai VARCHAR(50),
    var_jenis_kelamin VARCHAR(20),
    var_alamat VARCHAR(255)    
)
BEGIN
    UPDATE tblpegawai_npm_prodi_kelas
    SET
        kode_pegawai = var_kode_pegawai,
        nama_pegawai = var_nama_pegawai,
        jenis_kelamin = var_jenis_kelamin,
        alamat = var_alamat
    WHERE id = var_id;   
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_delete_pegawai
(
    var_id INT
)
BEGIN
    DELETE FROM tblpegawai_npm_prodi_kelas
    WHERE id = var_id;     
END $$

DELIMITER ;



#Barang

DELIMITER $$

CREATE PROCEDURE sp_read_barang()
BEGIN
    SELECT * FROM npm_prodi_kelas_tblbarang;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_simpan_barang
(
    var_kode_barang VARCHAR(4),
    var_nama_barang VARCHAR(50),
    var_harga_barang INT(10),
    var_stok_barang INT
)
BEGIN
    INSERT INTO npm_prodi_kelas_tblbarang(kode_barang,nama_barang,harga_barang,stok_barang)
    VALUES(var_kode_barang,var_nama_barang,var_harga_barang,var_stok_barang);     
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_update_barang 
(
    var_id INT,
    var_kode_barang VARCHAR(4),
    var_nama_barang VARCHAR(50),
    var_harga_barang INT(10),
    var_stok_barang INT  
)
BEGIN
    UPDATE npm_prodi_kelas_tblbarang
    SET
        kode_barang = var_kode_barang,
        nama_barang = var_nama_barang,
        harga_barang = var_harga_barang,
        stok_barang = var_stok_barang
    WHERE id = var_id;   
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_delete_barang
(
    var_id INT
)
BEGIN
    DELETE FROM npm_prodi_kelas_tblbarang
    WHERE id = var_id;     
END $$

DELIMITER ;

#Transaksi

DELIMITER $$

CREATE PROCEDURE sp_read_transaksi()
BEGIN
    SELECT * FROM tbltransaksi_npm_prodi_kelas;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_simpan_transaksi
(

  var_nomor_transaksi VARCHAR(15),
  var_tanggal_transaksi DATE,
  var_waktu_transaksi TIME,
  var_kode_barang VARCHAR(10),
  var_jumlah_beli INT(11),
  var_kode_pegawai VARCHAR(10)
  
)
BEGIN
    DECLARE var_stock_sementara INT;

    
    SELECT stok_barang INTO var_stock_sementara
    FROM npm_prodi_kelas_tblbarang
    WHERE kode_barang = var_kode_barang;

    INSERT INTO tbltransaksi_npm_prodi_kelas(nomor_transaksi,tanggal_transaksi,waktu_transaksi,kode_barang,jumlah_beli,kode_pegawai)
    VALUES(var_nomor_transaksi,var_tanggal_transaksi,var_waktu_transaksi,var_kode_barang,var_jumlah_beli,var_kode_pegawai);

    UPDATE npm_prodi_kelas_tblbarang
    SET stok_barang = stok_barang - var_jumlah_beli
    WHERE kode_barang = var_kode_barang;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_update_transaksi 
(
    var_id INT,
    var_kode_barang VARCHAR(4),
    var_nama_barang VARCHAR(50),
    var_harga_barang INT(10),
    var_stok_barang INT  
)
BEGIN
    UPDATE npm_prodi_kelas_tblbarang
    SET
        kode_barang = var_kode_barang,
        nama_barang = var_nama_barang,
        harga_barang = var_harga_barang,
        stok_barang = var_stok_barang
    WHERE id = var_id;   
END $$

DELIMITER ;


#barang nomor_masuk

DELIMITER $$

CREATE PROCEDURE sp_read_barangmasuk()
BEGIN
    SELECT * FROM tblbarangmasuk_npm_prodi_kelas;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_simpan_barangmasuk
(
  var_nomor_masuk VARCHAR(15),
  var_tanggal_masuk DATE,
  var_waktu_masuk TIME,
  var_kode_barang VARCHAR(10),
  var_jumlah_masuk INT(11),
  var_kode_pegawai VARCHAR(10)
)
BEGIN


    INSERT INTO npm_prodi_kelas_tblbarangmasuk(nomor_masuk,tanggal_masuk,waktu_masuk,kode_barang,jumlah_masuk,kode_pegawai)
    VALUES(var_nomor_masuk,var_tanggal_masuk,var_waktu_masuk,var_kode_barang,var_jumlah_masuk,var_kode_pegawai);
     
END $$

DELIMITER ;

-- DELIMITER $$

-- CREATE PROCEDURE sp_simpan_transaksi
-- (
--   var_nomor_masuk VARCHAR(10),
--   var_tanggal_masuk DATE,
--   var_waktu_masuk TIME,
--   var_kode_barang VARCHAR(10),
--   var_jumlah_masuk INT(11),
--   var_kode_pegawai VARCHAR(10)
-- )
-- BEGIN
--     DECLARE var_stock_sementara INT;
--     SELECT stok_barang INTO var_stock_sementara
--     FROM npm_prodi_kelas_tblbarang
--     WHERE kode_barang = var_kode_barang;

--     INSERT INTO npm_prodi_kelas_tblbarangmasuk(nomor_masuk,tanggal_masuk,waktu_masuk,kode_barang,jumlah_masuk,kode_pegawai)
--     VALUES(var_nomor_masuk,var_tanggal_masuk,var_waktu_masuk,var_kode_barang,var_jumlah_masuk,var_kode_pegawai);

--     UPDATE npm_prodi_kelas_tblbarang
--     SET stok_barang = var_stock_sementara + var_jumlah_masuk
--     WHERE kode_barang = var_kode_barang;     
-- END $$

-- DELIMITER ;


#Trigger

#Pegawai

DELIMITER $$

CREATE TRIGGER trg_log_simpan_pegawai
AFTER INSERT ON tblpegawai_npm_prodi_kelas
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_pegawai
    (
        operasi,
        timestamp,
        kode_pegawai,
        nama_pegawai,
        jenis_kelamin,
        alamat
    ) VALUES (
        'Insert',
        CURRENT_TIMESTAMP(),
        NEW.kode_pegawai,
        NEW.nama_pegawai,
        NEW.jenis_kelamin,
        NEW.alamat        
    );
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_log_update_pegawai
AFTER UPDATE ON tblpegawai_npm_prodi_kelas
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_pegawai
    (
        operasi,
        timestamp,
        kode_pegawai,
        nama_pegawai,
        jenis_kelamin,
        alamat
    ) VALUES(
        'Update',
        CURRENT_TIMESTAMP(),
        NEW.kode_pegawai,
        NEW.nama_pegawai,
        NEW.jenis_kelamin,
        NEW.alamat        
    );

END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_log_delete_pegawai
AFTER DELETE ON tblpegawai_npm_prodi_kelas
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_pegawai
    (
        operasi,
        timestamp,
        kode_pegawai,
        nama_pegawai,
        jenis_kelamin,
        alamat
    ) VALUES(
        'Delete',
        CURRENT_TIMESTAMP(),
        OLD.kode_pegawai,
        OLD.nama_pegawai,
        OLD.jenis_kelamin,
        OLD.alamat        
    );

END $$

DELIMITER ;

#Barang

DELIMITER $$

CREATE TRIGGER trg_log_simpan_barang
AFTER INSERT ON npm_prodi_kelas_tblbarang
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_barang
    (
        operasi,
        timestamp,
        kode_barang,
        nama_barang,
        harga_barang,
        stok_barang
    ) VALUES (
        'Insert',
        CURRENT_TIMESTAMP(),
        NEW.kode_barang,
        NEW.nama_barang,
        NEW.harga_barang,
        NEW.stok_barang        
    );
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_log_update_barang
AFTER UPDATE ON npm_prodi_kelas_tblbarang
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_barang
    (
        operasi,
        timestamp,
        kode_barang,
        nama_barang,
        harga_barang,
        stok_barang
    ) VALUES(
        'Update',
        CURRENT_TIMESTAMP(),
        NEW.kode_barang,
        NEW.nama_barang,
        NEW.harga_barang,
        NEW.stok_barang                
    );

END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_log_delete_barang
AFTER DELETE ON npm_prodi_kelas_tblbarang
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_barang
    (
        operasi,
        timestamp,
        kode_barang,
        nama_barang,
        harga_barang,
        stok_barang
    ) VALUES(
        'Delete',
        CURRENT_TIMESTAMP(),
        OLD.kode_barang,
        OLD.nama_barang,
        OLD.harga_barang,
        OLD.stok_barang     
    );

END $$

DELIMITER ;

#tbl barang masuk


DELIMITER $$

CREATE TRIGGER trg_barangmasuk
AFTER INSERT ON npm_prodi_kelas_tblbarangmasuk
FOR EACH ROW
BEGIN
UPDATE npm_prodi_kelas_tblbarang SET stok_barang = stok_barang + NEW.jumlah_masuk
WHERE kode_barang = NEW.kode_barang;

END $$

DELIMITER ;



-- View soal 1

CREATE VIEW vw_transaksi_npm_prodi_kelas AS
SELECT
  t.nomor_transaksi,
  t.tanggal_transaksi,
  t.waktu_transaksi,
  b.kode_barang,
  b.nama_barang,
  b.harga_barang,
  t.jumlah_beli,
  t.jumlah_beli * b.harga_barang AS sub_total,
  t.kode_pegawai,
  p.nama_pegawai,
  p.jenis_kelamin,
  p.alamat
FROM tbltransaksi_npm_prodi_kelas AS t
INNER JOIN npm_prodi_kelas_tblbarang AS b ON t.kode_barang = b.kode_barang
INNER JOIN tblpegawai_npm_prodi_kelas AS p ON t.kode_pegawai = p.kode_pegawai;

-- View 2

CREATE VIEW vw_barang_masuk_npm_prodi_kelas AS
SELECT
  bm.nomor_masuk,
  bm.tanggal_masuk,
  bm.waktu_masuk,
  b.kode_barang,
  b.nama_barang,
  b.harga_barang,
  bm.jumlah_masuk,
  bm.kode_pegawai,
  p.nama_pegawai,
  p.jenis_kelamin,
  p.alamat
FROM tblbarangmasuk_npm_prodi_kelas AS bm
INNER JOIN npm_prodi_kelas_tblbarang AS b ON bm.kode_barang = b.kode_barang
INNER JOIN tblpegawai_npm_prodi_kelas AS p ON bm.kode_pegawai = p.kode_pegawai;


-- View 3

CREATE VIEW vw_group_by AS
SELECT
  t.nomor_transaksi,
  t.tanggal_transaksi,
  t.waktu_transaksi,
  b.kode_barang,
  b.nama_barang,
  b.harga_barang,
  SUM(t.jumlah_beli) AS total_jumlah_beli,
  t.kode_pegawai,
  p.nama_pegawai,
  p.jenis_kelamin,
  p.alamat
FROM tbltransaksi_npm_prodi_kelas AS t
INNER JOIN npm_prodi_kelas_tblbarang AS b ON t.kode_barang = b.kode_barang
INNER JOIN tblpegawai_npm_prodi_kelas AS p ON t.kode_pegawai = p.kode_pegawai
GROUP BY
  t.nomor_transaksi,
  t.tanggal_transaksi,
  t.waktu_transaksi,
  b.kode_barang,
  b.nama_barang,
  b.harga_barang,
  t.kode_pegawai,
  p.nama_pegawai,
  p.jenis_kelamin,
  p.alamat
ORDER BY total_jumlah_beli DESC;