// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.player thread player_throwgrenade_timer();
    level endon( "new_quote_string" );
    level.player waittill( "death", var_0, var_1, var_2, var_3 );
    set_deadquote( "" );
    _func_0D3( "ammoCounterHide", 1 );
    _func_0D3( "hud_showstance", 0 );
    _func_0D3( "actionSlotsHide", 1 );
    soundscripts\_snd::snd_message( "player_death" );

    if ( isdefined( var_3 ) )
    {
        var_4 = level.player.origin - level.player _meth_80A8() + ( 0, 0, 35 );
        var_5 = spawn( "script_model", level.player.origin + ( 0, 0, var_4[2] ) );
        var_5.angles = ( -10, level.player.angles[2], 30 );
        var_5 _meth_804D( var_3 );
        level.player _meth_807C( var_5 );
    }

    maps\_sp_matchdata::register_death( var_2, var_1 );
    special_death_hint( var_0, var_1, var_2 );
}

player_throwgrenade_timer()
{
    self endon( "death" );
    self.lastgrenadetime = 0;

    for (;;)
    {
        while ( !self _meth_812C() )
            wait 0.05;

        self.lastgrenadetime = gettime();

        while ( self _meth_812C() )
            wait 0.05;
    }
}

special_death_hint( var_0, var_1, var_2 )
{
    if ( maps\_utility::is_specialop() )
        return;

    if ( level.missionfailed )
        return;

    set_deadquote( "" );

    if ( var_1 != "MOD_GRENADE" && var_1 != "MOD_GRENADE_SPLASH" && var_1 != "MOD_SUICIDE" && var_1 != "MOD_EXPLOSIVE" )
        return;

    if ( level.gameskill >= 2 )
    {
        if ( !maps\_load::map_is_early_in_the_game() )
            return;
    }

    switch ( var_1 )
    {
        case "MOD_SUICIDE":
            if ( level.player.lastgrenadetime - gettime() > 3500.0 )
                return;

            thread grenade_death_hint( &"SCRIPT_GRENADE_SUICIDE_LINE1", &"SCRIPT_GRENADE_SUICIDE_LINE2" );
            break;
        case "MOD_EXPLOSIVE":
            if ( level.player destructible_death( var_0 ) )
                return;

            if ( level.player vehicle_death( var_0 ) )
                return;

            if ( level.player exploding_barrel_death( var_0 ) )
                return;

            break;
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
            if ( isdefined( var_2 ) && !issubstr( var_2, "grenade" ) )
                return;

            set_deadquote( "@SCRIPT_GRENADE_DEATH" );
            thread grenade_death_indicator_hud();
            break;
        default:
            break;
    }
}

vehicle_death( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0.code_classname != "script_vehicle" )
        return 0;

    level notify( "new_quote_string" );
    set_deadquote( "@SCRIPT_EXPLODING_VEHICLE_DEATH" );
    thread set_death_icon( "hud_burningcaricon", 96, 96 );
    return 1;
}

destructible_death( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isdefined( var_0.destructible_type ) )
        return 0;

    level notify( "new_quote_string" );

    if ( issubstr( var_0.destructible_type, "vehicle" ) )
    {
        set_deadquote( "@SCRIPT_EXPLODING_VEHICLE_DEATH" );
        thread set_death_icon( "hud_burningcaricon", 96, 96 );
    }
    else
    {
        set_deadquote( "@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH" );
        thread set_death_icon( "hud_destructibledeathicon", 96, 96 );
    }

    return 1;
}

exploding_barrel_death( var_0 )
{
    if ( isdefined( level.lastexplodingbarrel ) )
    {
        if ( gettime() != level.lastexplodingbarrel["time"] )
            return 0;

        var_1 = distance( self.origin, level.lastexplodingbarrel["origin"] );

        if ( var_1 > level.lastexplodingbarrel["radius"] )
            return 0;

        level notify( "new_quote_string" );
        set_deadquote( "@SCRIPT_EXPLODING_BARREL_DEATH" );
        thread set_death_icon( "hud_burningbarrelicon", 64, 64 );
        return 1;
    }

    return 0;
}

set_deadquote( var_0 )
{
    setdvar( "ui_deadquote", var_0 );
}

deadquote_recently_used( var_0 )
{
    if ( var_0 == getdvar( "ui_deadquote_v1" ) )
        return 1;

    if ( var_0 == getdvar( "ui_deadquote_v2" ) )
        return 1;

    if ( var_0 == getdvar( "ui_deadquote_v3" ) )
        return 1;

    return 0;
}

lookupdeathquote( var_0 )
{
    var_1 = tablelookup( "sp/deathQuoteTable.csv", 0, var_0, 1 );

    if ( tolower( var_1[0] ) != tolower( "@" ) )
        var_1 = "@" + var_1;

    return var_1;
}

grenade_death_hint( var_0, var_1 )
{
    level.player.failingmission = 1;
    set_deadquote( "" );
    wait 1.5;
    var_2 = newhudelem();
    var_2.elemtype = "font";
    var_2.font = "default";
    var_2.fontscale = 1.5;
    var_2.x = 0;
    var_2.y = -30;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "center";
    var_2.vertalign = "middle";
    var_2 settext( var_0 );
    var_2.foreground = 1;
    var_2.alpha = 0;
    var_2 fadeovertime( 1 );
    var_2.alpha = 1;

    if ( isdefined( var_1 ) )
    {
        var_2 = newhudelem();
        var_2.elemtype = "font";
        var_2.font = "default";
        var_2.fontscale = 1.5;
        var_2.x = 0;
        var_2.y = -25 + level.fontheight * var_2.fontscale;
        var_2.alignx = "center";
        var_2.aligny = "middle";
        var_2.horzalign = "center";
        var_2.vertalign = "middle";
        var_2 settext( var_1 );
        var_2.foreground = 1;
        var_2.alpha = 0;
        var_2 fadeovertime( 1 );
        var_2.alpha = 1;
    }
}

grenade_death_indicator_hud()
{
    wait 1.5;
    var_0 = newhudelem();
    var_0.x = 0;
    var_0.y = 68;
    var_0 _meth_80CC( "hud_grenadeicon", 50, 50 );
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.horzalign = "center";
    var_0.vertalign = "middle";
    var_0.foreground = 1;
    var_0.alpha = 0;
    var_0 fadeovertime( 1 );
    var_0.alpha = 1;
    var_0 = newhudelem();
    var_0.x = 0;
    var_0.y = 25;
    var_0 _meth_80CC( "hud_grenadepointer", 50, 25 );
    var_0.alignx = "center";
    var_0.aligny = "middle";
    var_0.horzalign = "center";
    var_0.vertalign = "middle";
    var_0.foreground = 1;
    var_0.alpha = 0;
    var_0 fadeovertime( 1 );
    var_0.alpha = 1;
}

set_death_icon( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1.5;

    wait(var_3);
    var_4 = newhudelem();
    var_4.x = 0;
    var_4.y = 40;
    var_4 _meth_80CC( var_0, var_1, var_2 );
    var_4.alignx = "center";
    var_4.aligny = "middle";
    var_4.horzalign = "center";
    var_4.vertalign = "middle";
    var_4.foreground = 1;
    var_4.alpha = 0;
    var_4 fadeovertime( 1 );
    var_4.alpha = 1;
}
