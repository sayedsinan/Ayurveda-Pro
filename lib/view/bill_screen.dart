import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

import '../controller/auth_controller.dart';

class BillGenerator {
  static Future<void> generateBill({
    required String patientName,
    required String address,
    required String whatsappNumber,
    required String location,
    required String branch,
    required List<Map<String, dynamic>> treatments,
    required String totalAmount,
    required String discountAmount,
    required String advanceAmount,
    required String balanceAmount,
    required String treatmentDate,
    required String treatmentTime,
    required String paymentOption,
  }) async {
    final pdf = pw.Document();

    // Format current date and time for "Booked On"
    final now = DateTime.now();
    final bookedDate = DateFormat('dd/MM/yyyy').format(now);
    final bookedTime = DateFormat('hh:mm a').format(now);
    final Uint8List logoBytes = await rootBundle
        .load('assets/logo.png')
        .then((b) => b.buffer.asUint8List());
    final Uint8List signBytes = await rootBundle
        .load('assets/signature.png')
        .then((b) => b.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section with Logo and Address
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Logo space (left side)
                  pw.SizedBox(
                    width: 80,
                    height: 80,
                    child: pw.Image(
                      pw.MemoryImage(logoBytes),
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                  // Address details (right side)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'KUMARAKOM',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Cheepunkal P.O, Kumarakom, Kottayam, Kerala - 686563',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                      pw.Text(
                        'e-mail: unknown@gmail.com',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                      pw.Text(
                        'Mob: +91 9876543210 | +91 9876543210',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'GST No: 32AABCU9603R1ZW',
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 30),

              // Patient Details Section
              pw.Container(
                padding: pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(
                      color: PdfColors.grey400,
                      width: 1,
                      style: pw.BorderStyle.dashed,
                    ),
                  ),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Patient Details',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green700,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        _buildDetailRow('Name', patientName),
                        pw.SizedBox(height: 8),
                        _buildDetailRow('Address', address),
                        pw.SizedBox(height: 8),
                        _buildDetailRow('WhatsApp Number', whatsappNumber),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          'Booked On',
                          '$bookedDate | $bookedTime',
                        ),
                        pw.SizedBox(height: 8),
                        _buildDetailRow('Treatment Date', treatmentDate),
                        pw.SizedBox(height: 8),
                        _buildDetailRow('Treatment Time', treatmentTime),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Treatment Table
              pw.Column(
                children: [
                  // Table Header
                  pw.Container(
                    padding: pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(
                          color: PdfColors.grey400,
                          width: 1,
                          style: pw.BorderStyle.dashed,
                        ),
                      ),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            'Treatment',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Price',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green700,
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Male',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green700,
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Female',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green700,
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Total',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.green700,
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Table Rows
                  ...treatments.map((treatment) {
                    return pw.Container(
                      padding: pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColors.grey300,
                            width: 0.5,
                            style: pw.BorderStyle.dashed,
                          ),
                        ),
                      ),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              treatment['name'] ?? '',
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Rs.${treatment['price'] ?? '0'}',
                              style: pw.TextStyle(fontSize: 10),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              '${treatment['male'] ?? 0}',
                              style: pw.TextStyle(fontSize: 10),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              '${treatment['female'] ?? 0}',
                              style: pw.TextStyle(fontSize: 10),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Rs.${treatment['total'] ?? '0'}',
                              style: pw.TextStyle(fontSize: 10),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 20),

              // Payment Summary
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    width: 250,
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Column(
                      children: [
                        _buildAmountRow('Total Amount', 'Rs.$totalAmount'),
                        pw.SizedBox(height: 8),
                        _buildAmountRow('Discount', 'Rs.$discountAmount'),
                        pw.SizedBox(height: 8),
                        _buildAmountRow('Advance', 'Rs.$advanceAmount'),
                        pw.SizedBox(height: 8),
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border(
                              bottom: pw.BorderSide(
                                color: PdfColors.grey400,
                                width: 1,
                                style: pw.BorderStyle.dashed,
                              ),
                            ),
                          ),
                          child: pw.SizedBox(width: double.infinity, height: 1),
                        ),
                        pw.SizedBox(height: 8),
                        _buildAmountRow(
                          'Balance',
                          'Rs.$balanceAmount',
                          isBold: true,
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          'Thank you for choosing us',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green700,
                          ),
                        ),
                        pw.SizedBox(height: 6),
                        pw.Text(
                          'Your well-being is our commitment, and we\'re honored',
                          style: pw.TextStyle(
                            fontSize: 9,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text(
                          'you\'ve entrusted us with your health journey',
                          style: pw.TextStyle(
                            fontSize: 9,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        // Signature placeholder
                        pw.SizedBox(
                          width: 80,
                          height: 80,
                          child: pw.Image(
                            pw.MemoryImage(signBytes),
                            fit: pw.BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Spacer(),

              // Thank You Message with signature
              pw.Center(
                child: pw.Column(
                  children: [],
                ),
              ),
              pw.SizedBox(height: 30),

              // Footer Note
              pw.Center(
                child: pw.Text(
                  '*Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment*',
                  style: pw.TextStyle(fontSize: 8, color: PdfColors.grey),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF
    final output = await getTemporaryDirectory();
    final file = File(
      '${output.path}/ayurveda_bill_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    await OpenFile.open(file.path);
  }

  static pw.Widget _buildDetailRow(String label, String value) {
    return pw.Row(
      children: [
        pw.Text(
          '$label',
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(width: 20),
        pw.Text(value, style: pw.TextStyle(fontSize: 9)),
      ],
    );
  }

  static pw.Widget _buildAmountRow(
    String label,
    String amount, {
    bool isBold = false,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: isBold ? 12 : 10,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          amount,
          style: pw.TextStyle(
            fontSize: isBold ? 12 : 10,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }
}