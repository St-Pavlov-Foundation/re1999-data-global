module("modules.logic.scene.survival.comp.SurvivalSceneLevel", package.seeall)

local var_0_0 = class("SurvivalSceneLevel", SurvivalShelterSceneLevel)

function var_0_0.getLightName(arg_1_0)
	local var_1_0 = SurvivalMapModel.instance:getCurMapId()
	local var_1_1 = lua_survival_map_group_mapping.configDict[var_1_0].id
	local var_1_2 = SurvivalConfig.instance:getCopyCo(var_1_1)

	return var_1_2 and "light" .. var_1_2.lightPram
end

return var_0_0
