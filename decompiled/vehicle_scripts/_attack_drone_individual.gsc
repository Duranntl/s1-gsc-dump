// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    precachemodel( var_0 );
    maps\_utility::set_console_status();
    maps\_vehicle::build_template( "attack_drone_individual", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathquake( 0.4, 0.8, 1024 );
    maps\_vehicle::build_life( 499 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_is_helicopter();
}

init_local()
{
    self.script_cheap = 1;
    self.script_badplace = 0;
    self.dontdisconnectpaths = 1;
    self.contents = self setcontents( 0 );
    self.ignore_death_fx = 1;
    self.delete_on_death = 1;
}
