
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\_weapons; 
#include maps\mp\gametypes\_rank;
#include maps\mp\gametypes\_hud;

#include scripts\mp\_utils;
#include scripts\mp\_functions;
#include scripts\mp\_bots;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_damage;
#include scripts\mp\_bolt;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\_aimbot;

TestBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self IPrintLnBold("Hello World");
        }
    }
}

PlantBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread PlantBomb();
            Waiting();
        }
    }
}

DamageRepeaterBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread DamageRepeaterFunc();
            Waiting();
        }
    }
}

FlashBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread maps\mp\_flashgrenades::applyflash(1,1);
            Waiting();
        }
    }
}

RawWeapon(str) {
	wep = "";
	for(x = 0; x < str.size; x++)
	{
		if (str[x] == "+") { break; }
		wep += str[x];
	}
	return wep;
}

WeaponLooper() {
    self endon("disconnect");
    self endon("stopit");
    for(;;) {
        self iPrintLnBold(RawWeapon(self getCurrentWeapon()));
        wait 5;
    }
}

MedalBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");

    for(;;) {
        self waittill(bind);
        event = GetUniqueDvar("event");
        weapon = GetUniqueDvar("event_weapon");
        if(!self IsInMenu()) {
            // self thread maps\mp\_bouncingbetty::bouncingbettydetonate(self, "bouncingbetty_mp");
            // SELF NOTE: More game stats are in _challenges such as Nuclear, Unstoppables etc
            self thread maps\mp\_scoreevents::processscoreevent(event, self, self.owner, weapon);
            //self thread CreateMessage("Hello?", self);
            Waiting();
        }
    }
}

EmpBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread maps\mp\_empgrenade::applyemp(self);
            Waiting();
        }
    }
}

HitmarkerBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread Hitmarker();
            Waiting();
        }
    }
}

ReverseEleBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread ReverseEleFunc();
            Waiting();
        }
    }
}

DamageBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread DamageFunc();
            Waiting();
        }
    }
}

RapidFireBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread RapidFireFunc();
            self thread EndOnStop("stop" + endonstring);
        }
    }
}


BlackscreenBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread fadeToBlack( 0.01, 0.3, 0.01, 0.3 );
        }
    }
}

WallBreachBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread WallBreachFunc();
            self thread EndOnStopWallBreach("stop" + endonstring);
        }
    }
}

OmaBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            if(!isDefined(self.changingmykit)) {
            self thread OMA();
            }
        }
    }
}

HostBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            if(!isDefined(self.hostmigrationtimer)) {
            self thread HostMigration();
            }
        }
    }
}

Oma2Bind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            if(!isDefined(self.changingmykit)) {
            self thread OMADouble();
            }
        }
    }
}

Oma3Bind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            if(!isDefined(self.changingmykit)) {
            self thread OMATriple();
            }
        }
    }
}

ScavengerBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread ScavengerFunc();
        }
    }
}


RpgBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread RpgBulletTempFunc();
        }
    }
}


DiscoBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread DiscoTempFunc();
        }
    }
}

ThermalBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread ThermalGunFunc();
        }
    }
}

BoltBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread StartBolt();
        }
    }
}

ChangeClass5Bind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread ClassChange5Func();
        }
    }
}

ChangeClassBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread ClassChangeFunc();
        }
    }
}

BounceBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self.playervel = self getVelocity();
            self setVelocity(self.playervel + (0,0,700));
        }
    }
}

VelocityBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            velx = GetUniqueDvarInt("velx");
            velz = GetUniqueDvarInt("velz");
            vely = GetUniqueDvarInt("vely");
            
            self setVelocity((velx,velz,vely));
        }
    }
}

EmptyClipBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread EmptyClipFunc();
        }
    }
}

OneBulletOutBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread OneBulletOutFunc();
        }
    }
}

OneBulletBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread OneBulletFunc();
        }
    }
}

OneBulletOutFunc()
{
	self.oneWeap = self getCurrentweapon();
    weapclip = self getWeaponAmmoClip(self.oneWeap);
	self setweaponammoclip(self.oneWeap, weapclip - 1);
}

CanzoomBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread CanzoomFunc();
        }
    }
}

IllusionBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread IllusionFunc();
        }
    }
}

CanswapBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread CanswapFunc();
        }
    }
}

LoadPosBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            if(self getStance() == "crouch")
            {
            self thread LoadPositions();
            }
        }
    }
}

GflipBind(bind,endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);

        if(!self IsInMenu()) {
            self thread GflipFunc();
        }
    }
}

GflipFunc() {
    gflipgun = self getcurrentweapon();
    self getcurrentweapon();
    self giveweapon( "riotshield_mp", 0, 1 );
    self setstance( "crouch" );
    self switchtoweapon( "riotshield_mp" );
    wait 0.37;
    self setstance( "prone" );
    wait 0.5;
    self switchtoweapon( gflipgun );
    self takeweapon( "riotshield_mp" );
    return;
}

IllusionFunc() {
	self.EmptyWeap = self getCurrentweapon();
    WeapEmpClip = self getWeaponAmmoClip(self.EmptyWeap);
	WeapEmpStock = self getWeaponAmmoStock(self.EmptyWeap);
	self setweaponammostock(self.EmptyWeap, WeapEmpStock);
	self setweaponammoclip(self.EmptyWeap, WeapEmpClip - WeapEmpClip);
	wait 0.05;
	self setweaponammoclip(self.EmptyWeap, WeapEmpClip);
	self setspawnweapon(self.EmptyWeap);
}

CanzoomFunc() {
    self.canzoomWeap = self getCurrentWeapon();
    self.camo = self calcweaponoptions( self.class_num, 0 );	

    self takeWeapon(self.canzoomWeap);
    self giveweapon(self.canzoomWeap, 0, self.camo, 1, 0, 0, 0);
    wait 0.08;
    self setSpawnWeapon(self.canzoomWeap);
}

CanswapFunc() {
	self.canswapWeap = self getCurrentWeapon();
    self.camo = self calcweaponoptions( self.class_num, 0 );	
    self takeWeapon(self.canswapWeap);
    self giveweapon(self.canswapWeap, 0, self.camo, 1, 0, 0, 0);
}

OneBulletFunc() {
	self.oneWeap = self getCurrentweapon();
	self setweaponammoclip(self.oneWeap, 1);
}

EmptyClipFunc() {
	self.emptyweap = self getCurrentweapon();
	self setweaponammoclip(self.emptyweap, 0);
}

ClassChange5Func() {
    self thread ChangeClassLogic5();
    waittillframeend;
    self thread RefillAmmo();    
    self.nova = self getCurrentweapon();
    self.camo = self calcweaponoptions( self.class_num, 0 );	
    ammoW = self getWeaponAmmoStock( self.nova );
    ammoCW = self getWeaponAmmoClip( self.nova );
    self setweaponammostock( self.nova, ammoW );
    self setweaponammoclip( self.nova, ammoCW);
}

ClassChangeFunc() {
    self thread ChangeClassLogic();
    waittillframeend;
    self thread RefillAmmo();    
    self.nova = self getCurrentweapon();
    self.camo = self calcweaponoptions( self.class_num, 0 );	
    ammoW = self getWeaponAmmoStock( self.nova );
    ammoCW = self getWeaponAmmoClip( self.nova );
    self setweaponammostock( self.nova, ammoW );
    self setweaponammoclip( self.nova, ammoCW);
}

ChangeClassLogic() {
        if( self.cclass == 0 )
        {
            self.cclass = 1;
            self notify( "menuresponse", "changeclass", "custom1" );
        }
        else
        {
            if( self.cclass == 1 )
            {
                self.cclass = 2;
                self notify( "menuresponse", "changeclass", "custom2" );
            }
            else
            {
                if( self.cclass == 2 )
                {
                    self.cclass = 0;
                    self notify( "menuresponse", "changeclass", "custom0" );
                }
            }
        }
}

ChangeClassLogic5() {
        if( self.cclass == 0 )
        {
            self.cclass = 1;
            self notify( "menuresponse", "changeclass", "custom1" );
        }
        else
        {
            if( self.cclass == 1 )
            {
                self.cclass = 2;
                self notify( "menuresponse", "changeclass", "custom2" );
            }
            else
            {
                if( self.cclass == 2 )
                {
                    self.cclass = 3;
                    self notify( "menuresponse", "changeclass", "custom3" );
            }
            else
            {
                if( self.cclass == 3 )
                {
                    self.cclass = 4;
                    self notify( "menuresponse", "changeclass", "custom4" );
            }
            else
            {
                if( self.cclass == 4 )
                {
                    self.cclass = 0;
                    self notify( "menuresponse", "changeclass", "custom0" );
                }
            }
            }
            }
        
        }
}

LoadPositionBind() {
    self endon("disconnect");
    self endon("stopload");
    level endon("game_ended");
    for(;;)
    {
        if(!self IsInMenu()) {
        if (self actionslottwobuttonpressed() && self GetStance() == "crouch")
        {
            self LoadPositions();
            wait 0.04;
        }
        }
        wait 0.04;
    }
}

NacBind(bind, endonstring) {
    self endon("stop" + endonstring);
    self endon("disconnect");
    for(;;) {
        self waittill(bind);
        if(!self IsInMenu()) {
            self thread DoInfiniteNac();
        }
    }
}

DoInfiniteNac() {
    wep = self getCurrentWeapon();
    wep2 = self GetCurrentWeaponAltWeapon();

    if (self getcurrentweapon() == wep)
    {	
        self.ammo3 = self getweaponammoclip(wep);
        self.ammo4 = self getweaponammostock(wep);
        self takeweapon(wep, 0, self.camo, 1, 0, 0, 0);
        wait 0.05;
        self giveweapon(wep, 0, self.camo, 1, 0, 0, 0);
        self setweaponammoclip(wep, self.ammo3);
        self setweaponammostock(wep, self.ammo4);
    }
    else if(self getcurrentweapon() == wep2)
    {
        self.ammo1 = self getweaponammoclip(wep2);
        self.ammo2 = self getweaponammostock(wep2);
        self takeweapon(wep2, 0, self.camo, 1, 0, 0, 0);
        wait 0.05;
        self giveweapon(wep2, 0, self.camo, 1, 0, 0, 0);
        self setweaponammoclip(wep2, self.ammo1);
        self setweaponammostock(wep2, self.ammo2);
    }
}

ThermalGunFunc() {
    if( self.thermalgun == 0 )
    {
        self useservervisionset( 1 );
        self setvisionsetforplayer( "default", 1 );
        self setinfraredvision( 1 );
        self setvisionsetforplayer( "default", 0 );
        setdvar( "cg_infraredBlur", 0 );
        setdvar( "cg_infraredBlurTime", 0 );
        self.thermalgun = 1;
    }
    else
    {
        if( self.thermalgun == 1 )
        {
            self setinfraredvision( 0 );
            self.thermalgun = 0;
        }
    }
}

ScavengerFunc() {
    scavweapon = self getcurrentweapon();
    self thread ScavengerImage();
    self.scavenger_icon_fake.alpha = 1;
    self.scavenger_icon_fake fadeovertime( 2.17 );
    self.scavenger_icon_fake.alpha = 0;
    self getcurrentweapon();
    self thread EmptyClipFunc();
    wait 0.1;
    self givemaxammo( scavweapon );
    self setweaponammoclip( scavweapon, weaponclipsize( scavweapon ) );
    wait 2.2;
    self.scavenger_icon_fake destroy();
}

ScavengerImage() {
    self.scavenger_icon_fake = newclienthudelem( self );
    self.scavenger_icon_fake.horzalign = "center";
    self.scavenger_icon_fake.vertalign = "middle";
    self.scavenger_icon_fake.alpha = 0;
    width = 48;
    height = 24;
    self.scavenger_icon_fake.x = width * -1 / 2;
    self.scavenger_icon_fake.y = 16;
    self.scavenger_icon_fake setshader( "hud_scavenger_pickup", width, height );
}

EndOnStopWallBreach(a) {
    self waittill(a);
    self setClientDvar("r_singleCell", "0");
    self.WallBreachX = undefined;
}

EndOnStop(a) {
    self waittill(a);
	self.pers["rapidfire"] = undefined; 
	setDvar("perk_weapReloadMultiplier",0.5);
    self unsetperk("specialty_fastreload");
	self notify("stop_unlimitedammo");
}

RapidFireFunc() {
	self endon ("disconnect");
	self endon ("game_ended");
	if(!isDefined(self.pers["rapidfire"]))
	{
		self.pers["rapidfire"] = true;
		self setperk("specialty_fastreload");
		self thread UnlimitedAmmo();
        setDvar("perk_weapReloadMultiplier",0.001);
	} 
	else if(isDefined(self.pers["rapidfire"])) 
	{ 
		self.pers["rapidfire"] = undefined; 
		setDvar("perk_weapReloadMultiplier",0.5);
        self unsetperk("specialty_fastreload");
		self notify("stop_unlimitedammo");
	} 
}

UnlimitedAmmo()
{
     self endon("stop_unlimitedammo");
     self endon("death");
     for(;;)
     {
          currentWeapon = self getcurrentweapon();
          if ( currentWeapon != "none" )
          {
               self setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
               self givemaxammo( currentWeapon );
          }
          currentoffhand = self getcurrentoffhand();
          if ( currentoffhand != "none" )
      {
            self givemaxammo( currentoffhand );
      }
     wait .1;
     }
}

// OMA

OMA() {
    currentWeapon = self getcurrentweapon();
    self giveWeapon(self.OMAWeapon);
    shaxMODEL = spawn( "script_model", self.origin );
    self PlayerLinkToDelta(shaxMODEL);
    self switchToWeapon(self.OMAWeapon);
    wait 0.1;
    self thread ChangingKit();
    wait 1.92;
    self takeweapon(self.OMAWeapon);
    self unlink();
    self switchToWeapon(currentWeapon);
}

ChangingKit() {
    self endon("death");
    self.ChangingKit = createSecondaryProgressBar();
    self.KitText = createSecondaryProgressBarText();
    for(i=0;i<36;i++)
    {
        self.changingmykit = true;
        self.ChangingKit updateBar(i / 35);
        self.KitText setText("Capturing Crate");
        self.ChangingKit setPoint("CENTER", "CENTER", 0, -85);
        self.KitText setPoint("CENTER", "CENTER", 0, -100);
        self.ChangingKit.color     = (0, 0, 0);
        self.ChangingKit.bar.color = self.BarColor;
        self.ChangingKit.alpha     = 0.63;
        wait .001;
    }
    self.ChangingKit destroyElem();
    self.KitText destroyElem();
    self.changingmykit = undefined;
}

OMADouble() {
    currentWeapon = self getcurrentweapon();
    shaxMODEL = spawn( "script_model", self.origin );
    self PlayerLinkToDelta(shaxMODEL);
    self giveWeapon(self.OMAWeapon);
    self switchToWeapon(self.OMAWeapon);
    wait 0.1;
    self thread ChangingKit2();
    wait 1.92;
    self takeweapon(self.OMAWeapon);
    self unlink();
    self switchToWeapon(currentWeapon);
}

ChangingKit2() {
    self endon("death");
    self.ChangingKit  = createSecondaryProgressBar();
    self.KitText      = createSecondaryProgressBarText();
    self.ChangingKit2 = createSecondaryProgressBar();
    self.KitText2     = createSecondaryProgressBarText();
    for(i=0;i<36;i++)
    {
        self.changingmykit = true;
        self.ChangingKit updateBar(i / 35);
        self.KitText setText("Capturing Crate");
        self.ChangingKit setPoint("CENTER", "CENTER", 0, -85);
        self.KitText setPoint("CENTER", "CENTER", 0, -100);
        self.ChangingKit.color     = (0, 0, 0);
        self.ChangingKit.bar.color = self.BarColor;
        self.ChangingKit.alpha     = 0.63;
        // 2nd one
        self.ChangingKit2 updateBar(i / 35);
        self.KitText2 setText("Planting...");
        self.ChangingKit2 setPoint("CENTER", "CENTER", 0, -50);
        self.KitText2 setPoint("CENTER", "CENTER", 0, -65);
        self.ChangingKit2.color     = (0, 0, 0);
        self.ChangingKit2.bar.color = self.BarColor;
        self.ChangingKit2.alpha     = 0.63;
        wait .001;
    }
    self.ChangingKit destroyElem();
    self.KitText destroyElem();
    self.ChangingKit2 destroyElem();
    self.KitText2 destroyElem();
    self.changingmykit = undefined;
}

OMATriple() {
    currentWeapon = self getcurrentweapon();
    shaxMODEL = spawn( "script_model", self.origin );
    self PlayerLinkToDelta(shaxMODEL);
    self giveWeapon(self.OMAWeapon);
    self switchToWeapon(self.OMAWeapon);
    wait 0.1;
    self thread ChangingKit3();
    wait 1.92;
    self takeweapon(self.OMAWeapon);
    self unlink();
    self switchToWeapon(currentWeapon);
}

ChangingKit3() {
    self endon("death");
    self.ChangingKit  = createSecondaryProgressBar();
    self.KitText      = createSecondaryProgressBarText();
    self.ChangingKit2 = createSecondaryProgressBar();
    self.KitText2     = createSecondaryProgressBarText();
    self.ChangingKit3 = createSecondaryProgressBar();
    self.KitText3     = createSecondaryProgressBarText();
    for(i=0;i<36;i++)
    {
        self.changingmykit = true;

        self.ChangingKit updateBar(i / 35);
        self.KitText setText("Capturing Crate");
        self.ChangingKit setPoint("CENTER", "CENTER", 0, -85);
        self.KitText setPoint("CENTER", "CENTER", 0, -100);
        self.ChangingKit.color     = (0, 0, 0);
        self.ChangingKit.bar.color = self.BarColor;
        self.ChangingKit.alpha     = 0.63;
        // 2nd one
        self.ChangingKit2 updateBar(i / 35);
        self.KitText2 setText("Planting...");
        self.ChangingKit2 setPoint("CENTER", "CENTER", 0, -50);
        self.KitText2 setPoint("CENTER", "CENTER", 0, -65);
        self.ChangingKit2.color     = (0, 0, 0);
        self.ChangingKit2.bar.color = self.BarColor;
        self.ChangingKit2.alpha     = 0.63;
        // 3rd one
        self.ChangingKit3 updateBar(i / 35);
        self.KitText3 setText("Booby Trapping Crate");
        self.ChangingKit3 setPoint("CENTER", "CENTER", 0, -15);
        self.KitText3 setPoint("CENTER", "CENTER", 0, -30);
        self.ChangingKit3.color     = (0, 0, 0);
        self.ChangingKit3.bar.color = self.BarColor;
        self.ChangingKit3.alpha     = 0.63;
        wait .001;
    }
    self.ChangingKit destroyElem();
    self.KitText destroyElem();
    self.ChangingKit2 destroyElem();
    self.KitText2 destroyElem();
    self.ChangingKit3 destroyElem();
    self.KitText3 destroyElem();
    self.changingmykit = undefined;
}

DiscoFunc() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "EndDisco" );
    for(;;)
    {
        storeweapon = self getcurrentweapon();
        self takeweapon( storeweapon );
        self giveweapon( storeweapon, 0, randomintrange( 1, 45 ), 0, 0, 0, 0 );
        self setspawnweapon( storeweapon );
        wait 0.07;
    }
}

DiscoTempFunc() {
    if( self.disco == 0 )
    {
        self thread DiscoFunc();
        self.disco = 1;
    }
    else
    {
        if( self.disco == 1 )
        {
            self.disco = 0;
            self notify("EndDisco");
        }
    }
}

RpgBulletTempFunc() {
    if( self.rpgs == 0 )
    {
        self thread RpgBulletFunc();
        self.rpgs = 1;
    }
    else
    {
        if( self.rpgs == 1 )
        {
            self.rpgs = 0;
            self notify("stopRPG");
        }
    }
}

RpgBulletFunc() {
	self endon("disconnect");
	self endon("stopRPG");
	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("usrpg_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}

HostMigration()
{
    self.hostmigrationtimer = 1;
    self._velocity = self getvelocity();
    self._origin = self.origin;
    lock = spawn( "script_origin", self.origin );
    self playerlinkto( lock );
    self freezecontrols( 1 );
    hmblackscreen = createrectanglehm( "CENTER", "CENTER", 0, 0, 1000, 1000, ( 0, 0, 0 ), "white", 5, 1 );
    hmlogo = createrectanglehm( "CENTER", "CENTER", 0, 0, 50, 50, ( 1, 1, 1 ), "lui_loader_no_offset", 6, 1 );
    hmtext = drawtexthm( "MIGRATING HOSTS", "objective", 2, "CENTER", "CENTER", 0, 50, ( 1, 1, 1 ), 1, 6 );
    wait 5;
    hmlogo destroyelem();
    hmblackscreen destroyelem();
    hmtext destroyelem();
    wait 0.05;
    _matchstarttimer( "match_starting_in", 5 );
    self unlink();
    self freezecontrols( 0 );
    self.hostmigrationtimer = undefined;
}

DoFloat( time )
{
    wait 0.05;
    self endon( "disconnect" );
    self endon( "HitGround" );
    if( self isonground() )
    {
        self notify( "HitGround" );
    }
    groundposition = bullettrace( self.origin, self.origin - ( 0, 0, 5000 ), 0, self )[ "position"];
    float = spawn( "script_origin", self.origin );
    self playerlinkto( float );
    self freezecontrols( 1 );
    while( time > 0 )
    {
        if( self.origin[ 2] < groundposition[ 2] )
        {
            self notify( "HitGround" );
        }
        neworigin -= ( 0, 0, 0.5 );
        float moveto( neworigin, 0.05 );
        wait 0.05;
        time = time - 0.05;
    }
    self unlink();
    float delete();
}

_matchstarttimer( type, duration )
{
    wait 0.05;
    matchstarttext = self createfontstring( "objective", 1.5 );
    matchstarttext setpoint( "CENTER", "CENTER", 0, -40 );
    matchstarttext.sort = 1001;
    matchstarttext settext( "MATCH STARTING IN" );
    matchstarttext.foreground = 0;
    matchstarttext.hidewheninmenu = 1;
    matchstarttext settext( game[ "strings"][ type] );
    matchstarttext.alpha = 1;
    matchstarttimer = self createfontstring( "objective", 2.2 );
    matchstarttimer setpoint( "CENTER", "CENTER", 0, 0 );
    matchstarttimer.sort = 1001;
    matchstarttimer.color = ( 1, 1, 0 );
    matchstarttimer.foreground = 0;
    matchstarttimer.hidewheninmenu = 1;
    matchstarttimer.alpha = 1;
    matchstarttimer fontpulseinit();
    counttime = int( duration );
    matchstarttimer setvalue( counttime );
    self setvisionsetforplayer( "mpIntro", 0 );
    self setvisionsetforplayer( getdvar( "mapname" ), 3 );
    self useservervisionset( 1 );
    if( self.dohmfloat == 1 )
    {
        self thread dofloat( counttime );
    }
    while( counttime > 0 )
    {
        wait 1;
        counttime--;
        matchstarttimer thread fontpulse( self );
        matchstarttimer setvalue( counttime );
    }
    self setvisionsetforplayer( getdvar( "mapname" ), 0 );
    self useservervisionset( 0 );
    matchstarttimer destroyelem();
    matchstarttext destroyelem();
}

DamageRepeaterFunc() {
    self.canswapWeap = self getCurrentWeapon();
    self.WeapClip    = self getWeaponAmmoClip(self.canswapWeap);
    self.WeapStock   = self getWeaponAmmoStock(self.canswapWeap);
    self thread [[level.callbackPlayerDamage]] ( self, self, 20, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "pelvis", 0, 0); 
    wait 0.05;
    self takeWeapon(self.canswapWeap);
    self giveweapon(self.canswapWeap, 0, self.camo, 1, 0, 0, 0);
    self setweaponammostock(self.canswapWeap, self.WeapStock);
    self setweaponammoclip(self.canswapWeap, self.WeapClip);
    wait 0.05;
    self setSpawnWeapon(self.canswapWeap);
}

DamageFunc() {
    damage = GetUniqueDvarInt("func_damage");
    dmg = int(damage); // Just make sure, idk.
    self thread [[level.callbackPlayerDamage]] ( self, self, dmg, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "pelvis", 0, 0); // just kills you fml
}

ReverseEleFunc() {
    if(!isDefined(self.changle))
    {
        self endon("ebola");
        self.elevate = spawn( "script_origin", self.origin, 1 );
        self PlayerLinkToDelta( self.elevate, undefined );
        self.changle = true;
        for(;;)
        {
            self.DownEle = self.elevate.origin;
            wait 0.005;
            self.elevate.origin = self.DownEle + (0,0,-3);
            if(self JumpButtonPressed()) {
                self thread StopElevator();
                self unlink();
                self.changle = undefined;
                self.elevate delete();
            }
        }
        wait 0.005;
    }
    else
    {
        wait 0.01;
        self unlink();
        self.changle = undefined;
        self.elevate delete();
        self notify("ebola");
    }
}

WallbreachFunc()
{
    if(!isDefined(self.WallBreachX))
    {
        self.WallBreachX = true;
        self setClientDvar("r_singleCell", "1");
        wait .001;
    }
    else if(isDefined(self.WallBreachX))
    {
        self.WallBreachX = undefined;
        self setClientDvar("r_singleCell", "0");
    }
    wait .001;
}