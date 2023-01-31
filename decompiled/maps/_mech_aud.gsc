// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    waittillframeend;
    register_snd_messages();
}

register_snd_messages()
{
    if ( isdefined( level._snd ) )
    {
        soundscripts\_snd::snd_register_message( "snd_mech_emp_restart", ::snd_mech_emp_restart );
        soundscripts\_snd::snd_register_message( "snd_mech_add_rocketpack_raise", ::snd_mech_add_rocketpack_raise );
        soundscripts\_snd::snd_register_message( "snd_mech_add_rocketpack_lower", ::snd_mech_add_rocketpack_lower );
    }
}

snd_mech_emp_restart()
{
    soundscripts\_audio::deprecated_aud_play_linked_sound( "mech_emp_restart", self );
}

snd_mech_add_rocketpack_raise()
{
    soundscripts\_audio::deprecated_aud_play_linked_sound( "mech_add_rocketpack_raise", self );
}

snd_mech_add_rocketpack_lower()
{
    soundscripts\_audio::deprecated_aud_play_linked_sound( "mech_add_rocketpack_lower", self );
}

mech_movement( var_0, var_1 )
{
    soundscripts\_audio::deprecated_aud_play_linked_sound( var_0, self );
}

mech_fs_walk_slow( var_0 )
{
    soundscripts\_audio::deprecated_aud_play_linked_sound( "mech_fs_walk_slow", var_0 );
}

mech_metal_rattle( var_0 )
{
    soundscripts\_audio::deprecated_aud_play_linked_sound( "mech_metal_rattle", var_0 );
}
