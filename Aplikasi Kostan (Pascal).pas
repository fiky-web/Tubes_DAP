program kostkostan;
 uses crt;

type
  kamar=record
  tipekamar: string;
  kosong,nok: integer;
end;

type
  data=record
   harga: array [1..16] of longint;
   nama:array [1..16] of string;
   umur,hewan: array [1..16]of integer;
   tipekamar1: array [1..16] of string;
end;

var {global}
tabkosong: array [0..16] of kamar;
tabdata: array [0..16] of data;
temp:kamar;
temp1:data;
exit: boolean;
menu,option ,jlh: integer;
a,no,i,j,x,k,max,pass,select,cari3,fin3,new: integer;

baru,cari1,cari2,find1,find2: string;
pil : char;
bill: longint;

procedure butuh_berapa_orang(var T:array of kamar);
var
i: integer;
begin
  for i:=1 to 5 do
  begin
    T[i].tipekamar:='individu';
    T[i].kosong:=1;
    T[i].nok:=i;
  end;

  for i:=6 to 10 do
  begin
    T[i].tipekamar:='pasangan';
    T[i].kosong:=2;
    T[i].nok:=i;
  end;

  for i:=11 to 15 do
  begin
    T[i].tipekamar:='kelompok';
    T[i].kosong:=4;
    T[i].nok:=i;
  end;
end;

function FIND_EMPTY(T:array of kamar;n:integer): integer;
var
i: integer;
begin
  for i:=1 to n do
        begin
    if T[i].tipekamar='individu' then

      FIND_EMPTY:=T[i].kosong
    else if T[i].tipekamar='pasangan' then
      FIND_EMPTY:=T[i].kosong
    else if T[i].tipekamar='kelompok' then
      FIND_EMPTY:=T[i].kosong
    else
      FIND_EMPTY:=0;
                        end;
end;
function biaya(tot:integer):longint;

begin
  if tabkosong[no].tipekamar='individu' then
     biaya:= ((tot*50000) + 200000)
  else if tabkosong[no].tipekamar='pasangan' then
    biaya:= ((tot*50000) + (150000))
  else
    biaya:= ((tot*50000) + (100000));
end;
procedure datadiri(var T:array of data;var sum: integer; n,a:integer);
var

j,i:integer;

begin
 tabkosong[n].kosong:=tabkosong[n].kosong-a;
begin
  for j:=1 to a do
  begin
      write('nama: ');
      readln(T[n].nama[j]);
      write('umur: ');
      readln(T[n].umur[j]);
      write('jumlah hewan: ');
      readln(T[n].hewan[j]);
      T[n].harga[j]:= biaya(T[n].hewan[j]);
      T[n].tipekamar1[j]:=tabkosong[n].tipekamar;
  end;



end;
end;


function jumlah_biaya(i:integer): longint;
begin

      jumlah_biaya:=(tabdata[i].harga[1]+tabdata[i].harga[2]+tabdata[i].harga[3]+tabdata[i].harga[4]);

end;

 procedure perkenalan;
 begin
        writeln('================================');
		    writeln('||Nama : DENI SAPUTRA HERMAWAN||');
        writeln('||Kelas: IT-42-03             ||');
        writeln('||Nim  : 1303180074           ||');
        writeln('================================');
        writeln;
 end;

procedure judul;
begin
  writeln('===============================================');
	writeln('||        USAHA KOSTAN "KOSTAN SUKA SUKA"    ||');
	writeln('||            jl.Simcity Abadi 1             ||');
	writeln('||                  Simcity                  ||');
	writeln('===============================================');
        writeln;
        writeln;
end;
procedure sorting(option:integer; var T:array of data; Tab:array of kamar);
var
pass,max,j: integer;
begin
   if option= 1 then
       for pass:=1 to 4 do
         begin
            max:=pass;
         for j:=pass+1 to 5 do
            if (tabdata[j].umur[1]>tabdata[max].umur[1]) then
               max:=j;
            temp:=tabkosong[max];
              temp1:=tabdata[max];
            tabkosong[max]:=tabkosong[pass];
              tabdata[max]:=tabdata[pass];
            tabkosong[pass]:=temp;
              tabdata[pass]:=temp1;
        end

   else if option=2 then
       for pass:=1 to 4 do
         begin
            max:=pass;
         for j:=pass+1 to 5 do
            if (tabdata[j].harga[1]>tabdata[max].harga[1]) then
               max:=j;
            temp:=tabkosong[max];
              temp1:=tabdata[max];
            tabkosong[max]:=tabkosong[pass];
              tabdata[max]:=tabdata[pass];
            tabkosong[pass]:=temp;
              tabdata[pass]:=temp1;
       end

       else if option=4 then
       for pass:=6 to 9 do
         begin
            max:=pass;
         for j:=pass+1 to 10 do
            if (jumlah_biaya(j)>jumlah_biaya(max)) then
               max:=j;
            temp:=tabkosong[max];
              temp1:=tabdata[max];
            tabkosong[max]:=tabkosong[pass];
              tabdata[max]:=tabdata[pass];
            tabkosong[pass]:=temp;
              tabdata[pass]:=temp1;
       end

       else if option=5 then
       for pass:=11 to 14 do
         begin
            max:=pass;
         for j:=pass+1 to 15 do
            if (jumlah_biaya(j)>jumlah_biaya(max)) then
               max:=j;
            temp:=tabkosong[max];
              temp1:=tabdata[max];
            tabkosong[max]:=tabkosong[pass];
              tabdata[max]:=tabdata[pass];
            tabkosong[pass]:=temp;
              tabdata[pass]:=temp1;
       end;
end;
procedure list_data();
  begin
    writeln('/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\');
    writeln('| NOMOR KAMAR | UMUR | JUMLAH HEWAN | TIPE KAMAR |    BIAYA   | NAMA           |');
    writeln('================================================================================');
  end;

procedure PENGISIAN_DATA();
  begin
  writeln('Ketentuan kamar: ');
  writeln('1.individu untuk 1 orang, kamar nomor 1-5.');
  writeln('2.pasangan untuk 2 orang, kamar nomor 6-10');
  writeln('3.kelompok untuk 4 orang, kamar nomor 11-15');
  write('pilih nomor kamar: ');
  readln(no);
    while (tabkosong[no].kosong=0) do
       if (tabkosong[no].kosong=0) then
        begin
           writeln('kamar penuh');
           write('pilih nomor lain: ');
           readln(no);
        end;
   if (tabkosong[no].kosong>0) then
   begin
    write('masukkan jumlah orang (harus sesuai kapasitas kamar): ');
    readln(a);
    datadiri(tabdata,jlh,no,a);
    end;
    write('Tekan enter untuk kembali ke menu awal.');
    readln;
end;

procedure MENAMPILKAN_DATA();
begin

  writeln('1.individu');
    writeln('2.pasangan');
    writeln('3.kelompok');
    write('pilih tipe kamar yang ingin di cek: ');
    readln(pil);
    list_data;
  case pil of
  '1': begin
        for i:=1 to 5 do
          if tabkosong[i].kosong=0 then
          BEGIN     {| NOMOR KAMAR | UMUR | JUMLAH HEWAN | TIPE KAMAR |    BIAYA   | NAMA           '}
            writeln('| ',tabkosong[i].nok,'           | ',tabdata[i].umur[1],'   |       ',tabdata[i].hewan[1],'      | ', tabdata[i].tipekamar1[1],'   | RP ', tabdata[i].harga[1],'   | ', tabdata[i].nama[1]);
            writeln('|             |      |              |            |            |                ');
          end;

           if (tabkosong[1].kosong=0) and (tabkosong[2].kosong=0)  and (tabkosong[3].kosong=0) and (tabkosong[4].kosong=0) and (tabkosong[5].kosong=0) then
           begin
        writeln('Data suda penuh maka silahkan tekan: ');
       writeln('1.Sorting berdasarkan umur');
       writeln('2.Sorting berdasarkan biaya. ');
       writeln('3.Jika sudah melakukan sorting atau skip');
        readln(select);
        sorting(select,tabdata,tabkosong);
        sorting(select,tabdata,tabkosong);
          end;
  end;

 '2': begin
        for i:=6 to 10 do
          if tabkosong[i].kosong=0 then
          begin
           a:=2;
            for j:=1 to a do
            begin
               writeln('| ',tabkosong[i].nok,'           | ',tabdata[i].umur[j],'   |       ',tabdata[i].hewan[j],'      | ', tabdata[i].tipekamar1[j],'   | RP ', tabdata[i].harga[j],'   | ', tabdata[i].nama[j]);
            end;
               writeln('total biaya: Rp ',jumlah_biaya(i));

           end;

        if (tabkosong[6].kosong=0) and (tabkosong[7].kosong=0)  and (tabkosong[8].kosong=0) and (tabkosong[9].kosong=0) and (tabkosong[10].kosong=0) then
           begin
        writeln('Data suda penuh maka silahkan tekan kode: ');
       writeln('4.Sorting berdasarkan total biaya');
       writeln('3.Jika sudah melakukan sorting atau skip');
        readln(select);
        sorting(select,tabdata,tabkosong);
        end;

  end;

  '3': begin
        for i:=11 to 15 do
          if (tabkosong[i].kosong=0) or (tabkosong[i].kosong=1) then
          begin
            a:=4;
              for j:=1 to a do
              begin
               writeln('| ',tabkosong[i].nok,'           | ',tabdata[i].umur[j],'   |       ',tabdata[i].hewan[j],'      | ', tabdata[i].tipekamar1[j],'   | RP ', tabdata[i].harga[j],'   | ', tabdata[i].nama[j]);
            end;
                writeln('total biaya: Rp ',jumlah_biaya(i));

           end;

        if (tabkosong[11].kosong=0) and (tabkosong[12].kosong=0)  and (tabkosong[13].kosong=0) and (tabkosong[14].kosong=0) and (tabkosong[15].kosong=0) then
           begin
        writeln('Data suda penuh maka silahkan tekan kode: ');
       writeln('5.Sorting berdasarkan total biaya');
       writeln('3.Jika sudah melakukan sorting atau skip');
        readln(select);
        sorting(select,tabdata,tabkosong);
        end;



  end;

  end;
    write('Tekan enter untuk kembali ke menu awal.');
    readln;
END;


procedure EDIT_DATA();
begin
  write('tipe kamar yang ingin dicari: ');
        readln(cari1);
        write('nama penghuni yang ingin diedit: ');
        readln(cari2);
        write('umur penghuni yang ingin diedit: ');
        readln(cari3);

      for i:=1 to 15 do
      begin
        for j:=1 to 4 do
            begin
            if (tabdata[i].nama[j]=cari2) and (tabdata[i].umur[j]=cari3) and ( tabkosong[i].tipekamar=cari1) then
              writeln(tabdata[i].nama[j],' ',tabdata[x].tipekamar1[j],' ',tabdata[i].umur[j]);
              end;
      end;

        write('edit nama: ');
        readln(baru);
        write('edit umur: ');
        readln(new);

         for i:=1 to 15 do
      begin
        for j:=1 to 4 do
            begin
            if (tabdata[i].nama[j]=cari2) and (tabdata[i].umur[j]=cari3) and ( tabkosong[i].tipekamar=cari1) then
            begin
              tabdata[i].nama[j]:=baru;
              tabdata[i].umur[j]:=new;
            end;
              end;
         end;
END;

procedure DELETE_DATA();
begin
  write('Menghapus data penghuni kamar sesuai tipe.');
write('tipe kamar yang ingin dihapus: ');
        readln(find1);
        write('nama penghuni yang ingin dihapus: ');
        readln(find2);
        write('umur penghuni yang ingin dihapus: ');
        readln(fin3);

      for i:=1 to 5 do
      begin
        for j:=1 to 4 do
            begin
            if (tabdata[i].nama[j]=find2) and (tabdata[i].umur[j]=fin3) and ( tabkosong[i].tipekamar=find1) then
              tabkosong[i].kosong:=1;
              end;
      end;

      for i:=6 to 10 do
      begin
        for j:=1 to 4 do
            begin
            if (tabdata[i].nama[j]=find2) and (tabdata[i].umur[j]=fin3) and ( tabkosong[i].tipekamar=find1) then
              tabkosong[i].kosong:=2;
              end;
      end;

      for i:=11 to 15 do
      begin
        for j:=1 to 4 do
            begin
            if (tabdata[i].nama[j]=find2) and (tabdata[i].umur[j]=fin3) and ( tabkosong[i].tipekamar=find1) then
              tabkosong[i].kosong:=4;
              end;
      end;

      writeln('Data telah dihapus');
END;

procedure PERATURAN();
BEGIN
  writeln('Ketentuan harga kamar');
  writeln('1.individu');
  writeln('  Maksimal 1 orang tiap kamar dengan harga tiap orang Rp 200.000 + (Jumlah hewan x Rp 50.000)');
  writeln('2.pasangan');
  writeln('  Maksimal 2 orang tiap kamar dengan harga tiap orang Rp 150.000 + (Jumlah hewan x Rp 50.000)');
  writeln('3.kelompok');
  writeln('  Berjumlah 3-4 orang tiap kamar dengan harga tiap orang Rp 100.000 + (Jumlah hewan x Rp 50.000)');

  writeln;
  write('Tekan enter untuk kembali ke menu awal');
  readln;

END;

BEGIN
        perkenalan;
        butuh_berapa_orang(tabkosong);
        exit:=false;
    while not exit do
      begin
  judul;
  writeln('/   APLIKASI PENGOLAHAN DATA KOSTAN SUKA SUKA   \');
  writeln;
  writeln('--------------------- MENU ----------------------');
  writeln('*************************************************');
  writeln('|1. PENGISIAN DATA PENGHUNI BARU                |');
  writeln('|2. MENAMPILKAN DATA PENGHUNI                   |');
  writeln('|3. MENCARI DAN MEMPERBARUI DATA PENGHUNI KOSTAN|');
  writeln('|4. MENGHAPUS DATA PENGHUNI KOSTAN              |');
  writeln('|5. PERATURAN                                   |');
  writeln('|6. EXIT                                        |');
  writeln('*************************************************');
  writeln;
write('Pilih menu yang anda butuh = ');
readln(menu);
  clrscr;
case menu of
1: begin
    PENGISIAN_DATA;
end;

2:begin
    MENAMPILKAN_DATA;
end;

3: begin
    EDIT_DATA;
end;

4: begin
    DELETE_DATA;
end;

5: begin
    PERATURAN;
end;

6: begin
  exit:=true;
  writeln('=================================');
  writeln('|         TERIMA KASIH          |');
  writeln('|PROGRAM APLIKASI TELAH BERAKHIR|');
  writeln('=================================');
  
end;

   END{end case};
   END{end setelah while};
readln;
END.


