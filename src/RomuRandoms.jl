module RomuRandoms

export romu, romuquad, romutrio, romuduo, romuduojr, romuquad32, romutrio32, romumono32

struct RomuException <: exception
    msg::AbstractString
end

include("primitives.jl")  # rotate bits (ror, rol)
include("romu_states.jl") # setstate, state structs 
include("romu64s.jl")     # romuquad, romutrio, romuduo, romuduojr
include("romu32s.jl")     # romuquad32, romutrio32, romumono32

const romu = romutrio

end #  RomuRandoms
