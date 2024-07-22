document.getElementById('namaTagihan').addEventListener('change', function() {
    const jumlahTagihanInput = document.getElementById('jumlahTagihan');
    const namaTagihan = this.value;
    let jumlahTagihan;

    switch (namaTagihan) {
        case 'uang_bangunan':
            jumlahTagihan = 5000000;
            break;
        case 'ukt':
            jumlahTagihan = 3000000;
            break;
        case 'ujian_praktek':
            jumlahTagihan = 1500000;
            break;
        case 'uts':
            jumlahTagihan = 1000000;
            break;
        case 'uas':
            jumlahTagihan = 1000000;
            break;
        default:
            jumlahTagihan = 0;
    }

    jumlahTagihanInput.value = jumlahTagihan;
});

document.getElementById('paymentForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const namaTagihan = document.getElementById('namaTagihan').options[document.getElementById('namaTagihan').selectedIndex].text;
    const jumlahTagihan = document.getElementById('jumlahTagihan').value;
    const tanggalBayar = document.getElementById('tanggalBayar').value;
    const metodeBayar = document.getElementById('metodeBayar').value;

    alert(`Pembayaran berhasil!
Nama Tagihan: ${namaTagihan}
Jumlah Tagihan: Rp ${jumlahTagihan}
Tanggal Bayar: ${tanggalBayar}
Metode Pembayaran: ${metodeBayar}`);

    // Generate PDF
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF({
        orientation: 'p', // portrait
        unit: 'mm',
        format: [210, 297] // A4 size in mm (210 x 297)
    });

    // Header
    doc.setFontSize(16);
    doc.setFont('times', 'bold');
    doc.text('TEKIN UNIVERSITY', 10, 20);
    doc.setFontSize(12);
    doc.setFont('times', 'normal');
    doc.text('Jl. jalan kota baru No. 456, Kota Belajar', 10, 25);
    doc.text('Telp: (021) 98765432', 10, 30);
    doc.text('Email: info@tekinuniv-xyz.sch.id', 10, 35);
    doc.text('=========================================', 10, 40);

    // Title
    doc.setFontSize(14);
    doc.setFont('times', 'bold');
    doc.text('Pemberitahuan Pembayaran', 10, 50);

    // Body
    doc.setFontSize(12);
    doc.setFont('times', 'normal');
    const bodyText = `Dengan hormat,

Kami memberitahukan bahwa pembayaran untuk ${namaTagihan} telah berhasil dilakukan.

Detail Pembayaran:
- Nama Tagihan: ${namaTagihan}
- Jumlah Tagihan: Rp ${jumlahTagihan}
- Tanggal Bayar: ${tanggalBayar}
- Metode Pembayaran: ${metodeBayar}

Demikian pemberitahuan ini kami sampaikan. Terima kasih atas perhatian dan kerjasamanya.

Hormat kami,

 Staff Badan keuangan Tekin university`;
    doc.text(bodyText, 10, 60, { maxWidth: 190 });

    // Footer
    doc.setFontSize(10);
    doc.setFont('times', 'italic');
    doc.text('Tanggal: ' + new Date().toLocaleDateString(), 10, 270);
    doc.text('Waktu: ' + new Date().toLocaleTimeString(), 10, 275);

    doc.save('Pemberitahuan_Pembayaran.pdf');
});