// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

fake_death_over_time( var_0, var_1, var_2 )
{
    self endon( "death" );
    wait(randomintrange( var_1, var_2 ));

    if ( isdefined( self ) && isai( self ) && isalive( self ) )
    {
        if ( var_0 == "bullet" )
            fake_death_bullet();
        else
            fake_death_bullet();
    }
}

fake_death_bullet( var_0 )
{
    self endon( "death" );

    if ( !issentient( self ) || !isalive( self ) )
        return;

    if ( isdefined( self.bloody_death ) && self.bloody_death )
        return;

    self.bloody_death = 1;

    if ( isdefined( var_0 ) )
        wait(randomfloat( var_0 ));

    var_1 = [];
    var_1[0] = "j_hip_le";
    var_1[1] = "j_hip_ri";
    var_1[2] = "j_head";
    var_1[3] = "j_spine4";
    var_1[4] = "j_elbow_le";
    var_1[5] = "j_elbow_ri";
    var_1[6] = "j_clavicle_le";
    var_1[7] = "j_clavicle_ri";

    for ( var_2 = 0; var_2 < 3 + randomint( 5 ); var_2++ )
    {
        var_3 = randomintrange( 0, var_1.size );
        thread fake_death_bullet_fx( var_1[var_3], undefined );
        wait(randomfloat( 0.1 ));
    }

    self dodamage( self.health + 50, self.origin );
}

fake_death_bullet_fx( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level._effect["flesh_hit"];

    playfxontag( var_1, self, var_0 );
}

array_setgoalvolume( var_0, var_1 )
{
    var_2 = getent( var_1, "targetname" );
    wait 0.05;

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4 ) && isai( var_4 ) )
        {
            var_4 cleargoalvolume();
            var_4 setgoalvolumeauto( var_2 );
        }
    }
}

radio_dialogue_queue_single( var_0 )
{
    maps\_shg_utility::conversation_start();
    maps\_utility::radio_dialogue( var_0 );
    maps\_shg_utility::conversation_stop();
}

dialogue_queue_single( var_0 )
{
    maps\_shg_utility::conversation_start();
    maps\_utility::dialogue_queue( var_0 );
    maps\_shg_utility::conversation_stop();
}

dialogue_random_line( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = [];

    if ( isdefined( var_0 ) )
        var_8[var_8.size] = var_0;

    if ( isdefined( var_1 ) )
        var_8[var_8.size] = var_1;

    if ( isdefined( var_2 ) )
        var_8[var_8.size] = var_2;

    if ( isdefined( var_3 ) )
        var_8[var_8.size] = var_3;

    if ( isdefined( var_4 ) )
        var_8[var_8.size] = var_4;

    if ( isdefined( var_5 ) )
        var_8[var_8.size] = var_5;

    if ( isdefined( var_6 ) )
        var_8[var_8.size] = var_6;

    if ( isdefined( var_7 ) )
        var_8[var_8.size] = var_7;

    if ( !isdefined( level.dialogue_random_last_line ) )
        level.dialogue_random_last_line = undefined;

    var_9 = 0;

    while ( !var_9 )
    {
        var_10 = common_scripts\utility::random( var_8 );

        if ( isdefined( level.dialogue_random_last_line ) && level.dialogue_random_last_line == var_10 )
            continue;
        else
        {
            if ( isdefined( self ) && isai( self ) )
                dialogue_queue_single( var_10 );
            else
                radio_dialogue_queue_single( var_10 );

            level.dialogue_random_last_line = var_10;
            var_9 = 1;
        }

        wait 0.05;
    }

    var_9 = 0;
}

hint_neverbreak()
{
    return 0;
}

setup_ignore_suppression_triggers()
{
    var_0 = getentarray( "trigger_ignore_suppression", "targetname" );

    foreach ( var_2 in var_0 )
        level thread ignore_suppression_trigger_think( var_2 );
}

ignore_suppression_trigger_think( var_0 )
{
    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isdefined( var_1 ) && isai( var_1 ) && !var_1 isbadguy() )
            var_1 thread ignore_suppression_trigger_ai_think( var_0 );
    }
}

ignore_suppression_trigger_ai_think( var_0 )
{
    self notify( "ignore_suppression_trigger_ai_think_stop" );
    self endon( "ignore_suppression_trigger_ai_think_stop" );
    self endon( "death" );
    maps\_utility::set_ignoresuppression( 1 );

    while ( self istouching( var_0 ) )
        wait 0.5;

    maps\_utility::set_ignoresuppression( 0 );
}

add_hint_background( var_0 )
{
    if ( isdefined( var_0 ) )
        level.hintbackground = maps\_hud_util::createicon( "popmenu_bg", 650, 50 );
    else
        level.hintbackground = maps\_hud_util::createicon( "popmenu_bg", 650, 30 );

    level.hintbackground.hidewheninmenu = 1;
    level.hintbackground maps\_hud_util::setpoint( "TOP", undefined, 0, 110 );
    level.hintbackground.alpha = 0.5;
    level.hintbackground.sort = 0;
}

clear_hints()
{
    if ( isdefined( level.hintelem ) )
        level.hintelem maps\_hud_util::destroyelem();

    if ( isdefined( level.iconelem ) )
        level.iconelem maps\_hud_util::destroyelem();

    if ( isdefined( level.iconelem2 ) )
        level.iconelem2 maps\_hud_util::destroyelem();

    if ( isdefined( level.iconelem3 ) )
        level.iconelem3 maps\_hud_util::destroyelem();

    if ( isdefined( level.hintbackground ) )
        level.hintbackground maps\_hud_util::destroyelem();

    level notify( "clearing_hints" );
}

hint_with_background( var_0, var_1, var_2 )
{
    clear_hints();
    level endon( "clearing_hints" );
    add_hint_background( var_2 );
    level.hintelem = maps\_hud_util::createfontstring( "default", 2 );
    level.hintelem.hidewheninmenu = 1;
    level.hintelem maps\_hud_util::setpoint( "TOP", undefined, 0, 110 );
    level.hintelem.sort = 0.5;
    level.high_priority_hint = 1;
    level.hintelem settext( var_0 );

    if ( isdefined( var_1 ) )
        wait(var_1);
    else
        return;

    level.high_priority_hint = undefined;
    level.hintelem fadeovertime( 0.5 );
    level.hintelem.alpha = 0;
    wait 0.5;
    clear_hints();
}

dog_monitor_goal_ent( var_0, var_1 )
{
    level endon( "special_op_terminated" );
    self endon( "death" );
    var_2 = 30;
    var_3 = self.meleeattackdist + var_2;

    for (;;)
    {
        wait 0.05;

        if ( dog_enemy_laststand_check() )
            continue;

        if ( isdefined( self.enemy ) && self.movemode == "stop" )
        {
            if ( get_next_allow_melee_time( self ) > gettime() )
                continue;

            self setgoalentity( var_1 );
            maps\_utility::set_ignoreall( 1 );
            continue;
        }

        if ( isdefined( self.ignoreall ) && self.ignoreall )
        {
            var_4 = getnodesinradiussorted( self.favoriteenemy.origin, 16, 0, 64, "Path" );

            if ( isdefined( var_4 ) && var_4.size > 0 )
            {
                self setgoalentity( self.favoriteenemy );
                maps\_utility::set_ignoreall( 0 );
                continue;
            }

            if ( maps\_utility::is_coop() && distance2d( self.origin, var_1.origin ) < 125 )
            {
                var_5 = get_different_favoriteenemy();

                if ( var_5 so_can_player_see_dog( self ) )
                {
                    dog_swap_enemy();
                    maps\_utility::set_ignoreall( 0 );
                }
            }
        }
    }
}

so_can_player_see_dog( var_0 )
{
    var_1 = self geteye();
    var_2 = var_0 geteye();

    if ( sighttracepassed( var_1, var_2, 1, self, var_0 ) )
        return 1;

    return 0;
}

get_next_allow_melee_time( var_0 )
{
    var_1 = 0;

    if ( isdefined( self.enemy.dogattackallowtime ) )
        var_1 = self.enemy.dogattackallowtime + 2500;

    return var_1;
}

dog_enemy_laststand_check()
{
    if ( !maps\_utility::is_coop() )
        return 0;

    if ( isdefined( self.favoriteenemy.laststand ) && self.favoriteenemy.laststand )
    {
        dog_swap_enemy();
        return 1;
    }

    return 0;
}

dog_swap_enemy()
{
    if ( !maps\_utility::is_coop() )
        return;

    var_0 = get_different_favoriteenemy();
    self setgoalentity( var_0 );
    maps\_utility::set_favoriteenemy( var_0 );
}

get_different_favoriteenemy()
{
    var_0 = self.favoriteenemy != level.player2;
    return level.players[var_0];
}

ai_wave_spawn( var_0, var_1 )
{
    var_0 = getentarray( var_0, "targetname" );
    var_2 = [];

    if ( !isdefined( var_1 ) )
        var_1 = var_0.size;

    var_0 = common_scripts\utility::array_randomize( var_0 );

    for ( var_3 = 0; var_3 < var_1; var_3++ )
    {
        var_4 = var_0[var_3] maps\_utility::spawn_ai( 1 );
        var_2[var_2.size] = var_4;
        wait 0.1;
        var_0[var_3].count = 1;
    }

    return var_2;
}

ai_wave_setgoalvolume( var_0, var_1 )
{
    var_1 = getent( var_1, "targetname" );
    wait 0.05;

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) && isalive( var_3 ) && isai( var_3 ) )
        {
            var_3 cleargoalvolume();
            var_3 setgoalvolumeauto( var_1 );
        }
    }
}

ai_wave_monitor_threshold( var_0, var_1, var_2 )
{
    level endon( var_2 );

    for (;;)
    {
        var_0 = maps\_utility::array_removedead( var_0 );

        if ( var_0.size <= var_1 )
        {
            if ( isdefined( var_2 ) )
                level notify( var_2 );
        }

        wait 0.1;
    }
}

ai_wave_monitor_retreat( var_0, var_1, var_2 )
{
    level waittill( var_1 );
    array_setgoalvolume( var_0, var_2 );
}

ai_wave_spawn_volume_threshold_retreat( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = ai_wave_spawn( var_0, var_1 );
    ai_wave_setgoalvolume( var_6, var_2 );
    ai_wave_monitor_threshold( var_6, var_3, var_4 );
    ai_wave_monitor_retreat( var_6, var_4, var_5 );
    return var_6;
}

ai_wave_spawn_volume_threshold( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = ai_wave_spawn( var_0, var_1 );
    ai_wave_setgoalvolume( var_6, var_2 );
    ai_wave_monitor_threshold( var_6, var_3, var_4 );
    ai_wave_monitor_retreat( var_6, var_4, var_5 );
    return var_6;
}

ai_wave_spawn_volume( var_0, var_1, var_2 )
{
    var_3 = ai_wave_spawn( var_0, var_1 );
    ai_wave_setgoalvolume( var_3, var_2 );
    return var_3;
}
