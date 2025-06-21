#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\menu\_overflow;

DamageHook( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, boneIndex ) {
    	    death = randomize("mpl_flag_pickup_plr,mus_lau_rank_up,aml_dog_bark,cac_enter_cac,wpn_grenade_bounce_metal,mpl_wager_humiliate,wpn_claymore_alert,wpn_grenade_explode_glass,wpn_taser_mine_zap,wpn_hunter_ignite"); // Bot Weapons. Add above
        
			if ( DamageWeapon( sWeapon ) && !ShockCheck(sWeapon) )
            {
			iDamage = 9999;
            eAttacker playsound( death );
            }

    [[level.callDamage]]( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, boneIndex );
}

DamageWeapon( weapon ) {
    if ( !isDefined ( weapon ) )
        return false;
    
    weapon_class = getweaponclass( weapon );
    if ( weapon_class == "weapon_sniper" || isSubStr( weapon , "sa58_" ) ) //Allows all snipers and FAL damage
        return true;
        
    switch( weapon )
    {
       case "hatchet_mp": //Allows Tomahawk Damage
             return true;
        default:
             return false;        
    }
}  

ProneWeaps( weapon ) {
    weapon_class = getweaponclass( weapon );
    if ( weapon_class == "weapon_sniper" || isSubStr( weapon , "sa58_" ) ) //Allows all snipers and FAL damage
        return true;
}

ShockCheck( weapon ) {
    weapon_class = getweaponclass( weapon );
    if ( isSubStr( weapon , "proximity_" ) ) 
        return true;
}