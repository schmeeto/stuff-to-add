/*
	File: fn_rotateObj.sqf
	Author: Steven
	
	Description:
	Rotates object
*/
private ["_obj","_up","_dir","_angle","_vecdx","_vecdy","_vecdz"];
_obj = _this select 0;
_up = _this select 1;
_dir = _this select 2;
_angle = _this select 3;


_vecdx = sin(_dir) * cos(_angle);
_vecdy = cos(_dir) * cos(_angle);
_vecdz = sin(_angle);

//_vecux = cos(_dir) * cos(_angle) * sin(_pitch);
//_vecuy = sin(_dir) * cos(_angle) * sin(_pitch);
//_vecuz = cos(_angle) * cos(_pitch);

_obj setVectorDirAndUp [ [_vecdx,_vecdy,_vecdz], _up ];
