# ==============================================================================
# HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG - CƠ SỞ TP. HỒ CHÍ MINH
# Môn: Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03)
# Sinh viên: Đỗ Hồng Dương - MSSV: N24DCDT018 - Lớp: D24CQDT01-N
# Đề tài: DT012 - Sắp xếp chèn trực tiếp trên mảng gần tăng
# File: demo.jl
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

function chay_vi_du_1()
    println("\n" * "="^70)
    println("DEMO 1: VÍ DỤ 1 TRÊN PHIẾU GIAO ĐỀ TÀI")
    println("Mục tiêu: Chèn các phần tử vào mảng lộn xộn, lần lượt chèn 1, 3, 2")
    println("="^70)
    a1 = [4, 1, 3, 2]
    println("Dữ liệu vào (Input)           : a = ", a1)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 3, 4]")
    println("-"^70)
    kq1 = lan_vet_chen(a1; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq1.mang)
    println("Trạng thái kiểm tra           : ", kq1.mang == [1, 2, 3, 4] ? "PASS (CHÍNH XÁC)" : "FAIL")
end

function chay_vi_du_2()
    println("\n" * "="^70)
    println("DEMO 2: VÍ DỤ 2 TRÊN PHIẾU GIAO ĐỀ TÀI")
    println("Mục tiêu: Mảng có khóa bằng nhau, kiểm tra không dịch khóa bằng (Tính ổn định)")
    println("="^70)
    a2 = [1, 2, 2, 3]
    println("Dữ liệu vào (Input)           : a = ", a2)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 2, 3] (0 lần dịch)")
    println("-"^70)
    kq2 = lan_vet_chen(a2; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq2.mang)
    println("Số lần dịch thực tế           : ", kq2.tong_dich, " (kỳ vọng: 0)")
    println("Trạng thái kiểm tra           : ", (kq2.mang == [1, 2, 2, 3] && kq2.tong_dich == 0) ? "PASS (CHÍNH XÁC)" : "FAIL")
end

function chay_ca_tu_thiet_ke()
    println("\n" * "="^70)
    println("DEMO 3: CA TỰ THIẾT KẾ TRÊN MẢNG GẦN TĂNG (NEARLY SORTED)")
    println("Mục tiêu: Minh họa hiệu năng tuyến tính O(n) khi mảng chỉ có 1 nghịch thế")
    println("="^70)
    a3 = [1, 3, 2, 4, 5]
    println("Dữ liệu vào (Input)           : a = ", a3)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 3, 4, 5]")
    println("-"^70)
    kq3 = lan_vet_chen(a3; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq3.mang)
    println("Số so sánh: ", kq3.tong_so_sanh, " | Số dịch: ", kq3.tong_dich)
    println("Trạng thái kiểm tra           : ", kq3.mang == [1, 2, 3, 4, 5] ? "PASS (CHÍNH XÁC)" : "FAIL")
end

function chay_kiem_tra_on_dinh()
    println("\n" * "="^70)
    println("DEMO 4: KIỂM TRA TÍNH ỔN ĐỊNH VỚI BẢN GHI (KHOÁ, DỮ LIỆU)")
    println("Mục tiêu: Chứng minh hai phần tử có khóa 2 giữ nguyên thứ tự ban đầu")
    println("="^70)
    ds = [(2, "SinhVien_A"), (1, "SinhVien_B"), (2, "SinhVien_C")]
    println("Dữ liệu vào (Input)           : ", ds)
    kq = sap_xep_chen_on_dinh(ds)
    println("Kết quả sau sắp xếp (Actual)  : ", kq)
    on_dinh = (kq[2] == (2, "SinhVien_A") && kq[3] == (2, "SinhVien_C"))
    println("Bảo toàn thứ tự phần tử bằng  : ", on_dinh ? "ĐẠT TÍNH ỔN ĐỊNH (STABLE SORT)" : "KHÔNG ỔN ĐỊNH")
end

function main()
    println("#"^70)
    println("# CHƯƠNG TRÌNH THỰC NGHIỆM ĐỀ TÀI DT012 - HỌC KỲ I NĂM HỌC 2026-2027")
    println("# Sinh viên: Đỗ Hồng Dương | MSSV: N24DCDT018 | Lớp: D24CQDT01-N")
    println("# Sắp xếp chèn trực tiếp trên mảng gần tăng (Direct Insertion Sort)")
    println("#"^70)

    # Chạy các ca thực nghiệm tự động
    chay_vi_du_1()
    chay_vi_du_2()
    chay_ca_tu_thiet_ke()
    chay_kiem_tra_on_dinh()

    # Kiểm tra nếu người dùng muốn nhập từ bàn phím qua tham số dòng lệnh
    if "--nhap" in ARGS || "-i" in ARGS
        println("\n" * "="^70)
        println("CHẾ ĐỘ NHẬP DỮ LIỆU TỰ DO TỪ BÀN PHÍM")
        println("="^70)
        print("Nhập các số nguyên cách nhau bởi dấu cách: ")
        line = readline()
        try
            mang_nhap = parse.(Int, split(strip(line)))
            lan_vet_chen(mang_nhap; in_ra=true)
        catch e
            println("Lỗi dữ liệu: ", e)
        end
    end
end

main()
