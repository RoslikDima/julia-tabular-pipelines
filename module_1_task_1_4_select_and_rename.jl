# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.4
# Выбор, переименование и расчёт столбцов на лету с помощью select
# ==============================================================================

using DataFrames

sales_df = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty = [2, 5, 10, 15],
    price = [85_000.0, 24_000.0, 4_500.0, 2_200.0]
)

sales_report = select(
    sales_df,
    :product,
    :qty => :units_sold,
    [:qty, :price] => ((q, p) -> q .* p) => :revenue
)

println(sales_report)

@assert names(sales_report) == ["product", "units_sold", "revenue"] "Неверный набор или порядок столбцов!"
@assert sum(sales_report.revenue) == 368_000.0 "Неверная сумма выручки в отчёте!"
