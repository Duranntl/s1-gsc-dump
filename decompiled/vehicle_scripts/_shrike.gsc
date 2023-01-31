// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "shrike", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_airplane_shrike" );
    level._effect["engineeffect"] = loadfx( "vfx/trail/jet_thruster_far" );
    level._effect["afterburner"] = loadfx( "vfx/fire/jet_afterburner_ignite" );
    level._effect["contrail"] = loadfx( "vfx/trail/jet_contrail" );
    maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_generic_ai_explo_lrg_runner", undefined, "explo_metal_rand", undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_rumble( "mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05 );
    maps\_vehicle::build_team( "allies" );
}

init_local()
{
    thread playengineeffects();
    thread handle_death();
}

playengineeffects()
{
    self endon( "death" );
    self endon( "stop_engineeffects" );
    maps\_utility::ent_flag_init( "engineeffects" );
    maps\_utility::ent_flag_set( "engineeffects" );
    var_0 = common_scripts\utility::getfx( "engineeffect" );

    for (;;)
    {
        maps\_utility::ent_flag_wait( "engineeffects" );
        playfxontag( var_0, self, "tag_engine_right" );
        playfxontag( var_0, self, "tag_engine_left" );
        maps\_utility::ent_flag_waitopen( "engineeffects" );
        stopfxontag( var_0, self, "tag_engine_left" );
        stopfxontag( var_0, self, "tag_engine_right" );
    }
}

playafterburner()
{
    self endon( "death" );
    self endon( "stop_afterburners" );
    maps\_utility::ent_flag_init( "afterburners" );
    maps\_utility::ent_flag_set( "afterburners" );
    var_0 = common_scripts\utility::getfx( "afterburner" );

    for (;;)
    {
        maps\_utility::ent_flag_wait( "afterburners" );
        playfxontag( var_0, self, "tag_engine_right" );
        playfxontag( var_0, self, "tag_engine_left" );
        maps\_utility::ent_flag_waitopen( "afterburners" );
        stopfxontag( var_0, self, "tag_engine_left" );
        stopfxontag( var_0, self, "tag_engine_right" );
    }
}

handle_death()
{
    self waittill( "death" );

    if ( isdefined( self.tag1 ) )
        self.tag1 delete();

    if ( isdefined( self.tag2 ) )
        self.tag2 delete();
}

playcontrail()
{
    self.tag1 = add_contrail( "tag_engine_right", 1 );
    self.tag2 = add_contrail( "tag_engine_left", -1 );
    var_0 = common_scripts\utility::getfx( "contrail" );
    self endon( "death" );
    self endon( "stop_contrails" );
    maps\_utility::ent_flag_init( "contrails" );
    maps\_utility::ent_flag_set( "contrails" );

    for (;;)
    {
        maps\_utility::ent_flag_wait( "contrails" );
        playfxontag( var_0, self.tag1, "tag_origin" );
        playfxontag( var_0, self.tag2, "tag_origin" );
        maps\_utility::ent_flag_waitopen( "contrails" );
        stopfxontag( var_0, self.tag1, "tag_origin" );
        stopfxontag( var_0, self.tag2, "tag_origin" );
    }
}

add_contrail( var_0, var_1 )
{
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = self gettagorigin( var_0 );
    var_2.angles = self gettagangles( var_0 );
    var_3 = spawnstruct();
    var_3.entity = var_2;
    var_3.forward = -156;
    var_3.up = 0;
    var_3.right = 224 * var_1;
    var_3.yaw = 0;
    var_3.pitch = 0;
    var_3 maps\_utility::translate_local();
    var_2 _meth_804D( self, var_0 );
    return var_2;
}

playerisclose( var_0 )
{
    var_1 = playerisinfront( var_0 );

    if ( var_1 )
        var_2 = 1;
    else
        var_2 = -1;

    var_3 = common_scripts\utility::flat_origin( var_0.origin );
    var_4 = var_3 + anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) ) * ( var_2 * 100000 );
    var_5 = pointonsegmentnearesttopoint( var_3, var_4, level.player.origin );
    var_6 = distance( var_3, var_5 );

    if ( var_6 < 3000 )
        return 1;
    else
        return 0;
}

playerisinfront( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) );
    var_2 = vectornormalize( common_scripts\utility::flat_origin( level.player.origin ) - var_0.origin );
    var_3 = vectordot( var_1, var_2 );

    if ( var_3 > 0 )
        return 1;
    else
        return 0;
}

plane_sound_node()
{
    self waittill( "trigger", var_0 );
    var_0 endon( "death" );
    thread plane_sound_node();
    var_0 thread common_scripts\utility::play_loop_sound_on_entity( "veh_f15_dist_loop" );

    while ( playerisinfront( var_0 ) )
        wait 0.05;

    wait 0.5;

    if ( isdefined( var_0 ) )
    {
        var_0 thread common_scripts\utility::play_sound_in_space( "veh_f15_sonic_boom" );
        var_0 waittill( "reached_end_node" );
        var_0 stop_sound( "veh_f15_dist_loop" );
        var_0 delete();
    }
}

stop_sound( var_0 )
{
    self notify( "stop sound" + var_0 );
}
