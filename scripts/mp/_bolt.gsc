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
#include scripts\mp\_sliders;

BoltSpeed(var) {
    x = GetUniqueDvarFloat("bolttime");
    SetUniqueDvar("bolttime",x);
}

BoltSpeedSlider(value) {
    v = float(value);
    SetUniqueDvar("bolttime",v);
}

StopRecording() {
    if(isDefined(self.recording))
    {
    self notify("stopit");
    self iprintlnbold("Stopped recording points..");
    self freezecontrols(0);
    } else {
        self iprintlnbold("You aren't recording any points..");
    }

}

RecordBolt() {
    SetUniqueDvar("func_boltcount",0);
    SetUniqueDvar("bolttime",0);
    self.recording = true;
    self iPrintLnBold("Recording in [^33^7] seconds");
    wait 1;
    self iPrintLnBold("Recording in [^22^7] seconds");
    wait 1;
    self iPrintLnBold("Recording in [^11^7] seconds");
    wait 1;
    self endon("stopit");
    for(;;)
    {
        self endon("stopit");   
        self freezecontrols(1);
        self thread SpawnSafeBox();
        self savebolt();
        z = GetUniqueDvarFloat("bolttime");
        z += 0.1;
        SetUniqueDvar("bolttime",z);
        self freezecontrols(0);
        self iPrintLnBold("Recording in [^35^7] seconds");
        wait 1;
        self iPrintLnBold("Recording in [^34^7] seconds");
        wait 1;
        self iPrintLnBold("Recording in [^23^7] seconds");
        wait 1;
        self iPrintLnBold("Recording in [^22^7] seconds");
        wait 1;
        self iPrintLnBold("Recording in [^11^7] seconds");
        wait 1;
    }
}


SpawnSafeBox() {
    self thread SpawnBox();
    self freezecontrols(1);
    self setorigin(self.lastorigin);
    self setplayerangles(self.lastangle);
    wait 0.5;
    self freezecontrols(0);
}

StartBolt() {
    self endon("boltended");
    x = GetUniqueDvarInt("func_boltcount");
    if(x == 0) { self iPrintLnBold("^1ERROR: No Bolt Points"); return; }
    dabolt = spawn("script_model", self.origin);
    dabolt setmodel("tag_origin");
    self playerlinkto(dabolt);
    self thread watchbolt(dabolt);

    for(i = 1 ; i < x + 1 ; i++)
    {
        dabolt moveTo((GetUniqueDvarFloat("func_boltpos_x" + i),GetUniqueDvarFloat("func_boltpos_z" + i),GetUniqueDvarFloat("func_boltpos_y" + i)),GetUniqueDvarFloat("bolttime") / GetUniqueDvarFloat("func_boltcount"),0,0);
        wait(GetUniqueDvarFloat("bolttime") / GetUniqueDvarInt("func_boltcount"));
    }
    self unlink();
    dabolt delete();
}

WatchBolt(dabolt) {
    self waittill("+gostand");
    self unlink();
    dabolt delete();
    wait 0.05;
    self notify("boltended");
}

SaveBolt()
{
    x = GetUniqueDvarInt("func_boltcount");
    x += 1;
    SetUniqueDvar("func_boltcount",x);
    SetUniqueDvar("func_boltpos_x" + x,self.origin[0]);
    SetUniqueDvar("func_boltpos_z" + x,self.origin[1]);
    SetUniqueDvar("func_boltpos_y" + x,self.origin[2]);
    self iPrintLnBold("[^3" + x + "^7] Bolt Point Saved");
}