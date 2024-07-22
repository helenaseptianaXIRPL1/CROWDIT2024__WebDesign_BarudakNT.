document.addEventListener('DOMContentLoaded', () => {
    const monthNames = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
    const holidays = {
        "1-1": "Tahun Baru Masehi",
        "1-2": "Pembukaan penerimaan mahasiswa baru",
        "2-8": "Isra Mi'raj Nabi Muhammad SAW",
        "2-10": "Tahun Baru Imlek 2575 Kongzili",
        "3-11": "Hari Suci Nyepi Tahun Baru Saka 1946",
        "5-1": "Hari Buruh",
        "8-31": "penutupan penerimaan mahasiswa baru",
        "9-2": "tes akademik mahasiswa baru",
        "9-6": "pengumuman mahasiswa yang telah diterima",
        "9-15": "masa pengenalan lingkungan kampus",
        "12-2": "Libur Minggu Tenang UTS",
        "12-3": "Libur Minggu Tenang UTS",
        "12-4": "Libur Minggu Tenang UTS",
        "12-5": "Libur Minggu Tenang UTS",
        "12-6": "Libur Minggu Tenang UTS",
        "12-7": "Libur Minggu Tenang UTS",
        "8-17": "Hari Kemerdekaan",
        "12-25": "Natal"
    };

    let currentMonth = 0;
    let currentYear = 2024;

    function generateCalendar(month, year) {
        const calendarBody = document.getElementById('calendar-body');
        const holidayList = document.getElementById('holiday-list');
        calendarBody.innerHTML = '';
        holidayList.innerHTML = '';
        const firstDay = new Date(year, month).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        document.getElementById('month-name').innerText = monthNames[month];

        let date = 1;
        let hasHolidays = false;
        for (let i = 0; i < 6; i++) {
            const row = document.createElement('tr');

            for (let j = 0; j < 7; j++) {
                const cell = document.createElement('td');
                if (i === 0 && j < firstDay) {
                    cell.innerText = '';
                } else if (date > daysInMonth) {
                    break;
                } else {
                    cell.innerText = date;
                    const holidayKey = `${month + 1}-${date}`;
                    if (holidays[holidayKey]) {
                        cell.classList.add('holiday');
                        cell.dataset.holiday = holidays[holidayKey];
                        const listItem = document.createElement('li');
                        listItem.innerText = `${date} ${monthNames[month]}: ${holidays[holidayKey]}`;
                        holidayList.appendChild(listItem);
                        hasHolidays = true;
                    }
                    date++;
                }
                row.appendChild(cell);
            }

            calendarBody.appendChild(row);
        }

        if (!hasHolidays) {
            const noHolidayItem = document.createElement('li');
            noHolidayItem.innerText = "Tidak ada hari event dibulan ini^^";
            holidayList.appendChild(noHolidayItem);
        }

        addHolidayClickListener();
    }

    function addHolidayClickListener() {
        document.querySelectorAll('.holiday').forEach(cell => {
            cell.addEventListener('click', (event) => {
                const holidayText = event.target.dataset.holiday;
                document.getElementById('holiday-text').innerText = holidayText;
                document.getElementById('holiday-popup').style.display = 'block';
            });
        });
    }

    document.getElementById('prev-month').addEventListener('click', () => {
        currentMonth = (currentMonth === 0) ? 11 : currentMonth - 1;
        generateCalendar(currentMonth, currentYear);
    });

    document.getElementById('next-month').addEventListener('click', () => {
        currentMonth = (currentMonth === 11) ? 0 : currentMonth + 1;
        generateCalendar(currentMonth, currentYear);
    });

    document.getElementById('close-popup').addEventListener('click', () => {
        document.getElementById('holiday-popup').style.display = 'none';
    });

    generateCalendar(currentMonth, currentYear);


});

// End of script Schedule


// Set untuk menyimpan ID komentar yang telah di-like oleh pengguna
const likedComments = new Set();
const reportedComments = new Map(); // Menyimpan jumlah laporan per komentar
const reportReasons = new Map(); // Menyimpan alasan laporan per komentar
let currentCommentId = null;

function likeComment(button) {
    const comment = button.parentElement;
    const commentId = comment.getAttribute('data-comment-id');
    const likeCountElement = button.querySelector('.like-count');

    if (!likedComments.has(commentId)) {
        likedComments.add(commentId);
        let likeCount = parseInt(likeCountElement.textContent);
        likeCountElement.textContent = likeCount + 1;
        button.classList.add('active');
    }
}

function addComment() {
    const commentInput = document.getElementById('comment-input');
    const commentText = commentInput.value.trim();

    if (commentText === '') {
        alert('Komentar tidak boleh kosong!');
        return;
    }

    const commentSection = document.getElementById('comments-section');
    const commentId = Date.now();
    const postTime = new Date(commentId).getTime(); // Simulasi waktu posting dengan timestamp

    const newComment = document.createElement('div');
    newComment.classList.add('comment');
    newComment.setAttribute('data-comment-id', commentId);
    newComment.setAttribute('data-post-time', postTime);

    newComment.innerHTML = `
        <p class="comment-author">Beni</p>
        <p class="comment-text">${commentText}</p>
        <p class="comment-time">Komentar diposting sekarang</p>
        <button class="like-button" onclick="likeComment(this)">Suka <span class="like-count">0</span> ❤️</button>
        <button class="delete-button" onclick="deleteComment(this)">Hapus</button>
        <button class="report-button" onclick="openReportModal(this)">
            Laporkan <span class="report-count">0</span>
        </button>
    `;

    commentSection.appendChild(newComment);
    commentInput.value = '';

    // Update waktu posting komentar
    updateCommentTimes();
}

function deleteComment(button) {
    const comment = button.parentElement;
    const commentAuthor = comment.querySelector('.comment-author').textContent;

    if (confirm('Apakah Anda yakin ingin menghapus komentar?')) {
        const newContent = `${commentAuthor} telah menghapus komentar`;
        comment.querySelector('.comment-text').textContent = newContent;
        button.style.display = 'none'; // Sembunyikan tombol hapus setelah dihapus
    }
}

function openReportModal(button) {
    currentCommentId = button.parentElement.getAttribute('data-comment-id');
    document.getElementById('report-modal').style.display = 'block';
}

function closeReportModal() {
    document.getElementById('report-modal').style.display = 'none';
}

document.getElementById('report-form').addEventListener('submit', function(event) {
    event.preventDefault();
    const reason = document.querySelector('input[name="report-reason"]:checked').value;
    const customReason = document.getElementById('custom-reason').value.trim();

    if (currentCommentId) {
        let reportList = reportReasons.get(currentCommentId) || [];
        if (reason === 'lainnya' && customReason) {
            reportList.push(customReason);
        } else if (reason !== 'lainnya') {
            reportList.push(reason);
        }
        reportedComments.set(currentCommentId, (reportedComments.get(currentCommentId) || 0) + 1);
        reportReasons.set(currentCommentId, reportList);

        // Update jumlah laporan di tampilan
        const comment = document.querySelector(`.comment[data-comment-id="${currentCommentId}"]`);
        const reportButton = comment.querySelector('.report-button');
        const reportCountElement = reportButton.querySelector('.report-count');
        reportCountElement.textContent = reportedComments.get(currentCommentId);

        closeReportModal();
    }
});

document.querySelector('input[name="report-reason"][value="lainnya"]').addEventListener('change', function() {
    document.getElementById('custom-reason-container').classList.remove('hidden');
});

document.querySelector('input[name="report-reason"]:not([value="lainnya"])').addEventListener('change', function() {
    document.getElementById('custom-reason-container').classList.add('hidden');
});

function updateCommentTimes() {
    const comments = document.querySelectorAll('.comment');
    const now = Date.now();

    comments.forEach(comment => {
        const postTime = parseInt(comment.getAttribute('data-post-time'), 10);
        const timeDifference = now - postTime;
        const minutes = Math.floor(timeDifference / 60000);
        const hours = Math.floor(timeDifference / 3600000);
        const days = Math.floor(timeDifference / 86400000);
        const weeks = Math.floor(timeDifference / 604800000);
        const years = Math.floor(timeDifference / 31536000000);

        let timeText = 'Komentar diposting sekarang';
        if (minutes > 0 && minutes < 60) {
            timeText = `Komentar diposting ${minutes} menit yang lalu`;
        } else if (hours > 0 && hours < 24) {
            timeText = `Komentar diposting ${hours} jam yang lalu`;
        } else if (days > 0 && days < 7) {
            timeText = `Komentar diposting ${days} hari yang lalu`;
        } else if (weeks > 0 && weeks < 52) {
            timeText = `Komentar diposting ${weeks} minggu yang lalu`;
        } else if (years > 0) {
            timeText = `Komentar diposting ${years} tahun yang lalu`;
        }

        comment.querySelector('.comment-time').textContent = timeText;
    });
}

// Update waktu posting komentar pada load halaman
updateCommentTimes();

// Update waktu posting komentar setiap 60 detik
setInterval(updateCommentTimes, 60000);

// End Script of Forum






// End of script Absensi