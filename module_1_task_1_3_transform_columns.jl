# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.3
# Добавление расчётных столбцов с помощью transform и правил src => fn => dst
# ==============================================================================

using DataFrames

sales_df = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty = [2, 5, 10, 15],
    price = [85_000.0, 24_000.0, 4_500.0, 2_200.0]
)

sales_calc = transform(
    sales_df,
    [:qty, :price] => ((q, p) -> q .* p) => :revenue,
    :price => (p -> p .* 1.2) => :price_vat
)

println(sales_calc)

@assert ncol(sales_df) == 3 "Исходная таблица sales_df не должна мутировать!"
@assert sum(sales_calc.revenue) == 368_000.0 "Неверная общая выручка!"
@assert ncol(sales_calc) == 5 "В таблице должно стать 5 столбцов!"
