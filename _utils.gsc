#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\mp\_functions;
#include scripts\mp\menu\_overflow;
#include scripts\mp\_binds;
#include scripts\mp\_damage;
#include scripts\mp\_aimbot;

PlaceHolder() {
    self iprintlnbold("broken");
}

InArray(a, check) {
	if( IsInArray(a, check))
        return true;
}

SetPers(key, value) {
    self.pers[key] = value;
}

GetPers(key) {
    return self.pers[key];
}

SetPersIfUni(key, value) {
    if(!isdefined(self.pers[key])) {
        self.pers[key] = value;
    }
}

SetDvarIfUni(dvar, value) {
    if(!isdefined(GetDvar(dvar)) || GetDvar(dvar) == "") {
        SetDvar(dvar, value);
    }
}

SetUniqueDvarIfUni(dvar, value) {
    if(!isdefined(GetUniqueDvar(dvar)) || GetUniqueDvar(dvar) == "") {
        SetUniqueDvar(dvar, value);
    }
}

SetUniqueDvar(dvar, value) {
        y = PlayerName() + "_";
        SetDvar(y + dvar, value);
}

GetUniqueDvar(dvar) {
    y = PlayerName() + "_";
    i = getDvar(y + dvar);
    return i;
}

GetUniqueDvarFloat(dvar) {
    y = PlayerName() + "_";
    i = getDvarFloat(y + dvar);
    return i;
}

GetUniqueDvarInt(dvar) {
    y = PlayerName() + "_";
    i = getDvarInt(y + dvar);
    return i;
}

RandomColor() {
    ran = "^2";
    return ran;
}

BoolText(bool) {
    if(bool)
        return "^2ON^7";
    else
        return "^1OFF^7";
}

Group(key) {
    output = StrTok(key, " ");
    return output;
}

List(key) {
    output = StrTok(key, ",");
    return output;
}

SetupBind(pers, value, func) {
    self SetPersIfUni(pers, value);

    if(self GetPers(pers) != "^1OFF^7") {
        self thread [[func]](self GetPers(pers), pers);
    }
}

CreateText(font, fontscale, align, relative, x, y, color, sort, alpha, text) {
    textElem = CreateFontString(font, fontscale);
    textElem SetPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.type = "text";
    textElem SetSafeText(text);
    textElem.color = color;
    textElem.alpha = alpha;
    textElem.hideWhenInMenu = true;
    textElem.foreground = true;
    textElem.archived = true;
    textElem.type = "text";
    textElem SetSafeText(text);
    return textElem;
}

CreateRectangle(shader, align, relative, x, y, width, height, color, sort, alpha) {
    barElem = NewClientHudElem(self);
    barElem.elemType = "icon";
    if ( !level.splitScreen )
    {
        barElem.x = -2;
        barElem.y = -2;
    }
    barElem.width = width;
    barElem.height = height;
    barElem.align = align;
    barElem.relative = relative;
    barElem.xOffset = 0;
    barElem.yOffset = 0;
    barElem.children = [];
    barElem.color = color;
    if(isdefined(alpha))
        barElem.alpha = alpha;
    else
        barElem.alpha = 1;
    barElem SetShader(shader, width , height);
    barElem.hidden = false;
    barElem.sort = sort;
    barElem SetPoint(align,relative,x,y);
    barElem.foreground = true;
    barElem.archived = false;
    return barElem;
}

PlayerName() {
    name = getSubStr(self.name, 0, self.name.size);
    for(i = 0; i < name.size; i++)
    {
        if(name[i]==" " || name[i]=="]")
        {
            name = getSubStr(name, i + 1, name.size);
        }
    }
    if(name.size != i)
        name = getSubStr(name, i + 1, name.size);
    
    return name;
}

EndFrame() {
    wait 0.05;
}

Randomize(a) {
	r = strTok(a, ",");
	random = RandomInt(r.size);
	final = r[random];
	return final;
}

RandomizeWeapon(a) {
	r = strTok(a, ",");
	random = RandomInt(r.size);
	final = r[random] + "_mp";
	return final;
}

RandomizeAtt(a) {
	r = strTok(a, ",");
	random = RandomInt(r.size);
	final = "+"+r[random];
	return final;
}

Frame() {
    waittillframeend;
}

Waiting() {
    wait 0.05;
}

drawtexthm( text, font, fontscale, align, relative, x, y, color, alpha, sort )
{
    hud = self createfontstring( font, fontscale );
    hud settext( text );
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.foreground = 1;
    hud setpoint( align, relative, x, y );
    return hud;

}

createrectanglehm( align, relative, x, y, width, height, color, shader, sort, alpha )
{
    hud = newclienthudelem( self );
    hud.elemtype = "bar";
    hud.foreground = 1;
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setparent( level.uiparent );
    hud setshader( shader, width, height );
    hud setpoint( align, relative, x, y );
    return hud;
}

fadeToBlack( startwait, blackscreenwait, fadeintime, fadeouttime )
{
    wait( startwait );
    if( !isdefined(self.blackscreen) )
    self.blackscreen = newclienthudelem( self );

    self.blackscreen.x = 0;
    self.blackscreen.y = 0; 
    self.blackscreen.horzAlign = "fullscreen";
    self.blackscreen.vertAlign = "fullscreen";
    self.blackscreen.foreground = false;
    self.blackscreen.hidewhendead = false;
    self.blackscreen.hidewheninmenu = true;

    self.blackscreen.sort = 50; 
    self.blackscreen SetShader( "black", 640, 480 ); 
    self.blackscreen.alpha = 0; 
    if( fadeintime>0 )
    self.blackscreen FadeOverTime( fadeintime ); 
    self.blackscreen.alpha = 1;
    wait( fadeintime );
    if( !isdefined(self.blackscreen) )
        return;

    wait( blackscreenwait );
    if( !isdefined(self.blackscreen) )
        return;

    if( fadeouttime>0 )
    self.blackscreen FadeOverTime( fadeouttime ); 
    self.blackscreen.alpha = 0; 
    wait( fadeouttime );

    if( isdefined(self.blackscreen) )           
    {
        self.blackscreen destroy();
        self.blackscreen = undefined;
    }
}

Centauri()
{
    level.Centauri = []; 
    level.Centauri["last_update"] = "August, 10th, 2024";
    level.Centauri["version"] = "0.1.2";
}