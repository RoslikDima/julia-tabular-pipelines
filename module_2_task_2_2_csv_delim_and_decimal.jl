# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 2 | Задача 2.2
# Настройка разделителя столбцов (delim) и дробной части (decimal) в CSV.jl
# ==============================================================================

using CSV, DataFrames

ru_sales = DataFrame(
    product = ["Ноутбук", "Монитор", "Мышь"],
    qty     = [2, 5, 15],
    price   = [85_000.50, 24_150.75, 2_200.90]
)

ru_csv_path = joinpath(tempdir(), "ru_sales_2_2.csv")
CSV.write(ru_csv_path, ru_sales; delim = ';', decimal = ',')

ru_imported = CSV.read(ru_csv_path, DataFrame; delim = ';', decimal = ',')
println(read(ru_csv_path, String))
println(ru_imported)

@assert eltype(ru_imported.price) == Float64 "Столбец price должен распознаться как число Float64, а не строка!"
@assert ru_imported == ru_sales "Прочитанная таблица должна точно совпадать с исходной!"
