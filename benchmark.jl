include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Random
using Printf

function chay_khao_sat()
    Random.seed!(42) # Cố định seed để kết quả có thể tái lập chính xác
    sizes = [10, 100, 500, 1000]
    
    println("="^85)
    println("BẢNG KHẢO SÁT THỰC NGHIỆM ĐỀ TÀI DT012 TRÊN CÁC QUY MÔ N = 10, 100, 500, 1000")
    println("="^85)
    @printf("%-6s | %-15s | %-15s | %-15s | %-15s\n", "n", "Dạng dữ liệu", "Số so sánh khóa", "Số lần dịch", "Thời gian (μs)")
    println("-"^85)

    for n in sizes
        # 1. Mảng đã tăng sẵn (Best case: O(n))
        a_tang = collect(1:n)
        t1 = @elapsed res_tang = sap_xep_chen(a_tang)
        @printf("%-6d | %-15s | %-15d | %-15d | %-15.2f\n", n, "Đã tăng sẵn", res_tang.tong_so_sanh, res_tang.tong_dich, t1 * 1e6)

        # 2. Mảng gần tăng (Nearly sorted: O(n))
        a_gan = collect(1:n)
        num_swaps = max(1, div(n, 20)) # Đảo khoảng 5% số cặp kề
        for _ in 1:num_swaps
            idx = rand(1:n-1)
            a_gan[idx], a_gan[idx+1] = a_gan[idx+1], a_gan[idx]
        end
        t2 = @elapsed res_gan = sap_xep_chen(a_gan)
        @printf("%-6d | %-15s | %-15d | %-15d | %-15.2f\n", n, "Gần tăng (5%)", res_gan.tong_so_sanh, res_gan.tong_dich, t2 * 1e6)

        # 3. Mảng giảm dần (Worst case: O(n^2))
        a_giam = collect(n:-1:1)
        t3 = @elapsed res_giam = sap_xep_chen(a_giam)
        @printf("%-6d | %-15s | %-15d | %-15d | %-15.2f\n", n, "Giảm dần", res_giam.tong_so_sanh, res_giam.tong_dich, t3 * 1e6)
        println("-"^85)
    end
end

chay_khao_sat()
