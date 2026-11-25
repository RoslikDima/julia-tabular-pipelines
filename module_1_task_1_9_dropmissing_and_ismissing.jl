# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.9
# Подсчёт пропусков (ismissing.) и удаление неполных строк (dropmissing)
# ==============================================================================

using DataFrames

raw_sales = DataFrame(
    product = ["Ноутбук", "Монитор", "Клавиатура", "Мышь"],
    qty     = [2, missing, 10, 15],
    price   = [85_000.0, 24_000.0, missing, 2_200.0]
)

missing_prices = sum(ismissing.(raw_sales.price))
complete_sales = dropmissing(raw_sales)

println("Пропусков в столбце price: ", missing_prices)
println("Таблица без пропусков:\n", complete_sales)

@assert missing_prices == 1 "Неверное количество пропусков в столбце price!"
@assert nrow(complete_sales) == 2 && complete_sales.product == ["Ноутбук", "Мышь"] "Неверный результат dropmissing!"
