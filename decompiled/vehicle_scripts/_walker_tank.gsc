// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "walker_tank", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_shoot_shock( "tankblast_walker" );
    maps\_vehicle::build_treadfx();
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "axis" );
    precacheturret( "enemy_walker_top_left_turret" );
    precachemodel( "vehicle_walker_tank_dstrypv" );
    maps\_vehicle::build_bulletshield( 1 );
    maps\_vehicle::build_grenadeshield( 1 );
    maps\_vehicle::build_turret( "enemy_walker_belly_turret", "TAG_TURRET_BELLY", "vehicle_walker_tank_turret_belly", undefined, undefined, undefined, 0, 0, undefined );
    maps\_vehicle::build_turret( "enemy_walker_top_left_turret", "TAG_TURRET_TOP_LEFT", "vehicle_walker_tank_turret_top_left", undefined, undefined, undefined, 0, 0, undefined );
    maps\_vehicle::build_turret( "enemy_walker_top_right_turret", "TAG_TURRET_TOP_RIGHT", "vehicle_walker_tank_turret_top_right", undefined, undefined, undefined, 0, 0, undefined );
    maps\_vehicle::build_missile_launcher( "enemy_walker_left_launcher", "launcher_left", "projectile_rpg7", "rpg_guided", ::launchers_rotate_up, ::launchers_rotate_down );
    maps\_vehicle::build_missile_launcher( "enemy_walker_right_launcher", "launcher_right", "projectile_rpg7", "rpg_guided", ::launchers_rotate_up, ::launchers_rotate_down );

    if ( var_2 == "script_vehicle_walker_tank_generic" )
    {
        maps\_vehicle::build_deathmodel( var_0, "vehicle_walker_tank_dstrypv", undefined, var_2 );
        maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_walker_tank_explosion", "TAG_DEATH_FX", "exp_armor_vehicle" );
    }

    setdvar( "walker_tank_debug", 0 );
}

#using_animtree("vehicles");

init_local()
{
    self _meth_8115( #animtree );
    handle_vehicle_ai();
    self.shock_distance = 1500;
    self.black_distance = 1500;

    if ( self.script_team == "allies" )
        self.shock_distance = 500;

    self.missile_target_onscreen_guys_first = 1;
    thread death_cleanup();
}

handle_vehicle_ai()
{
    thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target( 1.5 );
    thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot( 3, 5, 3, 5 );
    thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
    thread setup_mg_turrets();
    thread setup_missile_launchers();
}

setup_missile_launchers()
{
    self.missiletags = [];
    self.missiletagsready = [];
    self.missiletags[0] = "tag_missile_1_L";
    self.missiletags[1] = "tag_missile_2_L";
    self.missiletags[2] = "tag_missile_3_L";
    self.missiletags[3] = "tag_missile_4_L";
    self.missiletags[4] = "tag_missile_5_L";
    self.missiletags[5] = "tag_missile_6_L";
    self.missiletags[6] = "tag_missile_7_L";
    self.missiletags[7] = "tag_missile_8_L";
    self.missiletags[8] = "tag_missile_9_L";
    self.missiletags[9] = "tag_missile_10_L";
    self.missiletags[10] = "tag_missile_1_R";
    self.missiletags[11] = "tag_missile_2_R";
    self.missiletags[12] = "tag_missile_3_R";
    self.missiletags[13] = "tag_missile_4_R";
    self.missiletags[14] = "tag_missile_5_R";
    self.missiletags[15] = "tag_missile_6_R";
    self.missiletags[16] = "tag_missile_7_R";
    self.missiletags[17] = "tag_missile_8_R";
    self.missiletags[18] = "tag_missile_9_R";
    self.missiletags[19] = "tag_missile_10_R";
    thread vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
}

setup_mg_turrets()
{
    waittillframeend;
    waittillframeend;
    var_0 = 0;

    foreach ( var_2 in self.mgturret )
    {
        var_2 thread walker_tank_turret_think( var_0 );
        var_2 thread stop_firing_for_death_anim( self );
        var_0++;
    }
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
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 1, -3 );
}

launchers_disable_threat_grenade_response()
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 0, -2 );
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 0, -3 );
}

enable_threat_grenade_response( var_0 )
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 1, var_0 );
}

disable_threat_grenade_response( var_0 )
{
    vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response( 0, var_0 );
}

fire_missles_at_target_array( var_0, var_1 )
{
    vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array( var_0, var_1 );
}

walker_tank_turret_think( var_0 )
{
    self endon( "death" );
    self endon( "stop_vehicle_turret_ai" );

    for (;;)
    {
        waittillframeend;

        if ( isdefined( self.disable_target_tracking ) && self.disable_target_tracking )
        {
            self.ai_target = undefined;
            waitframe();
            continue;
        }

        if ( isdefined( self.ai_target_force ) )
        {
            if ( !vehicle_scripts\_vehicle_turret_ai::is_valid_target( self.ai_target_force ) )
                self.ai_target_force = undefined;
            else
                self.ai_target = self.ai_target_force;
        }

        if ( !isdefined( self.ai_target ) )
        {
            var_1 = common_scripts\utility::get_enemy_team( self.script_team );
            var_2 = _func_0D6( var_1 );

            if ( isenemyteam( level.player.team, self.script_team ) )
                var_2 = common_scripts\utility::array_add( var_2, level.player );

            var_2 = sortbydistance( var_2, self.origin );
            var_3 = 0;

            for ( var_4 = 0; var_4 < var_2.size; var_4++ )
            {
                if ( !isdefined( var_2[var_4].claimed_walker_turret_target ) )
                {
                    self.ai_target = var_2[var_4];
                    break;
                }
            }

            if ( !isdefined( self.ai_target ) )
            {
                for ( var_4 = 0; var_4 < var_2.size; var_4++ )
                {
                    self.ai_target = var_2[var_4];
                    break;
                }
            }
        }

        if ( isdefined( self.ai_target ) && ( !isdefined( self.disable_firing ) || !self.disable_firing ) )
        {
            increment_claimed_refcount( self.ai_target );
            fire_at_target_until_dead( self.ai_target );
            continue;
        }

        wait 1;
    }
}

increment_claimed_refcount( var_0 )
{
    if ( !isdefined( var_0.claimed_walker_turret_target ) )
        var_0.claimed_walker_turret_target = 1;
    else
        var_0.claimed_walker_turret_target++;
}

decrement_claimed_refcount( var_0 )
{
    if ( !isdefined( var_0.claimed_walker_turret_target ) || var_0.claimed_walker_turret_target == 0 )
        return;

    if ( var_0.claimed_walker_turret_target == 1 )
        var_0.claimed_walker_turret_target = undefined;
    else
    {
        var_0.claimed_walker_turret_target--;
        return;
    }
}

fire_at_target_until_dead( var_0 )
{
    self endon( "death" );
    self endon( "stop_vehicle_turret_ai" );
    self endon( "mgturret_acquire_new_target" );
    var_1 = 2;
    var_2 = 4;
    var_3 = randomfloatrange( var_1, var_2 );
    var_4 = 2;
    var_5 = 5;
    var_6 = randomfloatrange( var_4, var_5 );
    var_7 = 0;
    self _meth_8135( self.script_team );
    self _meth_8065( "manual" );
    self _meth_8106( var_0 );
    self _meth_8179();
    self _meth_80E2();

    while ( var_7 < var_3 && vehicle_scripts\_vehicle_turret_ai::is_valid_target( var_0 ) )
    {
        var_7 += 0.05;
        wait 0.05;
    }

    self _meth_80E3();
    self _meth_815C();
    self _meth_8108();

    if ( vehicle_scripts\_vehicle_turret_ai::is_valid_target( var_0 ) )
        decrement_claimed_refcount( var_0 );

    wait(var_6);
    self notify( "mgturret_acquire_new_target" );
}

launchers_rotate_up()
{
    var_0 = 1;
    self _meth_8144( %walker_launcher_up_left_add, 1, 0, 1 );
    self _meth_8117( %walker_launcher_up_left_add, 1 );
    self _meth_8144( %walker_launcher_up_right_add, 1, 0, 1 );
    self _meth_8117( %walker_launcher_up_right_add, 1 );
    self _meth_814C( %walker_launcher_left_root, 1.0, var_0, 1 );
    self _meth_814C( %walker_launcher_right_root, 1.0, var_0, 1 );
    wait(var_0);
}

launchers_rotate_down()
{
    var_0 = 1;
    self _meth_8144( %walker_launcher_up_left_add, 1, 0, 1 );
    self _meth_8117( %walker_launcher_up_left_add, 1 );
    self _meth_8144( %walker_launcher_up_right_add, 1, 0, 1 );
    self _meth_8117( %walker_launcher_up_right_add, 1 );
    self _meth_814C( %walker_launcher_left_root, 0.01, var_0, 1 );
    self _meth_814C( %walker_launcher_right_root, 0.01, var_0, 1 );
    wait(var_0);
}

death_cleanup()
{
    self waittill( "death" );

    if ( isdefined( self ) )
        self detachall();
}

stop_firing_for_death_anim( var_0 )
{
    var_0 waittill( "stop_vehicle_turret_ai" );
    self _meth_80E3();
    self _meth_815C();
    self _meth_8108();
}
