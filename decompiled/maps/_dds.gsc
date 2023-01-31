// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

dds_init()
{
    level.dds = spawnstruct();
    level.dds.heartbeat = 0.25;
    level.dds.max_active_events = 6;
    level.dds.variant_limit = 17;
    level.dds.category_backoff_limit = 2;
    level.dds.scripted_line_delay = 2;
    level.dds.response_distance_min = 500;
    level.dds.history = [];
    level.dds.history_count = 15;
    level.dds.history_index = 0;
    level.dds.response_wait = 0.25;
    level.dds.response_wait_axis = 0.25;
    level.dds.trigger_string = "trig";
    level.dds.heightforhighcallout = 96.0;
    level.dds.using_overrides = 0;
    level.dds.reinforcement_endtime = [];
    init_dds_countryids();
    init_dds_category_groups();
    init_dds_category_groups_axis();
    init_dds_flags();
    init_dds_categories();
    init_dds_categories_axis();
    init_dds_active_events();
    setdvar( "dds_debug_table_active", 1 );
    setdvar( "dds_drawDebugTable", 0 );
    setdvar( "dds_logErrorsAndRequests", 0 );
    setdvar( "dds_drawDebugInfo", 0 );
    setdvar( "dds_drawDebugVerbose", 0 );
    setdvar( "dds_drawDebugFlank", 0 );
    setdvar( "dds_battlechater_disable", 0 );

    if ( !isdefined( anim.bcs_locations ) )
        common_scripts\_bcs_location_trigs::bcs_location_trigs_init();

    override_dds_categories();
}

init_dds_countryids( var_0, var_1 )
{
    level.dds.characterid_count = 0;
    level.dds.countryids = [];
    add_dds_countryid( "british", "UK", 2 );
    add_dds_countryid( "american", "US", 3 );
    add_dds_countryid( "seal", "NS", 4 );
    add_dds_countryid( "taskforce", "TF", 1 );
    add_dds_countryid( "secretservice", "SS", 4 );
    add_dds_countryid( "delta", "DF", 3 );
    add_dds_countryid( "french", "FR", 3 );
    add_dds_countryid( "czech", "CZ", 3 );
    add_dds_countryid( "pmc", "PC", 3 );
    add_dds_countryid( "russian", "RU", 3 );
    add_dds_countryid( "arab", "AB", 3 );
    add_dds_countryid( "portugese", "PG", 3 );
    add_dds_countryid( "shadowcompany", "SC", 4 );
    add_dds_countryid( "african", "AF", 3 );
    add_dds_countryid( "seal", "GS", 1 );
    add_dds_countryid( "shadowcompany", "SP", 1 );
    add_dds_countryid( "xslice", "XS", 3 );
    add_dds_countryid( "atlas", "AT", 3 );
    add_dds_countryid( "kva", "KV", 3 );
    add_dds_countryid( "sentinel", "SE", 3 );
    add_dds_countryid( "squad", "SQ", 3 );
    add_dds_countryid( "northkorea", "NK", 3 );
}

add_dds_countryid( var_0, var_1, var_2 )
{
    level.dds.countryids[var_0] = spawnstruct();
    level.dds.countryids[var_0].label = var_1;
    level.dds.countryids[var_0].count = 0;
    level.dds.countryids[var_0].max_voices = var_2;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_1 + var_3;
        level.dds.characterid_is_talking_currently[var_4] = 0;
    }
}

init_dds_category_groups()
{
    level.dds.category_groups = [];
    add_dds_category_group( "oclock", 5 );
}

add_dds_category_group( var_0, var_1 )
{
    level.dds.category_groups[var_0] = spawnstruct();
    level.dds.category_groups[var_0].timeout_reset = var_1;
    level.dds.category_groups[var_0].timeout = 0;
    level.dds.category_groups[var_0].categories = [];
    level.dds.category_groups[var_0].last_timeout = var_1;
    level.dds.category_groups[var_0].last_time = gettime();
    level.dds.category_groups[var_0].backoff_count = 0;
}

init_dds_category_groups_axis()
{
    level.dds.category_groups_axis = [];
    add_dds_category_group_axis( "oclock", 5 );
}

add_dds_category_group_axis( var_0, var_1 )
{
    level.dds.category_groups_axis[var_0] = spawnstruct();
    level.dds.category_groups_axis[var_0].timeout_reset = var_1;
    level.dds.category_groups_axis[var_0].timeout = 0;
    level.dds.category_groups_axis[var_0].categories = [];
    level.dds.category_groups_axis[var_0].last_timeout = var_1;
    level.dds.category_groups_axis[var_0].last_time = gettime();
    level.dds.category_groups_axis[var_0].backoff_count = 0;
}

init_dds_flags()
{
    common_scripts\utility::flag_init( "dds_running_allies" );
    level thread dds_send_team_notify_on_disable( "allies" );
    common_scripts\utility::flag_init( "dds_running_axis" );
    level thread dds_send_team_notify_on_disable( "axis" );
}

init_dds_categories()
{
    if ( !isdefined( level.dds.categories ) )
        level.dds.categories = [];

    add_dds_category( "react_ast", "react_ast", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_zipliners", "react_zipliners", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_man_down", "react_man_down", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_microwave", "react_microwave", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_boost_jumpers", "react_boost_jumpers", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_drones", "react_drones", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_elite", "react_elite", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_dogs", "react_dogs", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_mmg", "react_mmg", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_friendly_fire", "react_friendly_fire", 3, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.8, 1, 0, "", undefined, undefined );
    add_dds_category( "react_sniper", "react_sniper", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 240, 0, "", undefined, undefined );
    add_dds_category( "react_rpg", "react_rpg", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 10, 0, "", undefined, undefined );
    add_dds_category( "react_emp", "react_emp", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category( "react_grenade", "react_grenade", 1.25, "grenade_rspns", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category( "kill_confirm", "act_kill_confirm", 2, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.7, 1.5, 0, "", undefined, undefined );
    add_dds_category( "headshot", "act_kill_confirm", 0.75, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.7, 1.5, 0, "", undefined, undefined );
    add_dds_category( "rspns_killfirm", "rspns_killfirm", 0.75, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 1, 1.5, 0, "", undefined, undefined );
    add_dds_category( "rspns_movement", "rspns_movement", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.2, 13.5, 0, "", undefined, undefined );
    add_dds_category( "fragout", "act_fragout", 0.75, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category( "empout", "act_empout", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.7, 1.5, 0, "", undefined, undefined );
    add_dds_category( "trigger", level.dds.trigger_string, 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.95, 20, 1, "rspns_affirm", ::alt_rspns_random_test, undefined );
    add_dds_category( "thrt_left", "thrt_left", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_right", "thrt_right", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_behind", "thrt_behind", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_front", "thrt_front", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_flankleft", "thrt_flankleft", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_flankright", "thrt_flankright", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_flank", "thrt_flank", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category( "thrt_clock01", "thrt_clock01", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock10", "thrt_clock10", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock11", "thrt_clock11", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock12", "thrt_clock12", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock02", "thrt_clock02", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock03", "thrt_clock03", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock04", "thrt_clock04", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock05", "thrt_clock05", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock06", "thrt_clock06", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock07", "thrt_clock07", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock08", "thrt_clock08", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_clock09", "thrt_clock09", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category( "thrt_dist10", "thrt_dist10", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category( "thrt_dist20", "thrt_dist20", 2.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category( "thrt_dist30", "thrt_dist30", 2.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category( "thrt_dist40", "thrt_dist40", 2.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category( "thrt_open", "thrt_open", 2.5, "rspns_suppress", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0, "", undefined, undefined );
    add_dds_category( "thrt_exposed", "thrt_exposed", 2.5, "rspns_suppress", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0, "", undefined, undefined );
    add_dds_category( "thrt_movement", "thrt_movement", 2.5, "thrt_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0, "", undefined, undefined );
    add_dds_category( "thrt_breaking", "thrt_breaking", 2.5, "rspns_lm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.1, 7.5, 0, "", undefined, undefined );
    add_dds_category( "rspns_act", "rspns_act", 2.0, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.2, 4, 0, "", undefined, undefined );
    add_dds_category( "rspns_affirm", "rspns_affirm", 2.0, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.2, 4, 0, "", undefined, undefined );
    add_dds_category( "rspns_neg", "rspns_neg", 2.0, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.2, 4, 0, "", undefined, undefined );
    add_dds_category( "rspns_suppress", "react_suppress", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.8, 14, 0, "", undefined, undefined );
    add_dds_category( "casualty", "react_casualty", 2.0, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2800, 1, 1.4, 0, "", undefined, undefined );
    add_dds_category( "reload", "act_reload", 2, "action_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 3.5, 0, "", undefined, undefined );
    add_dds_category( "kill_melee", "kill_melee", 0.75, "", 1, ::dds_sort_ent_dist, ::get_attacker, 400, 1, 3.5, 0, "", undefined, undefined );
    add_dds_category( "order_combatmove", "order_combatmove", 3, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
    add_dds_category( "order_noncombatmove", "order_noncombatmove", 3, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
    add_dds_category( "order_coverme", "order_coverme", 3, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.7, 8, 0, "", undefined, undefined );
    add_dds_category( "react_leave_cover", "react_leave_cover", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category( "react_cantsee", "react_cantsee", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 300, 1.5, 0, "", undefined, undefined );
    add_dds_category( "act_moving", "act_moving", 0.75, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category( "order_suppress", "order_suppress", 3, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
    add_dds_category( "order_coverme", "order_coverme", 3, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
    add_dds_category( "order_kill_command", "order_kill_command", 3, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
}

init_dds_categories_axis()
{
    if ( !isdefined( level.dds.categories_axis ) )
        level.dds.categories_axis = [];

    add_dds_category_axis( "react_em1", "react_em1", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_smart", "react_smart", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_rpg", "react_rpg", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 3000, 0.8, 10, 0, "", undefined, undefined );
    add_dds_category_axis( "react_emp", "react_emp", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_grenade", "react_grenade", 1.25, "grenade_rspns", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_sniper", "react_sniper", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_acquired", "thrt_acquired", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 16.5, 0, "", undefined, undefined );
    add_dds_category_axis( "kill_confirm", "act_kill_confirm", 2, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.7, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "headshot", "act_kill_confirm", 0.75, "rspns_killfirm", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.7, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "rspns_killfirm", "rspns_killfirm", 0.75, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2500, 0.3, 7, 0, "", undefined, undefined );
    add_dds_category_axis( "rspns_movement", "rspns_movement", 0.5, "", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.2, 13.5, 0, "", undefined, undefined );
    add_dds_category_axis( "fragout", "act_fragout", 0.75, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "empout", "act_empout", 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.7, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "trigger", level.dds.trigger_string, 0.5, "rspns_act", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.95, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_dist10", "thrt_dist10", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_dist20", "thrt_dist20", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_dist30", "thrt_dist30", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_dist40", "thrt_dist40", 0.5, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 3000, 0.2, 15, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_open", "thrt_open", 1.0, "rspns_suppress", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.7, 18, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_exposed", "thrt_exposed", 2.5, "rspns_suppress", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 18, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_movement", "thrt_movement", 1.0, "thrt_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.7, 18, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_breaking", "thrt_breaking", 1.0, "rspns_lm", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.7, 7.5, 0, "", undefined, undefined );
    add_dds_category_axis( "rspns_act", "rspns_act", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.2, 4, 0, "", undefined, undefined );
    add_dds_category_axis( "rspns_affirm", "rspns_affirm", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.2, 4, 0, "", undefined, undefined );
    add_dds_category_axis( "rspns_neg", "rspns_neg", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.2, 4, 0, "", undefined, undefined );
    add_dds_category_axis( "thrt_clock01", "thrt_clock01", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock02", "thrt_clock02", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock03", "thrt_clock03", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock04", "thrt_clock04", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock05", "thrt_clock05", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock06", "thrt_clock06", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock07", "thrt_clock07", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock08", "thrt_clock08", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock09", "thrt_clock09", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock10", "thrt_clock10", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock11", "thrt_clock11", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock12", "thrt_clock12", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock01h", "thrt_clock01h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock02h", "thrt_clock02h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock03h", "thrt_clock03h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock04h", "thrt_clock04h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock05h", "thrt_clock05h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock06h", "thrt_clock06h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock07h", "thrt_clock07h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock08h", "thrt_clock08h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock09h", "thrt_clock09h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock10h", "thrt_clock10h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock11h", "thrt_clock11h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_clock12h", "thrt_clock12h", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, "use_group", 1, "", undefined, "oclock" );
    add_dds_category_axis( "thrt_left", "thrt_left", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_right", "thrt_right", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_behind", "thrt_behind", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_front", "thrt_front", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_flankleft", "thrt_flankleft", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_flankright", "thrt_flankright", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_flank", "thrt_flank", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_self_ent, 2000, 0.1, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinaln", "thrt_cardinaln", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinalne", "thrt_cardinalne", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinale", "thrt_cardinale", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinalse", "thrt_cardinalse", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinals", "thrt_cardinals", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinalsw", "thrt_cardinalsw", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinalw", "thrt_cardinalw", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "thrt_cardinalnw", "thrt_cardinalnw", 2.0, "react_cover", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2000, 0.15, 20, 1, "", undefined, undefined );
    add_dds_category_axis( "rspns_suppress", "react_suppress", 0.5, "", 1, ::dds_sort_ent_dist, ::get_nearest, 2000, 0.8, 14, 0, "", undefined, undefined );
    add_dds_category_axis( "casualty", "react_casualty", 2.0, "", 1, ::dds_sort_ent_dist, ::get_nearest_not_plr, 2800, 1, 1.4, 0, "", undefined, undefined );
    add_dds_category_axis( "reload", "act_reload", 2, "action_rspns", 1, ::dds_sort_ent_dist, ::get_self_ent, 5000, 0.3, 3.5, 0, "", undefined, undefined );
    add_dds_category_axis( "kill_melee", "kill_melee", 0.75, "", 1, ::dds_sort_ent_dist, ::get_attacker, 400, 1, 3.5, 0, "", undefined, undefined );
    add_dds_category_axis( "order_combatmove", "order_combatmove", 3, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
    add_dds_category_axis( "order_noncombatmove", "order_noncombatmove", 3, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.3, 8, 0, "", undefined, undefined );
    add_dds_category_axis( "order_coverme", "order_coverme", 3, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 2500, 0.7, 8, 0, "", undefined, undefined );
    add_dds_category_axis( "react_threat", "react_threat", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_getting_away", "react_getting_away", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_cantsee", "react_cantsee", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "react_vehicle", "react_vehicle", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "order_kill_command", "order_kill_command", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "order_reinforce", "order_reinforce", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "order_flush", "order_flush", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "order_suppress", "order_suppress", 1.25, "", 1, ::dds_sort_ent_dist, ::get_nearest, 3000, 0.4, 26.5, 0, "", undefined, undefined );
    add_dds_category_axis( "act_moving", "act_moving", 0.75, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0, "", undefined, undefined );
    add_dds_category_axis( "act_advancing", "act_advancing", 0.75, "rspns_act", 1, ::dds_sort_ent_dist, ::get_self_ent, 4000, 0.8, 1.5, 0, "", undefined, undefined );
}

override_dds_categories()
{
    if ( animscripts\battlechatter::is_xslice() )
    {
        override_dds_category_allteams( "trigger", undefined, undefined, undefined, undefined, undefined, undefined, 1.0, 10.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_open", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_exposed", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_movement", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_breaking", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist10", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist20", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist30", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist40", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock01", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock02", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock03", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock04", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock05", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock06", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock07", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock08", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock09", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock10", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock11", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock12", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "react_grenade", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "react_emp", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "react_sniper", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "rspns_neg", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_acquired", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "kill_confirm", undefined, undefined, undefined, undefined, undefined, undefined, 0.5, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinaln", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalne", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinale", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalse", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinals", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalsw", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalw", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalnw", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "order_combatmove", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "order_noncombatmove", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "order_coverme", undefined, undefined, undefined, undefined, undefined, undefined, 0.0, undefined, undefined, undefined, undefined, undefined );
        level.dds.using_overrides = 1;
    }

    if ( isdefined( level._stealth ) )
    {
        override_dds_category_allteams( "trigger", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist10", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist20", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist30", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_dist40", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_open", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_exposed", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_movement", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_breaking", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock01", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock02", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock03", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock04", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock05", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock06", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock07", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock08", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock09", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock10", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock11", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock12", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_acquired", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinaln", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalne", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinale", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinals", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalsw", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalw", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_cardinalnw", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 30.0, undefined, undefined, undefined, undefined );
        level.dds.using_overrides = 1;
    }

    if ( animscripts\battlechatter::is_greece() )
    {
        override_dds_category_allteams( "trigger", undefined, undefined, undefined, undefined, undefined, undefined, 1.0, 10.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock01", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock02", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock03", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock04", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock05", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock06", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock07", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock08", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock09", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock10", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock11", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        override_dds_category_allteams( "thrt_clock12", undefined, undefined, undefined, undefined, undefined, undefined, 0.1, 20.0, undefined, undefined, undefined, undefined );
        level.dds.using_overrides = 1;
    }
}

add_dds_category( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 )
{
    if ( isdefined( level.dds.active_events ) )
    {
        for ( var_14 = 0; var_14 < level.dds.categories.size; var_14++ )
        {
            if ( level.dds.categories[var_14].name == var_0 )
            {
                if ( isdefined( var_1 ) )
                    level.dds.categories[var_14].alias_name = var_1;

                if ( isdefined( var_2 ) )
                    level.dds.categories[var_14].duration = var_2;

                if ( isdefined( var_3 ) )
                    level.dds.categories[var_14].rspns_cat_name = var_3;

                if ( isdefined( var_4 ) )
                    level.dds.categories[var_14].clear_on_action_success = var_4;

                if ( isdefined( var_5 ) )
                    level.dds.categories[var_14].priority_sort = var_5;

                if ( isdefined( var_6 ) )
                    level.dds.categories[var_14].get_talker_func = var_6;

                if ( isdefined( var_7 ) )
                    level.dds.categories[var_14].speaker_distance = var_7;

                if ( isdefined( var_8 ) )
                    level.dds.categories[var_14].probability = var_8;

                if ( isdefined( var_9 ) )
                    level.dds.categories[var_14].timeout_reset = var_9;

                if ( isdefined( var_10 ) )
                    level.dds.categories[var_14].should_squelch = var_10;

                if ( isdefined( var_11 ) )
                    level.dds.categories[var_14].rspns_cat_name_alt = var_11;

                if ( isdefined( var_12 ) )
                    level.dds.categories[var_14].alt_rspns_test_func = var_12;

                if ( isdefined( var_13 ) )
                {
                    level.dds.categories[var_14].group = var_13;
                    level.dds.category_groups[var_13].categories[level.dds.category_groups[var_13].categories.size] = var_0;
                }

                return;
            }
        }
    }
    else
    {
        var_15 = spawnstruct();
        var_15.name = var_0;
        var_15.alias_name = var_1;
        var_15.duration = var_2;
        var_15.priority_sort = var_5;
        var_15.probability = var_8;
        var_15.get_talker_func = var_6;
        var_15.speaker_distance = var_7;
        var_15.last_time = gettime();
        var_15.backoff_count = 0;
        var_15.timeout = randomint( 10 );
        var_15.last_timeout = var_15.timeout;
        var_15.timeout_reset = var_9;
        var_15.rspns_cat_name = var_3;
        var_15.clear_on_action_success = var_4;
        var_15.should_squelch = var_10;
        var_15.rspns_cat_name_alt = var_11;
        var_15.alt_rspns_test_func = var_12;
        var_15.group = var_13;

        if ( isdefined( var_13 ) )
            level.dds.category_groups[var_13].categories[level.dds.category_groups[var_13].categories.size] = var_0;

        level.dds.categories[level.dds.categories.size] = var_15;
    }
}

add_dds_category_axis( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 )
{
    if ( isdefined( level.dds.active_events_axis ) )
    {
        for ( var_14 = 0; var_14 < level.dds.categories.size; var_14++ )
        {
            if ( level.dds.categories_axis[var_14].name == var_0 )
            {
                if ( isdefined( var_1 ) )
                    level.dds.categories_axis[var_14].alias_name = var_1;

                if ( isdefined( var_2 ) )
                    level.dds.categories_axis[var_14].duration = var_2;

                if ( isdefined( var_3 ) )
                    level.dds.categories_axis[var_14].rspns_cat_name = var_3;

                if ( isdefined( var_4 ) )
                    level.dds.categories_axis[var_14].clear_on_action_success = var_4;

                if ( isdefined( var_5 ) )
                    level.dds.categories_axis[var_14].priority_sort = var_5;

                if ( isdefined( var_6 ) )
                    level.dds.categories_axis[var_14].get_talker_func = var_6;

                if ( isdefined( var_7 ) )
                    level.dds.categories_axis[var_14].speaker_distance = var_7;

                if ( isdefined( var_8 ) )
                    level.dds.categories_axis[var_14].probability = var_8;

                if ( isdefined( var_9 ) )
                    level.dds.categories_axis[var_14].timeout_reset = var_9;

                if ( isdefined( var_11 ) )
                    level.dds.new_category_axis[var_14].rspns_cat_name_alt = var_11;

                if ( isdefined( var_12 ) )
                    level.dds.categories_axis[var_14].alt_rspns_test_func = var_12;

                if ( isdefined( var_13 ) )
                {
                    level.dds.categories_axis[var_14].group = var_13;
                    level.dds.category_groups_axis[var_13].categories[level.dds.category_groups_axis[var_13].categories.size] = var_0;
                }

                return;
            }
        }
    }
    else
    {
        var_15 = spawnstruct();
        var_15.name = var_0;
        var_15.alias_name = var_1;
        var_15.duration = var_2;
        var_15.priority_sort = var_5;
        var_15.probability = var_8;
        var_15.get_talker_func = var_6;
        var_15.speaker_distance = var_7;
        var_15.last_time = gettime();
        var_15.backoff_count = 0;
        var_15.timeout = randomint( 10 );
        var_15.last_timeout = var_15.timeout;
        var_15.timeout_reset = var_9;
        var_15.rspns_cat_name = var_3;
        var_15.clear_on_action_success = var_4;
        var_15.rspns_cat_name_alt = var_11;
        var_15.alt_rspns_test_func = var_12;
        var_15.group = var_13;

        if ( isdefined( var_13 ) )
            level.dds.category_groups_axis[var_13].categories[level.dds.category_groups_axis[var_13].categories.size] = var_0;

        level.dds.categories_axis[level.dds.categories_axis.size] = var_15;
    }
}

init_dds_active_events()
{
    level.dds.active_events = [];
    level.dds.active_events_axis = [];

    for ( var_0 = 0; var_0 < level.dds.categories.size; var_0++ )
        level.dds.active_events[level.dds.categories[var_0].name] = [];

    for ( var_0 = 0; var_0 < level.dds.categories_axis.size; var_0++ )
        level.dds.active_events_axis[level.dds.categories_axis[var_0].name] = [];
}

override_dds_category_allteams( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    override_dds_category( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 );
    override_dds_category_axis( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 );
}

override_dds_category( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    add_dds_category( var_0, undefined, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 );
}

override_dds_category_axis( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    add_dds_category_axis( var_0, undefined, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 );
}

reset_dds_categories()
{
    init_dds_categories();
    init_dds_categories_axis();
    level.dds.using_overrides = 0;
}

dds_clear_old_expired_events()
{
    for ( var_0 = 0; var_0 < level.dds.categories.size; var_0++ )
    {
        var_1 = level.dds.categories[var_0];

        for ( var_2 = 0; var_2 < level.dds.active_events[var_1.name].size; var_2++ )
        {
            level.dds.active_events[var_1.name][var_2].duration -= level.dds.heartbeat;

            if ( level.dds.active_events[var_1.name][var_2].duration <= 0 || level.dds.active_events[var_1.name][var_2].clear_event_on_prob )
                level.dds.active_events[var_1.name] = common_scripts\utility::array_remove( level.dds.active_events[var_1.name], level.dds.active_events[var_1.name][var_2] );
        }
    }
}

dds_clear_old_expired_events_axis()
{
    for ( var_0 = 0; var_0 < level.dds.categories_axis.size; var_0++ )
    {
        var_1 = level.dds.categories_axis[var_0];

        for ( var_2 = 0; var_2 < level.dds.active_events_axis[var_1.name].size; var_2++ )
        {
            level.dds.active_events_axis[var_1.name][var_2].duration -= level.dds.heartbeat;

            if ( level.dds.active_events_axis[var_1.name][var_2].duration <= 0 || level.dds.active_events_axis[var_1.name][var_2].clear_event_on_prob )
                level.dds.active_events_axis[var_1.name] = common_scripts\utility::array_remove( level.dds.active_events_axis[var_1.name], level.dds.active_events_axis[var_1.name][var_2] );
        }
    }
}

dds_clear_all_queued_events()
{
    for ( var_0 = 0; var_0 < level.dds.categories.size; var_0++ )
    {
        for ( var_1 = 0; var_1 < level.dds.active_events[level.dds.categories[var_0].name].size; var_1++ )
            level.dds.active_events[level.dds.categories[var_0].name] = [];
    }
}

dds_clear_all_queued_events_axis()
{
    for ( var_0 = 0; var_0 < level.dds.categories_axis.size; var_0++ )
    {
        for ( var_1 = 0; var_1 < level.dds.active_events_axis[level.dds.categories_axis[var_0].name].size; var_1++ )
            level.dds.active_events_axis[level.dds.categories_axis[var_0].name] = [];
    }
}

dds_main_process()
{
    if ( common_scripts\utility::flag( "dds_running_allies" ) )
        return;

    common_scripts\utility::flag_set( "dds_running_allies" );
    dds_find_threats( "allies", "axis" );
    var_0 = 0;

    while ( common_scripts\utility::flag( "dds_running_allies" ) )
    {
        if ( isdefined( level.numberofimportantpeopletalking ) && level.numberofimportantpeopletalking > 0 )
        {
            var_0 = 1;
            wait(level.dds.heartbeat);
            continue;
        }

        if ( var_0 )
        {
            wait(level.dds.scripted_line_delay);
            dds_clear_all_queued_events();
            var_0 = 0;
        }

        if ( !dds_process_active_events() )
            wait(level.dds.heartbeat);
        else
            wait 0.1;

        dds_clear_old_expired_events();
    }
}

dds_main_process_axis()
{
    if ( common_scripts\utility::flag( "dds_running_axis" ) )
        return;

    common_scripts\utility::flag_set( "dds_running_axis" );
    dds_find_threats( "axis", "allies" );
    var_0 = 0;

    while ( common_scripts\utility::flag( "dds_running_axis" ) )
    {
        if ( isdefined( level.numberofimportantpeopletalking ) && level.numberofimportantpeopletalking > 1 )
        {
            var_0 = 1;
            wait(level.dds.heartbeat);
            continue;
        }

        if ( var_0 )
        {
            wait(level.dds.scripted_line_delay);
            dds_clear_all_queued_events_axis();
            var_0 = 0;
        }

        if ( dds_process_active_events_axis() )
            wait(level.dds.heartbeat);
        else
            wait 0.1;

        dds_clear_old_expired_events_axis();
    }
}

dds_find_threats( var_0, var_1 )
{
    level thread dds_find_infantry_threat( var_0, var_1 );
}

dds_enable( var_0 )
{
    if ( !isdefined( level.dds ) )
        return;

    if ( !isdefined( var_0 ) )
    {
        level thread dds_main_process();
        level thread dds_main_process_axis();
    }
    else if ( var_0 == "allies" )
        level thread dds_main_process();
    else if ( var_0 == "axis" )
        level thread dds_main_process_axis();
}

dds_disable( var_0 )
{
    if ( !isdefined( level.dds ) )
        return;

    if ( !isdefined( var_0 ) )
    {
        dds_clear_all_queued_events();
        common_scripts\utility::flag_clear( "dds_running_allies" );
        dds_clear_all_queued_events_axis();
        common_scripts\utility::flag_clear( "dds_running_axis" );
    }
    else
    {
        switch ( var_0 )
        {
            case "axis":
                dds_clear_all_queued_events_axis();
                common_scripts\utility::flag_clear( "dds_running_axis" );
                break;
            case "allies":
                dds_clear_all_queued_events();
                common_scripts\utility::flag_clear( "dds_running_allies" );
                break;
            default:
                break;
        }
    }
}

dds_send_team_notify_on_disable( var_0 )
{
    for (;;)
    {
        common_scripts\utility::flag_waitopen( "dds_running_" + var_0 );
        level notify( "dds_running_" + var_0 );
        common_scripts\utility::flag_wait( "dds_running_" + var_0 );
    }
}

is_dds_enabled()
{
    if ( !isdefined( level.dds ) )
        return 0;

    if ( level.createfx_enabled || !common_scripts\utility::flag( "dds_running_allies" ) && !common_scripts\utility::flag( "dds_running_axis" ) )
        return 0;

    return 1;
}

exponent( var_0, var_1 )
{
    if ( var_1 == 0 )
        return 1;

    return var_0 * exponent( var_0, var_1 - 1 );
}

dds_process_active_events()
{
    foreach ( var_1 in level.dds.category_groups )
    {
        if ( var_1.timeout > 0 )
            var_1.timeout -= level.dds.heartbeat;
    }

    for ( var_3 = 0; var_3 < level.dds.categories.size; var_3++ )
    {
        var_4 = level.dds.categories[var_3];

        if ( isstring( var_4.timeout_reset ) && var_4.timeout_reset == "use_group" )
        {
            if ( level.dds.category_groups[var_4.group].timeout > 0 )
                continue;
        }
        else if ( var_4.timeout > 0 )
        {
            var_4.timeout -= level.dds.heartbeat;
            continue;
        }

        if ( level.dds.active_events[var_4.name].size != 0 )
        {
            level.dds.active_events[var_4.name] = [[ var_4.priority_sort ]]( level.dds.active_events[var_4.name] );

            for ( var_5 = 0; var_5 < level.dds.active_events[var_4.name].size; var_5++ )
            {
                if ( randomfloat( 1 ) >= var_4.probability )
                {
                    level.dds.active_events[var_4.name][var_5].clear_event_on_prob = 1;
                    continue;
                }

                if ( level.dds.active_events[var_4.name][var_5].processed )
                    continue;

                if ( dds_event_activate( level.dds.active_events[var_4.name][var_5], var_4.get_talker_func, var_4.speaker_distance, var_4.rspns_cat_name, var_4.should_squelch, var_4.rspns_cat_name_alt, var_4.alt_rspns_test_func ) )
                {
                    if ( !isstring( var_4.timeout_reset ) && var_4.timeout_reset == 0 )
                        var_4.timeout = var_4.timeout_reset;
                    else
                    {
                        var_6 = undefined;

                        if ( isstring( var_4.timeout_reset ) && var_4.timeout_reset == "use_group" )
                            var_6 = level.dds.category_groups[var_4.group];
                        else
                            var_6 = var_4;

                        if ( gettime() - var_6.last_time < var_6.last_timeout * 1.5 * 1000 )
                        {
                            var_6.backoff_count++;

                            if ( var_6.backoff_count > level.dds.category_backoff_limit )
                                var_6.backoff_count = level.dds.category_backoff_limit;
                        }
                        else
                        {
                            var_6.backoff_count--;

                            if ( var_6.backoff_count < 0 )
                                var_6.backoff_count = 0;
                        }

                        var_6.timeout = var_6.timeout_reset * exponent( 2, var_6.backoff_count ) + randomint( 2 );
                        var_6.last_timeout = var_6.timeout;
                        var_6.last_time = gettime();
                    }

                    if ( var_4.clear_on_action_success )
                    {
                        level.dds.active_events[var_4.name] = [];

                        if ( isdefined( var_4.group ) )
                        {
                            for ( var_7 = 0; var_7 < level.dds.category_groups[var_4.group].categories.size; var_7++ )
                                level.dds.active_events[level.dds.category_groups[var_4.group].categories[var_7]] = [];
                        }
                    }

                    return 1;
                }
                else
                    wait(level.dds.heartbeat);
            }
        }
    }

    return 0;
}

dds_process_active_events_axis()
{
    foreach ( var_1 in level.dds.category_groups_axis )
    {
        if ( var_1.timeout > 0 )
            var_1.timeout -= level.dds.heartbeat;
    }

    for ( var_3 = 0; var_3 < level.dds.categories_axis.size; var_3++ )
    {
        var_4 = level.dds.categories_axis[var_3];

        if ( isstring( var_4.timeout_reset ) && var_4.timeout_reset == "use_group" )
        {
            if ( level.dds.category_groups_axis[var_4.group].timeout > 0 )
                continue;
        }
        else if ( var_4.timeout > 0 )
        {
            var_4.timeout -= level.dds.heartbeat;
            continue;
        }

        if ( level.dds.active_events_axis[var_4.name].size != 0 )
        {
            level.dds.active_events_axis[var_4.name] = [[ var_4.priority_sort ]]( level.dds.active_events_axis[var_4.name] );

            for ( var_5 = 0; var_5 < level.dds.active_events_axis[var_4.name].size; var_5++ )
            {
                if ( randomfloat( 1 ) >= var_4.probability )
                {
                    level.dds.active_events_axis[var_4.name][var_5].clear_event_on_prob = 1;
                    continue;
                }

                if ( level.dds.active_events_axis[var_4.name][var_5].processed )
                    continue;

                if ( dds_event_activate( level.dds.active_events_axis[var_4.name][var_5], var_4.get_talker_func, var_4.speaker_distance, var_4.rspns_cat_name, 0, var_4.rspns_cat_name_alt, var_4.alt_rspns_test_func ) )
                {
                    if ( !isstring( var_4.timeout_reset ) && var_4.timeout_reset == 0 )
                        var_4.timeout = var_4.timeout_reset;
                    else
                    {
                        var_6 = undefined;

                        if ( isstring( var_4.timeout_reset ) && var_4.timeout_reset == "use_group" )
                            var_6 = level.dds.category_groups_axis[var_4.group];
                        else
                            var_6 = var_4;

                        if ( gettime() - var_6.last_time < var_6.last_timeout * 1.5 * 1000 )
                        {
                            var_6.backoff_count++;

                            if ( var_6.backoff_count > level.dds.category_backoff_limit )
                                var_6.backoff_count = level.dds.category_backoff_limit;
                        }
                        else
                        {
                            var_6.backoff_count--;

                            if ( var_6.backoff_count < 0 )
                                var_6.backoff_count = 0;
                        }

                        var_6.timeout = var_6.timeout_reset * exponent( 2, var_6.backoff_count ) + randomint( 2 );
                        var_6.last_timeout = var_6.timeout;
                        var_6.last_time = gettime();
                    }

                    if ( var_4.clear_on_action_success )
                    {
                        level.dds.active_events_axis[var_4.name] = [];

                        if ( isdefined( var_4.group ) )
                        {
                            for ( var_7 = 0; var_7 < level.dds.category_groups_axis[var_4.group].categories.size; var_7++ )
                                level.dds.active_events_axis[level.dds.category_groups_axis[var_4.group].categories[var_7]] = [];
                        }
                    }

                    return 1;
                }
                else
                    wait(level.dds.heartbeat);
            }
        }
    }

    return 0;
}

dds_event_activate( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_7 = var_0.category_name;

    if ( isdefined( var_0.category_response_name ) )
        var_7 = var_0.category_response_name;

    var_8 = var_0 [[ var_1 ]]( isdefined( var_0.category_response_name ), var_2 );

    if ( !isdefined( var_8 ) || !isalive( var_8 ) )
    {
        var_0.processed = 1;
        return 0;
    }

    if ( var_8.dds_disable )
        return 0;

    var_10 = dds_get_alias_from_event( var_8, var_0.category_alias_name, var_0.ent, var_0.ent_threat );

    if ( !isdefined( var_10 ) )
        return 0;

    if ( isdefined( var_0.category_response_name ) )
    {
        if ( var_0.isalliesline )
            wait(level.dds.response_wait);
        else
            wait(level.dds.response_wait_axis);
    }

    if ( isdefined( var_0.optional_responder_name ) && var_0.optional_responder_name != "" )
    {
        var_11 = dds_get_alias_from_name( var_8, var_0.optional_responder_name );

        if ( isdefined( var_11 ) )
        {
            dds_event_activate_play( var_8, var_11 );
            wait 0.6;
        }
    }

    dds_event_activate_play( var_8, var_10, var_4 );
    var_0.talker = var_8;
    var_0.talker_origin = var_8.origin;
    var_0.phrase = var_10;
    var_0.processed = 1;
    add_phrase_to_history( var_10 );

    if ( var_3 != "" )
    {
        if ( var_5 != "" && isdefined( var_6 ) && var_0 [[ var_6 ]]() )
            dds_notify_response( var_0, var_8, var_10, var_5 );
        else
            dds_notify_response( var_0, var_8, var_10, var_3 );
    }

    return 1;
}

dds_event_activate_play( var_0, var_1, var_2 )
{
    if ( !getdvarint( "snd_dsp_futz" ) )
        var_2 = 0;

    if ( isalive( var_0 ) )
    {
        if ( var_2 && !isplayer( var_0 ) && var_0.voice != "russian_english" )
            var_0 animscripts\face::playfacethread( undefined, "dds_squelch_strt", 0.5, "dds_squelch_strt" );

        var_0 set_talking_currently( var_0 );

        if ( maps\_utility::getdvarintdefault( "dds_battlechater_disable" ) == 0 )
            var_0 animscripts\face::playfacethread( undefined, var_1, 0.5, var_1 );

        var_0 clear_talking_currently_when_done( var_0, var_1 );
    }

    if ( var_2 && !isplayer( var_0 ) && isalive( var_0 ) && var_0.voice != "russian_english" )
        var_0 animscripts\face::playfacethread( undefined, "dds_squelch_end", 0.5, "dds_squelch_end" );
}

talker_is_talking_currently( var_0 )
{
    return level.dds.characterid_is_talking_currently[var_0.dds_characterid];
}

set_talking_currently( var_0 )
{
    level.dds.characterid_is_talking_currently[var_0.dds_characterid] = 1;
}

clear_talking_currently_when_done( var_0, var_1 )
{
    var_0 common_scripts\utility::waittill_any_timeout( 5.0, var_1, "death" );
    level.dds.characterid_is_talking_currently[var_0.dds_characterid] = 0;
}

add_phrase_to_history( var_0 )
{
    level.dds.history[level.dds.history_index] = var_0;
    level.dds.history_index = ( level.dds.history_index + 1 ) % level.dds.history_count;
}

get_nearest_common( var_0, var_1, var_2 )
{
    var_3 = level.player;

    if ( self.isalliesline )
    {
        var_4 = _func_0D6( "allies" );

        if ( var_1 )
            var_4[var_4.size] = var_3;
    }
    else
        var_4 = _func_0D6( "axis" );

    if ( var_4.size <= 0 )
        return undefined;

    var_4 = remove_all_actors_that_are_squelched( var_4 );

    if ( var_0 && isdefined( self.talker ) )
    {
        var_4 = remove_all_actors_with_same_characterid( var_4, self.talker.dds_characterid );
        var_5 = maps\_utility::get_closest_living( self.talker.origin, var_4 );
    }
    else
        var_5 = maps\_utility::get_closest_living( var_3.origin, var_4 );

    if ( !isdefined( var_5 ) )
        return undefined;

    var_6 = distancesquared( var_3.origin, var_5.origin );

    if ( var_6 > var_2 * var_2 )
        return undefined;

    if ( var_0 && var_6 < level.dds.response_distance_min * level.dds.response_distance_min )
        return undefined;

    return var_5;
}

remove_all_actors_that_are_squelched( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.bsc_squelched ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

remove_all_actors_with_same_characterid( var_0, var_1 )
{
    var_2 = 0;

    while ( var_2 < var_0.size )
    {
        if ( !isdefined( var_0[var_2].dds_characterid ) )
        {
            var_0 = common_scripts\utility::array_remove( var_0, var_0[var_2] );
            continue;
        }

        if ( var_0[var_2].dds_characterid == var_1 )
        {
            var_0 = common_scripts\utility::array_remove( var_0, var_0[var_2] );
            continue;
        }

        var_2++;
    }

    return var_0;
}

get_nearest( var_0, var_1 )
{
    return get_nearest_common( var_0, 1, var_1 );
}

get_nearest_not_plr( var_0, var_1 )
{
    return get_nearest_common( var_0, 0, var_1 );
}

get_attacker( var_0, var_1 )
{
    if ( isdefined( self.ent_attacker ) && isalive( self.ent_attacker ) )
    {
        if ( isdefined( self.ent_team ) )
        {
            if ( isdefined( self.ent_attacker.team ) && self.ent_team == self.ent_attacker.team )
                return undefined;

            if ( isdefined( self.ent_attacker.vteam ) && self.ent_team == self.ent_attacker.vteam )
                return undefined;
        }

        return self.ent_attacker;
    }

    return undefined;
}

get_self_ent( var_0, var_1 )
{
    if ( isdefined( self.ent ) && isalive( self.ent ) )
        return self.ent;

    return undefined;
}

alt_rspns_random_test()
{
    return 1;
}

dds_get_alias_from_name( var_0, var_1 )
{
    return dds_get_alias_from_event( var_0, "name_" + var_1 );
}

dds_get_alias_from_event( var_0, var_1, var_2, var_3 )
{
    if ( !isalive( var_0 ) )
        return undefined;

    if ( !isdefined( var_0.dds_characterid ) )
        return undefined;

    if ( talker_is_talking_currently( var_0 ) )
        return undefined;

    var_4 = "dds_" + var_0.dds_characterid + "_" + var_1;

    if ( isdefined( var_2 ) && var_1 == level.dds.trigger_string )
    {
        var_5 = var_3 get_trigger_location_qualifier( var_4 );

        if ( isdefined( var_5 ) )
            var_4 += ( "_" + var_5 );
    }

    if ( soundexists( var_4 ) )
        return var_4;

    return undefined;
}

is_phrase_in_history( var_0 )
{
    for ( var_1 = 0; var_1 < level.dds.history.size; var_1++ )
    {
        if ( level.dds.history[var_1] == var_0 )
            return 1;
    }

    return 0;
}

is_inside_valid_location_trigger()
{
    var_0 = [];
    var_0 = animscripts\battlechatter::get_all_my_locations();
    return var_0.size > 0;
}

get_trigger_location_qualifier( var_0 )
{
    var_1 = animscripts\battlechatter::get_all_my_locations();

    if ( !isdefined( var_1 ) || var_1.size == 0 )
        return undefined;

    if ( var_1[0].locationaliases.size == 0 )
        return undefined;

    foreach ( var_3 in var_1[0].locationaliases )
    {
        var_0 = var_0 + "_" + var_3;

        if ( soundexists( var_0 ) )
            return var_3;
    }

    return undefined;
}

dds_get_non_ai_threats( var_0 )
{
    var_1 = [];
    var_2 = getentarray( "actor_enemy_dog", "classname" );

    foreach ( var_4 in var_2 )
    {
        if ( get_team_or_script_team( var_4 ) == var_0 )
            var_1[var_1.size] = var_4;
    }

    var_6 = maps\_utility::getvehiclearray();

    foreach ( var_4 in var_6 )
    {
        if ( get_team_or_script_team( var_4 ) == var_0 )
        {
            if ( is_drone( var_4 ) )
                var_1[var_1.size] = var_4;
        }
    }

    var_9 = getentarray( "misc_turret", "classname" );

    foreach ( var_4 in var_9 )
    {
        if ( get_team_or_script_team( var_4 ) == var_0 )
        {
            if ( is_turret( var_4 ) )
                var_1[var_1.size] = var_4;
        }
    }

    if ( var_0 == "allies" )
        var_1[var_1.size] = level.player;

    return var_1;
}

get_team_or_script_team( var_0 )
{
    if ( isdefined( var_0.team ) )
        return var_0.team;

    if ( isdefined( var_0.script_team ) )
        return var_0.script_team;

    return "";
}

is_drone( var_0 )
{
    if ( isdefined( var_0.vehicletype ) && ( var_0.vehicletype == "pdrone" || var_0.vehicletype == "aerial_drone" || var_0.vehicletype == "attack_drone_queen" || issubstr( var_0.vehicletype, "drone" ) ) )
        return 1;

    return 0;
}

is_turret( var_0 )
{
    if ( var_0.classname == "misc_turret" && var_0 _meth_80E4() )
        return 1;

    return 0;
}

dds_find_infantry_threat( var_0, var_1 )
{
    var_2 = 0.0;
    var_3 = 3000;
    var_4 = var_1 == "allies";
    var_5 = 0;

    while ( common_scripts\utility::flag( "dds_running_" + var_0 ) )
    {
        var_6 = level.player;
        var_7 = _func_0D6( var_1 );
        var_8 = _func_0D6( var_0 );
        var_9 = dds_get_non_ai_threats( var_0 );
        var_10 = 0;
        var_11 = 0;
        var_12 = 0;
        var_13 = 0;

        for ( var_14 = 0; var_14 < var_8.size + var_9.size; var_14++ )
        {
            var_15 = undefined;
            var_16 = 0;

            if ( var_14 >= var_8.size )
                var_16 = 1;

            if ( var_16 )
                var_15 = var_9[var_14 - var_8.size];
            else
                var_15 = var_8[var_14];

            for ( var_17 = 0; var_17 < var_7.size; var_17++ )
            {
                if ( var_7.size >= 1 && randomfloat( 1 ) < 0.5 )
                {
                    var_13++;
                    var_18 = var_7[var_17];

                    if ( var_18.combattime > 0.0 )
                        var_12 = 1;

                    var_19 = 0;

                    if ( distancesquared( var_18.origin, var_15.origin ) < 16000000 && var_18 _meth_81BE( var_15 ) )
                    {
                        var_19 = 1;
                        var_11 = 1;
                    }

                    if ( var_19 && distancesquared( var_18.origin, var_6.origin ) < 16000000 )
                    {
                        var_18 dds_notify_threat_unique( var_4, var_15 );

                        if ( var_16 )
                            continue;

                        var_18 dds_notify_threat( var_4, var_15 );
                        var_10 = 1;

                        if ( gettime() > var_2 )
                        {
                            var_20 = var_18 gettagorigin( "TAG_EYE" );
                            var_21 = var_15.origin - var_20;
                            var_18 simple_and_lazy_flank_check( var_15, var_21, var_4 );
                            var_18 save_flank_info( var_15, var_21 );
                            var_2 += var_3;
                        }

                        break;
                    }
                }
            }

            if ( var_10 )
                break;
        }

        if ( !var_4 && var_7.size > 0 && var_13 / var_7.size > 0.75 )
        {
            if ( !var_11 && var_11 != var_5 && var_12 )
                var_7[0] dds_notify( "react_cantsee", var_4 );

            var_5 = var_11;
        }

        wait(0.3 + randomfloat( 0.2 ));
    }
}

save_flank_info( var_0, var_1 )
{
    self.dds_threat_guy = var_0;
    self.dds_threat_dir_stored = var_1;
    self.dds_threat_mypos = self.origin;
}

simple_and_lazy_flank_check( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( !isdefined( self.dds_threat_guy ) )
    {
        self.dds_threat_guy = undefined;
        self.dds_threat_dir_stored = undefined;
        return;
    }

    if ( var_0 != self.dds_threat_guy )
        return;

    if ( _func_220( self.origin, self.dds_threat_guy.origin ) < 90000 )
        return;

    if ( _func_220( self.origin, self.dds_threat_mypos ) > 10000 )
        return;

    var_4 = vectortoangles( self.dds_threat_dir_stored )[1];
    var_5 = vectortoangles( var_1 )[1];
    var_6 = var_5 - var_4;

    if ( var_6 < -180 )
        var_6 = var_5 + 360 - var_4;

    if ( var_6 > 180 )
        var_6 = var_5 - 360 - var_4;

    if ( var_6 < -45.0 )
        var_3 = "RIGHT";

    if ( var_6 > 45.0 )
        var_3 = "LEFT";

    if ( isdefined( var_3 ) )
    {
        dds_notify( "thrt_flank", var_2, self.dds_threat_guy );

        if ( var_3 == "RIGHT" )
            dds_notify( "thrt_flankright", var_2, self.dds_threat_guy, "" );

        if ( var_3 == "LEFT" )
            dds_notify( "thrt_flankleft", var_2, self.dds_threat_guy, "" );
    }
}

dds_getclock_position( var_0 )
{
    if ( !isdefined( level.player ) )
        return;

    var_1 = level.player getangles();
    var_2 = anglestoforward( var_1 );
    var_3 = vectornormalize( var_2 );
    var_4 = level.player getorigin();
    var_5 = var_0 - var_4;
    var_6 = vectornormalize( var_5 );
    var_7 = vectordot( var_3, var_6 );
    var_8 = acos( var_7 );
    var_9 = vectorcross( var_3, var_6 );
    var_10 = vectordot( var_9, anglestoup( var_1 ) );

    if ( var_10 < 0 )
        var_8 *= -1;

    var_11 = var_8 + 180;
    var_12 = 6;

    for ( var_13 = 15; var_13 < 375; var_13 += 30 )
    {
        if ( var_11 < var_13 )
            break;

        var_12 -= 1;

        if ( var_12 < 1 )
            var_12 = 12;
    }

    return var_12;
}

dds_notify_threat_unique( var_0, var_1 )
{
    var_2 = "";

    if ( !isdefined( level.player ) )
        return;

    if ( get_team_or_script_team( self ) == level.player.team )
    {
        var_3 = level.player;
        var_4 = var_3.origin;
        var_5 = level.player.angles;
        var_6 = var_1.origin;
    }
    else
    {
        var_3 = self;
        var_4 = var_3.origin;
        var_5 = animscripts\battlechatter::getrelativeangles( var_3 );
        var_6 = var_1.origin;
    }

    if ( isdefined( var_1.type ) && var_1.type == "dog" || var_1.classname == "actor_enemy_dog" )
        dds_notify( "react_dogs", var_0, var_1, var_2 );
    else if ( isdefined( var_1.is_using_boost ) && var_1.is_using_boost )
        dds_notify( "react_boost_jumpers", var_0, var_1, var_2 );
    else if ( is_drone( var_1 ) )
        dds_notify( "react_drones", var_0, var_1, var_2 );
    else if ( isdefined( var_1.elite ) && var_1.elite )
        dds_notify( "react_elites", var_0, var_1, var_2 );
    else if ( isdefined( var_1.animarchetype ) && var_1.animarchetype == "mech" || var_1.classname == "actor_enemy_mech" )
        dds_notify( "react_ast", var_0, var_1, var_2 );
    else if ( isdefined( var_1.is_using_zipline ) && var_1.is_using_zipline )
        dds_notify( "react_zipliners", var_0, var_1, var_2 );
    else if ( isdefined( var_1.primaryweapon ) && animscripts\utility::issniperrifle( var_1.primaryweapon ) )
        dds_notify( "react_sniper", var_0, var_1, var_2 );
    else if ( is_turret( var_1 ) )
        dds_notify( "react_mmg", var_0, var_1, var_2 );
}

dds_notify_threat( var_0, var_1 )
{
    var_2 = ( 0, 0, 0 );
    var_3 = ( 0, 0, 0 );
    var_4 = self;
    var_5 = "";

    if ( !isdefined( level.player ) )
        return;

    if ( self.team == level.player.team && !isdefined( var_1 ) )
        return;

    if ( self.team == level.player.team )
    {
        var_4 = level.player;
        var_3 = var_4.origin;
        var_6 = level.player.angles;
        var_2 = var_1.origin;

        if ( randomint( 100 ) > 50 )
            var_5 = var_4.dds_characterid;
    }
    else
    {
        var_4 = self;
        var_3 = var_4.origin;
        var_6 = animscripts\battlechatter::getrelativeangles( var_4 );
        var_2 = var_1.origin;
    }

    var_7 = distancesquared( var_2, var_3 );
    var_8 = var_2[2] - var_3[2];

    if ( var_1 is_inside_valid_location_trigger() )
        dds_notify( "trigger", var_0, var_1, var_5 );

    if ( var_7 < 200 )
        dds_notify( "thrt_dist10", var_0, var_1, var_5 );
    else if ( var_7 < 500 )
        dds_notify( "thrt_dist20", var_0, var_1, var_5 );
    else if ( var_7 < 1000 )
        dds_notify( "thrt_dist30", var_0, var_1, var_5 );

    if ( var_1 animscripts\battlechatter::isexposed( 0 ) )
        dds_notify( "thrt_exposed", var_0, var_1, var_5 );
    else
        dds_notify( "thrt_open", var_0, var_1, var_5 );

    var_9 = animscripts\battlechatter::getdirectionfacingangle( var_6, var_3, var_2 );
    var_10 = animscripts\battlechatter::getdirectionfacingclockgivenangle( var_9 );

    if ( var_8 > level.dds.heightforhighcallout )
    {
        if ( maps\_utility::string_is_single_digit_integer( var_10 ) )
            var_10 = "0" + var_10;

        dds_notify( "thrt_clockh" + var_10, var_0, var_1, var_5 );
    }

    if ( maps\_utility::string_is_single_digit_integer( var_10 ) )
        var_10 = "0" + var_10;

    dds_notify( "thrt_clock" + var_10, var_0, var_1, var_5 );

    if ( var_9 >= 45 && var_9 <= 135 )
        dds_notify( "thrt_right", var_0, var_1, var_5 );
    else if ( var_9 > 135 && var_9 <= 225 )
        dds_notify( "thrt_back", var_0, var_1, var_5 );
    else if ( var_9 >= 225 && var_9 <= 315 )
        dds_notify( "thrt_left", var_0, var_1, var_5 );
    else
        dds_notify( "thrt_front", var_0, var_1, var_5 );

    var_11 = animscripts\battlechatter::getdirectioncompass( var_3, var_2 );
    var_12 = animscripts\battlechatter::normalizecompassdirection( var_11 );
    dds_notify( "thrt_cardinal" + var_12, var_0, var_1, var_5 );
}

player_init()
{
    if ( !isplayer( self ) )
        return;

    if ( !isdefined( level.dds ) )
        return;

    self.iskillstreaktimerrunning = 0;
    self.killstreakcounter = 0;
    maps\_utility::ent_flag_init( "dds_killstreak" );
    maps\_utility::ent_flag_init( "dds_low_health" );
    thread dds_killstreak_timer();
    thread dds_watch_player_health();
    thread dds_multikill_tracker();
    self.dds_characterid = "player";

    while ( !isdefined( level.campaign ) )
        wait 0.1;

    self.countryid = level.dds.countryids[level.campaign].label;
    self.dds_disable = 0;
    level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
}

dds_multikill_tracker()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        level common_scripts\utility::flag_wait( "dds_running_" + self.team );
        self waittill( "multikill" );
        dds_notify( "multikill", self.team == "allies" );
    }
}

dds_watch_player_health()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        level common_scripts\utility::flag_wait( "dds_running_" + self.team );
        wait 0.5;

        if ( self.health < self.maxhealth * 0.4 )
        {
            dds_notify( "low_health", self.team == "allies" );
            maps\_utility::ent_flag_set( "dds_low_health" );
            thread reset_player_health();
        }

        maps\_utility::ent_flag_waitopen( "dds_low_health" );
    }
}

reset_player_health()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        if ( self.health > self.maxhealth * 0.75 )
        {
            maps\_utility::ent_flag_clear( "dds_low_health" );
            return;
        }

        wait 1;
    }
}

dds_killstreak_timer()
{
    self endon( "death" );
    self endon( "disconnect" );
    var_0 = maps\_utility::getdvarintdefault( "dds_killstreak_kills", 3 );
    var_1 = maps\_utility::getdvarintdefault( "dds_killstreak_timer", 10 );

    for (;;)
    {
        level common_scripts\utility::flag_wait( "dds_running_" + self.team );
        maps\_utility::ent_flag_wait( "dds_killstreak" );
        self.killstreakcounter++;

        if ( !self.iskillstreaktimerrunning )
        {
            self.iskillstreaktimerrunning = 1;
            thread track_kills_over_time( var_0, var_1 );
        }

        maps\_utility::ent_flag_clear( "dds_killstreak" );
    }
}

track_kills_over_time( var_0, var_1 )
{
    var_2 = gettime() + var_1 * 1000;

    while ( gettime() < var_2 )
    {
        if ( self.killstreakcounter >= var_0 )
        {
            dds_notify( "killstreak", self.team == "allies" );
            self.killstreakcounter = 0;
            var_2 = -1;
        }

        wait 0.1;
    }

    self.killstreakcounter = 0;
    self.iskillstreaktimerrunning = 0;
}

dds_ai_init()
{
    if ( !isdefined( level.dds ) )
        return;

    dds_get_ai_id();
    thread dds_watch_grenade_flee();
    thread dds_watch_damage();
}

dds_get_ai_id()
{
    self.countryid = level.dds.countryids[self.voice].label;
    var_0 = 0;
    var_1 = 0;
    var_2 = tolower( self.classname );

    if ( issubstr( var_2, "gideon" ) )
        self.dds_characterid = "gdn";
    else if ( issubstr( var_2, "carter" ) )
        self.dds_characterid = "ctr";
    else if ( issubstr( var_2, "joker" ) )
        self.dds_characterid = "jkr";
    else if ( issubstr( var_2, "cormack" ) )
        self.dds_characterid = "crk";
    else if ( issubstr( var_2, "knox" ) )
        self.dds_characterid = "knx";
    else if ( issubstr( var_2, "ilana" ) )
        self.dds_characterid = "iln";
    else if ( issubstr( var_2, "will" ) )
        self.dds_characterid = "wil";
    else if ( issubstr( var_2, "jackson" ) )
        self.dds_characterid = "jkn";
    else if ( issubstr( var_2, "ajani" ) )
        self.dds_characterid = "ajn";
    else if ( self.team != "neutral" )
    {
        if ( isdefined( level.dds.countryids[self.voice] ) )
        {
            var_1 = 1;
            var_0 = level.dds.countryids[self.voice].count % level.dds.countryids[self.voice].max_voices;
            self.dds_characterid = level.dds.countryids[self.voice].label + var_0;
            level.dds.countryids[self.voice].count++;
        }
        else
        {

        }
    }
    else
    {

    }

    if ( isdefined( self.dds_characterid ) && !var_1 )
        level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;

    if ( isdefined( self.dds_characterid ) && !animscripts\battlechatter::bcsenabled() )
        self.npcid = var_0 + 1;

    self.dds_disable = 0;
    return;
}

dds_watch_grenade_flee()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "grenade_flee", var_0 );

        if ( var_0 == "frag_grenade_sp" || var_0 == "frag_grenade_future_sp" || var_0 == "frag_grenade_80s_sp" )
            dds_notify( "react_grenade", self.team == "allies" );

        if ( var_0 == "emp_grenade_sp" )
            dds_notify( "react_emp", self.team == "allies" );
    }
}

dds_watch_damage()
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );

        if ( isdefined( var_1 ) && isdefined( var_1.team ) && self.team == var_1.team )
            dds_notify( "react_friendly_fire", self.team == "allies" );

        if ( isdefined( var_1 ) && isdefined( var_1.team ) && var_4 == "MOD_RIFLE_BULLET" && get_current_weapon( var_1 ) == "iw5_em1_sp" )
            dds_notify( "react_em1", self.team == "allies" );
    }
}

get_current_weapon( var_0 )
{
    var_1 = "";

    if ( isplayer( var_0 ) )
    {
        var_1 = var_0 _meth_8311();
        var_1 = getweaponbasename( var_1 );
    }
    else if ( isdefined( var_0.primaryweapon ) )
        var_1 = getweaponbasename( var_0.primaryweapon );

    return var_1;
}

update_player_damage( var_0 )
{
    if ( !is_dds_enabled() )
        return;

    self.dds_dmg_attacker = var_0;
}

update_actor_damage( var_0, var_1 )
{
    if ( !is_dds_enabled() )
        return;

    self.dds_dmg_attacker = var_0;

    if ( isplayer( var_0 ) )
    {
        switch ( var_1 )
        {
            case "MOD_IMPACT":
            case "MOD_GRENADE_SPLASH":
                return;
        }

        if ( self.team == var_0.team )
            self notify( "dds_friendly_fire" );
        else if ( self.team == "neutral" )
            dds_notify( "civ_fire", var_0.team == "allies" );
    }
}

evaluatecombatevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !is_dds_enabled() )
        return;

    if ( !isdefined( self.node ) )
        return;

    if ( !animscripts\battlechatter::isnodecoverorconceal() )
        return;

    if ( !animscripts\battlechatter_ai::nationalityokformoveorder() )
        return;

    var_0 = get_order_responder( "order_combatmove" );

    if ( isdefined( var_0 ) )
        dds_notify( "order_suppress", self.team == "allies", undefined, var_0.dds_characterid );
    else
        dds_notify( "order_suppress", self.team == "allies" );

    var_0 = get_order_responder( "order_kill_command" );

    if ( isdefined( var_0 ) )
        dds_notify( "order_kill_command", self.team == "allies", undefined, var_0.dds_characterid );
    else
        dds_notify( "order_kill_command", self.team == "allies" );

    var_0 = get_order_responder( "order_flush" );

    if ( isdefined( var_0 ) )
        dds_notify( "order_flush", self.team == "allies", undefined, var_0.dds_characterid );
    else
        dds_notify( "order_flush", self.team == "allies" );
}

evaluatemoveevent( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !is_dds_enabled() )
        return;

    if ( !isdefined( self.node ) )
        return;

    var_1 = distance( self.origin, self.node.origin );

    if ( !animscripts\battlechatter::isnodecoverorconceal() )
        return;

    if ( !animscripts\battlechatter_ai::nationalityokformoveorder() )
        return;

    if ( self.combattime > 0.0 )
    {
        if ( var_0 )
        {
            var_2 = get_order_responder( "order_coverme" );

            if ( isdefined( var_2 ) )
                dds_notify( "order_coverme", self.team == "allies", undefined, var_2.dds_characterid );
            else
                dds_notify( "order_coverme", self.team == "allies" );

            var_2 = get_order_responder( "order_combatmove" );

            if ( isdefined( var_2 ) )
                dds_notify( "order_combatmove", self.team == "allies", undefined, var_2.dds_characterid );
            else
                dds_notify( "order_combatmove", self.team == "allies" );
        }

        evaluatecombatevent();
    }
    else if ( animscripts\battlechatter_ai::nationalityokformoveordernoncombat() )
    {
        var_2 = get_order_responder( "order_noncombatmove" );

        if ( isdefined( var_2 ) )
            dds_notify( "order_noncombatmove", self.team == "allies", undefined, var_2.dds_characterid );
        else
            dds_notify( "order_noncombatmove", self.team == "allies" );
    }
}

get_order_responder( var_0 )
{
    var_1 = get_responder_given_category( var_0 );

    if ( self.team == level.player.team )
    {
        if ( !isdefined( var_1 ) )
            var_1 = level.player;
        else if ( randomint( 100 ) < 50 )
            var_1 = level.player;
    }

    return var_1;
}

get_responder_given_category( var_0 )
{
    var_1 = undefined;
    var_2 = undefined;

    if ( self.team == "allies" )
        var_2 = find_dds_category_by_name( level.dds.categories, var_0 );
    else
        var_2 = find_dds_category_by_name( level.dds.categories_axis, var_0 );

    if ( !isdefined( var_2 ) )
        return undefined;

    var_3 = var_2.rspns_cat_name;

    if ( self.team == "allies" )
        var_2 = find_dds_category_by_name( level.dds.categories, var_3 );
    else
        var_2 = find_dds_category_by_name( level.dds.categories_axis, var_3 );

    if ( !isdefined( var_2 ) )
        return undefined;

    var_4 = spawnstruct();
    var_4.category_name = var_3;
    var_4.ent = self;
    var_4.ent_origin = self.origin;
    var_4.ent_team = self.team;
    var_4.isalliesline = self.team == "allies";
    var_1 = var_4 [[ var_2.get_talker_func ]]( isdefined( var_2.rspns_cat_name ), var_2.speaker_distance );
}

check_kill_damage( var_0, var_1 )
{
    if ( isdefined( self.dds_dmg_attacker ) && isdefined( self.dds_dmg_attacker.dds_dmg_attacker ) )
    {
        if ( self == self.dds_dmg_attacker.dds_dmg_attacker )
            return "kill_dmg_" + var_1;
    }

    return var_0;
}

dds_notify_mod( var_0, var_1 )
{
    if ( !is_dds_enabled() )
        return;

    if ( !isdefined( self.damagemod ) )
        return;

    if ( isdefined( self.dds_dmg_attacker ) && isdefined( self.team ) )
    {
        if ( isdefined( self.dds_dmg_attacker.team ) && ( self.dds_dmg_attacker.team == self.team || self.team == "neutral" ) )
            return;
        else if ( isdefined( self.dds_dmg_attacker.vteam ) && self.dds_dmg_attacker.vteam == self.team )
            return;
    }

    var_2 = 0;

    if ( !isdefined( var_1 ) )
    {
        switch ( self.damagemod )
        {
            case "MOD_DROWN":
            case "MOD_HIT_BY_OBJECT":
            case "MOD_BURNED":
            case "MOD_TRIGGER_HURT":
            case "MOD_SUICIDE":
            case "MOD_FALLING":
            case "MOD_TELEFRAG":
            case "MOD_CRUSH":
                break;
            case "MOD_BAYONET":
            case "MOD_UNKNOWN":
            case "MOD_PROJECTILE_SPLASH":
            case "MOD_PROJECTILE":
                break;
            case "MOD_MELEE":
            case "MOD_MELEE_ALT":
                dds_notify( check_kill_damage( "kill_melee", "melee" ), var_0 );
                break;
            case "MOD_EXPLOSIVE":
            case "MOD_GRENADE_SPLASH":
            case "MOD_GRENADE":
                dds_notify( "kill_explo", var_0 );
                break;
            case "MOD_RIFLE_BULLET":
            case "MOD_PISTOL_BULLET":
                if ( animscripts\utility::issniperrifle( self.damageweapon ) )
                {
                    dds_notify( check_kill_damage( "react_sniper", "shot" ), !var_0 );
                    var_2 = 1;
                    break;
                }
                else
                {
                    dds_notify( check_kill_damage( "kill_confirm", "shot" ), var_0 );
                    var_2 = 1;
                    break;
                }
            case "MOD_HEAD_SHOT":
                var_2 = 1;
                break;
            default:
                break;
        }
    }
    else
    {
        dds_notify( var_1, var_0 );
        var_2 = 1;
    }

    if ( isplayer( self.attacker ) && var_2 )
        self.attacker maps\_utility::ent_flag_set( "dds_killstreak" );
}

dds_notify_casualty()
{
    var_0 = self.team == "allies";
    dds_notify( "casualty", var_0 );
    thread dds_reinforcement_think( self.team );
}

dds_reinforcement_think( var_0 )
{
    if ( isdefined( level.dds.reinforcement_endtime[var_0] ) )
    {
        level.dds.reinforcement_endtime[var_0] = gettime() + 5000.0;
        return;
    }

    var_1 = _func_0D6( var_0 );
    var_2 = var_1.size;
    var_3 = 0;
    level.dds.reinforcement_endtime[var_0] = gettime() + 5000.0;

    while ( gettime() < level.dds.reinforcement_endtime[var_0] )
    {
        var_1 = _func_0D6( var_0 );

        if ( var_1.size > var_2 )
            var_3 += var_1.size - var_2;

        if ( var_3 >= 1 )
        {
            var_1[0] dds_notify( "order_reinforce", var_0 == "allies" );
            break;
        }

        var_2 = var_1.size;
        waitframe();
    }

    level.dds.reinforcement_endtime[var_0] = undefined;
}

dds_notify_grenade( var_0, var_1, var_2 )
{
    if ( !is_dds_enabled() )
        return;

    if ( !var_2 )
    {
        switch ( var_0 )
        {
            case "willy_pete_80s_sp":
            case "willy_pete_sp":
                dds_notify( "smokeout", var_1 );
                break;
            case "emp_grenade_sp":
                dds_notify( "empout", var_1 );
                break;
            case "vc_grenade_sp":
            case "molotov_sp":
            case "claymore_80s_sp":
            case "claymore_sp":
            case "m8_white_smoke_sp":
            case "flash_grenade_80s_sp":
            case "flash_grenade_sp":
                break;
            case "frag_grenade_80s_sp":
            case "frag_grenade_future_sp":
            case "frag_grenade_sp":
            default:
                dds_notify( "fragout", var_1 );
                break;
        }
    }
    else
        dds_notify( "frag_throwback", var_1 );
}

dds_notify_reload( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        dds_notify( "reload", var_1 );
        return;
    }
    else if ( self _meth_82F0() > 0 )
        return;

    switch ( var_0 )
    {
        case "crossbow_explosive_alt_sp":
        case "crossbow_vzoom_alt_sp":
        case "crossbow_80s_sp":
        case "crossbow_sp":
            break;
        default:
            dds_notify( "reload", var_1 );
            break;
    }
}

dds_notify( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( level.dds ) )
        return;

    if ( !common_scripts\utility::flag( "dds_running_allies" ) && var_1 )
        return;

    if ( !common_scripts\utility::flag( "dds_running_axis" ) && !var_1 )
        return;

    if ( var_1 && !isdefined( level.dds.active_events[var_0] ) )
    {
        if ( maps\_utility::getdvarintdefault( "dds_logErrorsAndRequests" ) )
        {

        }
    }
    else
    {
        if ( !var_1 && !isdefined( level.dds.active_events_axis[var_0] ) )
        {
            if ( maps\_utility::getdvarintdefault( "dds_logErrorsAndRequests" ) )
            {

            }

            return;
        }

        if ( !var_1 )
        {
            if ( level.dds.active_events_axis[var_0].size > level.dds.max_active_events )
                return;
        }
        else if ( level.dds.active_events[var_0].size > level.dds.max_active_events )
            return;

        var_4 = spawnstruct();
        var_4.category_name = var_0;
        var_4.ent = self;
        var_4.ent_threat = var_2;
        var_4.ent_origin = self.origin;
        var_4.ent_team = self.team;
        var_4.clear_event_on_prob = 0;
        var_4.processed = 0;
        var_4.ent_attacker = self.dds_dmg_attacker;
        var_4.isalliesline = var_1;
        var_4.optional_responder_name = var_3;

        if ( !var_1 )
        {
            var_5 = find_dds_category_by_name( level.dds.categories_axis, var_0 );

            if ( !isdefined( var_5 ) )
                return;

            var_4.duration = var_5.duration;
            var_4.category_alias_name = var_5.alias_name;
            level.dds.active_events_axis[var_0][level.dds.active_events_axis[var_0].size] = var_4;
            return;
        }

        var_5 = find_dds_category_by_name( level.dds.categories, var_0 );

        if ( !isdefined( var_5 ) )
            return;

        var_4.duration = var_5.duration;
        var_4.category_alias_name = var_5.alias_name;
        level.dds.active_events[var_0][level.dds.active_events[var_0].size] = var_4;
    }
}

dds_notify_response( var_0, var_1, var_2, var_3 )
{
    var_0.category_response_name = var_3;
    var_0.processed = 0;

    if ( var_3 == "grenade_rspns" && isdefined( var_0.ent ) && isdefined( var_0.ent.grenade ) && isdefined( var_0.ent.grenade.originalowner ) && isdefined( var_0.ent.grenade.originalowner.team != var_0.ent_team ) )
        return;

    if ( !var_0.isalliesline )
    {
        var_4 = find_dds_category_by_name( level.dds.categories_axis, var_0.category_response_name );

        if ( !isdefined( var_4 ) )
            return;

        var_0.duration = var_4.duration;
        var_0.category_alias_name = var_4.alias_name;
        level.dds.active_events_axis[var_0.category_response_name][level.dds.active_events_axis[var_0.category_response_name].size] = var_0;
    }
    else
    {
        var_4 = find_dds_category_by_name( level.dds.categories, var_0.category_response_name );

        if ( !isdefined( var_4 ) )
            return;

        var_0.duration = var_4.duration;
        var_0.category_alias_name = var_4.alias_name;
        level.dds.active_events[var_0.category_response_name][level.dds.active_events[var_0.category_response_name].size] = var_0;
    }
}

find_dds_category_by_name( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2].name == var_1 )
            return var_0[var_2];
    }

    return undefined;
}

dds_sort_ent_dist( var_0 )
{
    var_1 = level.player;
    var_2 = [];
    var_3 = [];

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_5 = distancesquared( var_1.origin, var_0[var_4].ent_origin );
        var_2[var_2.size] = var_5;
        var_3[var_3.size] = var_4;
    }

    var_6 = undefined;

    for ( var_4 = 0; var_4 < var_2.size - 1; var_4++ )
    {
        if ( var_2[var_4] <= var_2[var_4 + 1] )
            continue;

        var_6 = var_2[var_4];
        var_2[var_4] = var_2[var_4 + 1];
        var_2[var_4 + 1] = var_6;
        var_6 = var_3[var_4];
        var_3[var_4] = var_3[var_4 + 1];
        var_3[var_4 + 1] = var_6;
    }

    var_7 = [];

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
        var_7[var_4] = var_0[var_3[var_4]];

    return var_7;
}

dds_sort_ent_duration( var_0 )
{
    return var_0;
}

dds_sort_ent_damage( var_0 )
{
    return var_0;
}
