return {
    descriptions = {
        Joker = {
            j_sj_purple_ticket = {
                name = "Purple Ticket",
                text = {
                    "Scoring with a {C:purple}purple seal{} card",
                    "gives a {C:tarot}tarot{} card",
                    "Has a small chance to be a {C:dark_edition}negative{}.",
                },
            },
            j_sj_cigarettes = {
                name = "Cigarettes",
                text = {
                    "Gives a {X:mult,C:white} X5 {} Mult",
                    "Lose a{C:blue} hand size {}each 3 hands played",
                },
            },
            j_sj_dawn = {
                name = "Dawn",
                text = {
                    "Retrigger all played cards",
                    "in {C:attention}first hand{} of the round",
                },
            },
            j_sj_iron_factory = {
                name = "Iron Factory",
                text = {
                    "When an iron card scores,",
                    "add {X:mult,C:white} +0.1{} to the XMult",
                },
            },
        }
    },
    misc = {

            -- do note that when using messages such as: 
            -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
            -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file.


        dictionary = {
            a_chips="+#1#",
            a_chips_minus="-#1#",
            a_hands="+#1# Hands",
            a_handsize="+#1# Hand Size",
            a_handsize_minus="-#1# Hand Size",
            a_mult="+#1# Mult",
            a_mult_minus="-#1# Mult",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# Mult",
            a_xmult_minus="-X#1# Mult",
        }
    }
}