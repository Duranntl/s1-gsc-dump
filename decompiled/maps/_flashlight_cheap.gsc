// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

cheap_flashlight_init()
{
    precachemodel( "com_flashlight_on_physics" );
    flashlight_fx();
}

add_cheap_flashlight( var_0, var_1, var_2 )
{
    var_3 = self;
    var_4 = "tag_flash";

    if ( isdefined( var_0 ) && var_0 == "flashlight" )
    {
        var_5 = self gettagorigin( "tag_inhand" );
        var_6 = self gettagangles( "tag_inhand" );
        self.flashlight = spawn( "script_model", var_5 );
        self.flashlight _meth_80B1( "com_flashlight_on_physics" );
        self.flashlight.angles = var_6;
        self.flashlight _meth_804D( self, "tag_inhand" );
        var_3 = self.flashlight;
        var_4 = "tag_light";
    }

    if ( isdefined( var_2 ) )
        playfxontag( common_scripts\utility::getfx( var_2 ), var_3, var_4 );
    else
        playfxontag( common_scripts\utility::getfx( "flashlight0" ), var_3, var_4 );

    thread fake_spotlight( var_4, var_1, var_4, var_2 );
    thread remove_flashlight_upon_combat();
}

remove_cheap_flashlight( var_0, var_1, var_2 )
{
    var_3 = self;
    var_4 = "tag_flash";

    if ( isdefined( var_0 ) && var_0 == "flashlight" )
        self.flashlight notify( "kill_fx_before_death" );
}

remove_flashlight_upon_combat()
{
    self endon( "death" );
    self.flashlight endon( "death" );
    self waittill( "enemy" );

    if ( self.prevscript != "scripted" )
        cheap_flashlight_hide( self );
}

fake_spotlight( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self.flashlight endon( "death" );

    if ( isdefined( self.flashlight ) )
        var_4 = self.flashlight;
    else
        var_4 = self;

    if ( !isdefined( var_1 ) )
        var_1 = 400;

    thread monitor_flashlight_death( var_0, var_4, var_2, var_3 );
    thread monitor_flashlight_owner_death( var_0, var_4, var_2, var_3 );
    maps\_utility::disable_long_death();
    var_4.light_tag = common_scripts\utility::spawn_tag_origin();
    playfxontag( common_scripts\utility::getfx( "point_amber" ), var_4.light_tag, "tag_origin" );

    for (;;)
    {
        var_5 = var_4 gettagorigin( var_0 );
        var_6 = var_4 gettagangles( var_0 );
        var_7 = anglestoforward( var_6 );
        var_8 = bullettrace( var_5 + var_7 * 7, var_5 + var_7 * var_1, 1, var_4, 0 );
        var_9 = bullettrace( var_8["position"], var_8["position"] + var_7 * -20, 1, var_4, 0 );
        var_4.light_tag.origin = var_9["position"];
        waitframe();
    }
}

kill_flashlight_fx( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_1.light_tag ) )
        killfxontag( common_scripts\utility::getfx( "point_amber" ), var_1.light_tag, "tag_origin" );

    if ( isdefined( var_1 ) && isdefined( var_2 ) )
    {
        if ( isdefined( var_3 ) )
            killfxontag( common_scripts\utility::getfx( var_3 ), var_1, var_2 );
        else
            killfxontag( common_scripts\utility::getfx( "flashlight0" ), var_1, var_2 );
    }
}

monitor_flashlight_owner_death( var_0, var_1, var_2, var_3 )
{
    self.flashlight endon( "death" );
    self waittill( "death" );
    kill_flashlight_fx( var_0, var_1, var_2, var_3 );
}

monitor_flashlight_death( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self.flashlight waittill( "kill_fx_before_death" );
    kill_flashlight_fx( var_0, var_1, var_2, var_3 );
    self.flashlight hide();
    waitframe();
    self.flashlight delete();
}

flashlight_fx()
{
    level._effect["point_amber"] = loadfx( "vfx/lights/lab/point_flashlight_lab" );
    level._effect["flashlight0"] = loadfx( "vfx/lights/lab/flashlight_lab" );
}

cheap_flashlight_hide( var_0 )
{
    if ( isdefined( var_0.flashlight ) )
    {
        var_0.lastreacttime = gettime();
        var_0 remove_cheap_flashlight( "flashlight" );
    }
}

cheap_flashlight_show( var_0 )
{
    if ( !isdefined( var_0.flashlight ) )
        var_0 add_cheap_flashlight( "flashlight" );
}
