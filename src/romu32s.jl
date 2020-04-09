const Romu32 = 0xc61d672b    # 3_323_815_723

function romu_quad32(state::RomuQuad32State)
    w, x, y, z = state.wstate, state.xstate, state.ystate, state.zstate
    state.wstate = Romu32 * z
    state.xstate = z + rol(w, 26)
    state.ystate = y - x
    y += w
    state.zstate = rol(y, 9)
    return state
end

function romu_trio32(state::RomuTrio32State)
    x, y, z = state.xstate, state.ystate, state.zstate
    state.xstate = Romu32 * z
    x = y - x
    state.ystate = rol(x, 6)  
    z -= y
    state.zstate = rol(z, 22)
    return state
end

function romu_mono32(state::RomuMono32State)
    x = state.xstate
    x = x >> 16
    x = x * Romu32
    x = rol(x, 12)
    state.xstate = x
    return state
end

#=


//===== RomuQuad32 ================================================================================
//
// 32-bit arithmetic: Good for general purpose use.
// Est. capacity >= 2^62 bytes. Register pressure = 7. State size = 128 bits.

uint32_t wState, xState, yState, zState;  // set to nonzero seed

uint32_t romuQuad32 () {
   uint32_t wp = wState, xp = xState, yp = yState, zp = zState;
   wState = 3323815723u * zp;  // a-mult
   xState = zp + ROTL(wp,26);  // b-rotl, c-add
   yState = yp - xp;           // d-sub
   zState = yp + wp;           // e-add
   zState = ROTL(zState,9);    // f-rotl
   return xp;
}


//===== RomuTrio32 ===============================================================================
//
// 32-bit arithmetic: Good for general purpose use, except for huge jobs.
// Est. capacity >= 2^53 bytes. Register pressure = 5. State size = 96 bits.

uint32_t xState, yState, zState;  // set to nonzero seed

uint32_t romuTrio32_random () {
   uint32_t xp = xState, yp = yState, zp = zState;
   xState = 3323815723u * zp;
   yState = yp - xp; yState = ROTL(yState,6);
   zState = zp - yp; zState = ROTL(zState,22);
   return xp;
}


//===== RomuMono32 ===============================================================================
//
// 32-bit arithmetic: Suitable only up to 2^26 output-values. Outputs 16-bit numbers.
// Fixed period of (2^32)-47. Must be seeded using the romuMono32_init function.
// Capacity = 2^27 bytes. Register pressure = 2. State size = 32 bits.

uint32_t state;

void romuMono32_init (uint32_t seed) {
   state = (seed & 0x1fffffffu) + 1156979152u;  // Accepts 29 seed-bits.
}

uint16_t romuMono32_random () {
   uint16_t result = state >> 16;
   state *= 3611795771u;  state = ROTL(state,12);
   return result;
}
=#
