# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 2 | Задача 2.3
# Тонкая настройка чтения CSV: header, skipto, missingstring и словарь types
# ==============================================================================

using CSV, DataFrames

dirty_csv_path = joinpath(tempdir(), "dirty_export_2_3.csv")

raw_export_text = """
Выгрузка склада №1
Период: Ноябрь 2026
article;stock_qty;comment
код;шт.;текст
00105;25;В наличии
00208;Н/Д;Ожидается поставка
00319;0;NULL
"""
write(dirty_csv_path, raw_export_text)

parsed_stock = CSV.read(
    dirty_csv_path,
    DataFrame;
    delim         = ';',
    header        = 3,
    skipto        = 5,
    missingstring = ["", "Н/Д", "NULL"],
    types         = Dict(:article => String)
)

println(parsed_stock)

@assert nrow(parsed_stock) == 3 "Должно быть прочитано ровно 3 строки данных!"
@assert parsed_stock.article[1] == "00105" "Ведущие нули в артикуле должны сохраниться!"
@assert ismissing(parsed_stock.stock_qty[2]) && ismissing(parsed_stock.comment[3]) "Маркеры Н/Д и NULL должны стать missing!"
