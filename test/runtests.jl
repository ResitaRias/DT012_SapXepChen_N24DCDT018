# ==============================================================================
# HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG - CƠ SỞ TP. HỒ CHÍ MINH
# Môn: Cấu trúc dữ liệu và giải thuật (INT13185 - Nhóm 03)
# Sinh viên: Đỗ Hồng Dương - MSSV: N24DCDT018 - Lớp: D24CQDT01-N
# Đề tài: DT012 - Sắp xếp chèn trực tiếp trên mảng gần tăng
# File: test/runtests.jl - Bộ kiểm thử 12 ca độc lập (TC01 -> TC12)
# ==============================================================================

using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

@testset "BỘ KIỂM THỬ ĐỀ TÀI DT012 - N24DCDT018 - ĐỖ HỒNG DƯƠNG" begin

    # --------------------------------------------------------------------------
    # TC01 (Tương ứng minh chứng A01 - Ví dụ 1 phiếu giao)
    # --------------------------------------------------------------------------
    @testset "TC01: Ví dụ 1 trên phiếu [4, 1, 3, 2]" begin
        input = [4, 1, 3, 2]
        expected = [1, 2, 3, 4]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test res.tong_so_sanh == 6
        @test res.tong_dich == 4
        @test issorted(res.mang)
        @test giai_bai(input) == expected
    end

    # --------------------------------------------------------------------------
    # TC02 (Tương ứng minh chứng A02 - Ví dụ 2 phiếu giao)
    # --------------------------------------------------------------------------
    @testset "TC02: Ví dụ 2 trên phiếu [1, 2, 2, 3] (Khóa bằng, không dịch)" begin
        input = [1, 2, 2, 3]
        expected = [1, 2, 2, 3]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test res.tong_dich == 0               # Không dịch khi khóa bằng nhau
        @test res.tong_so_sanh == length(input) - 1 # n-1 so sánh với mảng tăng
        @test issorted(res.mang)
    end

    # --------------------------------------------------------------------------
    # TC03 (Tương ứng minh chứng A03 - Ca tự thiết kế 1: Mảng gần tăng 1 nghịch thế)
    # --------------------------------------------------------------------------
    @testset "TC03: Tự thiết kế 1 - Mảng gần tăng có 1 cặp nghịch thế [1, 3, 2, 4, 5]" begin
        input = [1, 3, 2, 4, 5]
        expected = [1, 2, 3, 4, 5]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test res.tong_dich == 1               # Chỉ dịch số 3 đúng 1 vị trí
        @test res.tong_so_sanh == 5            # Hiệu năng tiệm cận tuyến tính O(n)
        @test issorted(res.mang)
    end

    # --------------------------------------------------------------------------
    # TC04 (Tương ứng minh chứng A04 - Ca tự thiết kế 2: Mảng gần tăng nhiều cặp đảo kề)
    # --------------------------------------------------------------------------
    @testset "TC04: Tự thiết kế 2 - Mảng gần tăng cặp kề đảo [2, 1, 4, 3, 6, 5]" begin
        input = [2, 1, 4, 3, 6, 5]
        expected = [1, 2, 3, 4, 5, 6]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test res.tong_dich == 3               # Mỗi cặp chỉ cần 1 lần dịch
        @test issorted(res.mang)
    end

    # --------------------------------------------------------------------------
    # TC05 (Tương ứng minh chứng A05 - Ca biên 1: Mảng rỗng)
    # --------------------------------------------------------------------------
    @testset "TC05: Ca biên 1 - Mảng rỗng []" begin
        input = Int[]
        res = sap_xep_chen(input)
        @test res.mang == Int[]
        @test res.tong_so_sanh == 0
        @test res.tong_dich == 0
        @test isempty(res.cac_buoc)
    end

    # --------------------------------------------------------------------------
    # TC06 (Tương ứng minh chứng A06 - Ca biên 2: Mảng 1 phần tử)
    # --------------------------------------------------------------------------
    @testset "TC06: Ca biên 2 - Mảng một phần tử [42]" begin
        input = [42]
        res = sap_xep_chen(input)
        @test res.mang == [42]
        @test res.tong_so_sanh == 0
        @test res.tong_dich == 0
        @test isempty(res.cac_buoc)
    end

    # --------------------------------------------------------------------------
    # TC07 (Tương ứng minh chứng A07 - Ca biên 3: Mảng toàn phần tử trùng nhau)
    # --------------------------------------------------------------------------
    @testset "TC07: Ca biên 3 - Mảng toàn phần tử trùng nhau [5, 5, 5, 5]" begin
        input = [5, 5, 5, 5]
        expected = [5, 5, 5, 5]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test res.tong_dich == 0               # Không xảy ra bất kỳ phép dịch nào
        @test res.tong_so_sanh == 3            # Đúng n - 1 phép so sánh khóa
    end

    # --------------------------------------------------------------------------
    # TC08 (Tương ứng minh chứng A08 - Input sai bị từ chối bởi Validator)
    # --------------------------------------------------------------------------
    @testset "TC08: Kiểm tra từ chối dữ liệu không hợp lệ (LOI01)" begin
        # Vi phạm |a[i]| <= 10^6
        @test_throws ArgumentError kiem_tra_dau_vao([1, 1000001])
        @test_throws ArgumentError sap_xep_chen([1, -1000001])

        # Vi phạm độ dài n <= 5000
        qua_dai = fill(1, 5001)
        @test_throws ArgumentError kiem_tra_dau_vao(qua_dai)

        # Dữ liệu hợp lệ trong miền biên
        hop_le_bien = [-1000000, 0, 1000000]
        @test kiem_tra_dau_vao(hop_le_bien) == true
    end

    # --------------------------------------------------------------------------
    # TC09 (Bổ sung: Ca mảng giảm dần hoàn toàn - Trường hợp xấu nhất O(n^2))
    # --------------------------------------------------------------------------
    @testset "TC09: Mảng giảm dần hoàn toàn [5, 4, 3, 2, 1]" begin
        input = [5, 4, 3, 2, 1]
        expected = [1, 2, 3, 4, 5]
        res = sap_xep_chen(input)
        @test res.mang == expected
        n = length(input)
        # Số so sánh và số dịch trường hợp xấu nhất = n*(n-1)/2
        @test res.tong_so_sanh == div(n * (n - 1), 2) # 10
        @test res.tong_dich == div(n * (n - 1), 2)    # 10
        @test issorted(res.mang)
    end

    # --------------------------------------------------------------------------
    # TC10 (Bổ sung: Ca mảng chứa số âm và số 0 theo phiếu)
    # --------------------------------------------------------------------------
    @testset "TC10: Mảng chứa số âm và số 0 [-1, -3, 0]" begin
        input = [-1, -3, 0]
        expected = [-3, -1, 0]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test issorted(res.mang)
    end

    # --------------------------------------------------------------------------
    # TC11 (Bổ sung: Ca mảng hỗn hợp âm, dương ngẫu nhiên)
    # --------------------------------------------------------------------------
    @testset "TC11: Mảng hỗn hợp âm dương [-10, 20, -5, 0, 15, -1]" begin
        input = [-10, 20, -5, 0, 15, -1]
        expected = [-10, -5, -1, 0, 15, 20]
        res = sap_xep_chen(input)
        @test res.mang == expected
        @test issorted(res.mang)
    end

    # --------------------------------------------------------------------------
    # TC12 (Bổ sung: Kiểm tra tính ổn định Stable Sort trên bản ghi)
    # --------------------------------------------------------------------------
    @testset "TC12: Kiểm tra tính ổn định với cặp (khóa, dữ liệu)" begin
        # Hai bản ghi có khóa là 2: 'A' đứng trước 'C'
        input_pairs = [(2, "A"), (1, "B"), (2, "C")]
        res_pairs = sap_xep_chen_on_dinh(input_pairs)
        # Kỳ vọng: khóa 1 đứng đầu, khóa 2 giữ nguyên 'A' trước 'C'
        @test res_pairs == [(1, "B"), (2, "A"), (2, "C")]
        @test res_pairs[2] === (2, "A")
        @test res_pairs[3] === (2, "C")
    end

end
