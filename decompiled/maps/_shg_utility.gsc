// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

move_player_to_start( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = level.start_point + "_playerstart";

    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );

    if ( isdefined( var_1 ) )
        maps\_utility::teleport_player( var_1 );
}

spawn_friendlies( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_4 = getentarray( var_1, "script_noteworthy" );
    var_5 = [];
    var_6 = 0;
    var_7 = [];

    foreach ( var_9 in var_4 )
    {
        if ( isspawner( var_9 ) )
            var_5[var_5.size] = var_9;
    }

    var_11 = common_scripts\utility::getstruct( var_0, "targetname" );
    var_12 = 0;

    foreach ( var_14 in var_5 )
    {
        var_15 = var_14 maps\_utility::spawn_ai( 1 );

        if ( var_2 )
            var_15 thread maps\_utility::replace_on_death();

        var_15 _meth_81C6( var_11.origin, var_11.angles );
        var_15 _meth_81A6( var_15.origin );
        var_7 = common_scripts\utility::array_add( var_7, var_15 );
        var_12++;

        if ( isdefined( var_3 ) && var_12 >= var_3 )
            return var_7;
    }

    return var_7;
}

setup_player_for_scene( var_0, var_1 )
{
    self _meth_8130( 0 );
    self _meth_831D();
    self _meth_831F();
    self _meth_8118( 1 );
    self _meth_8119( 0 );
    self _meth_811A( 0 );
    self _meth_8304( 0 );
    _func_0D3( "ammoCounterHide", 1 );

    if ( isdefined( var_0 ) && var_0 )
    {
        var_2 = 0;

        if ( isdefined( level.player.exclusive ) )
        {
            var_2 = maps\_player_exo::player_exo_is_active_single( "boost_dash" );

            if ( var_2 )
                maps\_player_exo::player_exo_remove_single( "boost_dash" );
        }

        for ( var_3 = 0; self _meth_817C() != "stand"; var_3 += 0.05 )
        {
            self _meth_817D( "stand" );
            waitframe();
        }

        while ( self _meth_812C() || self _meth_8337() || self _meth_8311( 0 ) != "none" )
        {
            waitframe();
            var_3 += 0.05;
        }

        if ( isdefined( var_1 ) && var_1 > var_3 )
            wait(var_1 - var_3);

        if ( var_2 )
            maps\_player_exo::player_exo_add_single( "boost_dash" );
    }
}

setup_player_for_gameplay()
{
    _func_0D3( "ammoCounterHide", 0 );
    self _meth_8304( 1 );
    self _meth_811A( 1 );
    self _meth_8119( 1 );
    self _meth_8118( 1 );
    self _meth_8320();
    self _meth_831E();
    self _meth_8130( 1 );
}

monitorscopechange()
{
    foreach ( var_1 in level.players )
    {
        if ( !isdefined( var_1.sniper_zoom_hint_hud ) )
        {
            var_1.sniper_zoom_hint_hud = var_1 maps\_hud_util::createclientfontstring( "default", 1.75 );
            var_1.sniper_zoom_hint_hud.horzalign = "center";
            var_1.sniper_zoom_hint_hud.vertalign = "top";
            var_1.sniper_zoom_hint_hud.alignx = "center";
            var_1.sniper_zoom_hint_hud.aligny = "top";
            var_1.sniper_zoom_hint_hud.x = 0;
            var_1.sniper_zoom_hint_hud.y = 20;
            var_1.sniper_zoom_hint_hud settext( &"VARIABLE_SCOPE_SNIPER_ZOOM" );
            var_1.sniper_zoom_hint_hud.alpha = 0;
            var_1.sniper_zoom_hint_hud.sort = 0.5;
            var_1.sniper_zoom_hint_hud.foreground = 1;
        }

        var_1.fov_snipe = 1;
    }

    var_3 = 0;
    level.players[0].sniper_dvar = "cg_playerFovScale0";

    if ( level.players.size == 2 )
        level.players[1].sniper_dvar = "cg_playerFovScale1";

    foreach ( var_1 in level.players )
    {
        var_1 thread monitormagcycle();
        var_1 thread disablevariablescopehudondeath();
    }

    if ( !isdefined( level.variable_scope_weapons ) )
        level.variable_scope_weapons = [];

    var_6 = undefined;
    var_7 = undefined;

    for (;;)
    {
        var_8 = 0;
        var_7 = var_6;
        var_6 = undefined;

        foreach ( var_10 in level.variable_scope_weapons )
        {
            foreach ( var_1 in level.players )
            {
                if ( var_1 _meth_8311() == var_10 && isalive( var_1 ) )
                {
                    var_8 = 1;
                    var_6 = var_1;
                    break;
                }
            }

            if ( var_8 )
                break;
        }

        if ( var_8 && !var_6 _meth_8336() && !var_6 _meth_8337() )
        {
            if ( var_6 maps\_utility::isads() && var_6 adsbuttonpressed() )
            {
                var_6 turnonvariablescopehud( var_3 );
                var_3 = 1;

                if ( isdefined( level.variable_scope_shadow_center ) )
                {
                    var_14 = undefined;
                    var_15 = undefined;
                    var_16 = anglestoforward( var_6 getangles() );
                    var_17 = var_6.origin;

                    foreach ( var_19 in level.variable_scope_shadow_center )
                    {
                        var_20 = anglestoforward( vectortoangles( var_19 - var_17 ) );
                        var_21 = vectordot( var_16, var_20 );

                        if ( !isdefined( var_14 ) || var_21 > var_15 )
                        {
                            var_14 = var_19;
                            var_15 = var_21;
                        }
                    }

                    if ( isdefined( var_14 ) )
                        _func_0D3( "sm_sunShadowCenter", var_14 );
                }
            }
            else if ( var_3 )
            {
                var_3 = 0;

                if ( isdefined( var_6 ) )
                    var_6 turnoffvariablescopehud();

                _func_0D3( "sm_sunShadowCenter", "0 0 0" );
            }
        }
        else if ( var_3 )
        {
            var_3 = 0;

            if ( isdefined( var_7 ) )
                var_7 turnoffvariablescopehud();

            _func_0D3( "sm_sunShadowCenter", "0 0 0" );
        }

        wait 0.05;
    }
}

turnonvariablescopehud( var_0 )
{
    self _meth_831F();
    _func_0D3( self.sniper_dvar, self.fov_snipe );
    self.sniper_zoom_hint_hud.alpha = 1;

    if ( !var_0 )
        level notify( "variable_sniper_hud_enter" );
}

turnoffvariablescopehud()
{
    level notify( "variable_sniper_hud_exit" );
    self _meth_8320();
    _func_0D3( self.sniper_dvar, 1 );
    self.sniper_zoom_hint_hud.alpha = 0;
}

monitormagcycle()
{
    notifyoncommand( "mag_cycle", "+melee_zoom" );
    notifyoncommand( "mag_cycle", "+sprint_zoom" );

    for (;;)
    {
        self waittill( "mag_cycle" );

        if ( self.sniper_zoom_hint_hud.alpha )
        {
            if ( self.fov_snipe == 0.5 )
            {
                self.fov_snipe = 1;
                continue;
            }

            self.fov_snipe = 0.5;
        }
    }
}

disablevariablescopehudondeath()
{
    self waittill( "death" );
    turnoffvariablescopehud();
}

dialogue_reminder( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "stop_reminders" );
    level endon( "missionfailed" );
    var_5 = undefined;

    if ( !isdefined( var_3 ) )
        var_3 = 10;

    if ( !isdefined( var_4 ) )
        var_4 = 20;

    while ( !common_scripts\utility::flag( var_1 ) )
    {
        var_6 = randomfloatrange( var_3, var_4 );
        var_7 = common_scripts\utility::random( var_2 );

        if ( isdefined( var_5 ) && var_7 == var_5 )
            continue;
        else
        {
            var_5 = var_7;
            wait(var_6);

            if ( !common_scripts\utility::flag( var_1 ) )
            {
                if ( isstring( var_0 ) && var_0 == "radio" )
                {
                    conversation_start();
                    maps\_utility::radio_dialogue( var_7 );
                    conversation_stop();
                    continue;
                }

                conversation_start();
                var_0 maps\_utility::dialogue_queue( var_7 );
                conversation_stop();
            }
        }
    }
}

conversation_start()
{
    if ( !common_scripts\utility::flag_exist( "flag_conversation_in_progress" ) )
        common_scripts\utility::flag_init( "flag_conversation_in_progress" );

    common_scripts\utility::flag_waitopen( "flag_conversation_in_progress" );
    common_scripts\utility::flag_set( "flag_conversation_in_progress" );
}

conversation_stop()
{
    common_scripts\utility::flag_clear( "flag_conversation_in_progress" );
}

array_combine_unique( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_4 in var_0 )
    {
        if ( !isdefined( common_scripts\utility::array_find( var_2, var_4 ) ) )
            var_2[var_2.size] = var_4;
    }

    foreach ( var_4 in var_1 )
    {
        if ( !isdefined( common_scripts\utility::array_find( var_2, var_4 ) ) )
            var_2[var_2.size] = var_4;
    }

    return var_2;
}

laser_targeting_device( var_0 )
{
    var_0 endon( "remove_laser_targeting_device" );
    var_0.lastusedweapon = undefined;
    var_0.laserforceon = 0;
    var_0 _meth_821B( "actionslot4", "dpad_laser_designator" );
    var_0 thread cleanuplasertargetingdevice();
    var_0 _meth_82DD( "use_laser", "+actionslot 4" );
    var_0 _meth_82DD( "fired_laser", "+attack" );
    var_0 _meth_82DD( "fired_laser", "+attack_akimbo_accessible" );
    var_0.laserallowed = 1;
    var_0.lasercooldownafterhit = 20;
    var_0 childthread monitorlaseroff();

    for (;;)
    {
        var_0 waittill( "use_laser" );

        if ( var_0.laserforceon || !var_0.laserallowed || var_0 shouldforcedisablelaser() )
        {
            var_0 notify( "cancel_laser" );
            var_0 _meth_80B3();
            var_0.laserforceon = 0;
            var_0 _meth_8300( 1 );
            wait 0.2;
            var_0 _meth_8131( 1 );
            continue;
        }

        var_0 _meth_80B2();
        var_0 _meth_8131( 0 );
        var_0.laserforceon = 1;
        var_0 _meth_8300( 0 );
        var_0 thread laser_designate_target();
    }
}

shouldforcedisablelaser()
{
    var_0 = self _meth_8311();

    if ( var_0 == "rpg" )
        return 1;

    if ( common_scripts\utility::string_starts_with( var_0, "gl" ) )
        return 1;

    if ( isdefined( level.laser_designator_disable_list ) && isarray( level.laser_designator_disable_list ) )
    {
        foreach ( var_2 in level.laser_designator_disable_list )
        {
            if ( var_0 == var_2 )
                return 1;
        }
    }

    if ( self _meth_8336() )
        return 1;

    if ( self _meth_812C() )
        return 1;

    return 0;
}

cleanuplasertargetingdevice()
{
    self waittill( "remove_laser_targeting_device" );
    self _meth_821B( "actionslot4", "none" );
    self notify( "cancel_laser" );
    self _meth_80B3();
    self.laserforceon = undefined;
    self _meth_8131( 1 );
    self _meth_8300( 1 );
}

monitorlaseroff()
{
    for (;;)
    {
        if ( shouldforcedisablelaser() && isdefined( self.laserforceon ) && self.laserforceon )
        {
            self notify( "use_laser" );
            wait 2.0;
        }

        wait 0.05;
    }
}

laser_designate_target()
{
    self endon( "cancel_laser" );

    for (;;)
    {
        self waittill( "fired_laser" );
        var_0 = get_laser_designated_trace();
        var_1 = var_0["position"];
        var_2 = var_0["entity"];
        level notify( "laser_coordinates_received" );
        var_3 = undefined;

        if ( isdefined( level.laser_targets ) && isdefined( var_2 ) && common_scripts\utility::array_contains( level.laser_targets, var_2 ) )
        {
            var_3 = var_2;
            level.laser_targets = common_scripts\utility::array_remove( level.laser_targets, var_2 );
        }
        else
            var_3 = gettargettriggerhit( var_1 );

        if ( isdefined( var_3 ) )
        {
            thread laser_artillery( var_3 );
            level notify( "laser_target_painted" );
            wait 0.5;
            self notify( "use_laser" );
        }
    }
}

gettargettriggerhit( var_0 )
{
    if ( !isdefined( level.laser_triggers ) || level.laser_triggers.size == 0 )
        return undefined;

    foreach ( var_2 in level.laser_triggers )
    {
        var_3 = distance2d( var_0, var_2.origin );
        var_4 = var_0[2] - var_2.origin[2];

        if ( !isdefined( var_2.radius ) )
            continue;

        if ( !isdefined( var_2.height ) )
            continue;

        if ( var_3 <= var_2.radius && var_4 <= var_2.height && var_4 >= 0 )
        {
            level.laser_triggers = common_scripts\utility::array_remove( level.laser_triggers, var_2 );
            return getent( var_2.target, "script_noteworthy" );
        }
    }

    return undefined;
}

get_laser_designated_trace()
{
    var_0 = self _meth_80A8();
    var_1 = self getangles();
    var_2 = anglestoforward( var_1 );
    var_3 = var_0 + var_2 * 7000;
    var_4 = bullettrace( var_0, var_3, 1, self );
    var_5 = var_4["entity"];

    if ( isdefined( var_5 ) )
        var_4["position"] = var_5.origin;

    return var_4;
}

laser_artillery( var_0 )
{
    level.player endon( "remove_laser_targeting_device" );
    level.player.laserallowed = 0;
    self _meth_821B( "actionslot4", "dpad_killstreak_hellfire_missile_inactive" );
    maps\_utility::flavorbursts_off( "allies" );
    var_1 = level.player;
    wait 2.5;

    if ( !isdefined( var_0.script_index ) )
        var_0.script_index = 99;

    wait 1;

    if ( isdefined( var_0.script_group ) )
    {
        var_2 = get_geo_group( "geo_before", var_0.script_group );

        if ( var_2.size > 0 )
            common_scripts\utility::array_call( var_2, ::hide );

        var_3 = get_geo_group( "geo_after", var_0.script_group );

        if ( var_3.size > 0 )
            common_scripts\utility::array_call( var_3, ::show );
    }

    wait(level.player.lasercooldownafterhit);
    level.player.laserallowed = 1;
    self _meth_821B( "actionslot4", "dpad_laser_designator" );
}

get_geo_group( var_0, var_1 )
{
    var_2 = getentarray( var_0, "targetname" );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        if ( isdefined( var_5.script_group ) && var_5.script_group == var_1 )
            var_3[var_3.size] = var_5;
    }

    return var_3;
}

linear_map( var_0, var_1, var_2, var_3, var_4 )
{
    return var_3 + ( var_0 - var_1 ) * ( var_4 - var_3 ) / ( var_2 - var_1 );
}

linear_map_clamp( var_0, var_1, var_2, var_3, var_4 )
{
    return clamp( linear_map( var_0, var_1, var_2, var_3, var_4 ), min( var_3, var_4 ), max( var_3, var_4 ) );
}

differentiate_motion()
{
    var_0 = gettime() * 0.001;

    if ( !isdefined( self.differentiated_last_update ) )
    {
        self.differentiated_last_update = var_0;
        self.differentiated_last_origin = self.origin;
        self.differentiated_last_velocity = ( 0, 0, 0 );
        self.differentiated_last_acceleration = ( 0, 0, 0 );
        self.differentiated_jerk = ( 0, 0, 0 );
        self.differentiated_acceleration = ( 0, 0, 0 );
        self.differentiated_velocity = ( 0, 0, 0 );
        self.differentiated_speed = 0;
    }
    else if ( self.differentiated_last_update != var_0 )
    {
        var_1 = var_0 - self.differentiated_last_update;
        self.differentiated_last_update = var_0;
        self.differentiated_jerk = ( self.differentiated_acceleration - self.differentiated_last_acceleration ) / var_1;
        self.differentiated_last_acceleration = self.differentiated_acceleration;
        self.differentiated_acceleration = ( self.differentiated_velocity - self.differentiated_last_velocity ) / var_1;
        self.differentiated_last_velocity = self.differentiated_velocity;
        self.differentiated_velocity = ( self.origin - self.differentiated_last_origin ) / var_1;
        self.differentiated_last_origin = self.origin;
        self.differentiated_speed = length( self.differentiated_velocity );
    }
}

get_differentiated_speed()
{
    differentiate_motion();
    return self.differentiated_speed;
}

get_differentiated_velocity()
{
    differentiate_motion();
    return self.differentiated_velocity;
}

get_differentiated_acceleration()
{
    differentiate_motion();
    return self.differentiated_acceleration;
}

get_differentiated_jerk()
{
    differentiate_motion();
    return self.differentiated_jerk;
}

show_player_hud( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0 ) )
        _func_0D3( "g_friendlyNameDist", var_0 );
    else
        _func_0D3( "g_friendlyNameDist", 15000 );

    if ( isdefined( var_1 ) )
        _func_0D3( "compass", var_1 );
    else
        _func_0D3( "compass", "1" );

    if ( isdefined( var_2 ) )
        _func_0D3( "ammoCounterHide", var_2 );
    else
        _func_0D3( "ammoCounterHide", "0" );

    if ( isdefined( var_3 ) )
        _func_0D3( "actionSlotsHide", var_3 );
    else
        _func_0D3( "actionSlotsHide", "0" );

    if ( isdefined( var_4 ) )
        _func_0D3( "hud_showStance", var_4 );
    else
        _func_0D3( "hud_showStance", "1" );
}

hide_player_hud( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0 ) )
        _func_0D3( "g_friendlyNameDist", var_0 );
    else
        _func_0D3( "g_friendlyNameDist", 0 );

    if ( isdefined( var_1 ) )
        _func_0D3( "compass", var_1 );
    else
        _func_0D3( "compass", "0" );

    if ( isdefined( var_2 ) )
        _func_0D3( "ammoCounterHide", var_2 );
    else
        _func_0D3( "ammoCounterHide", "1" );

    if ( isdefined( var_3 ) )
        _func_0D3( "actionSlotsHide", var_3 );
    else
        _func_0D3( "actionSlotsHide", "1" );

    if ( isdefined( var_4 ) )
        _func_0D3( "hud_showStance", var_4 );
    else
        _func_0D3( "hud_showStance", "0" );
}

disable_features_entering_cinema( var_0 )
{
    if ( isdefined( var_0 ) && var_0 == 1 )
    {
        level.player thread maps\_player_exo::player_exo_deactivate();
        level.exo_cinema_disabled = 1;
    }

    hide_player_hud();
}

enable_features_exiting_cinema( var_0 )
{
    if ( !isdefined( var_0 ) && isdefined( level.exo_cinema_disabled ) )
    {
        var_0 = level.exo_cinema_disabled;
        level.exo_cinema_disabled = undefined;
    }

    if ( isdefined( var_0 ) && var_0 == 1 )
        level.player thread maps\_player_exo::player_exo_activate();

    show_player_hud();
}

handle_portal_group( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );

    if ( isdefined( var_2 ) && isstring( var_2 ) )
        level endon( var_2 );

    if ( !isdefined( var_0 ) || !isstring( var_0 ) )
        return;

    if ( !isdefined( var_1 ) || !isstring( var_1 ) || !common_scripts\utility::flag_exist( var_0 ) )
        return;

    var_3 = getent( var_1, "targetname" );

    if ( !isdefined( var_3 ) )
        var_3 = getent( var_1, "script_noteworthy" );

    if ( !isdefined( var_3 ) )
        return;

    var_3 _meth_8070( 0 );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_0 );
        var_3 _meth_8070( 1 );
        common_scripts\utility::flag_waitopen( var_0 );
        var_3 _meth_8070( 0 );
        wait 0.05;
    }
}

portal_group_on( var_0, var_1 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );

    if ( !isdefined( var_0 ) || !isstring( var_0 ) )
        return;

    if ( !isdefined( var_1 ) || !isstring( var_1 ) || !common_scripts\utility::flag_exist( var_0 ) )
        return;

    var_2 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        var_2 = getent( var_1, "script_noteworthy" );

    if ( !isdefined( var_2 ) )
        return;

    var_2 _meth_8070( 0 );
    common_scripts\utility::flag_wait( var_0 );
    var_2 _meth_8070( 1 );
}

portal_group_off( var_0, var_1 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );

    if ( !isdefined( var_0 ) || !isstring( var_0 ) )
        return;

    if ( !isdefined( var_1 ) || !isstring( var_1 ) || !common_scripts\utility::flag_exist( var_0 ) )
        return;

    var_2 = getent( var_1, "targetname" );

    if ( !isdefined( var_2 ) )
        var_2 = getent( var_1, "script_noteworthy" );

    if ( !isdefined( var_2 ) )
        return;

    common_scripts\utility::flag_wait( var_0 );
    var_2 _meth_8070( 0 );
}

make_emp_vulnerable()
{
    if ( !isdefined( level.emp_vulnerable_list ) )
        level.emp_vulnerable_list = [];

    level.emp_vulnerable_list = common_scripts\utility::array_add( level.emp_vulnerable_list, self );
    self waittill( "death" );
    level.emp_vulnerable_list = common_scripts\utility::array_remove( level.emp_vulnerable_list, self );
}

play_fx_with_handle( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.fx_id = common_scripts\utility::getfx( var_0 );
    var_4.entity = var_1;
    var_4.tag = var_2;

    if ( isdefined( var_3 ) && var_3 )
    {
        var_4.tag_origin = common_scripts\utility::spawn_tag_origin();
        var_4.tag_origin _meth_804D( var_1, var_4.tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        playfxontag( var_4.fx_id, var_4.tag_origin, "tag_origin" );
        kill_fx_with_handle_on_death( var_4 );
    }
    else
        playfxontag( var_4.fx_id, var_4.entity, var_4.tag );

    return var_4;
}

kill_fx_with_handle_on_death( var_0 )
{
    thread kill_fx_with_handle_on_death_internal( var_0 );
}

kill_fx_with_handle_on_death_internal( var_0 )
{
    var_0.entity waittill( "death" );
    kill_fx_with_handle( var_0 );
}

kill_fx_with_handle( var_0 )
{
    if ( isdefined( var_0.tag_origin ) )
    {
        killfxontag( var_0.fx_id, var_0.tag_origin, "tag_origin" );
        var_0.tag_origin common_scripts\utility::delaycall( 0.05, ::delete );
        var_0.tag_origin = undefined;
        var_0.entity = undefined;
    }
    else if ( isdefined( var_0.entity ) )
    {
        killfxontag( var_0.fx_id, var_0.entity, var_0.tag );
        var_0.entity = undefined;
    }
}

hint_button_trigger( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 200;

    return hint_button_position( var_0, self.origin, undefined, var_1, undefined, self );
}

hint_button_tag( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    return hint_button_create( var_0, var_1, var_2, var_3, 0, var_4, var_5 );
}

hint_button_position( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = common_scripts\utility::spawn_tag_origin();

    if ( !isdefined( var_1 ) )
    {
        if ( isdefined( var_5 ) )
            var_1 = var_5.origin;
        else
            var_1 = self.origin;
    }

    var_6.origin = var_1;
    return var_6 hint_button_create( var_0, "tag_origin", var_2, var_3, 1, var_4, var_5 );
}

hint_button_create( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = newclienthudelem( level.player );
    var_7.alignx = "center";
    var_7.aligny = "middle";
    var_7.fontscale = 3;
    var_7.font = "buttonprompt";
    var_7.positioninworld = 1;

    if ( isdefined( self ) )
    {
        if ( isdefined( var_1 ) )
            var_7 _meth_80CD( self, var_1 );
        else
            var_7 _meth_80CD( self );
    }

    var_8 = hint_button_string_lookup( var_0 );
    var_7 settext( var_8 );
    var_7.hidewheninmenu = 1;
    var_7.sort = -1;
    var_7.alpha = 1;

    if ( !isdefined( var_5 ) || !var_5 )
        var_7 thread scale_3d_hint_button( self, var_1, level.player, var_2, var_3, var_6 );

    var_7.object = self;

    if ( isdefined( var_4 ) && var_4 )
        var_7.deleteobjectwhendone = 1;

    return var_7;
}

scale_3d_hint_button( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "death" );
    var_0 endon( "death" );

    if ( !isdefined( var_3 ) )
        var_3 = getdvarint( "player_useradius" );

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_6 = 0;
    self.fontscale = 2;
    self.font = "buttonprompt";

    for (;;)
    {
        if ( isdefined( var_1 ) )
            var_6 = distance( var_0 gettagorigin( var_1 ), var_2 _meth_80A8() );
        else
            var_6 = distance( var_0, var_2 _meth_80A8() );

        if ( var_4 != 0 && var_6 > var_4 )
            self.alpha = 0;
        else if ( var_3 != 0 && var_6 > var_3 )
        {
            if ( var_4 - var_3 > 0 )
                self.alpha = ( 1 - ( var_6 - var_3 ) / ( var_4 - var_3 ) ) * 0.3;
            else
                self.alpha = 0.3;
        }
        else if ( isdefined( var_5 ) && isdefined( var_5.classname ) && issubstr( var_5.classname, "trigger" ) )
        {
            var_7 = var_2 _meth_8521();

            if ( isdefined( var_7 ) && var_7 == var_5 )
                self.alpha = 1;
            else
                self.alpha = 0.3;
        }
        else
            self.alpha = 1;

        waitframe();
    }
}

hint_button_string_lookup( var_0 )
{
    switch ( var_0 )
    {
        case "activate":
        case "usereload":
        case "use":
        case "x":
        case "reload":
            return "^3[{+activate}]^7";
        case "gostand":
        case "jump":
        case "a":
            return "^3[{+gostand}]^7";
        case "weapnext":
        case "y":
            return "^3[{weapnext}]^7";
        case "stance":
        case "b":
        case "crouch":
            return "^3[{+stance}]^7";
        case "rs":
        case "melee":
            return "^3[{+melee}]^7";
        case "breath":
        case "ls":
        case "sprint":
            return "^3[{+sprint}]^7";
        case "r1":
        case "rt":
        case "attack":
            return "^3[{+attack}]^7";
        case "frag":
        case "r2":
        case "rb":
        case "grenade":
            return "^3[{+frag}]^7";
        case "ads":
        case "l1":
        case "lt":
            return "^3[{+ads}]^7";
        case "flash":
        case "smoke":
        case "l2":
        case "lb":
        case "flashbang":
            return "^3[{+smoke}]^7";
        case "pause":
        case "start":
            return "^3[{pause}]^7";
        case "up":
            return "^3[{+actionslot 1}]^7";
        case "down":
            return "^3[{+actionslot 2}]^7";
        case "left":
            return "^3[{+actionslot 3}]^7";
        case "right":
            return "^3[{+actionslot 4}]^7";
        default:
            break;
    }
}

hint_button_clear()
{
    if ( isdefined( self.deleteobjectwhendone ) && self.deleteobjectwhendone )
        self.object delete();

    if ( isdefined( self ) )
        self destroy();
}

hint_button_flash( var_0, var_1 )
{
    while ( isdefined( self ) )
    {
        var_2 = self.alpha;
        self fadeovertime( var_0 / 3 );
        self.alpha = var_1;
        wait(var_0);

        if ( !isdefined( self ) )
            return;

        self fadeovertime( var_0 / 3 );
        self.alpha = var_2;
        wait(var_0);
    }
}

button_mash_dynamic_hint( var_0, var_1, var_2, var_3 )
{
    self endon( var_2 );
    level.player endon( var_2 );
    self endon( "death" );
    thread maps\_utility::hint( var_0 );
    var_4 = var_1 + "_button_mash_dynamic_hint";
    thread buttonmash_hint_cleanup( var_2, var_4, var_1, var_3 );
    level.player _meth_82DD( var_4, var_1 );

    if ( isdefined( var_3 ) )
        level.player _meth_82DD( var_4, var_3 );

    for (;;)
    {
        self waittill( var_4 );
        level.hintelement.alpha = 0.2;
        level.hintelement fadeovertime( 0.3 );
        level.hintelement.alpha = 1;
        waitframe();
    }
}

buttonmash_hint_cleanup( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    common_scripts\utility::waittill_any_ents( self, var_0, level.player, var_0 );
    thread maps\_utility::hint_fade();
    level.player _meth_849C( var_1, var_2 );

    if ( isdefined( var_3 ) )
        level.player _meth_849C( var_1, var_3 );
}

hint_button_create_flashing( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 0, 0, 0 );

    self endon( "death" );
    var_7 = common_scripts\utility::spawn_tag_origin();
    var_7.origin = self gettagorigin( var_0 );
    var_7.origin += var_3;
    var_7 _meth_804D( self, var_0 );
    var_1 = var_7 hint_button_create( var_1, "TAG_ORIGIN", var_4, var_5, 1, 1 );

    if ( isdefined( var_6 ) )
        var_1.fontscale = var_6;

    var_1 thread hint_button_flash( 0.15, 0.1 );
    common_scripts\utility::waittill_any_ents( self, var_2, level.player, var_2 );
    var_1 hint_button_clear();
}

play_videolog( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( var_6 ) )
        var_6 = 1;

    var_8 = undefined;

    if ( isdefined( var_2 ) || isdefined( var_3 ) || isdefined( var_4 ) || isdefined( var_5 ) )
    {
        var_8 = [];
        var_8["top"] = var_2;
        var_8["left"] = var_3;
        var_8["bottom"] = var_4;
        var_8["right"] = var_5;
    }

    var_9 = [];
    var_9["add"] = 0;
    var_9["blend"] = 1;
    var_9["blend_add"] = 2;
    var_9["screen_add"] = 3;
    var_9["multiply"] = 4;
    var_9["replace"] = 5;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    var_10 = var_9[var_1];
    var_11 = getdvarint( "cg_cinematicfullscreen" );
    _func_0D3( "cg_cinematicfullscreen", 0 );
    var_12 = [];

    if ( isdefined( var_8 ) )
    {
        var_12["top"] = getomnvar( "ui_videolog_pos_top" );
        var_12["left"] = getomnvar( "ui_videolog_pos_left" );
        var_12["bottom"] = getomnvar( "ui_videolog_pos_bottom" );
        var_12["right"] = getomnvar( "ui_videolog_pos_right" );
        setomnvar( "ui_videolog_pos_top", var_8["top"] );
        setomnvar( "ui_videolog_pos_left", var_8["left"] );
        setomnvar( "ui_videolog_pos_bottom", var_8["bottom"] );
        setomnvar( "ui_videolog_pos_right", var_8["right"] );
    }

    setomnvar( "ui_videolog", 1 );
    var_13 = getomnvar( "ui_videolog_blendfunc" );
    setomnvar( "ui_videolog_blendfunc", var_10 );
    setomnvar( "ui_videolog_blur_bkgrnd", var_6 );

    if ( !isdefined( var_7 ) )
        var_7 = level._snd.default_vid_log_vol;

    _func_057( var_0, 0, var_7, 1 );

    while ( !_func_05B() )
        waitframe();

    while ( _func_05B() )
        waitframe();

    setomnvar( "ui_videolog", 0 );
    setomnvar( "ui_videolog_blendfunc", var_13 );
    _func_0D3( "cg_cinematicfullscreen", var_11 );

    if ( isdefined( var_8 ) )
    {
        setomnvar( "ui_videolog_pos_top", var_12["top"] );
        setomnvar( "ui_videolog_pos_left", var_12["left"] );
        setomnvar( "ui_videolog_pos_bottom", var_12["bottom"] );
        setomnvar( "ui_videolog_pos_right", var_12["right"] );
    }
}

stop_videolog()
{
    if ( _func_05B() )
        _func_05C();
}

play_chyron_video( var_0, var_1, var_2 )
{
    common_scripts\utility::flag_init( "chyron_video_done" );
    var_3 = newclienthudelem( level.player );
    var_3 _meth_80CC( "black", 1280, 720 );
    var_3.horzalign = "fullscreen";
    var_3.vertalign = "fullscreen";
    var_3.alpha = 1;
    var_3.foreground = 0;
    _func_057( var_0 );
    var_4 = getdvarint( "cg_cinematicCanPause", 0 );
    _func_0D3( "cg_cinematicCanPause", 1 );

    while ( !_func_05B() )
        waitframe();

    while ( _func_05B() )
        waitframe();

    common_scripts\utility::flag_set( "chyron_video_done" );

    if ( isdefined( var_1 ) )
        wait(var_1);

    if ( isdefined( var_2 ) )
    {
        var_3 fadeovertime( var_2 );
        var_3.alpha = 0;
        wait(var_2);
    }

    _func_0D3( "cg_cinematicCanPause", var_4 );
    var_3 destroy();
}

point_in_angle_of_crosshairs( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = level.player;

    return vectordot( vectornormalize( var_0 - var_2 _meth_80A8() ), anglestoforward( var_2 getangles() ) ) > cos( var_1 );
}

entity_is_in_circle( var_0, var_1, var_2, var_3 )
{
    return point_in_angle_of_crosshairs( var_0.origin, atan( tan( 0.5 * var_2 ) * var_3 / 320.0 ), var_1 );
}
