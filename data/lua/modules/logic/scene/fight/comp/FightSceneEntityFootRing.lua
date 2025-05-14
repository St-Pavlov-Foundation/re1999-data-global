module("modules.logic.scene.fight.comp.FightSceneEntityFootRing", package.seeall)

local var_0_0 = class("FightSceneEntityFootRing", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_setLevelCO(arg_1_2)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_1_0._onEntityDeadBefore, arg_1_0)
	FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, arg_1_0._onBeforePlayUniqueSkill, arg_1_0)
	FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, arg_1_0._onAfterPlayUniqueSkill, arg_1_0)
	FightController.instance:registerCallback(FightEvent.SetEntityFootEffectVisible, arg_1_0._onSetEntityFootEffectVisible, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._releaseAllEntityEffect, arg_1_0)
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_3_0._onEntityDeadBefore, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, arg_3_0._onBeforePlayUniqueSkill, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, arg_3_0._onAfterPlayUniqueSkill, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityFootEffectVisible, arg_3_0._onSetEntityFootEffectVisible, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_3_0._releaseAllEntityEffect, arg_3_0)
	arg_3_0:_releaseFlyEffect()
end

function var_0_0._onSpineLoaded(arg_4_0, arg_4_1)
	if not arg_4_1 or not arg_4_0._fly_effect_url then
		return
	end

	arg_4_0:_setSpineFlyEffect(arg_4_1)
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	arg_5_0:_releaseFlyEffect()
	arg_5_0:_setLevelCO(arg_5_1)
	arg_5_0:_setAllSpineFlyEffect()
end

function var_0_0._setLevelCO(arg_6_0, arg_6_1)
	local var_6_0 = lua_scene_level.configDict[arg_6_1].flyEffect

	if not string.nilorempty(var_6_0) then
		TaskDispatcher.runRepeat(arg_6_0._onFrameUpdateEffectPos, arg_6_0, 0.01)

		arg_6_0._fly_effect_url = "buff/buff_feixing"
	end
end

function var_0_0._setAllSpineFlyEffect(arg_7_0)
	if not arg_7_0._fly_effect_url then
		return
	end

	local var_7_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.spine and arg_7_0._fly_effect_url then
			arg_7_0:_setSpineFlyEffect(iter_7_1.spine)
		end
	end
end

function var_0_0._setSpineFlyEffect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.unitSpawn

	if not var_8_0:isMySide() then
		return
	end

	local var_8_1 = var_8_0.id
	local var_8_2 = var_8_0:getMO()

	if not var_8_2 then
		return
	end

	local var_8_3 = FightConfig.instance:getSkinCO(var_8_2.skin)

	if not var_8_3 or var_8_3.isFly == 1 then
		return
	end

	if not arg_8_0.foot_effect then
		arg_8_0.foot_effect = {}
		arg_8_0.origin_pos_y = {}
		arg_8_0.cache_entity = {}
	end

	if arg_8_0.cache_entity[var_8_1] then
		arg_8_0:_onEntityDeadBefore(var_8_1)
	end

	local var_8_4, var_8_5 = FightHelper.getEntityStandPos(var_8_2)

	arg_8_0.origin_pos_y[var_8_1] = var_8_5
	arg_8_0.cache_entity[var_8_1] = var_8_0
	arg_8_0.foot_effect[var_8_1] = arg_8_0.foot_effect[var_8_1] or var_8_0.effect:addHangEffect(arg_8_0._fly_effect_url)
end

function var_0_0._onFrameUpdateEffectPos(arg_9_0)
	if arg_9_0.foot_effect then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.foot_effect) do
			local var_9_0 = arg_9_0.cache_entity[iter_9_0]

			if var_9_0 and not gohelper.isNil(var_9_0.go) then
				local var_9_1 = var_9_0.go

				if var_9_1 then
					local var_9_2, var_9_3, var_9_4 = transformhelper.getPos(var_9_1.transform)

					arg_9_0.foot_effect[iter_9_0]:setWorldPos(var_9_2, arg_9_0.origin_pos_y[iter_9_0], var_9_4)
				end
			end
		end
	end
end

function var_0_0._onBeforePlayUniqueSkill(arg_10_0)
	if arg_10_0.foot_effect then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.foot_effect) do
			gohelper.setActive(iter_10_1.containerGO, false)
		end
	end
end

function var_0_0._onAfterPlayUniqueSkill(arg_11_0)
	if arg_11_0.foot_effect then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.foot_effect) do
			gohelper.setActive(iter_11_1.containerGO, true)
		end
	end
end

function var_0_0._onEntityDeadBefore(arg_12_0, arg_12_1)
	if arg_12_0.foot_effect and arg_12_0.foot_effect[arg_12_1] then
		local var_12_0 = arg_12_0.cache_entity[arg_12_1]

		if var_12_0 and var_12_0.effect then
			var_12_0.effect:removeEffect(arg_12_0.foot_effect[arg_12_1])
		end

		arg_12_0.foot_effect[arg_12_1] = nil
		arg_12_0.cache_entity[arg_12_1] = nil
	end
end

function var_0_0._onSetEntityFootEffectVisible(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.foot_effect and arg_13_0.foot_effect[arg_13_1] then
		arg_13_0:_onFrameUpdateEffectPos()
		gohelper.setActive(arg_13_0.foot_effect[arg_13_1].containerGO, arg_13_2 or false)
	end
end

function var_0_0._releaseAllEntityEffect(arg_14_0)
	if arg_14_0.foot_effect then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.foot_effect) do
			arg_14_0:_onEntityDeadBefore(iter_14_0)
		end
	end
end

function var_0_0._releaseFlyEffect(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._onFrameUpdateEffectPos, arg_15_0)
	arg_15_0:_releaseAllEntityEffect()

	arg_15_0.origin_pos_y = nil
	arg_15_0.foot_effect = nil
	arg_15_0._fly_effect_url = nil
	arg_15_0.cache_entity = nil
end

return var_0_0
