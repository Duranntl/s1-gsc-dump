// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );
    maps\_utility::set_console_status();
    setup_pdrone_type( var_2 );
    level._effect["pdrone_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["pdrone_large_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
    level._effect["pdrone_emp_death"] = loadfx( "vfx/explosion/vehicle_pdrone_explosion" );
    level._effect["emp_drone_damage"] = loadfx( "vfx/sparks/emp_drone_damage" );
    level._effect["ie_drone_thrusters_side"] = loadfx( "vfx/map/irons_estate/ie_drone_thrusters_side" );
    level._effect["ie_drone_thrusters"] = loadfx( "vfx/map/irons_estate/ie_drone_thrusters" );
    level._effect["ie_drone_eye_emissive"] = loadfx( "vfx/map/irons_estate/ie_drone_eye_emissive" );
    level._effect["ie_drone_eye_emissive_bootup"] = loadfx( "vfx/map/irons_estate/ie_drone_eye_emissive_bootup" );
    level._effect["drone_search_lt"] = loadfx( "vfx/lights/drone_search_lt" );
    level._effect["atlas_drone_shell"] = loadfx( "vfx/shelleject/atlas_drone_shell" );
    level._effect["atlas_drone_turret_flash"] = loadfx( "vfx/muzzleflash/atlas_drone_turret_flash" );
    level._effect["ie_drone_gun_lights"] = loadfx( "vfx/map/irons_estate/ie_drone_gun_lights" );
    level._effect["ie_drone_thrusters_side"] = loadfx( "vfx/map/irons_estate/ie_drone_thrusters_side" );
    level._effect["ie_drone_thrusters"] = loadfx( "vfx/map/irons_estate/ie_drone_thrusters" );
    level._effect["ie_drone_eye_emissive"] = loadfx( "vfx/map/irons_estate/ie_drone_eye_emissive" );
    level._effect["ie_drone_eye_emissive_bootup"] = loadfx( "vfx/map/irons_estate/ie_drone_eye_emissive_bootup" );
    level._effect["ie_drone_wash"] = loadfx( "vfx/map/irons_estate/ie_drone_wash" );
    level._effect["drone_search_lt"] = loadfx( "vfx/lights/drone_search_lt" );
    level._effect["drone_scan"] = loadfx( "vfx/map/irons_estate/ie_drone_scan" );
    level._effect["ie_drone_cam_distort"] = loadfx( "vfx/map/irons_estate/ie_drone_cam_distort" );
    level.sdrone_weapon_fire_sounds = [ "sdrone_weapon_fire", "sdrone_weapon_fire_alt1", "sdrone_weapon_fire_alt2" ];
    level.sdrone_weapon_fire_sound_next = 0;
    var_3 = "pdrone_security";

    if ( isdefined( var_1 ) )
        var_3 = var_1;

    maps\_vehicle::build_template( var_3, var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_drive( undefined, undefined, 0 );
    maps\_vehicle::build_deathquake( 0.4, 0.8, 1024 );
    maps\_vehicle::build_life( level.pdrone_parms[var_2]["health"] );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_mainturret();
    var_4 = randomfloatrange( 0, 1 );
    var_5 = var_2;
    maps\_vehicle::build_is_helicopter();
}

setup_pdrone_type( var_0 )
{
    if ( !isdefined( level.pdrone_parms ) )
        level.pdrone_parms = [];

    if ( isdefined( level.pdrone_parms[var_0] ) )
        return;

    level.pdrone_parms[var_0] = [];
    level.pdrone_parms[var_0]["health"] = 800;
    level.pdrone_parms[var_0]["axial_move"] = 1;
    level.pdrone_parms[var_0]["hover_radius"] = 16;
    level.pdrone_parms[var_0]["hover_speed"] = 8;
    level.pdrone_parms[var_0]["hover_accel"] = 8;
    level.pdrone_parms[var_0]["speed"] = 40;
    level.pdrone_parms[var_0]["accel"] = 80;
    level.pdrone_parms[var_0]["decel"] = 80;
    level.pdrone_parms[var_0]["angle_vel_pitch"] = 1000;
    level.pdrone_parms[var_0]["angle_vel_yaw"] = 2000;
    level.pdrone_parms[var_0]["angle_vel_roll"] = 10;
    level.pdrone_parms[var_0]["angle_accel"] = 1000;
    level.pdrone_parms[var_0]["yaw_speed"] = 2000;
    level.pdrone_parms[var_0]["yaw_accel"] = 2000;
    level.pdrone_parms[var_0]["yaw_decel"] = 2000;
    level.pdrone_parms[var_0]["yaw_over"] = 0.0;
    level.pdrone_parms[var_0]["pitchmax"] = 5;
    level.pdrone_parms[var_0]["rollmax"] = 5;
    level.pdrone_parms[var_0]["weap_fire_tags"] = [ "tag_muzzle_flash_lt", "tag_muzzle_flash_rt" ];
    level.pdrone_parms[var_0]["clear_look"] = 0;
}

drone_parm( var_0 )
{
    return level.pdrone_parms[self.classname][var_0];
}

init_class_motion( var_0, var_1, var_2 )
{
    self _meth_8253( drone_parm( "hover_radius" ), drone_parm( "hover_speed" ), drone_parm( "hover_accel" ) );
    self _meth_8294( drone_parm( "pitchmax" ), drone_parm( "rollmax" ) );
    var_3 = drone_parm( "speed" );
    var_4 = drone_parm( "accel" );
    var_5 = drone_parm( "decel" );

    if ( isdefined( var_0 ) )
        var_3 = var_0;

    if ( isdefined( var_1 ) )
        var_4 = var_1;

    if ( isdefined( var_2 ) )
        var_5 = var_2;

    self _meth_8283( var_3, var_4, var_5 );
    self _meth_84B1( drone_parm( "angle_vel_pitch" ), drone_parm( "angle_vel_yaw" ), drone_parm( "angle_vel_roll" ) );
    self _meth_84B2( drone_parm( "angle_accel" ) );
    self _meth_825A( 5 );
    self _meth_8292( drone_parm( "yaw_speed" ), drone_parm( "yaw_accel" ), drone_parm( "yaw_decel" ), drone_parm( "yaw_over" ) );
    self _meth_84E4( drone_parm( "axial_move" ) );
}

init_local()
{
    self endon( "death" );
    self.originheightoffset = distance( self gettagorigin( "tag_origin" ), self gettagorigin( "tag_ground" ) );
    self.script_badplace = 0;
    self.dontdisconnectpaths = 1;
    self.vehicle_heli_default_path_speeds = ::init_class_motion;
    init_class_motion();
    self _meth_8267( "pdrone_turret_security" );

    if ( self.script_team == "allies" )
    {
        thread maps\_vehicle::vehicle_lights_on( "friendly" );
        self.contents = self setcontents( 0 );
    }
    else
    {
        thread maps\_vehicle::vehicle_lights_on( "hostile" );
        self.ignore_death_fx = 1;
        self.delete_on_death = 1;
        thread pdrone_handle_death();
    }

    maps\_utility::ent_flag_init( "sentient_controlled" );
    maps\_utility::ent_flag_init( "fire_disabled" );
    self.playing_hit_reaction = 0;
    self.drone_relocating = 0;
    self.drone_firing = 0;
    vehicle_scripts\_pdrone_threat_sensor::build_threat_data();
    waittillframeend;
    self.emp_death_function = ::pdrone_emp_death;
    maps\_utility::add_damage_function( ::pdrone_damage_function );
    thread maps\_damagefeedback::monitordamage();

    if ( self.script_team != "allies" )
    {
        self enableaimassist();
        thread maps\_shg_utility::make_emp_vulnerable();
    }

    if ( isdefined( self.script_parameters ) && self.script_parameters == "diveboat_weapon_target" )
    {
        _func_09A( self, ( 0, 0, 0 ) );
        _func_0A6( self, level.player );
    }
    else if ( self.classname != "script_vehicle_pdrone_kva" )
    {
        _func_09A( self, ( 0, 0, 0 ) );
        _func_0A5( self, 1 );
    }

    thread pdrone_ai( 0 );
    thread pdrone_flying_fx();
    self notify( "stop_kicking_up_dust" );
    thread handle_pdrone_audio();
}

handle_pdrone_audio()
{
    self endon( "death" );
    var_0 = spawnstruct();
    var_0.preset_name = "pdrone_security";
    var_1 = vehicle_scripts\_pdrone_security_aud::snd_pdrone_security_constructor;
    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
}

pdrone_ai( var_0 )
{
    self endon( "death" );
    self _meth_8139( self.script_team, var_0 );
    self _meth_8294( drone_parm( "pitchmax" ), drone_parm( "rollmax" ) );
    thread vehicle_scripts\_pdrone_threat_sensor::pdrone_update_threat_sensor();
    thread pdrone_player_collision_monitor();
}

pdrone_player_collision_monitor()
{
    self endon( "death" );
    var_0 = undefined;
    var_1 = 0;

    while ( isdefined( self ) )
    {
        var_2 = distancesquared( level.player.origin, self.origin );
        var_3 = var_2 < 16384 && level.player.origin[2] > self.origin[2];

        if ( !var_1 && var_3 )
        {
            var_0 = self setcontents( 0 );
            var_1 = 1;
        }
        else if ( var_1 && !var_3 )
        {
            self setcontents( var_0 );
            var_1 = 0;
        }

        wait 0.05;
    }
}

pdrone_flying_fx()
{
    self endon( "death" );
    var_0 = 0.3;
    playfxontag( common_scripts\utility::getfx( "ie_drone_eye_emissive" ), self, "TAG_MAIN_CAMERA" );
    playfxontag( common_scripts\utility::getfx( "ie_drone_thrusters" ), self, "TAG_EXHAUST_REAR" );
    playfxontag( common_scripts\utility::getfx( "ie_drone_thrusters_side" ), self, "TAG_EXHAUST_LT" );
    playfxontag( common_scripts\utility::getfx( "ie_drone_thrusters_side" ), self, "TAG_EXHAUST_RT" );
    thread drone_security_thrust_fx( "ie_drone_wash", "ie_drone_cam_distort", "TAG_ORIGIN", 105 );
}

drone_security_thrust_fx( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    var_4 = var_3 * 3 * ( var_3 * 3 );
    var_5 = [ "", "" ];
    var_6 = [ "", "" ];
    var_7 = [];

    for ( var_8 = 0; var_8 < var_5.size; var_8++ )
    {
        var_7[var_8] = common_scripts\utility::spawn_tag_origin();
        var_7[var_8].angles = ( -90, 0, 0 );
        var_7[var_8] thread drone_security_thrust_fx_cleanup( self );
    }

    for (;;)
    {
        var_9 = self gettagorigin( var_2 );
        var_10 = var_9 - ( 0, 0, var_3 );
        var_11 = bullettrace( var_9, var_10, 0, self, 1 );
        var_5[0] = "";
        var_5[1] = "";

        if ( var_11["fraction"] < 1.0 )
        {
            var_5[0] = var_0;

            if ( self == level.player.closest_drone && distancesquared( var_9, level.player _meth_80A8() ) < var_4 && isdefined( level.player.inwater ) && isdefined( level.player.underwater ) )
                var_5[1] = var_1;

            for ( var_8 = 0; var_8 < var_5.size; var_8++ )
            {
                var_7[var_8] _meth_804F();
                var_7[var_8].origin = var_11["position"];
                var_7[var_8] _meth_804D( self );
            }
        }

        for ( var_8 = 0; var_8 < var_5.size; var_8++ )
        {
            if ( var_5[var_8] != var_6[var_8] )
            {
                if ( var_6[var_8] != "" )
                {
                    stopfxontag( common_scripts\utility::getfx( var_6[var_8] ), var_7[var_8], "tag_origin" );
                    var_6[var_8] = "";
                }

                if ( var_5[var_8] != "" )
                {
                    playfxontag( common_scripts\utility::getfx( var_5[var_8] ), var_7[var_8], "tag_origin" );
                    var_6[var_8] = var_5[var_8];
                }
            }
        }

        wait 0.25;
    }
}

drone_security_thrust_fx_cleanup( var_0 )
{
    self notify( "drone_security_thrust_fx_cleanup" );
    self endon( "drone_security_thrust_fx_cleanup" );
    self endon( "death" );
    var_0 waittill( "death" );

    if ( isdefined( self ) )
        self delete();
}

pdrone_get_nodes_in_radius( var_0, var_1, var_2, var_3 )
{
    return getnodesinradius( var_0, var_1, var_2, var_3, "Path", "Exposed" );
}

pdrone_can_move_to_point( var_0, var_1 )
{
    var_1 += vectornormalize( var_1 - var_0 ) * 32;
    var_0 += ( 0, 0, -24 );
    var_1 += ( 0, 0, -24 );
    var_2 = playerphysicstrace( var_0, var_1 );
    var_3 = distancesquared( var_2, var_1 ) < 0.01;
    return var_3;
}

pdrone_can_teleport_to_point( var_0 )
{
    var_1 = var_0 + ( 0, 0, 12 );
    var_2 = playerphysicstrace( var_1, var_0 );
    var_3 = distancesquared( var_2, var_0 ) < 0.01;
    return var_3;
}

pdrone_can_see_owner_from_point( var_0 )
{
    var_1 = self.owner _meth_80A8();
    var_2 = sighttracepassed( var_0, var_1, 0, self );
    return var_2;
}

pdrone_targeting( var_0 )
{
    self notify( "pdrone_targeting" );
    self endon( "pdrone_targeting" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self endon( "death" );
    self endon( "emp_death" );
    var_1 = "axis";

    if ( self.script_team == "axis" )
    {
        var_1 = "allies";

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_3 in self.mgturret )
                var_3.script_team = "axis";
        }
    }

    for (;;)
    {
        wait 0.05;

        if ( self.reached_node && isdefined( self.drone_threat_data.threat ) )
        {
            thread pdrone_fire_at_enemy( self.drone_threat_data.threat, var_0 );
            self.drone_threat_data.threat common_scripts\utility::waittill_any( "death", "target_lost" );
            continue;
        }

        if ( drone_parm( "clear_look" ) )
            self _meth_8266();

        if ( isdefined( self.owner ) )
            self _meth_825E( self.owner.angles[1] );
    }
}

calculate_lateral_move_accuracy( var_0 )
{
    var_1 = ( var_0.origin - self.origin ) * ( 1, 1, 0 );
    var_1 = vectornormalize( var_1 );
    var_1 = ( var_1[1], var_1[0] * -1, 0 );
    var_2 = abs( vectordot( var_1, var_0 getvelocity() ) );
    var_2 = clamp( var_2, 0, 250 ) / 250;
    var_2 = 1 - var_2;
    var_2 = clamp( var_2, 0.3, 1 );
    return var_2;
}

calculate_stance_accuracy( var_0 )
{
    if ( var_0 _meth_817C() == "crouch" )
        return 0.75;
    else if ( var_0 _meth_817C() == "prone" )
        return 0.5;

    return 1;
}

calculate_player_wounded_accuracy( var_0 )
{
    if ( level.player maps\_utility::ent_flag( "player_has_red_flashing_overlay" ) )
        return 0.5;

    return 1;
}

calculate_aim_offset( var_0, var_1 )
{
    var_2 = self.origin - var_0.origin;
    var_2 *= ( 1, 1, 0 );
    var_2 = vectornormalize( var_2 );

    if ( isplayer( var_0 ) )
    {
        var_1 *= calculate_lateral_move_accuracy( var_0 );
        var_1 *= calculate_stance_accuracy( var_0 );
        var_1 *= calculate_player_wounded_accuracy( var_0 );
    }

    var_3 = vectorcross( ( 0, 0, 1 ), var_2 );
    var_4 = var_3 * 10 / var_1 * randomfloatrange( -1, 1 );
    var_5 = ( 0, 0, 5 ) / var_1 * randomfloatrange( -1, 1 );
    return var_4 + var_5;
}

pdrone_should_hold_fire()
{
    if ( self.drone_firing )
        return 0;

    if ( self.drone_relocating )
        return 1;

    return !pdrone_fire_request();
}

pdrone_fire_request()
{
    var_0 = 2;

    if ( !isdefined( level.drone_fire_queue ) )
        level.drone_fire_queue = [];

    level.drone_fire_queue = common_scripts\utility::array_removeundefined( level.drone_fire_queue );

    if ( !common_scripts\utility::array_contains( level.drone_fire_queue, self ) )
        level.drone_fire_queue = common_scripts\utility::array_add( level.drone_fire_queue, self );

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        if ( level.drone_fire_queue[var_1] == self )
            return 1;
    }

    return 0;
}

pdrone_fire_finished()
{
    self.drone_firing = 0;
    level.drone_fire_queue = common_scripts\utility::array_remove( level.drone_fire_queue, self );
}

pdrone_cycle_fire_sound()
{
    self.weapon_fire_sound = level.sdrone_weapon_fire_sound_next;
    level.sdrone_weapon_fire_sound_next += 1;

    if ( level.sdrone_weapon_fire_sound_next >= level.sdrone_weapon_fire_sounds.size )
        level.sdrone_weapon_fire_sound_next = 0;
}

pdrone_fire_at_enemy( var_0, var_1 )
{
    self notify( "pdrone_fire_at_enemy" );
    self endon( "pdrone_fire_at_enemy" );
    var_0 endon( "death" );
    self endon( "death" );
    self endon( "emp_death" );
    self endon( "pdrone_targeting" );

    if ( isdefined( self.owner ) )
        self.owner endon( "pdrone_returning" );

    self notify( "new_target" );
    self endon( "new_target" );
    self.drone_firing = 0;
    var_2 = var_0 _meth_80A8() - var_0.origin;

    if ( isdefined( var_0.inwater ) && var_0.inwater )
        var_3 = ( 0, 0, var_2[2] );
    else
        var_3 = ( 0, 0, var_2[2] / 2 );

    var_4 = 1.0;

    if ( isdefined( self.attack_accuracy ) )
        var_4 = self.attack_accuracy;

    if ( isplayer( var_0 ) )
        var_5 = 0.15 * var_4;
    else
        var_5 = 0.3 * var_4;

    var_6 = 0.095;

    if ( !isdefined( var_1 ) )
        var_1 = 0.25;

    var_7 = var_1 - var_1 * 0.2;
    var_8 = var_1 + var_1 * 0.2;

    if ( level.currentgen )
    {
        var_6 = 0.2499;
        var_7 *= 2.5;
        var_8 *= 2.5;
    }

    var_9 = var_3 + calculate_aim_offset( var_0, var_5 );

    if ( !isdefined( self.fire_at_ent ) )
    {
        self.fire_at_ent = common_scripts\utility::spawn_tag_origin();
        self.fire_at_ent thread drone_fire_at_ent_cleanup( self );
    }

    if ( isdefined( self.fire_at_ent ) )
        self _meth_8265( self.fire_at_ent );
    else
        self _meth_8265( var_0 );

    for (;;)
    {
        self _meth_8262( var_0, var_9 );

        if ( isdefined( self.fire_at_ent ) )
        {
            self.fire_at_ent _meth_804F();
            self.fire_at_ent.origin = var_0.origin + var_9;
            self.fire_at_ent _meth_804D( var_0 );
        }

        if ( pdrone_should_hold_fire() )
        {
            wait 0.05;
            continue;
        }

        var_10 = self.origin;
        var_11 = self.angles;
        var_12 = drone_parm( "weap_fire_tags" );
        var_13 = var_12[0];

        if ( self _meth_8442( var_13 ) != -1 )
        {
            var_11 = self gettagangles( var_13 );
            var_10 = self gettagorigin( var_13 );
        }

        if ( pdrone_could_be_friendly_fire( var_10, var_0.origin + var_9 ) || !isdefined( self.drone_threat_data.threat ) || self.drone_threat_data.threat != var_0 )
        {
            var_0 notify( "target_lost" );
            return;
        }

        var_14 = randomfloatrange( 2, 3 );
        var_9 = var_3 + calculate_aim_offset( var_0, var_5 );

        while ( var_14 > 0 )
        {
            if ( pdrone_should_hold_fire() )
            {
                var_14 = randomfloatrange( 2, 3 );
                wait 0.05;
                continue;
            }

            pdrone_cycle_fire_sound();
            var_15 = randomfloatrange( var_7, var_8 );
            var_16 = min( var_15, var_14 );

            while ( var_16 > 0 )
            {
                if ( pdrone_should_hold_fire() )
                {
                    var_16 = min( var_15, var_14 );
                    var_14 = randomfloatrange( 2, 3 );
                    wait(var_6);
                    pdrone_fire_finished();
                    continue;
                }

                self.drone_firing = 1;
                var_10 = self.origin;
                var_11 = self.angles;

                if ( self _meth_8442( var_13 ) != -1 )
                {
                    var_11 = self gettagangles( var_13 );
                    var_10 = self gettagorigin( var_13 );
                }

                var_17 = var_10;
                var_18 = compute_fireweapon_direction( var_17, var_11, var_0.origin + var_9, 10 );

                if ( pdrone_could_be_friendly_fire( var_17, var_17 + var_18 * 10000 ) )
                {
                    var_0 notify( "target_lost" );
                    return;
                }

                pdrone_fire_weapon();
                var_14 -= var_6;
                var_16 -= var_6;
                wait(var_6);
            }

            pdrone_fire_finished();
            var_19 = randomfloatrange( 0.5, 1 );
            var_19 = min( var_19, var_14 );

            if ( var_19 > 0 )
            {
                var_14 -= var_19;
                wait(var_19);
            }
        }
    }
}

drone_fire_at_ent_cleanup( var_0 )
{
    var_0 waittill( "death" );
    self delete();
}

pdrone_fire_weapon()
{
    var_0 = drone_parm( "weap_fire_tags" );
    soundscripts\_snd_playsound::snd_play_linked( level.sdrone_weapon_fire_sounds[self.weapon_fire_sound] );
    pdrone_gunshot_teammate();

    foreach ( var_2 in var_0 )
    {
        self _meth_8268( var_2 );
        self.shot_at_player = 1;
    }
}

pdrone_gunshot_teammate()
{
    if ( !isdefined( self.last_team_gunshot_announce ) || gettime() - self.last_team_gunshot_announce > 1000 )
    {
        self.last_team_gunshot_announce = gettime();
        var_0 = _func_0D6( self.team );

        foreach ( var_2 in var_0 )
        {
            if ( distancesquared( var_2.origin, self.origin ) < 640000 )
                var_2 notify( "gunshot_teammate", self.origin );
        }
    }
}

compute_fireweapon_direction( var_0, var_1, var_2, var_3 )
{
    var_4 = vectortoangles( var_2 - var_0 );
    var_5 = anglessubtract( var_1, var_4 );
    var_5 = ( clamp( var_5[0], 0 - var_3, var_3 ), clamp( var_5[1], 0 - var_3, var_3 ), 0 );
    var_1 = anglessubtract( var_1, var_5 );
    var_6 = anglestoforward( var_1 );
    return var_6;
}

anglessubtract( var_0, var_1 )
{
    return ( angleclamp180( var_0[0] - var_1[0] ), angleclamp180( var_0[1] - var_1[1] ), angleclamp180( var_0[2] - var_1[2] ) );
}

pdrone_could_be_friendly_fire( var_0, var_1 )
{
    if ( self.script_team == "axis" )
        return 0;
    else
        return maps\_utility::shot_endangers_any_player( var_0, var_1 );
}

pdrone_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( var_1 ) && isdefined( var_1.script_team ) && self.script_team == var_1.script_team )
        return;

    if ( var_4 == "MOD_ENERGY" )
        self _meth_8051( var_0 * 4, var_1.origin, var_1 );
    else if ( isalive( self ) && isdefined( var_1 ) && !isplayer( var_1 ) )
        self.health = int( min( self.maxhealth, self.health + var_0 * 0.7 ) );
}

play_death_explosion_fx()
{
    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), self gettagorigin( "tag_origin" ) );
    soundscripts\_snd::snd_message( "pdrone_death_explode" );
    pdrone_notify_explosion();
}

pdrone_notify_explosion()
{
    var_0 = self gettagorigin( "tag_origin" );
    var_1 = _func_0D6( "axis", "allies", "neutral" );
    var_1 = common_scripts\utility::get_array_of_closest( var_0, var_1, undefined, undefined, 1500, undefined );
    var_1 = maps\_utility::array_removedead_or_dying( var_1 );

    if ( isdefined( var_1 ) && var_1.size > 0 )
    {
        foreach ( var_3 in var_1 )
            var_3 notify( "explode", var_0 );
    }
}

pdrone_handle_death()
{
    self waittill( "death", var_0 );

    if ( !isdefined( self ) )
        return;

    setdvarifuninitialized( "drone_spin_death_chance", 0.85 );

    if ( self.script_team != "allies" && !isdefined( self.owner ) && randomfloat( 1 ) <= getdvarfloat( "drone_spin_death_chance" ) )
        thread death_out_of_control( var_0 );
    else
        play_death_explosion_fx();
}

pdrone_emp_death()
{
    self endon( "death" );
    self endon( "in_air_explosion" );
    self notify( "emp_death" );
    self.vehicle_stays_alive = 1;
    var_0 = self _meth_8287();
    var_1 = 60;

    if ( isdefined( level.get_pdrone_crash_location_override ) )
        var_2 = [[ level.get_pdrone_crash_location_override ]]();
    else
    {
        var_3 = ( self.origin[0] + var_0[0] * 10, self.origin[1] + var_0[1] * 10, self.origin[2] - 2000 );
        var_2 = physicstrace( self.origin, var_3 );
    }

    self notify( "newpath" );
    self notify( "deathspin" );
    thread drone_deathspin();
    var_4 = 60;
    self _meth_8283( var_4, 60, 1000 );
    self _meth_825A( var_1 );
    self _meth_825B( var_2, 0 );
    thread drone_emp_crash_movement( var_2, var_1, var_4 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
    play_death_explosion_fx();
    self delete();
}

#using_animtree("script_model");

drone_deathspin()
{
    level.scr_animtree["pdrone_dummy"] = #animtree;
    level.scr_anim["pdrone_dummy"]["roll_left"][0] = %rotate_x_l;
    level.scr_anim["pdrone_dummy"]["roll_right"][0] = %rotate_x_r;
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 _meth_804D( self );

    if ( isdefined( self.death_model_override ) )
        var_0 _meth_80B1( self.death_model_override );
    else
        var_0 _meth_80B1( self.model );

    self hide();
    stopfxontag( common_scripts\utility::getfx( "drone_beacon_red" ), self, "tag_origin" );
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_0, "TAG_ORIGIN" );
    var_0.animname = "pdrone_dummy";
    var_0 maps\_utility::assign_animtree();

    if ( common_scripts\utility::cointoss() )
        var_1 = "roll_left";
    else
        var_1 = "roll_right";

    var_0 thread maps\_anim::anim_loop_solo( var_0, var_1 );
    self waittill( "death" );
    var_0 delete();
}

drone_emp_crash_movement( var_0, var_1, var_2 )
{
    self endon( "crash_done" );
    self _meth_8266();
    self _meth_8294( 180, 180 );
    self _meth_8292( 400, 100, 100 );
    self _meth_8296( 1 );
    var_3 = 1400;
    var_4 = 800;
    var_5 = undefined;
    var_6 = 90 * randomintrange( -2, 3 );

    for (;;)
    {
        if ( !isdefined( self ) )
            break;

        if ( self.origin[2] < var_0[2] + var_1 )
            self notify( "near_goal" );

        if ( common_scripts\utility::cointoss() )
        {
            var_5 = self.angles[1] - 300;
            self _meth_8292( var_3, var_4 );
            self _meth_825E( var_5 );
            self _meth_825E( var_5 );
        }

        wait 0.05;
    }
}

death_out_of_control( var_0 )
{
    var_1 = spawn( "script_model", self.origin );
    var_1.angles = self.angles;

    if ( isdefined( self.death_model_override ) )
        var_1 _meth_80B1( self.death_model_override );
    else
        var_1 _meth_80B1( self.model );

    var_1 setcontents( 0 );
    self setcontents( 0 );
    self hide();
    playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_1, "TAG_ORIGIN" );
    soundscripts\_snd::snd_message( "pdrone_emp_death", var_1 );
    playfxontag( common_scripts\utility::getfx( "ie_drone_thrusters" ), var_1, "TAG_EXHAUST_REAR" );
    playfxontag( common_scripts\utility::getfx( "ie_drone_thrusters_side" ), var_1, "TAG_EXHAUST_LT" );
    playfxontag( common_scripts\utility::getfx( "ie_drone_thrusters_side" ), var_1, "TAG_EXHAUST_RT" );
    var_2 = ( self.origin[0], self.origin[1], self.origin[2] - 500 );
    var_3 = physicstrace( self.origin, var_2 );
    var_4 = 0;
    var_5 = var_0.origin - var_1.origin;
    var_5 = vectornormalize( var_5 );
    var_6 = vectorcross( ( 0, 0, 1 ), var_5 );
    var_6 = vectornormalize( var_6 );
    var_7 = 100;
    var_8 = var_1.origin + var_6 * var_7;
    var_9 = vectortoangles( var_1.origin - var_8 );
    var_10 = 1;

    if ( common_scripts\utility::cointoss() )
        var_10 = -1;

    var_11 = 5.0;
    var_12 = 25;
    var_13 = 0;
    var_14 = var_11;

    if ( common_scripts\utility::cointoss() )
        var_14 = randomfloatrange( 0, 1 );

    var_15 = -2;
    var_16 = var_14 + 1.0;
    var_17 = 0;
    var_18 = 0;

    while ( var_4 < var_11 )
    {
        wait 0.05;
        var_4 += 0.05;

        if ( !var_18 && var_16 < var_11 && var_4 >= var_16 )
        {
            playfxontag( common_scripts\utility::getfx( "emp_drone_damage" ), var_1, "TAG_ORIGIN" );
            soundscripts\_snd::snd_message( "pdrone_emp_death", var_1 );
            stopfxontag( common_scripts\utility::getfx( "ie_drone_eye_emissive" ), var_1, "TAG_MAIN_CAMERA" );
            var_18 = 1;
        }

        if ( var_4 >= var_14 && var_4 < var_16 )
        {
            if ( !var_17 )
            {
                playfxontag( common_scripts\utility::getfx( "ie_drone_eye_emissive" ), var_1, "TAG_MAIN_CAMERA" );
                var_17 = 1;
            }

            var_15 += 0.5;
            var_13 = clamp( var_13 - 2.5, var_12 * -1.0, var_12 );
        }
        else
        {
            var_15 -= 0.5;
            var_13 = clamp( var_13 + 2.5, var_12 * -1.0, var_12 );
        }

        var_9 += ( 0, abs( var_13 ) * 0.4, 0 ) * var_10;
        var_8 += ( 0, 0, var_15 );
        var_19 = var_8 + anglestoforward( var_9 ) * var_7;
        var_20 = physicstrace( var_1.origin, var_19, var_1 );
        var_1.origin = var_19;
        var_1.angles += ( 0, var_13, 0 ) * var_10;
        var_1.angles = ( var_1.angles[0], var_1.angles[1], cos( var_4 ) * 10 );
        var_21 = length( var_3 - var_1.origin );

        if ( var_21 < 60 || var_1.origin[2] < var_3[2] + 15 || var_20 != var_19 )
            break;
    }

    playfx( common_scripts\utility::getfx( "pdrone_death_explosion" ), var_1.origin );
    soundscripts\_snd::snd_message( "pdrone_crash_land", var_1.origin );
    var_1 pdrone_notify_explosion();
    var_1 delete();
}

destroy_drones_when_nuked()
{
    self endon( "death" );

    for (;;)
    {
        if ( getdvar( "debug_nuke" ) == "on" )
            self _meth_8051( self.health + 99999, ( 0, 0, -500 ), level.player );

        wait 0.05;
    }
}

flying_attack_drone_logic( var_0 )
{
    self notify( "pdrone_flying_attack_drone_logic" );
    self endon( "pdrone_flying_attack_drone_logic" );
    self endon( "death" );
    var_0 = self;
    var_0 childthread flying_attack_drone_damage_monitor();
    var_0 thread flying_attack_drone_death_monitor();
    setdvarifuninitialized( "drone_attack_delay", 1.0 );
    setdvarifuninitialized( "drone_attack_accuracy", 10.0 );
    setdvarifuninitialized( "drone_attack_sight_required", 0 );
    var_0.attack_delay = getdvarfloat( "drone_attack_delay" );
    var_0.attack_accuracy = getdvarfloat( "drone_attack_accuracy" );
    var_0.attack_sight_required = getdvarint( "drone_attack_sight_required" );
    init_class_motion();

    if ( isdefined( var_0.target ) )
        var_0 waittill( "reached_dynamic_path_end" );

    if ( !isdefined( level.player.drone_attack_nodes ) )
        level.player thread player_attack_nodes_update();

    var_0 childthread flying_attack_drone_goal_update();
}

player_attack_nodes_update()
{
    self notify( "player_attack_nodes_update" );
    self endon( "player_attack_nodes_update" );
    self endon( "death" );
    self.drone_attack_nodes = [];

    for (;;)
    {
        var_0 = 0;

        if ( isdefined( level.active_drones ) )
        {
            foreach ( var_2 in level.active_drones )
            {
                if ( isdefined( var_2 ) && var_2.mode == "attack" )
                {
                    var_0 = 1;
                    break;
                }
            }
        }

        if ( !var_0 )
        {
            self.drone_attack_nodes = undefined;
            self notify( "player_attack_nodes_update" );
            return;
        }

        var_4 = [];
        var_5 = level.player.origin;
        var_6 = level.player _meth_8387();

        if ( !isdefined( var_6 ) )
        {
            wait 0.05;
            continue;
        }

        var_7 = pdrone_get_nodes_in_radius( var_5, 800, 300, 512 );
        var_8 = 0;

        foreach ( var_10 in var_7 )
        {
            if ( !_func_1FF( var_6, var_10 ) )
                continue;

            if ( var_8 >= 3 )
            {
                wait 0.05;
                var_8 = 0;
            }

            var_8++;

            if ( !drone_validate_node( var_10 ) )
                continue;

            var_4[var_4.size] = var_10;
        }

        self.drone_attack_nodes = var_4;
        wait 1;
    }
}

drone_waittill_goal()
{
    self.drone_relocating = 1;
    self waittill( "goal" );
    self.drone_relocating = 0;
}

drone_monitor_player_aim()
{
    var_0 = cos( 3 );

    for (;;)
    {
        if ( isalive( level.player ) )
        {
            var_1 = vectornormalize( self gettagorigin( "tag_origin" ) - level.player _meth_80A8() );
            var_2 = anglestoforward( level.player getangles() );

            if ( vectordot( var_1, var_2 ) > var_0 )
                self notify( "aimed_at" );
        }

        wait 0.25;
    }
}

flying_attack_drone_goal_update()
{
    self notify( "flying_attack_drone_goal_update" );
    self endon( "flying_attack_drone_goal_update" );
    self endon( "death" );
    childthread drone_monitor_player_aim();

    for (;;)
    {
        var_0 = common_scripts\utility::waittill_any_timeout( randomfloatrange( 1.0, 2.0 ), "aimed_at" );
        var_1 = self gettagorigin( "tag_origin" );
        var_2 = self gettagangles( "tag_origin" );
        var_3 = var_1;

        if ( common_scripts\utility::cointoss() )
            var_3 += anglestoright( var_2 ) * 200;
        else
            var_3 += anglestoright( var_2 ) * -200;

        if ( isdefined( level.player.drone_attack_nodes ) && level.player.drone_attack_nodes.size > 0 )
        {
            if ( !isdefined( self.claimed_node ) )
            {
                var_4 = sortbydistance( level.player.drone_attack_nodes, var_3 );

                foreach ( var_6 in var_4 )
                {
                    if ( drone_node_claimed_by_other( var_6 ) )
                        continue;

                    drone_claim_node( var_6 );
                    break;
                }

                if ( isdefined( self.claimed_node ) )
                {
                    var_8 = self.claimed_node.origin;
                    var_9 = var_8[2] + 100;
                    init_class_motion( 100, 200, 200 );

                    if ( isdefined( self.prev_attachedpath ) )
                    {
                        self _meth_825C( vectortoyaw( var_8 - var_1 ) );
                        self _meth_825B( ( self.origin[0], self.origin[1], max( var_9 + 500, var_1[2] ) ), 1 );
                        drone_waittill_goal();
                        self _meth_825C( vectortoyaw( var_8 - var_1 ) );
                        self _meth_825B( ( var_8[0], var_8[1], max( var_9 + 500, var_1[2] ) ), 1 );
                        drone_waittill_goal();
                    }

                    self _meth_825C( vectortoyaw( var_8 - var_1 ) );
                    self _meth_825B( ( var_8[0], var_8[1], max( var_9, var_1[2] ) ), 1 );
                    drone_waittill_goal();
                    init_class_motion();
                    self _meth_825B( ( var_8[0], var_8[1], var_9 ), 1 );
                    drone_waittill_goal();
                    self.reached_node = 1;
                }
            }

            var_10 = sortbydistance( level.player.drone_attack_nodes, var_3 );
            var_11 = self.claimed_node;
            var_12 = var_1[2];
            var_13 = 0.0;

            foreach ( var_6 in var_10 )
            {
                if ( isdefined( self.claimed_node ) && var_6 == self.claimed_node )
                    continue;

                if ( drone_node_claimed_by_other( var_6 ) )
                    continue;

                if ( !isdefined( self.claimed_node ) )
                {
                    var_11 = var_6;
                    break;
                }

                wait 0.05;
                var_15 = level.player.origin[2] + 100;
                var_16 = drone_validate_path_to( self.claimed_node, var_1[2], var_6, var_15 );

                if ( var_16 )
                    var_13 += 1.0;
                else
                {
                    wait 0.05;
                    var_16 = drone_validate_path_to( self.claimed_node, var_1[2], var_6, undefined );

                    if ( var_16 )
                    {
                        var_13 += 1.0;
                        var_15 = var_6.origin[2] + 100;
                    }
                }

                if ( var_16 && randomfloat( 1.0 ) <= 1.0 / var_13 )
                {
                    var_11 = var_6;
                    var_12 = var_15;

                    if ( var_13 >= 5 || var_0 == "aimed_at" )
                        break;
                }
            }

            if ( isdefined( var_11 ) && ( !isdefined( self.claimed_node ) || var_11 != self.claimed_node ) )
            {
                while ( self.drone_firing )
                    wait 0.05;

                if ( drone_node_claimed_by_other( var_11 ) )
                    continue;

                drone_claim_node( var_11 );
                init_class_motion();
                self _meth_8294( 80, drone_parm( "rollmax" ) );
                self _meth_825B( ( var_11.origin[0], var_11.origin[1], var_12 ), 1 );
                drone_waittill_goal();
                self.reached_node = 1;
                self _meth_8284( 0.05, 0.05, 0.05 );
            }
        }
    }
}

flying_attack_drone_damage_monitor()
{
    self endon( "death" );
    self.damagetaken = 0;
    self.istakingdamage = 0;

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( !isdefined( var_1 ) || !isplayer( var_1 ) )
            continue;

        self notify( "flying_attack_drone_damaged_by_player" );
        thread flying_attack_drone_damage_update();
    }
}

flying_attack_drone_damage_update()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self.istakingdamage = 1;
    wait 1;
    self.istakingdamage = 0;
}

flying_attack_drone_death_monitor()
{
    if ( !isdefined( level.flying_attack_drones ) )
        level.flying_attack_drones = [];

    level.flying_attack_drones = common_scripts\utility::array_add( level.flying_attack_drones, self );
    common_scripts\utility::waittill_any( "death", "pdrone_flying_attack_drone_logic" );
    level.flying_attack_drones = common_scripts\utility::array_remove( level.flying_attack_drones, self );
    level notify( "flying_attack_drone_destroyed" );
}

drone_investigate_try_location( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) && !isdefined( level.dronespawners ) || level.dronespawners.size == 0 )
        return 0;

    var_3 = pdrone_get_nodes_in_radius( var_0 + ( 0, 0, -512 ), 1000, 0, 1024 );

    if ( var_3.size == 0 )
        return 0;

    var_3 = sortbydistance( var_3, var_0 );
    var_4 = var_0;
    var_0 = var_3[0].origin;
    var_5 = 0;

    if ( !isdefined( var_1 ) )
    {
        foreach ( var_7 in level.drone_investigates )
        {
            if ( distancesquared( var_3[0].origin, var_7 ) < 1000000 )
                var_5 = 1;
        }
    }

    if ( var_5 )
        return 0;

    var_9 = var_2;

    if ( !isdefined( var_9 ) )
    {
        level.dronespawners = sortbydistance( level.dronespawners, var_0 );
        var_10 = anglestoforward( level.player getangles() );
        var_11 = cos( 60 );
        var_9 = level.dronespawners[0];

        foreach ( var_2 in level.dronespawners )
        {
            var_13 = vectornormalize( var_2.origin - level.player.origin );

            if ( vectordot( var_13, var_10 ) > var_11 )
                continue;

            var_9 = var_2;
            break;
        }
    }

    var_15 = drone_spawner_get_height( var_9 );
    var_16 = 0;
    var_17 = 0;

    for ( var_18 = 0; var_18 < var_3.size; var_18++ )
    {
        if ( var_17 >= 100 )
            return 0;

        if ( !_func_1FF( var_3[var_18], var_3[0] ) )
            continue;

        var_16 = drone_validate_node( var_3[var_18] );

        if ( !sighttracepassed( var_4 + ( 0, 0, 50 ), var_3[var_18].origin + ( 0, 0, 100 ), 0, undefined, undefined, 0 ) )
            var_16 = 0;

        if ( var_16 )
            break;
        else
        {

        }

        var_17++;
        wait 0.05;
    }

    if ( var_16 )
    {
        var_19 = var_9;

        if ( level.dronespawnerexits.size > 0 )
        {
            level.dronespawnerexits = sortbydistance( level.dronespawnerexits, var_0 );
            var_19 = level.dronespawnerexits[0];
        }

        level thread drone_investigate( var_9, var_19, var_3[var_18], var_15, var_4, var_1 );
    }

    return var_16;
}

drone_spawner_get_height( var_0 )
{
    if ( isdefined( var_0.script_parameters ) )
    {
        var_1 = int( var_0.script_parameters );

        if ( var_1 != 0 )
            return var_1;
    }

    return max( var_0.origin[2], 1500 );
}

drone_validate_node( var_0 )
{
    var_1 = var_0.origin;
    var_2 = var_1 + ( 0, 0, 10 );
    var_3 = ( var_1[0], var_1[1], var_0.origin[2] + 10000 );
    var_4 = playerphysicstrace( var_2, var_3, level.player );
    var_5 = distancesquared( var_4, var_3 ) < 0.01;
    return var_5;
}

drone_validate_path_to( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isdefined( var_2 ) )
        return 0;

    if ( !isdefined( var_1 ) )
        var_1 = var_0.origin[2] + 100;

    if ( !isdefined( var_3 ) )
        var_3 = var_2.origin[2] + 100;

    if ( var_3 < var_2.origin[2] + 50 )
        return 0;

    var_4 = ( var_0.origin[0], var_0.origin[1], var_1 );
    var_5 = ( var_0.origin[0], var_0.origin[1], var_3 );
    var_6 = playerphysicstrace( var_4, var_5, self );

    if ( distancesquared( var_5, var_6 ) < 0.01 )
    {
        var_4 = ( var_0.origin[0], var_0.origin[1], var_3 );
        var_5 = ( var_2.origin[0], var_2.origin[1], var_3 );
        var_6 = playerphysicstrace( var_4, var_5, self );
        return distancesquared( var_5, var_6 ) < 0.01;
    }

    return 0;
}

drone_investigate( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = drone_spawn( var_0, "patrol" );
    var_6 childthread drone_investigate_thread( var_1, var_2, var_3, var_4, var_5 );
}

drone_investigate_thread( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = self;
    var_6 = var_1.origin;
    level.drone_investigates[level.drone_investigates.size] = var_6;
    var_5 endon( "death" );
    var_5 notify( "drone_investigate" );
    var_5 endon( "drone_investigate" );
    var_5 drone_abort_path();
    level notify( "drone_investigate_start", var_5 );
    level.aud_drone_investigating = 1;
    var_7 = var_5.origin;
    var_8 = ( 0, 0, 100 );
    var_9 = var_6 + var_8;
    var_5 thread drone_investigate_cleanup( var_6 );
    var_5 thread drone_investigate_scan();
    var_5 childthread drone_investigate_find_spots( var_1, var_7, var_2, var_3 );
    var_5 init_class_motion();
    var_5 _meth_825C( vectortoyaw( var_6 - var_7 ) );
    var_5 _meth_825B( ( var_7[0], var_7[1], var_2 ), 1 );
    var_5 drone_waittill_goal();
    var_5 init_class_motion( 100, 200, 200 );
    var_5 _meth_825C( vectortoyaw( var_6 - var_7 ) );
    var_5 _meth_825B( ( var_9[0], var_9[1], var_2 ), 1 );
    var_5 drone_waittill_goal();
    var_5 init_class_motion();

    if ( isdefined( var_4 ) )
        var_5 thread drone_investigate_spot( var_1, var_4[2], var_4, 1 );
    else
        var_5 thread drone_investigate_spot( var_1, var_3[2] + 100 );

    var_5 waittill( "drone_investigate_spot_finished" );

    for ( var_10 = 0; var_10 < min( var_5.investigatenodes.size, 2 ); var_10++ )
    {
        if ( isdefined( var_4 ) )
            var_5 thread drone_investigate_spot( var_5.investigatenodes[var_10], var_4[2], var_4, 1 );
        else
            var_5 thread drone_investigate_spot( var_5.investigatenodes[var_10] );

        var_5 waittill( "drone_investigate_spot_finished" );
    }

    var_5 drone_return_home( var_0, self.prev_attachedpath );
}

drone_return_home( var_0, var_1 )
{
    var_2 = self;
    var_2 notify( "drone_return_home" );
    var_2 endon( "drone_return_home" );
    var_2 endon( "death" );
    var_2 drone_set_mode( "patrol", 0 );

    if ( !isdefined( var_0 ) )
    {
        if ( level.dronespawnerexits.size > 0 )
        {
            level.dronespawnerexits = sortbydistance( level.dronespawnerexits, var_2.origin );
            var_0 = level.dronespawnerexits[0];
        }
    }

    if ( !isdefined( var_0 ) && !isdefined( var_1 ) )
        return;

    var_3 = var_0.origin;

    if ( isdefined( var_1 ) )
        var_3 = var_1.origin;

    var_2 notify( "drone_investigate_cleanup" );
    var_4 = drone_spawner_get_height( var_0 );
    var_2 _meth_825C( vectortoyaw( var_0.origin - var_2.origin ) );
    var_2 _meth_825B( ( var_2.origin[0], var_2.origin[1], var_4 ), 1 );
    var_2 drone_waittill_goal();
    level.aud_drone_investigating = 0;
    var_2 init_class_motion( 100, 200, 200 );
    var_2 _meth_825C( vectortoyaw( var_3 - var_2.origin ) );
    var_2 _meth_825B( ( var_3[0], var_3[1], var_4 ), 1 );
    var_2 drone_waittill_goal();

    if ( isdefined( var_1 ) )
        var_2 thread maps\_vehicle_code::vehicle_paths_helicopter( var_1 );
    else
    {
        if ( isdefined( self.tagged ) )
            var_2 maps\_tagging::tag_outline_enemy( 0 );

        var_2 _meth_825B( var_0.origin, 1 );
        var_2 drone_waittill_goal();
        var_2 delete();
    }
}

drone_investigate_find_spots( var_0, var_1, var_2, var_3 )
{
    var_4 = 400;
    var_5 = 40000;
    var_6 = pdrone_get_nodes_in_radius( var_0.origin, var_4, 0, 512 );
    var_7 = [];

    foreach ( var_9 in var_6 )
    {
        if ( drone_node_claimed_by_other( var_9 ) )
            continue;

        if ( !_func_1FF( var_9, var_0 ) )
            continue;

        if ( distancesquared( var_9.origin, var_0.origin ) < var_5 )
            continue;

        var_10 = 0;

        foreach ( var_12 in var_7 )
        {
            if ( distancesquared( var_9.origin, var_12.origin ) < var_5 )
            {
                var_10 = 1;
                break;
            }
        }

        if ( var_10 )
            continue;

        wait 0.05;

        if ( drone_validate_node( var_9 ) )
            var_7[var_7.size] = var_9;
    }

    var_15 = common_scripts\utility::array_randomize( var_7 );
    var_16 = [];

    foreach ( var_9 in var_15 )
    {
        if ( var_16.size == 0 && drone_validate_path_to( var_0, var_3[2] + 100, var_9, undefined ) )
            var_16[var_16.size] = var_9;
        else if ( var_16.size > 0 && drone_validate_path_to( var_16[var_16.size - 1], undefined, var_9, undefined ) )
            var_16[var_16.size] = var_9;

        wait 0.05;
    }

    self.investigatenodes = var_16;
}

drone_node_claimed_by_other( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isdefined( var_0.claimed_drone ) )
        return 0;

    if ( var_0.claimed_drone == self )
        return 0;

    return 1;
}

drone_claim_node( var_0 )
{
    if ( isdefined( self.claimed_node ) )
    {
        self.claimed_node.claimed_drone = undefined;
        self.claimed_node = undefined;
    }

    if ( isdefined( var_0 ) )
    {
        if ( isdefined( var_0.claimed_drone ) && var_0.claimed_drone != self )
        {
            var_0.claimed_drone notify( "node_kicked" );
            var_0.claimed_drone drone_claim_node( undefined );
        }

        self.claimed_node = var_0;
        var_0.claimed_drone = self;
    }
}

drone_investigate_spot( var_0, var_1, var_2, var_3 )
{
    self notify( "drone_investigate_spot" );
    self endon( "drone_investigate_spot" );
    self endon( "drone_investigate" );
    self endon( "death" );
    drone_claim_node( var_0 );

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = var_0.origin[2] + 100;

    var_4 = ( var_0.origin[0], var_0.origin[1], var_1 );
    self.visiting_player_from_node = undefined;
    init_class_motion();
    self _meth_825D();

    if ( isdefined( var_2 ) )
    {
        drone_security_bays_open( 1 );
        self _meth_825E( vectortoyaw( var_2 - self.origin ) );
    }
    else
    {
        drone_security_bays_open( 0 );
        self _meth_825E( vectortoyaw( var_4 - self.origin ) );
    }

    self _meth_825B( var_4, 1 );

    for ( var_5 = "timeout"; var_5 == "timeout"; var_5 = common_scripts\utility::waittill_any_timeout( 0.05, "goal" ) )
    {
        if ( isdefined( var_2 ) )
            self _meth_825E( vectortoyaw( var_2 - self.origin ) );
    }

    self.reached_node = 1;
    self _meth_8284( 0.05, 0.05, 0.05 );
    var_6 = self.angles[1];
    var_7 = 1;

    while ( var_7 )
    {
        var_7 = 0;

        for ( var_8 = 0; var_8 < 4; var_8++ )
        {
            var_9 = 2.0;
            self.scantime = 0;
            var_10 = 0;

            while ( var_9 > 0 )
            {
                var_11 = var_6 + var_8 * 90;

                if ( isdefined( var_2 ) )
                    var_11 = vectortoyaw( var_2 - self.origin );

                var_12 = drone_investigate_yaw( var_11 );

                if ( var_12 > 0 )
                {
                    var_10 += 0.05;
                    var_9 = 2.0;
                }

                if ( var_10 > 0.5 )
                {
                    var_7 = 1;

                    if ( var_12 > 250 )
                        childthread drone_investigate_visit_player_from( var_0 );
                }

                var_9 -= 0.05;
                self.scantime += 0.05;
                wait 0.05;
            }

            if ( !var_3 )
                var_2 = undefined;
        }
    }

    init_class_motion();
    self.scantime = 0;

    if ( isdefined( self.investigate_spot_return_to ) && self.investigate_spot_return_to.size > 0 )
    {
        var_13 = self.investigate_spot_return_to[self.investigate_spot_return_to.size - 1];
        self.investigate_spot_return_to[self.investigate_spot_return_to.size - 1] = undefined;
        thread drone_investigate_spot( var_13 );
        return;
    }

    self _meth_825F();
    self notify( "drone_investigate_spot_finished" );
}

drone_investigate_visit_player_from( var_0 )
{
    if ( isdefined( self.visiting_player_from_node ) )
        return;

    self.visiting_player_from_node = var_0;
    var_1 = pdrone_get_nodes_in_radius( level.player.origin - ( 0, 0, 256 ), 512, 128, 512 );
    var_1 = sortbydistance( var_1, level.player.origin );

    foreach ( var_3 in var_1 )
    {
        if ( distancesquared( var_3.origin, var_0.origin ) < 22500 )
        {
            self.visiting_player_from_node = undefined;
            return;
        }

        wait 0.05;

        if ( drone_validate_path_to( var_0, undefined, var_3, level.player.origin[2] + 100 ) )
        {
            wait 0.05;

            if ( drone_validate_path_to( var_3, level.player.origin[2], var_0, undefined ) )
            {
                if ( !isdefined( self.investigate_spot_return_to ) )
                    self.investigate_spot_return_to = [];

                self.investigate_spot_return_to[self.investigate_spot_return_to.size] = var_0;
                thread drone_investigate_spot( var_3, level.player.origin[2] + 100, level.player.origin );
                return;
            }
        }
    }

    self.visiting_player_from_node = undefined;
}

drone_investigate_scan()
{
    self endon( "death" );
    self endon( "drone_investigate" );
    self.scanning = 0;
    self.scantime = 0;
    self.scantag childthread drone_investigate_scan_tag_think( self );

    for (;;)
    {
        if ( self.scantag.seeing )
        {
            wait 0.05;
            continue;
        }

        if ( ( self.scantime <= 0.3 || self.mode == "attack" ) && self.scanning )
        {
            level notify( "aud_stop_drone_scanning" );
            stopfxontag( level._effect["drone_scan"], self.scantag, "tag_origin" );
            self.scanning = 0;
            self.scantag.active = 0;
        }
        else if ( self.scantime > 0.3 && !self.scanning )
        {
            self.scantag _meth_804D( self, "tag_top_camera", ( 0, 0, 0 ), ( 0, -45, 0 ) );
            wait 0.05;
            self.scantag _meth_842A( ( 0, 90, 0 ), 1.7, 0, 0 );
            self.scantag.active = 1;
            self.scantagaudio soundscripts\_snd_playsound::snd_play_loop_linked( "sdrn_scan_lp", "aud_stop_drone_scanning", 0.1, 0.1 );
            playfxontag( level._effect["drone_scan"], self.scantag, "tag_origin" );
            self.scanning = 1;
        }

        wait 0.05;
    }
}

drone_investigate_scan_tag_think( var_0 )
{
    self.seeing = 0;

    for (;;)
    {
        self waittill( "sight" );
        self _meth_804D( var_0, "tag_top_camera", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self.seeing = 1;
        wait 3;
        self.seeing = 0;
    }
}

drone_security_scan_tag_cleanup( var_0 )
{
    self notify( "drone_security_scan_tag_cleanup" );
    self endon( "drone_security_scan_tag_cleanup" );
    var_0 waittill( "death" );

    if ( isdefined( self ) )
        self delete();
}

drone_security_scan_tag_audio( var_0, var_1 )
{
    self notify( "drone_security_scan_tag_audio" );
    self endon( "drone_security_scan_tag_audio" );
    var_0 endon( "death" );
    self endon( "death" );
    var_2 = 0;

    while ( isdefined( self ) && isdefined( var_0 ) && isdefined( var_0.scantag ) )
    {
        var_3 = var_1;
        var_4 = distancesquared( level.player.origin, var_0.scantag.origin );

        if ( var_4 < var_1 * var_1 )
            var_3 = sqrt( var_4 );

        if ( var_2 != var_3 )
        {
            self _meth_804F();
            var_2 = var_3;
            self.origin = var_0.scantag.origin;
            self.origin += anglestoforward( var_0.scantag.angles ) * var_2;
            self _meth_804D( var_0.scantag );
        }

        wait 0.05;
    }
}

drone_investigate_yaw( var_0 )
{
    if ( isdefined( self.last_saw_player ) && gettime() - self.last_saw_player_time < 1000 )
    {
        self _meth_825E( vectortoyaw( self.last_saw_player - self.origin ) );
        return gettime() - self.last_saw_player_time;
    }

    self _meth_825E( var_0 );
    return -1;
}

drone_investigate_cleanup( var_0 )
{
    self.investigating = 1;
    common_scripts\utility::flag_set( "drones_investigating" );
    common_scripts\utility::waittill_any( "death", "drone_investigate", "drone_investigate_cleanup" );
    level.drone_investigates = common_scripts\utility::array_remove( level.drone_investigates, var_0 );

    if ( isdefined( self ) )
    {
        self.investigating = undefined;
        level notify( "drone_investigate_finished", self );
    }

    wait 0.1;

    if ( level.drone_investigates.size == 0 )
        common_scripts\utility::flag_clear( "drones_investigating" );
}

drone_spawn( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "patrol";

    if ( !isdefined( var_0 ) )
        return undefined;

    var_2 = drone_spawn_single_struct( var_0 );

    if ( !isdefined( var_2 ) )
        return undefined;

    var_2 thread drone_active_thread();
    var_2 drone_set_mode( var_1 );
    return var_2;
}

drone_spawn_and_drive( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "patrol";

    if ( !isdefined( var_0 ) )
        return [];

    var_2 = common_scripts\utility::getstructarray( var_0, "targetname" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        var_6 = drone_spawn_single_struct( var_5 );
        var_6 thread drone_active_thread();
        var_6 drone_set_mode( var_1 );
        var_3[var_3.size] = var_6;
    }

    return var_3;
}

drone_spawn_single_struct( var_0 )
{
    if ( !isdefined( level.dronespawnertemplate ) )
        return undefined;

    while ( isdefined( level.dronespawnertemplate.vehicle_spawned_thisframe ) )
        wait 0.05;

    level.dronespawnertemplate.origin = var_0.origin;
    level.dronespawnertemplate.angles = var_0.angles;
    level.dronespawnertemplate.target = var_0.target;
    level.dronespawnertemplate.script_noteworthy = var_0.script_noteworthy;
    var_1 = level.dronespawnertemplate maps\_vehicle::spawn_vehicle_and_gopath();
    return var_1;
}

drone_active_thread()
{
    if ( !isdefined( level.last_drone_attacking_sound ) )
        level.last_drone_attacking_sound = 0;

    if ( !isdefined( level.last_drone_investigating_sound ) )
        level.last_drone_investigating_sound = 0;

    if ( !isdefined( level.last_drone_passive_sound ) )
        level.last_drone_passive_sound = 0;

    if ( !isdefined( level.last_drone_lens_sound ) )
        level.last_drone_lens_sound = 0;

    if ( !isdefined( level.active_drones ) )
        level.active_drones = [];

    level.active_drones = common_scripts\utility::array_add( level.active_drones, self );
    level.player thread drone_closest();
    childthread drone_random_vocalizations();
    childthread drone_spin_monitor();
    self waittill( "death" );
    level.active_drones = common_scripts\utility::array_remove( level.active_drones, self );
}

drone_closest()
{
    self notify( "drone_closest" );
    self endon( "drone_closest" );

    while ( isdefined( level.active_drones ) && isdefined( self ) )
    {
        var_0 = sortbydistance( level.active_drones, self.origin );

        if ( var_0.size > 0 )
            self.closest_drone = var_0[0];
        else
            self.closest_drone = undefined;

        wait 0.5;
    }
}

drone_spin_monitor()
{
    self endon( "death" );
    var_0 = 0;
    var_1 = angleclamp180( self gettagangles( "tag_origin" )[1] );

    while ( isdefined( self ) )
    {
        var_2 = angleclamp180( self gettagangles( "tag_origin" )[1] );

        if ( abs( var_2 - var_1 ) > 1.0 )
        {
            if ( !var_0 )
                soundscripts\_snd_playsound::snd_play_linked( "sdrone_pivot" );

            var_0 = 1;
        }
        else
            var_0 = 0;

        var_1 = var_2;
        wait 0.05;
    }
}

drone_random_vocalizations()
{
    self endon( "death" );

    while ( isdefined( self ) )
    {
        if ( !common_scripts\utility::flag( "_stealth_spotted" ) && common_scripts\utility::flag( "drones_investigating" ) )
        {
            if ( gettime() - level.last_drone_investigating_sound > 3000 )
            {
                var_0 = level.player.closest_drone;

                if ( isdefined( var_0 ) )
                {
                    level.last_drone_investigating_sound = gettime();

                    if ( randomint( 5 ) > 1 )
                        var_0 soundscripts\_snd_playsound::snd_play_linked( "sdrone_voc_suspicious" );
                    else
                        var_0 soundscripts\_snd_playsound::snd_play_linked( "sdrone_voc_aggressive" );
                }
            }

            if ( randomint( 5 ) > 3 && gettime() - level.last_drone_lens_sound > 3000 )
            {
                var_0 = level.player.closest_drone;

                if ( isdefined( var_0 ) )
                {
                    level.last_drone_lens_sound = gettime();
                    var_0 soundscripts\_snd_playsound::snd_play_linked( "sdrone_lens_movement" );
                }
            }

            wait(randomfloatrange( 0.2, 6 ));
        }
        else
        {
            if ( gettime() - level.last_drone_passive_sound > 5000 )
            {
                var_0 = level.player.closest_drone;

                if ( isdefined( var_0 ) )
                {
                    level.last_drone_passive_sound = gettime();
                    var_0 soundscripts\_snd_playsound::snd_play_linked( "sdrone_voc_curious" );
                }
            }

            wait(randomfloatrange( 5, 10 ));
        }

        wait 0.05;
    }
}

drone_alert_sight( var_0, var_1, var_2, var_3, var_4 )
{
    self notify( "drone_alert_sight" );
    self endon( "death" );
    self endon( "drone_alert_sight" );
    self.threatsightdelayenabled = 1;
    self.threatsightdelayfalloff = 1;
    self.threatsightdelay = 0;
    self.corpse_array_time = 0;

    if ( !isdefined( self.fovcosinez ) || self.fovcosinez == 0 )
        self.fovcosinez = cos( 10 );

    if ( !isdefined( self.fovcosine ) || self.fovcosine == 0 )
        self.fovcosine = cos( 45 );

    if ( !isdefined( var_3 ) )
        var_3 = 1.0;

    if ( !isdefined( var_4 ) )
        var_4 = 1.0;

    var_5 = 0.05;

    for (;;)
    {
        if ( !isdefined( level._stealth ) || !common_scripts\utility::flag_exist( "_stealth_enabled" ) || !common_scripts\utility::flag( "_stealth_enabled" ) )
        {
            wait 0.05;
            continue;
        }

        var_6 = getdvarfloat( "ai_threatSightDelayDistMin" );
        var_7 = getdvarfloat( "ai_threatSightDelayDistMax" );
        var_8 = getdvarfloat( "ai_threatSightDelayRateMin" );
        var_9 = getdvarfloat( "ai_threatSightDelayRateMax" );
        var_10 = level.player.maxvisibledist;

        if ( isai( self ) )
        {
            var_11 = self _meth_80A8();
            var_12 = anglestoforward( self.angles );
        }
        else
        {
            var_11 = self gettagorigin( "tag_origin" );
            var_12 = anglestoforward( self gettagangles( "tag_origin" ) );
        }

        var_13 = var_10;

        if ( isdefined( level._stealth ) && isdefined( level._stealth.logic ) && isdefined( level._stealth.logic.detect_range ) )
        {
            var_14 = level._stealth.logic.detect_range["hidden"][level.player _meth_817C()];

            if ( isdefined( var_14 ) )
                var_13 = min( var_14, var_13 );
        }

        var_15 = drone_alert_sight_check( level.player, var_11, var_1, var_2, var_13 * var_3 );
        self.canseeplayer = var_15 != 0;

        if ( self.canseeplayer )
        {
            if ( var_15 <= var_6 * var_6 )
                self.threatsightdelay += var_5;
            else
            {
                var_16 = sqrt( var_15 );

                if ( var_4 != 1.0 )
                {
                    var_17 = var_16 / var_4;
                    var_18 = vectornormalize( level.player.origin - var_11 );
                    var_19 = vectordot( var_18, var_12 );
                    var_20 = ( var_19 - self.fovcosine ) / ( 1.0 - self.fovcosine );
                    var_16 += ( var_17 - var_16 ) * var_20;
                }

                var_21 = clamp( ( var_16 - var_6 ) / ( var_7 - var_6 ), 0.0, 1.0 );
                var_22 = var_8 + ( var_9 - var_8 ) * var_21;
                self.threatsightdelay += var_5 * var_22;
            }

            self.last_saw_player = level.player.origin;
            self.last_saw_player_time = gettime();
            level.player.stealth_can_be_seen = 1;
        }
        else
        {
            var_23 = getdvarfloat( "ai_threatSightDelayFalloff" );
            self.threatsightdelay -= var_5 * var_23;
        }

        if ( !self.canseeplayer )
        {
            if ( gettime() > self.corpse_array_time )
            {
                self.corpse_array = sortbydistance( _func_0D9(), self.origin, 1000, 1 );
                self.corpse_array_time = gettime() + randomintrange( 500, 1000 );
            }

            if ( isdefined( self.corpse_array ) )
            {
                foreach ( var_25 in self.corpse_array )
                {
                    if ( !isdefined( var_25 ) )
                        continue;

                    if ( isdefined( var_25.corpse_seen_by ) && isdefined( var_25.corpse_seen_by[self _meth_81B1()] ) )
                        continue;

                    if ( drone_alert_sight_check( var_25, var_11, var_1, var_2, 1000 ) != 0 )
                    {
                        var_25.corpse_seen_by[self _meth_81B1()] = 1;
                        self notify( "see_corpse", var_25 );
                        wait 0.05;
                    }
                }
            }
        }

        self.threatsightdelay = clamp( self.threatsightdelay, 0.0, 1.0 );

        if ( self.threatsightdelay >= 1.0 )
        {
            self notify( var_0 );
            return;
        }

        wait(var_5);
    }
}

drone_alert_sight_check( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0.ignoreme ) && var_0.ignoreme )
        return 0;

    var_5 = var_0.origin + ( 0, 0, 20 );

    if ( isplayer( var_0 ) )
        var_5 = var_0 _meth_80A8();

    var_6 = var_5 - var_1;
    var_7 = lengthsquared( var_6 );
    var_8 = 0;
    var_9 = 4900;

    if ( var_7 < var_9 )
        var_8 = var_7;
    else
    {
        if ( drone_alert_sight_can_see( var_5, var_4, 1, isplayer( var_0 ) ) )
            var_8 = var_7;

        if ( var_8 == 0 && isplayer( var_0 ) && isdefined( var_2 ) && var_2.active )
        {
            if ( var_2 drone_alert_sight_can_see( var_5, var_3, 0, isplayer( var_0 ) ) )
                var_8 = var_7;

            if ( var_8 != 0 )
                var_2 notify( "sight", var_5 );
        }
    }

    return var_8;
}

drone_alert_sight_can_see( var_0, var_1, var_2, var_3 )
{
    var_4 = self gettagorigin( "tag_origin" );

    if ( isai( self ) )
        var_4 = self _meth_80A8();

    var_5 = var_0 - var_4;
    var_6 = lengthsquared( var_5 );
    var_7 = var_1 * var_1;
    var_8 = var_6 <= var_7;
    var_9 = getdvarfloat( "ai_threatSightDelayDistMin" );

    if ( var_8 )
    {
        if ( isai( self ) && var_3 && !isdefined( self.sight_ignore ) )
            var_8 = self _meth_81BE( level.player );
        else
        {
            var_10 = anglestoforward( self gettagangles( "tag_origin" ) );
            var_5 = var_0 - var_4;
            var_11 = vectornormalize( var_5 );
            var_12 = vectordot( var_10, var_11 );
            var_8 = var_12 >= self.fovcosine;

            if ( var_8 )
            {
                if ( self.fovcosinez > self.fovcosine && ( isdefined( self.sight_ignore ) || lengthsquared( var_5 ) > var_9 * var_9 ) )
                {
                    var_13 = ( var_10[0], var_10[1], 0 ) * length( ( var_5[0], var_5[1], 0 ) );
                    var_14 = var_4 + ( var_13[0], var_13[1], var_5[2] );
                    var_15 = vectornormalize( var_14 - var_4 );
                    var_16 = vectordot( var_15, var_10 );
                    var_8 = var_16 >= self.fovcosinez;
                }

                if ( var_8 )
                    var_8 = sighttracepassed( var_4, var_0, 0, self.sight_ignore, self, var_2 );
            }
        }
    }

    return var_8;
}

#using_animtree("vehicles");

drone_set_mode( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = self;
    var_3 = 0;

    if ( isdefined( var_2.mode ) && var_2.mode == var_0 )
        return;

    if ( !isdefined( var_2.mode ) )
    {
        var_3 = 1;
        var_2.reached_node = 0;
        var_2 _meth_8115( #animtree );

        if ( var_0 == "attack" )
        {
            var_2 _meth_814B( %ie_drone_deploy, 1, 0, 1 );
            var_2 _meth_8117( %ie_drone_deploy, 1.0 );
            var_2.bays_open = 1;
        }
        else
        {
            var_2 _meth_814B( %ie_drone_retract, 1, 0, 1 );
            var_2 _meth_8117( %ie_drone_retract, 1.0 );
            var_2.bays_open = 0;
        }
    }

    self notify( "drone_set_mode" );
    self endon( "drone_set_mode" );
    var_4 = var_2.mode;
    var_2.mode = var_0;

    if ( !isdefined( var_2.scantag ) )
    {
        var_2.scantag = common_scripts\utility::spawn_tag_origin();
        var_2.scantag thread drone_security_scan_tag_cleanup( var_2 );
        var_2.scantag.fovcosinez = 0;
        var_2.scantag.fovcosine = cos( 30 );
        var_2.scantag.active = 0;
        var_2.scantag.sight_ignore = var_2;
        var_2.scantagaudio = common_scripts\utility::spawn_tag_origin();
        var_2.scantagaudio thread drone_security_scan_tag_cleanup( var_2 );
        var_2.scantagaudio thread drone_security_scan_tag_audio( var_2, 300 );
    }

    if ( isdefined( level.stealth_spotted_drones ) )
        level.stealth_spotted_drones = common_scripts\utility::array_remove( level.stealth_spotted_drones, self );

    wait 0.1;

    switch ( var_0 )
    {
        case "patrol":
            var_2.fovcosinez = cos( 15 );
            var_2.fovcosine = cos( 55 );
            var_2 notify( "stealth_spotted_drone_death_monitor" );
            var_2 _meth_8266();
            var_2 _meth_825D();
            var_2 notify( "pdrone_targeting" );
            var_2 notify( "pdrone_flying_attack_drone_logic" );

            if ( var_1 )
            {
                var_2 thread drone_alert_sight( "attack", var_2.scantag, 300, 1.0, 2.0 );
                var_2 thread drone_wait_for_attack();
                var_2 thread drone_corpse_monitor();
            }

            if ( isdefined( var_4 ) )
                var_2 thread drone_security_prepare_patrol( var_3 );

            break;
        case "attack":
            var_2.fovcosinez = cos( 60 );
            var_2.fovcosine = cos( 60 );
            var_2 notify( "drone_investigate" );
            var_2 notify( "drone_corpse_monitor" );
            var_2 notify( "drone_alert_sight" );
            var_2 notify( "drone_wait_for_attack" );
            var_2 thread drone_security_prepare_attack( var_3 );
            break;
    }
}

drone_corpse_monitor()
{
    self notify( "drone_corpse_monitor" );
    self endon( "drone_corpse_monitor" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "see_corpse", var_0 );
        var_1 = pdrone_get_nodes_in_radius( var_0.origin, 500, 0, 500 );
        var_1 = sortbydistance( var_1, var_0.origin, 500, 1 );

        if ( isdefined( var_1 ) && var_1.size > 0 )
            drone_investigate_thread( undefined, var_1[0], var_1[0].origin[2] + 500, var_0.origin );
    }
}

drone_security_bays_open( var_0 )
{
    if ( !isdefined( self.bays_open ) )
        self.bays_open = 0;

    if ( self.bays_open != var_0 )
    {
        self.bays_open = var_0;

        if ( var_0 )
        {
            soundscripts\_snd_playsound::snd_play_linked( "sdrone_wpn_bays_open" );
            playfxontag( level._effect["ie_drone_gun_lights"], self, "tag_origin" );
            self _meth_814D( %ie_drone_deploy, 1, 0, 1 );
            self _meth_814B( %ie_drone_retract, 0, 0, 1 );
            wait(getanimlength( %ie_drone_deploy ));
        }
        else
        {
            soundscripts\_snd_playsound::snd_play_linked( "sdrone_wpn_bays_close" );
            stopfxontag( level._effect["ie_drone_gun_lights"], self, "tag_origin" );
            self _meth_814D( %ie_drone_retract, 1, 0, 1 );
            self _meth_814B( %ie_drone_deploy, 0, 0, 1 );
            wait(getanimlength( %ie_drone_retract ));
        }
    }
}

drone_security_prepare_patrol( var_0 )
{
    self notify( "drone_security_prepare_attack" );
    self notify( "drone_security_prepare_patrol" );
    self endon( "drone_security_prepare_attack" );
    self endon( "drone_security_prepare_patrol" );
    self _meth_8284( 0.05, 0.05, 0.05 );

    if ( gettime() - level.last_drone_passive_sound > 2000 )
    {
        var_1 = level.player.closest_drone;

        if ( isdefined( var_1 ) )
        {
            level.last_drone_passive_sound = gettime();
            var_1 soundscripts\_snd_playsound::snd_play_linked( "sdrone_voc_curious" );
        }

        if ( !var_0 )
            wait 0.75;
    }

    if ( !var_0 )
    {
        drone_security_bays_open( 0 );
        wait 0.5;
    }

    init_class_motion();
}

drone_abort_path()
{
    if ( isdefined( self.attachedpath ) )
    {
        self.prev_attachedpath = self.attachedpath;
        var_0 = self gettagorigin( "tag_origin" );
        self.reached_node = 1;
        self notify( "newpath" );
        self _meth_8260( var_0, 0, 0, 0, 1, 0, self gettagangles( "tag_origin" )[1], 0, 0, 1, 0, 0, 1, 1 );
    }
}

drone_security_prepare_attack( var_0 )
{
    self notify( "drone_security_prepare_attack" );
    self notify( "drone_security_prepare_patrol" );
    self endon( "drone_security_prepare_attack" );
    self endon( "drone_security_prepare_patrol" );
    self endon( "death" );
    thread drone_security_prepare_attack_relay( randomfloatrange( 0.3, 0.6 ) );
    drone_abort_path();
    self _meth_8284( 0.05, 0.05, 0.05 );
    self _meth_8265( level.player );

    if ( gettime() - level.last_drone_attacking_sound > 6000 )
    {
        var_1 = level.player.closest_drone;

        if ( isdefined( var_1 ) )
        {
            level.last_drone_attacking_sound = gettime();
            var_1 soundscripts\_snd_playsound::snd_play_linked( "sdrone_alert" );
        }

        if ( !var_0 )
            wait 0.75;
    }

    if ( !var_0 )
    {
        drone_security_bays_open( 1 );
        wait 0.5;
    }

    thread flying_attack_drone_logic();
    thread pdrone_targeting( 1.0 );
    self notify( "reached_dynamic_path_end" );
    wait 0.05;
    self _meth_8265( level.player );
    self _meth_8294( 80, drone_parm( "rollmax" ) );
}

drone_mode_population( var_0 )
{
    if ( !isdefined( level.active_drones ) )
        return 0;

    var_1 = 0;

    foreach ( var_3 in level.active_drones )
    {
        if ( isdefined( var_3 ) && var_3.mode == var_0 )
            var_1++;
    }

    return var_1;
}

drone_security_prepare_attack_relay( var_0 )
{
    self notify( "drone_security_prepare_attack_relay" );
    self endon( "drone_security_prepare_attack_relay" );
    self endon( "drone_security_prepare_attack" );
    self endon( "drone_security_prepare_patrol" );
    self endon( "drone_set_mode" );
    self endon( "death" );
    wait(var_0);

    while ( isdefined( self ) && drone_mode_population( "attack" ) >= 4 )
        wait 1;

    if ( !isdefined( self ) )
        return;

    var_1 = sortbydistance( level.active_drones, self.origin );

    foreach ( var_3 in var_1 )
    {
        if ( var_3 != self && distancesquared( var_3.origin, self.origin ) < 1000000 && ( !isdefined( var_3.mode ) || var_3.mode != "attack" ) )
        {
            var_3 drone_set_mode( "attack" );
            break;
        }
    }
}

drone_wait_for_attack()
{
    self notify( "drone_wait_for_attack" );
    self endon( "death" );
    self endon( "drone_wait_for_attack" );
    var_0 = common_scripts\utility::waittill_any_return( "attack", "damage" );

    if ( !common_scripts\utility::flag( "_stealth_spotted" ) )
        level.player soundscripts\_snd_playsound::snd_play_2d( "irons_spotted_alert" );

    common_scripts\utility::flag_set( "_stealth_spotted" );

    if ( isdefined( self ) )
        thread drone_set_mode( "attack" );
}
