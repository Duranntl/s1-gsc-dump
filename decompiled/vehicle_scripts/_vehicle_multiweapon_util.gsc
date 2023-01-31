// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

turret_to_missile_index( var_0 )
{
    return -2 - var_0;
}

set_forced_target( var_0, var_1 )
{
    if ( !vehicle_scripts\_vehicle_turret_ai::is_valid_target( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
    {
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target( var_0 );

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_3 in self.mgturret )
            {
                self notify( "mgturret_acquire_new_target" );
                var_3.ai_target_force = var_0;
            }
        }
    }
    else if ( var_1 == -1 )
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target( var_0 );
    else if ( var_1 <= -2 )
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target( var_0 );
    else if ( isdefined( self.mgturret ) )
    {
        self notify( "mgturret_acquire_new_target" );
        self.mgturret[var_1].ai_target_force = var_0;
    }
}

disable_firing( var_0 )
{
    set_firing_disabled( 1, var_0 );
}

enable_firing( var_0 )
{
    set_firing_disabled( 0, var_0 );
}

set_firing_disabled( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
    {
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_firing_disabled( var_0 );

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_3 in self.mgturret )
                var_3.disable_firing = var_0;
        }
    }
    else if ( var_1 == -1 )
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_firing_disabled( var_0 );
    else if ( var_1 <= -2 )
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_firing_disabled( var_0 );
    else if ( isdefined( self.mgturret ) )
        self.mgturret[var_1].disable_firing = var_0;
}

disable_tracking( var_0 )
{
    set_target_tracking_disabled( 1, var_0 );
}

enable_tracking( var_0 )
{
    set_target_tracking_disabled( 0, var_0 );
}

set_target_tracking_disabled( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
    {
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_target_tracking_disabled( var_0 );

        if ( isdefined( self.mgturret ) )
        {
            foreach ( var_3 in self.mgturret )
            {
                var_3.disable_target_tracking = var_0;

                if ( 0 && var_0 )
                    var_3.ai_target_force = undefined;
            }
        }
    }
    else if ( var_1 == -1 )
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_target_tracking_disabled( var_0 );
    else if ( var_1 <= -2 )
        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_target_tracking_disabled( var_0 );
    else if ( isdefined( self.mgturret ) )
    {
        self.mgturret[var_1].disable_target_tracking = var_0;

        if ( 0 && var_0 )
            self.mgturret[var_1].ai_target_force = undefined;
    }
}

set_threat_grenade_response( var_0, var_1 )
{
    if ( !isdefined( self.threat_grenade_response_is_on ) )
        self.threat_grenade_response_is_on = [];

    [var_3, var_4] = get_turret_iteration_helper( var_1 );

    for ( var_5 = var_3; var_5 <= var_4; var_5++ )
    {
        if ( var_5 <= -2 )
        {
            self.threat_grenade_response_is_on[var_5] = var_0;

            if ( var_0 )
            {
                self notify( "stop_missle_handle_thread_grenade" );
                thread vehicle_scripts\_vehicle_missile_launcher_ai::missile_handle_threat_grenade();
            }
            else
                self notify( "stop_missle_handle_thread_grenade" );

            continue;
        }

        thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_threat_grenade_response( var_0 );
        self.threat_grenade_response_is_on[var_5] = var_0;
    }
}

get_turret_iteration_helper( var_0 )
{
    var_1 = var_0;
    var_2 = var_0;

    if ( !isdefined( var_0 ) )
    {
        var_1 = -3;
        var_2 = 3;
    }

    return [ var_1, var_2 ];
}
