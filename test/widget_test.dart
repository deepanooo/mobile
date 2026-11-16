import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('education action opens the form from the home page',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('Tambah Edukasi'));
    await tester.tap(find.text('Tambah Edukasi'));
    await tester.pumpAndSettle();

    expect(find.byType(EducationFormPage), findsOneWidget);
    expect(find.text('Formulir Edukasi'), findsOneWidget);
  });

  testWidgets('required fields and education year order are validated',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: EducationFormPage()),
    );

    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Kolom ini wajib diisi.'), findsNWidgets(6));

    await tester.enterText(find.byType(TextFormField).at(0), 'Universitas');
    await tester.enterText(find.byType(TextFormField).at(1), 'S1');
    await tester.enterText(find.byType(TextFormField).at(2), 'Informatika');
    await tester.enterText(find.byType(TextFormField).at(3), '2024');
    await tester.enterText(find.byType(TextFormField).at(4), '2020');
    await tester.enterText(find.byType(TextFormField).at(5), 'Deskripsi');
    await tester.dragUntilVisible(
      find.text('Simpan'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(
      find.text('Tahun selesai tidak boleh sebelum tahun mulai.'),
      findsOneWidget,
    );
    expect(find.text('Data edukasi berhasil disimpan'), findsNothing);
  });

  testWidgets('valid education data appears in the summary dialog',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: EducationFormPage()),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Universitas');
    await tester.enterText(find.byType(TextFormField).at(1), 'S1');
    await tester.enterText(find.byType(TextFormField).at(2), 'Informatika');
    await tester.enterText(find.byType(TextFormField).at(3), '2020');
    await tester.enterText(find.byType(TextFormField).at(4), '2024');
    await tester.enterText(find.byType(TextFormField).at(5), 'Deskripsi');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Data edukasi berhasil disimpan'), findsOneWidget);
    expect(find.text('Institusi: Universitas'), findsOneWidget);
    expect(find.text('Periode: 2020–2024'), findsOneWidget);

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.byType(EducationFormPage), findsOneWidget);
  });

  testWidgets('education form can also be opened from the drawer',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    expect(find.byType(EducationFormPage), findsOneWidget);
  });
}
