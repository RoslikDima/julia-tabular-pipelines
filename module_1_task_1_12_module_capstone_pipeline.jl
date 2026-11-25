# ==============================================================================
# Репозиторий: julia-tabular-pipelines
# Модуль 1 | Задача 1.12 (Финал модуля)
# Сквозная очистка и подготовка витрины продаж: unique, dropmissing, transform, sort, select
# ==============================================================================

using DataFrames

raw_registry = DataFrame(
    product  = ["Ноутбук", "Монитор", "Ноутбук", "Клавиатура", "Мышь", "Веб-камера"],
    qty      = [2, 5, 2, missing, 15, 4],
    price    = [85_000.0, 24_000.0, 85_000.0, 4_500.0, 2_200.0, 6_000.0],
    discount = [0.05, missing, 0.05, 0.0, 0.10, missing]
)

step1_unique = unique(raw_registry)
step2_no_missing_qty = dropmissing(step1_unique, :qty)

step3_calc = transform(
    step2_no_missing_qty,
    :discount => (d -> coalesce.(d, 0.0)) => :discount_clean,
    [:qty, :price, :discount] => ((q, p, d) -> q .* p .* (1.0 .- coalesce.(d, 0.0))) => :net_revenue
)

step3_enriched = transform(
    step3_calc,
    :net_revenue => (n -> ifelse.(n .>= 50_000.0, "A-класс", "B-класс")) => :tier
)

step4_sorted = sort(step3_enriched, order(:net_revenue, rev = true))
final_showcase = select(step4_sorted, :product, :qty, :net_revenue, :tier)

println(final_showcase)

@assert nrow(final_showcase) == 4 "В финальной витрине должно быть 4 уникальных товара с заполненным qty!"
@assert names(final_showcase) == ["product", "qty", "net_revenue", "tier"] "Неверный набор столбцов финальной витрины!"
@assert final_showcase.product[1] == "Ноутбук" && final_showcase.net_revenue[1] == 161_500.0 "Неверный расчёт выручки лидера!"
