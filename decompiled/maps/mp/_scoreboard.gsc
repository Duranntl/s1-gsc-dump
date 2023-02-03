// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

processlobbyscoreboards()
{
    foreach ( var_1 in level.placement["all"] )
        var_1 setplayerscoreboardinfo();

    if ( level.multiteambased )
    {
        buildscoreboardtype( "multiteam" );

        foreach ( var_1 in level.players )
            var_1 setcommonplayerdata( "round", "scoreboardType", "multiteam" );

        setclientmatchdata( "alliesScore", -1 );
        setclientmatchdata( "axisScore", -1 );
    }
    else if ( level.teambased )
    {
        var_5 = getteamscore( "allies" );
        var_6 = getteamscore( "axis" );

        if ( var_5 == var_6 )
            var_7 = "tied";
        else if ( var_5 > var_6 )
            var_7 = "allies";
        else
            var_7 = "axis";

        setclientmatchdata( "alliesScore", var_5 );
        setclientmatchdata( "axisScore", var_6 );

        if ( var_7 == "tied" )
        {
            buildscoreboardtype( "allies" );
            buildscoreboardtype( "axis" );

            foreach ( var_1 in level.players )
            {
                var_9 = var_1.pers["team"];

                if ( !isdefined( var_9 ) )
                    continue;

                if ( var_9 == "spectator" )
                {
                    var_1 setcommonplayerdata( "round", "scoreboardType", "allies" );
                    continue;
                }

                var_1 setcommonplayerdata( "round", "scoreboardType", var_9 );
            }
        }
        else
        {
            buildscoreboardtype( var_7 );

            foreach ( var_1 in level.players )
                var_1 setcommonplayerdata( "round", "scoreboardType", var_7 );
        }
    }
    else
    {
        buildscoreboardtype( "neutral" );

        foreach ( var_1 in level.players )
            var_1 setcommonplayerdata( "round", "scoreboardType", "neutral" );

        setclientmatchdata( "alliesScore", -1 );
        setclientmatchdata( "axisScore", -1 );
    }

    foreach ( var_1 in level.players )
    {
        var_16 = 0;

        if ( !var_1 maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame() )
            var_16 = var_1.pers["summary"]["xp"];
        else
            var_16 = var_1 gettotalmpxp() - var_1.pers["summary"]["matchStartXp"];

        var_1 setcommonplayerdata( "round", "totalXp", var_16 );
        var_1 setcommonplayerdata( "round", "scoreXp", var_1.pers["summary"]["score"] );
        var_1 setcommonplayerdata( "round", "challengeXp", var_1.pers["summary"]["challenge"] );
        var_1 setcommonplayerdata( "round", "matchXp", var_1.pers["summary"]["match"] );
        var_1 setcommonplayerdata( "round", "miscXp", var_1.pers["summary"]["misc"] );
        var_1 setcommonplayerdata( "round", "entitlementXp", var_1.pers["summary"]["entitlementXP"] );
        var_1 setcommonplayerdata( "round", "clanWarsXp", var_1.pers["summary"]["clanWarsXP"] );
    }
}

setplayerscoreboardinfo()
{
    var_0 = getclientmatchdata( "scoreboardPlayerCount" );

    if ( var_0 <= 24 )
    {
        setclientmatchdata( "players", self.clientmatchdataid, "score", self.pers["score"] );
        var_1 = self.pers["kills"];
        setclientmatchdata( "players", self.clientmatchdataid, "kills", var_1 );

        if ( level.gametype == "ctf" || level.gametype == "sr" || level.gametype == "gun" )
            var_2 = self.assists;
        else
            var_2 = self.pers["assists"];

        setclientmatchdata( "players", self.clientmatchdataid, "assists", var_2 );
        var_3 = self.pers["deaths"];
        setclientmatchdata( "players", self.clientmatchdataid, "deaths", var_3 );
        var_4 = self.pers["headshots"];
        setclientmatchdata( "players", self.clientmatchdataid, "headshots", var_4 );
        var_5 = self.pers["team"];
        setclientmatchdata( "players", self.clientmatchdataid, "team", var_5 );
        var_6 = game[self.pers["team"]];
        setclientmatchdata( "players", self.clientmatchdataid, "faction", var_6 );
        var_7 = self.pers["extrascore0"];
        setclientmatchdata( "players", self.clientmatchdataid, "extrascore0", var_7 );
        var_8 = self.pers["extrascore1"];
        setclientmatchdata( "players", self.clientmatchdataid, "extrascore1", var_8 );
        var_9 = 0;

        if ( isdefined( self.pers["division"] ) && isdefined( self.pers["division"]["index"] ) )
            var_9 = self.pers["division"]["index"];

        setclientmatchdata( "players", self.clientmatchdataid, "division", var_9 );
        var_0++;
        setclientmatchdata( "scoreboardPlayerCount", var_0 );
    }
    else
    {

    }
}

buildscoreboardtype( var_0 )
{
    if ( var_0 == "multiteam" )
    {
        var_1 = 0;

        foreach ( var_3 in level.teamnamelist )
        {
            foreach ( var_5 in level.placement[var_3] )
            {
                setclientmatchdata( "scoreboards", "multiteam", var_1, var_5.clientmatchdataid );
                var_1++;
            }
        }
    }
    else if ( var_0 == "neutral" )
    {
        var_1 = 0;

        foreach ( var_5 in level.placement["all"] )
        {
            setclientmatchdata( "scoreboards", var_0, var_1, var_5.clientmatchdataid );
            var_1++;
        }
    }
    else
    {
        var_10 = maps\mp\_utility::getotherteam( var_0 );
        var_1 = 0;

        foreach ( var_5 in level.placement[var_0] )
        {
            setclientmatchdata( "scoreboards", var_0, var_1, var_5.clientmatchdataid );
            var_1++;
        }

        foreach ( var_5 in level.placement[var_10] )
        {
            setclientmatchdata( "scoreboards", var_0, var_1, var_5.clientmatchdataid );
            var_1++;
        }
    }
}
