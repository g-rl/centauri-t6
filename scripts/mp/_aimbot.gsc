#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\_functions;
#include scripts\mp\_bots;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_damage;
#include scripts\mp\menu\_menuutils;

ToggleAimbot() {
	if(!isDefined(self.aimbot))
	{
	self.aimbot = true;
	setUniqueDvar("func_aimbot", 1);
	self thread AimbotFunc();
	}
	else
	{
		self.aimbot = undefined;
		setUniqueDvar("func_aimbot", 0);
		self notify("stopaimbot");
	}
}

ToggleHMAimbot() {
	if(!isDefined(self.hmaimbot))
	{
	self.hmaimbot = true;
	setUniqueDvar("func_hmaimbot", 1);
	self thread HMAimbotFunc();
	}
	else
	{
		self.hmaimbot = undefined;
		setUniqueDvar("func_hmaimbot", 0);
		self notify("stophmaimbot");
	}
}

AimbotWeapon2() {
	if(!isDefined(self.aimbotweapon2))
	{
	self.aimbotweapon2 = true;
	setUniqueDvar("func_aimbotweapon2", self getCurrentWeapon());
	}
	else
	{
		self.aimbotweapon2 = undefined;
		setUniqueDvar("func_aimbotweapon2", "^1NONE^7");
	}
}

HMAimbotWeapon() {
	if(!isDefined(self.hmaimbotweapon))
	{
	self.hmaimbotweapon = true;
	setUniqueDvar("func_hmaimbotweapon", self getCurrentWeapon());
	} else {
		self.hmaimbotweapon = undefined;
		setUniqueDvar("func_hmaimbotweapon", "^1NONE^7");
	}
}

AimbotWeapon() {
	if(!isDefined(self.aimbotweapon))
	{
	self.aimbotweapon = true;
	setUniqueDvar("func_aimbotweapon", self getCurrentWeapon());
	} else {
		self.aimbotweapon = undefined;
		setUniqueDvar("func_aimbotweapon", "^1NONE^7");
	}
}

GetBulletTrace() {
    start = self geteye();
    end = start + anglestoforward(self getplayerangles()) * 1000000;
    x = bullettrace(start, end, false, self)["position"];
    return x;
}

AimbotRangeSlider(value) {
	range = int(value);
	setUniqueDvar("func_aimbotrange", range);
	self.aimbotrange = getUniqueDvarInt("func_aimbotrange");

	if(value == "^1Disable^7") {
	setUniqueDvar("func_aimbotrange", 0);
	self.aimbotrange = getUniqueDvarInt("func_aimbotrange");
	}
    self IPrintLnBold("Aimbot range set to ^3" + value);
}

AimbotDelaySlider(value) {
	delay = float(value);
	setUniqueDvar("func_aimbotdelay", delay);
    self IPrintLnBold("Aimbot delay set to ^3" + delay);

	if(value == "^1Disable^7") {
	setUniqueDvar("func_aimbotdelay", 0);
	}
}

AimbotFunc( weapon ) {
	self endon("disconnect");
	self endon("stopaimbot");

	for(;;)
	{
		self waittill("weapon_fired");
			x = self.aimbotrange;
            foreach(player in level.players) {
			if(isDefined(self.aimbotrange)) {
            if(player.pers["team"] != self.pers["team"] || getDvar("g_gametype") == "dm") {
				if(x > 0) {
                if (self getCurrentWeapon() == getUniqueDvar("func_aimbotweapon") || self getCurrentWeapon() == getUniqueDvar("func_aimbotweapon2")) {
				trace = getBulletTrace();
				if(distance(player.origin,trace) < x) {
				if(isAlive(player)) { // hitmarker after death fix ? LOL : EDIT: worked lol
					if(GetUniqueDvarFloat("func_aimbotdelay") != "^1NONE^7") wait GetUniqueDvarFloat("func_aimbotdelay");
            		player thread [[level.callbackPlayerDamage]] ( self, self, 500, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "pelvis", 0, 0 );
								}
							}
						}
			
					}
				}
			}
		}	
	}
}

HMAimbotFunc( weapon ) {
	self endon("disconnect");
	self endon("stophmaimbot");

	for(;;) {
		self waittill("weapon_fired");
		if (self getCurrentWeapon() == getUniqueDvar("func_hmaimbotweapon")) {
			self thread Hitmarker();
		}		
	}
}

Hitmarker()
{
    self playlocalsound("mpl_hit_alert");
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
}