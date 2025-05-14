module("modules.logic.scene.fight.comp.FightSceneSpineMat", package.seeall)

local var_0_0 = class("FightSceneSpineMat", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_setLevelCO(arg_1_2)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
	arg_2_0:_setAllSpineColor()
end

function var_0_0.onSceneClose(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	arg_3_0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)

	arg_3_0._spineColor = nil
end

function var_0_0._onSpineLoaded(arg_4_0, arg_4_1)
	if arg_4_0._spineColor and arg_4_1 then
		local var_4_0 = arg_4_1.unitSpawn.spineRenderer:getReplaceMat()

		MaterialUtil.setMainColor(var_4_0, arg_4_0._spineColor)
	end
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	arg_5_0:_setLevelCO(arg_5_1)
	arg_5_0:_setAllSpineColor()
end

function var_0_0._setLevelCO(arg_6_0, arg_6_1)
	arg_6_0._spineColor = nil

	local var_6_0 = lua_scene_level.configDict[arg_6_1]

	if var_6_0.spineR ~= 0 or var_6_0.spineG ~= 0 or var_6_0.spineB ~= 0 then
		arg_6_0._spineColor = Color.New(var_6_0.spineR, var_6_0.spineG, var_6_0.spineB, 1)
	end
end

function var_0_0._setAllSpineColor(arg_7_0)
	if not arg_7_0._spineColor then
		return
	end

	local var_7_0 = FightHelper.getAllEntitysContainUnitNpc()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.spineRenderer then
			local var_7_1 = iter_7_1.spineRenderer:getReplaceMat()

			MaterialUtil.setMainColor(var_7_1, arg_7_0._spineColor)
		end
	end
end

return var_0_0
