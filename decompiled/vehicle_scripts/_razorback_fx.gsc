// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level._effect["light_point_red_solid_nolens"] = loadfx( "vfx/lights/light_wingtip_red_med_point_nolens" );
    level._effect["razorback_tread_smk_regular_runner"] = loadfx( "vfx/treadfx/razorback_tread_smk_regular_runner" );
    level._effect["razorback_tread_smk_strong_runner"] = loadfx( "vfx/treadfx/razorback_tread_smk_strong_runner" );
    level._effect["razorback_tread_smk_idle_runner"] = loadfx( "vfx/treadfx/razorback_tread_smk_idle_runner" );
    level._effect["razorback_exhaust_regular"] = loadfx( "vfx/vehicle/razorback_exhaust_regular" );
    level._effect["razorback_exhaust_idle"] = loadfx( "vfx/vehicle/razorback_exhaust_idle" );
    level._effect["razorback_exhaust_strong"] = loadfx( "vfx/vehicle/razorback_exhaust_strong" );
    level._effect["razorback_exhaust_light_flicker"] = loadfx( "vfx/vehicle/razorback_exhaust_light_flicker" );
    level._effect["razorback_exhaust_tail_left_regular"] = loadfx( "vfx/vehicle/razorback_exhaust_tail_left_regular" );
    level._effect["razorback_exhaust_tail_right_regular"] = loadfx( "vfx/vehicle/razorback_exhaust_tail_right_regular" );
}

vfx_rb_thruster_front_light_on( var_0 )
{
    maps\_utility::delaythread( 0.4, ::play_back_thruster_light_rz );
    maps\_utility::delaythread( 0.45, ::play_front_thruster_light_rz );
}

vfx_rb_thruster_front_light_off( var_0 )
{
    maps\_utility::delaythread( 3.8, ::stop_back_thruster_light_rz );
    maps\_utility::delaythread( 6.5, ::stop_front_thruster_light_rz );
}

vfx_rb_thruster_front_on( var_0 )
{
    maps\_utility::delaythread( 0, ::play_regular_front_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.2, ::play_regular_tread_front_rz, var_0 );
    maps\_utility::delaythread( 0.3, ::play_regular_tail_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.05, ::stop_idle_front_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.15, ::stop_idle_tread_front_rz, var_0 );
}

vfx_rb_thruster_front_off( var_0 )
{
    maps\_utility::delaythread( 0, ::stop_regular_front_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.2, ::stop_regular_tail_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.3, ::stop_regular_tread_front_rz, var_0 );
    maps\_utility::delaythread( 0.05, ::play_idle_front_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.15, ::play_idle_tread_front_rz, var_0 );
}

vfx_rb_thruster_back_on( var_0 )
{
    wait 0.1;
    maps\_utility::delaythread( 0, ::play_regular_back_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.1, ::play_regular_tread_back_rz, var_0 );
    maps\_utility::delaythread( 0.3, ::stop_idle_back_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.05, ::vfx_razorback_jets_on, var_0 );
}

vfx_rb_thruster_back_off( var_0 )
{
    wait 0.1;
    maps\_utility::delaythread( 0, ::stop_regular_back_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.1, ::stop_regular_tread_back_rz, var_0 );
    maps\_utility::delaythread( 0.3, ::play_idle_back_thruster_rz, var_0 );
    maps\_utility::delaythread( 0.05, ::vfx_razorback_jets_off, var_0 );
}

play_regular_front_thruster_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_TR_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_TL_FX" );
}

stop_regular_front_thruster_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_TR_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_TL_FX" );
}

play_regular_tread_front_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_TR_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_TL_FX" );
}

stop_regular_tread_front_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_TR_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_TL_FX" );
}

play_idle_tread_front_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_tread_smk_idle_runner" ), var_0, "thrusterCenter_TR_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_tread_smk_idle_runner" ), var_0, "thrusterCenter_TL_FX" );
}

stop_idle_tread_front_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_tread_smk_idle_runner" ), var_0, "thrusterCenter_TR_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_tread_smk_idle_runner" ), var_0, "thrusterCenter_TL_FX" );
}

play_idle_front_thruster_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_TR_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_TL_FX" );
}

stop_idle_front_thruster_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_TR_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_TL_FX" );
}

play_front_thruster_light_rz()
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_TR_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_TL_FX" );
}

stop_front_thruster_light_rz()
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_TR_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_TL_FX" );
}

play_regular_tail_thruster_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_tail_right_regular" ), var_0, "thrusterCenter_KR_FX1" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_tail_left_regular" ), var_0, "thrusterCenter_KL_FX1" );
}

stop_regular_tail_thruster_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_tail_right_regular" ), var_0, "thrusterCenter_KR_FX1" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_tail_left_regular" ), var_0, "thrusterCenter_KL_FX1" );
}

play_regular_back_thruster_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_BL_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_BR_FX" );
}

stop_regular_back_thruster_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_BL_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), var_0, "thrusterCenter_BR_FX" );
}

play_regular_tread_back_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_BL_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_BR_FX" );
}

stop_regular_tread_back_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_BL_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_tread_smk_regular_runner" ), var_0, "thrusterCenter_BR_FX" );
}

play_idle_back_thruster_rz( var_0 )
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_BL_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_BR_FX" );
}

stop_idle_back_thruster_rz( var_0 )
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_BL_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), var_0, "thrusterCenter_BR_FX" );
}

play_back_thruster_light_rz()
{
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_BR_FX" );
    playfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_BL_FX" );
}

stop_back_thruster_light_rz()
{
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_BR_FX" );
    stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_light_flicker" ), self, "thrusterCenter_BL_FX" );
}

play_thruster_amount_given_tag( var_0, var_1, var_2 )
{
    self endon( "kill_" + var_2 );
    wait(var_0 * 0.05);

    if ( var_1 == "idle" )
    {
        stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), self, var_2 );
        wait 0.05;
        stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_strong" ), self, var_2 );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), self, var_2 );
        wait 0.05;
    }
    else if ( var_1 == "regular" )
    {
        wait 0.05;
        stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), self, var_2 );
        wait 0.05;
        stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_strong" ), self, var_2 );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), self, var_2 );
        wait 0.05;
    }
    else if ( var_1 == "strong" )
    {
        stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_idle" ), self, var_2 );
        wait 0.05;
        stopfxontag( common_scripts\utility::getfx( "razorback_exhaust_regular" ), self, var_2 );
        wait 0.05;
        playfxontag( common_scripts\utility::getfx( "razorback_exhaust_strong" ), self, var_2 );
        wait 0.05;
    }
}

vfx_red_lights_on()
{
    wait 0.5;
    playfxontag( common_scripts\utility::getfx( "light_point_red_solid_nolens" ), self, "TAG_LIGHT_BACK_RIGHT" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "light_point_red_solid_nolens" ), self, "TAG_LIGHT_BACK_LEFT" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "light_point_red_solid_nolens" ), self, "TAG_LIGHT_RIGHT" );
    wait 0.05;
    playfxontag( common_scripts\utility::getfx( "light_point_red_solid_nolens" ), self, "TAG_LIGHT_LEFT" );
}

vfx_razorback_jets_off( var_0 )
{
    level.razorback notify( "stop_kicking_up_dustthrusterCenter_BR_FX" );
    level.razorback notify( "stop_kicking_up_dustthrusterCenter_BL_FX" );
}

vfx_razorback_jets_on( var_0 )
{
    level.razorback thread maps\_vehicle_code::aircraft_wash_thread( undefined, "thrusterCenter_BR_FX" );
    level.razorback thread maps\_vehicle_code::aircraft_wash_thread( undefined, "thrusterCenter_BL_FX" );
}
