// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("dog");

main()
{
    self endon( "killanimscript" );
    thread animscripts\dog\dog_move::handlefootstepnotetracks();
    self clearanim( %dog_move, 0.2 );
    self setflaggedanimknoballrestart( "dog_stop", self.dogarrivalanim, %body, 1, 0.2, self.moveplaybackrate );
    animscripts\shared::donotetracks( "dog_stop" );
    self.dogarrivalanim = undefined;
}
