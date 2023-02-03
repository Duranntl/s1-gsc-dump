// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self.animtree = "";
    self.additionalassets = "";
    self.team = "allies";
    self.type = "human";
    self.subclass = "regular";
    self.accuracy = 0.2;
    self.health = 100;
    self.grenadeweapon = "fraggrenade";
    self.grenadeammo = 0;
    self.secondaryweapon = "";
    self.sidearm = "beretta";

    if ( isai( self ) )
    {
        self setengagementmindist( 256.0, 0.0 );
        self setengagementmaxdist( 768.0, 1024.0 );
    }

    self.weapon = "s1_m160_npc_only";
    character\character_sentinel_soldier_cloaked::main();
}

spawner()
{
    self setspawnerteam( "allies" );
}

precache()
{
    character\character_sentinel_soldier_cloaked::precache();
    precacheshellshock( "s1_m160_npc_only" );
    precacheshellshock( "beretta" );
    precacheshellshock( "fraggrenade" );
}
