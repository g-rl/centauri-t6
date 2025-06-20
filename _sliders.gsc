#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_binds;
#include scripts\mp\_damage;
#include scripts\mp\_functions;

TestArraySlider(value) {
    self IPrintLnBold("You Selected: " + value);
}

GravitySlider(value) {
    setDvar("bg_gravity", value);
    self IPrintLnBold("Gravity set to ^3" + value);
}

SpawnSavePointSlider(value) {
    SetUniqueDvar("func_spawnsavepoint", value);
    self IPrintLnBold("Now spawning on point ^3#" + value);
}

SavepointSlider(value) {
    SetUniqueDvar("func_savepoint", value);
    self IPrintLnBold("Now loading on point ^3#" + value);
}

DamageSlider(value) {
    SetUniqueDvar("func_damage", value);
    self iPrintLnBold("Damage bind amount set to ^3" + value);
}

AddVelocitySliderX(value) {
    v = int(value);
    self thread EditVelocity("x", v);
}

MultiplySlider(value) {
    v = int(value);
    self thread MultiplyVelocity(v);
}

DivideSlider(value) {
    v = int(value);
    self thread DivideVelocity(v);
}

RemoveVelocitySliderX(value) {
    v = int(value);
    self thread EditVelocity("x", v);
}

AddVelocitySliderY(value) {
    v = int(value);
    self thread EditVelocity("y", v);
}

RemoveVelocitySliderY(value) {
    v = int(value);
    self thread EditVelocity("y", v);
}

AddVelocitySliderZ(value) {
    v = int(value);
    self EditVelocity("z", v);
}

RemoveVelocitySliderZ(value) {
    v = int(value);
    self EditVelocity("z", v);
}

KillcamTimeSlider(value) {
    setDvar("scr_killcam_time", value);
    self IPrintLnBold("Killcam time set to ^3" + value);
}

StreakSlider(value) {

    switch( value )
    {
       case "All Streaks":
             self thread AllStreaks();
             break;
       case "Predator Missile":
             self thread GiveStreak("killstreak_remote_missile");
             break;
       case "Care Package":
             self thread GiveCare();
             break;
       case "Orbital VSAT":
             self thread GiveStreak("killstreak_spyplane_direction");
             break;
       case "Sentry Gun":
             self thread GiveSentry();
             break;
       case "RCXD":
             self thread GiveStreak("killstreak_rcbomb");
             break;
       case "Hunter Killer":
             self thread GiveHunter();
             break;
        default:
             break;      
    }
}

MoveSlider(value) {
    SetUniqueDvar("func_movetime", value);
}

BombSlider(value) {
    switch( value )
    {
       case "Plant":
             self thread PlantBomb();
             break;
       case "Defuse":
             self thread DefuseBomb();
             break;
        default:
             break;      
    }
}

LookingSlider(value) {
    switch( value )
    {
       case "Face Once":
             self thread BotsLook();
             break;
       case "Always Looking":
             self thread BotsLookAlways();
             break;
       case "Stop Looking":
             self notify("StopLooking");
             self.looking = undefined;
             break;
        default:
             break;      
    }
}

RespawnSlider(value) {
    switch( value )
    {
       case "Enemies":
             self thread RespawnEnemies();
             break;
       case "Friendly":
             self thread RespawnFriends();
             break;
        default:
             break;      
    }
}

MessageCycle(value) { // Start cycle for victory messages 
    switch( value ) {
        case "":
            break;
        default:
            break;
    }
    self iPrintLnBold("Victory message set to ^3" + value);
}

SpawnableSlider(value) {
    switch( value )
    {
       case "Repeater Crate":
             self thread SpawnSafePackage();
             break;
       case "Delete All":
             self thread ClearEnts();
             break;
        default:
             break;      
    }
}

MedalSlider(value) {
    switch( value )
    {
       case "Nuclear":
             display = "killstreak_30";
             break;
       case "Relentless":
             display = "killstreak_20";
             break;
       case "Merciless":
             display = "killstreak_10";
             break;
       case "Ruthless":
             display = "killstreak_15";
             break;
       case "Killed Planter":
             display = "killed_bomb_planter";
             break;
       case "Killed Defuser":
             display = "killed_bomb_defuser";
             break;
       case "Savior":
             display = "kill_enemy_who_killed_teammate";
             break;
        default:
             break;      
    }

    SetUniqueDvar("event", display);
}

CanswapSlider(value) {

    // ##########
    // May be too much but it ensures randomization pretty well & is easier to maintain
    smg = RandomizeWeapon("mp7,pdw57,vector,insas,qcw05,evoskorpion,peacekeeper");
    ar = RandomizeWeapon("tar21,type95,sig556,sa58,hk416,scar,saritch,xm8,an94");
    shotgun = RandomizeWeapon("870mcs,saiga12,ksg,srm1216");
    lmg = RandomizeWeapon("mk48,qbb95,lsat,hamr");
    sniper = RandomizeWeapon("svu,dsr50,ballista,as50");
    pistol = RandomizeWeapon("kard_dw,fnp45_dw,fiveseven_dw,judge_dw,baretta93r_dw,fiveseven,fnp45,baretta93r,judge,kard");
    misc = RandomizeWeapon("smaw,fhj18,usrpg,riotshield,crossbow,knife_ballistic_mp");

    smgat = Randomize("+sf,+reflex,+silencer,+fmj,+fastads,+dualclip");
    arat = Randomize("+mms,+gl,+fastads,+dualclip,+reflex");
    shotgunat = Randomize("+extbarrel,+silencer,+fastads,+reflex");
    lmgat = Randomize("+ir,+stalker");
    sniperat = Randomize("+ir,+dualclip,+silencer,+acog,+vzoom,+steadyaim,+swayreduc,+ir+dualclip");
    // #########

    switch( value )
    {
       case "SMG":
             self DropItemFunc(smg+smgat);
             break;
       case "AR":
             self DropItemFunc(ar+arat);
             break;
       case "LMG":
             self DropItemFunc(lmg+lmgat);
             break;
       case "Shotgun":
             self DropItemFunc(shotgun+shotgunat);
             break;
       case "Sniper":
             self DropItemFunc(sniper+sniperat);
             break;
       case "Pistol":
             self DropItemFunc(pistol);
             break;
       case "Misc":
             self DropItemFunc(misc);
             break;
        default:
             break;      
    }
}

BotSpawnSlider(value) {
    switch( value )
    {
        case "Enemy":
            self thread SpawnEnemy();
            break;
        case "Friendly":
            self thread SpawnFriendly();
            break;
        default:
            break;
    }
}

ResourceSlider(value) {
    switch( value )
    {
        case "Infinite Ammo":
            self thread ToggleInfAmmo();
            break;
        case "Infinite Equipment":
            self thread ToggleInfEq();
            break;
        default:
            break;
    }
}

TimerSlider(value) {
    switch( value )
    {
        case "Add Minute":
            self thread AddMin();
            break;
        case "Remove Minute":
            self thread RemoveMin();
            break;
        case "Remove Timer":
            self thread Unlimited();
            break;
        default:
            break;
    }
}

BotTeleportSlider(value) {
    switch( value )
    {
        case "Setup All":
            self thread TeleportFreeze();
            break;
        case "Setup Enemies":
            self thread TeleportFreezeEnemy();
            break;
        case "All Moving":
            self thread TeleportNoFreeze();
            break;
        case "Friendly Path Migration":
            self thread PathMigrationFriends();
            break;
        case "Enemy Path Migration":
            self thread PathMigrationEnemy();
            break;
        case "Setup Friendly":
            self thread TeleportFreezeFriends();
            break;
        case "Moving Friendly":
            self thread TeleportNoFreezeFriends();
            break;
        case "Moving Enemy":
            self thread TeleportNoFreezeEnemy();
            break;
        default:
            break;
    }
}

BounceSlider(value) {
    setDvar("sv_enablebounces", value);
}

KillcamSlider(value) {
    if(value == "Game End") {
        x = "game_ended";
    }

    if(value == "Killcam Start") {
        x = "play_final_killcam";
    }
    
    setDvar("func_killcamtype", x);
    y = getDvar("func_killcamtype");

    IPrintLnBold("Killcam timescale mode set to: ^3" + value);
    self thread ResetTime(y);
}

TimescaleSlider(value) {
    setDvar("timescale", value);
    setDvar("func_timescale", value);
}

BotKickSlider(value) {
    switch( value )
    {
        case "Enemies":
            self thread KickEnemy();
            break;
        case "Friendlies":
            self thread KickFriendly();
            break;
    }
}

BoltSlider(x) {
    SetUniqueDvar("func_boltcount",x);
    SetUniqueDvar("func_boltpos_x" + x,self.origin[0]);
    SetUniqueDvar("func_boltpos_z" + x,self.origin[1]);
    SetUniqueDvar("func_boltpos_y" + x,self.origin[2]);
    self iPrintLnBold("[^3" + x + "^7] Bolt Point Saved"); 
}

BoltDeleteSlider(i) {
    x = GetUniqueDvarInt("func_boltcount");
    if(x != 0)
    {
        SetUniqueDvar("func_boltpos_x" + i,"");
        SetUniqueDvar("func_boltpos_z" + i,"");
        SetUniqueDvar("func_boltpos_y" + i,""); 
        self iPrintLnBold("[^3" + i + "^7] Bolt Point Deleted");
        x -= 1;
        SetUniqueDvar("func_boltcount",x);
    } else self iPrintLnBold("^1ERROR: No Bolts");
}