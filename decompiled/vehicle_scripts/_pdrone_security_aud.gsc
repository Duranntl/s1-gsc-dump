// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

snd_pdrone_security_constructor()
{
    var_0 = 1.0;
    var_1 = 0.8;
    var_2 = 0;
    var_3 = 10;
    var_4 = 15;
    var_5 = var_4 - var_2;
    var_6 = 0.7;
    var_7 = 1.0;
    var_8 = 0.8;
    var_9 = 1.0;
    var_10 = 1.1;
    var_11 = 0.0;
    var_12 = 0.5;
    var_13 = 0.85;
    var_14 = 1.0;
    var_15 = 0.0;
    var_16 = 0.5;
    var_17 = 1.0;
    var_18 = 0.8;
    var_19 = 1.1;
    var_20 = 0.0;
    var_21 = 1.0;
    var_22 = 0.5;
    var_23 = 1.5;
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "pdrone_security" );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 3 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sdrone_thrusters_lw" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "sdrone_thrusters_lw" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_loopset_vol_env" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sdrone_thrusters_md" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "sdrone_thrusters_hi" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_loopset_vol_env" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sdrone_thrusters_hi" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "sdrone_thrusters_md" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_loopset_vol_env" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sdrone_thrusters_main_lp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_rotor_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_loopset_vol_env" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated", 0.65, 0.3 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();

    if ( !level.currentgen )
    {
        soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "sdrone_thrusters_whine_lp" );
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.65, 0.3 );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_whine_vel2vol" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated", 0.65, 0.3 );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_end_loop_def();
        soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "pdrone_security_pink_hipass_lp" );
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_noise_hi_vel2vol" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "distance" );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_noise_hi_dist2vol" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated", 0.65, 0.3 );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_end_loop_def();
        soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "pdrone_security_pink_lopass_lp" );
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_noise_lo_vel2vol" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "distance" );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_noise_lo_dist2vol" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated", 0.65, 0.3 );
        soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
        soundscripts\_audio_vehicle_manager::avm_end_param_map();
        soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    }

    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "pdrone_security_flyby", "pdrone_security_flyby_duck_envelope", 0.25, 1, [ "sdrone_by_1", "sdrone_by_2" ] );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_flyby_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_flyby_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "foo_oneshot", "pdrone_security_flyby_duck_envelope", 0.25, 1, [ "sdrone_by_1", "sdrone_by_2" ] );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_flyby_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "pdrone_security_flyby_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "doppler_exaggerated", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "pdrone_security_doppler2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_hover", ::pdrone_security_condition_callback_to_state_hover, [ "speed", "distance2d" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_flying", ::pdrone_security_condition_callback_to_state_flying, [ "speed", "distance2d" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "foo_oneshot" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_distant", ::pdrone_security_condition_callback_to_state_distant, [ "distance2d" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "sdrone_thrusters_main_lp" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_flyby", ::pdrone_security_condition_callback_to_state_flyby, [ "distance2d" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );

    if ( !0 )
        soundscripts\_audio_vehicle_manager::avm_add_oneshots( "pdrone_security_flyby" );

    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_deathspin", ::pdrone_security_condition_callback_to_state_deathspin );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_destruct", ::pdrone_security_condition_callback_to_state_destruct );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_off", ::pdrone_security_condition_callback_to_state_off );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "NONE" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_oneshots", "state_hover", "to_state_hover", 50, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_off" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flying", "to_state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_deathspin", "to_state_deathspin" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_deathspin", "to_state_deathspin" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flying", "to_state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_deathspin", "to_state_deathspin" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_flyby", 3.0 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_hover", "to_state_hover" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flying", "to_state_flying" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_flyby", "to_state_flyby" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_distant", "to_state_distant" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_deathspin", "to_state_deathspin" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_deathspin" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_destruct", "to_state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_destruct" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_off", "to_state_off" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_foo_env_function", ::foo_env_function );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_loopset_vol_env", [ [ var_4 * 0.0, 0.65 * var_0 ], [ var_4 * 0.0204, 0.66155 * var_0 ], [ var_4 * 0.0816, 0.670545 * var_0 ], [ var_4 * 0.1836, 0.688885 * var_0 ], [ var_4 * 0.3265, 0.72749 * var_0 ], [ var_4 * 0.5102, 0.80554 * var_0 ], [ var_4 * 0.7346, 0.926535 * var_0 ], [ var_4 * 1.0, 1.0 * var_0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "sdrone_thrusters_lw", [ [ var_4 * 0.0, 1.0 ], [ var_4 * 0.333, 1.0 ], [ var_4 * 0.666, 0.0 ], [ var_4 * 1.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "sdrone_thrusters_md", [ [ var_4 * 0.0, 0.0 ], [ var_4 * 0.333, 1.0 ], [ var_4 * 0.666, 1.0 ], [ var_4 * 1.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "sdrone_thrusters_hi", [ [ var_4 * 0.0, 0.0 ], [ var_4 * 0.333, 0.0 ], [ var_4 * 0.666, 1.0 ], [ var_4 * 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_rotor_vel2vol", [ [ var_2, var_6 ], [ var_4, var_7 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_rotor_vel2pch", [ [ var_2, var_8 ], [ var_3, var_9 ], [ var_4, var_10 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_whine_vel2vol", [ [ var_2, var_11 ], [ var_2 + ( var_4 - var_2 ) * 0.666, var_11 + ( var_12 - var_11 ) * 0.0 ], [ var_4, var_12 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_whine_vel2pch", [ [ var_2, var_13 ], [ var_4, var_14 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_noise_lo_vel2vol", [ [ var_2, var_15 ], [ var_2 + ( var_4 - var_2 ) * 0.66, var_11 ], [ var_4, var_16 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_noise_hi_vel2vol", [ [ var_2, var_15 ], [ var_2 + ( var_4 - var_2 ) * 0.66, var_11 ], [ var_4, var_17 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_noise_vel2pch", [ [ var_2, var_18 ], [ var_4, var_18 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_noise_hi_dist2vol", [ [ soundscripts\_audio_vehicle_manager::yards2dist( 0 ), var_17 ], [ soundscripts\_audio_vehicle_manager::yards2dist( 4 ), var_17 * 0.25 ], [ soundscripts\_audio_vehicle_manager::yards2dist( 6 ), var_17 * 0.4 ], [ soundscripts\_audio_vehicle_manager::yards2dist( 8 ), var_15 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_noise_lo_dist2vol", [ [ soundscripts\_audio_vehicle_manager::yards2dist( 3 ), var_16 ], [ soundscripts\_audio_vehicle_manager::yards2dist( 12 ), var_15 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_flyby_vel2vol", [ [ var_2, var_20 ], [ var_4, var_21 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_flyby_vel2pch", [ [ var_2, var_22 ], [ var_4, var_23 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_flyby_duck_envelope", [ [ 0.0, 1.0 ], [ 0.33, 0.33 ], [ 0.66, 0.33 ], [ 1.33, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "pdrone_security_doppler2pch", [ [ 0.0, 0.0 ], [ 2.0, 2.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

foo_env_function()
{
    return 1.0;
}

pdrone_security_condition_callback_to_state_off()
{
    return 0;
}

pdrone_security_condition_callback_to_state_hover( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = soundscripts\_audio_vehicle_manager::dist2yards( var_4 );

    if ( var_3 <= 5.1 && var_5 < 25 )
        var_2 = 1;

    return var_2;
}

pdrone_security_condition_callback_to_state_flying( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["speed"];
    var_4 = var_0["distance2d"];
    var_5 = soundscripts\_audio_vehicle_manager::dist2yards( var_4 );

    if ( var_3 > 5.1 && var_5 < 25 )
        var_2 = 1;

    return var_2;
}

pdrone_security_condition_callback_to_state_distant( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = soundscripts\_audio_vehicle_manager::dist2yards( var_3 );

    if ( var_4 >= 25 )
        var_2 = 1;

    return var_2;
}

pdrone_security_condition_callback_to_state_flyby( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = soundscripts\_audio_vehicle_manager::dist2yards( var_3 );

    if ( !isdefined( var_1.flyby ) )
    {
        var_1.flyby = spawnstruct();
        var_1.flyby.prev_yards = var_4;
        var_1.flyby.prev_dx = 0;
    }
    else
    {
        var_5 = var_4 - var_1.flyby.prev_yards;

        if ( var_5 < 0 && var_4 < 6.0 )
        {
            if ( 0 )
                var_2 = [ "pdrone_security_flyby" ];
            else
                var_2 = 1;
        }

        var_1.flyby.prev_yards = var_4;
        var_1.flyby.prev_dx = var_5;
    }

    return var_2;
}

pdrone_security_condition_callback_to_state_flyover( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0["distance2d"];
    var_4 = var_0["relative_speed"];
    var_5 = soundscripts\_audio_vehicle_manager::dist2yards( var_3 );

    if ( var_5 < 30 )
        var_2 = 1;

    return var_2;
}

pdrone_security_condition_callback_to_state_deathspin( var_0, var_1 )
{
    return 0;
}

pdrone_security_condition_callback_to_state_destruct( var_0, var_1 )
{
    return 0;
}

pdrone_security_speed_modifier_callback_smoother( var_0, var_1 )
{
    if ( !isdefined( var_1.input_scalar_target ) )
    {
        var_1.input_scalar_target = 1.0;
        var_1.input_scalar_actual = 1.0;
        var_1.min_range = 0.7;
        var_1.max_range = 1.2;
        var_1.smooth_up = 0.65;
        var_1.smooth_down = 0.3;
    }

    if ( abs( var_1.input_scalar_actual - var_1.input_scalar_target ) < 0.0001 )
        var_1.input_scalar_target = randomfloatrange( var_1.min_range, var_1.max_range );

    if ( var_1.input_scalar_target > var_1.input_scalar_actual )
        var_2 = var_1.smooth_up;
    else
        var_2 = var_1.smooth_down;

    var_1.input_scalar_actual += var_2 * ( var_1.input_scalar_target - var_1.input_scalar_actual );
    return var_0 * var_1.input_scalar_actual;
}

pdrone_security_speed_modifier_callback_perlin_noise( var_0, var_1 )
{
    if ( !isdefined( var_1.input_scalar_target ) )
        var_1.world_x = 0;

    var_1.world_x += 1;
    var_2 = gettime() * 0.001;
    var_3 = 0;
    var_4 = 2;
    var_5 = 2;
    var_6 = 1;
    var_7 = perlinnoise2d( var_2, var_3, var_4, var_5, 1 );
    return var_0 * 1;
}

pdrone_security_speed_modifier_callback_linear( var_0, var_1 )
{
    if ( !isdefined( var_1.input_scalar_target ) || gettime() >= var_1.input_start_time + var_1.input_delta_time )
    {
        var_1.input_scalar_actual = 1.0;
        var_1.input_scalar_target = randomfloatrange( 0.7, 1.2 );
        var_1.input_start_time = gettime();
        var_1.input_delta_time = randomintrange( 500, 500 );
    }

    var_2 = ( var_1.input_scalar_target - var_1.input_scalar_actual ) / var_1.input_delta_time;
    var_1.input_scalar_actual += var_2;
    return var_0 * 1;
}
