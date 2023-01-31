// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

_precache()
{
    precachemodel( "vehicle_sniper_drone_outerparts" );
    precachemodel( "vehicle_vm_sniper_drone" );
    precachemodel( "vehicle_pdrone_player" );
    precachemodel( "dem_tablet_pc_01" );
    precachemodel( "worldhands_atlas_pmc_smp" );
    precacheshader( "overlay_static_digital" );
    precacheshader( "s1_pdrone_player_overlay" );
    precacheshader( "ugv_vignette_overlay" );
}

#using_animtree("player");

_anims_player()
{
    level.scr_model["drone_deploy_player_arms"] = "worldhands_atlas_pmc_smp";
    level.scr_animtree["drone_deploy_player_arms"] = #animtree;
    level.scr_anim["drone_deploy_player_arms"]["deploy"] = %assault_drone_deploy_vm;
    level.scr_anim["drone_deploy_player_arms"]["use"] = %rec_drone_deploy_vm;
    level.scr_anim["drone_deploy_player_arms"]["stop_use"] = %rec_drone_deploy_out_vm;
}

#using_animtree("vehicles");

_anims_drone()
{
    level.scr_model["drone_deploy_drone"] = "vehicle_pdrone_player";
    level.scr_animtree["drone_deploy_drone"] = #animtree;
    level.scr_anim["drone_deploy_drone"]["deploy"] = %assault_drone_deploy;
}

#using_animtree("generic_human");

_anims_proxy()
{
    level.scr_animtree["drone_player_proxy"] = #animtree;
    level.scr_anim["drone_player_proxy"]["loop"][0] = %pdrone_player_proxy_idle;
}

_anims()
{
    _anims_player();
    _anims_drone();
    _anims_proxy();
}

_fx()
{
    level._effect["pdrone_large_death_explosion"] = loadfx( "vfx/explosion/vehicle_pdrone_large_explosion" );
}

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "pdrone_player", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_life( 10000, 0, 10000 );
    maps\_vehicle::build_turret( "pdrone_player_turret_sp", "tag_origin", "vehicle_sniper_drone_turret_mp", undefined, "manual", 0.2, 0, 0, ( 0, 0, 0 ) );
    _precache();
    _anims();
    _fx();
}

init_local()
{
    thread start_player_pdrone_audio();
}

start_player_pdrone_audio()
{
    var_0 = spawnstruct();
    var_0.preset_name = "pdrone_player";
    var_1 = vehicle_scripts\_pdrone_player_aud::snd_pdrone_player_constructor;
    soundscripts\_snd::snd_message( "snd_register_vehicle", var_0.preset_name, var_1 );
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
}

pdrone_deploy_check( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 125;

    if ( !isdefined( var_1 ) )
        var_1 = 10;

    if ( !isdefined( var_2 ) )
        var_2 = 45;

    var_3 = level.player _meth_80A8();
    var_4 = 1;
    var_5 = common_scripts\utility::flat_angle( level.player _meth_8036() );
    var_6 = 0;

    for ( var_7 = 0; var_7 <= 5; var_7++ )
    {
        var_8 = ( 1, 0, 0 );
        var_9 = var_5;

        switch ( var_7 )
        {
            case 1:
                var_9 = ( -1 * var_2, var_9[1] - var_1, 0 );
                var_8 = ( 0, 1, 0 );
                break;
            case 2:
                var_9 = ( 0, var_9[1] - var_1, 0 );
                var_8 = ( 0, 0, 1 );
                break;
            case 3:
                var_9 = ( 0, var_9[1] + var_1, 0 );
                var_8 = ( 1, 1, 1 );
                break;
            case 4:
                var_9 = ( -1 * var_2, var_9[1] + var_1, 0 );
                var_8 = ( 0, 0, 0 );
                break;
            case 5:
                var_9 = ( -1 * var_2, var_9[1] - var_1, 0 );
                var_8 = ( 1, 1, 0 );
                break;
        }

        var_10 = var_3 + anglestoforward( var_9 ) * var_0;
        var_11 = playerphysicstrace( var_3, var_10 );
        var_12 = length( var_11 - var_10 );
        var_4 = var_12 == 0;
    }

    return var_4;
}

pdrone_deploy( var_0, var_1, var_2 )
{
    var_3 = maps\_utility::spawn_anim_model( "drone_deploy_player_arms", level.player.origin );
    var_4 = maps\_utility::spawn_anim_model( "drone_deploy_drone", level.player.origin );
    var_5 = level.player common_scripts\utility::spawn_tag_origin();
    level.player _meth_80EF();
    level.player maps\_shg_utility::setup_player_for_scene();
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6 _meth_804D( var_3, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );

    if ( level.player _meth_817C() == "prone" )
    {
        while ( level.player _meth_817C() != "crouch" )
        {
            level.player _meth_817D( "crouch" );
            waitframe();
        }

        var_7 = 49;
    }

    var_7 = 0;

    if ( level.player _meth_817C() == "crouch" )
        var_7 = 20;

    level.player.dronedeploystance = level.player _meth_817C();
    var_3.origin = level.player.origin - ( 0, 0, var_7 );
    var_4.origin = level.player.origin - ( 0, 0, var_7 );
    var_5.origin = level.player.origin - ( 0, 0, var_7 );
    var_5 maps\_anim::anim_first_frame_solo( var_3, "deploy" );
    soundscripts\_snd::snd_message( "snd_player_drone_deploy", var_4 );
    var_3 hide();
    var_8 = 0.5;
    level.player _meth_8080( var_6, "tag_origin", var_8 );
    wait(var_8);
    var_3 show();
    thread introscreen_fade_in();
    var_5 maps\_anim::anim_single( [ var_3, var_4 ], "deploy" );
    var_9 = var_0 maps\_utility::spawn_vehicle();
    var_9 _meth_80B1( "vehicle_pdrone_player" );

    if ( isdefined( var_2 ) )
        var_9 _meth_827C( var_2.origin, var_2.angles );
    else
        var_9 _meth_827C( var_4.origin, var_4.angles );

    level.player _meth_804F();
    var_3 delete();
    var_4 delete();
    var_5 delete();
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player _meth_80F0();

    if ( isdefined( var_1 ) && var_1 )
        var_9 thread pdrone_orient_to_closest_ai_target();

    return var_9;
}

pdrone_orient_to_closest_target( var_0 )
{
    if ( !isdefined( var_0 ) || var_0.size == 0 )
        return;

    var_1 = common_scripts\utility::getclosest( self.origin, var_0, 100000 );

    if ( isdefined( var_1 ) && isalive( var_1 ) )
    {
        var_2 = var_1.origin - self.origin;
        var_3 = vectortoangles( var_2 );
        self _meth_827C( self.origin, var_3 );
    }
}

pdrone_orient_to_closest_ai_target()
{
    pdrone_orient_to_closest_target( _func_0D6( "axis" ) );
}

pdrone_orient_to_closest_ent_target()
{
    var_0 = [];

    foreach ( var_2 in getarraykeys( self.ent_targets ) )
        var_0 = common_scripts\utility::array_combine( var_0, getentarray( self.ent_targets[var_2], var_2 ) );

    pdrone_orient_to_closest_target( var_0 );
}

introscreen_fade_in()
{
    wait 4.0;
    thread maps\_introscreen::introscreen_generic_fade_in( "black", 0.4, 0.3, 0.3 );
}

_pdrone_stop_use_anim()
{
    var_0 = maps\_utility::spawn_anim_model( "drone_deploy_player_arms", level.player.origin );
    var_1 = level.player common_scripts\utility::spawn_tag_origin();
    level.player _meth_807F( var_0, "tag_player" );
    var_1 maps\_anim::anim_single_solo( var_0, "stop_use" );
    level.player _meth_804F();
    var_2 = level.player _meth_813C( level.player.origin + ( 0, 0, 60 ) );

    if ( isdefined( var_2 ) )
        level.player setorigin( var_2 );

    var_0 delete();
    var_1 delete();
}

_get_if_defined_or_default( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        return var_0;

    return var_1;
}

_pdrone_player_proxy_delicate_flower( var_0 )
{
    self endon( "death" );
    var_0 endon( "death" );

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2 );

        if ( isplayer( var_2 ) && var_1 > 50 )
            break;
    }

    self.player_proxy_took_damage = 1;
    pdrone_player_force_exit();
}

_pdrone_player_proxy( var_0 )
{
    var_1 = getent( "pdrone_player_proxy", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai( 1 );
    var_2.animname = "drone_player_proxy";
    var_2.name = "Mitchell";
    var_2.no_ai = 1;
    var_2 maps\_utility::gun_remove();
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.team = "axis";
    var_2.no_friendly_fire_penalty = 1;
    var_2 disableaimassist();
    var_2 thread maps\_utility::magic_bullet_shield( 1 );
    var_2 _meth_83FA( 3, 1, 1 );
    var_2 attach( "dem_tablet_pc_01", "tag_weapon_left" );
    var_3 = self.saved.return_tag;

    if ( isdefined( var_0 ) )
        var_3 = var_0;

    self.player_proxy = var_2;
    self.player_proxy_org = var_3;
    childthread _pdrone_player_proxy_delicate_flower( var_2 );
    var_2 _meth_81C6( var_3.origin, var_3.angles );
    var_3 maps\_anim::anim_loop_solo( var_2, "loop", "stop_loop" );
}

_pdrone_player_proxy_clear()
{
    if ( isdefined( self.player_proxy ) )
    {
        self.player_proxy_org notify( "stop_loop" );

        if ( isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
            maps\_utility::stop_magic_bullet_shield();

        self.player_proxy hide();
        self.player_proxy common_scripts\utility::delaycall( 0.1, ::delete );
    }
}

pdrone_player_use( var_0, var_1, var_2, var_3 )
{
    var_0.saved = spawnstruct();
    var_0.data = spawnstruct();
    var_0.data.volumes_targetname = var_1;
    var_0.team = level.player.team;
    var_0.time = var_2;
    var_0.is_pdrone = 1;
    var_0.turret = var_0.mgturret[0];
    var_0.turret hide();

    if ( isdefined( var_3 ) )
        var_0.losing_connection_multipler = var_3;
    else
        var_0.losing_connection_multipler = 1.5;

    var_0.data.player_command_for_exit = "stance";

    if ( !level.player _meth_834E() )
        var_0.data.player_command_for_exit = "activate";
}

pdrone_player_spawn( var_0, var_1, var_2, var_3 )
{
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname( var_0 );
    pdrone_player_use( var_4, var_1, var_2, var_3 );
    return var_4;
}

_save_dvars()
{
    self.saved.vehhelicoptercontrolsaltitude = getdvarint( "vehHelicopterControlsAltitude", 1 );
    self.saved.vehhelicoptercontrolsystem = getdvarint( "vehHelicopterControlSystem", 1 );
    self.saved.r_hudoutlineenable = getdvar( "r_hudoutlineenable", 0 );
    self.saved.r_hudoutlinepostmode = getdvar( "r_hudoutlinepostmode", 0 );
    self.saved.r_hudoutlinehalolumscale = getdvar( "r_hudoutlinehalolumscale", 0 );
    self.saved.r_hudoutlinehaloblurradius = getdvar( "r_hudoutlinehaloblurradius", 0 );
    self.saved.aim_turnrate_pitch = getdvarint( "aim_turnrate_pitch" );
    self.saved.aim_turnrate_yaw = getdvarint( "aim_turnrate_yaw" );
    self.saved.playerhealth_regularregendelay = level.player.gs.playerhealth_regularregendelay;
    self.saved.longregentime = level.player.gs.longregentime;
}

_reset_dvars()
{
    _func_0D3( "vehHelicopterControlsAltitude", self.saved.vehhelicoptercontrolsaltitude );
    _func_0D3( "vehHelicopterControlSystem", self.saved.vehhelicoptercontrolsystem );
    _func_0D3( "r_hudoutlineenable", self.saved.r_hudoutlineenable );
    _func_0D3( "r_hudoutlinepostmode", self.saved.r_hudoutlinepostmode );
    _func_0D3( "r_hudoutlinehalolumscale", self.saved.r_hudoutlinehalolumscale );
    _func_0D3( "r_hudoutlinehaloblurradius", self.saved.r_hudoutlinehaloblurradius );
    _func_0D3( "aim_turnrate_pitch", self.saved.aim_turnrate_pitch );
    _func_0D3( "aim_turnrate_yaw", self.saved.aim_turnrate_yaw );
    level.player.gs.playerhealth_regularregendelay = self.saved.playerhealth_regularregendelay;
    level.player.gs.longregentime = self.saved.playerhealth_regularregendelay;
}

_set_dvars()
{
    _func_0D3( "vehHelicopterControlsAltitude", 1 );
    _func_0D3( "vehHelicopterControlSystem", 1 );
    _func_0D3( "r_hudoutlineenable", 1 );
    _func_0D3( "r_hudoutlinepostmode", 2 );
    _func_0D3( "r_hudoutlinehalolumscale", 1 );
    _func_0D3( "r_hudoutlinehaloblurradius", 0.7 );
    _func_0D3( "aim_turnrate_pitch", 100 );
    _func_0D3( "aim_turnrate_yaw", 130 );
    level.player.gs.playerhealth_regularregendelay /= 500;
    level.player.gs.longregentime /= 500;
}

#using_animtree("vehicles");

_vmodel_anims( var_0, var_1 )
{
    self _meth_8115( #animtree );
    var_2 = getanimlength( var_1 );

    for (;;)
    {
        self _meth_8143( var_0 );
        level.player waittill( "weapon_fired" );

        if ( 1 )
            level.player.rumble_entity.intensity += 0.1;

        while ( level.player attackbuttonpressed() )
        {
            self _meth_8145( var_1 );
            wait(var_2 / 6);
        }

        if ( 1 )
            level.player.rumble_entity.intensity -= 0.1;
    }
}

_debug_vector_to_string( var_0 )
{
    return "( " + var_0[0] + " , " + var_0[1] + ", " + var_0[2] + " )";
}

_vmodel_sway()
{
    for (;;)
    {
        var_0 = self _meth_8288();
        var_1 = length( var_0 );

        if ( 1 )
        {
            if ( var_1 > 100 )
            {
                if ( !isdefined( self.movement_rumble ) )
                {
                    level.player.rumble_entity.intensity += 0.01;
                    self.movement_rumble = 1;
                }
            }
            else if ( isdefined( self.movement_rumble ) )
            {
                level.player.rumble_entity.intensity -= 0.01;
                self.movement_rumble = undefined;
            }
        }

        var_2 = 400;
        var_3 = 0;
        var_4 = 0;
        var_5 = 4;

        if ( var_0[1] < 0 )
        {
            var_6 = clamp( var_0[1] * -1, 0, var_2 );
            var_3 = var_6 / var_2;
        }
        else if ( var_0[1] > 0 )
        {
            var_7 = clamp( var_0[1], 0, var_2 );
            var_4 = var_7 / var_2;
        }

        var_8 = -1 * var_3 * var_5 + var_4 * var_5;
        var_9 = 0;
        var_10 = 0;
        var_11 = 1;

        if ( var_0[0] < 0 )
        {
            var_12 = clamp( var_0[0] * -1, 0, var_2 );
            var_9 = var_12 / var_2;
        }
        else if ( var_0[0] > 0 )
        {
            var_13 = clamp( var_0[0], 0, var_2 );
            var_10 = var_13 / var_2;
        }

        var_14 = -1 * var_9 * var_11 + var_10 * var_11;
        self.vmodelbarrel _meth_80A7( level.player );
        self.vmodelouter _meth_80A7( level.player );
        self.vmodelbarrel _meth_80A6( level.player, "tag_origin", ( -5, 0, -1.75 ), ( var_14, 0, var_8 ), 1 );
        self.vmodelouter _meth_80A6( level.player, "tag_origin", ( 6, 0, -3 ), ( var_14, 0, var_8 ), 1 );
        waitframe();
    }
}

_vmodel_enter()
{
    var_0 = spawn( "script_model", self.origin );
    var_0 _meth_80B1( "vehicle_sniper_drone_outerparts" );
    var_0 _meth_80A6( level.player, "tag_origin", ( 6, 0, -3 ), ( 0, 0, 0 ), 1 );
    var_0 childthread _vmodel_anims( %sniper_drone_outerparts_idle, %sniper_drone_outerparts_fire );
    self.vmodelouter = var_0;
    var_1 = spawn( "script_model", self.origin );
    var_1 _meth_80B1( "vehicle_vm_sniper_drone" );
    var_1 _meth_80A6( level.player, "tag_origin", ( -5, 0, -1.75 ), ( 0, 0, 0 ), 1 );
    var_1 childthread _vmodel_anims( %sniper_drone_vm_idle, %sniper_drone_vm_fire );
    self.vmodelbarrel = var_1;
    childthread _vmodel_sway();
}

_vmodel_exit()
{
    self.vmodelouter _meth_80A7( level.player );
    self.vmodelouter delete();
    self.vmodelbarrel _meth_80A7( level.player );
    self.vmodelbarrel delete();
}

_monitor_threat_count()
{
    for (;;)
    {
        setomnvar( "ui_assaultdrone_threat_count", self.hud_targets.size );
        self waittill( "update_threat_count" );
    }
}

_reduce_hud_target_count_on_death( var_0 )
{
    var_0 common_scripts\utility::waittill_either( "death", "fake_death" );
    self.hud_targets = common_scripts\utility::array_remove( self.hud_targets, var_0 );
    self.hud_targets = maps\_utility::remove_dead_from_array( self.hud_targets );
    self notify( "update_threat_count" );

    if ( self.hud_targets.size == 0 )
        self notify( "all_threats_eliminated" );
}

_sethudoutline( var_0 )
{
    var_0 _meth_83FA( 1, 1, 0 );
    childthread _reduce_hud_target_count_on_death( var_0 );
}

_sethudoutline_on_spawn( var_0 )
{
    for (;;)
    {
        var_0 waittill( "spawned", var_1 );
        self.hud_targets = common_scripts\utility::array_add( self.hud_targets, var_1 );
        _sethudoutline( var_1 );
    }
}

_mark_newlyspawned()
{
    var_0 = common_scripts\utility::array_combine( _func_0D8(), vehicle_getspawnerarray() );

    foreach ( var_2 in var_0 )
        childthread _sethudoutline_on_spawn( var_2 );
}

_set_hudoutline_on_enemies()
{
    self.hud_targets = _func_0D6( "axis" );
    self.hud_allies = _func_0D6( "allies" );

    if ( isdefined( self.vehicle_targets ) )
    {
        var_0 = [];

        foreach ( var_2 in getarraykeys( self.vehicle_targets ) )
            var_0 = common_scripts\utility::array_combine( var_0, getentarray( self.vehicle_targets[var_2], var_2 ) );

        self.hud_targets = common_scripts\utility::array_combine( self.hud_targets, var_0 );
    }

    if ( isdefined( self.ent_targets ) )
    {
        var_4 = [];

        foreach ( var_2 in getarraykeys( self.ent_targets ) )
            var_4 = common_scripts\utility::array_combine( var_4, getentarray( self.ent_targets[var_2], var_2 ) );

        self.hud_targets = common_scripts\utility::array_combine( self.hud_targets, var_4 );
    }

    foreach ( var_8 in self.hud_targets )
        _sethudoutline( var_8 );

    childthread _mark_newlyspawned();
    childthread _monitor_threat_count();

    foreach ( var_11 in self.hud_allies )
        var_11 _meth_83FA( 6, 1, 0 );
}

_remove_hudoutline_on_enemies()
{
    var_0 = common_scripts\utility::array_combine( self.hud_targets, self.hud_allies );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !_func_294( var_2 ) )
            var_2 _meth_83FB();
    }
}

pdrone_player_enter( var_0, var_1, var_2 )
{
    level.player endon( "drone_exit" );
    _save_dvars();
    _set_dvars();
    level.cansave = 0;
    level.player _meth_80EF();

    if ( isdefined( var_0 ) && var_0 )
        childthread _pdrone_player_proxy( var_1 );

    if ( !isdefined( var_1 ) )
        self.saved.return_tag = level.player common_scripts\utility::spawn_tag_origin();
    else
        self.saved.return_tag = var_1;

    self.no_threat_return_node = var_2;
    level.player maps\_utility::teleport_player( self );
    level.player _meth_820B( self, 0 );

    if ( 1 )
    {
        level.player.rumble_entity = maps\_utility::get_rumble_ent( "steady_rumble" );
        level.player.rumble_entity.intensity = 0.088;
    }

    self.turret _meth_8099( level.player );
    self.turret makeunusable();
    level.player _meth_80F4();
    level.player.is_driving_pdrone = 1;
    self hide();
    self _meth_8139( "allies" );
    _vmodel_enter();
    maps\_shg_utility::hide_player_hud();
    _setup_overlay_static();
    _setup_hud();
    thread _remove_hud_on_death();
    _set_hudoutline_on_enemies();
    childthread _listen_drone_input();
}

pdrone_player_is_driving()
{
    return isdefined( level.player.is_driving_pdrone ) && level.player.is_driving_pdrone;
}

_pdrone_player_exit_return_control()
{
    wait 0.2;
    level.player maps\_shg_utility::setup_player_for_gameplay();
    level.player freezecontrols( 0 );
}

pdrone_player_death()
{
    wait 0.25;
    var_0 = self gettagorigin( "tag_origin" );
    radiusdamage( var_0, 256, 250, 50, level.player );
    playfx( common_scripts\utility::getfx( "pdrone_large_death_explosion" ), var_0 );
    soundscripts\_snd::snd_message( "pdrone_death_explode" );
}

pdrone_player_exit( var_0 )
{
    pdrone_player_force_exit();
    _remove_drone_control();
    level.cansave = 1;
    maps\_shg_utility::show_player_hud();
    level.player freezecontrols( 1 );
    level.player maps\_shg_utility::setup_player_for_scene();

    if ( isalive( level.player ) )
    {
        thread maps\_introscreen::introscreen_generic_fade_in( "black", 0.1, 0.3, 0.3 );
        wait 0.35;
        _pdrone_player_proxy_clear();
        _remove_hud();
        _remove_overlay_static();
        _reset_dvars();

        if ( 1 )
        {
            level.player _meth_80AF( "steady_rumble" );

            if ( isdefined( level.player.rumble_entity ) )
                level.player.rumble_entity delete();
        }

        if ( level.player.is_driving_pdrone )
        {
            level.player _meth_820C( self );
            level.player.is_driving_pdrone = 0;
            self.turret delete();
        }

        level.player _meth_80F0();
        _vmodel_exit();
        _remove_hudoutline_on_enemies();

        if ( isdefined( self.no_threat_return_node ) && self.hud_targets.size < 2 )
            self.saved.return_tag = self.no_threat_return_node;

        if ( isdefined( self.saved.return_tag ) )
            level.player maps\_utility::teleport_player( self.saved.return_tag );

        if ( isdefined( self.player_proxy_took_damage ) && self.player_proxy_took_damage )
        {
            var_1 = level.player.health * 0.2 / level.player.damagemultiplier;
            level.player _meth_8051( var_1, self.origin, level.player );
        }

        if ( self.customhealth <= 0 && distance( self.saved.return_tag.origin, self.origin ) > 150 )
            thread pdrone_player_death();

        if ( isdefined( var_0 ) && var_0 )
            _pdrone_stop_use_anim();

        thread _pdrone_player_exit_return_control();
    }
}

_make_overlay( var_0, var_1, var_2, var_3 )
{
    var_4 = newclienthudelem( level.player );
    var_4.x = 0;
    var_4.y = 0;

    if ( var_2 )
    {
        var_4.horzalign = "fullscreen";
        var_4.vertalign = "fullscreen";
    }
    else
    {
        var_4.horzalign = "center";
        var_4.vertalign = "middle";
    }

    var_4.sort = var_3;
    var_4 _meth_80CC( var_0, 640, 480 );
    var_4.alpha = var_1;
    return var_4;
}

_setup_overlay_static()
{
    self.overlaystatic = _make_overlay( "overlay_static_digital", 0.0, 1, 0 );
}

_setup_hud()
{
    setomnvar( "ui_assaultdrone_toggle", 1 );
}

_remove_overlay_static()
{
    self.overlaystatic destroy();
}

_remove_hud()
{
    setomnvar( "ui_assaultdrone_toggle", 0 );
}

_remove_hud_on_death()
{
    level waittill( "missionfailed" );

    if ( isdefined( self ) && pdrone_player_is_driving() )
        _remove_hud();
}

_set_overlay_static_alpha( var_0 )
{
    self.overlaystatic.alpha = var_0;
}

_manage_timer( var_0 )
{
    var_1 = var_0;

    for ( var_2 = 0.05; var_1 >= 0; var_1 -= var_2 )
    {
        setomnvar( "ui_assaultdrone_countdown", var_0 - var_1 );
        wait(var_2);
    }

    pdrone_player_force_exit();
}

_do_a_lil_damage_and_heal( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    level.player _meth_8051( 1, var_0.origin, var_0 );
}

_monitor_volume_array()
{
    level.player endon( "drone_exit" );
    var_0 = 1;
    var_1 = common_scripts\utility::spawn_tag_origin();

    for (;;)
    {
        var_1.origin = self.origin;
        var_1.angles = self.angles;
        var_2 = var_1 _meth_80AA( self.data.volume_array );

        if ( !isdefined( var_2 ) || !isarray( var_2 ) || var_2.size == 0 )
        {
            var_3 = 50 * var_0;
            self notify( "damage", var_3 );
            var_0 *= self.losing_connection_multipler;
            setomnvar( "ui_assaultdrone_connection", 0 );
        }
        else
        {
            if ( var_0 > 1 )
            {
                var_0 /= self.losing_connection_multipler;
                var_0 = max( 1, var_0 );
            }

            setomnvar( "ui_assaultdrone_connection", 1 );
        }

        wait 0.25;
    }
}

_monitor_damage()
{
    for (;;)
    {
        self waittill( "damage", var_0, var_1 );
        thread _do_a_lil_damage_and_heal( var_1 );
        self.lastdamageat = gettime();
        self.customhealth -= var_0;

        if ( self.customhealth <= 0 )
        {
            self notify( "custom_death" );
            break;
        }
    }
}

_monitor_regen()
{
    self.disableregen = 0;

    for (;;)
    {
        if ( !self.disableregen && gettime() - self.lastdamageat > 1000 )
            self.customhealth = min( self.customhealth + 10, self.custommaxhealth );

        waitframe();
    }
}

_monitor_static()
{
    self.extra_static = 0;

    for (;;)
    {
        var_0 = 1 - self.customhealth / self.custommaxhealth;
        var_0 *= 0.3;
        var_0 += self.extra_static;
        _set_overlay_static_alpha( var_0 );
        waitframe();
    }
}

_monitor_touch()
{
    for (;;)
    {
        self waittill( "touch", var_0 );

        if ( isai( var_0 ) )
        {
            self notify( "damage", 4000 );

            if ( isdefined( var_0.targetname ) && issubstr( var_0.targetname, "pdrone_player_proxy" ) )
                var_0 _meth_8051( 100, self.origin, level.player );
            else if ( var_0.team != "allies" )
                var_0 _meth_8052();
        }

        waitframe();
    }
}

_bootup_static()
{
    for ( self.extra_static = 0.5; self.extra_static > 0; self.extra_static -= 0.05 )
        wait 0.15;

    self.extra_static = 0;
}

_monitor_health()
{
    self.custommaxhealth = 4000;
    self.customhealth = self.custommaxhealth;
    self.lastdamageat = gettime();
    childthread _monitor_damage();
    childthread _monitor_regen();
    childthread _monitor_static();
    childthread _bootup_static();
    childthread _monitor_touch();

    if ( isdefined( self.data.volumes_targetname ) )
    {
        self.data.volume_array = getentarray( self.data.volumes_targetname, "targetname" );
        childthread _monitor_volume_array();
    }

    self waittill( "custom_death" );
    var_0 = 0.3;

    while ( var_0 <= 1 )
    {
        var_0 += 0.05;
        _set_overlay_static_alpha( var_0 );
        waitframe();
    }

    pdrone_player_force_exit();
}

_monitor_controls()
{
    self endon( "monitor_controls_end" );
    var_0 = spawnstruct();
    self.controlcheck = var_0;
    var_0 maps\_utility::ent_flag_init( "move_done" );
    var_0 maps\_utility::ent_flag_init( "steer_done" );
    var_0 maps\_utility::ent_flag_init( "attack_done" );
    var_0 maps\_utility::ent_flag_init( "ads_done" );
    var_0 maps\_utility::ent_flag_init( "up_done" );
    var_0 maps\_utility::ent_flag_init( "down_done" );

    while ( !var_0 maps\_utility::ent_flag( "move_done" ) || !var_0 maps\_utility::ent_flag( "steer_done" ) || !var_0 maps\_utility::ent_flag( "attack_done" ) || !var_0 maps\_utility::ent_flag( "ads_done" ) || !var_0 maps\_utility::ent_flag( "up_done" ) || !var_0 maps\_utility::ent_flag( "down_done" ) )
    {
        var_1 = level.player _meth_82F3();

        if ( length( var_1 ) > 0.1 )
            var_0 maps\_utility::ent_flag_set( "move_done" );

        var_1 = level.player _meth_830D();

        if ( length( var_1 ) > 0.1 || !level.player _meth_834E() )
            var_0 maps\_utility::ent_flag_set( "steer_done" );

        if ( level.player attackbuttonpressed() )
            var_0 maps\_utility::ent_flag_set( "attack_done" );

        if ( level.player adsbuttonpressed() )
            var_0 maps\_utility::ent_flag_set( "ads_done" );

        if ( level.player _meth_82EE() )
            var_0 maps\_utility::ent_flag_set( "up_done" );

        if ( level.player _meth_82EF() )
            var_0 maps\_utility::ent_flag_set( "down_done" );

        waitframe();
    }
}

_show_contols()
{
    childthread _monitor_controls();
    setomnvar( "ui_assaultdrone_controls", 0 );
    setomnvar( "ui_assaultdrone_controls_exit", 0 );
    wait 1;
    var_0 = self.controlcheck;
    setomnvar( "ui_assaultdrone_controls", 1 );
    var_0 maps\_utility::ent_flag_wait( "move_done" );
    var_0 maps\_utility::ent_flag_wait( "steer_done" );
    setomnvar( "ui_assaultdrone_controls", 0 );
    wait 1;
    setomnvar( "ui_assaultdrone_controls", 2 );
    var_0 maps\_utility::ent_flag_wait( "attack_done" );
    var_0 maps\_utility::ent_flag_wait( "ads_done" );
    setomnvar( "ui_assaultdrone_controls", 0 );
    wait 1;
    setomnvar( "ui_assaultdrone_controls_exit", 1 );
    setomnvar( "ui_assaultdrone_controls", 3 );
    var_0 maps\_utility::ent_flag_wait( "up_done" );
    var_0 maps\_utility::ent_flag_wait( "down_done" );
    setomnvar( "ui_assaultdrone_controls", 0 );
}

pdrone_player_loop()
{
    level.player endon( "drone_exit" );
    level.player endon( "death" );
    childthread _monitor_health();
    childthread _show_contols();

    if ( isdefined( self.time ) && self.time > 0 )
        childthread _manage_timer( self.time );

    for (;;)
    {
        self.maxhealth = 500000;
        self.health = self.maxhealth;
        waitframe();
    }
}

pdrone_player_get_current_fov()
{
    return self.data.current_fov;
}

pdrone_player_force_exit()
{
    if ( !isdefined( self.is_pdrone ) )
        return;

    level.player notify( "drone_exit" );
}

pdrone_player_add_vehicle_target( var_0, var_1 )
{
    if ( !isdefined( self.vehicle_targets ) )
        self.vehicle_targets = [];

    self.vehicle_targets[var_0] = var_1;
}

pdrone_player_add_ent_target( var_0, var_1 )
{
    if ( !isdefined( self.ent_targets ) )
        self.ent_targets = [];

    self.ent_targets[var_0] = var_1;
}

_listen_for_hold_to_exit_set_flags( var_0 )
{
    for (;;)
    {
        level.player waittill( "hold_to_exit_start" );
        var_0 maps\_utility::ent_flag_set( "exit_button_pressed" );
        level.player waittill( "hold_to_exit_stop" );
        var_0 maps\_utility::ent_flag_clear( "exit_button_pressed" );
    }
}

_listen_for_hold_to_exit()
{
    var_0 = spawnstruct();
    var_0 maps\_utility::ent_flag_init( "exit_button_pressed" );
    childthread _listen_for_hold_to_exit_set_flags( var_0 );

    for (;;)
    {
        var_0 maps\_utility::ent_flag_wait( "exit_button_pressed" );

        for ( var_1 = 0; var_0 maps\_utility::ent_flag( "exit_button_pressed" ); var_1 += 0.05 )
        {
            if ( var_1 >= 1.0 || !level.player _meth_834E() )
            {
                level.player notify( "drone_exit" );
                break;
            }

            waitframe();
        }
    }
}

_listen_drone_input()
{
    level.player _meth_82DD( "weapon_fired", "+attack" );

    if ( isdefined( self.data.player_command_for_exit ) )
    {
        wait 2;
        level.player _meth_82DD( "hold_to_exit_start", "+" + self.data.player_command_for_exit );
        level.player _meth_82DD( "hold_to_exit_stop", "-" + self.data.player_command_for_exit );
        childthread _listen_for_hold_to_exit();
    }
}

_remove_drone_control()
{
    if ( isdefined( self.data.player_command_for_exit ) )
    {
        _func_28B( "hold_to_exit_start", "+" + self.data.player_command_for_exit );
        _func_28B( "hold_to_exit_stop", "-" + self.data.player_command_for_exit );
    }
}
