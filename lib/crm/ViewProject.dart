import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

//todo make example factuur

class ViewProject extends StatefulWidget {
  ViewProject({Key? key, required this.project, required this.customer}) : super(key: key);

  final Project project;
  final Customer customer;
  User? user = AuthService().user;

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: PdfPreview(
        build: (format) => _generatePdf(format, widget.project.label),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.Column(children: [
                  pw.Text(title, style: pw.TextStyle(font: font)),
                  pw.Text("Client Name: ${widget.customer.firstname}")
                ]),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
