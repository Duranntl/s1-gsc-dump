// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("player");

controllable_drone_swarm_init()
{
    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinewidth", 20 );
    _func_0D3( "r_hudoutlinecloakblurradius", 0.35 );

    if ( !isdefined( level.boid_settings_presets ) )
        level.boid_settings_presets = [];

    level.boid_settings_presets["controllable_swarm"] = spawnstruct();
    level.boid_settings_presets["controllable_swarm"].neighborhood_radius = 78;
    level.boid_settings_presets["controllable_swarm"].separation_factor = 3000;
    level.boid_settings_presets["controllable_swarm"].alignment_factor = 0.02;
    level.boid_settings_presets["controllable_swarm"].cohesion_factor = 0.0001;
    level.boid_settings_presets["controllable_swarm"].queen_factor = 10;
    level.boid_settings_presets["controllable_swarm"].queen_deadzone = 64;
    level.boid_settings_presets["controllable_swarm"].random_factor = 50;
    level.boid_settings_presets["controllable_swarm"].max_accel = 2400;
    level.boid_settings_presets["controllable_swarm"].min_speed = 52.8;
    level.boid_settings_presets["controllable_swarm"].max_speed = 396.0;
    level.boid_settings_presets["controllable_swarm"].dodge_player_shots = 0;
    level.boid_settings_presets["controllable_swarm"].emp_mode = 0;
    level.boid_settings_presets["controllable_swarm"].queen_relative_speed = 1;
    level.boid_settings_presets["controllable_swarm"].queen_data_accel = 5;
    level.boid_settings_presets["controllable_swarm"].queen_data_decel = 5;
    level.boid_settings_presets["controllable_swarm"].queen_data_desired_speed = 15;
    level.boid_settings_presets["controllable_swarm"].queen_data_follow_radii = 75;
    level.fully_controllable_swarm = 0;
    level.swarm_spawned = 0;
    level.controllable_drone_hud = "drone_hud_controllable_overlay_2";
    level.controllable_drone_activated = "drone_hud_controllable_overlay_1";
    level.controllable_hud_target_shader = "jet_hud_hex_blue";
    level.controllable_drone_swarm_target = [];

    if ( !common_scripts\utility::flag_exist( "cloud_in_formation" ) )
        common_scripts\utility::flag_init( "cloud_in_formation" );

    maps\_utility::ent_flag_init( "controllable_drones_go" );
    common_scripts\utility::flag_init( "controllable_swarm_activated" );
    common_scripts\utility::flag_init( "player_attack_think_running" );
    common_scripts\utility::flag_init( "controlling_drones" );
    common_scripts\utility::flag_init( "controlling_drones_first_time" );
    level.controllable_drones = [];
    level.expected_drones = level.attack_drones_num_queens * level.attack_drones_num_drones_per_queen;
    precacheitem( "iw5_attackdronemagicbullet" );
    precacheshader( level.controllable_drone_hud );
    precacheshader( level.controllable_drone_activated );
    precacheshader( level.controllable_hud_target_shader );
    precacheshader( "sat_hud_xray_blue" );
    precacheshader( "jet_hud_hex_orange" );
    precacheshader( "jet_hud_missile_circle" );
    precacheitem( "remote_missile_drone" );
    precache_icons();
    vehicle_scripts\_attack_drone_common::drone_fx();
    level.scr_animtree["drone_control_view_model"] = #animtree;
    level.scr_model["drone_control_view_model"] = "viewhands_s1_pmc";
    level.scr_anim["drone_control_view_model"]["drone_control_on"] = %vm_turn_on_cloak;
}

precache_icons()
{
    precacheshader( "drone_hud_locking_on_1" );
    precacheshader( "drone_hud_locking_on_2" );
    precacheshader( "drone_hud_locking_on_3" );
    precacheshader( "drone_hud_locking_on_4" );
    precacheshader( "drone_hud_locking_on_5" );
    precacheshader( "drone_hud_locking_on_6" );
    precacheshader( "drone_hud_locking_on_7" );
    precacheshader( "drone_hud_locking_on_8" );
    precacheshader( "drone_hud_locking_on_9" );
    precacheshader( "drone_hud_locking_on_10" );
    precacheshader( "drone_hud_locking_on_11" );
    precacheshader( "drone_hud_locking_on_12" );
    precacheshader( "drone_hud_locking_on_13" );
    precacheshader( "drone_hud_locking_on_14" );
    precacheshader( "drone_hud_locking_on_15" );
    precacheshader( "drone_hud_locking_on_16" );
    precacheshader( "drone_hud_npc_lockon" );
    precacheshader( "drone_hud_veh_lockon" );
    level.drone_lockon_icons = [ "drone_hud_locking_on_2", "drone_hud_locking_on_4", "drone_hud_locking_on_6", "drone_hud_locking_on_8", "drone_hud_locking_on_10", "drone_hud_locking_on_12", "drone_hud_locking_on_14", "drone_hud_locking_on_16" ];
}

kill_controllable_drone_swarm()
{
    level.controllable_cloud_queen notify( "end_drone_swarm" );
    level notify( "delete_drone_cloud" );
    common_scripts\utility::array_thread( level.controllable_drones, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::array_thread( level.drone_swarm_queens, maps\_shg_design_tools::delete_auto );
    common_scripts\utility::array_removeundefined( level.controllable_drones );
    common_scripts\utility::array_removeundefined( level.drone_swarm_queens );
}

ad_offset_position_from_tag( var_0, var_1, var_2 )
{
    var_3 = self gettagangles( var_1 );
    var_4 = self gettagorigin( var_1 );

    if ( var_0 == "up" )
        return var_4 + anglestoup( var_3 ) * var_2;

    if ( var_0 == "down" )
        return var_4 + anglestoup( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "right" )
        return var_4 + anglestoright( var_3 ) * var_2;

    if ( var_0 == "left" )
        return var_4 + anglestoright( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "forward" )
        return var_4 + anglestoforward( var_3 ) * var_2;

    if ( var_0 == "backward" )
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );

    if ( var_0 == "backwardright" )
    {
        var_4 += anglestoright( var_3 ) * var_2;
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );
    }

    if ( var_0 == "backwardleft" )
    {
        var_4 += anglestoright( var_3 ) * ( var_2 * -1 );
        return var_4 + anglestoforward( var_3 ) * ( var_2 * -1 );
    }

    if ( var_0 == "forwardright" )
    {
        var_4 += anglestoright( var_3 ) * ( var_2 * 1 );
        return var_4 + anglestoforward( var_3 ) * var_2;
    }

    if ( var_0 == "forwardleft" )
    {
        var_4 += anglestoright( var_3 ) * ( var_2 * -1 );
        return var_4 + anglestoforward( var_3 ) * var_2;
    }
}

setup_drone_swarm_crates()
{
    level.controllable_drone_spawners = getentarray( "drone_crate_spawner", "targetname" );
    var_0 = getentarray( "vol_drone_crate_reinforcements", "targetname" );

    foreach ( var_2 in level.controllable_drone_spawners )
        var_2 make_drone_crate( level.controllable_drone_spawners );

    foreach ( var_5 in var_0 )
    {
        var_5 make_drone_crate_group( level.controllable_drone_spawners );
        var_5 thread waittill_crate_activated();
    }

    level notify( "queen_drone_selected", self );
    level.player swarm_drone_hud_on( level.controllable_drone_activated );
}

make_drone_crate_group( var_0 )
{
    self.drone_spawners = [];
    self.path = undefined;

    foreach ( var_2 in var_0 )
    {
        if ( var_2 _meth_80A9( self ) )
            self.drone_spawners[self.drone_spawners.size] = var_2;
    }

    var_4 = common_scripts\utility::getstructarray( "struct_drone_crate_reinforcements", "targetname" );
    var_5 = common_scripts\utility::spawn_tag_origin();

    foreach ( var_7 in var_4 )
    {
        var_5.origin = var_7.origin;

        if ( var_5 _meth_80A9( self ) )
            self.path = var_7;
    }
}

make_drone_crate( var_0 )
{
    var_1 = getentarray( "drone_crate_trigger", "targetname" );
    self.trigger = getclosestdrone( self.origin, var_1, 500 );
    self.vols = getentarray( "drone_crate_volume", "targetname" );
    var_2 = getentarray( "drone_crate_drone", "targetname" );
    self.include = getent( "vol_include_drones", "targetname" );
    self.my_vol = getclosestdrone( self.origin, self.vols, 500 );
    self.my_orgs = _id_4137( var_2, self.my_vol );
    self.nodes = maps\_shg_design_tools::getthingarray( "drone_crate_path", "targetname" );
    self.node = getclosestdrone( self.my_vol.origin, self.nodes, 500 );
}

waittill_crate_activated()
{
    while ( !level.player _meth_80A9( self ) )
        waitframe();

    drone_cloud_controllable();
}

handle_controllable_cloud_queen_pathing()
{
    level.controllable_cloud_queen endon( "death" );
    var_0 = common_scripts\utility::getstructarray( "struct_drone_crate_masterpath1", "targetname" );
    var_1 = level.player common_scripts\utility::spawn_tag_origin();

    for (;;)
    {
        if ( !level.controllable_cloud_queen.is_player_controlled )
        {
            var_1.origin = level.player.origin;
            var_1.angles = level.player _meth_8036();
            var_2 = var_1 maps\_shg_design_tools::offset_position_from_tag( "forward", "tag_origin", 300 );
            var_3 = maps\_shg_design_tools::getclosestauto( var_2, var_0, 1000 );

            if ( isdefined( var_3 ) )
                thread queen_change_path( var_3, 20 );
        }

        wait 2;
    }
}

drone_cloud_controllable()
{
    var_0 = spawn_controllable_drone_cloud();

    if ( !isdefined( level.controllable_cloud_queen ) )
    {
        level.controllable_cloud_queen = var_0[0];
        level.controllable_cloud_queen.is_player_controlled = 0;
        level.controllable_cloud_queen show();
        thread handle_controllable_cloud_queen_pathing();
    }

    if ( !isdefined( level.drone_swarm_queens ) )
        level.drone_swarm_queens = var_0;
    else
        level.drone_swarm_queens = common_scripts\utility::array_combine( level.drone_swarm_queens, var_0 );

    foreach ( var_2 in var_0 )
    {
        while ( !isdefined( var_2.boid_cloud_spawned ) )
            waitframe();
    }

    wait 4;
    common_scripts\utility::array_thread( var_0, ::controllable_fly_think, level.controllable_cloud_queen, level.boid_settings_presets["controllable_swarm"].queen_data_follow_radii );
    level.controllable_cloud_queen.drones = level.controllable_drones;
    level.player thread player_attack_think();
    level notify( "drone_swarm_spawned" );
    level.swarm_spawned = 1;
}

queen_change_path( var_0, var_1 )
{
    if ( isdefined( level.controllable_cloud_queen ) )
    {
        if ( !isdefined( var_1 ) )
            var_1 = 25;

        level.controllable_cloud_queen notify( "end_queen_think" );
        level.controllable_cloud_queen.attachedpath = undefined;
        var_2 = level.player _meth_8036()[1];
        level.controllable_cloud_queen _meth_8260( var_0.origin, var_1, var_1 / 2, var_1 * 2, 0, 1, var_2, 0, 0, 1, 0, 0, 1 );
    }
}

getdroneperlinovertime( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1;

    var_4 = ( perlinnoise2d( gettime() * 0.001 * 0.05, 10, var_0, var_1, var_2 ) * var_3, perlinnoise2d( gettime() * 0.001 * 0.05, 20, var_0, var_1, var_2 ) * var_3, perlinnoise2d( gettime() * 0.001 * 0.05, 30, var_0, var_1, var_2 ) * var_3 );
    return var_4;
}

spawn_controllable_drone_cloud()
{
    var_0 = self.drone_spawners;
    var_1 = self.drone_spawners.size;
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_0[var_3].count = 1;
        var_4 = var_0[var_3] maps\_utility::spawn_vehicle();
        var_4.location = int( 120 / var_1 * var_3 );
        var_4.num_in_formation = var_1;
        var_4 thread make_crate_boidcloud( var_0[var_3].my_orgs );
        var_4 thread vehicle_scripts\_attack_drone_common::make_queen_invulnerable();
        var_4.can_be_damaged = 1;
        var_4.script_team = "allies";
        var_2[var_2.size] = var_4;
        var_4 hide();
        wait 0.1;
    }

    return var_2;
}

_id_4137( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_2 ) && var_2 )
        var_3 = common_scripts\utility::spawn_tag_origin();

    var_4 = [];

    foreach ( var_6 in var_0 )
    {
        if ( isdefined( var_3 ) )
        {
            var_3.origin = var_6.origin;
            var_7 = var_3;
        }
        else
            var_7 = var_6;

        if ( var_7 _meth_80A9( var_1 ) )
            var_4[var_4.size] = var_6;
    }

    if ( isdefined( var_3 ) )
        var_3 delete();

    return var_4;
}

player_linkto_drone_missile( var_0 )
{
    if ( level.player.is_driving_pdrone )
    {
        level.player maps\_utility::player_dismount_vehicle();
        level.player.is_driving_pdrone = 0;
    }

    level.player maps\_shg_utility::setup_player_for_scene();
    level.player _meth_807F( var_0, "tag_origin" );
}

player_unlink_from_drone_missile()
{
    level.player _meth_804F();
    level.player maps\_shg_utility::setup_player_for_gameplay();
}

prep_user_for_dronecrate()
{
    self _meth_831D();
    self.ignoreme = 1;
    self _meth_80EF();
    var_0 = _func_0D6( "axis" );
}

remove_user_from_dronecrate()
{
    self _meth_831E();
    self.ignoreme = 0;
    self _meth_80F0();
}

monitor_drone_depletion( var_0 )
{
    var_0 endon( "death" );

    while ( var_0.drones.size <= 0 )
        waitframe();

    while ( var_0.drones.size > 0 )
    {
        var_0.drones = common_scripts\utility::array_removeundefined( var_0.drones );
        waitframe();
    }

    var_0 notify( "end_drone_swarm" );
}

swarm_drone_hud_on( var_0 )
{
    var_1 = 50000;
    var_2 = 60;
    self.dronecrate_hud["overlay1"] = newclienthudelem( self );
    self.dronecrate_hud["overlay1"] _meth_80CC( var_0, 640, 480 );
    self.dronecrate_hud["overlay1"].alignx = "left";
    self.dronecrate_hud["overlay1"].aligny = "top";
    self.dronecrate_hud["overlay1"].x = 0;
    self.dronecrate_hud["overlay1"].y = 0;
    self.dronecrate_hud["overlay1"].horzalign = "fullscreen";
    self.dronecrate_hud["overlay1"].vertalign = "fullscreen";
    self.dronecrate_hud["overlay1"].alpha = 0.5;
    self.dronecrate_hud["num_drones"] = newclienthudelem( self );
    self.dronecrate_hud["num_drones"].alignx = "left";
    self.dronecrate_hud["num_drones"].aligny = "top";
    self.dronecrate_hud["num_drones"].x = 10;
    self.dronecrate_hud["num_drones"].y = 110;
    self.dronecrate_hud["num_drones"].fontscale = 2;
    thread monitor_num_activated_drones();
}

monitor_num_activated_drones()
{
    for (;;)
    {
        self.dronecrate_hud["num_drones"] settext( "Drones:  " + level.controllable_drones.size );
        waitframe();
    }
}

swarm_drone_hud_change( var_0 )
{
    self.dronecrate_hud["overlay1"] _meth_80CC( var_0, 640, 480 );
}

swarm_drone_hud_off( var_0 )
{
    common_scripts\utility::array_call( self.dronecrate_hud, ::destroy );
}

get_drones_into_start_positions( var_0, var_1, var_2, var_3, var_4 )
{
    wait(randomfloat( var_1 / 2 ));
    var_0 = self.origin + ( randomintrange( -20, 20 ), randomintrange( -20, 20 ), 20 + var_1 * 12 );
    vehicle_scripts\_attack_drone_common::drone_lerp_to_position( ( self.origin[0], self.origin[1], var_0[2] ), 50 );
    self _meth_82B5( var_2.angles, 1, 0.1, 0.5 );
    wait 1;
    vehicle_scripts\_attack_drone_common::drone_lerp_to_position( var_0, 50 );
    var_3 vehicle_scripts\_attack_drone_common::add_to_flock( self );
}

attack_hint_display()
{
    for (;;)
    {
        common_scripts\utility::flag_waitopen( "controlling_drones" );
        common_scripts\utility::flag_wait( "controlling_drones" );
        maps\_utility::hint( "Press ^3[{+attack}]^7 to launch a drone at each locked on target" );
        level.player common_scripts\utility::waittill_any( "attack_pressed", "dpad_down" );
        maps\_utility::hint_fade();
    }
}

drone_enabled_animation()
{
    level.player _meth_831D();
    level.player waittill( "weapon_change" );
    var_0 = maps\_utility::spawn_anim_model( "drone_control_view_model" );
    var_0 _meth_80A6( level.player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    level.player maps\_anim::anim_single_solo( var_0, "drone_control_on" );
    level.player _meth_831E();
    var_0 _meth_804F();
    var_0 delete();
}

setup_drone_mode()
{
    foreach ( var_1 in level.controllable_drones )
    {
        if ( isdefined( var_1 ) )
        {
            var_1 maps\_vehicle::godon();
            var_1 _meth_8029();
        }
    }

    foreach ( var_4 in level.controllable_drone_swarm_target )
    {
        if ( isdefined( var_4 ) )
            var_4 _meth_8029();
    }

    waitframe();
    level.player thermalvisionon();
    level.player swarm_drone_hud_change( level.controllable_drone_hud );
}

remove_drone_mode()
{
    var_0 = level.player.drone_locked_targets;

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && _func_0A3( var_2 ) )
            _func_09B( var_2 );
    }

    level.player.drone_locked_targets = [];
    level.player thermalvisionoff();
    level.player swarm_drone_hud_change( level.controllable_drone_activated );
}

handle_drone_target_selection()
{
    var_0 = _func_0D6( "axis" );
    level.controllable_drone_swarm_target = maps\_utility::array_removedead( level.controllable_drone_swarm_target );
    var_1 = common_scripts\utility::array_combine( level.controllable_drone_swarm_target, var_0 );
    var_1 = common_scripts\utility::array_removeundefined( var_1 );
    var_1 = common_scripts\utility::array_remove_duplicates( var_1 );
    level.player.drone_locked_targets = [];

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.ridingvehicle ) )
            var_1 = common_scripts\utility::array_remove( var_1, var_3 );
    }

    handle_drone_target_selection_internal( var_1 );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3 ) && _func_0A3( var_3 ) )
            _func_09B( var_3 );
    }

    if ( common_scripts\utility::flag( "drone_swarm_launched" ) )
        level waittill( "drone_swarm_launch_seq_complete" );
}

handle_drone_target_selection_internal( var_0 )
{
    level.player endon( "dpad_down" );
    level endon( "drone_swarm_launched" );
    level.player endon( "drone_killed_by_death" );
    var_1 = common_scripts\utility::spawn_tag_origin();
    _func_09A( var_1 );
    _func_0A6( var_1, level.player );

    foreach ( var_3 in var_0 )
        var_3.lock_on_stage = 0;

    for (;;)
    {
        foreach ( var_3 in var_0 )
        {
            if ( !isdefined( var_3 ) || var_3.lock_on_stage == level.drone_lockon_icons.size )
                continue;

            var_1.origin = var_3.origin;
            var_6 = level.controllable_cloud_queen vehicle_scripts\_pdrone_player::pdrone_player_get_current_fov();
            var_7 = 60;
            var_8 = _func_09F( var_1, level.player, var_6, var_7 );
            var_8 = var_8 && level.player.drone_locked_targets.size < level.controllable_drones.size;

            if ( var_8 )
            {
                if ( var_3.lock_on_stage == 0 )
                    _func_09A( var_3, ( 0, 0, 32 ) );

                var_3.lock_on_stage++;

                if ( var_3.lock_on_stage == level.drone_lockon_icons.size )
                {
                    if ( var_3 maps\_vehicle::isvehicle() )
                        _func_09C( var_3, "drone_hud_veh_lockon" );
                    else
                        _func_09C( var_3, "drone_hud_npc_lockon" );

                    level.player.drone_locked_targets[level.player.drone_locked_targets.size] = var_3;
                    level.player notify( "drone_target_aquired" );
                }
                else
                    _func_09C( var_3, level.drone_lockon_icons[var_3.lock_on_stage] );

                continue;
            }

            if ( _func_0A3( var_3 ) )
            {
                var_3.lock_on_stage = 0;
                _func_09B( var_3 );
            }
        }

        waitframe();
    }
}

waittill_attack_and_launch_drones()
{
    common_scripts\utility::flag_clear( "drone_swarm_launched" );
    level.player waittill( "attack_pressed" );
    level.player.drone_locked_targets = common_scripts\utility::array_removeundefined( level.player.drone_locked_targets );
    level.player.drone_locked_heli_target = undefined;

    foreach ( var_1 in level.player.drone_locked_targets )
    {
        if ( var_1 maps\_vehicle::isvehicle() && var_1 maps\_vehicle::ishelicopter() )
        {
            level.player.drone_locked_heli_target = var_1;
            level.player.drone_locked_targets = common_scripts\utility::array_remove( level.player.drone_locked_targets, var_1 );
            break;
        }
    }

    if ( level.player.drone_locked_targets.size > 0 )
    {
        common_scripts\utility::flag_set( "drone_swarm_launched" );
        var_3 = level.player.drone_locked_targets.size - 1;
        level.player.drone_locked_special_target = level.player.drone_locked_targets[var_3];
        level.player.drone_locked_special_target.health = 1000;
        level.player.drone_locked_targets = maps\_utility::array_remove_index( level.player.drone_locked_targets, var_3 );

        if ( level.player.drone_locked_targets.size > 0 )
            launch_drone_missiles( level.player.drone_locked_targets );

        level.player.drone_locked_special_target.health = 50;
        launch_drone_missile_special( level.player.drone_locked_special_target );
    }

    level notify( "drone_swarm_launch_seq_complete" );

    if ( isdefined( level.player.drone_locked_heli_target ) )
        level.player.drone_locked_heli_target thread helicopter_drone_attack( level.controllable_cloud_queen.origin );
}

player_attack_think()
{
    level.player endon( "death" );

    if ( common_scripts\utility::flag( "player_attack_think_running" ) )
        return;

    common_scripts\utility::flag_set( "player_attack_think_running" );
    var_0 = 1000;
    thread attack_hint_display();

    for (;;)
    {
        level.player waittill( "dpad_down" );

        if ( level.controllable_drones.size == 0 )
            continue;

        drone_enabled_animation();

        if ( level.controllable_drones.size > 0 )
        {
            common_scripts\utility::flag_set( "controlling_drones" );
            common_scripts\utility::flag_set( "controlling_drones_first_time" );
            var_1 = level.controllable_cloud_queen;
            var_1.is_player_controlled = 1;
            setup_drone_mode();
            vehicle_scripts\_pdrone_player::pdrone_player_use( var_1, undefined, 0, undefined, undefined, "LT", "ui_sniperdrone" );
            thread maps\_introscreen::introscreen_generic_fade_in( "black", 0.5, 0.5 );
            var_1 vehicle_scripts\_pdrone_player::pdrone_player_enter();
            var_1 _meth_80C6();
            thread waittill_attack_and_launch_drones();

            if ( isdefined( level.controllable_drone_allowed_vols ) )
            {

            }

            var_1 thread vehicle_scripts\_pdrone_player::pdrone_player_loop();
            handle_drone_target_selection();
            var_1 vehicle_scripts\_pdrone_player::pdrone_player_exit();
            var_1.is_player_controlled = 0;
            thread maps\_introscreen::introscreen_generic_fade_in( "black", 0.5, 0.5 );
            remove_drone_mode();
            common_scripts\utility::flag_clear( "controlling_drones" );
        }

        waitframe();
    }
}

drone_missile_make( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_2 _meth_80B1( "vehicle_sentinel_survey_drone" );
    var_2 drone_missile_init( var_0, var_1 );
    return var_2;
}

drone_missile_init( var_0, var_1 )
{
    self.launch_org = var_0;
    self.target_org = var_1;
    self.direction = self.target_org - self.launch_org;
    var_2 = 500;
    self.total_time = length( self.target_org - self.launch_org ) / var_2;
    self.vec_acceleration = ( -1, -1, -150 );
    self.vec_velocity = ( 2 * ( self.target_org - self.launch_org ) - self.vec_acceleration * self.total_time * self.total_time ) / 2 * self.total_time;
}

drone_missile_loop()
{
    self.time_passed = 0;

    while ( self.time_passed <= self.total_time )
    {
        var_0 = self.origin;
        self.origin = self.launch_org + self.time_passed * self.vec_velocity + 0.5 * self.vec_acceleration * self.time_passed * self.time_passed;
        self.angles = vectortoangles( self.target_org - self.origin );
        self.time_passed += 0.05;
        wait 0.05;
    }

    _func_071( "fraggrenade", self.origin, ( 0, 0, 0 ), 0.05, level.player );
    self delete();
    level notify( "drone_missile_loop_complete", self );
}

launch_drone_missile_special( var_0 )
{
    level.controllable_drones = common_scripts\utility::array_removeundefined( level.controllable_drones );
    var_1 = level.controllable_drones[0];
    level.controllable_drones = common_scripts\utility::array_remove( level.controllable_drones, var_1 );
    var_1 delete();
    var_2 = drone_missile_make( level.player.origin, var_0.origin );
    player_linkto_drone_missile( var_2 );
    var_2 drone_missile_loop();
    player_unlink_from_drone_missile();
}

launch_drone_missiles( var_0 )
{
    var_1 = level.player.origin;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) )
        {
            var_1 = var_3.origin;
            break;
        }
    }

    level.controllable_drones = common_scripts\utility::array_removeundefined( level.controllable_drones );
    var_5 = level.controllable_drones;
    var_5 = sortbydistance( var_5, var_1 );
    var_6 = [];

    foreach ( var_8 in var_0 )
    {
        if ( isdefined( var_8 ) )
        {
            var_6[var_6.size] = var_8;

            if ( _func_0A3( var_8 ) )
                _func_09B( var_8 );
        }
    }

    var_10 = 0;

    foreach ( var_20, var_12 in var_0 )
    {
        if ( !isdefined( var_12 ) )
            continue;

        var_13 = var_5[var_20];

        if ( !isdefined( var_13 ) )
        {
            foreach ( var_3 in var_0 )
            {
                if ( isdefined( var_3 ) )
                    var_12 = var_3;
            }
        }

        if ( !isdefined( var_13 ) )
            return;

        var_13 notify( "im_attacking" );
        var_13.remove_from_flock = 1;
        var_16 = var_13.origin;
        var_16 = level.player _meth_80A8();
        var_17 = level.player getangles();
        var_13 delete();
        level.controllable_drones = common_scripts\utility::array_removeundefined( level.controllable_drones );
        var_18 = ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), 0 );
        var_19 = drone_missile_make( var_16, var_12.origin );
        var_10++;
        var_19 _meth_8029();
        var_19 thread drone_missile_loop();
    }

    while ( var_10 > 0 )
    {
        level waittill( "drone_missile_loop_complete", var_21 );
        var_10--;
    }
}

cleanup_missile( var_0, var_1 )
{
    while ( isdefined( var_0 ) )
        wait 0.05;

    var_1 delete();
}

drone_lockon_missile_fire( var_0, var_1 )
{
    wait(randomfloatrange( 0.1, 0.35 ));
    var_2 = common_scripts\utility::spawn_tag_origin();

    if ( issentient( "target" ) )
        var_2.origin = var_1 _meth_80A8();
    else
        var_2.origin = var_1.origin;

    var_2 _meth_804D( var_1 );
    _func_09A( var_2 );
    _func_0A6( var_2, level.player );

    if ( issentient( "target" ) )
        var_3 = magicbullet( "remote_missile_drone_light", var_0, var_1 _meth_80A8() + ( 0, 0, 200 ), level.player );
    else
        var_3 = magicbullet( "remote_missile_drone_light", var_0, var_1.origin + ( 0, 0, 200 ), level.player );

    var_3 _meth_81D9( var_2 );
    var_3 _meth_81DD();
    thread cleanup_missile( var_3, var_2 );
    return var_3;
}

getclosestdrone( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 500000;

    if ( !isdefined( var_1 ) )
        return;

    var_3 = undefined;

    foreach ( var_5 in var_1 )
    {
        if ( !isdefined( var_5 ) )
            continue;

        var_6 = distance( var_5.origin, var_0 );

        if ( var_6 >= var_2 )
            continue;

        var_2 = var_6;
        var_3 = var_5;
    }

    return var_3;
}

monitor_drone_missile_death()
{
    while ( isdefined( self ) )
        waitframe();

    level.player notify( "drone_missile_impact" );
}

helicopter_drone_attack( var_0 )
{
    if ( isdefined( level.drone_swarm_queens[1] ) )
        var_1 = level.drone_swarm_queens[1];
    else
        var_1 = level.drone_swarm_queens[2];

    var_2 = var_1.origin;

    foreach ( var_4 in var_1.boids )
    {
        if ( isdefined( var_4 ) )
            var_4 delete();
    }

    var_1 delete();
    var_6 = undefined;
    var_7 = undefined;

    if ( level.nextgen )
    {
        var_6 = 12;
        var_7 = 24;
    }
    else
    {
        var_6 = 6;
        var_7 = 12;
    }

    var_8 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud( "queen_drone_cloud_2", undefined, var_6, var_7, var_2 );
    level notify( "drone_attacked_chopper" );
    var_8 vehicle_scripts\_attack_drone_common::snake_cloud_pester_helicopter( self );
}

send_swarm_to_chopper( var_0 )
{
    while ( isdefined( var_0 ) && isdefined( self ) )
    {
        self _meth_825B( var_0.origin, 1 );
        wait 0.05;
    }
}

create_drone_kamikazes( var_0 )
{
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.angles = self.angles;
    var_1.origin = var_1 vehicle_scripts\_attack_drone_common::offset_position_from_drone( "forward", "tag_origin", 50 );
    var_2[0] = var_1 vehicle_scripts\_attack_drone_common::offset_position_from_drone( "right", "tag_origin", 60 );
    var_2[1] = var_1 vehicle_scripts\_attack_drone_common::offset_position_from_drone( "left", "tag_origin", 70 );
    var_2[2] = var_1 vehicle_scripts\_attack_drone_common::offset_position_from_drone( "up", "tag_origin", 40 );
    var_2[3] = var_1 vehicle_scripts\_attack_drone_common::offset_position_from_drone( "down", "tag_origin", 40 );

    foreach ( var_4 in var_2 )
    {
        var_5 = spawn( "script_model", var_4 );
        var_5 _meth_80B1( "vehicle_sentinel_survey_drone" );
        var_5.angles = var_1.angles;
        var_5 thread vehicle_scripts\_attack_drone_common::lerp_drone_to_position( var_0.origin, randomintrange( 600, 700 ) );
        var_5 thread simple_drone_health();
    }
}

clear_drone_cloud()
{

}

monitor_drone_cloud_members()
{
    common_scripts\utility::waittill_any( "im_dying", "explode", "death", "im_attacking" );
    level.controllable_drones = common_scripts\utility::array_remove( level.controllable_drones, self );
}

controllable_fly_think( var_0, var_1 )
{
    if ( self != level.controllable_cloud_queen )
        thread queen_drone_fly( var_0, var_1 );
}

queen_drone_fly( var_0, var_1 )
{
    level endon( "delete_drone_cloud" );
    self endon( "death" );
    self endon( "end_queen_think" );
    level.controllable_cloud_queen endon( "end_drone_swarm" );
    self.radii = var_1;
    self.accel = level.boid_settings_presets["controllable_swarm"].queen_data_accel;
    self.decel = level.boid_settings_presets["controllable_swarm"].queen_data_decel;
    self.desired_speed = level.boid_settings_presets["controllable_swarm"].queen_data_desired_speed;
    var_2 = ( 0, 0, 0 );
    self notify( "queen_set_fly_logic" );

    for (;;)
    {
        var_3 = position_in_circle( var_0.origin, self.radii );
        var_2 = var_3;
        var_4 = var_0 _meth_8286() * 1.75;

        if ( var_4 <= 0 )
            var_4 = 1;

        self _meth_8283( var_4, var_4, var_4 * 1.5 );
        self _meth_825B( var_3 );

        if ( !common_scripts\utility::flag( "cloud_in_formation" ) )
        {
            if ( self.location + 1 <= 120 )
                self.location++;
            else
                self.location = 0;

            waitframe();
            continue;
        }

        wait 0.25;
    }
}

position_in_circle( var_0, var_1 )
{
    var_2 = var_1;
    var_3 = 1;
    var_4 = 120;
    var_5 = 3.0;
    var_6 = [];
    var_7 = [];

    for ( var_8 = 0; var_8 < var_4; var_8++ )
    {
        var_3 = var_5 * var_8;
        var_9 = 0;
        var_6[var_6.size] = var_0 + anglestoforward( ( var_9, var_3, 0 ) ) * var_2;
    }

    if ( isdefined( var_6[self.location] ) )
        return var_6[self.location];
    else
        return var_6[0];
}

make_crate_boidcloud( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.boids = [];
    var_2.queen = self;
    var_2.queen.flock = var_2;

    if ( isdefined( var_1 ) )
        var_2.boid_settings = var_1;
    else
        var_2.boid_settings = spawnstruct();

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        var_4 = spawn( "script_model", var_0[var_3].origin );
        var_4 _meth_80B1( "vehicle_mil_attack_drone_static" );
        var_4.angles = var_0[var_3].angles;
        var_4 thread get_drones_into_start_positions( var_0[var_3], var_3, var_2.queen, var_2 );
        var_0[var_3] hide();
        var_4 thread monitor_controllable_drone_cloud_health();
        thread monitor_drone_cloud_members();
        level.controllable_drones[level.controllable_drones.size] = var_4;
        waitframe();
    }

    self.boids = var_2.boids;
    var_2.queen.boid_cloud_spawned = 1;
    var_2 thread vehicle_scripts\_attack_drone_common::boid_flock_think();
    return var_2;
}

will_boid_clip_camera( var_0 )
{
    var_1 = 150;

    if ( !isdefined( level.controllable_cloud_queen.camera_tag ) )
        return 0;

    if ( distance( var_0, level.controllable_cloud_queen.camera_tag.origin ) < var_1 )
        return 1;

    return 0;
}

simple_drone_health()
{
    self _meth_82C0( 1 );
    self.can_be_damaged = 1;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( vehicle_scripts\_attack_drone_common::is_bullet_damage( var_4 ) )
            thread vehicle_scripts\_attack_drone_common::fake_drone_death();
    }
}

monitor_controllable_drone_cloud_health( var_0 )
{
    self notify( "kill_drone_cloud_health_process" );
    self endon( "kill_drone_cloud_health_process" );

    if ( isdefined( self ) )
        self.can_be_damaged = 0;

    if ( !isdefined( self ) )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !var_0 && randomint( 100 ) > 25 )
        return;

    if ( !var_0 )
        wait(randomfloat( 1.0 ));

    self _meth_82C0( 1 );
    self.can_be_damaged = 1;
    var_1 = 0;

    for (;;)
    {
        self waittill( "damage", var_2, var_3, var_4, var_5, var_6 );

        if ( vehicle_scripts\_attack_drone_common::is_bullet_damage( var_6 ) )
            var_1++;

        if ( var_1 >= 2 )
        {
            thread vehicle_scripts\_attack_drone_common::fake_drone_death();
            level notify( "drone_killed_by_death" );
            break;
        }
    }
}

boid_add_vehicle_to_targets( var_0, var_1 )
{
    var_0 notify( "stop_friendlyfire_shield" );
    level endon( "end_drone_cloud" );
    var_0 endon( "death" );

    if ( !isdefined( var_1 ) )
        var_1 = 300;

    while ( !level.swarm_spawned )
        waitframe();

    while ( distance( var_0.origin, level.cloud_queen.origin ) > var_1 )
    {
        var_2 = distance( var_0.origin, level.cloud_queen.origin );
        waitframe();
    }

    while ( vehicle_scripts\_attack_drone_common::isdronevehiclealive( var_0 ) )
    {
        var_3 = sortbydistance( level.controllable_drones, var_0.origin );

        for ( var_4 = 0; var_4 < 5; var_4++ )
        {
            var_3[var_4] thread vehicle_scripts\_attack_drone_common::boid_vehicle_targets( var_0, var_1 );
            wait 0.1;
        }

        wait 2;
    }
}
