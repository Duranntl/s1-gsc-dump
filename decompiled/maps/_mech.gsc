// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( isdefined( level.mech_initialized ) )
        return;

    level.mech_initialized = 1;
    level._mech_globals = spawnstruct();
    level._mech_globals.num_missile_attractors = 0;
    level._mech_globals.num_missile_repulsors = 0;

    if ( !isdefined( level.subclass_spawn_functions ) )
        level.subclass_spawn_functions = [];

    level.subclass_spawn_functions["mech"] = ::subclass_mech;

    if ( !getdvarint( "r_reflectionProbeGenerate" ) )
        maps\_mech_aud::main();

    precacheitem( "mech_rocket" );
    precacheitem( "mech_rocket_deploy" );
    precachemodel( "npc_exo_armor_minigun_whole" );
    precachemodel( "npc_exo_armor_minigun_barrel" );
    precachemodel( "npc_exo_armor_minigun_handle" );
    level.mech_fx["rocket_muzzle_flash"] = loadfx( "vfx/muzzleflash/exo_armor_rocket_flash_wv" );
    level.mech_fx["rocket_seperation"] = loadfx( "vfx/muzzleflash/exo_armor_rocket_burst" );
    level.mech_fx["bullet_hit_sparks"] = loadfx( "vfx/weaponimpact/metal_spark_fountain_small" );
    level.mech_fx["bullet_hit_sparks_large"] = loadfx( "vfx/weaponimpact/metal_spark_fountain_large" );
    level.mech_fx["rocket_trail_0"] = loadfx( "vfx/trail/exo_armor_rocket_trail_a" );
    level.mech_fx["rocket_trail_1"] = loadfx( "vfx/trail/exo_armor_rocket_trail_b" );
    level.mech_fx["rocket_trail_2"] = loadfx( "vfx/trail/exo_armor_rocket_trail_c" );
}

#using_animtree("generic_human");

subclass_mech()
{
    init_mech_animsets();
    self.mech = 1;
    self.rocketpodup = 0;
    self.emp = 0;
    self.targetattacker = 0;
    self.mechpainbuildup = 1;
    self.paindamagestart = 200;
    self.paindamagemin = 100;
    self.paindamageincrement = 4;
    self.paindamageincrementback = 1;
    self.paindamagetime = 0.2;
    self.animarchetype = "mech";
    self.script_animation = "mech";

    if ( animscripts\utility::aihasweapon( "exo_minigun" ) )
    {
        self attach( "npc_exo_armor_minigun_barrel", "TAG_BARREL" );
        self attach( "npc_exo_armor_minigun_handle", "TAG_HANDLE" );
        self _meth_814B( %s1_mechgun, 1, 1, 1 );
    }

    if ( animscripts\utility::aihasweapon( "exo_minigun_scaled" ) )
    {
        self attach( "npc_exo_armor_minigun_barrel", "TAG_BARREL" );
        self attach( "npc_exo_armor_minigun_handle", "TAG_HANDLE" );
        self _meth_814B( %s1_mechgun, 1, 1, 1 );
    }

    level.scr_anim["generic"]["patrol_idle_mech"] = %mech_unaware_idle;
    level.scr_anim["generic"]["patrol_walk_mech"] = %mech_unaware_walk;
    level.scr_anim["generic"]["patrol_stop_mech"] = %mech_unaware_walk_stop;
    level.scr_anim["generic"]["patrol_start_mech"] = %mech_unaware_walk_start;
    level.scr_anim["generic"]["patrol_walk_weights"] = %mech_unaware_walk;
    self _meth_81CA( "stand" );
    self.maxhealth = self.health;
    self.minpaindamage = 100;
    self.walkdist = 500;
    self.walkdistfacingmotion = self.walkdist;
    self.grenadeammo = 0;
    self.doorflashchance = 0.05;
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    self.no_pistol_switch = 1;
    self.norunngun = 1;
    self.disablebulletwhizbyreaction = 1;
    self.combatmode = "no_cover";
    self.neversprintforvariation = 1;
    self.noturnanims = undefined;
    self.canclimbladders = 0;
    self.flashbangimmunity = 1;
    self._id_849D = 0;
    self.noruntwitch = 1;
    self.usemuzzleforaim = 1;
    self.bdisabledefaultfacialanims = 1;
    self.aimfaryawtolerance = 20;
    self.disablereactionanims = 1;
    self.dontmelee = 1;
    self.meleechargedistsq = 9216;
    self _meth_84E3();
    self.standingturnrate = 0.2;
    self.walkingturnrate = 0.07;
    self.runingturnrate = 0.5;
    self.standingaimblendtime = 0.2;
    self.walkingaimblendtime = 0.6;
    self.runningaimblendtime = 0.4;
    self.aimsetupblendtime = 2;
    self.standingmechblendtime = 1.5;
    self.walkingmechblendtime = 1.5;
    self.runningmechblendtime = 0.2;
    self.standingaimlimits = [ -25, 35, 45, -45 ];
    self.walkingaimlimits = [ -25, 35, 45, -45 ];
    self.runningaimlimits = [ -25, 35, 45, -45 ];

    if ( !isdefined( self.attractornumber ) )
        self.attractornumber = 6;

    if ( !isdefined( self.repulsornumber ) )
        self.repulsornumber = 3;

    self.largesparkdistance = 600;
    self _meth_84FB( 0 );
    self.scriptedarrivalententity = common_scripts\utility::spawn_tag_origin();
    self.scriptedarrivalententity.type = "scripted_arrival_ent";
    self.scriptedarrivalententity.arrivalstance = "stand";
    thread common_scripts\utility::delete_on_death( self.scriptedarrivalententity );
    maps\_utility::disable_surprise();
    maps\_utility::disable_danger_react();
    self.grenadeawareness = 0;
    self.norunreload = 1;
    maps\_utility::add_damage_function( animscripts\pain::additive_pain );
    maps\_utility::add_damage_function( maps\_spawner::pain_resistance );
    maps\_utility::add_damage_function( ::mech_hit_vfx );
    maps\_utility::add_damage_function( ::mech_pain_adder );
    maps\_utility::add_damage_function( ::mech_incoming_damage_modifiers );
    thread maps\_shg_utility::make_emp_vulnerable();
    self.emp_death_function = ::mech_emp_function;
    thread mech_wait_for_drop();
    thread mech_minigun_loop();
    thread mech_melee_behavior();
    thread mech_turn_loop();
    thread mech_pain_loop();

    if ( isdefined( level.mech_grapple_setup_function ) )
        [[ level.mech_grapple_setup_function ]]( self );

    if ( !self _meth_813D() )
        return;

    self.bullet_resistance = 40;
    maps\_utility::add_damage_function( maps\_spawner::bullet_resistance );
    maps\_utility::add_damage_function( ::mech_target_attacker );
    self.pathenemyfightdist = 64;
    self.pathenemylookahead = 128;
    level notify( "mech_spawned" );
    self waittill( "death", var_0, var_1, var_2 );
    mech_death_function();

    if ( isdefined( self ) && isdefined( self.nodrop ) )
    {
        var_3 = [];
        var_3[var_3.size] = "left";
        var_3[var_3.size] = "right";
        var_3[var_3.size] = "chest";
        var_3[var_3.size] = "back";
        animscripts\shared::detachallweaponmodels();

        foreach ( var_5 in var_3 )
        {
            var_2 = self.a.weaponpos[var_5];

            if ( var_2 == "none" )
                continue;

            self.weaponinfo[var_2].position = "none";
            self.a.weaponpos[var_5] = "none";
        }

        self.weapon = "none";
        animscripts\shared::updateattachedweaponmodels();
    }

    level notify( "mech_died" );

    if ( !isdefined( self ) )
        return;

    if ( !isdefined( var_0 ) )
        return;

    if ( !isplayer( var_0 ) )
        return;
}

mech_set_goal_node( var_0 )
{
    self _meth_81A5( var_0 );
    self.scriptedarrivalententity.origin = var_0.origin;
    self.scriptedarrivalententity.angles = var_0.angles;
    self.scriptedarrivalent = self.scriptedarrivalententity;
}

process_melee_notetracks()
{
    self endon( "death" );
    self endon( "melee_complete" );

    for (;;)
    {
        self waittill( "meleeAnim", var_0 );

        if ( !isdefined( var_0 ) )
            var_0 = "undefined";

        if ( var_0 == "fire" )
        {
            if ( isdefined( self.enemy ) )
            {
                var_1 = self _meth_81E9();

                if ( isai( var_1 ) )
                    var_1 _meth_8051( 999999999, self.origin, self, self, "MOD_MELEE" );
            }

            continue;
        }

        if ( var_0 == "end" || var_0 == "stop" )
            return;
        else
            animscripts\notetracks::handlenotetrack( var_0, "meleeAnim" );
    }
}

mech_do_melee()
{
    self _meth_818E( "zonly_physics" );
    var_0 = vectortoyaw( self.enemy.origin - self.origin );
    var_1 = angleclamp180( self.angles[1] - var_0 );

    if ( var_1 < -90 )
    {
        var_2 = self.origin + self.origin - self.enemy.origin;
        self _meth_818F( "face point", var_2 );
        var_3 = %mech_stand_melee_left;
    }
    else if ( var_1 > 90 )
    {
        var_2 = self.origin + self.origin - self.enemy.origin;
        self _meth_818F( "face point", var_2 );
        var_3 = %mech_stand_melee_right;
    }
    else
    {
        self _meth_818F( "face point", self.enemy.origin );
        var_3 = %mech_stand_melee_front;
    }

    self _meth_8110( "meleeAnim", var_3, %body, 1, 0.5, 1 );
    var_4 = getanimlength( var_3 );
    thread process_melee_notetracks();
    thread kill_clipping_enemy();
    wait(var_4);
    self notify( "stop_kill_clipping_enemy" );
}

kill_clipping_enemy()
{
    self endon( "stop_kill_clipping_enemy" );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.enemy ) && distance( self.origin, self.enemy.origin ) < 32 && !isplayer( self.enemy ) )
            self.enemy _meth_8051( 999999999, self.origin, self, self, "MOD_MELEE" );

        waitframe();
    }
}

mech_melee_endscript()
{
    self _meth_818E( "none" );
    self _meth_8142( %body, 0.2 );
    self.a.movement = "stop";
    self _meth_818F( "face default" );
    var_0 = self _meth_813C();

    if ( isdefined( var_0 ) )
        self _meth_81C6( var_0, self.angles );
    else
    {

    }

    self notify( "melee_complete" );
}

mech_death_function()
{
    if ( isdefined( self ) && isdefined( self.mech ) && self.mech )
    {
        self _meth_8048( "TAG_BARREL", "npc_exo_armor_minigun_barrel" );
        self _meth_8048( "TAG_HANDLE", "npc_exo_armor_minigun_handle" );
        self detach( "npc_exo_armor_minigun_barrel", "TAG_BARREL" );
        self detach( "npc_exo_armor_minigun_handle", "TAG_HANDLE" );
    }
}

mech_minigun_loop()
{
    self endon( "death" );
    var_0 = 0;

    for (;;)
    {
        if ( animscripts\utility::isincombat() && !var_0 )
            var_0 = 1;

        if ( !animscripts\utility::isincombat() && var_0 )
            var_0 = 0;

        wait 0.25;
    }
}

mech_pain_loop()
{
    self endon( "death" );

    if ( !isdefined( self.mechpainbuildup ) || isdefined( self.mechpainbuildup ) && !self.mechpainbuildup )
        return;

    if ( isdefined( self.paindamagestart ) )
        self.minpaindamage = self.paindamagestart;

    for (;;)
    {
        if ( self.minpaindamage < self.paindamagestart )
            self.minpaindamage += self.paindamageincrementback;

        if ( isdefined( self.mechpainbuildup ) && !self.mechpainbuildup )
            break;

        if ( isdefined( self.paindamagetime ) && self.paindamagetime > 0 )
        {
            wait(self.paindamagetime);
            continue;
        }

        wait 0.2;
    }
}

mech_pain_adder( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( self.mechpainbuildup ) && self.mechpainbuildup && ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" ) && var_1 == level.player )
    {
        if ( self.minpaindamage > self.paindamagemin )
            self.minpaindamage -= self.paindamageincrement;
    }
}

mech_incoming_damage_modifiers( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = 0;

    if ( isdefined( self.bullet_resistance ) )
        var_7 = self.bullet_resistance;

    if ( isdefined( self.reduced_nonplayer_damage ) && self.reduced_nonplayer_damage > 0 && var_1 != level.player )
    {
        if ( self.health > 0 && var_0 > var_7 )
            self.health += int( ( var_0 - var_7 ) * self.reduced_nonplayer_damage );
    }
    else if ( self.damagelocation == "head" )
    {
        if ( self.health > 0 )
            self.health += int( ( var_0 - var_7 ) * 0.25 );
    }
}

is_doing_scripted_anim()
{
    return isdefined( self.script ) && self.script == "scripted";
}

mech_turn_loop()
{
    self endon( "stop_mech_turn_loop" );
    var_0 = ( 1, 0, 0 );
    var_1 = self.movemode;
    var_2 = animscripts\utility::isincombat();

    for (;;)
    {
        if ( !_func_294( self ) && isdefined( self ) )
        {
            if ( isdefined( self.script ) && self.script == "death" || !isalive( self ) )
            {
                self _meth_814B( %idle_combat, 0, 1, 1, 1 );
                self _meth_814C( %mech_combat_idle, 0, 0.2, 1 );
                break;
            }
        }
        else
            break;

        if ( is_doing_scripted_anim() )
        {

        }
        else if ( self.movemode == "stop" || self.movemode == "stop soon" && isdefined( self.standingturnrate ) )
        {
            self.turnrate = self.standingturnrate;
            self.aimblendtime = self.standingaimblendtime;
            self.strafeblendtimes = self.standingmechblendtime;
            self.leftaimlimit = self.standingaimlimits[0];
            self.rightaimlimit = self.standingaimlimits[1];
            self.upaimlimit = self.standingaimlimits[2];
            self.downaimlimit = self.standingaimlimits[3];
        }
        else if ( self.movemode == "walk" && isdefined( self.walkingturnrate ) )
        {
            self.turnrate = self.walkingturnrate;
            self.aimblendtime = self.walkingaimblendtime;
            self.strafeblendtimes = self.walkingmechblendtime;
            self.leftaimlimit = self.walkingaimlimits[0];
            self.rightaimlimit = self.walkingaimlimits[1];
            self.upaimlimit = self.walkingaimlimits[2];
            self.downaimlimit = self.walkingaimlimits[3];
        }
        else if ( self.movemode == "run" && isdefined( self.runingturnrate ) )
        {
            self.turnrate = self.runingturnrate;
            self.aimblendtime = self.runningaimblendtime;
            self.strafeblendtimes = self.runningmechblendtime;
            self.leftaimlimit = self.runningaimlimits[0];
            self.rightaimlimit = self.runningaimlimits[1];
            self.upaimlimit = self.runningaimlimits[2];
            self.downaimlimit = self.runningaimlimits[3];
        }
        else
        {

        }

        if ( var_2 != animscripts\utility::isincombat() || self.movemode != var_1 )
        {
            if ( self.movemode == "stop" && animscripts\utility::isincombat() && self.script != "scripted" )
            {
                self _meth_814B( %idle_combat, 1, 1, 1, 1 );
                self _meth_814C( %mech_combat_idle, 0.5, 0.2, 1 );
            }
            else
            {
                self _meth_814B( %idle_combat, 0, 1, 1, 1 );
                self _meth_814C( %mech_combat_idle, 0, 0.2, 1 );
            }

            var_2 = animscripts\utility::isincombat();
            var_1 = self.movemode;
        }

        wait 0.05;
    }
}

mech_wait_for_drop()
{
    self endon( "wait_drop_end" );
    self waittill( "weapon_dropped", var_0 );

    if ( isdefined( var_0 ) && var_0.classname == "weapon_exo_minigun" )
    {
        var_0 _meth_80B1( "npc_exo_armor_minigun_whole" );
        var_0 makeunusable();
    }
}

mech_hit_vfx( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" )
    {
        if ( isplayer( var_1 ) && isdefined( self.largesparkdistance ) && common_scripts\utility::distance_2d_squared( self.origin, var_1.origin ) > self.largesparkdistance * self.largesparkdistance )
            playfx( level.mech_fx["bullet_hit_sparks_large"], var_3, var_2 * -1.0, ( 0, 0, 1 ) );
        else
            playfx( level.mech_fx["bullet_hit_sparks"], var_3, var_2 * -1.0, ( 0, 0, 1 ) );
    }
}

mech_bullet_ricochet( var_0, var_1 )
{
    var_2 = anglestoforward( self.angles );
    var_1 = vectornormalize( var_1 );
    var_3 = -2 * vectordot( var_1, var_2 ) * var_2 + var_1;
    playfx( level.mech_fx["bullet_ricochet"], var_0, var_3, ( 0, 0, 1 ) );
}

mech_vfx_loop()
{
    self endon( "death" );

    for (;;)
    {
        if ( self.health < self.maxhealth / 2 )
        {
            if ( self _meth_8442( "tag_vfx_chest_light" ) != -1 )
            {

            }
            else
            {

            }

            break;
        }

        wait 0.5;
    }

    for (;;)
    {
        if ( self.health < self.maxhealth / 4 )
        {
            if ( self _meth_8442( "tag_vfx_chest_light" ) != -1 )
            {

            }
            else
            {

            }

            break;
        }

        wait 0.5;
    }
}

mech_is_shooting_rockets()
{
    if ( isdefined( self.isshootingrockets ) && self.isshootingrockets )
        return 1;

    return 0;
}

mech_start_target_attacker()
{
    self.targetattacker = 1;
}

mech_stop_target_attacker()
{
    self.targetattacker = 0;
}

mech_start_rockets( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    thread mech_rocket_launcher_behavior( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
}

mech_stop_rockets()
{
    self notify( "stop_stop_rocket_launcher" );
}

mech_start_hunting()
{
    thread mech_hunt_immediately_behavior();
}

mech_stop_hunting()
{
    self notify( "stop_hunting" );
}

mech_badplace_behavior()
{
    self endon( "death" );
    self endon( "stop_badplace_behavior" );
    var_0 = 1.0;
    var_1 = 240;
    var_2 = 120;
    var_3 = "mech_bad_place" + self _meth_81B1();

    for (;;)
    {
        badplace_cylinder( var_3, var_0 - 0.05, self.origin, var_1, var_2, "allies" );
        wait(var_0);
    }
}

mech_start_badplace_behavior()
{
    thread mech_badplace_behavior();
}

mech_stop_badplace_behavior()
{
    self notify( "stop_badplace_behavior" );
}

mech_start_generic_attacking()
{
    thread mech_generic_attacking_behavior();
}

mech_stop_generic_attacking()
{
    self notify( "stop_generic_attacking" );
}

mech_start_reduced_nonplayer_damage( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0.9;

    self.reduced_nonplayer_damage = var_0;
}

mech_stop_reduced_nonplayer_damage()
{
    self.reduced_nonplayer_damage = undefined;
}

mech_melee_is_valid()
{
    if ( !isdefined( self.enemy ) )
        return 0;

    if ( distancesquared( self.origin, self.enemy.origin ) > self.meleechargedistsq )
        return 0;

    if ( !isalive( self ) )
        return 0;

    if ( isdefined( self.emp ) && self.emp )
        return 0;

    if ( !isalive( self.enemy ) )
        return 0;

    if ( isdefined( self.enemy.dontattackme ) || isdefined( self.enemy.ignoreme ) && self.enemy.ignoreme )
        return 0;

    if ( isai( self.enemy ) )
    {
        if ( self.enemy _meth_819B() )
            return 0;

        if ( self.enemy maps\_utility::doinglongdeath() || self.enemy.delayeddeath )
            return 0;
    }

    if ( !mech_melee_trace_passed( self.enemy ) )
        return 0;

    return 1;
}

mech_melee_trace_passed( var_0 )
{
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles( var_1 );
    var_3 = anglestoforward( var_2 );
    var_4 = anglestoright( var_2 );
    var_5 = anglestoup( var_2 );

    foreach ( var_7 in [ 10, 80 ] )
    {
        foreach ( var_9 in [ -20, 0, 20 ] )
        {
            var_10 = self.origin - 10 * var_3 + var_9 * var_4 + var_7 * var_5;
            var_11 = var_0.origin - 10 * var_3 + var_9 * var_4 + var_7 * var_5;
            var_12 = sighttracepassed( var_10, var_11, 0, self );

            if ( !var_12 )
                return 0;
        }
    }

    return 1;
}

mech_melee_behavior()
{
    self endon( "death" );
    var_0 = 0.05;

    for (;;)
    {
        if ( mech_melee_is_valid() )
        {
            self _meth_819A( ::mech_do_melee, ::mech_melee_endscript );
            self waittill( "melee_complete" );
        }

        wait(var_0);
    }
}

mech_rocket_launcher_behavior( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );
    self endon( "stop_rocket_launcher" );
    var_7 = 0.25;
    self.isshootingrockets = 1;

    if ( !isdefined( var_0 ) )
        var_0 = 256;

    if ( !isdefined( var_1 ) )
        var_1 = 2048;

    if ( !isdefined( var_2 ) )
        var_2 = 0.0;

    if ( !isdefined( var_3 ) )
        var_3 = 3;

    if ( !isdefined( var_4 ) )
        var_4 = 50;

    if ( !isdefined( var_5 ) )
        var_5 = 4;

    if ( !isdefined( var_6 ) )
        var_6 = 117;

    var_8 = var_0 * var_0;
    var_9 = var_1 * var_1;

    for (;;)
    {
        if ( !isdefined( self.enemy ) || !self _meth_81BD() )
        {
            wait(var_7);
            continue;
        }

        if ( isdefined( self.underwater ) && self.underwater )
        {
            wait(var_7);
            continue;
        }

        if ( getdvar( "debug_mech_rocket" ) == "on" )
            self.mechrocketdebug = 1;
        else
            self.mechrocketdebug = 0;

        var_10 = self gettagorigin( "tag_eye" );
        var_11 = self.enemy _meth_8097() - var_10;
        var_12 = vectornormalize( anglestoforward( self gettagangles( "tag_eye" ) ) );
        var_13 = vectornormalize( var_11 );
        var_14 = vectordot( var_12, var_13 );

        if ( var_14 < var_2 )
        {
            wait(var_7);
            continue;
        }

        if ( isdefined( self.emp ) && self.emp || animscripts\utility::isdoingpain() )
        {
            wait(var_7);
            continue;
        }

        if ( isdefined( self.team ) && self.team == "allies" )
        {
            var_16 = pointonsegmentnearesttopoint( self.enemy _meth_8097(), var_10, level.player.origin );

            if ( distance( level.player.origin, var_16 ) < var_6 )
            {
                wait(var_7);
                continue;
            }
        }

        var_17 = distancesquared( self.origin, self.enemy.origin );

        if ( var_17 >= var_8 && var_17 <= var_9 )
        {
            if ( !isdefined( self.rocketpodup ) || !self.rocketpodup )
                mech_raise_rocket_pod( 1 );

            thread mech_random_missile_attractors( self.enemy );
            var_18 = 0;

            while ( var_18 < var_3 )
            {
                mech_fire_rockets();
                var_18++;
                wait 0.5;

                if ( isdefined( self.emp ) && self.emp || animscripts\utility::isdoingpain() )
                    break;
            }

            thread mech_random_missile_attractor_cleanup( 1 );

            if ( isdefined( self.emp ) && self.emp || animscripts\utility::isdoingpain() )
                mech_lower_rocket_pod( 1 );
            else if ( randomfloatrange( 0, 100 ) < var_4 )
                mech_lower_rocket_pod( 1 );

            wait(0.5 * var_5 + randomfloatrange( 0, var_5 ));
        }

        wait(var_7);
    }

    self.isshootingrockets = 0;
}

mech_random_missile_attractors( var_0 )
{
    if ( !isdefined( self.attractornumber ) )
        self.attractornumber = 6;

    if ( !isdefined( self.repulsornumber ) )
        self.repulsornumber = 3;

    var_1 = 130;
    var_2 = 130;
    var_3 = 200;
    var_4 = mech_precise_target_position( self, var_0 );
    var_5 = ( var_4 + self.origin ) / 2;
    var_6 = 1500;
    var_7 = 2000;
    var_8 = 3000;
    var_9 = 128;
    var_10 = 256;
    var_11 = 1200;
    self.mechmissileattractors = [];
    self.mechmissilerepulsors = [];

    if ( level._mech_globals.num_missile_attractors + self.attractornumber <= 10 )
    {
        for ( var_12 = 0; var_12 < self.attractornumber; var_12++ )
        {
            var_13 = randomintrange( -1 * var_1, var_1 );
            var_14 = randomintrange( -1 * var_2, var_2 );
            var_15 = randomintrange( 0, var_3 );
            var_16 = var_5 + ( var_13, var_14, var_15 );
            self.mechmissileattractors[var_12] = missile_createattractororigin( var_16, var_7, var_10 );
            level._mech_globals.num_missile_attractors++;
        }
    }

    if ( level._mech_globals.num_missile_repulsors + self.repulsornumber <= 10 )
    {
        for ( var_12 = 0; var_12 < self.repulsornumber; var_12++ )
        {
            var_13 = randomintrange( -1 * var_1, var_1 );
            var_14 = randomintrange( -1 * var_2, var_2 );
            var_15 = randomintrange( 0, var_3 );
            var_16 = var_5 + ( var_13, var_14, var_15 );
            self.mechmissilerepulsors[var_12] = missile_createrepulsororigin( var_16, var_6, var_9 );
            level._mech_globals.num_missile_repulsors++;
        }
    }

    if ( !isdefined( var_0 ) )
    {
        self.mechmissileattractors[self.attractornumber] = undefined;
        return;
    }

    if ( level._mech_globals.num_missile_attractors + 1 <= 10 )
    {
        self.mechmissileattractors[self.attractornumber] = missile_createattractorent( var_0, var_8, var_11 );
        level._mech_globals.num_missile_attractors++;
    }

    thread mech_rocket_fire_timeout( var_0 );
}

mech_random_missile_attractor_cleanup( var_0 )
{
    wait(var_0);

    if ( isdefined( self ) )
    {
        if ( isdefined( self.mechmissileattractors ) )
        {
            for ( var_1 = 0; var_1 < self.attractornumber + 1; var_1++ )
            {
                if ( isdefined( self.mechmissileattractors[var_1] ) )
                {
                    missile_deleteattractor( self.mechmissileattractors[var_1] );
                    level._mech_globals.num_missile_attractors--;
                }
            }
        }

        if ( isdefined( self.mechmissilerepulsors ) )
        {
            for ( var_1 = 0; var_1 < self.repulsornumber; var_1++ )
            {
                if ( isdefined( self.mechmissilerepulsors[var_1] ) )
                {
                    missile_deleteattractor( self.mechmissilerepulsors[var_1] );
                    level._mech_globals.num_missile_repulsors--;
                }
            }
        }

        self.mechmissileattractors = [];
        self.mechmissilerepulsors = [];
    }
}

mech_fire_rockets()
{
    self endon( "death" );
    var_0 = 48;
    var_1 = 64;
    var_2 = 3;
    var_3 = 6;
    var_4 = 100;
    var_5 = 24;
    var_6 = 0.1;
    var_7 = 0.4;
    var_8 = 12;
    var_9 = "tag_rocket";
    var_10 = 0.2;
    var_11 = randomintrange( var_2 + 1, var_3 + 1 );
    var_12 = 20;
    var_13 = 20;
    var_14 = 16;

    for ( var_15 = 1; var_15 < var_11; var_15++ )
    {
        var_16 = var_9 + var_15;
        var_17 = self gettagorigin( var_16 );
        var_18 = self gettagangles( var_16 );
        var_19 = anglestoforward( var_18 );
        var_19 = vectornormalize( var_19 );
        var_20 = randomintrange( -1 * var_12, var_12 );
        var_21 = randomintrange( -1 * var_13, var_13 );
        var_22 = randomintrange( -1 * var_14, var_14 );
        var_23 = var_17 + var_19 * var_5;
        var_24 = var_17 + ( var_19 * var_4 + ( var_20, var_21, var_22 ) );
        var_25 = magicbullet( "mech_rocket_deploy", var_23, var_24 );
        playfx( level.mech_fx["rocket_muzzle_flash"], var_17, var_19, ( 0, 0, 1 ) );

        if ( isdefined( var_25 ) )
        {
            var_26 = randomfloatrange( var_6, var_7 );
            var_25 thread mech_rocket_deploy_projectile_think( self, self.enemy, var_26 );
        }

        wait 0.05;
    }

    wait 0.25;
}

mech_precise_target_position( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        return var_1.origin;
    else
        return 400 * anglestoforward( var_0.angles );
}

mech_rocket_deploy_projectile_think( var_0, var_1, var_2 )
{
    var_3 = 32;
    var_4 = self.origin;
    wait(var_2);

    if ( isdefined( self ) )
    {
        var_5 = ( randomintrange( -1 * var_3, var_3 ), randomintrange( -1 * var_3, var_3 ), randomintrange( -1 * var_3, var_3 ) );
        var_6 = mech_precise_target_position( self, var_1 ) + var_5;
        var_7 = magicbullet( "mech_rocket", self.origin, var_6 );
        playfx( level.mech_fx["rocket_seperation"], self.origin, anglestoforward( self.angles ), ( 0, 0, 1 ) );
        var_7 thread mech_rocket_projectile_think( var_1, var_6, var_0 );
        var_7.owner = var_0;
        self delete();
    }
}

mech_rocket_fire_timeout( var_0 )
{
    wait 1.0;

    if ( isdefined( self.mechmissileattractors ) && isdefined( self.mechmissileattractors[self.attractornumber] ) )
    {
        missile_deleteattractor( self.mechmissileattractors[self.attractornumber] );
        var_1 = mech_precise_target_position( self, var_0 );
        self.mechmissileattractors[self.attractornumber] = missile_createattractororigin( var_1, 5000, 256 );
    }
}

mech_rocket_projectile_think( var_0, var_1, var_2 )
{
    self endon( "death" );

    if ( isdefined( self ) )
    {
        if ( isdefined( var_0 ) )
            self _meth_81D9( var_0, ( 0, 0, 32 ) );
        else
            self _meth_81DA( var_1 );

        self hide();
        var_3 = randomintrange( 0, 3 );
        playfxontag( level.mech_fx["rocket_trail_" + var_3], self, "tag_origin" );
    }

    var_4 = self.origin;

    for (;;)
    {
        var_4 = self.origin;
        wait 0.1;
    }
}

mech_raise_rocket_pod( var_0 )
{
    var_1 = 0.2;
    var_2 = %mech_add_rocketpack_raise;
    self _meth_8145( var_2, 1, var_1 );
    soundscripts\_snd::snd_message( "snd_mech_add_rocketpack_raise" );

    if ( isdefined( var_0 ) && var_0 )
        wait(getanimlength( var_2 ));

    self.rocketpodup = 1;
}

mech_lower_rocket_pod( var_0 )
{
    var_1 = 0.2;
    var_2 = %mech_add_rocketpack_lower;
    self _meth_8145( var_2, 1, var_1 );
    soundscripts\_snd::snd_message( "snd_mech_add_rocketpack_lower" );

    if ( isdefined( var_0 ) && var_0 )
        wait(getanimlength( var_2 ));

    self.rocketpodup = 0;
}

mech_generic_attacking_behavior()
{
    self endon( "death" );
    self endon( "stop_generic_attacking" );

    for (;;)
    {
        wait 0.2;
        animscripts\combat::tryexposedreacquire();

        if ( isdefined( self.enemy ) )
        {
            self.goalradius = 200;
            self.goalheight = 81;
            animscripts\combat_utility::tryrunningtoenemy( 1 );
        }
    }
}

mech_target_attacker( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( self.targetattacker ) && self.targetattacker )
    {
        self.usechokepoints = 0;

        if ( isdefined( var_1 ) && self _meth_81BE( var_1 ) )
            self _meth_81A6( var_1.origin );
    }
}

mech_hunt_stealth_behavior()
{
    self endon( "death" );
    self endon( "stop_hunting" );
    self endon( "_stealth_enemy_alert_level_change" );
    self.usechokepoints = 1;
    var_0 = 0;
    var_1 = randomfloatrange( 3.0, 4.0 );

    for (;;)
    {
        wait 0.5;

        if ( isdefined( self.enemy ) && isdefined( level.player ) && self.enemy == level.player )
        {
            if ( isdefined( level._cloaked_stealth_settings ) && isdefined( level._cloaked_stealth_settings.cloak_on ) && level._cloaked_stealth_settings.cloak_on )
            {
                wait(randomfloatrange( 0.3, 3.0 ));
                continue;
            }
        }

        if ( isdefined( self.enemy ) )
        {
            self _meth_81A6( self _meth_81C1( self.enemy ) );
            self.goalradius = 400;
            self.goalheight = 81;
        }
        else
            var_0++;

        if ( 0.5 * var_0 > var_1 )
            break;
    }
}

mech_hunt_immediately_behavior()
{
    self endon( "death" );
    self endon( "stop_hunting" );
    self.usechokepoints = 0;

    for (;;)
    {
        wait 0.5;

        if ( isdefined( self.enemy ) )
        {
            self _meth_81A6( self.enemy.origin );
            self.goalradius = 200;
            self.goalheight = 81;
        }
    }
}

mech_emp_function()
{
    mech_emp_loop( %mech_emp_react, 6.0 );
}

mech_emp_loop( var_0, var_1 )
{
    self endon( "death" );

    if ( isdefined( self.emp ) && self.emp || common_scripts\utility::isflashed() )
        return;

    self.a.pose = "stand";
    self.allowdeath = 1;
    var_2 = self.flashbangimmunity;
    self.flashbangimmunity = 0;
    self.emp = 1;
    maps\_utility::flashbangstart( var_1 );
    self.flashbangimmunity = var_2;
    thread empanim( var_1 );
}

empanim( var_0 )
{
    self endon( "death" );

    if ( isdefined( self.emp ) && !self.emp || !common_scripts\utility::isflashed() )
        return;

    self notify( "start_emp_effect" );
    var_1 = self.minpaindamage;
    self.minpaindamage = 20000;
    maps\_utility::disable_pain();
    var_2 = getanimlength( %mech_emp_react );
    wait(var_2);
    self _meth_8143( %mech_emp_idle, 1, 0.2, 1 );
    var_3 = getanimlength( %mech_emp_restart );
    wait(var_0 - var_3 + var_2);

    if ( common_scripts\utility::isflashed() )
    {
        self _meth_8143( %mech_emp_restart, 1, 1, 1 );
        soundscripts\_snd::snd_message( "snd_mech_emp_restart" );
    }

    wait(var_3);
    maps\_utility::enable_pain();
    self.minpaindamage = var_1;
    self.emp = 0;
}

init_mech_animsets()
{
    if ( isdefined( anim.archetypes["mech"] ) )
        return;

    anim.archetypes["mech"] = [];
    init_animset_mech_default_stand();
    init_animset_mech_walk_move();
    init_animset_mech_run_move();
    init_animset_mech_cqb_move();
    init_animset_mech_shoot_moving();
    init_mech_turn_animations();
    init_animset_mech_death();
    init_animset_mech_pain();
    init_animset_mech_flashed();
    init_animset_mech_grenade_animations();
    init_animset_mech_stop();
    init_animset_mech_addpain();
    anim.archetypes["mech"]["combat"]["surprise_stop"] = %mech_unaware_walk_stop;
    anim.archetypes["mech"]["combat"]["trans_to_combat"] = %mech_walk_start;
    init_amimset_mech_transition();
}

init_animset_mech_addpain()
{
    anim.initanimset = [];
    anim.initanimset["default"] = [ %mech_flinch_back, %mech_flinch_chest ];
    anim.initanimset["left_arm"] = %mech_flinch_lshoulder_down;
    anim.initanimset["right_arm"] = %mech_flinch_rshoulder_down;
    anim.initanimset["left_leg"] = %mech_flinch_lshoulder_up;
    anim.initanimset["right_leg"] = %mech_flinch_rshoulder_up;
    anim.archetypes["mech"]["additive_pain"] = anim.initanimset;
}

init_animset_mech_stop()
{
    var_0 = [];
    var_0["stand"][0] = [ %mech_stand_idle ];
    var_0["stand"][1] = [ %mech_stand_idle ];
    var_0["stand_cqb"][0] = [ %mech_stand_idle ];
    var_0["crouch"][0] = [ %mech_stand_idle ];
    anim.archetypes["mech"]["idle"] = var_0;
    var_0 = [];
    var_0["stand"][0] = [ 1 ];
    var_0["stand"][1] = [ 1 ];
    var_0["stand_cqb"][0] = [ 1 ];
    var_0["crouch"][0] = [ 1 ];
    anim.archetypes["mech"]["idle_weights"] = var_0;
    var_0 = [];
    var_0["stand"] = %mech_stand_idle;
    var_0["crouch"] = %mech_stand_idle;
    var_0["stand_smg"] = %mech_stand_idle;
    anim.archetypes["mech"]["idle_transitions"] = var_0;
}

init_amimset_mech_transition()
{
    var_0 = [];
    var_0["exposed"] = [];
    var_0["exposed"][1] = %mech_walk_stop_1;
    var_0["exposed"][2] = %mech_walk_stop_2;
    var_0["exposed"][3] = %mech_walk_stop_3;
    var_0["exposed"][4] = %mech_walk_stop_4;
    var_0["exposed"][6] = %mech_walk_stop_6;
    var_0["exposed"][7] = %mech_walk_stop_7;
    var_0["exposed"][8] = %mech_walk_stop_8;
    var_0["exposed"][9] = %mech_walk_stop_9;
    var_0["exposed_cqb"] = [];
    var_0["exposed_cqb"][1] = %mech_walk_stop_1;
    var_0["exposed_cqb"][2] = %mech_walk_stop_2;
    var_0["exposed_cqb"][3] = %mech_walk_stop_3;
    var_0["exposed_cqb"][4] = %mech_walk_stop_4;
    var_0["exposed_cqb"][6] = %mech_walk_stop_6;
    var_0["exposed_cqb"][7] = %mech_walk_stop_7;
    var_0["exposed_cqb"][8] = %mech_walk_stop_8;
    var_0["exposed_cqb"][9] = %mech_walk_stop_9;
    anim.archetypes["mech"]["cover_trans"] = var_0;
    var_0 = [];
    var_0["exposed"] = [];
    var_0["exposed"][1] = %mech_walk_start_1;
    var_0["exposed"][2] = %mech_walk_start_2;
    var_0["exposed"][3] = %mech_walk_start_3;
    var_0["exposed"][4] = %mech_walk_start_4;
    var_0["exposed"][6] = %mech_walk_start_6;
    var_0["exposed"][7] = %mech_walk_start_7;
    var_0["exposed"][8] = %mech_walk_start_8;
    var_0["exposed"][9] = %mech_walk_start_9;
    var_0["exposed_cqb"] = [];
    var_0["exposed_cqb"][1] = %mech_walk_start_1;
    var_0["exposed_cqb"][2] = %mech_walk_start_2;
    var_0["exposed_cqb"][3] = %mech_walk_start_3;
    var_0["exposed_cqb"][4] = %mech_walk_start_4;
    var_0["exposed_cqb"][6] = %mech_walk_start_6;
    var_0["exposed_cqb"][7] = %mech_walk_start_7;
    var_0["exposed_cqb"][8] = %mech_walk_start_8;
    var_0["exposed_cqb"][9] = %mech_walk_start_9;
    anim.archetypes["mech"]["cover_exit"] = var_0;
    animscripts\init_move_transitions::inittransdistandanglesforarchetype( "mech" );
    initmechsplittimes();
    animscripts\init_move_transitions::getsplittimes( "mech" );
}

initmechsplittimes()
{

}

init_animset_mech_shoot_moving()
{
    var_0 = [];
    var_0["fire"] = %mech_walking_fire_auto;
    var_0["single"] = [ %mech_walking_fire_auto ];
    anim.archetypes["mech"]["shoot_while_moving"] = var_0;
}

init_mech_turn_animations()
{
    anim.initanimset = [];
    anim.initanimset[0] = %mech_run_turn_180;
    anim.initanimset[1] = %mech_run_turn_l135;
    anim.initanimset[2] = %mech_run_turn_l90;
    anim.initanimset[3] = %mech_run_turn_l45;
    anim.initanimset[5] = %mech_run_turn_r45;
    anim.initanimset[6] = %mech_run_turn_r90;
    anim.initanimset[7] = %mech_run_turn_r135;
    anim.initanimset[8] = %mech_run_turn_180;
    anim.archetypes["mech"]["run_turn"] = anim.initanimset;
    anim.archetypes["mech"]["cqb_run_turn"] = anim.initanimset;
    anim.initanimset = [];
    anim.initanimset[0] = %mech_walk_turn_2;
    anim.initanimset[1] = %mech_walk_turn_1;
    anim.initanimset[2] = %mech_walk_turn_4;
    anim.initanimset[3] = %mech_walk_turn_7;
    anim.initanimset[5] = %mech_walk_turn_9;
    anim.initanimset[6] = %mech_walk_turn_6;
    anim.initanimset[7] = %mech_walk_turn_3;
    anim.initanimset[8] = %mech_walk_turn_2;
    anim.archetypes["mech"]["cqb_turn"] = anim.initanimset;
    anim.initanimset = [];
    anim.initanimset["turn_left_45"] = %mech_turn_45_l;
    anim.initanimset["turn_left_90"] = %mech_turn_90_l;
    anim.initanimset["turn_left_135"] = %mech_turn_135_l;
    anim.initanimset["turn_left_180"] = %mech_turn_180_l;
    anim.initanimset["turn_right_45"] = %mech_turn_45_r;
    anim.initanimset["turn_right_90"] = %mech_turn_90_r;
    anim.initanimset["turn_right_135"] = %mech_turn_135_r;
    anim.initanimset["turn_right_180"] = %mech_turn_180_r;
    anim.archetypes["mech"]["exposed_turn"] = anim.initanimset;
}

init_animset_mech_grenade_animations()
{
    anim.initanimset = [];
    anim.initanimset["cower_squat"] = %mech_exposed_squat_down_mech_grenade_f;
    anim.initanimset["cower_dive_back"] = %mech_exposed_dive_grenade_b;
    anim.initanimset["cower_dive_front"] = %mech_exposed_dive_grenade_f;
    anim.initanimset["return_throw_short"] = [ %mech_grenade_return_running_throw_forward, %mech_grenade_return_standing_throw_overhand_forward ];
    anim.initanimset["return_throw_long"] = [ %mech_grenade_return_standing_throw_overhand_forward ];
    anim.initanimset["return_throw_default"] = [ %mech_grenade_return_running_throw_forward, %mech_grenade_return_standing_throw_overhand_forward ];
    anim.archetypes["mech"]["grenade"] = anim.initanimset;
}

init_animset_mech_pain()
{
    anim.initanimset = [];
    anim.initanimset["torso_upper"] = [ %mech_stand_exposed_extendedpain_neck ];
    anim.initanimset["torso_upper_extended"] = [ %mech_stand_exposed_extendedpain_gut, %mech_stand_exposed_extendedpain_stomach ];
    anim.initanimset["torso_lower"] = [ %mech_exposed_pain_groin, %mech_stand_exposed_extendedpain_hip ];
    anim.initanimset["torso_lower_extended"] = [ %mech_stand_exposed_extendedpain_gut, %mech_stand_exposed_extendedpain_stomach ];
    anim.initanimset["head"] = [ %mech_exposed_pain_face, %mech_stand_exposed_extendedpain_neck ];
    anim.initanimset["head_extended"] = [ %mech_exposed_pain_face, %mech_stand_exposed_extendedpain_neck ];
    anim.initanimset["right_arm"] = [ %mech_exposed_pain_right_arm ];
    anim.initanimset["right_arm_extended"] = [ %mech_exposed_pain_right_arm ];
    anim.initanimset["left_arm"] = [ %mech_stand_exposed_extendedpain_shoulderswing ];
    anim.initanimset["left_arm_extended"] = [ %mech_stand_exposed_extendedpain_shoulderswing ];
    anim.initanimset["leg"] = [ %mech_exposed_pain_groin ];
    anim.initanimset["leg_extended"] = [ %mech_stand_exposed_extendedpain_stomach ];
    anim.initanimset["foot"] = [ %mech_stand_exposed_extendedpain_thigh ];
    anim.initanimset["foot_extended"] = [ %mech_stand_exposed_extendedpain_thigh ];
    anim.initanimset["default_long"] = [ %mech_stand_extendedpainc, %mech_stand_exposed_extendedpain_chest, %mech_stand_exposed_extendedpain_stomach ];
    anim.initanimset["default_short"] = [ %mech_exposed_pain_right_arm, %mech_exposed_pain_face, %mech_exposed_pain_groin ];
    anim.initanimset["default_extended"] = [ %mech_stand_extendedpainb, %mech_stand_exposed_extendedpain_chest, %mech_stand_extendedpainc ];
    anim.initanimset["damage_shield_pain_array"] = [ %mech_stand_exposed_extendedpain_gut, %mech_stand_exposed_extendedpain_stomach, %mech_stand_exposed_extendedpain_chest ];
    anim.initanimset["run_long"] = [ %mech_stand_extendedpainc, %mech_stand_extendedpainb, %mech_stand_exposed_extendedpain_chest ];
    anim.initanimset["run_medium"] = [ %mech_stand_extendedpainc, %mech_stand_extendedpainb, %mech_stand_exposed_extendedpain_chest ];
    anim.initanimset["run_short"] = [ %mech_stand_extendedpainc, %mech_stand_extendedpainb, %mech_stand_exposed_extendedpain_chest ];
    anim.initanimset["back"] = %mech_stand_extendedpainb;
    anim.archetypes["mech"]["pain"] = anim.initanimset;
}

init_animset_mech_death()
{
    var_0 = [];
    var_0["directed_energy_stand_front_head"] = [ %mech_stand_death_headshot_slowfall ];
    var_0["directed_energy_stand_front_legs"] = [ %mech_stand_death_leg ];
    var_0["directed_energy_stand_front_default"] = [ %mech_stand_death_tumbleforward ];
    var_0["directed_energy_stand_back_default"] = [ %mech_stand_death_tumbleback ];
    var_0["strong_legs"] = [ %mech_stand_death_leg ];
    var_0["strong_torso_lower"] = [ %mech_stand_death_guts ];
    var_0["strong_default"] = [ %mech_stand_death_stumbleforward, %mech_stand_death_tumbleforward ];
    var_0["strong_right"] = [ %mech_stand_death_shoulder_spin, %mech_stand_death_fallside ];
    var_0["strong_left"] = [ %mech_stand_death_shoulder_spin, %mech_stand_death_fallside ];
    var_0["running_forward"] = [ %mech_stand_death_tumbleforward, %mech_exposed_death_flop ];
    var_0["running_forward_f"] = [ %mech_stand_death_tumbleback ];
    var_0["stand_lower_body"] = [ %mech_stand_death_crotch, %mech_stand_death_leg ];
    var_0["stand_lower_body_extended"] = [ %mech_stand_death_crotch, %mech_stand_death_guts ];
    var_0["stand_head"] = [ %mech_stand_death_face, %mech_stand_death_headshot_slowfall ];
    var_0["stand_neck"] = [ %mech_exposed_death_neckgrab ];
    var_0["stand_left_shoulder"] = [ %mech_stand_death_shoulder_spin ];
    var_0["stand_torso_upper"] = [ %mech_stand_death_tumbleforward ];
    var_0["stand_torso_upper_extended"] = [ %mech_stand_death_fallside ];
    var_0["stand_front_head"] = [ %mech_stand_death_face, %mech_stand_death_headshot_slowfall ];
    var_0["stand_front_head_extended"] = [ %mech_stand_death_head_straight_back ];
    var_0["stand_front_torso"] = [ %mech_stand_death_tumbleback ];
    var_0["stand_front_torso_extended"] = [ %mech_stand_death_chest_stunned ];
    var_0["stand_back"] = [ %mech_exposed_death_flop ];
    var_0["stand_default"] = [ %mech_exposed_death_flop ];
    var_0["stand_default_firing"] = [ %mech_exposed_death_flop ];
    var_0["stand_backup_default"] = %mech_exposed_death_flop;
    var_0["melee_standing_front"] = [ %mech_exposed_death_neckgrab ];
    var_0["melee_standing_back"] = [ %mech_exposed_death_flop ];
    var_0["melee_standing_left"] = [ %mech_exposed_death_flop ];
    var_0["melee_standing_right"] = [ %mech_exposed_death_flop ];
    var_0["melee_crouching_front"] = [ %mech_exposed_death_flop ];
    var_0["melee_crouching_back"] = [ %mech_exposed_death_flop ];
    var_0["melee_crouching_left"] = [ %mech_exposed_death_flop ];
    var_0["melee_crouching_right"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_stand_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_stand_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_stand_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_stand_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_stand_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_stand_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_stand_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_stand_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_stand_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_stand_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_stand_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_stand_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_crouch_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_crouch_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_crouch_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_crouch_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_crouch_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_crouch_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_crouch_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_crouch_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_crouch_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_crouch_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_crouch_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_crouch_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_prone_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_prone_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_prone_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_prone_stand"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_prone_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_prone_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_prone_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_prone_crouch"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_prone_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_back_prone_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_left_prone_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_right_prone_prone"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_stand_front_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_stand_back_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_stand_left_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_stand_right_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_crouch_front_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_crouch_back_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_crouch_left_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_crouch_right_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_prone_front_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_prone_back_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_prone_left_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_prone_right_head"] = [ %mech_exposed_death_flop ];
    var_0["melee_exo_front_lower"] = [ %mech_exposed_death_flop ];
    var_0["emp"] = [ %mech_emp_death ];
    anim.archetypes["mech"]["death"] = var_0;
}

init_animset_mech_cqb_move()
{
    anim.initanimset = [];
    anim.initanimset["sprint"] = %mech_runf;
    anim.initanimset["sprint_short"] = %mech_sprint;
    anim.initanimset["straight"] = %mech_walkf;
    anim.initanimset["fire"] = %mech_walking_fire_auto;
    anim.initanimset["single"] = [ %mech_walking_fire_auto ];
    anim.initanimset["move_f"] = %mech_walkf;
    anim.initanimset["move_l"] = %mech_stand_walk_left;
    anim.initanimset["move_r"] = %mech_stand_walk_right;
    anim.initanimset["move_b"] = %mech_stand_walk_back;
    anim.initanimset["stairs_up"] = %mech_run_stairs_up;
    anim.initanimset["stairs_up_in"] = %mech_run_stairs_up_2_run;
    anim.initanimset["stairs_down_out"] = %mech_run_stairs_down_2_run;
    anim.initanimset["stairs_down"] = %mech_run_stairs_down;
    anim.initanimset["aim_2"] = %mech_walking_aim_low;
    anim.initanimset["aim_4"] = %mech_walking_aim_left;
    anim.initanimset["aim_6"] = %mech_walking_aim_right;
    anim.initanimset["aim_8"] = %mech_walking_aim_high;
    anim.initanimset["aim_5"] = %mech_walking_aim5;
    anim.archetypes["mech"]["cqb"] = anim.initanimset;
}

init_animset_mech_default_stand()
{
    anim.initanimset = [];
    anim.initanimset["add_aim_up"] = %mech_aim_high;
    anim.initanimset["add_aim_down"] = %mech_aim_low;
    anim.initanimset["add_aim_left"] = %mech_aim_left;
    anim.initanimset["add_aim_right"] = %mech_aim_right;
    anim.initanimset["straight_level"] = %mech_aim5;
    anim.initanimset["aim_2"] = %mech_aim_low;
    anim.initanimset["aim_4"] = %mech_aim_left;
    anim.initanimset["aim_6"] = %mech_aim_right;
    anim.initanimset["aim_8"] = %mech_aim_high;
    anim.initanimset["aim_5"] = %mech_aim5;
    anim.initanimset["fire"] = %mech_walking_fire_auto;
    anim.initanimset["single"] = animscripts\utility::array( %mech_stand_fire_burst_semi );
    set_animarray_mech_burst_and_semi_fire_stand();
    anim.initanimset["exposed_idle"] = animscripts\utility::array( %mech_combat_idle );
    anim.initanimset["reload"] = animscripts\utility::array( %mech_stand_reload );
    anim.initanimset["reload_crouchhide"] = animscripts\utility::array( %mech_stand_reload );
    set_animarray_mech_standing_turns();
    anim.archetypes["mech"]["default_stand"] = anim.initanimset;
    anim.archetypes["mech"]["cqb_stand"] = anim.initanimset;
}

init_animset_mech_run_move()
{
    anim.initanimset = [];
    anim.initanimset["sprint"] = %mech_sprint;
    anim.initanimset["sprint_short"] = %mech_sprint;
    anim.initanimset["fire"] = %mech_walking_fire_auto;
    anim.initanimset["single"] = [ %mech_walking_fire_auto ];
    anim.initanimset["straight"] = %mech_runf;
    anim.initanimset["smg_straight"] = %mech_runf;
    anim.initanimset["aim_2"] = %mech_walking_aim_low;
    anim.initanimset["aim_4"] = %mech_walking_aim_left;
    anim.initanimset["aim_6"] = %mech_walking_aim_right;
    anim.initanimset["aim_8"] = %mech_walking_aim_high;
    anim.initanimset["aim_5"] = %mech_walking_aim5;
    anim.initanimset["move_f"] = %mech_runf;
    anim.initanimset["move_l"] = %mech_stand_walk_left;
    anim.initanimset["move_r"] = %mech_stand_walk_right;
    anim.initanimset["move_b"] = %mech_stand_walk_back;
    anim.initanimset["stairs_up"] = %mech_run_stairs_up;
    anim.initanimset["stairs_up_in"] = %mech_run_stairs_up_2_run;
    anim.initanimset["stairs_up_out"] = %mech_run_stairs_up_2_run;
    anim.initanimset["stairs_down"] = %mech_run_stairs_down;
    set_animarray_mech_burst_and_semi_fire_walk();
    anim.archetypes["mech"]["run"] = anim.initanimset;
}

init_animset_mech_walk_move()
{
    anim.initanimset = [];
    anim.initanimset["sprint"] = %mech_sprint;
    anim.initanimset["straight"] = %mech_walkf;
    anim.initanimset["fire"] = %mech_walking_fire_auto;
    anim.initanimset["single"] = [ %mech_walking_fire_auto ];
    anim.initanimset["move_f"] = %mech_walkf;
    anim.initanimset["move_l"] = %mech_stand_walk_left;
    anim.initanimset["move_r"] = %mech_stand_walk_right;
    anim.initanimset["move_b"] = %mech_stand_walk_back;
    anim.initanimset["aim_2"] = %mech_walking_aim_low;
    anim.initanimset["aim_4"] = %mech_walking_aim_left;
    anim.initanimset["aim_6"] = %mech_walking_aim_right;
    anim.initanimset["aim_8"] = %mech_walking_aim_high;
    anim.initanimset["aim_5"] = %mech_walking_aim5;
    anim.initanimset["stairs_up"] = %mech_run_stairs_up;
    anim.initanimset["stairs_down"] = %mech_run_stairs_down;
    anim.initanimset["stairs_up_in"] = %mech_run_stairs_up_2_run;
    anim.initanimset["stairs_up_out"] = %mech_run_stairs_up_2_run;
    set_animarray_mech_burst_and_semi_fire_walk();
    anim.archetypes["mech"]["walk"] = anim.initanimset;
}

set_animarray_mech_standing_turns()
{
    anim.initanimset["turn_left_45"] = %mech_turn_45_l;
    anim.initanimset["turn_left_90"] = %mech_turn_90_l;
    anim.initanimset["turn_left_135"] = %mech_turn_135_l;
    anim.initanimset["turn_left_180"] = %mech_turn_180_l;
    anim.initanimset["turn_right_45"] = %mech_turn_45_r;
    anim.initanimset["turn_right_90"] = %mech_turn_90_r;
    anim.initanimset["turn_right_135"] = %mech_turn_135_r;
    anim.initanimset["turn_right_180"] = %mech_turn_180_r;
}

set_animarray_mech_burst_and_semi_fire_stand()
{
    anim.initanimset["burst2"] = %mech_stand_fire_burst;
    anim.initanimset["burst3"] = %mech_stand_fire_burst;
    anim.initanimset["burst4"] = %mech_stand_fire_burst;
    anim.initanimset["burst5"] = %mech_stand_fire_burst;
    anim.initanimset["burst6"] = %mech_stand_fire_burst;
    anim.initanimset["semi1"] = %mech_stand_fire_burst_semi;
    anim.initanimset["semi3"] = %mech_stand_fire_burst_semi;
    anim.initanimset["semi4"] = %mech_stand_fire_burst_semi;
    anim.initanimset["semi5"] = %mech_stand_fire_burst_semi;
}

set_animarray_mech_burst_and_semi_fire_walk()
{
    anim.initanimset["burst2"] = %mech_walk_fire_burst;
    anim.initanimset["burst3"] = %mech_walk_fire_burst;
    anim.initanimset["burst4"] = %mech_walk_fire_burst;
    anim.initanimset["burst5"] = %mech_walk_fire_burst;
    anim.initanimset["burst6"] = %mech_walk_fire_burst;
    anim.initanimset["semi1"] = %mech_walk_fire_burst_semi;
    anim.initanimset["semi3"] = %mech_walk_fire_burst_semi;
    anim.initanimset["semi4"] = %mech_walk_fire_burst_semi;
    anim.initanimset["semi5"] = %mech_walk_fire_burst_semi;
}

init_animset_mech_flashed()
{
    var_0 = [];
    var_0["flashed"] = [ %mech_emp_react ];
    anim.archetypes["mech"]["flashed"] = var_0;
    anim.flashanimindex["mech"] = 0;
}
