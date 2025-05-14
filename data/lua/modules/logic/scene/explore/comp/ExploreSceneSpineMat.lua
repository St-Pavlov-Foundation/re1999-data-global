module("modules.logic.scene.explore.comp.ExploreSceneSpineMat", package.seeall)

local var_0_0 = class("ExploreSceneSpineMat", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_setLevelCO(arg_1_2)
	ExploreController.instance:registerCallback(ExploreEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onSceneClose(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)

	arg_3_0._spineColor = nil
end

function var_0_0._onSpineLoaded(arg_4_0, arg_4_1)
	if arg_4_0._spineColor and arg_4_1 then
		local var_4_0 = arg_4_1.unitSpawn.spineRenderer:getReplaceMat()

		MaterialUtil.setMainColor(var_4_0, arg_4_0._spineColor)
	end
end

function var_0_0._setLevelCO(arg_5_0, arg_5_1)
	arg_5_0._spineColor = nil

	local var_5_0 = lua_scene_level.configDict[arg_5_1]

	if var_5_0.spineR ~= 0 or var_5_0.spineG ~= 0 or var_5_0.spineB ~= 0 then
		arg_5_0._spineColor = Color.New(var_5_0.spineR, var_5_0.spineG, var_5_0.spineB, 1)
	end
end

return var_0_0
