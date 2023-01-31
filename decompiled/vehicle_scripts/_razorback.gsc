// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "razorback", var_0, var_1, var_2 );

    if ( issubstr( var_2, "simple" ) )
        maps\_vehicle::build_localinit( ::init_local_simple );
    else
        maps\_vehicle::build_localinit( ::init_local );

    maps\_vehicle::build_deathfx( "vfx/explosion/rocket_explosion_default", undefined, "explo_metal_rand" );
    maps\_vehicle::build_rocket_deathfx( "vfx/explosion/rocket_explosion_default", "tag_deathfx", "apache_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0, 5 );
    maps\_vehicle::build_treadfx_override_tags( var_2, [ "thrusterCenter_TL_FX", "thrusterCenter_TR_FX", "thrusterCenter_BL_FX", "thrusterCenter_BR_FX" ] );
    maps\_vehicle::build_treadfx_override_get_surface_function( var_2, ::razor_surface_override_function );
    maps\_vehicle::build_treadfx( var_2, "default", "vfx/treadfx/razorback_tread_smk_idle_runner" );
    maps\_vehicle::build_treadfx( var_2, "default_regular", "vfx/treadfx/razorback_tread_smk_regular_runner" );
    maps\_vehicle::build_treadfx( var_2, "default_strong", "vfx/treadfx/razorback_tread_smk_strong_runner" );
    maps\_vehicle::build_treadfx( var_2, "default_idle", "vfx/treadfx/razorback_tread_smk_idle_runner" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_is_helicopter();
    build_misc_anims( var_2 );
    vehicle_scripts\_razorback_fx::main();
    setdvar( "razorback_debug", 0 );
    maps\_vehicle::build_missile_launcher( "razor_missile_launcher", "launcherhatch", "projectile_rpg7", "rpg_guided", ::missile_door_open, ::missile_door_close );
}

set_attached_models()
{

}

#using_animtree("vehicles");

build_misc_anims( var_0 )
{
    if ( !isdefined( level.vehicle_anim_array ) )
        level.vehicle_anim_array = [];

    if ( !isdefined( level.vehicle_anim_array[var_0] ) )
        level.vehicle_anim_array[var_0] = [];

    level.vehicle_anim_array[var_0][0] = [];
    level.vehicle_anim_array[var_0][0]["rotate_root"] = %razorback_root_wl;
    level.vehicle_anim_array[var_0][0]["rotate_anim"] = %razorback_wing_left_rot;
    level.vehicle_anim_array[var_0][0]["nozzle_root"] = %razorback_root_wl_nozzle;
    level.vehicle_anim_array[var_0][0]["nozzle_anim"] = %razorback_wing_left_nozzle;
    level.vehicle_anim_array[var_0][0]["socket_root"] = %razorback_root_wl_socket;
    level.vehicle_anim_array[var_0][0]["socket_anim"] = %razorback_wing_left_socket;
    level.vehicle_anim_array[var_0][0]["thruster_fx_tag"] = "thrusterCenter_TL_FX";
    level.vehicle_anim_array[var_0][1] = [];
    level.vehicle_anim_array[var_0][1]["rotate_root"] = %razorback_root_wr;
    level.vehicle_anim_array[var_0][1]["rotate_anim"] = %razorback_wing_right_rot;
    level.vehicle_anim_array[var_0][1]["nozzle_root"] = %razorback_root_wr_nozzle;
    level.vehicle_anim_array[var_0][1]["nozzle_anim"] = %razorback_wing_right_nozzle;
    level.vehicle_anim_array[var_0][1]["socket_root"] = %razorback_root_wr_socket;
    level.vehicle_anim_array[var_0][1]["socket_anim"] = %razorback_wing_right_socket;
    level.vehicle_anim_array[var_0][1]["thruster_fx_tag"] = "thrusterCenter_TR_FX";
    level.vehicle_anim_array[var_0][2] = [];
    level.vehicle_anim_array[var_0][2]["rotate_root"] = %razorback_root_bl;
    level.vehicle_anim_array[var_0][2]["rotate_anim"] = %razorback_base_left_rot;
    level.vehicle_anim_array[var_0][2]["nozzle_root"] = %razorback_root_bl_nozzle;
    level.vehicle_anim_array[var_0][2]["nozzle_anim"] = %razorback_base_left_nozzle;
    level.vehicle_anim_array[var_0][2]["thruster_fx_tag"] = "thrusterCenter_BL_FX";
    level.vehicle_anim_array[var_0][3] = [];
    level.vehicle_anim_array[var_0][3]["rotate_root"] = %razorback_root_br;
    level.vehicle_anim_array[var_0][3]["rotate_anim"] = %razorback_base_right_rot;
    level.vehicle_anim_array[var_0][3]["nozzle_root"] = %razorback_root_br_nozzle;
    level.vehicle_anim_array[var_0][3]["nozzle_anim"] = %razorback_base_right_nozzle;
    level.vehicle_anim_array[var_0][3]["thruster_fx_tag"] = "thrusterCenter_BR_FX";
    level.vehicle_anim_array[var_0][4] = [];
    level.vehicle_anim_array[var_0][4]["rotate_root"] = %razorback_root_tl;
    level.vehicle_anim_array[var_0][4]["rotate_anim"] = %razorback_tail_left_rot;
    level.vehicle_anim_array[var_0][5] = [];
    level.vehicle_anim_array[var_0][5]["rotate_root"] = %razorback_root_tr;
    level.vehicle_anim_array[var_0][5]["rotate_anim"] = %razorback_tail_right_rot;
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 9; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_driver";
    var_0[0].idle = %razor_copilot_idle;
    var_0[0].death_no_ragdoll = 1;
    var_0[0].bhasgunwhileriding = 0;
    var_0[1].sittag = "tag_passenger";
    var_0[1].idle = %razor_copilot_idle;
    var_0[1].death_no_ragdoll = 1;
    var_0[1].bhasgunwhileriding = 0;
    var_0[2].sittag = "tag_guy0";
    var_0[2].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[2].death_no_ragdoll = 1;
    var_0[3].sittag = "tag_guy1";
    var_0[3].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[3].death_no_ragdoll = 1;
    var_0[4].sittag = "tag_guy2";
    var_0[4].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[4].death_no_ragdoll = 1;
    var_0[5].sittag = "tag_guy3";
    var_0[5].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[5].death_no_ragdoll = 1;
    var_0[6].sittag = "tag_guy4";
    var_0[6].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[6].death_no_ragdoll = 1;
    var_0[7].sittag = "tag_guy5";
    var_0[7].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[7].death_no_ragdoll = 1;
    var_0[8].sittag = "tag_guy6";
    var_0[8].idle = %lab_chopper_evac_hover_idle_npc;
    var_0[8].death_no_ragdoll = 1;
    return var_0;
}

#using_animtree("vehicles");

init_local()
{
    handle_vehicle_ai();
    self.missile_target_onscreen_guys_first = 1;
    self.dontdisconnectpaths = 1;
    self.script_badplace = 0;
    self.enablerocketdeath = 1;
    wait 0.05;
    maps\_vehicle::vehicle_lights_on( "running" );

    while ( is_playing_scripted_anim() )
        waitframe();

    thread update_calculations();
    self.thrusters_angle_goal = [];
    self.thrusters_angle_current = [];
    self.thrusters_fx_amount = [];
    self _meth_814B( %razorback_idle, 1, 0, 1 );
    thread vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_light_on( self );
    thread vehicle_scripts\_razorback_fx::play_regular_tail_thruster_rz( self );
    thread vehicle_scripts\_razorback_fx::vfx_red_lights_on();
    thread init_thruster( "thruster_TL" );
    thread init_thruster( "thruster_TR" );
    thread init_thruster( "thruster_BL" );
    thread init_thruster( "thruster_BR" );
    thread init_thruster( "thruster_KL" );
    thread init_thruster( "thruster_KR" );
    thread update_thrusters();
}

init_local_simple()
{
    self.dontdisconnectpaths = 1;
    self.script_badplace = 0;
    self.enablerocketdeath = 1;
    wait 0.05;
    maps\_vehicle::vehicle_lights_on( "running" );
}

razor_surface_override_function( var_0, var_1 )
{
    var_2 = 0;

    if ( var_1 == "thrusterCenter_TL_FX" )
        var_2 = 0;
    else if ( var_1 == "thrusterCenter_TR_FX" )
        var_2 = 1;
    else if ( var_1 == "thrusterCenter_BL_FX" )
        var_2 = 2;
    else if ( var_1 == "thrusterCenter_BR_FX" )
        var_2 = 3;

    if ( !isdefined( self.thrusters_fx_amount ) || !isdefined( self.thrusters_fx_amount[var_2] ) )
        return var_0;

    return "default_" + self.thrusters_fx_amount[var_2];
}

set_forced_target( var_0, var_1 )
{
    vehicle_scripts\_vehicle_multiweapon_util::set_forced_target( var_0, var_1 );
}

disable_firing( var_0 )
{
    vehicle_scripts\_vehicle_multiweapon_util::disable_firing( var_0 );
}

enable_firing( var_0 )
{
    vehicle_scripts\_vehicle_multiweapon_util::enable_firing( var_0 );
}

disable_tracking( var_0 )
{
    vehicle_scripts\_vehicle_multiweapon_util::disable_tracking( var_0 );
}

enable_tracking( var_0 )
{
    vehicle_scripts\_vehicle_multiweapon_util::enable_tracking( var_0 );
}

launchers_enable_threat_grenade_response()
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 1, -2 );
}

launchers_disable_threat_grenade_response()
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 0, -2 );
}

enable_threat_grenade_response()
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 1, -1 );
}

disable_threat_grenade_response()
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 0, -1 );
}

fire_missles_at_target_array( var_0 )
{
    vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array( var_0 );
}

handle_vehicle_ai()
{
    disable_tracking();
    thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target( 1.5 );
    thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot( 3, 5, 0.15, 5 );
    thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
    setup_missile_launchers();
}

setup_missile_launchers()
{
    self.missiletags = [];
    self.missiletagsready = [];
    self.missiletags[0] = "TAG_MISSILE_1";
    self.missiletags[1] = "TAG_MISSILE_2";
    self.missiletags[2] = "TAG_MISSILE_3";
    self.missiletags[3] = "TAG_MISSILE_4";
    self.missiletags[4] = "TAG_MISSILE_5";
    self.missiletags[5] = "TAG_MISSILE_6";
    thread vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
}

missile_door_open()
{
    self _meth_8145( %razorback_launcher_hatch_open, 0.9, 0 );
    self _meth_814C( %razorback_root_launcher_hatch, 1, 0 );
    wait(getanimlength( %razorback_launcher_hatch_open ));
}

missile_door_close()
{
    self _meth_814C( %razorback_root_launcher_hatch, 0.01, 0.5 );
    wait(getanimlength( %razorback_launcher_hatch_open ));
}

is_playing_scripted_anim()
{
    return isdefined( self._animactive ) && self._animactive > 0;
}

get_field_from_array( var_0, var_1 )
{
    return level.vehicle_anim_array[self.classname][var_0][var_1];
}

init_thruster( var_0 )
{
    self endon( "death" );
    var_1 = get_tag_index_from_tag_name( var_0 );
    self.thrusters_angle_current[var_1] = 0.0;
    self.thrusters_angle_goal[var_1] = 0.0;
}

update_thrusters()
{
    self endon( "death" );

    for (;;)
    {
        if ( !is_playing_scripted_anim() )
        {
            for ( var_0 = 0; var_0 < self.thrusters_angle_goal.size; var_0++ )
            {
                if ( isdefined( self.debug_controls ) )
                {

                }
                else
                {
                    var_1 = get_angle_from_speed( var_0, 0 );
                    var_2 = get_angle_mod_from_horiz_speed( var_0 );
                    var_3 = get_angle_mod_from_yaw_diff( var_0 );
                    var_4 = var_1 + ( -90 - var_1 ) * var_2;
                    var_4 += ( -90 - var_4 ) * var_3;
                    self.thrusters_angle_goal[var_0] = var_4;
                    var_5 = get_nozzle_opening_from_speed( var_0, self.thrusters_angle_goal[var_0] );
                    update_nozzle_opening( var_0, var_5 );
                }

                self.thrusters_angle_goal[var_0] = clamp( self.thrusters_angle_goal[var_0], -90, 0 );
                update_thruster_angle( var_0 );
            }
        }

        wait 0.05;
    }
}

get_tag_index_from_tag_name( var_0 )
{
    if ( var_0 == "thruster_TL" )
        return 0;

    if ( var_0 == "thruster_TR" )
        return 1;

    if ( var_0 == "thruster_BL" )
        return 2;

    if ( var_0 == "thruster_BR" )
        return 3;

    if ( var_0 == "thruster_KL" )
        return 4;

    if ( var_0 == "thruster_KR" )
        return 5;
}

play_thruster_rotation( var_0, var_1 )
{
    var_2 = get_field_from_array( var_0, "rotate_root" );
    var_1 = clamp( var_1, 0, 1 );
    var_3 = get_field_from_array( var_0, "rotate_anim" );
    var_4 = 0.05;

    if ( var_0 == 4 )
        var_4 = 0.2;

    self _meth_8144( var_3, 1, 0, 1 );
    self _meth_8117( var_3, 1 );

    if ( var_1 == 0 )
        self _meth_814C( var_2, 0.01, var_4, 1 );
    else
        self _meth_814C( var_2, var_1, var_4, 1 );
}

update_thruster_angle( var_0 )
{
    var_1 = self.thrusters_angle_goal[var_0];
    var_2 = self.thrusters_angle_current[var_0];

    if ( !is_float_equal( var_2, var_1 ) )
    {
        if ( abs( var_1 - var_2 ) < 6.0 )
            self.thrusters_angle_current[var_0] = var_1;
        else if ( var_2 > var_1 )
            self.thrusters_angle_current[var_0] -= 6.0;
        else
            self.thrusters_angle_current[var_0] += 6.0;

        play_thruster_rotation( var_0, self.thrusters_angle_current[var_0] / -90 );
    }
    else
    {

    }
}

update_nozzle_opening( var_0, var_1 )
{
    var_2 = get_field_from_array( var_0, "nozzle_root" );
    var_3 = get_field_from_array( var_0, "nozzle_anim" );
    var_4 = get_field_from_array( var_0, "thruster_fx_tag" );
    var_5 = undefined;
    var_6 = undefined;

    if ( isdefined( var_2 ) )
    {
        self _meth_8144( var_3, 1, 0, 1 );
        self _meth_8117( var_3, 1 );

        if ( var_1 == 0 )
            self _meth_814C( var_2, 0.01, 0.05, 1 );
        else
            self _meth_814C( var_2, var_1, 0.05, 1 );

        var_5 = self.thrusters_fx_amount[var_0];

        if ( var_1 < 0.01 )
            var_6 = "idle";
        else if ( var_1 > 0.5 )
            var_6 = "strong";
        else
            var_6 = "regular";

        if ( !isdefined( var_5 ) || var_5 != var_6 )
        {
            self.thrusters_fx_amount[var_0] = var_6;
            self notify( "killfx_" + var_4 );
            vehicle_scripts\_razorback_fx::play_thruster_amount_given_tag( var_0, var_6, var_4 );
        }
    }
}

is_float_equal( var_0, var_1 )
{
    var_2 = 0.1;
    return abs( var_0 - var_1 ) < var_2;
}

get_angle_mod_from_yaw_diff( var_0 )
{
    var_1 = 0;
    var_2 = self.yaw_per_sec_calc;

    if ( var_2 < -1 )
    {
        if ( var_0 == 5 )
            var_1 = interp_with_clamp( var_2, -2.0, -1.0, 1.0, 0.0 );
    }

    if ( var_2 < -1.5 )
    {
        if ( var_0 == 4 )
            var_1 = interp_with_clamp( var_2, -2, -1.5, -1.0, 0 );
    }

    if ( var_2 > 1 )
    {
        if ( var_0 == 4 )
            var_1 = interp_with_clamp( var_2, 0.75, 1.75, 0.0, 1.0 );
    }

    if ( var_2 > 1.5 )
    {
        if ( var_0 == 5 )
            var_1 = interp_with_clamp( var_2, 1.5, 2, 0, -1.0 );
    }

    return var_1;
}

get_angle_mod_from_horiz_speed( var_0 )
{
    var_1 = 0;
    var_2 = self.horiz_speed_calc;

    if ( var_2 < -10 )
    {
        if ( var_0 == 0 )
            var_1 = interp_with_clamp( var_2, -100.0, -10, 1.0, 0.0 );
        else if ( var_0 == 2 )
            var_1 = interp_with_clamp( var_2, -100.0, -10, 1.0, 0.0 );
    }

    if ( var_2 > 10 )
    {
        if ( var_0 == 1 )
            var_1 = interp_with_clamp( var_2, 10, 100, 0.0, 1.0 );
        else if ( var_0 == 3 )
            var_1 = interp_with_clamp( var_2, 10, 100, 0.0, 1.0 );
    }

    return var_1;
}

get_angle_from_speed( var_0, var_1 )
{
    if ( var_0 == 4 )
        return 0;
    else if ( var_0 == 5 )
        return 0;
    else
        return interp_with_clamp( self.speed_calc, 13.0, 20 + var_1, -90, 0 );
}

get_nozzle_opening_from_speed( var_0, var_1 )
{
    if ( var_0 == 4 )
        return 0;
    else if ( var_0 == 5 )
        return 0;

    if ( var_1 < -70 )
        return 1.0;
    else if ( var_0 == 0 )
        return interp_with_clamp( self.speed_calc, 10.0, 15, 1.0, 0.25 );
    else if ( var_0 == 1 )
        return interp_with_clamp( self.speed_calc, 10.0, 15, 1.0, 0.25 );
    else if ( var_0 == 2 )
        return interp_with_clamp( self.speed_calc, 10.0, 15, 1.0, 0.75 );
    else if ( var_0 == 3 )
        return interp_with_clamp( self.speed_calc, 10.0, 15, 1.0, 0.75 );
}

interp_with_clamp( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_0 <= var_1 )
        return var_3;
    else if ( var_0 > var_2 )
        return var_4;
    else
    {
        var_5 = ( var_4 - var_3 ) / ( var_2 - var_1 );
        var_6 = var_5 * ( var_0 - var_1 ) + var_3;
        return var_6;
    }
}

model_speed_to_mph( var_0 )
{
    return var_0 / 63360.0 * 60.0 * 60.0;
}

update_calculations()
{
    self endon( "death" );
    var_0 = self.origin;
    var_1 = self.angles;

    for (;;)
    {
        var_2 = self.origin - var_0;
        var_3 = self.angles - var_1;
        self.yaw_per_sec_calc = var_3[1];
        self.velocity_calc = var_2 / 0.05;
        self.speed_calc = model_speed_to_mph( length( self.velocity_calc ) );
        var_4 = anglestoright( self.angles );
        var_5 = ( var_4[0], var_4[1], 0 );
        var_6 = ( self.velocity_calc[0], self.velocity_calc[1], 0 );
        var_7 = vectordot( var_6, var_5 );
        self.horiz_speed_calc = var_7;
        var_0 = self.origin;
        var_1 = self.angles;
        waitframe();
    }
}
