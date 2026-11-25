# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.10
# Поиск и удаление дубликатов с помощью nonunique и unique
# ==============================================================================

using DataFrames

dup_sales = DataFrame(
    product = ["Ноутбук", "Монитор", "Ноутбук", "Мышь", "Монитор"],
    qty     = [2, 5, 2, 15, 8],
    price   = [85_000.0, 24_000.0, 85_000.0, 2_200.0, 24_000.0]
)

full_dups = sum(nonunique(dup_sales))
dedup_rows = unique(dup_sales)
unique_products = unique(dup_sales, :product)

println("Найдено полных дубликатов: ", full_dups)
println("Таблица без полных дубликатов:\n", dedup_rows)
println("Справочник уникальных товаров:\n", unique_products)

@assert full_dups == 1 "Должен быть найден ровно 1 полный дубликат!"
@assert nrow(dedup_rows) == 4 && nrow(unique_products) == 3 "Неверное количество строк после дедупликации!"
