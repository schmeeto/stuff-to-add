/*
	File: fn_processMultiAction.sqf
	Author: Steven for WolfPack server
	
	Description:
	Handling for processing multiple items.
*/
private["_vendor","_itemInfo","_ingredients","_newItem","_cost","_upp","_hasLicense","_itemName","_oldVals","_minVal","_ui","_progress","_pgText","_cP","_speed"];
_vendor = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_itemInfo = [_this,1,ObjNull,[ObjNull,[]]] call BIS_fnc_param;
_ingredients = [_this,2,ObjNull,[ObjNull,[]]] call BIS_fnc_param;

//Error checking
if(isNull _vendor OR (player distance _vendor > 10)) exitWith {};
if(count _itemInfo == 0) exitWith {};
if(count _ingredients == 0) exitWith {};

//Setup vars.
_newItem = _itemInfo select 1;
_cost = _itemInfo select 2;
_upp = _itemInfo select 3;
_neededLicense = _itemInfo select 4;
_hasLicense = missionNamespace getVariable (([_neededLicense,0] call life_fnc_licenseType) select 0);
_itemName = [([_newItem,0] call life_fnc_varHandle)] call life_fnc_varToStr;

//Setup ingredients
_minVal = 999;
_oldVals = 0;

{
	_oldVals =  missionNamespace getVariable ([_x,0] call life_fnc_varHandle);
	if(_oldVals < _minVal) then {_minVal = _oldVals;};

} foreach _ingredients;

//set total cost for non-license
_cost = _cost * _minVal;

//Some more checks
if(_minVal == 0) exitWith {};

//Setup our progress bar
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

life_is_processing = true;

//set process speed according to license
if(_hasLicense) then
{
	_speed = 0.3;
}
else
{
	_speed = 0.9;
	if(life_cash < _cost) exitWith {hint format["You need $%1 to process without a license!",[_cost] call life_fnc_numberText]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
};

//security check
if(player distance _vendor > 10) exitWith {hint "You need to stay within 10m to process."; 5 cutText ["","PLAIN"]; life_is_processing = false;};

//do progress simulation
while{true} do
{
	sleep  _speed;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(player distance _vendor > 10) exitWith {};
};

//security checks
//if(life_cash < _cost) exitWith {hint format["You need $%1 to process without a license!",[_cost] call life_fnc_numberText]; 5 cutText ["","PLAIN"]; life_is_processing = false;};	
if(player distance _vendor > 10) exitWith {hint "You need to stay within 10m to process."; 5 cutText ["","PLAIN"]; life_is_processing = false;};

//get all the ingredients
{
	if(!([false,_x,_minVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; life_is_processing = false;};

}foreach _ingredients;
//give processed items
if(!([true,_newItem,_minVal] call life_fnc_handleInv)) exitWith 
{
	5 cutText ["","PLAIN"];
	//give back all the ingredients
	{
		[true,_x,_minVal] call life_fnc_handleInv;
	}foreach _ingredients;
	life_is_processing = false;
};

//Finishing Message
5 cutText ["","PLAIN"];
if(_hasLicense) then
{
	titleText[format["You have processed %1 into %2",_minVal,_itemName],"PLAIN"];
}
	else
{
	titleText[format["You have processed %1 into %2 for $%3",_minVal,_itemName,[_cost] call life_fnc_numberText],"PLAIN"];
	life_cash = life_cash - _cost;
};
life_is_processing = false;


