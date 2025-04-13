# 💸 Expensage

| Name                   | NRP        |
| ---------------------- | ---------- |
| Ardhika Krishna Wijaya | 5025221006 |

## 👣 Steps 
> ### Pendahuluan
  - Expensage adalah gabungan dari kata *expense* dan *manage* yaitu aplikasi pencatat pengeluaran sederhana yang dibangun menggunakan Flutter dan sqflite sebagai database lokal. Menggunakan sqflite memungkinkan untuk melakukan penyimpanan data secara lokal tanpa memerlukan koneksi internet.
    
> ### Instalisasi Sqflite
  - Untuk menggunakan sqflite, tambahkan dependensi sqflite dan path ke pubspec.yaml:
  ![image](https://github.com/user-attachments/assets/958f69e7-a3c2-4675-aa3f-c69e443dc190)

> ### Membuat Model Expense
  - Membuat model
  ![image](https://github.com/user-attachments/assets/80bc5c94-a474-4c02-8715-dc83de71a002)
  - Membuat nama tabel, nama kolom, dan tipe data
  ![image](https://github.com/user-attachments/assets/011ee68c-537a-4a2f-89cf-66021a2f7d89)
  - `toMap`: Mengubah objek menjadi format yang bisa disimpan ke database
  - `fromMap`: Mengonversi data dari database ke dalam objek Dart.
  ![image](https://github.com/user-attachments/assets/253dd615-18a4-4b7d-bfa9-8e136bd273e5)
  - Membuat method copywith
  ![image](https://github.com/user-attachments/assets/c0b5d9ac-f15b-4d94-9eee-277cbae84207)
  - Cek tipe data SQL -> `https://sqlite.org/datatype3.html`
    
> ### Menyiapkan Database Service
  - Inisialisasi database dan membuat tabel
  ![image](https://github.com/user-attachments/assets/7c1c1c29-e80e-4431-bcec-67f231508ba4)

  - CRUD (Create, Read, Update, Delete)
  ![image](https://github.com/user-attachments/assets/8dcba1d2-5d86-4c89-9d5b-9609b4085185)

> ### Menggunakan Database di UI
  - Menampilkan Data di HomePage
  ![image](https://github.com/user-attachments/assets/95014e8f-902f-42f2-ad20-093497d48c25)
  ![image](https://github.com/user-attachments/assets/6c04888a-f629-472c-9e35-c8fe6472b5ff)

  - Menambahkan Data dari UI
  ![image](https://github.com/user-attachments/assets/c0885d3f-a4b0-4508-a663-d7a7d2643699)

  - Menghapus Data dari UI
  ![image](https://github.com/user-attachments/assets/d9700e0c-37b1-4f4b-8fda-b7a956f1fec6)
  ![image](https://github.com/user-attachments/assets/1e3c7490-f795-4c59-b6ac-12d3026dbc0e)
  ![image](https://github.com/user-attachments/assets/56602dfb-b34e-447c-9a77-0b7c60cb491a)

  - Mengedit Data
  ![image](https://github.com/user-attachments/assets/6e27175a-0c46-4ffc-a169-f07852316dd2)

> ### Kesimpulan
- Dengan menggunakan sqflite, kita dapat menyimpan, membaca, memperbarui, dan menghapus data secara lokal di aplikasi Flutter. Jika menyimpan data hanya di dalam list (variabel biasa di memori) tanpa menggunakan database atau local storage lainnya, maka datanya akan hilang begitu aplikasi ditutup atau direstart. Namun dengan menggunakan SQLite ini data akan tetap tersimpan meskipun aplikasi ditutup, sehingga ketika aplikasi dibuka kembali, data yang tersimpan sebelumnya akan tetap tampil dan tidak hilang. 

## 📱 Documentation
<table>
  <tr align="center">
    <th>Splash Screen</th>
    <th>Home Page</th>
    <th>Drawer</th>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/af1444e9-d7f3-4eef-8eae-b9e23af3a5a7" alt="Splash Screen" width="250"></td>
    <td><img src="https://github.com/user-attachments/assets/e735c721-1077-4b91-bb65-b268678601e2" alt="Home Page" width="250"></td>
    <td><img src="https://github.com/user-attachments/assets/31ae6b50-1914-48f2-b6eb-0c052ea812e4" alt="Drawer" width="250"></td>

  </tr>
    <tr align="center">
    <th>Add Expense</th>
    <th>Edit/Delete</th>
    <th>Edit Expense</th>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/3f0737b8-7112-4266-b26d-a9dfe64ad679" alt="Add Form" width="250"></td>
    <td><img src="https://github.com/user-attachments/assets/27dc3b58-c818-442b-8107-7bb86e01ebc6" alt="Edit/Delete" width="250"></td>
    <td><img src="https://github.com/user-attachments/assets/97038c51-18c9-48f7-a390-59e73693b057" alt="Edit Form" width="250"></td>
  </tr>
</table>

## 📌 References
- https://www.youtube.com/watch?v=bihC6ou8FqQ
- https://docs.flutter.dev/cookbook/persistence/sqlite
- https://www.youtube.com/watch?v=pFctmsTDoa0


