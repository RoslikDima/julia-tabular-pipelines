# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 2 | Задача 2.1
# Базовая запись и чтение CSV-файлов: CSV.write и CSV.read(..., DataFrame)
# ==============================================================================

using CSV, DataFrames

export_sales = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty     = [2, 5, 10, 15],
    price   = [85_000.0, 24_000.0, 4_500.0, 2_200.0]
)

csv_path = joinpath(tempdir(), "sales_export_2_1.csv")
CSV.write(csv_path, export_sales)

imported_sales = CSV.read(csv_path, DataFrame)

println(imported_sales)
println("Типы столбцов: ", eltype.(eachcol(imported_sales)))

@assert isfile(csv_path) "CSV-файл не был создан на диске!"
@assert imported_sales == export_sales "Прочитанная таблица должна полностью совпадать с исходной!"
