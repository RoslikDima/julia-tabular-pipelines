# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.8
# Работа с пропусками: skipmissing и векторизованная замена через coalesce.(...)
# ==============================================================================

using DataFrames

raw_sales = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty     = [2, missing, 10, 15],
    price   = [85_000.0, 24_000.0, missing, 2_200.0]
)

known_qty = sum(skipmissing(raw_sales.qty))

clean_sales = transform(
    raw_sales,
    :qty => (q -> coalesce.(q, 0)) => :qty_clean,
    :price => (p -> coalesce.(p, 0.0)) => :price_clean
)

println("Сумма известных количеств: ", known_qty)
println(clean_sales)

@assert known_qty == 27 "Неверная сумма известных количеств!"
@assert sum(clean_sales.qty_clean) == 27 && sum(clean_sales.price_clean) == 111_200.0 "Неверная очистка пропусков!"
