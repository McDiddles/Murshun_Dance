murshun_danceanimationsArray = ["murshun_ActsPercMstpSnonWnonDnon_DancingStefan", "murshun_ActsPercMstpSnonWnonDnon_DancingDuoStefan", "murshun_ActsPercMstpSnonWnonDnon_DancingDuoIvan"];

murshun_danceInProgress = false;

if (isNil "murshun_dance_canDance") then {
	if (isMultiplayer) then {
		murshun_dance_canDance = false;
	} else {
		murshun_dance_canDance = true;
	};
};

murshun_dance_fnc = {
	_unit = _this select 0;

	if ((local _unit) && !(isPlayer _unit)) exitWith {
		[_unit] spawn murshun_dance_AI_fnc;
	};

	_animation = murshun_danceanimationsArray call BIS_fnc_selectRandom;

	[[_unit, _animation], "switchMove"] call BIS_fnc_MP;
	[[_unit, _animation], "playMoveNow"] call BIS_fnc_MP;
	
	murshun_danceInProgress = true;
	
		if (_animation == "murshun_ActsPercMstpSnonWnonDnon_DancingStefan") then {
		sleep 36.1;
		};
		
		if (_animation == "murshun_ActsPercMstpSnonWnonDnon_DancingDuoStefan") then {
		sleep 40;
		};
		
		if (_animation == "murshun_ActsPercMstpSnonWnonDnon_DancingDuoIvan") then {
		sleep 40;
		};

	murshun_danceInProgress = false;
	
	[[_unit, ""], "switchMove"] call BIS_fnc_MP;
	
};

murshun_dance_AI_fnc = {
	_unit = _this select 0;

	_animation = murshun_danceanimationsArray call BIS_fnc_selectRandom;

	[[_unit, _animation], "switchMove"] call BIS_fnc_MP;
	[[_unit, _animation], "playMoveNow"] call BIS_fnc_MP;
};

_action = ["murshun_dance", "Start Dancing!", "murshun_dance\dance.paa", {[player] spawn murshun_dance_fnc}, {player == vehicle player && murshun_dance_canDance && !murshun_danceInProgress && alive player && ((player getVariable ["ace_sitting_isSitting", false]) isEqualTo false)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
