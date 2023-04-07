import CSV
import UUIDs

growth_rate_range = LinRange(1.0, 3.0, 200)
carrying_capacity_range = [1.0]

simulation_parameters = []

for growth_rate in growth_rate_range
    for carrying_capacity in carrying_capacity_range
        simulation_id = UUIDs.uuid4()
        push!(simulation_parameters, (id=simulation_id, r=growth_rate, K=carrying_capacity))
    end
end

CSV.write("parameters.csv", simulation_parameters)