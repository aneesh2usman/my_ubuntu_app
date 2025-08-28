import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
// Import provider
import 'package:my_ubuntu_app/views/providers/userlistprovider.dart';

Future<void> exportUsersToExcel(BuildContext context, UserListProvider userProvider) async {
  try {
    // Create Excel workbook
    final excel = Excel.createExcel();
    // You can name the sheet whatever you like, e.g., 'User Data'
    final Sheet sheet = excel['User Data'];

    // Add headers
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = TextCellValue('Username');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value = TextCellValue('Email');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value = TextCellValue('First Name');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value = TextCellValue('Last Name');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value = TextCellValue('Phone');
    
    // Style headers (optional)
    for (int i = 0; i < 5; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
      );
    }

    print("Exporting users to Excel... Total users: ${userProvider.items.length}");
    
    // Add data rows
    for (int i = 0; i < userProvider.items.length; i++) {
      final user = userProvider.items[i];
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i+1)).value = TextCellValue(user.username ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i+1)).value = TextCellValue(user.email ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i+1)).value = TextCellValue(user.firstname ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i+1)).value = TextCellValue(user.lastname ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i+1)).value = TextCellValue(user.phoneNumber ?? '');
    }
    
    print("Exporting users to sheet complete. Total rows: ${sheet.maxRows}");
    
    // Generate Excel bytes - Convert List<int> to Uint8List
    final List<int> excelBytes = excel.encode()!;
    final Uint8List bytes = Uint8List.fromList(excelBytes);
    
    print("Generated Excel bytes: ${bytes.length}");
    
    // Save file using FileSaver
    await FileSaver.instance.saveFile(
      name: 'users_export2',
      bytes: bytes,
      ext: 'xlsx',
      mimeType: MimeType.microsoftExcel,
    );

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exported successfully! Check your downloads folder.')),
    );
  } catch (e) {
    // Show error message if any exception occurs
    print("Export failed: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Export failed: ${e.toString()}')),
    );
  }
}