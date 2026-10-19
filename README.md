# DT012 — SẮP XẾP CHÈN TRỰC TIẾP TRÊN MẢNG GẦN TĂNG

Đồ án môn học Cấu trúc dữ liệu và Giải thuật (INT13185 - Nhóm 03) — Học viện Công nghệ Bưu chính Viễn thông (Cơ sở TP. Hồ Chí Minh).

## 1. Thông tin sinh viên & đề tài

- **Họ và tên:** Đỗ Hồng Dương
- **Mã số sinh viên (MSSV):** N24DCDT018
- **Lớp:** D24CQDT01-N
- **Mã đề tài:** DT012
- **Tên đề tài:** Sắp xếp chèn trực tiếp trên mảng gần tăng (Direct Insertion Sort on Nearly Sorted Array)
- **Giảng viên hướng dẫn:** ThS. Hồ Nhựt Minh
- **Tài liệu căn cứ:** Giáo trình Cấu trúc dữ liệu và Giải thuật (INT1306)
  - Chương 2, Mục 2.2.3; Bảng 2.3; Mục 2.8 bài tập 16, 17, 19
  - Trang in: 37–39, 61 | Trang PDF: 49–51, 73
- **Môi trường & Ngôn ngữ:** Julia 1.12.6 (chỉ dùng thư viện chuẩn `Test`, `Printf`)

## 2. Hợp đồng dữ liệu đầu vào và kết quả đầu ra

- **Dữ liệu vào (Input):**
  - Mảng một chiều $a$ kiểu `Vector{Int}`.
  - Kích thước: $0 \le n \le 5000$.
  - Miền giá trị phần tử: $|a[i]| \le 10^6$ với mọi $i$.
  - Kiểm tra tính hợp lệ bằng hàm `kiem_tra_dau_vao(a)`, từ chối dữ liệu không đúng bằng ngoại lệ `ArgumentError`.
- **Kết quả ra (Output):**
  - Mảng $a$ sau khi sắp xếp tăng dần.
  - Số lần so sánh khóa (`tong_so_sanh`), số lần dịch chuyển phần tử (`tong_dich`).
  - Danh sách chi tiết các bước con: khóa chèn $x$, các phần tử bị dịch, vị trí chèn mới và tiền tố mảng sau chèn.
- **Ràng buộc quan trọng:**
  - Điều kiện so sánh lùi dịch chuyển là $a[j] > x$ (lớn hơn nghiêm ngặt), tuyệt đối không dịch khi $a[j] == x$ nhằm bảo toàn tính ổn định (Stable Sort).

## 3. Cấu trúc thư mục mã nguồn

```text
N24DCDT018_DT012_DoHongDuong/
├── .gitignore               # Cấu hình bỏ qua tệp tạm, cache Julia
├── README.md                # Tài liệu thuyết minh mã nguồn và hướng dẫn chạy
├── demo.jl                  # Kịch bản thực thi trực quan (Ví dụ 1, Ví dụ 2, Mảng gần tăng, Ổn định)
├── src/
│   └── DeTai.jl             # Module cài đặt thuật toán, validator và trace
├── test/
│   └── runtests.jl          # Bộ kiểm thử tự động 12 ca độc lập (TC01 -> TC12)
└── docs/
    └── anh_ket_qua/         # Chứa 11 ảnh chụp minh chứng thực nghiệm (A01 -> A11)
```

## 4. Hướng dẫn chạy chương trình

Mở terminal (PowerShell) tại thư mục dự án:

### Kiểm tra phiên bản Julia:
```powershell
julia --version
```

### Chạy chương trình trực quan demo:
```powershell
julia --startup-file=no demo.jl
```
*(Tùy chọn: Thêm tham số `-i` hoặc `--nhap` để nhập mảng tự do từ bàn phím: `julia --startup-file=no demo.jl -i`)*

### Chạy toàn bộ bộ kiểm thử tự động:
```powershell
julia --startup-file=no test/runtests.jl
```

## 5. Kết quả kiểm thử thực tế

Bộ kiểm thử gồm **12 ca kiểm thử độc lập (TC01 – TC12)** với **42 phép kiểm tra (asserts)**:
- **TC01 (A01):** Ví dụ 1 phiếu `[4, 1, 3, 2]` $\rightarrow$ ra `[1, 2, 3, 4]`, 6 so sánh, 4 dịch (`Pass`).
- **TC02 (A02):** Ví dụ 2 phiếu `[1, 2, 2, 3]` $\rightarrow$ giữ nguyên `[1, 2, 2, 3]`, 0 dịch, $n-1$ so sánh (`Pass`).
- **TC03 (A03):** Tự thiết kế 1: Mảng gần tăng `[1, 3, 2, 4, 5]` $\rightarrow$ ra `[1, 2, 3, 4, 5]`, 1 dịch (`Pass`).
- **TC04 (A04):** Tự thiết kế 2: Mảng đảo cặp kề `[2, 1, 4, 3, 6, 5]` $\rightarrow$ ra `[1, 2, 3, 4, 5, 6]`, 3 dịch (`Pass`).
- **TC05 (A05):** Ca biên mảng rỗng `[]` $\rightarrow$ không lỗi, không đọc ngoài biên (`Pass`).
- **TC06 (A06):** Ca biên 1 phần tử `[42]` $\rightarrow$ giữ nguyên, 0 so sánh, 0 dịch (`Pass`).
- **TC07 (A07):** Ca biên toàn phần tử bằng nhau `[5, 5, 5, 5]` $\rightarrow$ giữ nguyên, 0 dịch (`Pass`).
- **TC08 (A08):** Dữ liệu không hợp lệ (vượt ngưỡng $10^6$, độ dài $> 5000$) $\rightarrow$ Validator từ chối đúng (`Pass`).
- **TC09:** Mảng giảm dần `[5, 4, 3, 2, 1]` $\rightarrow$ xấu nhất $O(n^2)$, 10 so sánh, 10 dịch (`Pass`).
- **TC10:** Mảng chứa số âm và số không `[-1, -3, 0]` $\rightarrow$ ra `[-3, -1, 0]` (`Pass`).
- **TC11:** Mảng hỗn hợp âm dương ngẫu nhiên $\rightarrow$ sắp xếp tăng dần chính xác (`Pass`).
- **TC12:** Kiểm tra tính ổn định trên bản ghi cặp `(khóa, nhãn)` $\rightarrow$ giữ nguyên thứ tự bản ghi bằng khóa (`Pass`).

**Tổng kết:** `Test Summary: Pass: 42, Total: 42 (100% Passed)`.

## 6. Hướng dẫn công bố GitHub và Kiểm tra bản Clone

```powershell
# Khởi tạo và đẩy lên GitHub cá nhân (Commit C):
git init
git add .
git commit -m "Hoan thanh de tai DT012: ma nguon, test va minh chung"
git branch -M main
git remote add origin https://github.com/TEN_TAI_KHOAN/DT012_SapXepChen_N24DCDT018.git
git push -u origin main
git rev-parse HEAD

# Kiểm tra bản clone sạch sang thư mục mới:
git clone https://github.com/TEN_TAI_KHOAN/DT012_SapXepChen_N24DCDT018.git kiem_tra_ban_nop
cd kiem_tra_ban_nop
git rev-parse HEAD
julia --startup-file=no demo.jl
julia --startup-file=no test/runtests.jl
```
