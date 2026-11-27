# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 2 | Задача 2.5
# Чтение вектора CSV-файлов за один вызов и метка источника source
# ==============================================================================

using CSV, DataFrames

jan_path = joinpath(tempdir(), "sales_jan_2_5.csv")
feb_path = joinpath(tempdir(), "sales_feb_2_5.csv")

CSV.write(jan_path, DataFrame(
    product = ["Ноутбук", "Монитор"],
    revenue = [170_000.0, 120_000.0]
))

CSV.write(feb_path, DataFrame(
    product = ["Ноутбук", "Клавиатура"],
    revenue = [255_000.0, 45_000.0]
))

q1_sales = CSV.read([jan_path, feb_path], DataFrame; source = :batch_file)
println(q1_sales)

@assert nrow(q1_sales) == 4 "Объединённая таблица должна содержать 4 строки из двух файлов!"
@assert names(q1_sales) == ["product", "revenue", "batch_file"] "Должен добавиться столбец batch_file с источником!"
@assert sum(q1_sales.revenue) == 590_000.0 "Суммарная выручка по двум файлам должна быть равна 590000.0!"
