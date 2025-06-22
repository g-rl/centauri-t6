#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_utils;
#include scripts\mp\menu\_menuutils;
#include scripts\mp\_functions;
#include scripts\mp\_damage;
#include scripts\mp\_binds;
#include scripts\mp\_aimbot;
#include scripts\mp\_sliders;
#include scripts\mp\_bolt;

Structure() {

    // AddSlider(menu, text, func, pers, min, max, amount)
    // AddDvarSlider(menu, text, func, dvar, min, max, amount)

    self CreateMenu("Centauri", "exit");
    self AddOption("Centauri", "Preference", ::LoadMenu, undefined, "Preference");
    self AddOption("Centauri", "Binds", ::LoadMenu, undefined, "Binds");
    self AddOption("Centauri", "Game", ::LoadMenu, undefined, "Game");
    self AddOption("Centauri", "Aimbot", ::LoadMenu, undefined, "Aimbot");
    self AddOption("Centauri", "Position", ::LoadMenu, undefined, "Position");
    self AddOption("Centauri", "Robotics", ::LoadMenu, undefined, "Robotics");

    self CreateMenu("Preference", "Centauri");
    self AddArraySlider("Preference", "Drop Canswap", ::CanswapSlider, List("SMG,AR,LMG,Shotgun,Sniper,Pistol,Misc"), "canswap_slider");
    self AddArraySlider("Preference", "Resources", ::ResourceSlider, List("Infinite Ammo,Infinite Equipment"), "resource_slider");
    self AddArraySlider("Preference", "Streaks", ::StreakSlider, List("All Streaks,Predator Missile,Care Package,Orbital VSAT,Sentry Gun,RCXD,Hunter Killer"), "streak_slider");
    self AddUniqueIntDvarSlider("Preference", "Prestige", ::NewPrestige, "prestige", 0, 16, 1);
    self AddUniqueBoolDvarSlider("Preference", "Auto Reload", ::AutoReloading, "func_autoreload", 0, 1, 1);
    self AddArraySlider("Preference", "Damage Amount (Bind)", ::DamageSlider, List("10,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100"), "damage_slider");
    self AddArraySlider("Preference", "Medal Type (Bind)", ::MedalSlider, List("Nuclear,Relentless,Merciless,Ruthless,Killer Planter,Killed Defuser,Savior"), "medal_slider");
    self AddUniqueBoolDvarSlider("Preference", "No Clipping", ::ToggleNoClipping, "func_noclip", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Fake Elevators", ::ToggleElevator, "func_elevator", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Projectile Riding", ::ToggleRideables, "func_rideables", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Always Canswap", ::ToggleAlwaysCanswap, "func_alwayscanswap", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Mid Air Prone", ::ToggleMidAirProne, "func_midprone", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Auto Prone", ::ToggleAutoProne, "func_autoprone", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Instashoots", ::ToggleInstashoots, "func_instashoots", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Instant Respawn", ::ToggleInstantRespawns, "func_instantrespawn", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Toggle Hud", ::ToggleHud, "func_hud", 0, 1, 1);
    self AddOption("Preference", "Cowboy", ::GiveCowboy);
    self AddUniqueBoolDvarSlider("Preference", "Constant UAV", ::ToggleUAV, "func_uav", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Fake Sweep", ::ToggleFakeSweep, "func_fakesweep", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Exo Suits", ::ExoSuits, "func_exosuits", 0, 1, 1);
    //self AddUniqueBoolDvarSlider("Preference", "Hatchet Nades", ::ToggleHatchetNades, "func_hatchetnades", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Preference", "Move After", ::MW2Endgame, "func_mw2", 0, 1, 1);
    //self AddArraySlider("Preference", "Move Time", ::MoveSlider, List("Always,0.25,0.5,0.75,1"), "move_slider");
    self AddOption("Preference", "Blowjob", ::BlowjobFunc);
    self AddOption("Preference", "Unstuck", ::Unstuck);
    self AddOption("Preference", "Test Softlands", ::SoftLanding);

    self CreateMenu("Binds", "Centauri");
    self AddOption("Binds", "Change Class", ::LoadMenu, undefined, "Change Class");
    self AddOption("Binds", "Velocity", ::LoadMenu, undefined, "Velocity");
    self AddOption("Binds", "Bolt Movement", ::LoadMenu, undefined, "Bolt Movement");
    self AddOption("Binds", "OMA", ::LoadMenu, undefined, "OMA");
    self AddBindSliders("Binds", "Nac", ::NacBind, "nac_bind");
    self AddBindSliders("Binds", "One Bullet", ::OneBulletBind, "one_bullet_bind");
    self AddBindSliders("Binds", "One Bullet Out", ::OneBulletOutBind, "one_bullet_out_bind");
    self AddBindSliders("Binds", "Empty Clip", ::EmptyClipBind, "empty_clip_bind");
    self AddBindSliders("Binds", "Canzoom", ::CanzoomBind, "canzoom_bind");
    self AddBindSliders("Binds", "RPG Bullets", ::RpgBind, "rpg_bind");
    self AddBindSliders("Binds", "Damage", ::DamageBind, "damage_bind");
    self AddBindSliders("Binds", "Damage Repeater", ::DamageRepeaterBind, "damage_repeater_bind");
    self AddBindSliders("Binds", "Bounce", ::BounceBind, "bounce_bind");
    self AddBindSliders("Binds", "Illusion Reload", ::IllusionBind, "illusion_bind");
    self AddBindSliders("Binds", "Canswap", ::CanswapBind, "canswap_bind");
    self AddBindSliders("Binds", "Reverse Elevator", ::ReverseEleBind, "reverse_ele_bind");
    self AddBindSliders("Binds", "Wallbreach", ::WallbreachBind, "wallbreach_bind");
    self AddBindSliders("Binds", "Fade to Black", ::BlackscreenBind, "blackscreen_bind");
    self AddBindSliders("Binds", "Real Gflip", ::GflipBind, "gflip_bind");
    self AddBindSliders("Binds", "Thermal Gun", ::ThermalBind, "thermal_gun_bind");
    self AddBindSliders("Binds", "Host Migration", ::HostBind, "host_bind");
    self AddBindSliders("Binds", "Scavenger", ::ScavengerBind, "scavenger_bind");
    self AddBindSliders("Binds", "Flashbang", ::FlashBind, "flash_bind");
    self AddBindSliders("Binds", "EMP", ::EmpBind, "emp_bind");
    self AddBindSliders("Binds", "Medals", ::MedalBind, "medal_bind");
    self AddBindSliders("Binds", "Hitmarker", ::HitmarkerBind, "hitmarker_bind");
    self AddBindSliders("Binds", "Rapid Fire", ::RapidFireBind, "rapidfire_bind");
    self AddBindSliders("Binds", "Plant Bomb", ::PlantBind, "plant_bind");
    self AddBindSliders("Binds", "Disco Camo", ::DiscoBind, "disco_bind");

    self CreateMenu("Change Class", "Binds");
    self AddOption("Change Class", "On Class Change", ::LoadMenu, undefined, "Classes");
    self AddBindSliders("Change Class", "Change Class [^23^7]", ::ChangeClassBind, "change_class_bind");
    self AddBindSliders("Change Class", "Change Class [^65^7]", ::ChangeClass5Bind, "change_class_5_bind");

    self CreateMenu("Classes", "Change Class");
    self AddUniqueBoolDvarSlider("Classes", "Canswap", ::ToggleClassCanswap, "func_ccanswap", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Classes", "Canzoom", ::ToggleClassCanzoom, "func_ccanzoom", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Classes", "Illusion", ::ToggleClassIllusion, "func_iilusion", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Classes", "Empty Clip", ::ToggleClassEmpty, "func_emptyclip", 0, 1, 1);
    self AddUniqueBoolDvarSlider("Classes", "One Bullet", ::ToggleClassOneBullet, "func_onebullet", 0, 1, 1);

    self CreateMenu("Velocity", "Binds");
    self AddVelocity("Velocity", "Current Velocity");
    self AddBindSliders("Velocity", "Velocity", ::VelocityBind, "velocity_bind");
    self AddArraySlider("Velocity", "Multiply Velocity", ::MultiplySlider, List("2,3,4"), "multiply_slider");
    self AddArraySlider("Velocity", "Divide Velocity", ::DivideSlider, List("2,3,4"), "divide_slider");
    self AddOption("Velocity", "Play Velocity", ::PlayVelocity);
    self AddOption("Velocity", "Track Velocity", ::TrackVelocity);
    self AddOption("Velocity", "Reset Velocity", ::ResetVelocity);
    self AddOption("Velocity", "Edit X", ::LoadMenu, undefined, "Edit X");
    self AddOption("Velocity", "Edit Y", ::LoadMenu, undefined, "Edit Y");
    self AddOption("Velocity", "Edit Z", ::LoadMenu, undefined, "Edit Z");

    self CreateMenu("Bolt Movement", "Binds");
    self AddBolt("Bolt Movement", "Current Speed / Points");
    self AddBindSliders("Bolt Movement", "Bolt Movement", ::BoltBind, "bolt_bind");
    self AddArraySlider("Bolt Movement", "Save Point", ::BoltSlider, List("1,2,3,4,5"), "bolt_save_slider");
    self AddArraySlider("Bolt Movement", "Delete Point", ::BoltDeleteSlider, List("1,2,3,4,5"), "bolt_delete_slider");
    self AddArraySlider("Bolt Movement", "Bolt Speed", ::BoltSpeedSlider, List("1,1.25,1.5,1.75,2,2.25,2.50,2.75,3,3.25,3.50,3.75,4"), "bolt_speed_slider");
    self AddOption("Bolt Movement", "Record Points", ::RecordBolt);
    self AddOption("Bolt Movement", "Stop Recording", ::StopRecording);
    self AddOption("Bolt Movement", "Play Bolt", ::StartBolt);

    self CreateMenu("Edit X", "Velocity");
    self AddVelocity("Edit X", "Current Velocity");
    self AddArraySlider("Edit X", "Add Velocity", ::AddVelocitySliderX, List("10,25,50,100,150"), "add_velocity_slider_x");
    self AddArraySlider("Edit X", "Remove Velocity", ::RemoveVelocitySliderX, List("-10,-25,-50,-100,-150"), "remove_velocity_slider_x");
    self AddOption("Edit X", "Reset X", ::EditVelocity, undefined, "x", 0);
    
    self CreateMenu("Edit Y", "Velocity");
    self AddVelocity("Edit Y", "Current Velocity");
    self AddArraySlider("Edit Y", "Add Velocity", ::AddVelocitySliderY, List("10,25,50,100,150"), "add_velocity_slider_y");
    self AddArraySlider("Edit Y", "Remove Velocity", ::RemoveVelocitySliderY, List("-10,-25,-50,-100,-150"), "remove_velocity_slider_y");
    self AddOption("Edit Y", "Reset Y", ::EditVelocity, undefined, "y", 0);

    self CreateMenu("Edit Z", "Velocity");
    self AddVelocity("Edit Z", "Current Velocity");
    self AddArraySlider("Edit Z", "Add Velocity", ::AddVelocitySliderZ, List("10,25,50,100,150"), "add_velocity_slider_z");
    self AddArraySlider("Edit Z", "Remove Velocity", ::RemoveVelocitySliderZ, List("-10,-25,-50,-100,-150"), "remove_velocity_slider_z");
    self AddOption("Edit Z", "Reset Z", ::EditVelocity, undefined, "z", 0);

    self CreateMenu("OMA", "Binds");
    self AddBindSliders("OMA", "OMA [^6Single^7]", ::OmaBind, "omasingle_bind");  
    self AddBindSliders("OMA", "OMA [^2Double^7]", ::Oma2Bind, "omadouble_bind");  
    self AddBindSliders("OMA", "OMA [^5Triple^7]", ::Oma3Bind, "omatriple_bind");  

    self CreateMenu("Game", "Centauri");
    self AddOption("Game", "Dvars", ::LoadMenu, undefined, "Dvars");
    self CreateMenu("Dvars", "Game");
    // AddBoolDvarSlider(menu, text, func, dvar, min, max, amount) {
    self AddBoolDvarSlider("Dvars", "Melee Range", ::LungeFunc, "func_lunges", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Bounces", ::ToggleBounces, "func_bounces", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Ladder Spins", ::LadderSpins, "func_ladderspins", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Prone Spins", ::ProneSpins, "func_pronespins", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Jump Slowdown", ::JumpSlowdown, "func_jumpslowdowns", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Ladder Jumps", ::LadderJumps, "func_ladderjumps", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Increased Throwbacks", ::ThrowbackRadius, "func_throwbacks", 0, 1, 1);
    self AddBoolDvarSlider("Dvars", "Increased Pickups", ::PickupRadius, "func_pickups", 0, 1, 1);
    
    self AddOption("Game", "Reset Rounds", ::ResetRounds);
    self AddArraySlider("Game", "Bomb", ::BombSlider, List("Plant,Defuse"), "bomb_slider");
    self AddArraySlider("Game", "Timer", ::TimerSlider, List("Remove Timer,Add Minute,Remove Minute"), "timer_slider");
    self AddArraySlider("Game", "Spawnables", ::SpawnableSlider, List("Delete All,Repeater Crate"), "spawnable_slider");
    self AddArraySlider("Game", "Gravity", ::GravitySlider, List("800,750,700,650,600,500,550"), "gravity_slider");
    self AddArraySlider("Game", "Killcam Time", ::KillcamTimeSlider, List("4,4.5,5,6,7,8,9"), "killcam_time_slider");
    self AddArraySlider("Game", "Timescale", ::TimescaleSlider, List("1,0.75,0.50,0.25"), "timescale_slider");
    self AddArraySlider("Game", "Killcam Timescale", ::KillcamSlider, List("Game End,Killcam Start"), "killcam_slider");
    self AddOption("Game", "Switch Team", ::ChangeTeam);
    self AddMap("Game", "Map ID");

    self CreateMenu("Aimbot", "Centauri");
    self AddUniqueBoolDvarSlider("Aimbot", "Aimbot", ::ToggleAimbot, "func_aimbot", 0, 1, 1);
    self AddUniqueWeaponDvarSlider("Aimbot", "Aimbot Weapon", ::AimbotWeapon, "func_aimbotweapon", 0, 1, 1);
    self AddUniqueWeaponDvarSlider("Aimbot", "Second Aimbot Weapon", ::AimbotWeapon2, "func_aimbotweapon2", 0, 1, 1);
    self AddArraySlider("Aimbot", "Aimbot Range", ::AimbotRangeSlider, List("^1Disable^7,400,500,650,750,900,1000,1500,2000,2500,3000,4500,10000"), "aimbot_range_slider");
    self AddArraySlider("Aimbot", "Aimbot Delay", ::AimbotDelaySlider, List("^1Disable^7,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1"), "aimbot_delay_slider");
    self AddUniqueBoolDvarSlider("Aimbot", "Hitmarker Aimbot", ::ToggleHMAimbot, "func_hmaimbot", 0, 1, 1);
    self AddUniqueWeaponDvarSlider("Aimbot", "HM Aimbot Weapon", ::HMAimbotWeapon, "func_hmaimbotweapon", 0, 1, 1);

    self CreateMenu("Position", "Centauri");
    self AddUniqueDvarIntSlider("Position", "Savepoint", ::SavepointSlider, "func_savepoint", 1, 5, 1);
    self AddUniqueDvarIntSlider("Position", "Spawn Savepoint", ::SpawnSavePointSlider, "func_spawnsavepoint", 1, 5, 1);
    self AddBindSliders("Position", "Load Position Bind", ::LoadPosBind, "load_pos_bind");
    self AddOption("Position", "Save Position", ::SavePositions);
    self AddOption("Position", "Load Position", ::LoadPositions);   

    self CreateMenu("Robotics", "Centauri");
    self AddArraySlider("Robotics", "Teleport", ::BotTeleportSlider, List("Setup All,Setup Enemies,Setup Friendly,Friendly Path Migration,Enemy Path Migration,Moving Enemy,Moving Friendly"), "teleport_slider");
    self AddArraySlider("Robotics", "Spawn", ::BotSpawnSlider, List("Enemy,Friendly"), "botspawn_slider");
    self AddArraySlider("Robotics", "Respawn", ::RespawnSlider, List("Enemies,Friendly"), "respawn_slider");
    self AddArraySlider("Robotics", "Kick", ::BotKickSlider, List("Enemies,Friendlies"), "botkick_slider");
    self AddArraySlider("Robotics", "Direction", ::LookingSlider, List("Face Once,Always Looking,Stop Looking"), "looking_slider");
    self AddBoolDvarSlider("Robotics", "Unlimited Lives", ::ToggleBotLives, "func_botlives", 0, 1, 1);
    self AddBoolDvarSlider("Robotics", "Instant Respawns", ::ToggleBotInstantRespawns, "func_instantrespawn", 0, 1, 1);
}