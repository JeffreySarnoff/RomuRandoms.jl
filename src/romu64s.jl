const Romu64 = 0xd3833e804f4c574b  # 1_5241_094_284_759_029_579

function romu_quad(state::RomuQuadState)
    w, x, y, z = state.wstate, state.xstate, state.ystate, state.zstate
    state.wstate = Romu64 * z
    state.xstate = z + rol(w, 52)
    state.ystate = y - x
    y += w
    state.zstate = rol(y, 19)
    return state
end

function romu_trio(state::RomuTrioState)
    x, y, z = state.xstate, state.ystate, state.zstate
    state.xstate = Romu64 * z
    x = y - x
    state.ystate = rol(x, 12)  
    z -= y
    state.zstate = rol(z, 44)
    return state
end

romu_trio2(state::RomuTrioState) = romu_trio2(state.xstate, state.ystate, state.zstate)

function romu_trio2(xstate::T, ystate::T, zstate::T) where {T<:UInt64}
    xstate = Romu64 * zstate
    zstate = zstate - ystate
    zstate = rol(zstate, 44)
    ystate = ystate - xstate
    ystate = rol(ystate, 12)
    return RomuTrioState(xstate,ystate,zstate)
end    

function romu_duo(state::RomuDuoState)
    x, y = state.xstate, state.ystate
    state.xstate = Romu64 * y
    state.ystate = rol(y, 36) + rol(y, 15) - x  
    return state
end

function romu_duojr(state::RomuDuoState)
    x, y = state.xstate, state.ystate
    state.xstate = Romu64 * y
    y -= x
    state.ystate = rol(y, 27)  
    return state
end

#=

//===== RomuQuad ==================================================================================
//
// More robust than anyone could need, but uses more registers than RomuTrio.
// Est. capacity >= 2^90 bytes. Register pressure = 8 (high). State size = 256 bits.

uint64_t wState, xState, yState, zState;  // set to nonzero seed

uint64_t romuQuad_random () {
   uint64_t wp = wState, xp = xState, yp = yState, zp = zState;
   wState = 15241094284759029579u * zp; // a-mult
   xState = zp + ROTL(wp,52);           // b-rotl, c-add
   yState = yp - xp;                    // d-sub
   zState = yp + wp;                    // e-add
   zState = ROTL(zState,19);            // f-rotl
   return xp;
}


//===== RomuTrio ==================================================================================
//
// Great for general purpose work, including huge jobs.
// Est. capacity = 2^75 bytes. Register pressure = 6. State size = 192 bits.

uint64_t xState, yState, zState;  // set to nonzero seed

uint64_t romuTrio_random () {
   uint64_t xp = xState, yp = yState, zp = zState;
   xState = 15241094284759029579u * zp;
   yState = yp - xp;  yState = ROTL(yState,12);
   zState = zp - yp;  zState = ROTL(zState,44);
   return xp;
}


//===== RomuDuo ==================================================================================
//
// Might be faster than RomuTrio due to using fewer registers, but might struggle with massive jobs.
// Est. capacity = 2^61 bytes. Register pressure = 5. State size = 128 bits.

uint64_t xState, yState;  // set to nonzero seed

uint64_t romuDuo_random () {
   uint64_t xp = xState;
   xState = 15241094284759029579u * yState;
   yState = ROTL(yState,36) + ROTL(yState,15) - xp;
   return xp;
}


//===== RomuDuoJr ================================================================================
//
// The fastest generator using 64-bit arith., but not suited for huge jobs.
// Est. capacity = 2^51 bytes. Register pressure = 4. State size = 128 bits.

uint64_t xState, yState;  // set to nonzero seed

uint64_t romuDuoJr_random () {
   uint64_t xp = xState;
   xState = 15241094284759029579u * yState;
   yState = yState - xp;  yState = ROTL(yState,27);
   return xp;
}
=#
