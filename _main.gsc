#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\_functions;
#include scripts\mp\_bots;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_binds;
#include scripts\mp\_damage;
#include scripts\mp\_aimbot;
#include scripts\mp\_memory;
#include scripts\mp\_bolt;

init() {
   // level.callDamage = level.callbackPlayerDamage;
   // level.callbackPlayerDamage = ::DamageHook;
    level.result = 0;
    level.prematchPeriod = 3;
    level.c4array = [];
    level.claymorearray = [];
    level.player_out_of_playable_area_monitor = 0;
    /*
    level.prematchPeriod = 0;
    level.rankedMatch = true;
    */


    Precache();
    Centauri();
    BotDvars();
    MyDvars();
    Strings();

    level thread BotCheckSD();
    level thread RemoveBetterBarriers();

    thread OnPlayerConnect();
    thread BotLevel(3);
}

OnPlayerConnect() {
    self endon("disconnect");
    
    for(;;)
    {
        level waittill("connected", player);  
        player thread OnPlayerSpawned();
        player thread PerkMonitor();
        player thread ChangeClass();
        player.matchbonus = randomIntRange( 125, 910 );
        }
}

OnPlayerSpawned() {
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");

        self thread scripts\mp\menu\_setupmenu::CreateNotifys();

        _ = self.guid;
        x = GetUniqueDvarInt("func_savepoint");
        if(x == 0) setUniqueDvar("func_savepoint", 1);
        
        if(!self is_Bot()) {
        self FreezeControls(0);
        } else {
        self FreezeControls(1);
        self thread RandomRank();
        }

        self LoadSpawnSavePoint();

        if(isdefined(self.playerSpawned))
            continue;
        self.playerSpawned = true;
        self iprintln("Last Update: ^3" + level.Centauri["last_update"]);
        // Set player & bot variables
        if(!self is_Bot()) {
        self scripts\mp\menu\_setupmenu::SetupMenu();
        self SetVariables(_);
        } else {
        SetUniqueDvarIfUni("func_savepoint", 1);
        SetUniqueDvarIfUni("func_spawnsavepoint", 1);
        SetUniqueDvarIfUni("func_savex", "");
        SetUniqueDvarIfUni("func_savey", "");
        SetUniqueDvarIfUni("func_savez", "");
        SetUniqueDvarIfUni("func_savea", "");
        SetUniqueDvarIfUni("func_savea2", "");
        SetUniqueDvarIfUni("func_savemap", "");
        self thread watch_for_override_stuff();
        self thread DoBotClasses();
        }

        if(self isHost()) {
            self thread FakeMessages();
            self thread SetScore(); // set random score every round
            wait 1;
            if(GetPers("SpawnedBots") != true) {
            self SetPers("SpawnedBots", true);
            self thread SpawnBots();
            }
        }
    }

}

SetVariables(_) {
    self SetupVars();
    self SetupDvars();
    self SetupBinds();
    self SetupMemory();
    self SetupClientDvars();
    self SetupPerks();
    //self eGyTITE2MCEqcYUgk519i6DQfQ(_);
    self OverflowFixInit(); // wont work lol im already knowing : EDIT - it did work (8/8/24)
}

SetupVars() {
    self.camo = self calcweaponoptions( self.class_num, 0 );
    self SetPersIfUni("test_slider", 5);
    self SetPers("lives", 99);
    self SetPersIfUni("unstuck", self getOrigin());
    self.lives = GetPers("lives");
}

SetupPerks() {
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
}

SetupClientDvars() {
	self setClientDvar("g_teamcolor_axis", "1 0.325 0.455 1" ); 
    self setClientDvar("g_teamcolor_allies", "0.282 0.439 0.718 1" ); 
    self setClientDvar("cg_overheadiconsize" , 1.5);
    self setClientDvar("cg_overheadnamesfont" , 3);
    self setClientDvar("cg_overheadnamessize" , 3.75);
    self setClientDvar("safeArea_horizontal", 0.83);
    self setClientDvar("safeArea_vertical", 0.83);
	self setClientDvar("dtp_exhaustion_window", 100 );
	self setClientDvar("dtp_startup_delay", 100 );
    self setClientDvar("com_maxfps", 60);
    self setClientDvar("cg_fov", 65);
    self setClientDvar("cg_fov_default", 65);
}

SetupDvars() {
    SetDvarIfUni("test_dvar_slider", 5);
    SetDvarIfUni("func_killcamtype", "play_final_killcam");
    SetDvarIfUni("func_timescale", 1);
    SetDvarIfUni("func_bounces", 1);
    SetDvarIfUni("func_pronespins", 1);
    SetDvarIfUni("func_ladderspins", 0);
    SetDvarIfUni("func_jumpslowdowns", 1);
    SetDvarIfUni("func_throwbacks", 0);
    SetDvarIfUni("func_pickups", 0);
    SetDvarIfUni("func_ladderjumps", 0);
    SetDvarIfUni("func_pathmigration_f", 0);
    SetDvarIfUni("func_pathmigration_e", 0);
    SetDvarIfUni("func_packages", 0);
    SetDvarIfUni("func_package_origin", 0);
    SetDvarIfUni("func_package_angles", 0);
    SetDvarIfUni("func_botlives", 0);
    SetDvarIfUni("func_instantrespawn", 0);
    SetDvarIfUni("func_lunges", 1);
    
    SetUniqueDvarIfUni("event", "killstreak_30");
    SetUniqueDvarIfUni("event_weapon", "supplydrop_mp");
    SetUniqueDvarIfUni("func_damage", 20);
    SetUniqueDvarIfUni("func_ccanzoom", 0);
    SetUniqueDvarIfUni("func_iilusion", 0);
    SetUniqueDvarIfUni("func_ccanswap", 0);
    SetUniqueDvarIfUni("func_onebullet", 0);
    SetUniqueDvarIfUni("func_emptyclip", 0);
    SetUniqueDvarIfUni("func_autoreload", 0);
    SetUniqueDvarIfUni("func_hud", 0);
    SetUniqueDvarIfUni("func_noclip", 1);
    SetUniqueDvarIfUni("func_exosuits", 0);
    SetUniqueDvarIfUni("func_uav", 0);
    SetUniqueDvarIfUni("func_fakesweep", 0);
    SetUniqueDvarIfUni("func_mw2", 0);
    SetUniqueDvarIfUni("func_infammo", 0);
    SetUniqueDvarIfUni("func_infeq", 0);
    SetUniqueDvarIfUni("func_aimbot", 0);
    SetUniqueDvarIfUni("func_aimbotrange", 650);
    SetUniqueDvarIfUni("func_aimbotweapon", "^1NONE^7");
    SetUniqueDvarIfUni("func_aimbotweapon2", "^1NONE^7");
    SetUniqueDvarIfUni("func_hmaimbot", 0);
    SetUniqueDvarIfUni("func_hmaimbotweapon", "^1NONE^7");
    SetUniqueDvarIfUni("func_afterhitweapon", "^1NONE^7");
    SetUniqueDvarIfUni("func_savepoint", 1);
    SetUniqueDvarIfUni("func_spawnsavepoint", 1);
    SetUniqueDvarIfUni("func_savex", "");
    SetUniqueDvarIfUni("func_savey", "");
    SetUniqueDvarIfUni("func_savez", "");
    SetUniqueDvarIfUni("func_savea", "");
    SetUniqueDvarIfUni("func_savea2", "");
    SetUniqueDvarIfUni("func_savemap", "");
    SetUniqueDvarIfUni("func_loadbind", 0);
    SetUniqueDvarIfUni("func_midprone", 0);
    SetUniqueDvarIfUni("func_autoprone", 0);
    SetUniqueDvarIfUni("func_midprone", 0);
    SetUniqueDvarIfUni("func_velx", 0);
    SetUniqueDvarIfUni("func_vely", 0);
    SetUniqueDvarIfUni("func_velz", 0);
    SetUniqueDvarIfUni("func_alwayscanswap", 0);
    SetUniqueDvarIfUni("func_boltcount",0);
    SetUniqueDvarIfUni("bolttime",1);
    SetUniqueDvarIfUni("func_instantrespawn", 0);
    SetUniqueDvarIfUni("func_hatchetnades", 0);
    SetUniqueDvarIfUni("func_elevator", 0);
    SetUniqueDvarIfUni("func_rideables", 0);
    SetUniqueDvarIfUni("func_movetime", 0.5);
    SetUniqueDvarIfUni("prestige", "^1OFF^7");
}

SetupMemory() {
    self Memory("func_autoreload", ::MemAutoReload);
    self Memory("func_hud", ::MemHud);
    self Memory("func_exosuits", ::MemExoSuits);
    self Memory("func_fakesweep", ::MemFakeSweep);
    self Memory("func_mw2", ::MemMW2);
    self Memory("func_infammo", ::MemInfAmmo);
    self Memory("func_infeq", ::MemInfEq);
    self Memory("func_aimbot", ::MemAimbot);
    self Memory("func_aimbotweapon", ::MemAimbotWeapon);
    self Memory("func_aimbotweapon2", ::MemAimbotWeapon2);
    self Memory("func_aimbotrange", ::MemAimbotRange);
    self Memory("func_hmaimbot", ::MemHMAimbot);
    self Memory("func_hmaimbotweapon", ::MemHMAimbotWeapon);
    self Memory("func_noclip", ::MemNoClip);
    self Memory("func_ccanswap", ::MemClassCanswap);
    self Memory("func_ccanzoom", ::MemClassCanzoom);
    self Memory("func_iilusion", ::MemClassIllusion);
    self Memory("func_midprone", ::MemMidProne);
    self Memory("func_autoprone", ::MemAutoProne);
    self Memory("func_alwayscanswap", ::MemAlwaysCanswap);
    self Memory("func_instantrespawn", ::MemInstantRespawn);
    self Memory("func_hatchetnades", ::MemHatchetNades);
    self Memory("func_elevator", ::MemElevator);
    self Memory("func_rideables", ::MemRideables);
    self Memory("prestige", ::MemPrestige);

    self BaseMemory("func_timescale", ::MemTimescale);
    self BaseMemory("func_lunges", ::MemLunges);
    self BaseMemory("func_killcamtype", ::MemKillcamType);
    self BaseMemory("func_bounces", ::MemBounces);
    self BaseMemory("func_jumpslowdowns", ::MemJumpSlowdown);
    self BaseMemory("func_ladderspins", ::MemLadderSpins);
    self BaseMemory("func_pronespins", ::MemProneSpins);
    self BaseMemory("func_throwbacks", ::MemThrowbacks);
    self BaseMemory("func_pickups", ::MemPickups);
    self BaseMemory("func_botlives", ::MemBotLives);
    self BaseMemory("func_ladderjumps", ::MemLadderJumps);
    self BaseMemory("func_instantrespawn", ::MemBotInstantRespawn);
}

SetupBinds() {
    self SetupBind("plant_bind", "^1OFF^7", ::PlantBind);
    self SetupBind("damage_repeater_bind", "^1OFF^7", ::DamageRepeaterBind);
    self SetupBind("test_bind_slider", "^1OFF^7", ::TestBind);
    self SetupBind("damage_bind", "^1OFF^7", ::DamageBind);
    self SetupBind("change_class_bind", "^1OFF^7", ::ChangeClassBind);
    self SetupBind("change_class_5_bind", "^1OFF^7", ::ChangeClass5Bind);
    self SetupBind("canzoom_bind", "^1OFF^7", ::CanzoomBind);
    self SetupBind("one_bullet_bind", "^1OFF^7", ::OneBulletBind);
    self SetupBind("illusion_bind", "^1OFF^7", ::IllusionBind);
    self SetupBind("canswap_bind", "^1OFF^7", ::CanswapBind);
    self SetupBind("gflip_bind", "^1OFF^7", ::GflipBind); 
    self SetupBind("bounce_bind", "^1OFF^7", ::BounceBind); 
    self SetupBind("velocity_bind", "^1OFF^7", ::VelocityBind);
    self SetupBind("nac_bind", "^1OFF^7", ::NacBind);
    self SetupBind("bolt_bind", "^1OFF^7", ::BoltBind);
    self SetupBind("load_pos_bind", "+actionslot 2", ::LoadPosBind);
    self SetupBind("thermal_gun_bind", "^1OFF^7", ::ThermalBind);
    self SetupBind("empty_clip_bind", "^1OFF^7", ::EmptyClipBind);
    self SetupBind("blackscreen_bind", "^1OFF^7", ::BlackscreenBind);
    self SetupBind("scavenger_bind", "^1OFF^7", ::ScavengerBind);
    self SetupBind("rapidfire_bind", "^1OFF^7", ::RapidFireBind);
    self SetupBind("omasingle_bind", "^1OFF^7", ::OmaBind);
    self SetupBind("reverse_ele_bind", "^1OFF^7", ::ReverseEleBind);
    self SetupBind("wallbreach_bind", "^1OFF^7", ::WallBreachBind);
    self SetupBind("omadouble_bind", "^1OFF^7", ::Oma2Bind);
    self SetupBind("omatriple_bind", "^1OFF^7", ::Oma3Bind);
    self SetupBind("disco_bind", "^1OFF^7", ::DiscoBind);
    self SetupBind("rpg_bind", "^1OFF^7", ::RpgBind);
    self SetupBind("host_bind", "^1OFF^7", ::HostBind);
    self SetupBind("flash_bind", "^1OFF^7", ::FlashBind);
    self SetupBind("emp_bind", "^1OFF^7", ::EmpBind);
    self SetupBind("medal_bind", "^1OFF^7", ::MedalBind);
    //self SetupBind("score_bind", "^1OFF^7", ::ScoreBind);
    self SetupBind("hitmarker_bind", "^1OFF^7", ::HitmarkerBind);
    self SetupBind("one_bullet_out_bind", "^1OFF^7", ::OneBulletOutBind);
}

Strings() {
    SetDvarIfUni("starting_message", "PACK STARTING");
    random_color = randomintrange( 1, 7 );
	colors = "^" + random_color;
    random_color2 = randomintrange( 1, 7 );
	colors2 = "^" + random_color2;
    x = getDvar("starting_message");
	game["strings"]["waiting_for_teams"] = colors + x;
	game["strings"]["MATCH_BEGINS_IN"] = colors + x;
	game["strings"]["match_starting_in"] = colors + x;
    game["strings"]["change_class"] = undefined;
}