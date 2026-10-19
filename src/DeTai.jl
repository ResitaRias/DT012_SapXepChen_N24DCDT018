module DeTai

using Printf

export kiem_tra_dau_vao, giai_bai, sap_xep_chen, sap_xep_chen!, chen_vao_doan!, lan_vet_chen, sap_xep_chen_on_dinh

"""
    kiem_tra_dau_vao(a)

Kiểm tra tính hợp lệ của dữ liệu đầu vào theo đúng hợp đồng trong phiếu đề tài DT012:
- `a`: mảng một chiều (Vector) chứa các số nguyên (`Integer`).
- Kích thước: `0 <= length(a) <= 5000`.
- Miền giá trị: `|a[i]| <= 10^6` với mọi phần tử.
Ném ngoại lệ `ArgumentError` nếu dữ liệu vi phạm bất kỳ điều kiện nào trên.
Trả về `true` nếu hợp lệ.
"""
function kiem_tra_dau_vao(a)
    (a isa AbstractVector) || throw(ArgumentError("Du lieu dau vao phai la mang mot chieu (Vector)."))
    n = length(a)
    (0 <= n <= 5000) || throw(ArgumentError("Kich thuoc mang phai nam trong pham vi 0..5000 (hien tai n = $n)."))
    for (idx, x) in enumerate(a)
        (x isa Integer) || throw(ArgumentError("Phan tu tai chi so $idx khong phai la so nguyen."))
        abs(x) <= 10^6 || throw(ArgumentError("Phan tu tai chi so $idx co gia tri |x| > 10^6 (x = $x)."))
    end
    return true
end

"""
    chen_vao_doan!(a, i)

Chèn phần tử `x = a[i]` vào đoạn đầu đã được sắp xếp tăng dần `a[1:i-1]`.
- Dịch chuyển các phần tử `a[j] > x` sang phải một vị trí (`a[j+1] = a[j]`).
- ĐIỀU KIỆN QUAN TRỌNG: Chỉ dịch khi `a[j] > x` (lớn hơn nghiêm ngặt), KHÔNG dịch khi `a[j] == x`
  để bảo toàn tính ổn định (Stable Sort).
- Đếm riêng số lần so sánh khóa và số lần dịch phần tử.
- Trả về `NamedTuple` chứa thông tin của lượt chèn:
  `(; buoc = i, khoa = x, vi_tri_chen = j + 1, so_so_sanh, so_dich, phan_tu_dich)`
"""
function chen_vao_doan!(a::AbstractVector{<:Integer}, i::Integer)
    x = a[i]
    j = i - 1
    so_so_sanh = 0
    so_dich = 0
    phan_tu_dich = Int[]

    # Vòng lặp lùi: so sánh chỉ số j >= 1 trước khi truy cập a[j]
    while j >= 1
        so_so_sanh += 1 # Đếm so sánh khóa
        if a[j] > x
            a[j + 1] = a[j]
            push!(phan_tu_dich, a[j])
            so_dich += 1
            j -= 1
        else
            break # Dừng ngay khi gặp phần tử a[j] <= x (không dịch khóa bằng nhau)
        end
    end
    vi_tri_chen = j + 1
    a[vi_tri_chen] = x
    tien_to = copy(a[1:i])

    return (; buoc = i, khoa = x, vi_tri_chen, so_so_sanh, so_dich, phan_tu_dich, tien_to)
end

"""
    sap_xep_chen!(a; kiem_tra=true)

Sắp xếp mảng `a` tại chỗ (in-place) theo thuật toán sắp xếp chèn trực tiếp (Insertion Sort).
- Bất biến: Sau lượt `i`, tiền tố `a[1:i]` luôn được sắp xếp tăng dần.
- Trả về `NamedTuple`:
  `(; mang = a, tong_so_sanh, tong_dich, cac_buoc)`
"""
function sap_xep_chen!(a::AbstractVector{<:Integer}; kiem_tra::Bool=true)
    if kiem_tra
        kiem_tra_dau_vao(a)
    end
    n = length(a)
    cac_buoc = []
    tong_so_sanh = 0
    tong_dich = 0

    if n <= 1
        return (; mang = a, tong_so_sanh = 0, tong_dich = 0, cac_buoc)
    end

    for i in 2:n
        buoc = chen_vao_doan!(a, i)
        push!(cac_buoc, buoc)
        tong_so_sanh += buoc.so_so_sanh
        tong_dich += buoc.so_dich
    end

    return (; mang = a, tong_so_sanh, tong_dich, cac_buoc)
end

"""
    sap_xep_chen(a; kiem_tra=true)

Phiên bản không làm thay đổi mảng gốc `a` (tạo bản sao trước khi sắp xếp).
"""
function sap_xep_chen(a::AbstractVector{<:Integer}; kiem_tra::Bool=true)
    b = copy(a)
    return sap_xep_chen!(b; kiem_tra)
end

"""
    giai_bai(du_lieu)

Hàm chuẩn theo khung đề tài: nhận `du_lieu` (mảng số nguyên), thực hiện sắp xếp và trả về mảng kết quả.
"""
function giai_bai(du_lieu)
    kq = sap_xep_chen(du_lieu)
    return kq.mang
end

"""
    lan_vet_chen(a; in_ra=true)

Thực hiện lần vết từng bước thuật toán sắp xếp chèn trên mảng `a`.
In bảng trạng thái chi tiết theo đúng yêu cầu minh chứng C2, C3 của phiếu:
- Khóa chèn (x)
- Các phần tử bị dịch sang phải
- Vị trí chèn mới
- Tiền tố mảng sau khi chèn
"""
function lan_vet_chen(a::AbstractVector{<:Integer}; in_ra::Bool=true)
    kiem_tra_dau_vao(a)
    b = copy(a)
    n = length(b)
    kq = sap_xep_chen!(b; kiem_tra=false)

    if in_ra
        println("="^75)
        println("LẦN VẾT THUẬT TOÁN SẮP XẾP CHÈN TRỰC TIẾP TRÊN MẢNG: ", a)
        println("="^75)
        println("Khởi tạo ban đầu: a = ", a)
        if n <= 1
            println("Mảng có $n phần tử, không cần chèn.")
        else
            println("-"^75)
            @printf("%-6s | %-10s | %-18s | %-10s | %-20s\n", "Lượt i", "Khóa (x)", "Phần tử dịch", "Vị trí mới", "Tiền tố a[1:i]")
            println("-"^75)
            for (idx, b_info) in enumerate(kq.cac_buoc)
                dich_str = isempty(b_info.phan_tu_dich) ? "(khong)" : string(b_info.phan_tu_dich)
                tien_to_str = string(b_info.tien_to)
                @printf("%-6d | %-10d | %-18s | %-10d | %-20s\n", b_info.buoc, b_info.khoa, dich_str, b_info.vi_tri_chen, tien_to_str)
            end
            println("-"^75)
        end
        println("Kết quả sau cùng: a = ", kq.mang)
        println("Tổng số lần so sánh khóa: ", kq.tong_so_sanh)
        println("Tổng số lần dịch phần tử: ", kq.tong_dich)
        println("="^75)
    end

    return kq
end

"""
    sap_xep_chen_on_dinh(a_pairs)

Yêu cầu thêm tùy chọn: Chèn trên mảng chứa cặp `(khoa, du_lieu)`.
Minh chứng tính ổn định: Khi hai phần tử có khóa bằng nhau, thuật toán KHÔNG đổi chỗ chúng.
"""
function sap_xep_chen_on_dinh(a::AbstractVector{Tuple{K, V}}) where {K, V}
    b = copy(a)
    n = length(b)
    if n <= 1
        return b
    end
    for i in 2:n
        x = b[i]
        j = i - 1
        # Điều kiện nghiêm ngặt b[j][1] > x[1] đảm bảo tính ổn định
        while j >= 1 && b[j][1] > x[1]
            b[j + 1] = b[j]
            j -= 1
        end
        b[j + 1] = x
    end
    return b
end

end # module DeTai
