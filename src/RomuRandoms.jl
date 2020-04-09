module RomuRandoms

export Romu, romu, state, setstate, 
    RomuQuadState, RomuTrioState, RomuDuoState, RomuDuoJrState, RomuQuad32State, RomuTrio32State, RomuMono32State,
    romu_quad, romu_trio, romu_duo, romu_duojr, romu_quad32, romu_trio32, romu_mono32
       

struct RomuException <: Exception
    msg::AbstractString
end

include("primitives.jl")  # rotate bits (ror, rol)
include("romu_states.jl") # setstate, state structs 
include("romu64s.jl")     # romu_quad, romu_trio, romu_duo, romu_duojr
include("romu32s.jl")     # romu_quad32, romu_trio32, romu_mono32

const Romu = RomuTrioState
const romu = romu_trio

end #  RomuRandoms
