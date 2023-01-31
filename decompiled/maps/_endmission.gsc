// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    var_0 = [];
    var_0 = createmission( "THE_BEST_OF_THE_BEST" );
    var_0 addlevel( "seoul", 0, "LEVEL_1", 0, undefined, 2 );
    var_0 addlevel( "recovery", 0, "LEVEL_2", 0, undefined, 2 );
    var_0 addlevel( "lagos", 0, "LEVEL_3", 0, undefined, 2 );
    var_0 addlevel( "fusion", 0, "LEVEL_4", 0, undefined, 2 );
    var_0 addlevel( "detroit", 0, "LEVEL_5", 0, undefined, 2 );
    var_0 addlevel( "greece", 0, "LEVEL_6", 0, undefined, 2 );
    var_0 addlevel( "betrayal", 0, "LEVEL_7", 0, undefined, 2 );
    var_0 addlevel( "irons_estate", 0, "LEVEL_8", 0, undefined, 2 );
    var_0 addlevel( "crash", 0, "LEVEL_9", 0, undefined, 3 );
    var_0 addlevel( "lab", 0, "LEVEL_10", 0, undefined, 2 );
    var_0 addlevel( "sanfran", 1, "LEVEL_11", 0, undefined, 3 );
    var_0 addlevel( "sanfran_b", 0, "LEVEL_12", 0, undefined, 2 );
    var_0 addlevel( "df_fly", 0, undefined, 1, undefined, undefined );
    var_0 addlevel( "df_baghdad", 0, "LEVEL_13", 0, undefined, 2 );
    var_0 addlevel( "captured", 0, "LEVEL_14", 0, undefined, 2 );
    var_0 addlevel( "finale", 0, undefined, 0, undefined, 2 );

    if ( isdefined( level.endmission_main_func ) )
    {
        [[ level.endmission_main_func ]]();
        level.endmission_main_func = undefined;
    }

    level.missionsettings = var_0;
}

debug_test_next_mission()
{
    wait 10;

    while ( getdvarint( "test_next_mission" ) < 1 )
        wait 3;

    _nextmission();
}

_nextmission()
{
    if ( maps\_utility::is_demo() )
    {
        _func_0D3( "ui_nextMission", "0" );

        if ( isdefined( level.nextmission_exit_time ) )
            _func_053( "", 0, level.nextmission_exit_time );
        else
            _func_053( "", 0 );
    }
    else
    {
        level notify( "nextmission" );
        level.nextmission = 1;
        level.player _meth_80EF();
        var_0 = undefined;
        _func_0D3( "ui_nextMission", "1" );
        setdvar( "ui_showPopup", "0" );
        setdvar( "ui_popupString", "" );
        setdvar( "ui_prev_map", level.script );
        game["previous_map"] = level.script;
        var_0 = level.missionsettings getlevelindex( level.script );

        if ( level.script == "sp_intro" && !getdvarint( "prologue_select" ) )
        {
            for ( var_1 = var_0 + 1; var_1 < level.missionsettings.levels.size - 1; var_1++ )
            {
                if ( level.missionsettings.levels[var_1].name == "sp_intro" )
                {
                    var_0 = var_1;
                    break;
                }
            }
        }

        setdvar( "prologue_select", "0" );

        if ( level.missionsettings hasachievement( var_0 ) )
            maps\_utility::giveachievement_wrapper( level.missionsettings getachievement( var_0 ) );

        maps\_gameskill::auto_adust_zone_complete( "aa_main_" + level.script );

        if ( !isdefined( var_0 ) )
        {
            _func_054( level.script );
            return;
        }

        end_mission_fade_audio_and_video( level.missionsettings getfadetime( var_0 ) );

        if ( level.script != "finale" )
            maps\_utility::level_end_save();

        level.missionsettings setlevelcompleted( var_0 );
        var_2 = level.player _meth_820D( "gameskill" );
        maps\_player_stats::register_difficulty( level.difficultytype[int( var_2 )], 0 );
        maps\_sp_matchdata::level_complete( level.script );
        var_3 = updatesppercent();
        maps\_upgrade_challenge::commit_exo_awards_upon_mission_success();
        updategamerprofile();
        check_campaign_completion();

        if ( level.script == "finale" )
        {
            _func_054( "", 0 );
            return;
        }

        var_4 = var_0 + 1;

        if ( maps\_utility::arcademode() )
        {
            if ( !getdvarint( "arcademode_full" ) )
            {
                _func_0D3( "ui_nextMission", "0" );
                _func_054( level.script );
                return;
            }
        }

        if ( level.missionsettings skipssuccess( var_0 ) )
        {
            if ( isdefined( level.missionsettings getfadetime( var_0 ) ) )
            {
                _func_053( level.missionsettings getlevelname( var_4 ), level.missionsettings getkeepweapons( var_0 ), level.missionsettings getfadetime( var_0 ) );
                return;
            }

            _func_053( level.missionsettings getlevelname( var_4 ), level.missionsettings getkeepweapons( var_0 ) );
            return;
            return;
        }

        _func_054( level.missionsettings getlevelname( var_4 ), level.missionsettings getkeepweapons( var_0 ) );
    }
}

updatesppercent()
{
    var_0 = int( gettotalpercentcompletesp() * 100 );

    if ( getdvarint( "mis_cheat" ) == 0 )
        level.player _meth_820F( "percentCompleteSP", var_0 );

    return var_0;
}

gettotalpercentcompletesp()
{
    var_0 = max( getstat_easy(), getstat_regular() );
    var_1 = 0.5;
    var_2 = getstat_hardened();
    var_3 = 0.25;
    var_4 = getstat_veteran();
    var_5 = 0.1;
    var_6 = getstat_intel();
    var_7 = 0.15;
    var_8 = 0.0;
    var_8 += var_1 * var_0;
    var_8 += var_3 * var_2;
    var_8 += var_5 * var_4;
    var_8 += var_7 * var_6;
    return var_8;
}

getstat_progression( var_0 )
{
    var_1 = level.player _meth_820E( "missionHighestDifficulty" );
    var_2 = 0;
    var_3 = [];
    var_4 = 0;

    for ( var_5 = 0; var_5 < level.missionsettings.levels.size; var_5++ )
    {
        if ( int( var_1[var_5] ) >= var_0 )
            var_2++;
    }

    var_6 = var_2 / level.missionsettings.levels.size * 100;
    return var_6;
}

getstat_easy()
{
    var_0 = 1;
    return getstat_progression( var_0 );
}

getstat_regular()
{
    var_0 = 2;
    return getstat_progression( var_0 );
}

getstat_hardened()
{
    var_0 = 3;
    return getstat_progression( var_0 );
}

getstat_veteran()
{
    var_0 = 4;
    return getstat_progression( var_0 );
}

getstat_intel()
{
    var_0 = 45;
    var_1 = level.player _meth_820E( "cheatPoints" ) / var_0 * 100;
    return var_1;
}

getlevelcompleted( var_0 )
{
    return int( level.player _meth_820E( "missionHighestDifficulty" )[var_0] );
}

getsolevelcompleted( var_0 )
{
    return int( level.player _meth_820E( "missionSOHighestDifficulty" )[var_0] );
}

setlevelcompleted( var_0 )
{
    var_1 = level.player _meth_820E( "missionHighestDifficulty" );
    var_2 = "";

    for ( var_3 = 0; var_3 < var_1.size; var_3++ )
    {
        if ( var_3 != var_0 )
        {
            var_2 += var_1[var_3];
            continue;
        }

        if ( level.gameskill + 1 > int( var_1[var_0] ) )
        {
            var_2 += ( level.gameskill + 1 );
            continue;
        }

        var_2 += var_1[var_3];
    }

    var_4 = "";
    var_5 = 0;
    var_6 = 0;

    for ( var_7 = 0; var_7 < var_2.size; var_7++ )
    {
        if ( int( var_2[var_7] ) == 0 || var_5 )
        {
            var_4 += "0";
            var_5 = 1;
            continue;
        }

        var_4 += var_2[var_7];
        var_6++;
    }

    _sethighestmissionifnotcheating( var_6 );
    _setmissiondiffstringifnotcheating( var_4 );
}

_sethighestmissionifnotcheating( var_0 )
{
    if ( getdvar( "mis_cheat" ) == "1" )
        return;

    level.player _meth_820F( "highestMission", var_0 );
}

_setmissiondiffstringifnotcheating( var_0 )
{
    if ( getdvar( "mis_cheat" ) == "1" )
        return;

    level.player _meth_820F( "missionHighestDifficulty", var_0 );
}

getlevelskill( var_0 )
{
    var_1 = level.player _meth_820E( "missionHighestDifficulty" );
    return int( var_1[var_0] );
}

getmissiondvarstring( var_0 )
{
    if ( var_0 < 9 )
        return "mis_0" + ( var_0 + 1 );
    else
        return "mis_" + ( var_0 + 1 );
}

getlowestskill()
{
    var_0 = level.player _meth_820E( "missionHighestDifficulty" );
    var_1 = 4;

    for ( var_2 = 0; var_2 < self.levels.size; var_2++ )
    {
        if ( int( var_0[var_2] ) < var_1 )
            var_1 = int( var_0[var_2] );
    }

    return var_1;
}

createmission( var_0 )
{
    var_1 = spawnstruct();
    var_1.levels = [];
    var_1.prereqs = [];
    var_1.hardenedaward = var_0;
    return var_1;
}

addlevel( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = self.levels.size;
    self.levels[var_7] = spawnstruct();
    self.levels[var_7].name = var_0;
    self.levels[var_7].keepweapons = var_1;
    self.levels[var_7].achievement = var_2;
    self.levels[var_7].skipssuccess = var_3;
    self.levels[var_7].veteran_achievement = var_4;

    if ( isdefined( var_5 ) )
        self.levels[var_7].fade_time = var_5;
}

addprereq( var_0 )
{
    var_1 = self.prereqs.size;
    self.prereqs[var_1] = var_0;
}

getlevelindex( var_0 )
{
    foreach ( var_3, var_2 in self.levels )
    {
        if ( var_2.name == var_0 )
            return var_3;
    }

    return undefined;
}

getlevelname( var_0 )
{
    return self.levels[var_0].name;
}

getkeepweapons( var_0 )
{
    return self.levels[var_0].keepweapons;
}

getachievement( var_0 )
{
    return self.levels[var_0].achievement;
}

getlevelveteranaward( var_0 )
{
    return self.levels[var_0].veteran_achievement;
}

getfadetime( var_0 )
{
    if ( !isdefined( self.levels[var_0].fade_time ) )
        return undefined;

    return self.levels[var_0].fade_time;
}

haslevelveteranaward( var_0 )
{
    if ( isdefined( self.levels[var_0].veteran_achievement ) )
        return 1;
    else
        return 0;
}

hasachievement( var_0 )
{
    if ( isdefined( self.levels[var_0].achievement ) )
        return 1;
    else
        return 0;
}

check_other_haslevelveteranachievement( var_0 )
{
    for ( var_1 = 0; var_1 < self.levels.size; var_1++ )
    {
        if ( var_1 == var_0 )
            continue;

        if ( !haslevelveteranaward( var_1 ) )
            continue;

        if ( self.levels[var_1].veteran_achievement == self.levels[var_0].veteran_achievement )
        {
            if ( getlevelcompleted( var_1 ) < 4 )
                return 0;
        }
    }

    return 1;
}

check_campaign_completion()
{
    var_0 = 0;
    var_1 = 0;

    if ( getstat_veteran() >= 100 )
    {
        maps\_utility::giveachievement_wrapper( "CAMPAIGN_VETERAN" );
        var_0 = 1;
        level.player _meth_820F( "sp_mpGearUnlocks", 0, "1" );
    }

    if ( getstat_hardened() >= 100 || var_0 )
    {
        maps\_utility::giveachievement_wrapper( "CAMPAIGN_HARDENED" );
        var_1 = 1;
    }

    if ( getstat_easy() >= 100 || getstat_regular() >= 100 || var_1 )
        maps\_utility::giveachievement_wrapper( "CAMPAIGN_COMPLETE" );
}

skipssuccess( var_0 )
{
    if ( !isdefined( self.levels[var_0].skipssuccess ) )
        return 0;

    return self.levels[var_0].skipssuccess;
}

gethardenedaward()
{
    return self.hardenedaward;
}

hasmissionhardenedaward()
{
    if ( isdefined( self.hardenedaward ) )
        return 1;
    else
        return 0;
}

getnextlevelindex()
{
    for ( var_0 = 0; var_0 < self.levels.size; var_0++ )
    {
        if ( !getlevelskill( var_0 ) )
            return var_0;
    }

    return 0;
}

force_all_complete()
{
    var_0 = level.player _meth_820E( "missionHighestDifficulty" );
    var_1 = "";

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_2 < 20 )
        {
            var_1 += 2;
            continue;
        }

        var_1 += 0;
    }

    level.player _meth_820F( "missionHighestDifficulty", var_1 );
    level.player _meth_820F( "highestMission", 20 );
}

clearall()
{
    level.player _meth_820F( "missionHighestDifficulty", "00000000000000000000000000000000000000000000000000" );
    level.player _meth_820F( "highestMission", 1 );
}

credits_end()
{
    _func_053( "airplane", 0 );
}

end_mission_fade_audio_and_video( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 == 0 )
        return;

    soundscripts\_snd::snd_message( "finish_mission_fade", var_0 );
    var_1 = maps\_hud_util::create_client_overlay( "black", 0, level.player );
    var_1.sort = 100;
    var_1 fadeovertime( var_0 );
    var_1.alpha = 1;
    wait(var_0);
}
