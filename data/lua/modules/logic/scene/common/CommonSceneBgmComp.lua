module("modules.logic.scene.common.CommonSceneBgmComp", package.seeall)

local var_0_0 = class("CommonSceneBgmComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._sceneLevelCO = lua_scene_level.configDict[arg_2_2]

	if arg_2_0._sceneLevelCO and arg_2_0._sceneLevelCO.bgmId and arg_2_0._sceneLevelCO.bgmId > 0 then
		AudioMgr.instance:trigger(arg_2_0._sceneLevelCO.bgmId)
	end
end

function var_0_0.onSceneClose(arg_3_0)
	return
end

return var_0_0
