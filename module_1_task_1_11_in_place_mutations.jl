# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.11
# Мутирующие операции на месте в памяти: transform! и sort!
# ==============================================================================

using DataFrames

mutable_sales = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty     = [2, 5, 10, 15],
    price   = [85_000.0, 24_000.0, 4_500.0, 2_200.0]
)

transform!(mutable_sales, [:qty, :price] => ((q, p) -> q .* p) => :revenue)
sort!(mutable_sales, order(:revenue, rev = true))

println(mutable_sales)

@assert "revenue" in names(mutable_sales) "Столбец revenue должен появиться в исходной таблице!"
@assert mutable_sales.product[1] == "Ноутбук" && mutable_sales.revenue[1] == 170_000.0 "Неверный порядок строк после sort!"
