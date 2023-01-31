// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_color_grouping( var_0 )
{
    level.colorlist = [];
    level.colorlist[level.colorlist.size] = "r";
    level.colorlist[level.colorlist.size] = "b";
    level.colorlist[level.colorlist.size] = "y";
    level.colorlist[level.colorlist.size] = "c";
    level.colorlist[level.colorlist.size] = "g";
    level.colorlist[level.colorlist.size] = "p";
    level.colorlist[level.colorlist.size] = "o";
    level.arrays_of_colorcoded_nodes = [];
    level.arrays_of_colorcoded_nodes["axis"] = [];
    level.arrays_of_colorcoded_nodes["allies"] = [];
    level.arrays_of_colorcoded_volumes = [];
    level.arrays_of_colorcoded_volumes["axis"] = [];
    level.arrays_of_colorcoded_volumes["allies"] = [];
    level.color_teams = [];
    level.color_teams["allies"] = "allies";
    level.color_teams["axis"] = "axis";
    level.color_teams["team3"] = "axis";
    level.color_teams["neutral"] = "neutral";
    var_1 = [];
    var_1 = common_scripts\utility::array_combine( var_1, getentarray( "trigger_multiple", "code_classname" ) );
    var_1 = common_scripts\utility::array_combine( var_1, getentarray( "trigger_radius", "code_classname" ) );
    var_1 = common_scripts\utility::array_combine( var_1, getentarray( "trigger_once", "code_classname" ) );
    var_2 = getentarray( "info_volume", "code_classname" );

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4.script_color_allies ) )
            var_4 add_node_to_global_arrays( var_4.script_color_allies, "allies" );

        if ( isdefined( var_4.script_color_axis ) )
            var_4 add_node_to_global_arrays( var_4.script_color_axis, "axis" );
    }

    foreach ( var_7 in var_2 )
    {
        if ( isdefined( var_7.script_color_allies ) )
            var_7 add_volume_to_global_arrays( var_7.script_color_allies, "allies" );

        if ( isdefined( var_7.script_color_axis ) )
            var_7 add_volume_to_global_arrays( var_7.script_color_axis, "axis" );
    }

    foreach ( var_10 in var_1 )
    {
        if ( isdefined( var_10.script_color_allies ) )
            var_10 thread trigger_issues_orders( var_10.script_color_allies, "allies" );

        if ( isdefined( var_10.script_color_axis ) )
            var_10 thread trigger_issues_orders( var_10.script_color_axis, "axis" );
    }

    level.color_node_type_function = [];
    add_cover_node( "BAD NODE" );
    add_cover_node( "Cover Stand" );
    add_cover_node( "Cover Crouch" );
    add_cover_node( "Cover Prone" );
    add_cover_node( "Cover Crouch Window" );
    add_cover_node( "Cover Right" );
    add_cover_node( "Cover Left" );
    add_cover_node( "Cover Wide Left" );
    add_cover_node( "Cover Wide Right" );
    add_cover_node( "Cover Multi" );
    add_cover_node( "Conceal Stand" );
    add_cover_node( "Conceal Crouch" );
    add_cover_node( "Conceal Prone" );
    add_cover_node( "Reacquire" );
    add_cover_node( "Balcony" );
    add_cover_node( "Scripted" );
    add_cover_node( "Begin" );
    add_cover_node( "End" );
    add_cover_node( "Turret" );
    add_path_node( "Ambush" );
    add_path_node( "Guard" );
    add_path_node( "Path" );
    add_path_node( "Exposed" );
    add_path_node( "Scripted" );
    level.colorchecklist["red"] = "r";
    level.colorchecklist["r"] = "r";
    level.colorchecklist["blue"] = "b";
    level.colorchecklist["b"] = "b";
    level.colorchecklist["yellow"] = "y";
    level.colorchecklist["y"] = "y";
    level.colorchecklist["cyan"] = "c";
    level.colorchecklist["c"] = "c";
    level.colorchecklist["green"] = "g";
    level.colorchecklist["g"] = "g";
    level.colorchecklist["purple"] = "p";
    level.colorchecklist["p"] = "p";
    level.colorchecklist["orange"] = "o";
    level.colorchecklist["o"] = "o";
    level.currentcolorforced = [];
    level.currentcolorforced["allies"] = [];
    level.currentcolorforced["axis"] = [];
    level.lastcolorforced = [];
    level.lastcolorforced["allies"] = [];
    level.lastcolorforced["axis"] = [];

    foreach ( var_13 in level.colorlist )
    {
        level.arrays_of_colorforced_ai["allies"][var_13] = [];
        level.arrays_of_colorforced_ai["axis"][var_13] = [];
        level.currentcolorforced["allies"][var_13] = undefined;
        level.currentcolorforced["axis"][var_13] = undefined;
    }

    if ( isdefined( level.colors_player_can_take_nodes ) )
        thread player_color_node();

    common_scripts\utility::flag_init( "respawn_friendlies" );
    common_scripts\utility::flag_init( "respawn_enemies" );
    common_scripts\utility::flag_init( "friendly_spawner_locked" );
    common_scripts\utility::flag_init( "enemy_spawner_locked" );
    common_scripts\utility::flag_init( "player_looks_away_from_friendly_spawner" );
    common_scripts\utility::flag_init( "player_looks_away_from_enemy_spawner" );
    level.respawn_friendlies_force_vision_check = 1;
    level.respawn_enemies_force_vision_check = 1;
    level.respawn_spawner_org = [];
    level.arrays_color_spawners = [];
    level.arrays_color_spawners["allies"] = [];
    level.arrays_color_spawners["axis"] = [];
    var_15 = _func_0DA( "allies" );
    var_16 = _func_0DA( "team3" );
    var_16 = common_scripts\utility::array_combine( _func_0DA( "axis" ), var_16 );

    foreach ( var_18 in var_15 )
    {
        if ( isdefined( var_18.script_noteworthy ) && var_18.script_noteworthy == "color_spawner" )
            var_18 add_spawner_to_global_arrays( "allies" );

        if ( isdefined( var_18.script_parameters ) && var_18.script_parameters == "color_replace" )
            var_18 thread add_replace_after_load_done();
    }

    foreach ( var_18 in var_16 )
    {
        if ( isdefined( var_18.script_noteworthy ) && var_18.script_noteworthy == "color_spawner" )
            var_18 add_spawner_to_global_arrays( "axis" );

        if ( isdefined( var_18.script_parameters ) && var_18.script_parameters == "color_replace" )
            var_18 thread add_replace_after_load_done();
    }
}

add_node_to_global_arrays( var_0, var_1 )
{
    self.color_user = undefined;
    var_2 = strtok( var_0, " " );
    var_2 = common_scripts\utility::array_remove_duplicates( var_2 );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( level.arrays_of_colorcoded_nodes[var_1] ) && isdefined( level.arrays_of_colorcoded_nodes[var_1][var_4] ) )
        {
            level.arrays_of_colorcoded_nodes[var_1][var_4] = common_scripts\utility::array_add( level.arrays_of_colorcoded_nodes[var_1][var_4], self );
            continue;
        }

        level.arrays_of_colorcoded_nodes[var_1][var_4][0] = self;
    }
}

add_volume_to_global_arrays( var_0, var_1 )
{
    var_2 = strtok( var_0, " " );
    var_2 = common_scripts\utility::array_remove_duplicates( var_2 );

    foreach ( var_4 in var_2 )
        level.arrays_of_colorcoded_volumes[var_1][var_4] = self;
}

add_cover_node( var_0 )
{
    level.color_node_type_function[var_0][1]["allies"] = ::process_cover_node_with_last_in_mind_allies;
    level.color_node_type_function[var_0][1]["axis"] = ::process_cover_node_with_last_in_mind_axis;
    level.color_node_type_function[var_0][0]["allies"] = ::process_cover_node;
    level.color_node_type_function[var_0][0]["axis"] = ::process_cover_node;
}

add_path_node( var_0 )
{
    level.color_node_type_function[var_0][1]["allies"] = ::process_path_node;
    level.color_node_type_function[var_0][1]["axis"] = ::process_path_node;
    level.color_node_type_function[var_0][0]["allies"] = ::process_path_node;
    level.color_node_type_function[var_0][0]["axis"] = ::process_path_node;
}

add_spawner_to_global_arrays( var_0 )
{
    if ( !isdefined( level.arrays_color_spawners[var_0][self.classname] ) )
        level.arrays_color_spawners[var_0][self.classname] = [];

    level.arrays_color_spawners[var_0][self.classname] = common_scripts\utility::array_add( level.arrays_color_spawners[var_0][self.classname], self );
}

add_replace_after_load_done()
{
    self endon( "death" );
    level waittill( "load_finished" );
    maps\_utility::add_spawn_function( ::colornode_replace_on_death );
}

trigger_issues_orders( var_0, var_1 )
{
    var_2 = get_colorcodes( var_0, var_1 );
    var_3 = var_2["colorCodes"];
    var_4 = var_2["colorCodesByColorIndex"];
    var_5 = var_2["colors"];
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger" );
        activate_color_code_internal( var_3, var_5, var_1, var_4 );

        if ( isdefined( self.script_oneway ) && self.script_oneway )
            thread trigger_delete_target_chain();
    }
}

activate_color_code_internal( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    foreach ( var_6 in var_1 )
    {
        var_7 = var_3[var_6];

        if ( same_color_code_as_last_time( var_2, var_6, var_7 ) )
            continue;

        level.arrays_of_colorforced_ai[var_2][var_6] = maps\_utility::array_removedead( level.arrays_of_colorforced_ai[var_2][var_6] );
        var_4[var_6] = issue_leave_node_order_to_ai_and_get_ai( var_7, var_6, var_2 );
    }

    foreach ( var_6 in var_1 )
    {
        var_7 = var_3[var_6];

        if ( same_color_code_as_last_time( var_2, var_6, var_7 ) )
            continue;

        level.lastcolorforced[var_2][var_6] = level.currentcolorforced[var_2][var_6];
        level.currentcolorforced[var_2][var_6] = var_7;

        if ( !isdefined( var_4[var_6] ) )
            continue;

        issue_color_order_to_ai( var_7, var_6, var_2, var_4[var_6] );
    }
}

same_color_code_as_last_time( var_0, var_1, var_2 )
{
    if ( !isdefined( level.currentcolorforced[var_0][var_1] ) )
        return 0;

    return var_2 == level.currentcolorforced[var_0][var_1];
}

issue_leave_node_order_to_ai_and_get_ai( var_0, var_1, var_2 )
{
    var_3 = [];
    var_4 = level.arrays_of_colorforced_ai[var_2][var_1];

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6.currentcolorcode ) && var_6.currentcolorcode == var_0 )
            continue;

        if ( isdefined( var_6.force_color_driven_anim ) )
            continue;

        var_3[var_3.size] = var_6;
    }

    if ( !var_3.size )
        return;

    common_scripts\utility::array_thread( var_3, ::left_color_node );
    return var_3;
}

left_color_node()
{
    if ( !isdefined( self.color_node ) )
        return;

    if ( isdefined( self.color_node.color_user ) && self.color_node.color_user == self )
        self.color_node.color_user = undefined;

    self.color_node = undefined;
}

issue_color_order_to_ai( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    if ( isdefined( level.arrays_of_colorcoded_nodes[var_2][var_0] ) )
    {
        prioritize_colorcoded_nodes( var_2, var_0, var_1 );
        var_4 = get_colorcoded_nodes( var_2, var_0 );
    }
    else
    {
        var_5 = get_colorcoded_volume( var_2, var_0 );
        common_scripts\utility::array_thread( var_3, ::send_ai_to_colorvolume, var_5, var_0 );
        return;
    }

    var_6 = 0;

    for ( var_7 = undefined; var_3.size > 0; var_6++ )
    {
        var_4 = remove_nodes_with_users_from_array( var_4 );
        var_8 = get_best_ai_match_for_highest_priority_node( var_4, var_3 );

        if ( !isdefined( var_8 ) )
            break;

        var_3 = common_scripts\utility::array_remove( var_3, var_8["guy"] );
        var_7 = var_8["node"];
        var_4 = common_scripts\utility::array_remove( var_4, var_8["node"] );
        var_8["guy"] take_color_node( var_8["node"], var_0, self, var_6 );
    }

    if ( isdefined( level.colors_player_can_take_nodes ) && isdefined( var_7 ) )
        return;

    if ( isdefined( var_7 ) )
        return;

    return;
    return;
}

remove_nodes_with_users_from_array( var_0 )
{
    for ( var_1 = var_0.size - 1; var_1 >= 0; var_1-- )
    {
        if ( isdefined( var_0[var_1].color_user ) && isalive( var_0[var_1].color_user ) )
            var_0 = common_scripts\utility::array_remove( var_0, var_0[var_1] );
    }

    return var_0;
}

get_best_ai_match_for_highest_priority_node( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = 999999999;

    if ( !isdefined( var_0 ) || var_0.size <= 0 )
        return undefined;

    var_5 = var_0[0].color_priority;

    for ( var_6 = 0; var_6 < var_0.size; var_6++ )
    {
        var_7 = var_0[var_6];

        if ( var_7.color_priority > var_5 )
            break;

        var_8 = common_scripts\utility::getclosest( var_7.origin, var_1 );
        var_9 = distance( var_8.origin, var_7.origin );

        if ( var_9 < var_4 )
        {
            var_2 = var_7;
            var_3 = var_8;
            var_4 = var_9;
        }
    }

    if ( isdefined( var_2 ) )
    {
        var_10 = [];
        var_10["guy"] = var_3;
        var_10["node"] = var_2;
        return var_10;
    }
    else
        return undefined;
}

take_color_node( var_0, var_1, var_2, var_3 )
{
    self notify( "stop_color_move" );
    self notify( "color_code_move_update", var_0 );
    self.currentcolorcode = var_1;
    thread process_color_order_to_ai( var_0, var_2, var_3 );
}

process_color_order_to_ai( var_0, var_1, var_2 )
{
    thread take_color_node_until_death( var_0 );
    self endon( "stop_color_move" );
    self endon( "death" );

    if ( isdefined( var_1 ) && issubstr( var_1.classname, "trigger" ) )
        var_1 maps\_utility::script_delay();

    if ( !my_current_node_delays() )
    {
        if ( isdefined( var_2 ) )
            wait(var_2 * randomfloatrange( 0.2, 0.35 ));
    }

    ai_sets_goal( var_0 );
    self.color_ordered_node_assignment = var_0;

    for (;;)
    {
        self waittill( "node_taken", var_3 );

        if ( isplayer( var_3 ) )
        {
            if ( !isdefined( level.colors_player_can_take_nodes ) )
                continue;

            wait 0.05;
        }

        if ( !isalive( var_3 ) )
            continue;

        if ( var_3 != self.color_node.color_user )
            self.color_node.color_user = undefined;

        self.color_node = undefined;
        var_0 = get_best_available_new_colored_node();

        if ( isdefined( var_0 ) )
        {
            if ( isdefined( self.color_node ) )
            {
                if ( isalive( self.color_node.color_user ) && self.color_node.color_user == self )
                    self.color_node.color_user = undefined;
            }

            self.color_node = var_0;
            var_0.color_user = self;
            ai_sets_goal( var_0 );
            continue;
        }
    }
}

ai_sets_goal( var_0 )
{
    self notify( "stop_going_to_node" );
    self.fixednode = 1;
    set_color_goal_node( var_0 );

    if ( isdefined( self.script_careful ) && self.script_careful == 1 )
    {
        var_1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

        if ( isdefined( var_1 ) )
            self _meth_81AC( var_1 );
        else
            self _meth_815E();

        thread careful_logic( var_0, var_1 );
    }
    else
        self _meth_815E();
}

set_color_goal_node( var_0 )
{
    if ( isdefined( self.colornode_func ) )
        self thread [[ self.colornode_func ]]( var_0 );

    if ( isdefined( self._colors_go_line ) )
    {
        thread maps\_anim::anim_single_queue( self, self._colors_go_line );
        self._colors_go_line = undefined;
    }

    if ( isdefined( self.colornode_setgoal_func ) )
        self thread [[ self.colornode_setgoal_func ]]( var_0 );
    else if ( var_0.type == "Scripted" )
    {
        thread color_node_anim_at_node( var_0 );
        return;
    }
    else
    {
        self _meth_81A5( var_0 );
        thread color_node_arrival_notifies( var_0 );
    }

    if ( isdefined( var_0.fixednodesaferadius ) )
        self.fixednodesaferadius = var_0.fixednodesaferadius;
    else if ( isdefined( level.fixednodesaferadius_default ) )
        self.fixednodesaferadius = level.fixednodesaferadius_default;
    else
        self.fixednodesaferadius = 64;

    if ( isdefined( var_0.radius ) && var_0.radius > 0 )
        self.goalradius = var_0.radius;
}

color_node_anim_at_node( var_0 )
{
    self endon( "death" );
    self endon( "start_being_careful" );
    self endon( "stop_color_move" );
    self.fixednode = 0;
    self.goalradius = level.default_goalradius;
    thread color_node_arrival_notifies( var_0 );

    if ( isdefined( var_0.script_forcegoal ) )
        self.force_color_driven_anim = 1;

    self.perforing_color_driven_anim = 1;
    var_0 maps\_anim::anim_reach_solo( self, var_0.script_animation );
    thread color_node_anim_at_node_animate( var_0 );
}

color_node_anim_at_node_animate( var_0 )
{
    self endon( "death" );
    var_0 maps\_anim::anim_single_solo( self, var_0.script_animation );
    self.perforing_color_driven_anim = undefined;
    self.force_color_driven_anim = undefined;

    if ( self.currentcolorcode != level.currentcolorforced[get_team()][self.script_forcecolor] )
    {
        self.currentcolorcode = level.currentcolorforced[get_team()][self.script_forcecolor];
        thread goto_current_colorindex();
    }
}

color_node_arrival_notifies( var_0 )
{
    self endon( "stop_color_move" );

    for (;;)
    {
        self waittill( "goal" );

        if ( !isdefined( self.being_careful ) || !self.being_careful )
        {
            if ( isdefined( var_0.script_flag_set ) )
                common_scripts\utility::flag_set( var_0.script_flag_set );

            if ( isdefined( var_0.script_ent_flag_set ) )
                maps\_utility::ent_flag_set( var_0.script_ent_flag_set );

            if ( isdefined( var_0.script_flag_clear ) )
                common_scripts\utility::flag_clear( var_0.script_flag_clear );

            if ( isdefined( var_0.script_noteworthy ) )
                self notify( var_0.script_noteworthy );

            return;
        }
    }
}

take_color_node_until_death( var_0 )
{
    self endon( "stop_color_move" );
    var_0.color_user = self;
    self.color_node = var_0;
    self waittill( "death" );
    self.color_node.color_user = undefined;
}

send_ai_to_colorvolume( var_0, var_1 )
{
    self notify( "stop_color_move" );
    self.currentcolorcode = var_1;

    if ( isdefined( var_0.target ) )
    {
        var_2 = getnode( var_0.target, "targetname" );

        if ( isdefined( var_2 ) )
            self _meth_81A5( var_2 );
    }

    self.fixednode = 0;
    self _meth_81A9( var_0 );
}

clear_color_order_from_team( var_0, var_1 )
{
    var_2 = undefined;

    foreach ( var_2 in level.colorlist )
    {
        if ( issubstr( var_0, var_2 ) )
            break;

        var_2 = undefined;
    }

    level.currentcolorforced[var_1][var_2] = undefined;
    level.lastcolorforced[var_1][var_2] = undefined;
    var_5 = level.arrays_of_colorforced_ai[var_1][var_2];

    foreach ( var_7 in var_5 )
        var_7.currentcolorcode = undefined;
}

player_color_node()
{
    for (;;)
    {
        var_0 = undefined;

        if ( !isdefined( level.player.node ) )
        {
            wait 0.05;
            continue;
        }

        var_1 = level.player.node.color_user;

        if ( !isdefined( var_1.perforing_color_driven_anim ) )
        {
            if ( isdefined( var_1 ) )
                var_1 notify( "node_taken", level.player );

            var_0 = level.player.node;
            var_0.color_user = level.player;

            for (;;)
            {
                if ( !isdefined( level.player.node ) )
                    break;

                if ( level.player.node != var_0 )
                    break;

                wait 0.05;
            }

            var_0.color_user = undefined;
            continue;
        }

        wait 0.05;
    }
}

careful_logic( var_0, var_1 )
{
    self endon( "death" );
    self endon( "stop_being_careful" );
    self endon( "stop_going_to_node" );
    thread recover_from_careful_disable( var_0 );

    for (;;)
    {
        wait_until_an_enemy_is_in_safe_area( var_0, var_1 );
        self.being_careful = 1;
        self.perforing_color_driven_anim = undefined;
        self notify( "start_being_careful" );
        use_big_goal_until_goal_is_safe( var_0, var_1 );
        self.being_careful = 0;
        self.fixednode = 1;
        set_color_goal_node( var_0 );
    }
}

recover_from_careful_disable( var_0 )
{
    self endon( "death" );
    self endon( "stop_going_to_node" );
    self waittill( "stop_being_careful" );
    self.being_careful = 0;
    self.fixednode = 1;
    set_color_goal_node( var_0 );
}

wait_until_an_enemy_is_in_safe_area( var_0, var_1 )
{
    for (;;)
    {
        if ( self _meth_816E( var_0.origin, self.fixednodesaferadius ) )
            return;

        if ( isdefined( var_1 ) && self _meth_816F( var_1 ) )
            return;

        wait 1;
    }
}

use_big_goal_until_goal_is_safe( var_0, var_1 )
{
    self _meth_81A6( self.origin );

    if ( isdefined( level.default_goalradius ) )
        self.goalradius = level.default_goalradius;
    else
        self.goalradius = 1024;

    self.fixednode = 0;

    for (;;)
    {
        wait 1;

        if ( self _meth_816E( var_0.origin, self.fixednodesaferadius ) )
            continue;

        if ( isdefined( var_1 ) && self _meth_816F( var_1 ) )
            continue;

        return;
    }
}

process_cover_node_with_last_in_mind_allies( var_0, var_1 )
{
    if ( issubstr( var_0.script_color_allies, var_1 ) )
    {
        var_0.color_priority = 2;
        self.cover_nodes_last[self.cover_nodes_last.size] = var_0;
    }
    else
    {
        var_0.color_priority = 1;
        self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
    }
}

process_cover_node_with_last_in_mind_axis( var_0, var_1 )
{
    if ( issubstr( var_0.script_color_axis, var_1 ) )
    {
        var_0.color_priority = 2;
        self.cover_nodes_last[self.cover_nodes_last.size] = var_0;
    }
    else
    {
        var_0.color_priority = 1;
        self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
    }
}

process_cover_node( var_0, var_1 )
{
    var_0.color_priority = 1;
    self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
}

process_path_node( var_0, var_1 )
{
    var_0.color_priority = 3;
    self.path_nodes[self.path_nodes.size] = var_0;
}

prioritize_colorcoded_nodes( var_0, var_1, var_2 )
{
    var_3 = level.arrays_of_colorcoded_nodes[var_0][var_1];
    var_4 = spawnstruct();
    var_4.path_nodes = [];
    var_4.cover_nodes_first = [];
    var_4.cover_nodes_last = [];
    var_5 = isdefined( level.lastcolorforced[var_0][var_2] );

    for ( var_6 = 0; var_6 < var_3.size; var_6++ )
    {
        var_7 = var_3[var_6];
        var_4 [[ level.color_node_type_function[var_7.type][var_5][var_0] ]]( var_7, level.lastcolorforced[var_0][var_2] );
    }

    var_4.cover_nodes_first = common_scripts\utility::array_randomize( var_4.cover_nodes_first );
    var_8 = [];
    var_3 = [];

    foreach ( var_7 in var_4.cover_nodes_first )
    {
        if ( isdefined( var_7.script_colorlast ) )
        {
            var_7.color_priority = 4;
            var_8[var_8.size] = var_7;
            continue;
        }

        var_3[var_3.size] = var_7;
    }

    var_3 = common_scripts\utility::array_combine( var_3, var_4.cover_nodes_last );
    var_3 = common_scripts\utility::array_combine( var_3, var_4.path_nodes );
    var_3 = common_scripts\utility::array_combine( var_3, var_8 );
    level.arrays_of_colorcoded_nodes[var_0][var_1] = var_3;
}

get_best_available_new_colored_node()
{
    var_0 = level.currentcolorforced[get_team()][self.script_forcecolor];
    var_1 = get_colorcoded_nodes( get_team(), var_0 );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( !isalive( var_1[var_2].color_user ) )
            return var_1[var_2];
    }
}

get_colorcodes( var_0, var_1 )
{
    var_2 = strtok( var_0, " " );
    var_2 = common_scripts\utility::array_remove_duplicates( var_2 );
    var_3 = [];
    var_4 = [];
    var_5 = [];

    foreach ( var_7 in var_2 )
    {
        var_8 = undefined;

        foreach ( var_8 in level.colorlist )
        {
            if ( issubstr( var_7, var_8 ) )
                break;

            var_8 = undefined;
        }

        if ( !colorcode_is_used_in_map( var_1, var_7 ) )
            continue;

        var_4[var_8] = var_7;
        var_3[var_3.size] = var_8;
        var_5[var_5.size] = var_7;
    }

    var_12 = [];
    var_12["colorCodes"] = var_5;
    var_12["colorCodesByColorIndex"] = var_4;
    var_12["colors"] = var_3;
    return var_12;
}

colorcode_is_used_in_map( var_0, var_1 )
{
    if ( isdefined( level.arrays_of_colorcoded_nodes[var_0][var_1] ) )
        return 1;

    return isdefined( level.arrays_of_colorcoded_volumes[var_0][var_1] );
}

trigger_delete_target_chain()
{
    var_0 = [];
    var_1 = self;

    while ( isdefined( var_1 ) )
    {
        var_0[var_0.size] = var_1;

        if ( !isdefined( var_1.targetname ) )
            break;

        var_2 = getentarray( var_1.targetname, "target" );
        var_1 = undefined;

        foreach ( var_4 in var_2 )
        {
            if ( !isdefined( var_4.script_color_allies ) && !isdefined( var_4.script_color_axis ) )
                continue;

            var_1 = var_4;
        }
    }

    maps\_utility::array_delete( var_0 );
}

colorislegit( var_0 )
{
    for ( var_1 = 0; var_1 < level.colorlist.size; var_1++ )
    {
        if ( var_0 == level.colorlist[var_1] )
            return 1;
    }

    return 0;
}

get_team( var_0 )
{
    if ( isdefined( self.team ) && !isdefined( var_0 ) )
        var_0 = self.team;

    return level.color_teams[var_0];
}

get_colorcoded_nodes( var_0, var_1 )
{
    return level.arrays_of_colorcoded_nodes[var_0][var_1];
}

get_colorcoded_volume( var_0, var_1 )
{
    return level.arrays_of_colorcoded_volumes[var_0][var_1];
}

shortencolor( var_0 )
{
    return level.colorchecklist[tolower( var_0 )];
}

my_current_node_delays()
{
    if ( !isdefined( self.node ) )
        return 0;

    if ( isdefined( self.script_color_delay_override ) )
    {
        wait(self.script_color_delay_override);
        return 1;
    }

    return self.node maps\_utility::script_delay();
}

add_ai_to_colors( var_0, var_1 )
{
    self notify( "new_color_being_set" );
    self endon( "new_color_being_set" );
    self endon( "death" );
    self.new_force_color_being_set = 1;
    var_2 = shortencolor( var_0 );

    if ( !isai( self ) )
    {
        set_force_color_spawner( var_2 );
        return;
    }

    if ( self.team == "allies" )
    {
        self.pathenemyfightdist = 0;
        self.pathenemylookahead = 0;
    }

    self.script_color_axis = undefined;
    self.script_color_allies = undefined;
    self.old_forcecolor = undefined;
    var_3 = get_team();

    if ( isdefined( self.script_forcecolor ) )
        level.arrays_of_colorforced_ai[var_3][self.script_forcecolor] = common_scripts\utility::array_remove( level.arrays_of_colorforced_ai[var_3][self.script_forcecolor], self );

    self.script_forcecolor = var_2;
    level.arrays_of_colorforced_ai[var_3][self.script_forcecolor] = common_scripts\utility::array_add( level.arrays_of_colorforced_ai[var_3][self.script_forcecolor], self );
    self.currentcolorcode = level.currentcolorforced[get_team()][self.script_forcecolor];

    if ( isdefined( self.dontcolormove ) )
        self.dontcolormove = undefined;
    else if ( isdefined( var_1 ) )
        thread ai_go_to_goal_before_colors( var_1 );
    else
        thread goto_current_colorindex();

    self.new_force_color_being_set = undefined;
    self notify( "done_setting_new_color" );
}

ai_go_to_goal_before_colors( var_0 )
{
    self endon( "death" );
    var_1 = self.goalradius;
    self.goalradius = 128;
    self _meth_81A6( var_0 );
    self waittill( "goal" );
    self.goalradius = var_1;
    thread goto_current_colorindex();
}

remove_ai_from_colors()
{
    level.arrays_of_colorforced_ai[get_team()][self.script_forcecolor] = common_scripts\utility::array_remove( level.arrays_of_colorforced_ai[get_team()][self.script_forcecolor], self );
    left_color_node();
    self notify( "stop_color_move" );
    self.script_forcecolor = undefined;
    self.currentcolorcode = undefined;
    self.fixednode = 0;
    self.perforing_color_driven_anim = undefined;
    self.force_color_driven_anim = undefined;
}

set_force_color_spawner( var_0 )
{
    self.script_forcecolor = var_0;
    self.old_forcecolor = undefined;
}

goto_current_colorindex()
{
    if ( !isdefined( self.currentcolorcode ) )
        return;

    if ( !isdefined( self.finished_spawning ) )
        common_scripts\utility::waittill_either( "finished spawning", "death" );

    if ( !isalive( self ) )
        return;

    left_color_node();
    var_0[0] = self;
    issue_color_order_to_ai( self.currentcolorcode, self.script_forcecolor, self.team, var_0 );
}

issue_color_orders_generic( var_0, var_1 )
{
    var_2 = get_colorcodes( var_0, var_1 );
    var_3 = var_2["colorCodes"];
    var_4 = var_2["colorCodesByColorIndex"];
    var_5 = var_2["colors"];
    activate_color_code_internal( var_3, var_5, var_1, var_4 );
}

get_color_volume_from_trigger_codes()
{
    var_0 = get_color_info_from_trigger();
    var_1 = var_0["team"];

    foreach ( var_3 in var_0["codes"] )
    {
        var_4 = level.arrays_of_colorcoded_volumes[var_1][var_3];

        if ( isdefined( var_4 ) )
            return var_4;
    }

    return undefined;
}

get_color_nodes_from_trigger_codes()
{
    var_0 = get_color_info_from_trigger();
    var_1 = var_0["team"];

    foreach ( var_3 in var_0["codes"] )
    {
        var_4 = level.arrays_of_colorcoded_nodes[var_1][var_3];

        if ( isdefined( var_4 ) )
            return var_4;
    }

    return undefined;
}

get_color_info_from_trigger()
{
    var_0 = "allies";

    if ( isdefined( self.script_color_axis ) )
        var_0 = "axis";

    var_1 = [];

    if ( var_0 == "allies" )
    {
        var_2 = get_colorcodes( self.script_color_allies, "allies" );
        var_1 = var_2["colorCodes"];
    }
    else
    {
        var_2 = get_colorcodes( self.script_color_axis, "axis" );
        var_1 = var_2["colorCodes"];
    }

    var_3 = [];
    var_3["team"] = var_0;
    var_3["codes"] = var_1;
    return var_3;
}

colornode_clear_promotion_order()
{
    level.current_color_order = [];
}

colornode_set_promotion_order( var_0, var_1 )
{
    if ( !isdefined( level.current_color_order ) )
        level.current_color_order = [];

    var_0 = shortencolor( var_0 );
    var_1 = shortencolor( var_1 );
    level.current_color_order[var_0] = var_1;

    if ( !isdefined( level.current_color_order[var_1] ) )
        colornode_set_empty_promotion_order( var_1 );
}

colornode_set_empty_promotion_order( var_0 )
{
    if ( !isdefined( level.current_color_order ) )
        level.current_color_order = [];

    level.current_color_order[var_0] = "none";
}

get_color_to_promote_from_order( var_0 )
{
    if ( !isdefined( var_0 ) )
        return "none";

    if ( !isdefined( level.current_color_order ) )
        return "none";

    if ( !isdefined( level.current_color_order[var_0] ) )
        return "none";

    return level.current_color_order[var_0];
}

get_color_forced_ai( var_0, var_1 )
{
    if ( isdefined( level.arrays_of_colorforced_ai[var_0][var_1] ) )
    {
        level.arrays_of_colorforced_ai[var_0][var_1] = maps\_utility::array_removedead( level.arrays_of_colorforced_ai[var_0][var_1] );
        return level.arrays_of_colorforced_ai[var_0][var_1];
    }

    return undefined;
}

colornode_set_respawn_point( var_0, var_1 )
{
    if ( var_1 == "allies" || var_1 == "axis" )
        level.respawn_spawner_org[var_1] = var_0;
    else
    {
        level.respawn_spawner_org["allies"] = var_0;
        level.respawn_spawner_org["axis"] = var_0;
    }
}

colornode_spawn_reinforcement( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "kill_color_replacements" );
    level endon( "kill_hidden_reinforcement_waiting" );
    var_5 = spawn_hidden_reinforcement( var_0, var_1, var_2, var_4 );

    if ( !isdefined( var_5 ) )
    {
        var_6 = 0;

        if ( var_0 == "allies" && common_scripts\utility::flag( "respawn_friendlies" ) )
            var_6 = 1;
        else if ( var_0 == "axis" && common_scripts\utility::flag( "respawn_enemies" ) )
            var_6 = 1;

        if ( var_6 )
        {

        }

        return;
    }

    if ( var_5.team == "allies" && isdefined( level.friendly_startup_thread ) )
        var_5 thread [[ level.friendly_startup_thread ]]();
    else if ( var_5.team == "axis" && isdefined( level.enemy_startup_thread ) )
        var_5 thread [[ level.enemy_startup_thread ]]();

    if ( isdefined( var_3 ) && var_3 == 1 )
        var_5 thread colornode_replace_on_death();
}

spawn_hidden_reinforcement( var_0, var_1, var_2, var_3 )
{
    level endon( "kill_color_replacements" );
    level endon( "kill_hidden_reinforcement_waiting" );
    var_4 = undefined;

    if ( var_0 == "allies" && !common_scripts\utility::flag( "respawn_friendlies" ) )
        return undefined;

    if ( var_0 == "axis" && !common_scripts\utility::flag( "respawn_enemies" ) )
        return undefined;

    for (;;)
    {
        if ( !respawn_reinforcements_without_vision_check( var_0 ) )
        {
            if ( !isdefined( level.friendly_respawn_vision_checker_thread ) )
                thread spawner_vision_checker( "allies" );

            if ( !isdefined( level.enemy_respawn_vision_checker_thread ) )
                thread spawner_vision_checker( "axis" );

            for (;;)
            {
                wait_until_vision_check_satisfied_or_disabled( var_0 );

                if ( respawn_reinforcements_without_vision_check( var_0, 1 ) )
                    break;

                wait 0.05;
            }
        }

        thread lock_spawner_for_awhile( var_0 );
        var_5 = get_color_spawner( var_0, var_1 );
        var_5.count = 1;
        var_6 = var_5.origin;
        var_5.origin = level.respawn_spawner_org[var_0];
        var_7 = undefined;

        if ( isdefined( var_5.script_forcecolor ) )
        {
            var_7 = var_5.script_forcecolor;
            var_5.script_forcecolor = undefined;
        }

        var_4 = var_5 _meth_8094();
        var_5.script_forcecolor = var_7;
        var_5.origin = var_6;

        if ( maps\_utility::spawn_failed( var_4 ) )
        {
            thread lock_spawner_for_awhile( var_0 );
            wait 1;
            continue;
        }

        level notify( "reinforcement_spawned", var_4 );
        break;
    }

    var_4 add_ai_to_colors( var_2, var_3 );
    return var_4;
}

respawn_reinforcements_without_vision_check( var_0, var_1 )
{
    if ( !isdefined( var_1 ) || var_1 == 0 )
    {
        if ( var_0 == "allies" && isdefined( level.respawn_friendlies_force_vision_check ) )
            return 0;
        else if ( var_0 == "axis" && isdefined( level.respawn_enemies_force_vision_check ) )
            return 0;
    }

    if ( var_0 == "allies" )
        return common_scripts\utility::flag( "respawn_friendlies" ) && !common_scripts\utility::flag( "friendly_spawner_locked" );
    else if ( var_0 == "axis" )
        return common_scripts\utility::flag( "respawn_enemies" ) && !common_scripts\utility::flag( "enemy_spawner_locked" );
}

wait_until_vision_check_satisfied_or_disabled( var_0 )
{
    if ( var_0 == "allies" )
    {
        if ( common_scripts\utility::flag( "player_looks_away_from_friendly_spawner" ) )
            return;

        level endon( "player_looks_away_from_friendly_spawner" );
    }
    else
    {
        if ( common_scripts\utility::flag( "player_looks_away_from_enemy_spawner" ) )
            return;

        level endon( "player_looks_away_from_enemy_spawner" );
    }

    for (;;)
    {
        if ( respawn_reinforcements_without_vision_check( var_0 ) )
            return;

        wait 0.05;
    }
}

spawner_vision_checker( var_0 )
{
    if ( var_0 == "allies" )
        level.friendly_respawn_vision_checker_thread = 1;
    else
        level.enemy_respawn_vision_checker_thread = 1;

    var_1 = 0;

    for (;;)
    {
        wait 1.0;

        if ( !isdefined( level.respawn_spawner_org[var_0] ) )
        {
            var_1 = 0;
            continue;
        }

        var_2 = level.respawn_spawner_org[var_0] - level.player.origin;

        if ( length( var_2 ) < 200 )
        {
            player_sees_spawner( var_0 );
            var_1 = 0;
            continue;
        }

        var_3 = anglestoforward( ( 0, level.player getangles()[1], 0 ) );
        var_4 = vectornormalize( var_2 );
        var_5 = vectordot( var_3, var_4 );

        if ( var_5 > 0.2 )
        {
            var_6 = !sighttracepassed( level.player _meth_80A8(), level.respawn_spawner_org[var_0], 0, level.player );

            if ( var_6 )
                var_6 = !sighttracepassed( level.player _meth_80A8(), level.respawn_spawner_org[var_0] + ( 0, 0, 96 ), 0, level.player );

            if ( !var_6 )
            {
                player_sees_spawner( var_0 );
                var_1 = 0;
                continue;
            }
        }

        var_1++;

        if ( var_1 < 3 )
            continue;

        player_does_not_see_spawner( var_0 );
    }
}

player_sees_spawner( var_0 )
{
    if ( var_0 == "allies" )
        common_scripts\utility::flag_clear( "player_looks_away_from_friendly_spawner" );
    else
        common_scripts\utility::flag_clear( "player_looks_away_from_enemy_spawner" );
}

player_does_not_see_spawner( var_0 )
{
    if ( var_0 == "allies" )
        common_scripts\utility::flag_set( "player_looks_away_from_friendly_spawner" );
    else
        common_scripts\utility::flag_set( "player_looks_away_from_enemy_spawner" );
}

get_color_spawner( var_0, var_1 )
{
    if ( isdefined( var_1 ) && isdefined( level.arrays_color_spawners[var_0][var_1] ) )
        return common_scripts\utility::random( level.arrays_color_spawners[var_0][var_1] );
    else
    {
        var_2 = getarraykeys( level.arrays_color_spawners[var_0] );
        var_3 = [];

        foreach ( var_5 in var_2 )
            var_3 = common_scripts\utility::array_add( var_3, level.arrays_color_spawners[var_5] );

        return common_scripts\utility::random( var_3 );
    }
}

lock_spawner_for_awhile( var_0 )
{
    level notify( "stop_lock_spawner_for_team_" + var_0 );
    level endon( "stop_lock_spawner_for_team_" + var_0 );

    if ( var_0 == "allies" )
        common_scripts\utility::flag_set( "friendly_spawner_locked" );
    else
        common_scripts\utility::flag_set( "enemy_spawner_locked" );

    if ( var_0 == "allies" && isdefined( level.friendly_respawn_lock_func ) )
        [[ level.friendly_respawn_lock_func ]]();
    else if ( var_0 == "axis" && isdefined( level.enemy_respawn_lock_func ) )
        [[ level.enemy_respawn_lock_func ]]();
    else
        wait 2;

    if ( var_0 == "allies" )
        common_scripts\utility::flag_clear( "friendly_spawner_locked" );
    else
        common_scripts\utility::flag_clear( "enemy_spawner_locked" );
}

colornode_replace_on_death()
{
    level endon( "kill_color_replacements" );
    self endon( "_disable_reinforcement" );

    if ( isdefined( self.replace_on_death ) )
        return;

    self.replace_on_death = 1;
    waittillframeend;

    if ( isalive( self ) )
        self waittill( "death" );

    if ( _func_294( self ) )
        return;

    var_0 = self.classname;
    var_1 = self.script_forcecolor;
    var_2 = self.team;
    var_3 = self.origin;

    if ( !isdefined( var_1 ) )
        return;

    var_4 = get_color_to_promote_from_order( var_1 );

    if ( var_4 != "none" )
    {
        for (;;)
        {
            var_5 = get_color_forced_ai( var_2, var_4 );

            if ( !isdefined( var_5 ) )
                break;

            if ( !isdefined( level.color_doesnt_care_about_heroes ) )
                var_5 = maps\_utility::remove_heroes_from_array( var_5 );

            if ( !isdefined( level.color_doesnt_care_about_classname ) )
                var_5 = maps\_utility::remove_without_classname( var_5, var_0 );

            if ( var_5.size <= 0 )
                break;

            var_6 = common_scripts\utility::getclosest( var_3, var_5 );

            if ( !isalive( var_6 ) )
                continue;

            var_7 = var_6.classname;
            var_4 = var_6.script_forcecolor;
            var_6 add_ai_to_colors( var_1, var_3 );

            if ( var_2 == "allies" && isdefined( level.friendly_promotion_thread ) )
                var_6 [[ level.friendly_promotion_thread ]]( var_1 );

            if ( var_2 == "axis" && isdefined( level.enemy_promotion_thread ) )
                var_6 [[ level.enemy_promotion_thread ]]( var_1 );

            var_0 = var_7;
            var_1 = var_4;
            var_3 = var_6.origin;
            break;
        }
    }

    thread colornode_spawn_reinforcement( var_2, var_0, var_1, 1, var_3 );
}

colornode_stop_replace_on_death_group( var_0, var_1 )
{
    if ( isdefined( var_1 ) && !colorislegit( var_1 ) )
    {

    }

    foreach ( var_3 in level.colorlist )
    {
        if ( isdefined( var_1 ) && var_3 != var_1 )
            continue;

        if ( isdefined( var_0 ) && var_0 == "axis" || var_0 == "allies" )
        {
            foreach ( var_5 in level.arrays_of_colorforced_ai[var_0][var_3] )
            {
                if ( isalive( var_5 ) )
                    var_5 notify( "_disable_reinforcement" );
            }

            continue;
        }

        foreach ( var_5 in level.arrays_of_colorforced_ai["axis"][var_3] )
        {
            if ( isalive( var_5 ) )
                var_5 notify( "_disable_reinforcement" );
        }

        foreach ( var_5 in level.arrays_of_colorforced_ai["allies"][var_3] )
        {
            if ( isalive( var_5 ) )
                var_5 notify( "_disable_reinforcement" );
        }
    }
}

kill_color_replacements()
{
    common_scripts\utility::flag_clear( "friendly_spawner_locked" );
    common_scripts\utility::flag_clear( "enemy_spawner_locked" );
    level notify( "kill_color_replacements" );
    var_0 = _func_0D6();
    common_scripts\utility::array_thread( var_0, ::remove_replace_on_death );
}

remove_replace_on_death()
{
    self.replace_on_death = undefined;
}
