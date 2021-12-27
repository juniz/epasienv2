import 'dart:io';
import 'dart:typed_data';

import 'package:epasien/app/modules/surat_sakit/models/LIstSuratNarkobaModel.dart';
import 'package:epasien/app/modules/surat_sakit/models/SuratKontrolModel.dart';
import 'package:epasien/app/modules/surat_sakit/models/SuratRujukanModel.dart';
import 'package:epasien/app/modules/surat_sakit/models/surat_sakit_model.dart';
import 'package:epasien/app/modules/surat_sakit/providers/surat_bebas_narkoba_provider.dart';
import 'package:epasien/app/modules/surat_sakit/providers/surat_kontrol_provider.dart';
import 'package:epasien/app/modules/surat_sakit/providers/surat_rujukan_provider.dart';
import 'package:epasien/app/modules/surat_sakit/providers/surat_sakit_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SuratSakitController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement SuratSakitController
  final rumkit = GetStorage().read('rumkit');
  final pasien = GetStorage().read('pasien');
  SuratKontrolProvider _suratKontrolProvider =
      GetInstance().put(SuratKontrolProvider());
  SuratBebasNarkobaProvider _suratSKBNProvider =
      GetInstance().put(SuratBebasNarkobaProvider());
  SuratSakitProvider _suratSakaitProvider =
      GetInstance().put(SuratSakitProvider());
  SuratRujukanProvider _suratRujukanProvider =
      GetInstance().put(SuratRujukanProvider());
  var listSuratSakit = <SuratSakitModel>[].obs;
  var listSuratNarkoba = <ListSuratNarkobaModel>[].obs;
  var listSuratKontrol = <SuratKontrolModel>[].obs;
  var listSuratRujukan = <SuratRujukanModel>[].obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    _suratSakaitProvider
        .fetchSuratSakit({'no_rkm_medis': pasien['no_rkm_medis']}).then(
      (value) => listSuratSakit.value = value,
    );
    _suratSKBNProvider
        .fetchListSuratNarkoba({'no_rkm_medis': pasien['no_rkm_medis']}).then(
      (value) => listSuratNarkoba.value = value,
    );
    _suratKontrolProvider
        .fetchSuratKontrol({'no_rkm_medis': pasien['no_rkm_medis']}).then(
      (value) => listSuratKontrol.value = value,
    );
    _suratRujukanProvider
        .fetchSuratSakit({'no_rkm_medis': pasien['no_rkm_medis']}).then(
      (value) => listSuratRujukan.value = value,
    );
    super.onReady();
  }

  @override
  void onClose() {}

  void suratSKBN(String noSurat) async {
    final data =
        await _suratSKBNProvider.fetchDataSuratNarkoba({'no_surat': noSurat});
    final barcode =
        await _suratSakaitProvider.fetchBarcode({'nik': data.kdDokter});
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text(
                  'SURAT KETERANGAN',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'HASIL PEMERIKSAAN URINE PENGGUNA NARKOBA',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'NOMOR : ${noSurat}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 15),
              pw.Table(
                columnWidths: {
                  0: pw.FractionColumnWidth(.05),
                  1: pw.FractionColumnWidth(.6),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('1.'),
                      pw.Column(
                        children: [
                          pw.Text(
                            'Yang bertanda tangan dibawah ini saya ${data.nmDokter}, pada ${rumkit['rumkit']} menerangkan bahwa telah melakukan wawancara, pemeriksaan fisik dan pemeriksaan laboratorium terhadap pasien dengan keterangan sebagai berikut :',
                            textAlign: pw.TextAlign.justify,
                          ),
                          pw.SizedBox(height: 15),
                          pw.Table(
                            columnWidths: {
                              0: pw.FractionColumnWidth(.05),
                              1: pw.FractionColumnWidth(.2),
                              2: pw.FractionColumnWidth(.02),
                              3: pw.FractionColumnWidth(.5),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text('a.'),
                                  pw.Text('Nama'),
                                  pw.Text(':'),
                                  pw.Text(data.nmPasien!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('b.'),
                                  pw.Text('Tempat, Tgl. lahir'),
                                  pw.Text(':'),
                                  pw.Text(
                                      data.tmpLahir! + ', ' + data.tglLahir!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('c.'),
                                  pw.Text('Agama'),
                                  pw.Text(':'),
                                  pw.Text(data.agama!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('d.'),
                                  pw.Text('Jenis Kelamin'),
                                  pw.Text(':'),
                                  pw.Text(data.jk!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('e.'),
                                  pw.Text('Suku Bangsa'),
                                  pw.Text(':'),
                                  pw.Text(data.namaSukuBangsa!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('f.'),
                                  pw.Text('Pekerjaan'),
                                  pw.Text(':'),
                                  pw.Text(data.pekerjaan!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('g.'),
                                  pw.Text('Alamat'),
                                  pw.Text(':'),
                                  pw.Text(data.alamat!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('h.'),
                                  pw.Text('Dipergunakan'),
                                  pw.Text(':'),
                                  pw.Text(data.keperluan!)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.SizedBox(height: 15),
                      pw.SizedBox(height: 15),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('2.'),
                      pw.Column(
                        children: [
                          pw.Text(
                            'Berdasarkan pemeriksaan Fisik dan pemeriksaan Urine dengan menggunakan alat ANSWER yang dilaksanakan pada hari/tanggal ${data.tanggalsurat}, bahwa pada saat pemeriksaaan didapatkan hasil sebagai berikut :',
                            textAlign: pw.TextAlign.justify,
                          ),
                          pw.SizedBox(height: 15),
                          pw.Table(
                            columnWidths: {
                              0: pw.FractionColumnWidth(.05),
                              1: pw.FractionColumnWidth(.2),
                              2: pw.FractionColumnWidth(.02),
                              3: pw.FractionColumnWidth(.5),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text('a.'),
                                  pw.Text('Opiat / Morphin'),
                                  pw.Text(':'),
                                  pw.Text(data.opiat!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('b.'),
                                  pw.Text('Ganja / Canabis'),
                                  pw.Text(':'),
                                  pw.Text(data.ganja!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('c.'),
                                  pw.Text('Amphetamin'),
                                  pw.Text(':'),
                                  pw.Text(data.amphetamin!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('d.'),
                                  pw.Text('Methamphetamin'),
                                  pw.Text(':'),
                                  pw.Text(data.methamphetamin!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('e.'),
                                  pw.Text('Benzodiazepin'),
                                  pw.Text(':'),
                                  pw.Text(data.benzodiazepin!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('f.'),
                                  pw.Text('Cocain'),
                                  pw.Text(':'),
                                  pw.Text(data.cocain!)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.SizedBox(height: 15),
                      pw.SizedBox(height: 15),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('3.'),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('KESIMPULAN :'),
                          pw.Text(
                            'Pada saat pemeriksaan orang ini yang berdasarkan wawancara, pemeriksaan fisik dan pemeriksaan laboratorium urinnya, tidak ditemukan tanda dari intoksikasi dan atau ketergantungan penggunaan narkoba. Demikian surat keterangan ini dibuat agar yang berkepentingan menjadi maklum.',
                            textAlign: pw.TextAlign.justify,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('Pemohon'),
                      pw.SizedBox(height: 70),
                      pw.Text(data.nmPasien!)
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('${rumkit['kota']}, ${data.tanggalsurat}'),
                      pw.Text(rumkit['rumkit']),
                      pw.Text('Dokter,'),
                      pw.SizedBox(height: 10),
                      pw.BarcodeWidget(
                        data: barcode.body['sidikjari'],
                        barcode: pw.Barcode.qrCode(),
                        width: 100,
                        height: 100,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        '( ${data.nmDokter} )',
                        style: pw.TextStyle(
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    Uint8List bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/surat_SKBN.pdf');
    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  void suratSakitPDF(String noSurat) async {
    final dataSurat =
        await _suratSakaitProvider.fetchDataSuratSakit({'no_surat': noSurat});
    final barcode =
        await _suratSakaitProvider.fetchBarcode({'nik': dataSurat.kdDokter});
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Center(
                  child: pw.Text(
                    'SURAT KETERANGAN SAKIT',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    noSurat,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Divider(thickness: 1),
                pw.SizedBox(height: 15),
                pw.Text(
                  'Yang bertanda tangan di bawah ini ${dataSurat.nmDokter}, dokter pada ${rumkit['rumkit']} menerangkan bahwa :',
                  textAlign: pw.TextAlign.justify,
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 15),
                pw.Table(
                  columnWidths: {0: pw.FractionColumnWidth(.3)},
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Nama Pasien',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          ': ',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          dataSurat.nmPasien!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Umur',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          ': ',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          dataSurat.umur!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Jenis Kelamin',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          ': ',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          dataSurat.jk!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Pekerjaan',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          ': ',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          dataSurat.pekerjaan!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Alamat',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          ': ',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          dataSurat.alamat!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(
                          'Diagnosa',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          ': ',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          dataSurat.diagnosa!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  'Telah diperiksa kesehatan badannya dan sekarang dalam keadaan sakit dan perlu istirahat ${dataSurat.lamasakit} hari dari tanggal ${dataSurat.tanggalawal} sampai dengan ${dataSurat.tanggalakhir}. Demikian surat keterangan ini dibuat dengan benar dan untuk dapat digunakan sebagaimana mestinya.',
                  textAlign: pw.TextAlign.justify,
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Flexible(
                      child: pw.SizedBox(width: 10),
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          '${rumkit['kota']}, ${dataSurat.tanggalawal}',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          rumkit['rumkit'],
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          'Dokter,',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.SizedBox(height: 10),
                        pw.BarcodeWidget(
                          data: barcode.body['sidikjari'],
                          barcode: pw.Barcode.qrCode(),
                          width: 80,
                          height: 80,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          '( ${dataSurat.nmDokter} )',
                          style: pw.TextStyle(
                            decoration: pw.TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
    );
    Uint8List bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/surat_sakit.pdf');
    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  suratSKDP(String noSurat, String tahun) async {
    final data = await _suratKontrolProvider
        .fetchSuratKontrolData({'noantrian': noSurat, 'tahun': tahun});
    final barcode =
        await _suratSakaitProvider.fetchBarcode({'nik': data.kdDokter});
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'SURAT KETERANGAN',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 15),
              pw.Table(
                columnWidths: {
                  0: pw.FractionColumnWidth(.3),
                  1: pw.FractionColumnWidth(.05),
                  2: pw.FractionColumnWidth(.6),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(
                        'NO. SURAT',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        ':',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        data.noAntrian!,
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        'NO. RM',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        ':',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        data.noRkmMedis!,
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        'DIAGNOSA',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        ':',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        data.diagnosa!,
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        'TERAPI',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        ':',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        data.terapi!,
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                'Tanggal surat rujukan ${DateFormat("dd-MM-yyyy").format(data.tanggalRujukan!)}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'Belum dapat dikembalikan ke Fasilitas Perujuk dengan alasan :',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '1. ${data.alasan1}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '2. ${data.alasan2}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                'Rencana tindak lanjut yang akan diberikan pada kunjungan berikutnya :',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '1. ${data.rtl1}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '2. ${data.rtl2}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                'Surat keterangan ini digunakan untuk 1 (satu) kali kunjungan dengan diagnosa di atas pada :',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'Tanggal ${DateFormat("dd-MM-yyyy").format(data.tanggalDatang!)}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'No. Antrian ${data.noReg}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 15),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.BarcodeWidget(
                    data: data.noReg!,
                    barcode: pw.Barcode.qrCode(),
                    width: 50,
                    height: 50,
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                        '${rumkit['kota']},',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        'Dokter',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.SizedBox(height: 10),
                      pw.BarcodeWidget(
                        data: barcode.body['sidikjari'],
                        barcode: pw.Barcode.qrCode(),
                        width: 80,
                        height: 80,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        '(${data.nmDokter})',
                        style: pw.TextStyle(
                          fontSize: 14,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    Uint8List bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/surat_SKDP.pdf');
    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  suratRujukan(String noSurat) async {
    final data =
        await _suratRujukanProvider.fetchDataSuratRujukan({'nosurat': noSurat});
    final barcode =
        await _suratSakaitProvider.fetchBarcode({'nik': data.kdDokter});
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'SURAT KETERANGAN RUJUKAN',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  'NOMOR : ${data.noRujuk}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 15),
              pw.Align(
                child: pw.Text(
                  '${rumkit['kota']}, ${data.tglRujuk}',
                  textAlign: pw.TextAlign.right,
                ),
                alignment: pw.Alignment.topRight,
              ),
              pw.Text('Kepada Yth.'),
              pw.Text(data.rujukKe!),
              pw.Text('Di Tempat'),
              pw.SizedBox(height: 15),
              pw.Text(
                  'Bersama ini kami beritahukan bahwa kami telah merawat / memeriksa pasien berikut ini. Mohon pemeriksaan dan penanganan lebih lanjut penderita :',
                  textAlign: pw.TextAlign.justify),
              pw.SizedBox(height: 15),
              pw.Table(
                columnWidths: {
                  0: pw.FractionColumnWidth(.2),
                  1: pw.FractionColumnWidth(.010),
                  2: pw.FractionColumnWidth(.7),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Tanggal Rawat'),
                      pw.Text(':'),
                      pw.Text(
                          DateFormat("dd-MM-yyyy").format(data.tglRegistrasi!)),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Nama Pasien'),
                      pw.Text(':'),
                      pw.Text(data.nmPasien!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('No.RM'),
                      pw.Text(':'),
                      pw.Text(data.noRkmMedis!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Alamat'),
                      pw.Text(':'),
                      pw.Text(data.alamat!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Diagnosa'),
                      pw.Text(':'),
                      pw.Text(data.keteranganDiagnosa!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Tindakan'),
                      pw.Text(':'),
                      pw.Text(
                          data.inap! + data.lab! + data.rad! + data.operasi!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Terapi'),
                      pw.Text(':'),
                      pw.Text(data.obat!),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                  'Demikianlah riwayat perawatan selama di ${rumkit['rumkit']} dengan diagnosa akhir ${data.keteranganDiagnosa}. Atas kerjasamanya kami ucapkan terima kasih',
                  textAlign: pw.TextAlign.justify),
              pw.SizedBox(height: 15),
              pw.Align(
                alignment: pw.Alignment.topRight,
                child: pw.Column(
                  children: [
                    pw.Text('${rumkit['rumkit']},'),
                    pw.Text('Dokter yang merawat'),
                    pw.SizedBox(height: 10),
                    pw.BarcodeWidget(
                      data: barcode.body['sidikjari'],
                      barcode: pw.Barcode.qrCode(),
                      width: 80,
                      height: 80,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      '(${data.nmDokter})',
                      style: pw.TextStyle(
                        decoration: pw.TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    Uint8List bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/surat_rujukan.pdf');
    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }
}
