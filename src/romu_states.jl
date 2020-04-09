const uint64range = UnitRange(one(UInt64), typemax(UInt64))
const uint32range = UnitRange(one(UInt32), typemax(UInt32))
    
const mono32mask   = 0x1fffffff    # 536_870_911
const mono32offset = 0x44f619d0    # 1_156_979_152

mutable struct RomuQuadState
    wstate::UInt64
    xstate::UInt64
    ystate::UInt64
    zstate::UInt64
end

mutable struct RomuTrioState
    xstate::UInt64
    ystate::UInt64
    zstate::UInt64
end

mutable struct RomuDuoState
    xstate::UInt64
    ystate::UInt64
end

mutable struct RomuDuoJrState
    xstate::UInt64
    ystate::UInt64
end

mutable struct RomuQuad32State
    wstate::UInt32
    xstate::UInt32
    ystate::UInt32
    zstate::UInt32
end

mutable struct RomuTrio32State
    xstate::UInt32
    ystate::UInt32
    zstate::UInt32
end

mutable struct RomuMono32State
    xstate::UInt32
end


function setstate(::Type{RomuQuadState}, w::T=0, x::T=0, y::T=0, z::T=0) where {T<:UInt64}
    validate(RomuQuadState, w, x, y, z)
    return RomuQuadState(w, x, y, z)
end

function setstate(::Type{RomuTrioState}, x::T=0, y::T=0, z::T=0) where {T<:UInt64}
    validate(RomuTrioState, x, y, z)
    return RomuTrioState(w, x, y, z)
end

function setstate(::Type{RomuDuoState}, x::T=0, y::T=0) where {T<:UInt64}
    validate(RomuDuoState, x, y)
    return RomuDuoState(x, y)
end

function setstate(::Type{RomuDuoJrState}, x::T=0, y::T=0) where {T<:UInt64}
    validate(RomuDuoJrState, x, y)
    return RomuDuoJrState(x, y)
end

function setstate(::Type{RomuQuad32State}, w::T=0, x::T=0, y::T=0, z::T=0) where {T<:UInt32}
    validate(RomuQuad32State, w, x, y, z)
    return RomuQuad32State(w, x, y, z)
end

function setstate(::Type{RomuTrio32State}, x::T=0, y::T=0, z::T=0) where {T<:UInt32}
    validate(RomuTrio32State, x, y, z)
    return RomuTrio32State(w, x, y, z)
end

function setstate(::Type{RomuMono32State}, x::T=0) where {T<:UInt32}
    validate(RomuMono32State, x)
    x = x & mono32mask
    x = x + mono32offset
    return RomuMono32State(x)
end

setstate(::Type{RomuQuadState}) = setstate(RomuQuadState, rand(uint64range, 4)...)
setstate(::Type{RomuTrioState}) = setstate(RomuTrioState, rand(uint64range, 3)...)
setstate(::Type{RomuDuoState}) = setstate(RomuDuoState, rand(uint64range, 2)...)
setstate(::Type{RomuDuoJrState}) = setstate(RomuDuoJrState, rand(uint64range, 2)...)
setstate(::Type{RomuQuad32State}) = setstate(RomuQuad32State, rand(uint32range, 4)...)
setstate(::Type{RomuTrio32State}) = setstate(RomuTrio32State, rand(uint32range, 3)...)
setstate(::Type{RomuMono32State}) = setstate(RomuMono32State, (rand(uint32range) & mono32mask) + mono32offset)

    
validate(::Type{RomuQuadState}, w::T=0, x::T=0, y::T=0, z::T=0) where {T<:UInt64} =
   if iszero(w) || iszero(x) || iszero(y) || iszero(z)
       throw(RomuException("All four states must be initialized to nonzero values."))
   else
       nothing
   end

validate(::Type{RomuTrioState}, x::T=0, y::T=0, z::T=0) where {T<:UInt64} =
   if iszero(x) || iszero(y) || iszero(z)
       throw(RomuException("All three states must be initialized to nonzero values."))
   else
       nothing
   end

validate(::Type{RomuDuoState}, x::T=0, y::T=0) where {T<:UInt64} =
   if iszero(x) || iszero(y)
       throw(RomuException("Both states must be initialized to nonzero values."))
   else
       nothing
   end

validate(::Type{RomuDuoJrState}, x::T=0, y::T=0) where {T<:UInt64} =
   if iszero(x) || iszero(y)
       throw(RomuException("Both states must be initialized to nonzero values."))
   else
       nothing
   end

validate(::Type{RomuQuad32State}, w::T=0, x::T=0, y::T=0, z::T=0) where {T<:UInt32} =
   if iszero(w) || iszero(x) || iszero(y) || iszero(z)
       throw(RomuException("All four states must be initialized to nonzero values."))
   else
       nothing
   end

validate(::Type{RomuTrio32State}, x::T=0, y::T=0, z::T=0) where {T<:UInt32} =
   if iszero(x) || iszero(y) || iszero(z)
       throw(RomuException("All three states must be initialized to nonzero values."))
   else
       nothing
   end

validate(::Type{RomuMono32State}, x::T=0) where {T<:UInt32} =
   if iszero(x)
       throw(RomuException("The state must be initialized to a nonzero value."))
   else
       nothing
   end
