// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    precachestring( &"SCRIPT_INTELLIGENCE_OF_FOURTYFIVE" );
    precachestring( &"SCRIPT_RORKEFILE_PREV_FOUND" );
    precachestring( &"SCRIPT_INTELLIGENCE_PICKUP" );
    precachestring( &"SCRIPT_INTELLIGENCE_PERCENT" );
    precachestring( &"SCRIPT_INTELLIGENCE_UPLOADING" );
    precacheshader( "torpedo_connection_bar" );
    precacheshader( "torpedo_connection_frame" );
    level.intel_items = create_array_of_intel_items();
    setdvar( "ui_level_cheatpoints", level.intel_items.size );
    level.intel_counter = 0;
    setdvar( "ui_level_player_cheatpoints", level.intel_counter );
    level.table_origins = create_array_of_origins_from_table();
    initialize_intel();

    if ( maps\_utility::is_specialop() )
    {
        remove_all_intel();
        return;
    }

    intel_think();
    wait 0.05;
}

remove_all_intel()
{
    foreach ( var_2, var_1 in level.intel_items )
    {
        if ( !isdefined( var_1.removed ) )
            var_1 remove_intel_item();
    }
}

remove_intel_item()
{
    self.removed = 1;
    self.item hide();
    self.item _meth_82BF();
    common_scripts\utility::trigger_off();
    level.intel_counter++;
    setdvar( "ui_level_player_cheatpoints", level.intel_counter );
    self notify( "end_trigger_thread" );
}

initialize_intel()
{
    foreach ( var_3, var_1 in level.intel_items )
    {
        var_2 = var_1.origin;
        var_1.num = get_nums_from_origins( var_2 );
    }
}

intel_think()
{
    foreach ( var_2, var_1 in level.intel_items )
    {
        if ( var_1 check_item_found() )
        {
            var_1 remove_intel_item();
            continue;
        }

        var_1 thread wait_for_pickup();
        var_1 thread poll_for_found();
    }
}

poll_for_found()
{
    self endon( "end_loop_thread" );

    while ( !check_item_found() )
        wait 0.1;

    remove_intel_item();
}

check_item_found()
{
    foreach ( var_1 in level.players )
    {
        if ( !var_1 _meth_823D( self.num ) )
            return 0;
    }

    return 1;
}

create_array_of_intel_items()
{
    var_0 = getentarray( "intelligence_item", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_0[var_1].item = getent( var_0[var_1].target, "targetname" );
        var_0[var_1].found = 0;
    }

    return var_0;
}

create_array_of_origins_from_table()
{
    var_0 = [];

    for ( var_1 = 1; var_1 <= 64; var_1++ )
    {
        var_2 = tablelookup( "sp/_intel_items.csv", 0, var_1, 4 );

        if ( isdefined( var_2 ) && var_2 != "undefined" )
        {
            var_3 = strtok( var_2, "," );

            for ( var_4 = 0; var_4 < var_3.size; var_4++ )
                var_3[var_4] = int( var_3[var_4] );

            var_0[var_1] = ( var_3[0], var_3[1], var_3[2] );
            continue;
        }

        var_0[var_1] = undefined;
    }

    return var_0;
}

award_intel()
{
    save_intel_for_all_players();
    updategamerprofileall();
    waittillframeend;
    remove_intel_item();
}

wait_for_pickup()
{
    self endon( "end_trigger_thread" );

    if ( self.classname == "trigger_use" )
    {
        self _meth_80DB( &"SCRIPT_INTELLIGENCE_PICKUP" );
        self _meth_817B();
    }

    thread upload_hold();
    self waittill( "hold_complete" );
    self notify( "end_loop_thread" );
    intel_feedback( level.player );
    award_intel();
}

upload_hold()
{
    level.player.hold_count = 0;

    while ( level.player.hold_count < 30 )
    {
        level.player.hold_count = 0;
        self waittill( "trigger", var_0 );
        setdvar( "ui_securing", "intel" );
        setdvar( "ui_securing_progress", 0.0 );
        thread progress_bar();
        hold_count_check();
    }

    self notify( "hold_complete" );
    self _meth_80AB( "intelligence_pickup_loop" );
    setdvar( "ui_securing_progress", 1.0 );
    setdvar( "ui_securing", "" );
    level.player.hold_count = 0;
}

hold_count_check()
{
    self endon( "stopped_pressing" );

    for (;;)
    {
        if ( level.player usebuttonpressed() && distance( level.player.origin, self.origin ) < 128 && isalive( level.player ) )
            level.player.hold_count++;
        else
        {
            setdvar( "ui_securing", "" );
            self _meth_80AB( "intelligence_pickup_loop" );
            self notify( "stopped_pressing" );
        }

        if ( level.player.hold_count >= 30 )
        {
            setdvar( "ui_securing", "" );
            self notify( "stopped_pressing" );
            self _meth_80AB( "intelligence_pickup_loop" );
        }

        waitframe();
    }
}

progress_bar()
{
    self endon( "stopped_pressing" );
    var_0 = 30;
    var_1 = 8;

    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        setdvar( "ui_securing_progress", getdvarfloat( "ui_securing_progress" ) + 1 / var_0 );
        waitframe();
    }
}

intel_upload_text( var_0, var_1 )
{
    self endon( "stopped_pressing" );
    var_2 = 30;
    var_3 = 10;
    var_4 = 0;

    for ( var_5 = 0; var_5 < var_2; var_5++ )
    {
        if ( var_4 > var_3 )
            var_4 = 0;

        if ( var_4 < var_3 / 2 )
            var_0 settext( &"SCRIPT_INTELLIGENCE_UPLOADING" );
        else
            var_0 settext( "" );

        var_1.label = int( var_5 / var_2 * 100 );
        var_1 settext( &"SCRIPT_INTELLIGENCE_PERCENT" );
        var_4++;
        waitframe();
    }

    var_0 settext( &"SCRIPT_INTELLIGENCE_UPLOADING" );
    var_1.label = "100";
    var_1 settext( &"SCRIPT_INTELLIGENCE_PERCENT" );
}

save_intel_for_all_players()
{
    foreach ( var_1 in level.players )
    {
        if ( var_1 _meth_823D( self.num ) )
            continue;

        var_1 _meth_823E( self.num );
        var_1 maps\_player_stats::stat_notify( "intel", 1 );
    }

    logstring( "found intel item " + self.num );
    maps\_endmission::updatesppercent();
}

give_point()
{
    var_0 = self _meth_820E( "cheatPoints" );
    self _meth_820F( "cheatPoints", var_0 + 1 );
    check_intel_achievements( self );
}

check_intel_achievements( var_0 )
{
    var_1 = var_0 _meth_820E( "cheatPoints" );

    if ( var_1 >= 45 )
        maps\_utility::giveachievement_wrapper( "INTEL_ALL" );

    if ( var_1 >= 23 )
        maps\_utility::giveachievement_wrapper( "INTEL_HALF" );
}

intel_feedback( var_0 )
{
    self.item hide();
    self.item _meth_82BF();
    level thread common_scripts\utility::play_sound_in_space( "intelligence_pickup", self.item.origin );
    var_1 = 3000;
    var_2 = 700;
    var_3 = var_1 + var_2 / 1000;

    foreach ( var_5 in level.players )
    {
        if ( var_0 != var_5 && var_5 _meth_823D( self.num ) )
            continue;

        var_6 = var_5 maps\_hud_util::createclientfontstring( "objective", 1.5 );
        var_6.glowcolor = ( 0.7, 0.7, 0.3 );
        var_6.glowalpha = 1;
        var_6 setup_hud_elem();
        var_6.y = -50;
        var_7 = getdvarint( "loc_language", 0 );

        if ( var_7 == 16 )
            var_6 maps\_utility::delaythread( var_1 / 1000, maps\_hud_util::fade_over_time, 0, var_2 / 1000 );
        else
            var_6 setpulsefx( 60, var_1, var_2 );

        var_8 = 0;

        if ( var_0 == var_5 && var_5 _meth_823D( self.num ) )
            var_6.label = &"SCRIPT_RORKEFILE_PREV_FOUND";
        else
        {
            var_6.label = &"SCRIPT_INTELLIGENCE_OF_FOURTYFIVE";
            var_5 give_point();
            var_8 = var_5 _meth_820E( "cheatPoints" );
            var_6 _meth_80D7( var_8 );
        }

        if ( var_8 == 18 )
            var_5 maps\_utility::player_giveachievement_wrapper( "EXT_1" );

        var_6 common_scripts\utility::delaycall( var_3, ::destroy );
    }
}

setup_hud_elem()
{
    self.color = ( 1, 1, 1 );
    self.alpha = 1;
    self.x = 0;
    self.alignx = "center";
    self.aligny = "middle";
    self.horzalign = "center";
    self.vertalign = "middle";
    self.foreground = 1;
}

assert_if_identical_origins()
{
    var_0 = [];

    for ( var_1 = 1; var_1 < 65; var_1++ )
    {
        var_2 = tablelookup( "sp/_intel_items.csv", 0, var_1, 4 );
        var_3 = strtok( var_2, "," );

        for ( var_1 = 0; var_1 < var_3.size; var_1++ )
            var_3[var_1] = int( var_3[var_1] );

        var_0[var_1] = ( var_3[0], var_3[1], var_3[2] );
    }

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !isdefined( var_0[var_1] ) )
            continue;

        if ( var_0[var_1] == "undefined" )
            continue;

        for ( var_4 = 0; var_4 < var_0.size; var_4++ )
        {
            if ( !isdefined( var_0[var_4] ) )
                continue;

            if ( var_0[var_4] == "undefined" )
                continue;

            if ( var_1 == var_4 )
                continue;

            if ( var_0[var_1] == var_0[var_4] )
            {

            }
        }
    }
}

get_nums_from_origins( var_0 )
{
    foreach ( var_3, var_2 in level.table_origins )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( distancesquared( var_0, var_2 ) < squared( 75 ) )
            return var_3;
    }
}
