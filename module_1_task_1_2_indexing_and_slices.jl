# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.2
# Векторизованный доступ к столбцам (df.col) и срезы строк/столбцов (df[1:2, :])
# ==============================================================================

using DataFrames

sales_df = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty = [2, 5, 10, 15],
    price = [85_000.0, 24_000.0, 4_500.0, 2_200.0]
)

total_qty = sum(sales_df.qty)
first_two = sales_df[1:2, :]
price_list = sales_df[:, [:product, :price]]

println("Всего продано единиц: ", total_qty)
println("Первые две позиции:\n", first_two)
println("Прайс-лист:\n", price_list)

@assert total_qty == 32 "Неверное общее количество товаров!"
@assert ncol(price_list) == 2 && nrow(first_two) == 2 "Неверная размерность срезов!"
