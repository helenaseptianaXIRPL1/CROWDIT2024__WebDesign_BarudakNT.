Memori Utama:
+---------+---------+---------+---------+
| Process | Process | Process | Process |
|    A    |    B    |    C    |    D    |
+---------+---------+---------+---------+

Swap Space (Penyimpanan Sekunder):
+---------+---------+---------+---------+
|         |         |         |         |
|         |         |         |         |
+---------+---------+---------+---------+

Step 1: Memori utama penuh, memerlukan swap out Process B
Memori Utama:
+---------+---------+---------+---------+
| Process |         | Process | Process |
|    A    |         |    C    |    D    |
+---------+---------+---------+---------+

Swap Space:
+---------+---------+---------+---------+
|         | Process |         |         |
|         |    B    |         |         |
+---------+---------+---------+---------+

Step 2: Proses baru, Process E, masuk ke memori utama
Memori Utama:
+---------+---------+---------+---------+
| Process | Process | Process | Process |
|    A    |    E    |    C    |    D    |
+---------+---------+---------+---------+

Swap Space:
+---------+---------+---------+---------+
|         | Process |         |         |
|         |    B    |         |         |
+---------+---------+---------+---------+

Step 3: Process B diperlukan kembali, swap in Process B
Memori Utama:
+---------+---------+---------+---------+
| Process | Process | Process |         |
|    A    |    E    |    C    |         |
+---------+---------+---------+---------+

Swap Space:
+---------+---------+---------+---------+
|         |         |         |         |
|         |         |         |         |
+---------+---------+---------+---------+

Memori Utama:
+---------+---------+---------+---------+
| Process | Process | Process | Process |
|    A    |    E    |    C    |    B    |
+---------+---------+---------+---------+
