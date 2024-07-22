document.addEventListener("DOMContentLoaded", () => {
    const tbody = document.getElementById("tbody");

    const mataKuliah = [
        { no: 1, kode: "0991", nama: "Aljabar" },
        { no: 2, kode: "0992", nama: "Kalkulus" },
        { no: 3, kode: "0993", nama: "Fisika" },
        { no: 4, kode: "0994", nama: "Kimia" },
        { no: 5, kode: "0995", nama: "Biologi" },
        { no: 6, kode: "0996", nama: "Komputer" },
        { no: 7, kode: "0997", nama: "Statistika dan Probabilitas" }
    ];

    mataKuliah.forEach((mk, index) => {
        const tr = document.createElement("tr");

        let td = document.createElement("td");
        td.textContent = index + 1;
        tr.appendChild(td);

        td = document.createElement("td");
        td.textContent = mk.kode;
        tr.appendChild(td);

        td = document.createElement("td");
        td.textContent = mk.nama;
        tr.appendChild(td);

        for (let i = 0; i < 16; i++) {
            td = document.createElement("td");
            td.classList.add("pertemuan");
            tr.appendChild(td);
        }

        tbody.appendChild(tr);
    });

    document.getElementById("submit").addEventListener("click", () => {
        const hadir = document.getElementById("hadir").checked;
        const izin = document.getElementById("izin").checked;
        const rows = document.querySelectorAll("#tbody tr");

        if (hadir || izin) {
            rows.forEach(row => {
                const cells = row.querySelectorAll(".pertemuan");
                const namaMK = row.querySelector("td:nth-child(3)").textContent;

                if (namaMK === "Statistika dan Probabilitas") {
                    for (let cell of cells) {
                        if (!cell.textContent) { // If cell is empty
                            if (hadir) {
                                cell.innerHTML = "✔";
                                cell.classList.add("hadir");
                            } else if (izin) {
                                cell.innerHTML = "-";
                                cell.classList.add("izin");
                            }
                            return; // Mark only the first empty cell
                        }
                    }
                }
            });
        } else {
            alert("Please select either 'Hadir' or 'Izin' before submitting.");
        }
    });
});