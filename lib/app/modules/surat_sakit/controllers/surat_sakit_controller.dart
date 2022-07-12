import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/LIstSuratNarkobaModel.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/SuratKontrolModel.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/SuratRujukanModel.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/data_surat_sakit_model.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/surat_sakit_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../api/login_session.dart';
import '../../../api/rest_api.dart';
import '../models/DataSuratSakitModel.dart';
import '../models/SuratKontrolDataModel.dart';
import '../models/SuratRujukanDataModel.dart';
import '../models/setting_model.dart';

class SuratSakitController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement SuratSakitController
  final pasien = Get.find<LoginSession>().rkm.val;
  final _restApi = Get.put(RestApi());
  final _setting = Setting().obs;
  var listSuratSakit = <SuratSakitModel>[].obs;
  var listSuratNarkoba = <ListSuratNarkobaModel>[].obs;
  var listSuratKontrol = <SuratKontrolModel>[].obs;
  var listSuratRujukan = <SuratRujukanModel>[].obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    _restApi.getService(urlSetting).then((value) => {
          log(value.bodyString),
          if (value.statusCode == 200)
            {
              _setting.value = settingFromJson(value.bodyString!),
            }
        });
    super.onInit();
  }

  @override
  void onReady() {
    _restApi.getService(urlSuratSakit + '?no_rkm_medis=$pasien').then(
          (value) => listSuratSakit.value =
              suratSakitModelFromJson(json.encode(value.body['data'])),
        );
    _restApi.getService(urlSuratSKBN + '?no_rkm_medis=$pasien').then(
          (value) => listSuratNarkoba.value =
              listSuratNarkobaModelFromJson(json.encode(value.body['data'])),
        );
    _restApi.getService(urlSuratKontrol + '?no_rkm_medis=$pasien').then(
          (value) => listSuratKontrol.value =
              suratKontrolModelFromJson(json.encode(value.body['data'])),
        );
    _restApi.getService(urlSuratRujukan + '?no_rkm_medis=$pasien').then(
          (value) => listSuratRujukan.value =
              suratRujukanModelFromJson(json.encode(value.body['data'])),
        );
    super.onReady();
  }

  @override
  void onClose() {}

  void suratSKBN(String noSurat) async {
    final data =
        await _restApi.getService(urlSuratSKBNData + '?no_surat=$noSurat');
    final surat = dataSuratNarkobaModelFromJson(json.encode(data.body['data']));
    final barcode =
        await _restApi.getService(urlBarcode + '?nik=${surat.kdDokter}');
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
                            'Yang bertanda tangan dibawah ini saya ${surat.nmDokter}, pada ${_setting.value.data?.namaInstansi} menerangkan bahwa telah melakukan wawancara, pemeriksaan fisik dan pemeriksaan laboratorium terhadap pasien dengan keterangan sebagai berikut :',
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
                                  pw.Text(surat.nmPasien!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('b.'),
                                  pw.Text('Tempat, Tgl. lahir'),
                                  pw.Text(':'),
                                  pw.Text(
                                      surat.tmpLahir! + ', ' + surat.tglLahir!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('c.'),
                                  pw.Text('Agama'),
                                  pw.Text(':'),
                                  pw.Text(surat.agama!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('d.'),
                                  pw.Text('Jenis Kelamin'),
                                  pw.Text(':'),
                                  pw.Text(surat.jk!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('e.'),
                                  pw.Text('Suku Bangsa'),
                                  pw.Text(':'),
                                  pw.Text(surat.namaSukuBangsa!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('f.'),
                                  pw.Text('Pekerjaan'),
                                  pw.Text(':'),
                                  pw.Text(surat.pekerjaan!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('g.'),
                                  pw.Text('Alamat'),
                                  pw.Text(':'),
                                  pw.Text(surat.alamat!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('h.'),
                                  pw.Text('Dipergunakan'),
                                  pw.Text(':'),
                                  pw.Text(surat.keperluan!)
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
                            'Berdasarkan pemeriksaan Fisik dan pemeriksaan Urine dengan menggunakan alat ANSWER yang dilaksanakan pada hari/tanggal ${surat.tanggalsurat}, bahwa pada saat pemeriksaaan didapatkan hasil sebagai berikut :',
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
                                  pw.Text(surat.opiat!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('b.'),
                                  pw.Text('Ganja / Canabis'),
                                  pw.Text(':'),
                                  pw.Text(surat.ganja!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('c.'),
                                  pw.Text('Amphetamin'),
                                  pw.Text(':'),
                                  pw.Text(surat.amphetamin!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('d.'),
                                  pw.Text('Methamphetamin'),
                                  pw.Text(':'),
                                  pw.Text(surat.methamphetamin!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('e.'),
                                  pw.Text('Benzodiazepin'),
                                  pw.Text(':'),
                                  pw.Text(surat.benzodiazepin!)
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('f.'),
                                  pw.Text('Cocain'),
                                  pw.Text(':'),
                                  pw.Text(surat.cocain!)
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
                      pw.Text(surat.nmPasien!)
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                          '${_setting.value.data?.kabupaten}, ${surat.tanggalsurat}'),
                      pw.Text(_setting.value.data!.namaInstansi!),
                      pw.Text('Dokter,'),
                      pw.SizedBox(height: 10),
                      pw.BarcodeWidget(
                        data: barcode.body['data']['sidikjari'],
                        barcode: pw.Barcode.qrCode(),
                        width: 100,
                        height: 100,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        '( ${surat.nmDokter} )',
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
    log(noSurat);
    final data =
        await _restApi.getService(urlSuratSakitData + '?no_surat=$noSurat');
    final surat = dataSuratSakitModelFromJson(json.encode(data.body['data']));
    final barcode =
        await _restApi.getService(urlBarcode + '?nik=${surat.kdDokter}');
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
                  'Yang bertanda tangan di bawah ini ${surat.nmDokter}, dokter pada ${_setting.value.data?.namaInstansi} menerangkan bahwa :',
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
                          surat.nmPasien!,
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
                          surat.umur!,
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
                          surat.jk!,
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
                          surat.pekerjaan!,
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
                          surat.alamat!,
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
                          surat.diagnosa!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  'Telah diperiksa kesehatan badannya dan sekarang dalam keadaan sakit dan perlu istirahat ${surat.lamasakit} hari dari tanggal ${surat.tanggalawal} sampai dengan ${surat.tanggalakhir}. Demikian surat keterangan ini dibuat dengan benar dan untuk dapat digunakan sebagaimana mestinya.',
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
                          '${_setting.value.data!.kabupaten!}, ${surat.tanggalawal}',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          _setting.value.data!.namaInstansi!,
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.Text(
                          'Dokter,',
                          style: pw.TextStyle(fontSize: 14),
                        ),
                        pw.SizedBox(height: 10),
                        pw.BarcodeWidget(
                          data: barcode.body['data']['sidikjari'],
                          barcode: pw.Barcode.qrCode(),
                          width: 80,
                          height: 80,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          '( ${surat.nmDokter} )',
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
    final data = await _restApi
        .getService(urlSuratKontrolData + '?noantrian=$noSurat&tahun=$tahun');
    final surat = suratKontrolDataModelFromJson(json.encode(data.body['data']));
    final barcode =
        await _restApi.getService(urlBarcode + '?nik=${surat.kdDokter}');
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
                        surat.noAntrian!,
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
                        surat.noRkmMedis!,
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
                        surat.diagnosa!,
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
                        surat.terapi!,
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                'Tanggal surat rujukan ${DateFormat("dd-MM-yyyy").format(surat.tanggalRujukan!)}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'Belum dapat dikembalikan ke Fasilitas Perujuk dengan alasan :',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '1. ${surat.alasan1}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '2. ${surat.alasan2}',
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
                '1. ${surat.rtl1}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                '2. ${surat.rtl2}',
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
                'Tanggal ${DateFormat("dd-MM-yyyy").format(surat.tanggalDatang!)}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.Text(
                'No. Antrian ${surat.noReg}',
                style: pw.TextStyle(fontSize: 14),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 15),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.BarcodeWidget(
                    data: surat.noReg!,
                    barcode: pw.Barcode.qrCode(),
                    width: 50,
                    height: 50,
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                        '${_setting.value.data!.kabupaten!},',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.Text(
                        'Dokter',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                      pw.SizedBox(height: 10),
                      pw.BarcodeWidget(
                        data: barcode.body['data']['sidikjari'],
                        barcode: pw.Barcode.qrCode(),
                        width: 80,
                        height: 80,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        '(${surat.nmDokter})',
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
        await _restApi.getService(urlSuratRujukanData + '?nosurat=$noSurat');
    final surat = suratRujukanDataModelFromJson(json.encode(data.body['data']));
    final barcode =
        await _restApi.getService(urlBarcode + '?nik=${surat.kdDokter}');
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
                  'NOMOR : ${surat.noRujuk}',
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
                  '${_setting.value.data?.kabupaten}, ${surat.tglRujuk}',
                  textAlign: pw.TextAlign.right,
                ),
                alignment: pw.Alignment.topRight,
              ),
              pw.Text('Kepada Yth.'),
              pw.Text(surat.rujukKe!),
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
                      pw.Text(DateFormat("dd-MM-yyyy")
                          .format(surat.tglRegistrasi!)),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Nama Pasien'),
                      pw.Text(':'),
                      pw.Text(surat.nmPasien!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('No.RM'),
                      pw.Text(':'),
                      pw.Text(surat.noRkmMedis!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Alamat'),
                      pw.Text(':'),
                      pw.Text(surat.alamat!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Diagnosa'),
                      pw.Text(':'),
                      pw.Text(surat.keteranganDiagnosa!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Tindakan'),
                      pw.Text(':'),
                      pw.Text(surat.inap! +
                          surat.lab! +
                          surat.rad! +
                          surat.operasi!),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Terapi'),
                      pw.Text(':'),
                      pw.Text(surat.obat!),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                  'Demikianlah riwayat perawatan selama di ${_setting.value.data?.namaInstansi} dengan diagnosa akhir ${surat.keteranganDiagnosa}. Atas kerjasamanya kami ucapkan terima kasih',
                  textAlign: pw.TextAlign.justify),
              pw.SizedBox(height: 15),
              pw.Align(
                alignment: pw.Alignment.topRight,
                child: pw.Column(
                  children: [
                    pw.Text('${_setting.value.data?.namaInstansi},'),
                    pw.Text('Dokter yang merawat'),
                    pw.SizedBox(height: 10),
                    pw.BarcodeWidget(
                      data: barcode.body['data']['sidikjari'],
                      barcode: pw.Barcode.qrCode(),
                      width: 80,
                      height: 80,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      '(${surat.nmDokter})',
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
