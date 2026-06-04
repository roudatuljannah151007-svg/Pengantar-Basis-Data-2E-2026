CREATE DATABASE db_siakad;
USE db_siakad;

CREATE TABLE mahasiswa (
nim VARCHAR (15) PRIMARY KEY,
nama VARCHAR (100),
angkatan INT,
jurusan VARCHAR (100)
);

CREATE TABLE dosen(
id_dosen INT PRIMARY KEY,
nama_dosen VARCHAR (100)
);

CREATE TABLE mata_kuliah (
kode_mk VARCHAR (25) PRIMARY KEY,
nama_mk VARCHAR (50),
sks INT,
id_dosen INT,
FOREIGN KEY (id_dosen) REFERENCES dosen (id_dosen)
);

CREATE TABLE krs (
id_krs INT PRIMARY KEY,
nim VARCHAR (10),
kode_mk VARCHAR (25),
FOREIGN KEY (nim) REFERENCES mahasiswa (nim),
FOREIGN KEY (kode_mk)REFERENCES mata_kuliah (kode_mk),
semester INT
);

CREATE TABLE nilai (
id_nilai INT PRIMARY KEY,
nim VARCHAR (10),
kode_mk VARCHAR (25),
FOREIGN KEY (nim) REFERENCES mahasiswa (nim),
FOREIGN KEY (kode_mk)REFERENCES mata_kuliah(kode_mk),
nilai_angka DECIMAL (15,2),
nilai_huruf VARCHAR (50)
);

INSERT INTO mahasiswa VALUES
('21001', 'Andi Saputra', 2021, 'Teknik Informatika'),
('22001', 'Budi Santoso', 2022, 'Sistem Informasi'),
('22002', 'Citra Dewi', 2022, 'Teknik Informatika'),
('23001', 'Dewi Lestari', 2023, 'Sistem Informasi'),
('23002', 'Eko Prasetyo', 2023, 'Teknik Informatika'),
('24001', 'Fajar Hidayat', 2024, 'Sistem Informasi'),
('24002', 'Gina Putri', 2024, 'Teknik Informatika'),
('24003', 'Hendra Wijaya', 2024, 'Sistem Informasi'),
('25001', 'Indra Mahendra', 2025, 'Teknik Informatika'),
('25002', 'Joko Purwanto', 2025, 'Sistem Informasi'),
('25003', 'Kiara Sabrina', 2025, 'Teknik Informatika'),
('25004', 'Laura Mala', 2025, 'Sistem Informasi');

INSERT INTO dosen VALUES
(1, 'Dr. Ahmad'),
(2, 'Prof. Budi'),
(3, 'Siti Rahma, M.Kom'),
(4, 'Rudi Hartono, M.T'),
(5, 'Lina Kusuma, M.Kom');

INSERT INTO mata_kuliah VALUES
('MK01', 'Pengantar Basis Data', 3, 1),
('MK02', 'Pemrograman Berbasis Web', 3, 2),
('MK03', 'Desain Manajemen Jaringan', 2, 3),
('MK04', 'Sistem Operasi', 3, 1),
('MK05', 'Algoritma dan Dasar Pemrograman', 2, 2),
('MK06', 'Kecerdasan Buatan', 3, 4),
('MK07', 'Data Mining', 2, 5);

INSERT INTO krs VALUES
(1, '21001', 'MK01', 1),
(2, '22001', 'MK01', 1),
(3, '22001', 'MK02', 2),
(4, '22002', 'MK02', 2),
(5, '23001', 'MK03', 1),
(6, '23002', 'MK04', 3),
(7, '24001', 'MK02', 1),
(8, '24002', 'MK03', 2),
(9, '24003', 'MK01', 3),
(10, '25001', 'MK05', 2),
(11, '25002', 'MK06', 3),
(12, '25003', 'MK07', 1),
(13, '25004', 'MK01', 2);

INSERT INTO nilai VALUES
(1, '21001', 'MK01', 82, 'A'),
(2, '22001', 'MK01', 85, 'A'),
(3, '22001', 'MK02', 78, 'B'),
(4, '22002', 'MK02', 80, 'A'),
(5, '23001', 'MK03', 75, 'B'),
(6, '23002', 'MK04', 88, 'A'),
(7, '24001', 'MK02', 90, 'A'),
(8, '24002', 'MK03', 77, 'B'),
(9, '24003', 'MK01', 84, 'A'),
(10, '25001', 'MK05', 79, 'B'),
(11, '25002', 'MK06', 83, 'A'),
(12, '25003', 'MK07', 76, 'B'),
(13, '25004', 'MK01', 81, 'A');

#soal1
SELECT m.nim, m.nama, n.nilai_angka
FROM mahasiswa m
JOIN nilai n ON m.nim = n.nim
WHERE n.nilai_angka > 
(SELECT AVG(nilai_angka)
FROM nilai
);

#soal2
SELECT kode_mk, nama_mk 
FROM mata_kuliah
WHERE kode_mk IN
(SELECT kode_mk
FROM krs
WHERE nim = (
SELECT nim
FROM mahasiswa
WHERE nama = 'Budi Santoso')
);

#soal3
SELECT nim, nama 
FROM mahasiswa m
WHERE EXISTS
(SELECT *
FROM nilai n
WHERE n.nim = m.nim
);

#soal4
SELECT AVG(nilai_angka) AS rata_rata_nilai
FROM
(SELECT nilai_angka
FROM nilai
WHERE kode_mk IN ('MK01', 'MK02')
) AS sementara;

#soal5
#5A
CREATE VIEW v_transkrip_lengkap AS
SELECT 
    m.nim,
    m.nama AS nama_mahasiswa,
    mk.nama_mk,
    n.nilai_huruf
FROM mahasiswa m
JOIN nilai n ON m.nim = n.nim
JOIN mata_kuliah mk ON n.kode_mk = mk.kode_mk;

#5b
SELECT *
FROM v_transkrip_lengkap
WHERE nilai_huruf = 'A';
