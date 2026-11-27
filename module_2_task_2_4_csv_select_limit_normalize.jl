# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 2 | Задача 2.4
# Выборочное чтение столбцов и строк CSV: select, limit, normalizenames
# ==============================================================================

using CSV, DataFrames

wide_csv_path = joinpath(tempdir(), "wide_sales_2_4.csv")

wide_sales_text = """
Product Name;Tech UUID;Total Qty;Gross Revenue
Ноутбук;uuid-001;2;170000.0
Монитор;uuid-002;5;120000.0
Клавиатура;uuid-003;10;45000.0
Мышь;uuid-004;15;33000.0
"""
write(wide_csv_path, wide_sales_text)

sample_sales = CSV.read(
    wide_csv_path,
    DataFrame;
    delim          = ';',
    normalizenames = true,
    select         = [:Product_Name, :Gross_Revenue],
    limit          = 3
)

println(sample_sales)

@assert size(sample_sales) == (3, 2) "Должно быть загружено ровно 3 строки и 2 столбца!"
@assert names(sample_sales) == ["Product_Name", "Gross_Revenue"] "Заголовки должны быть нормализованы и отфильтрованы!"
@assert sample_sales.Gross_Revenue[3] == 45_000.0 "Третьей строкой должна быть Клавиатура с выручкой 45000.0!"
