program AplikasiTubes;
uses crt;

const
  KUOTA = 100;
  DataFile = 'DataKeluarga.dat';

type 
  keluarga = record
        noKK : integer;
        nama: string;
        jumlah: integer;
        pndptn: real;
        disabilitas : integer;
        Blt : real;
end;

type

daftarKeluarga = array [1..KUOTA] of keluarga;

var
  pilih : byte;
  jumlahKeluarga : integer;
  keluargaTerdaftar : daftarKeluarga;
  DA : file of keluarga;

procedure saveData;
  var
    i : integer;
  begin
    assign(DA, DataFile);
    rewrite(DA);
    for i := 1 to KUOTA do
      write(DA, keluargaTerdaftar[i]);
    close(DA);
  end;

procedure loadData;

  begin
    assign(DA, DataFile);
    reset(DA);
    while not (eof(DA)) do
      begin
        inc(jumlahKeluarga);
        read(DA, keluargaTerdaftar[jumlahKeluarga]);
        if (keluargaTerdaftar[jumlahKeluarga].nama = '') then
        dec(jumlahKeluarga);
      end;
    close(DA);
  end;

function carinokeluarga (noKK : integer) : integer;
  var
    i : integer;
    IDfound : integer;
  begin
    IDfound := 0;
    for i := 1 to jumlahKeluarga do
      begin
        if (keluargaTerdaftar[i].noKK = noKK) then
          IDfound := i;
      end;
    carinokeluarga := IDfound;
  end;

function bubbleSort(arr : daftarKeluarga; field : string; descending : boolean) : daftarKeluarga;
  var i, j: integer;
      tmp: Keluarga;
      comparison: boolean;
  begin
    FOR i := jumlahKeluarga - 1 DOWNTO 1 DO
      FOR j := 1 TO i DO
        begin
          if (descending) then
            begin
              case field of
                'pendapatan': comparison := (arr[j].pndptn > arr[j + 1].pndptn);
                'BLT': comparison := (arr[j].Blt > arr[j + 1].Blt);  
              end;
            end
          else
            begin
              case field of
                'pendapatan': comparison := (arr[j].pndptn < arr[j + 1].pndptn);
                'BLT': comparison := (arr[j].pndptn > arr[j + 1].Blt);
              end;
            end;
          IF (comparison) THEN BEGIN
              tmp := arr[j];
              arr[j] := arr[j + 1];
              arr[j + 1] := tmp;
          END;
        end;
    bubbleSort := arr;
  end;




procedure InputKeluarga;

var
    indeksKotakYangKosong : integer;
    
begin
    clrscr;
    writeln('=======================================');
    writeln('         MASUKAN Data Keluarga         ');
    Writeln('=======================================');
    writeln('');
    indeksKotakYangKosong := jumlahKeluarga + 1;
    keluargaTerdaftar[indeksKotakYangKosong].noKK := indeksKotakYangKosong;
    write('1. NAMA Kepala Keluarga: ');
    readln(keluargaTerdaftar[indeksKotakYangKosong].Nama);
    write('2. Jumlah Anggota Keluarga: ');
    readln(keluargaTerdaftar[indeksKotakYangKosong].jumlah);
    write('3. pendapatan (/Bulan: ');
    readln(keluargaTerdaftar[indeksKotakYangKosong].pndptn);
    write('4. Jumlah Disabilitas: ');
    readln(keluargaTerdaftar[indeksKotakYangKosong].disabilitas);    
begin
      
     if(keluargaTerdaftar[indeksKotakYangKosong].disabilitas > 0) and (keluargaTerdaftar[indeksKotakYangKosong].pndptn/keluargaTerdaftar[indeksKotakYangKosong].jumlah < 100000) then
       keluargaTerdaftar[indeksKotakYangKosong].Blt := 300000 * keluargaTerdaftar[indeksKotakYangKosong].disabilitas
     else
       keluargaTerdaftar[indeksKotakYangKosong].Blt := 0;
end;



    jumlahKeluarga := jumlahKeluarga + 1;
    saveData();
end;


procedure TampilkanKeluarga;

var
  i : integer;

  begin
      clrscr;
      for i := 1 to jumlahKeluarga  do
      begin
      writeln('========== Data Keluarga KE-', i , ' ======================');
      writeln('1. No Kartu Keluarga: ', keluargaTerdaftar[i].noKK);
      writeln('2. NAMA Kepala Keluarga: ', keluargaTerdaftar[i].Nama);
      writeln('3. Jumlah Anggota Keluarga: ', keluargaTerdaftar[i].jumlah);
      writeln('4. pendapatan (/Bulan): ', keluargaTerdaftar[i].pndptn:10:0);
      writeln('5. Jumlah Disabilitas: ', keluargaTerdaftar[i].disabilitas);
      writeln('6. Blt yang didapat:   ', keluargaTerdaftar[i].Blt:10:0); 
      writeln();
  end;
   write('Silahkan tekan enter untuk kembali ke menu');
  readkey();
end;


procedure pengurutanData();

var 
  dataTerurut : daftarKeluarga;
  pil, i : integer;

begin
  clrscr;
  writeln('==================================================================');
  writeln('||                    urutkan data sesuai :                     ||');
  writeln('||==============================================================||');
  writeln('||  1. Urutkan data sesuai pendapatan terkecil                  ||');
  writeln('||  2. Urutkan data sesuai pendapatan terbesar                  ||');
  writeln('||  3. Urutkan data sesuai BLT(bantuan tunai langsung) terkecil ||');
  writeln('||  4. Urutkan data sesuai BLT(bantuan tunai langsung) terbesar ||');
  writeln('=================================================================');
  write('PILIHAN MENU ANDA: ');
  readln(pil);

  case pil of
    1: dataTerurut := bubbleSort(keluargaTerdaftar, 'pendapatan', false);
    2: dataTerurut := bubbleSort(keluargaTerdaftar, 'pendapatan', true);
    3: dataTerurut := bubbleSort(keluargaTerdaftar, 'BLT'       , false);
    4: dataTerurut := bubbleSort(keluargaTerdaftar, 'BLT'       , true);
  end;

    for i := 1 to jumlahKeluarga do
      begin
        clrscr;
        writeln('=========== Data Keluarga-', i , ' ==========');
        writeln('|NO KK  : ', dataTerurut[i].noKK);
        writeln('|NAMA KEPALA Keluarga : ', dataTerurut[i].nama);
        writeln('|Jumlah Anggota Keluarga : ',dataTerurut[i].jumlah);
        writeln('|pendapatan : ', dataTerurut[i].pndptn:10:0);
        writeln('|Jumlah disabilitas : ',dataTerurut[i].disabilitas);
        writeln('|Blt : ', dataTerurut[i].Blt:10:0);
        writeln();
      end;

      write('Silahkan tekan enter untuk kembali ke menu');
      readkey();
end;
  
 
  


procedure caridataKeluarga;
  var
    found : boolean;
    cari : integer;
    lagi : char;
    i : integer;
  begin
    lagi := 'y';
    while upcase(lagi) = 'Y' do
      begin
      clrscr;
      found := false;
      gotoxy(1,1);writeln('================');
      gotoxy(1,3);writeln('================');
      gotoxy(21,1);writeln('========');
      gotoxy(21,3);writeln('========');
      gotoxy(1,2);write('| Masukkan no Kk|=>> |              |');
      gotoxy(25,2);readln(cari);
      writeln;
        for i := 1 to jumlahKeluarga do
        begin
        if (keluargaTerdaftar[i].noKK = cari) then
          begin
            found := true;
            writeln('Berikut data yang ditemukan : ');
            writeln;
            writeln('No KK   : ', keluargaTerdaftar[i].noKK);
            writeln('Nama Kepala Keluarga : ', keluargaTerdaftar[i].nama);
            writeln('pendapatan (/Bulan)  : ', keluargaTerdaftar[i].pndptn:10:0);
            writeln('Jumlah Disabilitas   : ', keluargaTerdaftar[i].disabilitas);
          end;
        end;
        if not found then
        writeln('No KK tidak ditemukan!');
        writeln;
        writeln;
        write('Ingin Mencari Lagi ? (Y/T) : ');
        readln(lagi);
      end;
  end;

procedure isiData (var databarukeluarga : keluarga; datakeluargaAsal : keluarga );
  begin

    write('Nama Kepala Keluarga  : ');
    readln(databarukeluarga.nama);
    if (databarukeluarga.nama = '') then
      databarukeluarga.nama := datakeluargaAsal.nama;
    
    write('pendapatan       : ');
    readln(databarukeluarga.pndptn);
   

    write('Jumlah Disabilitas       : ');
    readln(databarukeluarga.disabilitas);

  end;
    

procedure perbaruiData;

  var
    noKK : integer;
    index : integer;
    dataBaru : keluarga;
  begin
    clrscr;
    writeln;
      gotoxy(1,1);writeln('================');
      gotoxy(1,3);writeln('================');
      gotoxy(21,1);writeln('========');
      gotoxy(21,3);writeln('========');
      gotoxy(1,2);write('| Masukkan no Kk|=>> |              |');
      gotoxy(25,2);readln(noKK);
    index := carinokeluarga(noKK);
    if (index > 0 ) then
      begin
        writeln;
        dataBaru := keluargaTerdaftar[index];
        writeln('Silahkan Perbarui Data Anda (*Kosongi jika tidak ingin diubah*) ');
        writeln;
        isiData(dataBaru, dataBaru);
        keluargaTerdaftar[index] := dataBaru;
        writeln;
        writeln('Data Berhasil Diperbarui!');
        saveData();
      end
    else
      writeln('noKK tidak ditemukan!');
  end;

procedure hapusData;
  var
    noKK : integer;
    index : integer;
    i : integer;
  begin
    clrscr;
    writeln;
      gotoxy(1,1);writeln('================');
      gotoxy(1,3);writeln('================');
      gotoxy(21,1);writeln('========');
      gotoxy(21,3);writeln('========');
      gotoxy(1,2);write('| Masukkan no Kk|=>> |              |');
      gotoxy(25,2);readln(noKK);
    index := carinoKeluarga(noKK);
    if (index <> 0) then
      begin
        for i := index + 1 to KUOTA - 1 do
          keluargaTerdaftar[i - 1] := keluargaTerdaftar[i];
          keluargaTerdaftar[jumlahKeluarga] := default(keluarga);
          jumlahKeluarga := jumlahKeluarga - 1;
          writeln;
          writeln('Penghapusan BERHASIL!');
          saveData();
        end
      else
        writeln('noKK tidak ditemukan!');
  end;

begin
  jumlahKeluarga := 0;
  loadData();
  while true do
begin
    clrscr;
    writeln('');
    writeln('                            ======================\\\\\\//////=====================');
    writeln('                            ||                    SELAMAT DATANG                 ||');
    writeln('                            ||                 APLIKASI RUKUN TETANGGA           ||');
    writeln('                            ||***************************************************||');
    writeln('                            ||  C R E A T E D   BY   FIKY ANGGARA|1303180015     ||');
    writeln('                            ======================//////\\\\\\=====================');
    writeln;
    writeln;
    writeln('                                    ================ MENU =================');
    writeln('                                    =======================================');
    writeln('                                    || 1. Masukkan Data Keluarga         ||');
    writeln('                                    || 2. Tampilkan Data Keluarga        ||');
    writeln('                                    || 3. list Data Keluarga             ||');
    writeln('                                    || 4. Cari Data Keluarga             ||');
    writeln('                                    || 5. Update Data Keluarga           ||');
    writeln('                                    || 6. Hapus Data                     ||');
    writeln('                                    || 0. Keluar Program                 ||');
    writeln('                                    =======================================');
  pilih := 0;
  while (pilih < 1 ) do
    begin
        writeln;
        write('                                          PILIHAN MENU ANDA: ');
        readln(pilih);
        case pilih of
          1 : begin
              clrscr;
              InputKeluarga;
              end;
          2 : begin
              TampilkanKeluarga;
              end;
          3:  begin
              pengurutanData();
              readln;
              end;
              4 : caridataKeluarga();
              5 : begin
                  perbaruiData();
                  writeln;
                  writeln;
                  writeln;
                  write('Tekan enter untuk kembali ke MENU');
                  readln;
                end;
              6 : begin
                  hapusData();
                  writeln;
                  writeln;
                  writeln;
                  write('Tekan enter untuk kembali ke MENU');
                  readln;
                  end;
              0 : exit;
            end;
         end;
     end;
end.