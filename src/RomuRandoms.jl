module RomuRandoms

export Romu, romu, state, setstate, 
    RomuQuad, RomuTrio, RomuDuo, RomuDuoJr, RomuQuad32, RomuTrio32, RomuMono32,
    romu_quad, romu_trio, romu_duo, romu_duojr, romu_quad32, romu_trio32, romu_mono32
       

struct RomuException <: Exception
    msg::AbstractString
end

include("primitives.jl")  # rotate bits (ror, rol)
include("romu_states.jl") # setstate, state structs 
include("romu64s.jl")     # romu_quad, romu_trio, romu_duo, romu_duojr
include("romu32s.jl")     # romu_quad32, romu_trio32, romu_mono32

const Romu = RomuTrio
const romu = romu_trio

end #  RomuRandoms
