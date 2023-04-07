import CSV
import JLD
import ProgressMeter

if ~isfile("parameters.csv")
    include("00_make_parameters.jl")
end

if ~isdir("results")
    mkdir("results")
end

function bifurcation_diagram(r, K; t=2_000, retain=500)
    n = zeros(Float64, t+1)
    n[begin] = K/100.0
    for step in 1:t
        n[step+1] = n[step] + n[step] * r * (1 - n[step]/K)
    end
    return unique(n[(t-retain):end])
end

parameters = CSV.File("parameters.csv")

progressbar = ProgressMeter.Progress(length(parameters));

Threads.@threads for simulation_parameters in parameters
    id, r, K = simulation_parameters
    n = bifurcation_diagram(r, K)
    results_path = joinpath("results", "$(id).jld")
    JLD.save(results_path, "values", n, "parameters", (r, K))
    ProgressMeter.next!(progressbar)
end