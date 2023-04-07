import JLD
import ProgressMeter
using CairoMakie

CairoMakie.activate!(; px_per_unit = 2)

results_files = filter(endswith(".jld"), readdir("results"; join=true))

r = Float64[]
n = Float64[]

ProgressMeter.@showprogress "Reading the results" for result in results_files
    pop_size = JLD.load(result, "values")
    growth_rate = fill(JLD.load(result, "parameters")[1], length(pop_size))
    append!(n, pop_size)
    append!(r, growth_rate)
end

scatter(r, n; color=:black)
current_figure()

save("bifurcation.png", current_figure())