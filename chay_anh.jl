# ==============================================================================
# HỖ TRỢ CHẠY TỪNG CA ĐỂ CHỤP ẢNH MINH CHỨNG (A01 -> A08)
# Đề tài DT012: Sắp xếp chèn trực tiếp trên mảng gần tăng
# Sinh viên: Đỗ Hồng Dương - N24DCDT018
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

function in_tieu_de(ma_anh, ten_ca, muc_tieu)
    println("="^75)
    println("ẢNH MINH CHỨNG: ", ma_anh, " — ", ten_ca)
    println("Mục tiêu: ", muc_tieu)
    println("="^75)
end

function chay_A01()
    in_tieu_de("A01 (Hình 4.1)", "Ví dụ 1 trên phiếu giao", "Chèn các phần tử vào mảng lộn xộn [4, 1, 3, 2]")
    a = [4, 1, 3, 2]
    println("Dữ liệu vào (Input)           : a = ", a)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 3, 4] | 6 so sánh | 4 dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Đánh giá                      : ", kq.mang == [1, 2, 3, 4] ? "PASS (CHÍNH XÁC)" : "FAIL")
end

function chay_A02()
    in_tieu_de("A02 (Hình 4.2)", "Ví dụ 2 trên phiếu giao", "Mảng tăng có khóa bằng nhau [1, 2, 2, 3] (Tính ổn định)")
    a = [1, 2, 2, 3]
    println("Dữ liệu vào (Input)           : a = ", a)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 2, 3] | 3 so sánh | 0 dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Số lần dịch thực tế           : ", kq.tong_dich, " (Kỳ vọng: 0)")
    println("Đánh giá                      : ", (kq.mang == [1, 2, 2, 3] && kq.tong_dich == 0) ? "PASS (KHÔNG DỊCH KHÓA BẰNG)" : "FAIL")
end

function chay_A03()
    in_tieu_de("A03 (Hình 4.3)", "Ca tự thiết kế 1", "Mảng gần tăng có 1 cặp nghịch thế [1, 3, 2, 4, 5]")
    a = [1, 3, 2, 4, 5]
    println("Dữ liệu vào (Input)           : a = ", a)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 3, 4, 5] | Chỉ 1 lần dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Số lần dịch thực tế           : ", kq.tong_dich, " (Kỳ vọng: 1)")
    println("Đánh giá                      : ", kq.mang == [1, 2, 3, 4, 5] ? "PASS (TIỆM CẬN TUYẾN TÍNH O(n))" : "FAIL")
end

function chay_A04()
    in_tieu_de("A04 (Hình 4.4)", "Ca tự thiết kế 2", "Mảng gần tăng nhiều cặp kề bị đảo [2, 1, 4, 3, 6, 5]")
    a = [2, 1, 4, 3, 6, 5]
    println("Dữ liệu vào (Input)           : a = ", a)
    println("Kết quả mong đợi (Expected)   : a = [1, 2, 3, 4, 5, 6] | 3 lần dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Số lần dịch thực tế           : ", kq.tong_dich, " (Kỳ vọng: 3)")
    println("Đánh giá                      : ", kq.mang == [1, 2, 3, 4, 5, 6] ? "PASS (CHÍNH XÁC)" : "FAIL")
end

function chay_A05()
    in_tieu_de("A05 (Hình 4.5)", "Ca biên 1", "Mảng rỗng [] không lỗi, không đọc ngoài biên")
    a = Int[]
    println("Dữ liệu vào (Input)           : a = Int[] (Mảng rỗng)")
    println("Kết quả mong đợi (Expected)   : a = Int[] | 0 so sánh | 0 dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Đánh giá                      : ", isempty(kq.mang) ? "PASS (AN TOÀN)" : "FAIL")
end

function chay_A06()
    in_tieu_de("A06 (Hình 4.6)", "Ca biên 2", "Mảng 1 phần tử [42] giữ nguyên")
    a = [42]
    println("Dữ liệu vào (Input)           : a = [42]")
    println("Kết quả mong đợi (Expected)   : a = [42] | 0 so sánh | 0 dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Đánh giá                      : ", kq.mang == [42] ? "PASS (GIỮ NGUYÊN)" : "FAIL")
end

function chay_A07()
    in_tieu_de("A07 (Hình 4.7)", "Ca biên 3", "Mảng toàn phần tử bằng nhau [5, 5, 5, 5]")
    a = [5, 5, 5, 5]
    println("Dữ liệu vào (Input)           : a = [5, 5, 5, 5]")
    println("Kết quả mong đợi (Expected)   : a = [5, 5, 5, 5] | 3 so sánh | 0 dịch")
    println("-"^75)
    kq = lan_vet_chen(a; in_ra=true)
    println("Kết quả thực tế (Actual)      : a = ", kq.mang)
    println("Số lần dịch thực tế           : ", kq.tong_dich, " (Kỳ vọng: 0)")
    println("Đánh giá                      : ", (kq.mang == [5, 5, 5, 5] && kq.tong_dich == 0) ? "PASS (CHÍNH XÁC)" : "FAIL")
end

function chay_A08()
    in_tieu_de("A08 (Hình 4.8)", "Kiểm tra dữ liệu sai (LOI01)", "Phần tử vượt quá |10^6| bị Validator từ chối")
    a = [1, 1000001]
    println("Dữ liệu vào (Input)           : a = [1, 1000001] (Phần tử thứ 2 vượt quá 10^6)")
    println("Kỳ vọng (Expected)            : Ném ngoại lệ ArgumentError từ chối dữ liệu")
    println("-"^75)
    try
        kiem_tra_dau_vao(a)
        println("Kết quả thực tế (Actual)      : KHÔNG BẮT ĐƯỢC LỖI (FAIL)")
    catch e
        println("Kết quả thực tế (Actual)      : Bắt được lỗi ngoại lệ thành công!")
        println("Thông báo lỗi (Error message) : ", e)
        println("Đánh giá                      : PASS (TỪ CHỐI DỮ LIỆU ĐÚNG HỢP ĐỒNG)")
    end
end

function main()
    chon = isempty(ARGS) ? "ALL" : uppercase(ARGS[1])
    
    if chon in ["A01", "1"]
        chay_A01()
    elseif chon in ["A02", "2"]
        chay_A02()
    elseif chon in ["A03", "3"]
        chay_A03()
    elseif chon in ["A04", "4"]
        chay_A04()
    elseif chon in ["A05", "5"]
        chay_A05()
    elseif chon in ["A06", "6"]
        chay_A06()
    elseif chon in ["A07", "7"]
        chay_A07()
    elseif chon in ["A08", "8"]
        chay_A08()
    else
        println("\n>>> HƯỚNG DẪN CHẠY TỪNG CA ĐỂ CHỤP ẢNH MINH CHỨNG:")
        println("  julia chay_anh.jl A01  --> Chạy và chụp Hình 4.1 (Ví dụ 1)")
        println("  julia chay_anh.jl A02  --> Chạy và chụp Hình 4.2 (Ví dụ 2)")
        println("  julia chay_anh.jl A03  --> Chạy và chụp Hình 4.3 (Tự thiết kế 1)")
        println("  julia chay_anh.jl A04  --> Chạy và chụp Hình 4.4 (Tự thiết kế 2)")
        println("  julia chay_anh.jl A05  --> Chạy và chụp Hình 4.5 (Biên mảng rỗng)")
        println("  julia chay_anh.jl A06  --> Chạy và chụp Hình 4.6 (Biên 1 phần tử)")
        println("  julia chay_anh.jl A07  --> Chạy và chụp Hình 4.7 (Biên toàn số trùng)")
        println("  julia chay_anh.jl A08  --> Chạy và chụp Hình 4.8 (Dữ liệu sai)")
        println("  julia test/runtests.jl --> Chạy và chụp Hình 4.9 (Tổng kết 12 test)")
    end
end

main()
