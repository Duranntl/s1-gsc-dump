// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

is_using_model_memory_sharing()
{
    return !maps\_utility::is_gen4();
}

main( var_0, var_1, var_2 )
{
    var_3 = 0;

    if ( issubstr( var_2, "_stealth" ) )
    {
        var_3 = 1;

        if ( issubstr( var_2, "_stealth_col" ) )
            precachemodel( "vehicle_xh9_warbird_cloaked_mp" );
    }

    if ( issubstr( var_2, "_stealth_low" ) )
    {
        level.cloak_new = 1;
        precachemodel( "vehicle_xh9_warbird_low_cloak" );
    }

    if ( issubstr( var_2, "_atlas_desert" ) )
        precachemodel( "vehicle_xh9_warbird_desert" );

    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = issubstr( var_2, "_no_treadfx" );

    if ( issubstr( var_2, "_no_turret" ) )
        var_4 = 1;
    else if ( issubstr( var_2, "_heavy_turret" ) )
    {
        var_6 = 1;
        precacheturret( "warbird_heavy_turret" );
    }
    else if ( issubstr( var_2, "_usarmy_turret" ) )
    {
        var_7 = 1;
        precacheturret( "warbird_side_turret_usarmy_sp" );
    }
    else if ( issubstr( var_2, "_side_turret" ) )
    {
        var_8 = 1;
        precacheturret( "warbird_side_turret_sp" );
    }
    else if ( issubstr( var_2, "_cheap" ) )
    {
        var_9 = 1;
        var_4 = 1;
    }

    if ( issubstr( var_2, "_no_cloak" ) )
        var_5 = 1;

    if ( issubstr( var_2, "_no_zipline" ) )
        var_10 = 1;

    if ( !var_9 )
    {
        if ( !var_10 )
        {
            precachemodel( "npc_zipline_gun_left" );
            precachemodel( "npc_zipline_rope_left" );
            precachemodel( "npc_zipline_gun_right" );
            precachemodel( "npc_zipline_rope_right" );
            precachemodel( "npc_optics_zipline_gun" );
            precacheturret( "zipline_gun" );
            precacheturret( "zipline_gun_rope" );
        }

        maps\_utility::set_console_status();

        if ( !var_5 )
        {
            if ( is_using_model_memory_sharing() )
            {
                precachemodel( "vehicle_xh9_warbird_cloaked_transparent" );
                precachemodel( "vehicle_xh9_warbird_decloaking_masked" );
            }
            else
                precachemodel( "vehicle_xh9_warbird_cloaked_in_out" );
        }

        if ( var_3 )
        {
            precachemodel( "vehicle_xh9_warbird_turret_left_stealth" );
            precachemodel( "vehicle_xh9_warbird_turret_right_stealth" );
        }
        else
        {
            precachemodel( "vehicle_xh9_warbird_turret_left" );
            precachemodel( "vehicle_xh9_warbird_turret_right" );
        }
    }

    maps\_vehicle::build_template( "xh9_warbird", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );

    if ( !var_9 )
        maps\_vehicle::build_deathmodel( "vehicle_xh9_warbird" );

    if ( !var_11 )
        maps\_vehicle::build_treadfx();

    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_unload_groups( ::unload_groups );
    maps\_vehicle::build_bulletshield( 1 );

    if ( !var_4 )
    {
        if ( var_3 )
        {
            maps\_vehicle::build_turret( "warbird_turret", "tag_turret_left", "vehicle_xh9_warbird_turret_left_stealth", undefined, "manual", undefined, 0, 0, undefined );
            maps\_vehicle::build_turret( "warbird_turret", "tag_turret_right", "vehicle_xh9_warbird_turret_right_stealth", undefined, "manual", undefined, 0, 0, undefined );
        }
        else if ( var_6 )
        {
            maps\_vehicle::build_turret( "warbird_heavy_turret", "tag_turret_left", "vehicle_xh9_warbird_turret_left", undefined, "manual", undefined, 0, 0, undefined );
            maps\_vehicle::build_turret( "warbird_heavy_turret", "tag_turret_right", "vehicle_xh9_warbird_turret_right", undefined, "manual", undefined, 0, 0, undefined );
        }
        else if ( var_7 )
            maps\_vehicle::build_turret( "warbird_side_turret_usarmy_sp", "tag_turret_zipline_fl", "npc_zipline_gun_right", undefined, "manual", undefined, 0, 0, ( 12, 0, -16 ) );
        else if ( var_8 )
            maps\_vehicle::build_turret( "warbird_side_turret_sp", "tag_turret_zipline_fl", "npc_zipline_gun_right", undefined, "manual", undefined, 0, 0, undefined );
        else
        {
            maps\_vehicle::build_turret( "warbird_turret", "tag_turret_left", "vehicle_xh9_warbird_turret_left", undefined, "manual", undefined, 0, 0, undefined );
            maps\_vehicle::build_turret( "warbird_turret", "tag_turret_right", "vehicle_xh9_warbird_turret_right", undefined, "manual", undefined, 0, 0, undefined );
        }
    }

    var_12 = randomfloatrange( 0, 1 );

    if ( !var_9 )
        maps\_vehicle::build_deathfx( "vfx/explosion/vehicle_warbird_explosion_midair", "tag_origin", "sfb_warbird_death_explo", undefined, undefined, undefined, -1, 1 );

    if ( !issubstr( var_2, "_stealth_col" ) )
    {
        maps\_vehicle::build_light( var_2, "white_blink_tail", "tag_light_tail", "vfx/lights/light_wingtip_red_med_point", "running", var_12 );
        maps\_vehicle::build_light( var_2, "wingtip_red_body_r", "TAG_light_body_R", "vfx/lights/light_wingtip_red_med_point", "running", var_12 );
        maps\_vehicle::build_light( var_2, "wingtip_red_body_l", "TAG_light_body_L", "vfx/lights/light_wingtip_red_med_point", "running", var_12 );
        maps\_vehicle::build_light( var_2, "wingtip_red_body_r", "TAG_light_R_wing", "vfx/lights/light_wingtip_red_med_point", "running", var_12 );
        maps\_vehicle::build_light( var_2, "wingtip_red_body_l", "TAG_light_L_wing", "vfx/lights/light_wingtip_red_med_point", "running", var_12 );
        maps\_vehicle::build_light( var_2, "headlight_L", "TAG_light_front_R", "vfx/lights/headlight_gaz", "headlights", 0.0 );
        maps\_vehicle::build_light( var_2, "headlight_R", "TAG_light_front_L", "vfx/lights/headlight_gaz", "headlights", 0.0 );
    }

    maps\_vehicle::build_is_helicopter();

    if ( !var_9 && !var_10 )
        load_script_model_anims();
}

#using_animtree("script_model");

load_script_model_anims()
{
    level.scr_animtree["_zipline_gun_fl"] = #animtree;
    level.scr_model["_zipline_gun_fl"] = "npc_zipline_gun_right";
    level.scr_anim["_zipline_gun_fl"]["folded_idle"] = %fastzip_launcher_folded_idle_right;
    level.scr_anim["_zipline_gun_fl"]["rest_idle"] = %fastzip_launcher_rest_idle_right;
    level.scr_anim["_zipline_gun_fl"]["readyup"] = %fastzip_launcher_readyup_right;
    level.scr_anim["_zipline_gun_fl"]["jumpout"] = %fastzip_launcher_jumpout_right;
    level.scr_anim["_zipline_gun_fl"]["fastzip_pullout"] = %fastzip_launcher_pullout;
    level.scr_anim["_zipline_gun_fl"]["fastzip_putaway"] = %fastzip_launcher_putaway;
    level.scr_anim["_zipline_gun_fl"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_right;
    level.scr_anim["_zipline_gun_fl"]["fastzip_fire"] = %fastzip_launcher_fire_right_npc;
    level.scr_anim["_zipline_gun_fl"]["fastzip_slide"] = %fastzip_launcher_slidedown_right_npc;
    level.scr_anim["_zipline_gun_fl"]["retract_rope"] = %fastzip_launcher_retract_right;
    level.scr_animtree["_zipline_gun_fr"] = #animtree;
    level.scr_model["_zipline_gun_fr"] = "npc_zipline_gun_left";
    level.scr_anim["_zipline_gun_fr"]["folded_idle"] = %fastzip_launcher_folded_idle_left;
    level.scr_anim["_zipline_gun_fr"]["rest_idle"] = %fastzip_launcher_rest_idle_left;
    level.scr_anim["_zipline_gun_fr"]["readyup"] = %fastzip_launcher_readyup_left;
    level.scr_anim["_zipline_gun_fr"]["jumpout"] = %fastzip_launcher_jumpout_left;
    level.scr_anim["_zipline_gun_fr"]["fastzip_pullout"] = %fastzip_launcher_pullout;
    level.scr_anim["_zipline_gun_fr"]["fastzip_putaway"] = %fastzip_launcher_putaway;
    level.scr_anim["_zipline_gun_fr"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_left;
    level.scr_anim["_zipline_gun_fr"]["fastzip_fire"] = %fastzip_launcher_fire_left_npc;
    level.scr_anim["_zipline_gun_fr"]["fastzip_slide"] = %fastzip_launcher_slidedown_left_npc;
    level.scr_anim["_zipline_gun_fr"]["retract_rope"] = %fastzip_launcher_retract_left;
    level.scr_animtree["_zipline_gun_kl"] = #animtree;
    level.scr_model["_zipline_gun_kl"] = "npc_zipline_gun_left";
    level.scr_anim["_zipline_gun_kl"]["folded_idle"] = %fastzip_launcher_folded_idle_left;
    level.scr_anim["_zipline_gun_kl"]["rest_idle"] = %fastzip_launcher_rest_idle_left;
    level.scr_anim["_zipline_gun_kl"]["readyup"] = %fastzip_launcher_readyup_left;
    level.scr_anim["_zipline_gun_kl"]["jumpout"] = %fastzip_launcher_jumpout_left;
    level.scr_anim["_zipline_gun_kl"]["fastzip_pullout"] = %fastzip_launcher_pullout;
    level.scr_anim["_zipline_gun_kl"]["fastzip_putaway"] = %fastzip_launcher_putaway;
    level.scr_anim["_zipline_gun_kl"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_left;
    level.scr_anim["_zipline_gun_kl"]["fastzip_fire"] = %fastzip_launcher_fire_left_npc;
    level.scr_anim["_zipline_gun_kl"]["fastzip_slide"] = %fastzip_launcher_slidedown_left_npc;
    level.scr_anim["_zipline_gun_kl"]["retract_rope"] = %fastzip_launcher_retract_left;
    level.scr_animtree["_zipline_gun_kr"] = #animtree;
    level.scr_model["_zipline_gun_kr"] = "npc_zipline_gun_right";
    level.scr_anim["_zipline_gun_kr"]["folded_idle"] = %fastzip_launcher_folded_idle_right;
    level.scr_anim["_zipline_gun_kr"]["rest_idle"] = %fastzip_launcher_rest_idle_right;
    level.scr_anim["_zipline_gun_kr"]["readyup"] = %fastzip_launcher_readyup_right;
    level.scr_anim["_zipline_gun_kr"]["jumpout"] = %fastzip_launcher_jumpout_right;
    level.scr_anim["_zipline_gun_kr"]["fastzip_pullout"] = %fastzip_launcher_pullout;
    level.scr_anim["_zipline_gun_kr"]["fastzip_putaway"] = %fastzip_launcher_putaway;
    level.scr_anim["_zipline_gun_kr"]["fastzip_aim_idle"] = %fastzip_launcher_aim_level_right;
    level.scr_anim["_zipline_gun_kr"]["fastzip_fire"] = %fastzip_launcher_fire_right_npc;
    level.scr_anim["_zipline_gun_kr"]["fastzip_slide"] = %fastzip_launcher_slidedown_right_npc;
    level.scr_anim["_zipline_gun_kr"]["retract_rope"] = %fastzip_launcher_retract_right;
}

init_local()
{
    self.script_badplace = 0;
    maps\_utility::ent_flag_init( "left_door_open" );
    maps\_utility::ent_flag_init( "right_door_open" );
    waittillframeend;

    if ( issubstr( self.classname, "_no_turret" ) && !issubstr( self.classname, "cheap" ) )
    {
        if ( issubstr( self.classname, "_stealth" ) )
        {
            thread spawn_turret_model( "tag_turret_left", "vehicle_xh9_warbird_turret_left_stealth" );
            thread spawn_turret_model( "tag_turret_right", "vehicle_xh9_warbird_turret_right_stealth" );
        }
        else
        {
            thread spawn_turret_model( "tag_turret_left", "vehicle_xh9_warbird_turret_left" );
            thread spawn_turret_model( "tag_turret_right", "vehicle_xh9_warbird_turret_right" );
        }
    }

    thread handle_rotors();

    if ( !issubstr( self.classname, "_no_zipline" ) && !issubstr( self.classname, "cheap" ) )
    {
        thread spawn_script_model_turret( "_zipline_gun_fl", "tag_turret_zipline_fl", "TAG_GUNNER_FL", "npc_zipline_rope_right" );
        thread spawn_script_model_turret( "_zipline_gun_fr", "tag_turret_zipline_fr", "TAG_GUNNER_FR", "npc_zipline_rope_left" );
        thread spawn_script_model_turret( "_zipline_gun_kl", "tag_turret_zipline_kl", "TAG_GUNNER_KL", "npc_zipline_rope_left", "npc_optics_zipline_gun" );
        thread spawn_script_model_turret( "_zipline_gun_kr", "tag_turret_zipline_kr", "TAG_GUNNER_KR", "npc_zipline_rope_right" );
    }

    self.emp_death_function = ::warbird_emp_death;
    maps\_utility::add_damage_function( ::warbird_emp_damage_function );
}

spawn_turret_model( var_0, var_1 )
{
    var_2 = spawn( "script_model", ( 0, 0, 0 ) );
    var_2 _meth_80B1( var_1 );
    var_2 _meth_804D( self, var_0, ( 0, 0, 14 ), ( -8, 0, 0 ) );

    if ( !isdefined( self.turret_models ) )
        self.turret_models = [];

    self.turret_models[var_0] = var_2;
    self waittill( "death" );
    var_2 delete();
}

show_blurry_rotors()
{
    self.blurry_rotors_on = 1;
    self _meth_8048( "TAG_STATIC_MAIN_ROTOR_L" );
    self _meth_8048( "TAG_STATIC_MAIN_ROTOR_R" );
    self _meth_8048( "TAG_STATIC_TAIL_ROTOR" );
    self _meth_804B( "TAG_SPIN_MAIN_ROTOR_L" );
    self _meth_804B( "TAG_SPIN_MAIN_ROTOR_R" );
    self _meth_804B( "TAG_SPIN_TAIL_ROTOR" );
}

#using_animtree("vehicles");

handle_rotors()
{
    self endon( "death" );
    self endon( "stop_handle_rotors" );
    show_blurry_rotors();

    if ( isdefined( self.no_anim_rotors ) && self.no_anim_rotors )
        return;

    self _meth_814B( %warbird_rotors_spin, 1, 0.2, 1 );
    var_0 = 0;
    var_1 = 0;

    for (;;)
    {
        var_2 = self _meth_8287();
        var_3 = anglestoforward( self.angles );
        var_4 = vectordot( var_2, var_3 );

        if ( var_4 > 0 )
        {
            var_1 = var_4 / 3000;
            var_1 = min( var_1, 1 );
        }
        else if ( var_4 < 0 )
        {
            var_1 = var_4 / 1000;
            var_1 = max( var_1, -1 );
        }
        else
            var_1 = 0;

        if ( var_0 < var_1 )
        {
            var_0 += 0.1;
            var_0 = min( var_0, var_1 );
        }
        else if ( var_0 > var_1 )
        {
            var_0 -= 0.1;
            var_0 = max( var_0, var_1 );
        }

        if ( var_0 > 0 )
        {
            self _meth_8143( %warbird_rotors_forward, 1, 0.2, 0 );
            self _meth_8117( %warbird_rotors_forward, var_0 );
            self _meth_814B( %rotors_tilt, 1, 0.2, 1 );
        }
        else if ( var_0 < 0 )
        {
            self _meth_8143( %warbird_rotors_backward, 1, 0.2, 0 );
            self _meth_8117( %warbird_rotors_backward, var_0 * -1 );
            self _meth_814B( %rotors_tilt, 1, 0.2, 1 );
        }
        else
            self _meth_8142( %rotors_tilt, 0.2 );

        wait 0.1;
    }
}

open_doors_for_unload( var_0 )
{
    var_1 = self gettagangles( var_0 );
    var_2 = anglestoforward( var_1 );
    var_3 = anglestoright( self.angles );
    var_4 = vectordot( var_3, var_2 );

    if ( var_4 > 0 )
    {
        if ( !maps\_utility::ent_flag( "right_door_open" ) )
            thread open_right_door();
    }
    else if ( !maps\_utility::ent_flag( "left_door_open" ) )
        thread open_left_door();
}

open_right_door()
{
    if ( !isdefined( self.right_door_anim ) || self.right_door_anim != "opening" )
    {
        self.right_door_anim = "opening";
        self _meth_814B( %warbird_doors, 1, 0.2, 1 );
        self _meth_814B( %warbird_door_r_open, 1, 0.2, 1 );
        var_0 = getanimlength( %warbird_door_r_open );
        wait(var_0);
        maps\_utility::ent_flag_set( "right_door_open" );
    }
}

open_left_door()
{
    if ( !isdefined( self.left_door_anim ) || self.left_door_anim != "opening" )
    {
        self.left_door_anim = "opening";
        self _meth_814B( %warbird_doors, 1, 0.2, 1 );
        self _meth_814B( %warbird_door_l_open, 1, 0.2, 1 );
        var_0 = getanimlength( %warbird_door_l_open );
        wait(var_0);
        maps\_utility::ent_flag_set( "left_door_open" );
    }
}

copy_animation_to_model( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0 _meth_83BF( self );
}

copy_animation_to_cloak_models()
{
    copy_animation_to_model( self.cloaked_model );
    copy_animation_to_model( self.decloaking_model );
}

handle_cloak_models_animation()
{
    self endon( "death" );
    self endon( "stop_cloaked_models_animation" );

    for (;;)
    {
        copy_animation_to_cloak_models();
        wait 0.05;
    }
}

spawn_script_model_turret( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = maps\_utility::spawn_anim_model( var_0 );

    if ( isdefined( var_3 ) )
    {
        var_5 attach( var_3 );
        var_5.rope_model = var_3;
    }

    if ( isdefined( var_4 ) )
    {
        var_6 = spawn( "script_model", ( 0, 0, 0 ) );
        var_6 _meth_80B1( "npc_optics_zipline_gun" );
        var_6 _meth_804D( var_5, "TAG_DE_TECH", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_5.attachment = var_6;
    }

    var_5 _meth_804D( self, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_5 _meth_814B( level.scr_anim[var_0]["folded_idle"], 1, 0, 1 );

    if ( !isdefined( self.zipline_gun_model ) )
        self.zipline_gun_model = [];

    self.zipline_gun_model[var_1] = var_5;
    self.zipline_gunner_tag[var_1] = var_2;
    self waittill( "death" );

    if ( isdefined( var_5.attachment ) )
        var_5.attachment delete();

    var_5 delete();
}

set_vehicle_anims( var_0 )
{
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 6; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].idle = %helicopter_pilot1_idle;
    var_0[1].idle = %helicopter_pilot1_idle;
    var_0[2].idle = %helicopter_pilot1_idle;
    var_0[3].idle = %helicopter_pilot1_idle;
    var_0[4].idle = %helicopter_pilot1_idle;
    var_0[5].idle = %helicopter_pilot1_idle;
    var_0[0].sittag = "TAG_DRIVER";
    var_0[1].sittag = "TAG_GUY0";
    var_0[2].sittag = "TAG_GUY2";
    var_0[3].sittag = "TAG_GUY3";
    var_0[4].sittag = "TAG_GUY5";
    var_0[5].sittag = "TAG_PASSENGER";
    var_0[1].bnoanimunload = 1;
    var_0[2].bnoanimunload = 1;
    var_0[3].bnoanimunload = 1;
    var_0[4].bnoanimunload = 1;
    var_0[1].rider_func = ::setup_fastzip_unload;
    var_0[2].rider_func = ::setup_fastzip_unload;
    var_0[3].rider_func = ::setup_fastzip_unload;
    var_0[4].rider_func = ::setup_fastzip_unload;
    var_0[1].death_flop_dir = ( 0, 2500, 0 );
    var_0[2].death_flop_dir = ( 0, 2500, 0 );
    var_0[3].death_flop_dir = ( 0, -2500, 0 );
    var_0[4].death_flop_dir = ( 0, -2500, 0 );
    var_0[5].death_flop_dir = ( 0, -2500, 0 );
    return var_0;
}

unload_groups()
{
    var_0 = [];
    var_0["default"] = [];
    var_0["default"][var_0["default"].size] = 1;
    var_0["default"][var_0["default"].size] = 2;
    var_0["default"][var_0["default"].size] = 3;
    var_0["default"][var_0["default"].size] = 4;
    return var_0;
}

#using_animtree("vehicles");

show_attached_clone_model( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_0 = spawn( "script_model", self getorigin() );
        var_0 _meth_80B1( var_1 );
        var_0 _meth_8115( #animtree );
    }

    var_0 _meth_804D( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    copy_animation_to_cloak_models();
    var_0 show();
    return var_0;
}

show_cloaked_warbird()
{
    self.cloaked_model = show_attached_clone_model( self.cloaked_model, "vehicle_xh9_warbird_cloaked_transparent" );
}

show_decloaking_warbird()
{
    self.decloaking_model = show_attached_clone_model( self.decloaking_model, "vehicle_xh9_warbird_decloaking_masked" );
}

cloak_warbird()
{
    if ( is_using_model_memory_sharing() )
    {
        self hide();
        show_cloaked_warbird();
        thread handle_cloak_models_animation();
    }
    else if ( isdefined( level.cloak_new ) && level.cloak_new )
    {
        self.uncloak_model = self.model;
        self _meth_80B1( "vehicle_xh9_warbird_low_cloak" );
    }
    else
    {
        self.uncloak_model = self.model;
        self _meth_80B1( "vehicle_xh9_warbird_cloaked_in_out" );

        if ( issubstr( self.classname, "_stealth_col" ) )
        {
            wait 0.25;
            self _meth_80B1( "vehicle_xh9_warbird_cloaked_mp" );
        }
    }

    if ( isdefined( self.blurry_rotors_on ) && self.blurry_rotors_on )
        show_blurry_rotors();

    waittillframeend;
    waittillframeend;
    set_cloak_parameter( 0.0, 0.0 );

    if ( isdefined( self.zipline_gun_model ) )
    {
        foreach ( var_1 in self.zipline_gun_model )
            var_1 hide();
    }

    if ( isdefined( self.turret_models ) )
    {
        foreach ( var_4 in self.turret_models )
            var_4 hide();
    }

    if ( isdefined( self.mgturret ) )
    {
        foreach ( var_7 in self.mgturret )
            var_7 hide();
    }
}

set_cloak_parameter( var_0, var_1 )
{
    if ( isdefined( self.uncloak_model ) )
        self _meth_83A7( var_0, var_1 );

    if ( isdefined( self.cloaked_model ) )
        self.cloaked_model _meth_83A7( var_0, var_1 );

    if ( isdefined( self.decloaking_model ) )
        self.decloaking_model _meth_83A7( var_0, var_1 );
}

setmodel_warbird( var_0 )
{
    self endon( "death" );
    wait(var_0);

    if ( is_using_model_memory_sharing() )
    {
        self show();

        if ( isdefined( self.cloaked_model ) )
            self.cloaked_model hide();

        if ( isdefined( self.decloaking_model ) )
            self.decloaking_model hide();

        self notify( "stop_cloaked_models_animation" );
    }
    else if ( isdefined( self.uncloak_model ) )
        self _meth_80B1( self.uncloak_model );

    maps\_vehicle::vehicle_lights_on( "running" );
    show_blurry_rotors();
}

uncloak_warbird( var_0 )
{
    var_1 = 8.3;

    if ( isdefined( var_0 ) )
        var_1 = var_0;

    if ( issubstr( self.classname, "_stealth_col" ) && !is_using_model_memory_sharing() )
        self _meth_80B1( "vehicle_xh9_warbird_cloaked_in_out" );

    if ( is_using_model_memory_sharing() )
    {
        show_decloaking_warbird();
        thread setmodel_warbird( var_1 );
    }
    else if ( isdefined( self.uncloak_model ) )
        thread setmodel_warbird( var_1 );

    set_cloak_parameter( 1.0, var_1 );
    wait(var_1);

    if ( isdefined( self.blurry_rotors_on ) && self.blurry_rotors_on )
        show_blurry_rotors();

    if ( isdefined( self.zipline_gun_model ) )
    {
        foreach ( var_3 in self.zipline_gun_model )
            var_3 show();
    }

    if ( isdefined( self.turret_models ) )
    {
        foreach ( var_6 in self.turret_models )
            var_6 show();
    }

    if ( isdefined( self.mgturret ) )
    {
        foreach ( var_9 in self.mgturret )
            var_9 show();
    }
}

warbird_emp_damage_function( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_4 == "MOD_ENERGY" && isdefined( self.emp_death_function ) )
    {
        if ( !isdefined( self.emp_hits ) || self.emp_hits < 1 )
            self.emp_hits = 1;
        else
            self thread [[ self.emp_death_function ]]( var_1, var_4 );
    }
}

warbird_emp_death( var_0, var_1 )
{
    self endon( "death" );
    self endon( "in_air_explosion" );
    self notify( "emp_death" );
    soundscripts\_snd::snd_message( "warbird_emp_death" );
    maps\_vehicle::vehicle_lights_off( "all" );
    self.emp_crash = 1;
    self.vehicle_stays_alive = 1;
    var_2 = self _meth_8287();
    var_3 = 250;

    if ( isdefined( level.get_warbird_crash_location_override ) )
        var_4 = [[ level.get_warbird_crash_location_override ]]();
    else
    {
        var_5 = ( self.origin[0] + var_2[0] * 5, self.origin[1] + var_2[1] * 5, self.origin[2] - 2000 );
        var_4 = physicstrace( self.origin + vectornormalize( var_5 - self.origin ) * 100, var_5 );
    }

    self notify( "newpath" );
    self notify( "deathspin" );
    thread warbird_deathspin();
    var_6 = 1000;
    self _meth_8283( var_6, 40, 1000 );
    self _meth_825A( var_3 );
    self _meth_825B( var_4, 0 );
    thread warbird_emp_crash_movement( var_4, var_3, var_6 );
    common_scripts\utility::waittill_any( "goal", "near_goal" );
    self notify( "stop_crash_loop_sound" );
    self notify( "crash_done" );
    maps\_vehicle_code::vehicle_kill_common( var_0, var_1 );
    self notify( "death_finished" );
    wait 0.05;
    thread kill_and_delete( var_0 );
}

kill_and_delete( var_0 )
{
    self _meth_8052( self.origin, var_0 );
    self delete();
}

#using_animtree("script_model");

warbird_deathspin()
{
    level.scr_animtree["warbird_dummy"] = #animtree;
    level.scr_anim["warbird_dummy"]["roll_left"][0] = %rotate_x_l;
    level.scr_anim["warbird_dummy"]["roll_right"][0] = %rotate_x_r;
    var_0 = spawn( "script_model", self.origin );
    var_0.angles = self.angles;
    var_0 _meth_804D( self );

    if ( isdefined( self.death_model_override ) )
        var_0 _meth_80B1( self.death_model_override );
    else
        var_0 _meth_80B1( self.model );

    var_0 endon( "death" );
    self hide();
    soundscripts\_snd::snd_message( "warbird_emp_death" );
    var_0.animname = "warbird_dummy";
    var_0 maps\_utility::assign_animtree();

    if ( common_scripts\utility::cointoss() )
        var_1 = "roll_left";
    else
        var_1 = "roll_right";

    var_0 thread maps\_anim::anim_loop_solo( var_0, var_1 );
    thread common_scripts\utility::delete_on_death( var_0 );
    var_2 = 0;
    var_3 = 0.4;
    var_4 = 0.01;
    var_5 = 0.05;

    while ( var_2 < var_3 )
    {
        var_0 _meth_83C7( level.scr_anim[var_0.animname][var_1][0], var_2 );
        var_2 += var_4;
        wait 0.05;
    }
}

warbird_emp_crash_movement( var_0, var_1, var_2 )
{
    self endon( "crash_done" );
    self _meth_8266();
    self _meth_8292( 400, 100, 100 );
    var_3 = 400;
    var_4 = 100;
    var_5 = undefined;
    var_6 = 90 * randomintrange( -2, 3 );

    for (;;)
    {
        if ( self.origin[2] < var_0[2] + var_1 )
            self notify( "near_goal" );

        wait 0.05;
    }
}

setup_fastzip_unload()
{
    self.customunloadfunc = ::fastzip_unload;
    self.ridingvehicle thread maps\_vehicle_aianim::guy_idle( self, self.vehicle_position );
    thread guy_death_inside_warbird();
}

#using_animtree("generic_human");

setup_fastzip_anims( var_0 )
{
    if ( var_0 == "tag_turret_zipline_fl" || var_0 == "tag_turret_zipline_kr" )
    {
        var_1 = "zipline_guy_right";
        self.zipline_animname = var_1;
        level.scr_anim[var_1]["rest_idle"] = %zipline_right_rest;
        level.scr_anim[var_1]["readyup"] = %zipline_right_readyup;
        level.scr_anim[var_1]["jumpout"] = %zipline_right_jumpedout;
        level.scr_anim[var_1]["fire"] = %zipline_right_fire;
        level.scr_anim[var_1]["slide_idle_a"][0] = %zipline_right_slidedown_guy_a;
        level.scr_anim[var_1]["slide_idle_b"][0] = %zipline_right_slidedown_guy_b;
        level.scr_anim[var_1]["zipline_right_land_guy_a"] = %zipline_right_land_guy_a;
        level.scr_anim[var_1]["zipline_right_land_guy_b"] = %zipline_right_land_guy_b;
    }
    else
    {
        var_1 = "zipline_guy_left";
        self.zipline_animname = var_1;
        level.scr_anim[var_1]["rest_idle"] = %zipline_left_rest;
        level.scr_anim[var_1]["readyup"] = %zipline_left_readyup;
        level.scr_anim[var_1]["jumpout"] = %zipline_left_jumpedout;
        level.scr_anim[var_1]["fire"] = %zipline_left_fire;
        level.scr_anim[var_1]["slide_idle_a"][0] = %zipline_left_slidedown_guy_a;
        level.scr_anim[var_1]["slide_idle_b"][0] = %zipline_left_slidedown_guy_b;
        level.scr_anim[var_1]["zipline_left_landing_guy_a"] = %zipline_left_landing_guy_a;
        level.scr_anim[var_1]["zipline_left_landing_guy_b"] = %zipline_left_landing_guy_b;
    }
}

fastzip_unload( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;

    foreach ( var_7, var_5 in var_0.zipline_gun_model )
    {
        var_6 = distance2d( var_5.origin, self.origin );

        if ( !isdefined( var_3 ) || var_6 < var_3 )
        {
            if ( !isdefined( var_5.turret ) )
            {
                var_3 = var_6;
                var_2 = var_7;
            }
        }
    }

    if ( !isdefined( var_2 ) )
        return 0;

    setup_fastzip_anims( var_2 );
    var_8 = var_0.zipline_gunner_tag[var_2];

    if ( !isdefined( var_8 ) )
        return 0;

    var_9 = find_unload_node( var_0, var_8 );

    if ( !isdefined( var_9 ) )
        return 0;

    var_10 = calculate_rope_target( var_0, var_2, var_9 );

    if ( !validate_target_pos( var_0, var_8, var_10 ) )
        return 0;

    var_11 = var_0.zipline_gun_model[var_2];
    var_12 = setup_zipline_gun( "zipline_gun", var_0, var_2, var_11.model, var_11.rope_model, var_11.animname );
    var_13 = setup_zipline_gun( "zipline_gun_rope", var_0, var_2, var_11.rope_model, undefined, var_11.animname );
    var_11.turret = var_12;
    var_14 = common_scripts\utility::spawn_tag_origin();
    var_14.origin = var_10;
    var_12 thread common_scripts\utility::delete_on_death( var_14 );
    self.allowdeath = 1;
    self.noragdoll = undefined;
    get_ready_to_use_turret( var_0, var_11, var_8 );

    if ( !isdefined( self ) || !isalive( self ) )
        return 1;

    var_11 hide();
    var_12 show();
    var_12 _meth_8067( 1 );
    self _meth_818A( var_12 );
    var_12 _meth_8106( var_14 );
    var_13 _meth_8106( var_14 );
    var_12 waittill( "turret_on_target" );

    if ( !isdefined( self ) || !isalive( self ) )
        return 1;

    self _meth_818B();
    self _meth_804D( var_0, var_8 );
    var_0 thread maps\_anim::anim_single_solo( self, "fire", var_8, undefined, self.zipline_animname );
    var_15 = var_13 fire_rope( var_12, var_14.origin, var_11 );
    var_11 show();
    var_12 hide();

    if ( !isdefined( self ) || !isalive( self ) )
        return 1;

    play_jump_out_anim( var_0, var_11, var_8 );
    self notify( "fastzip_jumped_out" );

    if ( isdefined( self ) && isalive( self ) )
    {
        var_16 = var_9.animation;
        var_17 = [];
        var_17["zipline_right_land_guy_a"] = "slide_idle_a";
        var_17["zipline_right_land_guy_b"] = "slide_idle_b";
        var_17["zipline_left_landing_guy_a"] = "slide_idle_a";
        var_17["zipline_left_landing_guy_b"] = "slide_idle_b";
        var_18 = var_17[var_16];

        if ( !isdefined( var_18 ) )
            var_18 = "slide_idle_a";

        fastzip_slide( var_13, var_18 );
        wait 0.1;
        fastzip_land( var_13, var_9.origin, var_16 );
        wait 1;
        var_13 retract_rope( var_15 );
    }

    var_14 delete();
    var_12 delete();
    var_13 delete();
    var_11.turret = undefined;
    return 1;
}

get_ready_to_use_turret( var_0, var_1, var_2 )
{
    self endon( "death" );
    thread play_rest_anim( var_0, var_1, var_2 );
    wait 0.05;
    var_0 thread open_doors_for_unload( var_2 );
    play_ready_up_anim( var_0, var_1, var_2 );
}

find_unload_node( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = 1;

    if ( var_1 == "TAG_GUNNER_FL" || var_1 == "TAG_GUNNER_KR" )
        var_4 = 0;

    var_5 = var_0 gettagorigin( var_1 );
    var_6 = var_0 gettagangles( var_1 );
    var_7 = anglestoforward( var_6 );
    var_8 = anglestoright( var_6 );
    var_9 = common_scripts\utility::getstructarray( var_0.currentnode.target, "targetname" );

    foreach ( var_11 in var_9 )
    {
        if ( !isdefined( var_11.script_unloadtype ) )
            continue;

        var_12 = var_11.origin - var_5;
        var_13 = vectornormalize( var_12 );
        var_14 = ( var_12[0], var_12[1], 0 );
        var_15 = vectornormalize( var_14 );
        var_16 = vectordot( var_7, var_13 );

        if ( var_16 < 0 )
            continue;

        var_17 = vectordot( var_8, var_15 );

        if ( !var_4 && ( !isdefined( var_3 ) || var_17 > var_3 ) )
        {
            var_2 = var_11;
            var_3 = var_17;
            continue;
        }

        if ( var_4 && ( !isdefined( var_3 ) || var_17 < var_3 ) )
        {
            var_2 = var_11;
            var_3 = var_17;
        }
    }

    if ( !isdefined( var_2 ) )
        return undefined;

    return var_2;
}

calculate_rope_target( var_0, var_1, var_2 )
{
    var_3 = var_0 gettagorigin( var_1 );
    var_4 = var_2.origin - var_3;
    var_5 = vectortoangles( var_4 );
    var_6 = var_0.zipline_gun_model[var_1];
    var_7 = spawn( "script_model", var_2.origin );
    var_7.animname = var_6.animname;
    var_7.angles = var_5;
    var_7 maps\_utility::assign_animtree();
    var_7 _meth_80B1( var_6.rope_model );
    var_7 hide();
    var_8 = var_7 maps\_utility::getanim( "fastzip_fire" );
    var_7 _meth_8143( var_8, 1, 0, 0 );
    [var_10, var_11] = var_7 get_ai_fastzip_pos();
    var_12 = var_2.origin - var_10;
    var_7.origin += var_12;
    wait 0.05;
    var_13 = var_7 gettagorigin( "jnt_shuttleRoot" );
    var_7 delete();
    return var_13;
}

validate_target_pos( var_0, var_1, var_2 )
{
    var_3 = var_0 gettagorigin( var_1 );
    var_4 = var_0 gettagangles( var_1 );
    var_5 = anglestoforward( var_4 );
    var_6 = anglestoup( var_4 ) * -1;
    var_7 = var_2 - var_3;
    var_8 = vectornormalize( var_7 );
    var_9 = vectordot( var_8, var_6 );

    if ( var_9 > cos( 30 ) )
        return undefined;

    var_10 = ( var_7[0], var_7[1], 0 );
    var_11 = vectornormalize( var_10 );
    var_12 = vectordot( var_11, var_5 );

    if ( var_12 < cos( 45 ) )
        return undefined;

    var_13 = length( var_7 );

    if ( var_13 > 2400 )
        return undefined;

    return 1;
}

play_rest_anim( var_0, var_1, var_2 )
{
    self notify( "newanim" );
    maps\_utility::anim_stopanimscripted();
    self _meth_804F();
    var_1 clear_script_model_anim( 0 );
    var_1 _meth_814B( var_1 maps\_utility::getanim( "rest_idle" ), 1, 0, 0 );
    var_0 maps\_anim::anim_first_frame_solo( self, "rest_idle", var_2, self.zipline_animname );
    self _meth_804D( var_0, var_2 );
}

play_ready_up_anim( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_0 endon( "death" );
    wait(randomfloatrange( 0, 0.25 ));
    var_0 thread maps\_anim::anim_single_solo( var_1, "readyup", var_2 );
    var_0 maps\_anim::anim_single_solo( self, "readyup", var_2, undefined, self.zipline_animname );
}

play_jump_out_anim( var_0, var_1, var_2 )
{
    self endon( "death" );
    var_3 = [ self, var_1 ];
    var_0 thread maps\_anim::anim_single_solo( var_1, "jumpout", var_2 );
    var_0 maps\_anim::anim_single_solo( self, "jumpout", var_2, undefined, self.zipline_animname );
}

aim_test( var_0, var_1, var_2 )
{
    var_3 = self gettagorigin( "tag_aim" );
    var_4 = self gettagangles( "tag_aim" );
    var_4 = ( angleclamp180( var_4[0] ), angleclamp180( var_4[1] ), angleclamp180( var_4[2] ) );
    var_0.origin = var_3 + anglestoforward( var_4 ) * 100;

    while ( var_4[0] > -5 )
    {
        var_3 = self gettagorigin( "tag_aim" );
        var_4 -= ( 0.1, 0, 0 );
        var_0.origin = var_3 + anglestoforward( var_4 ) * 100;
        wait 0.05;
    }

    wait 2;

    while ( var_4[0] < 60 )
    {
        var_3 = self gettagorigin( "tag_aim" );
        var_5 = self gettagangles( "tag_aim" );
        var_6 = self gettagorigin( "tag_weapon" );
        var_7 = self gettagangles( "tag_weapon" );
        var_8 = self gettagorigin( "tag_flash" );
        var_9 = self gettagangles( "tag_flash" );
        var_10 = var_1 gettagorigin( var_2 );
        var_11 = var_1 gettagangles( var_2 );
        var_4 += ( 0.3, 0, 0 );
        var_0.origin = var_3 + anglestoforward( var_4 ) * 100;
        wait 0.05;
    }

    wait 1;

    while ( var_4[0] > 0 )
    {
        var_3 = self gettagorigin( "tag_aim" );
        var_4 -= ( 0.3, 0, 0 );
        var_0.origin = var_3 + anglestoforward( var_4 ) * 100;
        wait 0.05;
    }

    self notify( "aim_test_done" );
}

#using_animtree("script_model");

spawn_zipline_turret( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnturret( "misc_turret", ( 0, 0, 0 ), var_0 );
    var_4 _meth_804D( self, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_4 _meth_80B1( var_2 );
    var_4.angles = self.angles;
    var_4.script_team = self.script_team;
    maps\_vehicle_code::set_turret_team( var_4 );
    var_4 _meth_815A( 0 );
    var_4 _meth_8065( "manual" );
    var_4 makeunusable();
    var_4 _meth_8115( #animtree );
    var_4.animname = var_3;
    return var_4;
}

setup_zipline_gun( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = var_1 spawn_zipline_turret( var_0, var_2, var_3, var_5 );

    if ( isdefined( var_4 ) )
        var_6 attach( var_4 );

    var_6 hide();
    var_6 _meth_815A( 0 );
    var_6 maps\_utility::anim_stopanimscripted();
    var_6 clear_script_model_anim( 0 );
    var_6 _meth_814B( var_6 maps\_utility::getanim( "fastzip_aim_idle" ), 1, 0, 0 );
    var_1 thread common_scripts\utility::delete_on_death( var_6 );
    return var_6;
}

clear_script_model_anim( var_0 )
{
    self _meth_8142( %root, var_0 );
}

fire_rope( var_0, var_1, var_2 )
{
    var_3 = 210;
    var_4 = var_3 / 30;
    var_0 detach( var_2.rope_model );
    var_2 detach( var_2.rope_model );
    self show();
    var_5 = var_0 gettagorigin( "tag_barrel" );
    var_6 = var_1 - var_5;
    var_6 = vectornormalize( var_6 );
    var_7 = var_1 + var_6 * 2400;
    var_8 = bullettrace( var_1, var_7, 0 );

    if ( var_8["fraction"] < 1 )
        var_7 = var_8["position"];

    var_9 = distance( var_5, var_7 ) / 12;
    var_10 = var_9 / 200;
    thread sndxt_fastzip_fire( var_7 );
    var_11 = maps\_utility::getanim( "fastzip_fire" );
    var_12 = getanimlength( var_11 );
    var_13 = var_12 / var_4 * var_10;
    self _meth_8143( var_11, 1, 0.2, var_4 );
    var_0 _meth_8143( var_11, 1, 0.2, 1 );
    var_13 -= 0.05;

    if ( var_13 > 0.05 )
        wait(var_13);

    self _meth_814B( var_11, 1, 0, 0 );
    self _meth_8117( var_11, var_10 );
    return var_9;
}

sndxt_fastzip_fire( var_0 )
{
    var_1 = self;
    var_2 = randomfloatrange( 0.1, 0.2 );
    wait(var_2);
    var_1 soundscripts\_snd_playsound::snd_play( "tac_fastzip_fire" );
    wait(var_2);
    common_scripts\utility::play_sound_in_space( "tac_fastzip_proj_impact", var_0 );
}

fastzip_slide( var_0, var_1 )
{
    var_2 = var_0 maps\_utility::getanim( "fastzip_slide" );
    var_0 _meth_814C( %add_slide, 1, 0, 0 );
    var_0 _meth_814C( var_2, 1, 0, 0 );
    thread maps\_anim::anim_loop_solo( self, var_1, "stop_loop", undefined, self.zipline_animname );
    [var_4, var_5] = var_0 get_ai_fastzip_pos();
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    self _meth_804D( var_6, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_6 _meth_82AE( var_4, 0.2, 0.1, 0 );
    var_6 _meth_82B5( var_5, 0.2, 0.1, 0 );
    var_6 waittill( "movedone" );
    self _meth_81C6( var_4, var_5 );
    self _meth_804D( var_0, "jnt_shuttleRoot", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_6 delete();
    var_0 _meth_814C( %add_slide, 1, 0, 1.2 );
    var_0 _meth_814C( var_2, 1, 0, 1.2 );
}

fastzip_land( var_0, var_1, var_2 )
{
    var_3 = ( 0, 0, 0 );
    var_4 = [];

    if ( isdefined( self ) && isalive( self ) )
    {
        var_5 = self.origin;
        var_6 = self.origin;
        var_7 = distance( self.origin, var_1 );

        for (;;)
        {
            wait 0.05;
            [var_9, var_10] = var_0 get_ai_fastzip_pos();
            var_11 = distance( var_6, var_9 );
            var_12 = distance( var_9, var_1 );
            var_13 = distance( var_9, var_5 );

            if ( var_12 < var_11 * 4 )
                break;

            if ( var_7 < var_13 + var_11 )
                break;

            var_6 = var_9;
        }

        if ( isdefined( self ) )
        {
            var_14 = common_scripts\utility::spawn_tag_origin();
            var_14.origin = self.origin;
            var_14.angles = self.angles;
            self _meth_804D( var_14, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            var_15 = ( 0, self.angles[1], 0 );
            var_14 _meth_82AE( var_1, 0.2, 0.1, 0 );
            var_14 _meth_82B5( var_15, 0.2, 0.1, 0 );
            var_14 waittill( "movedone" );

            if ( isalive( self ) )
            {
                self _meth_804F();
                self notify( "stop_loop" );
                self _meth_81C6( var_1, var_15 );
                thread maps\_anim::anim_single_solo( self, var_2, undefined, undefined, self.zipline_animname );
            }

            var_14 delete();
        }
    }

    var_16 = var_0 maps\_utility::getanim( "fastzip_slide" );
    var_0 _meth_814C( var_16, 1, 0, 0 );

    if ( isdefined( self ) && isalive( self ) )
    {
        self endon( "death" );
        self waittill( var_2 );

        if ( maps\_vehicle_aianim::guy_resets_goalpos( self ) )
            self _meth_81A6( self.origin );
    }
}

retract_rope( var_0 )
{
    var_1 = var_0 / 200;
    var_1 = 1 - min( var_1, 1 );
    var_2 = 30;
    var_3 = 1;
    var_4 = maps\_utility::getanim( "retract_rope" );
    self _meth_8143( var_4, 1, 0.2, var_3 );
    self _meth_8117( var_4, var_1 );
    var_5 = var_2 * ( 1 - var_1 ) / 30 * var_3;
    wait(var_5 + 0.05);
}

get_ai_fastzip_pos()
{
    var_0 = self gettagorigin( "jnt_shuttleRoot" );
    var_1 = self gettagangles( "jnt_shuttleRoot" );
    var_2 = angleclamp180( var_1[0] );
    var_2 = clamp( var_2, -20, 20 );
    var_3 = ( var_2, var_1[1], var_1[2] );
    var_4 = anglestoup( var_3 );
    var_0 += var_4 * -70;
    return [ var_0, var_3 ];
}

guy_death_inside_warbird()
{
    self endon( "fastzip_jumped_out" );
    var_0 = self.ridingvehicle;
    thread kill_on_fastzip_jump();
    self waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        if ( !self _meth_81E0() )
        {
            if ( ( self.damagemod == "MOD_PROJECTILE_SPLASH" || self.damagemod == "MOD_EXPLOSIVE" ) && isdefined( self.death_flop_dir ) )
            {
                var_1 = length( self.death_flop_dir );
                var_2 = vectornormalize( var_0 _meth_81B0( self.death_flop_dir ) - self.origin );
                self _meth_8024( "torso_lower", var_2 * var_1 );
            }
            else
            {
                self _meth_804D( var_0 );
                self.noragdoll = 1;
                var_0 waittill( "death" );

                if ( isdefined( self ) )
                    self delete();
            }
        }
    }
}

kill_on_fastzip_jump()
{
    self endon( "death" );
    self waittill( "fastzip_jumped_out" );
    self.noragdoll = undefined;
}
