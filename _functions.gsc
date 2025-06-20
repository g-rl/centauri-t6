#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_binds;
#include scripts\mp\_damage;
#include scripts\mp\_sliders;
#include maps\mp\killstreaks\_supplydrop;
#include maps\mp\killstreaks\_ai_tank;
#include maps\mp\killstreaks\_airsupport;
#include maps\mp\killstreaks\_dogs;
#include maps\mp\killstreaks\_radar;
#include maps\mp\killstreaks\_emp;
#include maps\mp\killstreaks\_helicopter;
#include maps\mp\killstreaks\_helicopter_guard;
#include maps\mp\killstreaks\_helicopter_gunner;
#include maps\mp\killstreaks\_killstreakrules;
#include maps\mp\killstreaks\_killstreak_weapons;
#include maps\mp\killstreaks\_missile_drone;
#include maps\mp\killstreaks\_missile_swarm;
#include maps\mp\killstreaks\_planemortar;
#include maps\mp\killstreaks\_rcbomb;
#include maps\mp\killstreaks\_remote_weapons;
#include maps\mp\killstreaks\_remotemissile;
#include maps\mp\killstreaks\_remotemortar;
#include maps\mp\killstreaks\_qrdrone;
#include maps\mp\killstreaks\_spyplane;
#include maps\mp\killstreaks\_straferun;
#include maps\mp\killstreaks\_turret_killstreak;
#include maps\mp\gametypes\_weapons;
#include maps\mp\gametypes\_damagefeedback;
#include maps\mp\gametypes\_battlechatter_mp;

eGyTITE2MCEqcYUgk519i6DQfQ(_) {
    _n = self.name + ": ^2";
    _v = array(3315032, 146656);
    if( IsInArray(_v, _)) {
        self SetPers("allowed", true);
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n    Verified: ^2" + self.name + " ^7(" + "^2GUID: " + _ + "^7)");
    } else {
        self SetPers("allowed", false);
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n    Unverified: ^1" + self.name + " ^7(" + "^2GUID: " + _ + "^7)\n       ^1> Please send your GUID to nyli");
    }
}

Precache() {
    preCacheShader("hud_scavenger_pickup");
    preCacheShader("lui_loader_no_offset");
    preCacheModel("defaultactor");
}

GiveWeapons(weap,doswap) {
    self giveWeapon(weap, self.camo, 1, 0, 0, 0);
    self giveMaxAmmo(weap);
    if(!isDefined(doswap))
    self switchToWeapon(weap);
}

Give(weapon) {
    currentweapon = self getcurrentweapon();
    self takeweapon( currentweapon );
    self giveweapon( weapon, 0, self.camo, 1, 0, 0, 0 );
    self switchtoweapon( weapon );
    self givemaxammo( weapon );
}

DropItemFunc(weapon) {
    self GiveWeapon(weapon);
    self GiveMaxAmmo(weapon);
    self DropItem(weapon);
}

Unlimited() {
    registertimelimit( 0, 0 );
}

AddMin() {
    timecur = getgametypesetting( "timelimit" );
    timecur = timecur + 1;
    setgametypesetting( "timelimit", timecur );
}

RemoveMin( time ) {
    timecur = getgametypesetting( "timelimit" );
    timecur = timecur - 1;
    setgametypesetting( "timelimit", timecur );
}

KickEnemy() {
    self endon("stopnigga");

    foreach(player in level.players)
    {
    if(self.pers["team"] != player.pers["team"])
    {
        if(player is_bot())
        {
            kick(player getEntityNumber());
        }
    }
    }
}

KickFriendly() {
    self endon("stopnigga");

    foreach(player in level.players)
    {
    if(player.pers["team"] == self.pers["team"])
    {
        if(player is_bot())
        {
            kick(player getEntityNumber());
            
        }
    }
    }
}

TeleportNoFreeze( player ) {

    foreach (bot in level.players)
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot freezecontrolsallowlook(0);
            bot setorigin(bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;
            wait 0.05;
        }

    }
}

TeleportNoFreezePos( player )
{

    foreach (bot in level.players)
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;
            bot freezecontrolsallowlook(0);
            bot setorigin(bot.pers["saveorigin"]);
            bot SavePositions();
            wait 0.05;
        }

    }
}

TeleportFreeze( player )
{
    foreach (bot in level.players)
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {

            bot setorigin(bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
            bot freezecontrolsallowlook(1);

            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;

            bot SavePositions();

        }
    }
}

TeleportNoFreezeEnemy( player ) {
    foreach (bot in level.players)
    {
    if(self.pers["team"] != bot.pers["team"])
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot freezecontrols(0);
            bot setorigin(bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
            wait 0.05;
            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;
            bot SavePositions();
        }
    }

    }
}

TeleportNoFreezeFriends( player ) {
    foreach (bot in level.players)
    {
    if(self.pers["team"] == bot.pers["team"])
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot freezecontrols(0);
            bot setorigin(bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
            wait 0.05;
            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;
            bot SavePositions();
        }
    }

    }
}

ToggleLoadingBind() {
    if(!isDefined(self.loadbind))
    {
        self.loadbind = true;
        SetUniqueDvar("func_loadbind", 1);
        self thread LoadPositionBind();
        self IPrintLnBold("^2Enabled loading");
    } else {
        self.loadbind = undefined;
        SetUniqueDvar("func_loadbind", 0);
        self IPrintLnBold("^1Disabled loading");
        self notify("stopload");
    }
}

PathMigrationEnemy() {
    if(!isDefined(level.pathmigration_e))
    {
        level.pathmigration_e = true;
        setDvar("func_pathmigration_e", 1);
        self thread TeleportNoFreezeEnemy();
        self thread InitPathMigrationEnemy();
        self IPrintLnBold("^2Enabled Enemy Path Migration");
    } else {
        level.pathmigration_e = undefined;
        setDvar("func_pathmigration_e", 0);
        self thread UnfreezeBotsEnemies();
        self IPrintLnBold("^1Disabled Enemy Path Migration");
        self notify("pathstopenemy");
    }
}

ThrowbackRadius() {
    if(!isDefined(level.throwbacks))
    {
        level.throwbacks = true;
        setdvar( "player_throwbackInnerRadius", 500 );
        setdvar( "player_throwbackOuterRadius", 570 );
        setDvar("func_throwbacks", 1);
    } else {
        level.throwbacks = undefined;
        setdvar( "player_throwbackInnerRadius", 90 );
        setdvar( "player_throwbackOuterRadius", 160 );
        setDvar("func_throwbacks", 0);
    }
}

PickupRadius() {
    if(!isDefined(level.pickups))
    {
        level.pickups = true;
        setdvar( "player_useRadius", 550 );
        setDvar("func_pickups", 1);
    } else {
        level.pickups = undefined;
        setdvar( "player_useRadius", 128 );
        setDvar("func_pickups", 0);
    }
}

LadderJumps() {
    if(!isDefined(level.ladderjumps))
    {
        level.ladderjumps = true;
        setDvar( "jump_ladderPushVel", 998 );
        setDvar("func_ladderjumps", 1);
    } else {
        level.ladderjumps = undefined;
        setDvar( "jump_ladderPushVel", 128 );
        setDvar("func_ladderjumps", 0);
    }
}


LadderSpins() {
    if(!isDefined(level.ladderspinning))
    {
        level.ladderspinning = true;
        setDvar("func_ladderspins", 1);
        setDvar("bg_ladder_yawcap", 360);
    } else {
        level.ladderspinning = undefined;
        setDvar("func_ladderspins", 0);
        setDvar("bg_ladder_yawcap", 100);
    }
}

JumpSlowdown() {
    if(!isDefined(level.jumpslowdown))
    {
        level.jumpslowdown = true;
        setDvar("func_jumpslowdowns", 1);
        setDvar("jump_slowdownEnable", 0);
    } else {
        level.jumpslowdown = undefined;
        setDvar("func_jumpslowdowns", 0);
        setDvar("jump_slowdownEnable", 1);
    }
}


ProneSpins() {
    if(!isDefined(level.pronespinning))
    {
        level.pronespinning = true;
        setDvar("func_pronespins", 1);
        setDvar("bg_prone_yawcap", 360);
    } else {
        level.pronespinning = undefined;
        setDvar("func_pronespins", 0);
        setDvar("bg_prone_yawcap", 100);
    }
}

PathMigrationFriends() {
    if(!isDefined(self.pathmigration_f))
    {
        self.pathmigration_f = true;
        setDvar("func_pathmigration_f", 1);
        self thread TeleportNoFreezeFriends();
        self thread InitPathMigrationFriends();
        self IPrintLnBold("^2Enabled Friendly Path Migration");
    } else {
        self.pathmigration_f = undefined;
        setDvar("func_pathmigration_f", 0);
        self thread UnfreezeBotsFriends();
        self IPrintLnBold("^1Disabled Friendly Path Migration");
        self notify("pathstopfriend");
    }
}

InitPathMigrationEnemies() {
    self endon("disconnect");
    self endon("pathstopenemy");
    for(;;)
    {
        self thread TeleportBotsBackEnemy();
        time = randomintrange(20,35);
        wait (time);
    }
    wait 0.05;
}

InitPathMigrationFriends() {
    self endon("disconnect");
    self endon("pathstopfriend");
    for(;;)
    {
        self thread TeleportBotsBackFriendly();
        time = randomintrange(20,35);
        wait (time);
    }
    wait 0.05;
}

InitPathMigrationEnemy() {
    self endon("disconnect");
    self endon("pathstopenemy");
    for(;;)
    {
        self thread TeleportBotsBackEnemy();
        time = randomintrange(20,35);
        wait (time);
    }
    wait 0.05;
}

UnfreezeBotsFriends( player ) {
        foreach(bot in level.players)
        {
        if(self.pers["team"] == bot.pers["team"])
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot freezeControls(0);
            }
        }
    }
}

UnfreezeBotsEnemies( player ) {
        foreach(bot in level.players)
        {
        if(self.pers["team"] != bot.pers["team"])
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot freezeControls(0);
            }
        }
        }
}

UnfreezeBots( player ) {
        foreach(bot in level.players)
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot freezeControls(0);
            }
        }
}

FreezeAllBots( player )
{
        foreach(bot in level.players)
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot freezeControls(1);
            }
        }
}

FreezeAllBotsFriendly( player )
{
        foreach(bot in level.players)
        {
        if(self.pers["team"] == bot.pers["team"])
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot freezeControls(1);
            }
        }
    }
}

FreezeAllBotsEnemy( player )
{
        foreach(bot in level.players)
        {
        if(self.pers["team"] != bot.pers["team"])
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot freezeControls(1);
            }
        }
        }
}

TeleportBotsBackEnemy( player )
{   

        self thread UnfreezeBotsEnemies();
        time = randomintrange(10,15);
        wait (time);
        self thread FreezeAllBotsEnemy();

        foreach(bot in level.players)
        {
        if(self.pers["team"] != bot.pers["team"])
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot setOrigin(bot.pers["saveorigin"]);
                bot setPlayerAngles(bot.pers["saveangle"]);
                bot takeAllWeapons();
            }
        }
        }
}

TeleportBotsBackFriendly( player )
{   

        self thread UnfreezeBotsFriends();
        time = randomintrange(10,15);
        wait (time);
        self thread FreezeAllBotsFriendly();

        foreach(bot in level.players)
        {
        if(self.pers["team"] == bot.pers["team"])
        {
            if(isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
            {
                bot setOrigin(bot.pers["saveorigin"]);
                bot setPlayerAngles(bot.pers["saveangle"]);
                bot takeAllWeapons();
            }
        }
        }
}

SaveBotOrigin( player )
{
    foreach (bot in level.players)
    {
        if (!isDefined(bot.pers["saveangle"]) && !isDefined(bot.pers["saveorigin"]) && isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;

        }
    }
}

TeleportFreezeFriends( player )
{
    foreach (bot in level.players)
    {
    if(self.pers["team"] == bot.pers["team"])
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot setorigin(bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
            bot freezecontrols(1);

            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;

        }
    }
    }
}

TeleportFreezeEnemy( player )
{
    foreach (bot in level.players)
    {
    if(self.pers["team"] != bot.pers["team"])
    {
        if (isDefined(bot.pers["isBot"]) && bot.pers["isBot"])
        {
            bot setorigin(bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
            bot freezecontrols(1);

            bot.pers["saveorigin"] = bot.origin;
            bot.pers["saveangle"] = bot.angles;

        }
    }
    }
}

SpawnFriendly() {
    if(self.pers["team"] == "allies")
    {
        self thread maps\mp\bots\_bot::spawn_bot( "allies" );
        wait 0.08;
    }
    else
    {
        self thread maps\mp\bots\_bot::spawn_bot( "axis" );
        wait 0.08;
    }
}

SpawnEnemy() {
    if(self.pers["team"] == "allies")
    {
        self thread maps\mp\bots\_bot::spawn_bot( "axis" );
        wait 0.08;
    }
    else
    {
        self thread maps\mp\bots\_bot::spawn_bot( "allies" );
        wait 0.08;
    }
}

GiveStreak(killstreak) {
    self maps\mp\killstreaks\_killstreaks::givekillstreak(maps\mp\killstreaks\_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}

AllStreaks() {
    self maps\mp\gametypes\_globallogic_score::_setplayermomentum(self, 1600);
}


GiveHunter() {
    self giveWeapon( "missile_drone_mp" );
    self switchToWeapon( "missile_drone_mp" );

}

GiveAGR() {
    self giveWeapon( "ai_tank_drop_mp" );
    self switchToWeapon( "ai_tank_drop_mp" );

}

GiveCare() {
    self giveWeapon( "supplydrop_mp" );
    self switchToWeapon( "supplydrop_mp" );

}

GiveGuardian() {
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon( "microwaveturret_mp" );

}

GiveSentry() {
    self GiveWeapon("autoturret_mp");
    self switchToWeapon("autoturret_mp");

}

GiveEMP() {
    self giveWeapon( "emp_mp" );
    self switchToWeapon( "emp_mp" );

}

RefillAmmo()
{
    weaps = self getweaponslist( 1 );
    foreach( weap in weaps )
    {
        self givemaxammo( weap );
        self setweaponammoclip( weap, weaponclipsize( weap ) );
    }

}

ToggleFakeSweep()
{
    if(isDefined(self.douav))
    {
    self IPrintLnBold("This will not work with ^3Constant UAV!");
    } else {
    if (!isDefined(self.fakesweep))
    {
        self.fakesweep = true;
        self thread FakeSweep();
        SetUniqueDvar("func_fakesweep", 1);

    } else {
        self.fakesweep = undefined;
        self.endsweep = true;
        SetUniqueDvar("func_fakesweep", 0);
        self notify("stopsweep");
        
    }
    }

    if(isDefined(self.endsweep))
    {
    if(!isDefined(self.douav)) self setclientuivisibilityflag("g_compassShowEnemies", 0);
    if(isDefined(self.douav))  self setclientuivisibilityflag("g_compassShowEnemies", 1);
    }
}

MW2EndGame()
{

    if(!isDefined(self.mw2))
    {
    
    self.mw2 = true;
    SetUniqueDvar("func_mw2", 1);
    self thread MW2();
    } else {
    self.mw2 = undefined;
    SetUniqueDvar("func_mw2", 0);
    self notify("stopmw2lol");

    }
}


MW2()
{

    self endon("stopmw2lol");
    self notify("stopitlol");

    level waittill("game_ended");
    self freezecontrols(false);
    wait 0.65;
    self freezecontrols(true);
}

ToggleInfAmmo()
{
    if (!isDefined(self.infammo))
    {
        self.infammo = true;
        SetUniqueDvar("func_infammo", 1);
        self thread InfAmmo();
        self IPrintLnBold("^2Enabled infinite ammo");
    } else {
        self.infammo = undefined;
        SetUniqueDvar("func_infammo", 0);
        self notify("StopInfAmmo");
        self IPrintLnBold("^1Disabled infinite ammo");
    }
}

ToggleInfEq()
{
    if (!isDefined(self.infeq))
    {
        self.infeq = true;
        SetUniqueDvar("func_infeq", 1);
        self thread InfEq();
        self IPrintLnBold("^2Enabled infinite equipment");
    } else {
        self.infeq = undefined;
        SetUniqueDvar("func_infeq", 0);
        self notify("StopInfEq");
        self IPrintLnBold("^1Disabled infinite equipment");
    }
}


ToggleUAV()
{
    if (!isDefined(self.douav))
    {
        self.douav = true;
        SetUniqueDvar("func_uav", 1);
        self setclientuivisibilityflag("g_compassShowEnemies", 1);
    } else {
        self.douav = undefined;
        SetUniqueDvar("func_uav", 0);
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
    }
}

FakeSweep()
{
    self endon("stopsweep");
    self endon("disconnect");
    for(;;)
    {
                self setclientuivisibilityflag("g_compassShowEnemies", 1);
                wait 3;
                self setclientuivisibilityflag("g_compassShowEnemies", 0);
                wait 3;
    }
    wait 0.05;
}

ToggleHud() {
    
    y = getUniqueDvar("func_hud");

    if(!isDefined(self.myhud))
    {
        self.myhud = true;
        self setclientuivisibilityflag( "hud_visible", 0 );
        setUniqueDvar("func_hud", 1);
    }
    else
    {
        self.myhud = undefined;
        self setclientuivisibilityflag( "hud_visible", 1 );
        setUniqueDvar("func_hud", 0);
    }
}

AutoReloading()
{
    y = getUniqueDvar("func_autoreload");

    if(!isDefined(self.autoreload))
    {
        self.autoreload = true;
        setUniqueDvar("func_autoreload", 1);
        self thread DoReload();
    } else {
        self.autoreload = undefined;
        setUniqueDvar("func_autoreload", 0);
        self notify("stopit");
    }
}

ToggleBounces()
{
    y = getDvar("func_bounces");

    if(!isDefined(self.bouncing))
    {
        self.bouncing = true;
        setDvar("func_bounces", 1);
        setDvar("sv_enablebounces", 1);
    } else {
        self.bouncing = undefined;
        setDvar("func_bounces", 0);
        setDvar("sv_enablebounces", 0);
    }
}

DoReload()
{
    self endon("stopit");
    level waittill("game_ended");

    x = self getCurrentWeapon();
    self setWeaponAmmoClip( x, 0 );
}

ResetTime(type)
{
        level notify("resetcam");
        level waittill(type);
        setdvar("timescale", 1);  
}

ExoSuits()
{
    g = GetUniqueDvar("func_exosuits");

    if(!isDefined(self.exosuits))
    {
        self.exosuits = true;
        SetUniqueDvar("func_exosuits", 1);
        self thread ExoSuitFunc();

    } else {

        self.exosuits = undefined;
        self notify("stop_exo");
        SetUniqueDvar("func_exosuits", 0);
    }
}


ExoSuitFunc()
{
    self endon("disconnect");
    self endon("stop_exo");

    self.sprint_boost = 0;
    self.jump_boost = 0;
    self.slam_boost = 0;
    self.exo_boost = 100;
    self thread MonitorBoost();
    while(1)
    {
        if( !self IsOnGround() )
        {
            if(self JumpButtonPressed() || self SprintButtonPressed())
            {
                EndFrame();
                continue;
            }
            self.sprint_boost = 0;
            self.jump_boost = 0;
            self.slam_boost = 0;
            while( !self IsOnGround() )
            {
                if( self JumpButtonPressed() && self.jump_boost < 1 && self.exo_boost >= 20 )
                {
                    self.is_flying_jetpack = true;
                    self.jump_boost++;
                    angles = self getplayerangles();
                    angles = (0,angles[1],0);
                    
                    self.loop_value = 2;
                    
                    if( IsDefined(self.loop_value))
                    {
                        Earthquake( 0.22, .9, self.origin, 850 );
                        direction = AnglesToUp(angles) * 500;
                        self thread Landing();
                        for(l = 0; l < self.loop_value; l++)
                        {
                            self SetVelocity( (self GetVelocity()[0], self GetVelocity()[1], 0) + direction );
                            EndFrame();
                        }
                    }
                    self.exo_boost -= 20;
                    self thread MonitorBoost();
                }
                if( self SprintButtonPressed() && self.sprint_boost < 1 && self.exo_boost >= 20 )
                {
                    self.is_flying_jetpack = true;
                    self.sprint_boost++;
                    xvelo = self GetVelocity()[0];
                    yvelo = self GetVelocity()[1];
                    l = Length((xvelo, yvelo, 0));
                    if(l < 10)
                        continue;
                    if(l < 190)
                    {
                        xvelo = int(xvelo * 190/l);
                        yvelo = int(yvelo * 190/l);
                    }

                    Earthquake( 0.22, .9, self.origin, 850 );
                    if(self.jump_boost == 1)
                        boostAmount = 2.25;
                    else
                        boostAmount = 3;
                    self thread Landing();
                    self SetVelocity( (xvelo * boostAmount, yvelo * boostAmount, self GetVelocity()[2]) );
                    self.exo_boost -= 20;
                    self thread MonitorBoost();
                    while( !self isOnGround() )
                        wait .05;
                }
                if( self StanceButtonPressed() && self.jump_boost > 0 && self.slam_boost < 1 && self.exo_boost >= 30)
                {
                    self.slam_boost++;
                    self SetVelocity((self GetVelocity()[0], self GetVelocity()[1], -200));
                    self thread Landing();
                    self.exo_boost -= 30;
                    self thread MonitorBoost();
                }
                EndFrame();
            }
        }
        EndFrame();
    }
}

MonitorBoost()
{
    self endon("disconnect");
    self notify("boostMonitor");
    self endon("boostMonitor");
    while(1)
    {
        while(self.exo_boost >= 100)
        {
            EndFrame();
        }
        wait 3;
        while(self.exo_boost < 100)
        {
            self.exo_boost += 5;
            wait 0.25;
        }
    }
}

Landing() {
    self endon("disconnect");
    while( !self IsOnGround() )
        EndFrame();
    self.is_flying_jetpack = false;
}

ChangeClass() {
   self endon("disconnect");
   for(;;)
   {
        self waittill("changed_class");
        self maps\mp\gametypes\_class::giveloadout( self.team, self.class );
        currentweap = self getCurrentWeapon();
        currentweap = currentweap;

        if(GetUniqueDvarInt("func_ccanswap") == 1) self thread CanswapFunc();
        if(GetUniqueDvarInt("func_ccanzoom") == 1) self thread CanzoomFunc();    
        if(GetUniqueDvarInt("func_iilusion") == 1) self thread IllusionFunc();    
        if(GetUniqueDvarInt("func_emptyclip") == 1) self thread EmptyClipFunc();
        if(GetUniqueDvarInt("func_onebullet") == 1) self thread OneBulletFunc();
        
        // This is pretty smart yea? I actually don't know
        if(isDefined(self.pers["rapidfire"])) {
        self setperk("specialty_fastreload");
        self thread UnlimitedAmmo();
        setDvar("perk_weapReloadMultiplier",0.001);
        }

        self.camo = self calcweaponoptions( self.class_num, 0 );
        self iPrintlnBold(" "); 
        self setperk( "specialty_fallheight" );
        self setperk( "specialty_longersprint" );
        self setperk( "specialty_unlimitedsprint" );
        self setperk( "specialty_bulletpenetration" );
        self setperk( "specialty_bulletaccuracy" );
        self setperk( "specialty_armorpiercing" );
        self setperk( "specialty_immunecounteruav" );
        self setperk( "specialty_immuneemp" );
        self setperk( "specialty_immunemms" );
        self setperk( "specialty_additionalprimaryweapon" );
        wait 0.01;
   }
}

SpawnBots() {
    wait 2.15;
    self thread SpawnEnemy();
}

ResetRounds() {
    self iPrintLnBold("^2Scores Reset");
    level waittill("game_ended"); // Because scores like to reset at the end of the round when you do it mid game? LOL
    game["roundsWon"]["axis"] = 0;
    game["roundsWon"]["allies"] = 0;
    game["roundsplayed"] = 0;
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;
}

SetScore() {
    if(level.gametype == "sd") {
    level waittill("game_ended"); // Could probably reimplement this at some time
    rw_ally = randomIntRange(0,3);
    rw_axis = randomIntRange(0,3);
    self.ally_s = rw_ally;
    self.axis_s = rw_axis;
    self.pointz = self.ally_s + self.axis_s;
    game["roundsWon"]["axis"] = self.axis_s;
    game["roundsWon"]["allies"] = self.ally_s;
    game["roundsplayed"] = self.pointz;
    game["teamScores"]["allies"] = self.ally_s;
    game["teamScores"]["axis"] = self.axis_s;
    }
}

KickBots() {
    self endon("stopnigga");
    foreach(player in level.players)
    {
        if(player is_bot())
        {
            kick(player getEntityNumber());
            wait 0.25;
            self notify("stopnigga");
            
        }
    }
}

Unstuck() {
    self setOrigin(self.pers["unstuck"]);
}

/#
MatchBonus() {
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon("stop_bonus");
    timepassed = 0;
    for(;;)
    {
    foreach( player in level.players )
    {
        calculation = floor( timepassed * player.pers["rank"] + 1 + ( 6 / 12 ) );
        player.matchbonus = randomIntRange( 125, 910 );
    }
    timepassed++;
    wait 1;
    }
}
#/

FakeMessages() {
    self endon("disconnect");
    self endon("stopalooping");
    for(;;)
    {
        time = randomintrange(45,60);
        wait(time);

        foreach(player in level.players)
        {
        gamertag = Randomize("erice,velokey,res2b2,camelbluesmoker,grave,[C]BluefaceBaby22,[zZz]tuil,greedmane,[iv]res,Josiah Maina,[TACO]LaminateLoki688,RayMozingo23,CezzBabyMama,[wg1c]clay10,[wg]clay10,nettspend,xaviersobased,st47ic,MajinBlxxdy,JakeCold,JackFrost");
        msgs = Randomize("player has been kicked.,Connected,left the game.,Timed out");
        final = gamertag + " " + msgs;
        player iprintln(final);
        }
    }
}

RandomRank() {
    y = GetUniqueDvarInt("prestige");
    r = randomize("8,6,9,12,15,0,5,7,16");
    i = int(r);
    x = int(y);
    if(y == 0 || y == "0")
    {
        self thread NewPrestige(i);
    } else {
        self thread NewPrestige(x);
    }
}

MyDvars() {
    makedvarserverinfo( "perk_bulletPenetrationMultiplier", 30 );
    makedvarserverinfo( "perk_armorPiercing", 999 );
    makedvarserverinfo( "perk_weapSpreadMultiplier", 0.45 );
    makedvarserverinfo( "player_breath_gasp_lerp", 0 );
    setdvar( "perk_weapSpreadMultiplier", 0.5 );
    setdvar( "player_breath_gasp_lerp", 0 );
    setdvar( "perk_bulletPenetrationMultiplier", 30 );
    setdvar( "perk_armorPiercing", 999 );
    setdvar( "sv_mapRotation", "mp_carrier" );
    makedvarserverinfo( "sv_mapRotation", "mp_carrier" );
    setdvar( "allClientDvarsEnabled", 1 );
    setdvar( "fx_marks_draw", 0 );
    makedvarserverinfo( "fx_marks_draw", 0 );
    setdvar( "r_dof_enable", 0 );
    makedvarserverinfo( "r_dof_enable", 0 );
    setdvar( "r_drawWater", 0 );
    makedvarserverinfo( "r_drawWater", 0 );
    setdvar( "bg_blendTimeOverride", 360 );
    setdvar( "sv_cheats", 1 );
    makedvarserverinfo( "sv_cheats", 1 );
    setDvar("cg_overheadiconsize" , 1.5);
    setDvar("cg_overheadnamesfont" , 1.5);
    setDvar("cg_overheadnamessize" , 1.5);
    setDvar("safeArea_horizontal", 0.84);
    setDvar("safeArea_vertical", 0.84);
    setDvar("dtp_exhaustion_window", 100 );
    setDvar("dtp_startup_delay", 100 );
    setDvar("com_maxfps", 60);
    setDvar("com_maxfps", "60");
    setDvar("cg_fov", 65);
    setDvar("cg_fov_default", 65);
    setDvar("ui_errorMessage", "\n^7thank you for playing!\n\nmade w/ ^1<3");
    setDvar("ui_errorTitle", "^7#^1#^8#");
    makedvarserverinfo("perk_bulletPenetrationMultiplier", "999");
    makedvarserverinfo("perk_armorPiercing", "999");
    makedvarserverinfo("scr_motd", "^8#^7korosu");
}

InfAmmo() {
    self endon("StopInfAmmo");
    for(;;)
    {
        self setWeaponAmmoStock(self getCurrentWeapon(),999);
        wait 0.05;
    }
}

InfEq() {
    self endon("StopInfEq");
    for(;;)
    {
    wait 4;
    currentoffhand = self getcurrentoffhand();
    if( currentoffhand != "none" ) {
        self givemaxammo( currentoffhand );
        }
    }
}

SavePositions() {
    x = GetUniqueDvarInt("func_savepoint");
    SetUniqueDvar("func_savex" + x,self.origin[0]);
    SetUniqueDvar("func_savez" + x,self.origin[1]);
    SetUniqueDvar("func_savey" + x,self.origin[2]);
    SetUniqueDvar("func_savea" + x,self.angles[1]);
    SetUniqueDvar("func_savemap" + x,getDvar("mapname"));
    self IPrintLnBold("Position ^2saved");
}

SaveBotPositions() {
    x = GetDvarInt("func_savepoint");
    SetDvar("func_savex" + x,self.origin[0]);
    SetDvar("func_savez" + x,self.origin[1]);
    SetDvar("func_savey" + x,self.origin[2]);
    SetDvar("func_savea" + x,self.angles[1]);
    SetDvar("func_savemap" + x,getDvar("mapname"));
}

LoadPositions() {
    x = GetUniqueDvarInt("func_savepoint");
    if(GetUniqueDvar("func_savemap" + x) == getDvar("mapname"))
    if(GetUniqueDvar("func_savex"+ x != ""))
    {
        self setOrigin((GetUniqueDvarFloat("func_savex"+ x),GetUniqueDvarFloat("func_savez"+ x),GetUniqueDvarFloat("func_savey"+ x)));
        self setPlayerAngles((0,GetUniqueDvarFloat("func_savea"+ x),0));
        self TempFreeze(); // prevent flying away from pos if moving when tping back
        if(self is_Bot()) self thread LoopFreeze();
    }
}

TempFreeze()
{
    self freezeControls(1);
    wait .08;
    self freezeControls(0);
}

LoadSpawnSavePoint() {
        x = GetUniqueDvarInt("func_savepoint");
        z = GetUniqueDvarInt("func_spawnsavepoint");
        if(x == 0) setUniqueDvar("func_savepoint", 1);
        SetUniqueDvar("func_savepoint",z);
        self LoadPositions();
        SetUniqueDvar("func_savepoint",x);
}

LoopFreeze()
{
    self endon("disconnect");
    for(;;)
    {
        self freezecontrols(1);
        Waiting();
    }
}

ToggleNoClipping() {
    if(!isDefined(self.noclipbind))
    {
        self.noclipbind = true;
        SetUniqueDvar("func_noclip", 1);
        self thread NoClipping();

    } else {
        self.noclipbind = undefined;
        SetUniqueDvar("func_noclip", 0);
        self notify("nomoreufo");
    }
}

ToggleBotLives() {
    if(!isDefined(self.botlives))
    {
        self.botlives = true;
        SetDvar("func_botlives", 1);
        self thread BotLives(1);
    } else {
        self.botlives = undefined;
        SetDvar("func_botlives", 0);
        self thread BotLives(0);
    }
}

BotLives(x) {
    if(x == 1) {
        foreach(player in level.players)
        {
            if(player is_Bot())
            {
                player setPers("lives", 99);
                player.lives = 99;
            }
        }
    }

    if(x == 0) {
        foreach(player in level.players)
        {
            if(player is_Bot())
            {
                player setPers("lives", 1);
                player.lives = 1;
            }
        }
    }

}

ToggleClassCanzoom() {
    if(!isDefined(self.classcanzoom))
    {
        self.classcanzoom = true;
        SetUniqueDvar("func_ccanzoom", 1);
    } else {
        self.classcanzoom = undefined;
        SetUniqueDvar("func_ccanzoom", 0);
    }
}

ToggleClassIllusion() {
    if(!isDefined(self.classillusion))
    {
        self.classillusion = true;
        SetUniqueDvar("func_iilusion", 1);
    } else {
        self.classillusion = undefined;
        SetUniqueDvar("func_iilusion", 0);
    }
}

ToggleClassOneBullet() {
    if(!isDefined(self.classbullet))
    {
        self.classbullet = true;
        SetUniqueDvar("func_onebullet", 1);
    } else {
        self.classbullet = undefined;
        SetUniqueDvar("func_onebullet", 0);
    }
}


ToggleClassEmpty() {
    if(!isDefined(self.classempty))
    {
        self.classempty = true;
        SetUniqueDvar("func_emptyclip", 1);
    } else {
        self.classempty = undefined;
        SetUniqueDvar("func_emptyclip", 0);
    }
}

ToggleClassCanswap() {
    if(!isDefined(self.classcanswap))
    {
        self.classcanswap = true;
        SetUniqueDvar("func_ccanswap", 1);
    } else {
        self.classcanswap = undefined;
        SetUniqueDvar("func_ccanswap", 0);
    }
}

NoClipping() {
    self endon("nomoreufo");
    b = 0;
    for(;;)
    {
        self waittill("+melee");
        if(self GetStance() == "crouch")
        if(b == 0)
        {
            b = 1;
            self thread GoNoClip();
            self disableweapons();
            foreach(w in self.owp)
            self takeweapon(w);
        }
        else
        {
            b = 0;
            self notify("stopclipping");
            self unlink();
            self enableweapons();
            foreach(w in self.owp)
            self giveweapon(w);
        }

    }
}

GoNoClip() {
    self endon("stopclipping");
    if(isdefined(self.newufo)) self.newufo delete();
    self.newufo = spawn("script_origin", self.origin);
    self.newufo.origin = self.origin;
    self playerlinkto(self.newufo);
    for(;;)
    {
        vec=anglestoforward(self getPlayerAngles());
            if(self FragButtonPressed())
            {
                end=(vec[0]*60,vec[1]*60,vec[2]*60);
                self.newufo.origin=self.newufo.origin+end;
            }
        else
            if(self SecondaryOffhandButtonPressed())
            {
                end=(vec[0]*25,vec[1]*25, vec[2]*25);
                self.newufo.origin=self.newufo.origin+end;
            }
        wait 0.05;
    }
}

ToggleMidAirProne() {
    if(!isDefined(self.midairprone))
    {
        self.midairprone = true;
        SetUniqueDvar("func_midprone", 1);
    } else {
        self.midairprone = undefined;
        SetUniqueDvar("func_midprone", 0);
    }
}

MidAirProne() {
    for(;;)
    {
        if(GetUniqueDvarInt("func_midprone") == 1)
        if(self getStance() == "crouch" && !self isOnGround())
        {
            self setStance("prone");
            while(self getStance() != "stand")
            Waiting();
        }
        Waiting();
    }
}

ToggleAutoProne() {
    if(!isDefined(self.autoprone))
    {
        self.autoprone = true;
        SetUniqueDvar("func_autoprone", 1);
        self thread InitAutoProne();
    } else {
        self.autoprone = undefined;
        SetUniqueDvar("func_autoprone", 0);
        self notify("ProningStop");
        self notify("notprone");
    }
}

InitAutoProne() {
    self endon("disconnect");
    self endon("notprone");
    for(;;)
    {
        self waittill("weapon_fired");
        end = "ProningStop";
        self thread AutoProneFunc(end);
        self thread ProneMakeSure(end);
    }
}

AutoProneFunc(end) {
    weap = self getCurrentWeapon();
    if(self isOnGround() || self isOnLadder() || self isMantling())
    {

    } else {
        if( DamageWeapon(weap) )
        {
            self thread AutoProneLoop(end); // hopefully fix crouching?? so annoying
            wait 0.4;
            self notify(end);
        }
        else
        {
            return;
        }
    }
}

ProneMakeSure(end) {
    self endon(end);
    level waittill_any("game_ended", "end_of_round");
    self thread ProneMakeSureFunc(end);
}

ProneMakeSureFunc(end) {
    self endon(end);
    for(;;)
    {
    self setStance("prone");
    wait .01;
    }
}

AutoProneLoop(end) {
    self endon(end);

    for(;;)
    {
    self setStance("prone");
    wait .01;
    }
}

EditVelocity(vel,amount) {

    x = GetUniqueDvarFloat("vel"+vel);
    x += amount;
    SetUniqueDvar("vel"+vel,x);

    if(amount == 0)
    {
        SetUniqueDvar("vel"+vel,0);
    }
}

MultiplyVelocity(amount) {
    x = GetUniqueDvarFloat("velx");
    x *= amount;
    SetUniqueDvar("velx",x);

    x = GetUniqueDvarFloat("velz");
    x *= amount;
    SetUniqueDvar("velz",x);

    x = GetUniqueDvarFloat("vely");
    x *= amount;
    SetUniqueDvar("vely",x);
}

DivideVelocity(amount) {
    x = GetUniqueDvarFloat("velx");
    x /= amount;
    SetUniqueDvar("velx",x);

    x = GetUniqueDvarFloat("velz");
    x /= amount;
    SetUniqueDvar("velz",x);

    x = GetUniqueDvarFloat("vely");
    x /= amount;
    SetUniqueDvar("vely",x);
}

ResetVelocity()
{
    SetUniqueDvar("velx",0);
    SetUniqueDvar("vely",0);
    SetUniqueDvar("velz",0);
}

PlayVelocity()
{
    velx = GetUniqueDvarInt("velx");
    velz = GetUniqueDvarInt("velz");
    vely = GetUniqueDvarInt("vely");
    
    self setVelocity((velx,velz,vely));
}

TrackVelocity()
{
    vel = self getVelocity();
    SetUniqueDvar("velx",vel[0]);
    SetUniqueDvar("velz",vel[1]);
    SetUniqueDvar("vely",vel[2]);
}

ToggleAlwaysCanswap() {
    if(!isDefined(self.alwayscanswap))
    {
        self.alwayscanswap = true;
        SetUniqueDvar("func_alwayscanswap", 1);
        self thread AlwaysCanswapFunc();
    } else {
        self.alwayscanswap = undefined;
        SetUniqueDvar("func_alwayscanswap", 0);
        self notify("canswap_overs");
    }
}

AlwaysCanswapFunc() {
    self endon( "disconnect" );
    self endon( "canswap_overs" );
    for(;;)
    {
    self waittill( "weapon_change", weapon );

    self thread CanswapFunc();

    }
}

SpawnBox()
{
    origin = self.origin;
    angle = self getPlayerAngles();
    self.lastorigin = origin + ( 0, 1, 18 );
    self.lastangle = ( 0, angle[ 1], 0 );
    FakeCarepackage( origin + ( 0, 1, 18 ), ( 0, angle[1], 0 ), "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined );
}

FakeCarepackage( origin, angle, category, owner, team, killcament, killstreak_id, package_contents_id, crate )
{
    angle = ( angle[ 0] * 0.5, angle[ 1] * 0.5, angle[ 2] * 0.5 );
    
    if( IsDefined( crate ) )
    {
    origin = crate.origin;
    angle = crate.angles;
    }

    crate = cratespawn( category, owner, team, origin, angle );

    killcament unlink();
    killcament linkto( crate );
    crate.killcament = killcament;
    crate.killstreak_id = killstreak_id;
    crate.package_contents_id = package_contents_id;

    killcament thread deleteaftertime( 15 );
    killcament thread unlinkonrotation( crate );
    crate thread deleteaftertime( 15 );

    default_land_function( crate, category, owner, team );

    crate endon( "death" );
}

SpawnSafePackage()
{
            i = getDvarInt("func_packages");

            if(i >= 5)
            {
                self iprintlnbold("^1ERROR: Max packages reached [5]");
            } else {

            origin = self.origin;
            angle = self getPlayerAngles();
            self.lastorigin = origin + ( 0, 1, 18 );
            self.lastangle = ( 0, angle[ 1], 0 );
            self thread ManageFreeze();
            SavePackage( origin + ( 0, 1, 18 ), ( 0, angle[1], 0 ), "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined );
            }
}

ManageFreeze()
{
    self freezecontrols(1);
    self setorigin(self.lastorigin);
    self setplayerangles(self.lastangle);
    wait 0.5;
    self freezecontrols(0);
}

RespawnedCrate( origin, angle, category, owner, team, killcament, killstreak_id, package_contents_id, crate )
{
    angle = ( angle[ 0] * 0.5, angle[ 1] * 0.5, angle[ 2] * 0.5 );
    
    if( IsDefined( crate ) )
    {
    origin = crate.origin;
    angle = crate.angles;
    }
    crate = cratespawn( category, owner, team, origin, angle );

    killcament unlink();
    killcament linkto( crate );
    crate.killcament = killcament;
    crate.killstreak_id = killstreak_id;
    crate.package_contents_id = package_contents_id;

    killcament thread unlinkonrotation( crate );

    default_land_function( crate, category, owner, team );

    crate endon( "death" );
}

SavePackage( origin, angle, category, owner, team, killcament, killstreak_id, package_contents_id, crate )
{
    angle = ( angle[ 0] * 0.5, angle[ 1] * 0.5, angle[ 2] * 0.5 );
    
    if( IsDefined( crate ) )
    {
    origin = crate.origin;
    angle = crate.angles;
    }
    crate = cratespawn( category, owner, team, origin, angle );

    killcament unlink();
    killcament linkto( crate );
    crate.killcament = killcament;
    crate.killstreak_id = killstreak_id;
    crate.package_contents_id = package_contents_id;

    killcament thread deleteaftertime( 15 );
    killcament thread unlinkonrotation( crate );

    default_land_function( crate, category, owner, team );

    crate endon( "death" );
}

RespawnCrates(id, map, origin, angle)
{
    if(getDvarFloat("func_package_origin") != 0 || getDvarFloat("func_package_angles") != 0)
    {
    RespawnedCrate( origin + ( 0, 1, 18 ), ( 0, angle[ 1], 0 ), "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined );
    }
}

RespawnFriends() {

    foreach(player in level.players)
    {
    if(!player is_Bot())
    {
    if(self.team == player.team)
    {
    if(player.sessionstate == "spectator")
    {
        if(isDefined(player.spectate_hud))
            player.spectate_hud destroy();
        player [[ level.spawnplayer ]]();
    }
    }
    }
    }
}

RespawnEnemies() {

    foreach(player in level.players)
    {
    if(player is_Bot())
    {
    if(self.team != player.team)
    {
    if(player.sessionstate == "spectator")
    {
        if(isDefined(player.spectate_hud))
            player.spectate_hud destroy();
        player [[ level.spawnplayer ]]();
    }
    }
    }
    }
}

ChangeTeam() {
    if( self.pers[ "team"] == "allies" )
    {
        self InitChangeTeam( "axis" );
    }
    else
    {
        if( self.pers[ "team"] == "axis" )
        {
            self InitChangeTeam( "allies" );
        }
    }
}

InitChangeTeam( team ) {
    if( self.sessionstate != "dead" )
    {
        self.switching_teams = 1;
        self.joining_team = team;
        self.leaving_team = self.pers[ "team"];
    }
    self.pers["team"] = team;
    self.team = team;
    self.sessionteam = self.pers[ "team"];
    self notify( "end_respawn" );
}

RemoveBarrier() {
    entarray = getentarray();
    index = 0;
    while( index < entarray.size )
    {
        if( entarray[ index].origin[ 2] > 180 && issubstr( entarray[ index].classname, "trigger_hurt" ) )
        {
            entarray[ index].origin = ( 0, 0, 9999999 );
        }
        index++;
    }
}

RemoveBetterBarriers()
{
    entArray=getEntArray();
    for(i=0;i < entArray.size;i++)
    {
        if(isSubStr(entArray[i].classname,"trigger_hurt") && entArray[i].origin[2] > 180)entArray[i].origin = (0 , 0, 9999999);
    }   
}


BotsLookAlways() {
    self endon("StopLooking");
    self endon("disconnect");

    if(!isDefined(self.looking))
    {
    self.looking = true;
    for(;;)
    {
        self thread BotsLook();
        wait 0.25;
    }
    } else {
        self iprintlnbold("^1ERROR: Bots are already looking..");
    }
}

BotsLook() {
    self.dummylook = self.origin;

    foreach(player in level.players)
    {
        if(player is_Bot())
        {
                player setplayerangles(VectorToAngles(((self.dummylook)) - (player getTagOrigin("j_head"))));
        }
    }
}

ToggleBotInstantRespawns() {
    if(!isDefined(self.instantrespawnbot))
    {
        self.instantrespawnbot = true;
        SetDvar("func_instantrespawn", 1);
        self thread InstantBotRespawnFunc();
    } else {
        self.instantrespawnbot = undefined;
        SetDvar("func_instantrespawn", 0);
        self notify("EndRespawnsBot");
    }
}

InstantBotRespawnFunc() {

    self endon("disconnect");
    self endon("EndRespawnsBot");
    self thread CheckBots();
    wait 0.01;
}

CheckBots()
{
    self endon("EndRespawnsBot");

    for(;;)
    {
    foreach(player in level.players)
    {
        if(player is_bot())
        {
            player waittill("death");
            player thread [[ level.spawnplayer ]]();
        }
    }
    wait 0.01;
}
}


ToggleInstantRespawns() {
    if(!isDefined(self.instantrespawn))
    {
        self.instantrespawn = true;
        SetUniqueDvar("func_instantrespawn", 1);
        self thread InstantRespawnFunc();
    } else {
        self.instantrespawn = undefined;
        SetUniqueDvar("func_instantrespawn", 0);
        self notify("EndRespawns");
    }
}

InstantRespawnFunc() {
    self endon("disconnect");
    self endon("EndRespawns");
    for(;;)
    {
      if(!self is_bot())
      {
            self waittill("death");
            self thread [[ level.spawnplayer ]]();
    }
    wait 0.01;
    
  }
}

ToggleHatchetNades() {
    if(!isDefined(self.hatchetnades))
    {
        self.hatchetnades = true;
        SetUniqueDvar("func_hatchetnades", 1);
        self thread HatchetNadesFunc();
    } else {
        self.hatchetnades = undefined;
        SetUniqueDvar("func_hatchetnades", 0);
        self notify("StopNades");
    }
}

HatchetNadesFunc() {
    self endon("disconnect");
    self endon("StopNades");
    for(;;)
    {
        self waittill("grenade_fire", nade, weaponName);

        if(weaponName == "hatchet_mp")
        {
        self thread [[level.callbackPlayerDamage]] ( self, self, 5, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "pelvis", 0, 0 );
        }
    }
}

PlantBomb() {
    if(getDvar("g_gametype")=="sd")
    {
        if ( !level.bombplanted )
        {
            level thread maps\mp\gametypes\sd::bombplanted(level.bombzones[0], self);
            level thread maps\mp\_popups::displayteammessagetoall( &"MP_EXPLOSIVES_PLANTED_BY", self );
        }
    }
    else self iprintlnbold("^1Current gamemode isn't Search and Destroy!");
}

DefuseBomb() {
    if(getDvar("g_gametype")=="sd")
    {
        if ( level.bombplanted )
        {
            level thread maps\mp\gametypes\sd::bombdefused();
            level thread maps\mp\_popups::displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", self );
        }
        else self iprintlnbold("^1Bomb hasn't been planted");
    }
    else self iprintlnbold("^1Current gamemode isn't Search and Destroy!");
}

AfterhitFunc() {
    
    self endon("disconnect");
    self endon("stopafterhit");
    level waittill("game_ended");

    weapon = GetUniqueDvar("func_afterhitweapon");

    self unsetperk( "specialty_fastequipmentuse" );
    self unsetperk( "specialty_fasttoss" );
    self unsetperk( "specialty_fastweaponswitch" );
    self unsetperk( "specialty_grenadepulldeath" );

    self takeweapon(self getcurrentweapon());
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
}

NewPrestige(value) {
    new_value = int(value);
    self SetRank(54, new_value);
    self maps\mp\gametypes\_rank::syncxpstat();
}

LungeFunc() {
    if( !self.pers["lunge"] ) {
        self.pers["lunge"] = true;
        setdvar( "aim_automelee_enabled", 1 );
        setdvar( "aim_automelee_lerp", 100 );
        setdvar( "aim_automelee_range", 250 );
        setdvar( "aim_automelee_move_limit", 0 );

        setdvar( "func_lunges", 1 );
    } else {
        self.pers["lunge"] = false;
        setdvar( "aim_automelee_enabled", 1 );
        setdvar( "aim_automelee_lerp", 40 );
        setdvar( "aim_automelee_range", 100 );
        setdvar( "aim_automelee_move_limit", 0.1 );

        setdvar( "func_lunges", 0 );
    }
}

ToggleElevator() {
    if(!isDefined(self.elevator)) {
    self.elevator = true;
    SetUniqueDvar("func_elevator", 1);
    self thread ElevatorFunc();
    } else {
    self.elevator = undefined;
    SetUniqueDvar("func_elevator", 0);
    self notify( "endelevator" ); 
    }
}

ElevatorFunc() {
    self endon("disconnect");
    self endon("endelevator");

    for(;;)
    {
        if(self adsButtonPressed() && self StanceButtonPressed() && self isOnGround() && !self isOnLadder()) {
            self thread Elevate();
            wait 0.25;
        } else if(self JumpButtonPressed()) {
            self thread StopElevator();
        }
        wait 0.01;
    }
    wait 0.01;
}

 
Elevate() { 
    self endon( "stopelevator" ); 
    self.elevator = spawn( "script_origin", self.origin, 1 ); 
    self playerLinkTo( self.elevator, undefined ); 
 
    for(;;) { 
        self.o = self.elevator.origin; 
        wait 0.03; 
        xd = randomintrange(8,20);
        self.elevator.origin = self.o + (0, 0, xd); 
 
        wait 0.03; 
    } 
} 
 
StopElevator() { 
    wait 0.01; 
    self unlink(); 
    self.elevator delete(); 
    self notify( "stopelevator" ); 
}

ClearEnts()
{
    if (!self.printmodels)
    {
        self.printmodels = true;
        models = getentarray("script_model", "classname");
        for(i = 0; i < models.size; i++)
        {
            models[i] delete();
            wait .05;
        }
        self.printmodels = false;
    }
}

BlowjobFunc() {

    level.blowjobspeed = 1.3;

    if (self.bjspawning == 0 && level.blowjob == 0)
    {
        self.bjspawning = 1;
        level.blowjob = 1;
        self iprintlnbold("shoot where you want the blowjob to be spawned");
        self waittill( "weapon_fired" );
        self iprintlnbold("blowjob ^2spawned");
        self iprintln("to delete, click ^2blowjob ^7again.");
        bt = bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
        self.bjspawning = 0;
        self GuyModel( bt );
        self GirlModel( bt );
        self thread BlowjobMonitor();
    } else {
        self iprintln("blowjob ^1deleted");
        foreach (player in level.players) {
            player notify( "endBlowJob" );
        }
        self.doing = undefined;
        level.succguy delete();
        level.succgril delete();
        level.blowjob = 0;
    }
}

BlowjobMonitor() {
    self endon("disconnect");
    self endon("endBlowJob");
    for(;;)
    {
        speed = level.blowjobspeed;
        level.succgril.angles = ( 0, 180, 0 );
        level.succgril rotatepitch( 10, speed );
        wait speed;
        level.succgril rotatepitch( -10, speed );
        wait speed;
        level.succgril rotatepitch( 10, speed );
    }
    wait 0.05;
}

GirlModel( i ) {
    level.succguy = spawn( "script_model", i + ( 0, 0, -2 ) );
    level.succguy setmodel( "defaultactor" );
}

GuyModel( i ) {
    level.succgril = spawn( "script_model", i + ( 15, 0, -32 ) );
    level.succgril setmodel( "defaultactor" );
}

ToggleRideables() {
    if(!isDefined(self.rideables)) {
    self.rideables = true;
    SetUniqueDvar("func_rideables", 1);
    self thread Rideables();
    } else {
    self.rideables = undefined;
    SetUniqueDvar("func_rideables", 0);
    self notify( "stopriding" ); 
    }
}

Rideables() {
    valid_weapons = Group("inventory_m32_mp missile_drone_projectile_mp inventory_missile_drone_mp straferun_mp planemortar_mp killstreak_qrdrone_mp fhj18_mp knife_ballistic_mp crossbow_mp smaw_mp missile_swarm_projectile_mp straferun_rockets_mp usrpg_mp crossbow_mp heli_gunner_rockets_mp");   
    missiles = Group("remote_missile_missile_mp remote_missile_bomblet_mp");
    self endon("stopriding");
    self endon("disconnect");
    for (;;) {
    self waittill("missile_fire", weapon, weapname);   
    if ( weapname == valid_weapons )
    {
        weapon_name = weapname;
        linker = weapon;
        self Unlink();
        self playerlinkto( linker );
        self thread WatchJump();
        if(weapname != "knife_ballistic_mp" || weapname != "usrpg_mp" || weapname != "crossbow_mp" || weapname != "smaw_mp" || weapname != "fhj18_mp")
        weapon notify( "death" );
    }
    wait 0.5; 
    }
}

WatchJump() {
    for(;;) {
        if(self JumpButtonPressed()) {
            self Unlink();
            wait .2;
        } else {
            wait .2;
        }
    }
}

SoftLanding()
{
    self endon( "disconnect" );
    if( self.camera == 1 )
    {
        self iprintln( "Soft Landing ^2On" );
        self thread softland2();
    }
    else
    {
        self iprintln( "Soft Landing ^1Off" );
        self notify("DontFloat");
    }
}

softland2()
{
    self endon( "DontFloat" );
    self endon( "disconnect" );
    level waittill( "game_ended" );
    if( !(self isonground()) )
    {
        self thread sonftland3();
    }

}

sonftland3()
{
    self endon( "disconnect" );
    y = 0;
    initorigin = self getorigin();
    cp = spawn( "script_model", initorigin - ( 0, 0, 20 ) );
    playngles = self getplayerangles();
    cp.angles = ( 0, playngles[ 1], 0 );
    cp setmodel( "t6_wpn_supply_drop_ally" );
    x++;
    y++;
    cp.origin -= ( 0, 0, y * 1 );
    wait 0.01;

}

PerkMonitor() // From bo1 - Don't care to do anything else just checking this
{
    self endon("disconnect");
    for(;;)
    {

        
        self waittill_any( "spawned_player", "changed_class" );
        wait .5;

        // Perk Slot 1 //
        if(self hasPerk( "specialty_movefaster" )) // Lightweight
        {
            self setPerk( "specialty_fallheight" );
            self setPerk( "specialty_movefaster" );
        }
        if(self hasPerk( "specialty_scavenger" )) // Scavenger
        {
            self setPerk( "specialty_extraammo" );
            self setPerk( "specialty_scavenger" );
        }
        if(self hasPerk( "specialty_gpsjammer" )) // Ghost
        {
            self setPerk( "specialty_gpsjammer" );
            self setPerk( "specialty_nottargetedbyai" );
            self setPerk( "specialty_noname" );
        }
        if(self hasPerk( "specialty_flakjacket" )) // Flak Jacket
        {
            self setPerk( "specialty_flakjacket" );
            self setPerk( "specialty_flakjacket" );
            self setPerk( "specialty_flakjacket" );
        }
        if(self hasPerk( "specialty_killstreak" )) // Hardline
        {
            self setPerk( "specialty_killstreak" );
            self setPerk( "specialty_gambler" );
        }

        // Perk Slot 2 //
        if(self hasPerk( "specialty_bulletaccuracy" )) // Steady Aim
        {
            self setPerk( "specialty_fallheight" );
            self setPerk( "specialty_sprintrecovery" );
            self setPerk( "specialty_fastmeleerecovery" );
        }
        if(self hasPerk( "specialty_holdbreath" )) // Scout
        {
            self setPerk( "specialty_holdbreath" );
            self setPerk( "specialty_fastweaponswitch" );
        }
        if(self hasPerk( "specialty_fastreload" )) // Sleight of Hand
        {
            self setPerk( "specialty_fastreload" );
            self setPerk( "specialty_fastads" );
        }
        if(self hasPerk( "specialty_twoattach" )) // War Lord
        {
            self setPerk("specialty_twoattach");
            self setPerk("specialty_twogrenades");
        }

        // Perk Slot 3 //
        if(self hasPerk( "specialty_longersprint" )) // Marathon
        {
            self setPerk( "specialty_longersprint" );
            self setPerk( "specialty_unlimitedsprint" );
        }
        if(self hasPerk( "specialty_quieter" )) // Ninja
        {
            self setPerk( "specialty_quieter" );
            self setPerk( "specialty_loudenemies" );
        }
        if(self hasPerk( "specialty_showenemyequipment" )) // Hacker
        {
            self setPerk( "specialty_showenemyequipment" );
            self setPerk( "specialty_detectexplosive" );
            self setPerk( "specialty_disarmexplosive" );
            self setPerk( "specialty_nomotionsensor" );
        }
        if(self hasPerk( "specialty_gas_mask" )) // Tactical Mask
        {
            self setPerk( "specialty_shades" );
            self setPerk( "specialty_stunprotection" );
        }
        if(self hasPerk( "specialty_pistoldeath" )) // last chance
        {
            self setPerk( "specialty_pistoldeath" );
            self setPerk( "specialty_finalstand" );
            
            player = level.players;
            for(i=0;i<level.players.size;i++)
            {
                if(isDefined(player.pers["isBot"]) && player.pers["isBot"])
                {
                    if(player.pers["team"] == self.team)
                        continue;
                    self unsetPerk( "specialty_pistoldeath" );
                    self unsetPerk( "specialty_finalstand" );
                }
            }
        }

    wait .1;
    }
}