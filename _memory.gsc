#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_functions;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_binds;
#include scripts\mp\_damage;
#include scripts\mp\_utils;
#include scripts\mp\_aimbot;

Memory(dvar, func) {
    x = GetUniqueDvar(dvar);
    if(x != "0" || x != 0 || x != undefined || x != "false" || x != "none")
    {
        self thread [[func]](x);
        print("[^2MEMORY^7] Loaded ^3" + dvar + "\n");
      } else {
    }
}

BaseMemory(dvar, func) {
    x = getDvar(dvar);
    if(x != "0" || x != 0)
    {
        self thread [[func]](x);
      } else {
    }
}

MemAutoReload() {
    z = GetUniqueDvar("func_autoreload");

    if(z == 1 || z == "1")
    {
    self.autoreload = true;
    self thread DoReload();
    }
}

MemNoClip() {
    z = GetUniqueDvar("func_noclip");

    if(z == 1 || z == "1")
    {
    self.noclipbind = true;
    self thread NoClipping();
    }
}

MemLunges() {
    self setPers("lunge", true);
    setdvar( "aim_automelee_enabled", 1 );
    setdvar( "aim_automelee_lerp", 100 );
    setdvar( "aim_automelee_range", 250 );
    setdvar( "aim_automelee_move_limit", 0 );
}

MemTimescale() {
    setDvar("timescale", getDvarFloat("func_timescale"));
}

MemKillcamType() {
        level notify("resetcam");
        level waittill(getDvar("func_killcamtype"));
        setdvar("timescale", 1);  
}

MemBounces() {
    z = GetDvar("func_bounces");

    if(z == 1 || z == "1")
    {
    self.bouncing = true;
    setDvar("sv_enablebounces", getDvarInt("func_bounces"));
    }
}

MemExoSuits() {
    z = GetUniqueDvar("func_exosuits");

    if(z == 1 || z == "1") {
    self.exosuits = true;
    self thread ExoSuitFunc();
    }
}

MemHud() {
    z = GetUniqueDvar("func_hud");

	if(z == 1 || z == "1") {
        self.myhud = true;
        self setclientuivisibilityflag( "hud_visible", 0 );
    }

    if (z == 0 || z == "0") {
        self.myhud = undefined;
        self setclientuivisibilityflag( "hud_visible", 1 );
    }

}

MemFakeSweep() {
    z = GetUniqueDvar("func_fakesweep");
	if(z == 1 || z == "1") {
        self.fakesweep = true;
    	self thread FakeSweep();
    }
}

MemRideables() {
    z = GetUniqueDvar("func_rideables");
	if(z == 1 || z == "1") {
        self.rideables = true;
    	self thread Rideables();
    }
}


MemElevator() {
    z = GetUniqueDvar("func_elevator");
	if(z == 1 || z == "1") {
        self.elevator = true;
    	self thread ElevatorFunc();
    }
}

MemInfAmmo() {
    z = GetUniqueDvar("func_infammo");
	if(z == 1 || z == "1") {
        self.infammo = true;
    	self thread InfAmmo();
    }
}

MemClassCanzoom() {
    z = GetUniqueDvar("func_ccanzoom");
	if(z == 1 || z == "1") {
        self.classcanzoom = true;
    }
}

MemClassIllusion() {
    z = GetUniqueDvar("func_iilusion");
	if(z == 1 || z == "1") {
        self.classillusion = true;
    }
}

MemClassEmpty() {
    z = GetUniqueDvar("func_emptyclip");
	if(z == 1 || z == "1") {
        self.classempty = true;
    }
}

MemClassCanswap() {
    z = GetUniqueDvar("func_ccanswap");
	if(z == 1 || z == "1") {
        self.classcanswap = true;
    }
}

MemBotInstantRespawn() {
    z = GetDvar("func_instantrespawn");
	if(z == 1 || z == "1") {
        self.instantrespawnbot = true;
        self thread InstantBotRespawnFunc();
    }
}

MemInstantRespawn() {
    z = GetUniqueDvar("func_instantrespawn");
	if(z == 1 || z == "1") {
        self.instantrespawn = true;
        self thread InstantRespawnFunc();
    }
}

MemBotLives() {
    z = GetDvar("func_botlives");
	if(z == 1 || z == "1") {
        self thread BotLives(1);
    }
}

MemPickups() {
    z = GetDvar("func_pickups");
	if(z == 1 || z == "1") {
        level.pickups = true;
    }
}

MemLadderJumps() {
    z = GetDvar("func_ladderjumps");
	if(z == 1 || z == "1") {
        level.ladderjumps = true;
    }
}

MemHatchetNades() {
    z = GetUniqueDvar("func_hatchetnades");
	if(z == 1 || z == "1") {
        level.hatchetnades = true;
        self thread HatchetNadesFunc();
    }
}

MemThrowbacks() {
    z = GetDvar("func_throwbacks");
	if(z == 1 || z == "1") {
        level.throwbacks = true;
    }
}

MemLadderSpins() {
    z = GetDvar("func_ladderspins");
	if(z == 1 || z == "1") {
        level.ladderspinning = true;
    }
}

MemProneSpins() {
    z = GetDvar("func_pronespins");
	if(z == 1 || z == "1") {
        level.pronespinning = true;
    }
}

MemJumpSlowdown() {
    z = GetDvar("func_jumpslowdowns");
	if(z == 1 || z == "1") {
        level.jumpslowdown = true;
        setdvar("jump_slowdown", 0);
    }
}

MemMidProne() {
    z = GetUniqueDvar("func_midprone");

	if(z == 1 || z == "1") {
        self.midairprone = true;
    	self thread MidAirProne();
    }
}

MemAutoProne() {
    z = GetUniqueDvar("func_autoprone");

	if(z == 1 || z == "1") {
        self.autoprone = true;
    	self thread InitAutoProne();
    }
}

MemAlwaysCanswap() {
    z = GetUniqueDvar("func_alwayscanswap");

	if(z == 1 || z == "1") {
        self.alwayscanswap = true;
    	self thread AlwaysCanswapFunc();
    }
}

MemInfEq() {
    z = GetUniqueDvar("func_infeq");

	if(z == 1 || z == "1") {
        self.infeq = true;
    	self thread InfEq();
    }
}

MemMW2() {
    z = GetUniqueDvar("func_mw2");

	if(z == 1 || z == "1") {
        self.mw2 = true;
    	self thread MW2();
    }
}

MemHMAimbot() {
    z = GetUniqueDvar("func_hmaimbot");

	if(z == 1 || z == "1") {
        self.hmaimbot = true;
    	self thread HMAimbotFunc();
    }
}

MemPrestige() {
    z = GetUniqueDvar("prestige");

	if(z != "^1OFF^7") {
        self SetPers("customrank", true);
        self thread NewPrestige(z);
    }
}

MemHMAimbotWeapon() {
    z = GetUniqueDvar("func_hmaimbotweapon");

	if(z != "^1NONE^7") {
        self.hmaimbotweapon = true;
    }
}

MemAimbot() {
    z = GetUniqueDvar("func_aimbot");

	if(z == 1 || z == "1") {
        self.aimbot = true;
    	self thread AimbotFunc();
    }
}

MemAimbotRange() {
    z = GetUniqueDvarInt("func_aimbotrange");

	if(z != 0) {
        self.aimbotrange = z;
    }
}

MemAimbotWeapon() {
    z = GetUniqueDvar("func_aimbotweapon");

	if(z != "^1NONE^7") {
        self.aimbotweapon = true;
    }
}

MemAimbotWeapon2() {
    z = GetUniqueDvar("func_aimbotweapon2");

	if(z != "^1NONE^7") {
        self.aimbotweapon2 = true;
    }
}

MemUAV() {
    z = GetUniqueDvar("func_uav");

	if(z == 1 || z == "1") {
        self.douav = true;
    	self setclientuivisibilityflag("g_compassShowEnemies", 1);
    }

    if (z == 0 || z == "0") {
        self.douav = undefined;
    	self setclientuivisibilityflag("g_compassShowEnemies", 0);
    }

}