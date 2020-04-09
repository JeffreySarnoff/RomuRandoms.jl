module RomuRandoms

export romu, state, setstate, 
    RomuQuad, RomuTrio, RomuDuo, RomuDuoJr, RomuQuad32, RomuTrio32, RomuMono32,
    romu_quad, romu_trio, romu_duo, romu_duojr, romu_quad32, romu_trio32, romu_mono32
       

struct RomuException <: Exception
    msg::AbstractString
end

include("primitives.jl")  # rotate bits (ror, rol)
include("romu_states.jl") # setstate, state structs 
include("romu64s.jl")     # romuquad, romutrio, romuduo, romuduojr
include("romu32s.jl")     # romuquad32, romutrio32, romumono32

const romu = romutrio

end #  RomuRandoms
