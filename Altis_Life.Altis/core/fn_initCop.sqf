    #include <macro.h>
    /*
    File: fn_initCop.sqf
    Author: Bryan "Tonic" Boardwine & [LLN]_Fuzz
    Traductions/Corrections: [LLN]team
    Description:
    Cop Initialization file.
    */
    player addRating 9999999;
    waitUntil {!(isNull (findDisplay 46))};
    [] spawn life_fnc_copMarkers;
     
    if(life_blacklisted) exitWith
    {
    ["Blacklisted",false,true] call BIS_fnc_endMission;
    sleep 30;
    };
     
    if(!(str(player) in ["cop_99"])) then {
    if((__GETC__(life_coplevel) == 0) && (__GETC__(life_adminlevel) == 0)) then {
    ["NotWhitelisted",false,true] call BIS_fnc_endMission;
    sleep 35;
    };
    };
     
    [] call life_fnc_spawnMenu;
    waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
    waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
    titleText ["", "BLACK FADED", 9];
    titleText ["Serveur LLN v3.1.2 (+18)", "BLACK IN", 6];
    [] execVM "msgbienvenue.sqf";
     
    private["_getRank"];
    _getRank = switch (__GETC__(life_coplevel)) do {case 1: {1}; case 2: {2}; case 3: {3}; case 4: {4}; case 5: {5}; case 6: {6}; case 7: {7}; default {0};};
    player setVariable["coplevel",_getRank,TRUE];
     