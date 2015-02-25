#define MACRO_NTA_VEHICLELOCK \
  class NTA_Unlock { \
    displayName = "$STR_NTA_unlock"; \
    distance = 4; \
    conditionShow = "AGM_Interaction_Target getVariable ['locked', false]"; \
    condition = "AGM_Interaction_Target getVariable ['locked', false] && {alive AGM_Interaction_Target} && {[AGM_Interaction_Target] call NTA_fnc_BWplus_checkVehicleRights} && {[AGM_Interaction_Target] call NTA_fnc_core_checkVehicleRights}"; \
    statement = "[AGM_Interaction_Target] call NTA_fnc_vehicles_unlock"; \
    priority = 3; \
    Icon = "pics\NTA_Logo_G.paa"; \
    hotkey = "L"; \
  }; \
  class NTA_Lock { \
    displayName = "$STR_NTA_lock"; \
    distance = 4; \
    condition = "!(AGM_Interaction_Target getVariable ['locked', false]) && {[AGM_Interaction_Target] call NTA_fnc_BWplus_checkVehicleRights} && {[AGM_Interaction_Target] call NTA_fnc_core_checkVehicleRights}"; \
    conditionShow = "!(AGM_Interaction_Target getVariable ['locked', false]) && {count crew AGM_Interaction_Target == 0}"; \
    statement = "[AGM_Interaction_Target] call NTA_fnc_vehicles_lock"; \
    priority = 3; \
    enableInside = 1; \
    Icon = "pics\NTA_Logo_G.paa"; \
    hotkey = "L"; \
  };