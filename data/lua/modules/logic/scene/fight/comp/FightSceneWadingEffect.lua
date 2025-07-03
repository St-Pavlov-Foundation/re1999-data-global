module("modules.logic.scene.fight.comp.FightSceneWadingEffect", package.seeall)

local var_0_0 = class("FightSceneWadingEffect", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_setLevelCO(arg_1_2)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_1_0._releaseEntityEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._releaseAllEntityEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.BeforeChangeSubHero, arg_1_0._releaseEntityEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.SetEntityAlpha, arg_1_0._onSetEntityAlpha, arg_1_0)
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0:getCurScene().level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_3_0._releaseEntityEffect, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_3_0._releaseAllEntityEffect, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeChangeSubHero, arg_3_0._releaseEntityEffect, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityAlpha, arg_3_0._onSetEntityAlpha, arg_3_0)
	arg_3_0:_releaseEffect()
end

function var_0_0._onSpineLoaded(arg_4_0, arg_4_1)
	if not arg_4_1 or not arg_4_0._effectUrl then
		return
	end

	arg_4_0:_setSpineEffect(arg_4_1)
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	arg_5_0:_releaseEffect()
	arg_5_0:_setLevelCO(arg_5_1)
	arg_5_0:_setAllSpineEffect()
end

function var_0_0._setLevelCO(arg_6_0, arg_6_1)
	local var_6_0 = lua_scene_level.configDict[arg_6_1].wadeEffect

	if not string.nilorempty(var_6_0) then
		TaskDispatcher.runRepeat(arg_6_0._onFrameUpdateEffectPos, arg_6_0, 0.01)

		local var_6_1 = string.split(var_6_0, "#")
		local var_6_2 = var_6_1[1]

		if var_6_2 == "1" then
			arg_6_0._side = FightEnum.EntitySide.EnemySide
		elseif var_6_2 == "2" then
			arg_6_0._side = FightEnum.EntitySide.MySide
		elseif var_6_2 == "3" then
			arg_6_0._side = nil
		end

		arg_6_0._effectUrl = var_6_1[2]
	end
end

function var_0_0._setAllSpineEffect(arg_7_0)
	if not arg_7_0._effectUrl then
		return
	end

	local var_7_0

	if arg_7_0._side then
		var_7_0 = FightHelper.getSideEntitys(arg_7_0._side, true)
	else
		var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
			table.insert(var_7_0, iter_7_1)
		end

		for iter_7_2, iter_7_3 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)) do
			table.insert(var_7_0, iter_7_3)
		end
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_0) do
		if iter_7_5.spine then
			arg_7_0:_setSpineEffect(iter_7_5.spine)
		end
	end
end

function var_0_0._setSpineEffect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.unitSpawn
	local var_8_1 = var_8_0.id
	local var_8_2 = var_8_0:getMO()

	if not var_8_2 then
		return
	end

	local var_8_3 = FightConfig.instance:getSkinCO(var_8_2.skin)

	if not var_8_3 or var_8_3.isFly == 1 then
		return
	end

	if arg_8_0._side and arg_8_0._side ~= var_8_0:getSide() then
		return
	end

	if not arg_8_0._effects then
		arg_8_0._effects = {}
		arg_8_0._originPos = {}
		arg_8_0._standPos = {}
		arg_8_0._effects2 = {}
	end

	if arg_8_0._effects[var_8_1] then
		return
	end

	local var_8_4 = var_8_0:getHangPoint(ModuleEnum.SpineHangPoint.mountbody)

	if var_8_4 then
		local var_8_5 = var_8_0.effect:addHangEffect(arg_8_0._effectUrl, ModuleEnum.SpineHangPointRoot)

		arg_8_0._effects[var_8_1] = var_8_5

		arg_8_0._effects[var_8_1]:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_8_1, var_8_5)

		local var_8_6, var_8_7, var_8_8 = FightHelper.getEntityStandPos(var_8_2)
		local var_8_9, var_8_10, var_8_11 = transformhelper.getLocalPos(var_8_4.transform)

		arg_8_0._originPos[var_8_1] = {
			var_8_6 + var_8_9,
			var_8_7 + var_8_10,
			var_8_8 + var_8_11
		}
		arg_8_0._standPos[var_8_1] = {
			var_8_6,
			var_8_7,
			var_8_8
		}

		local var_8_12 = var_8_0.effect:addGlobalEffect(arg_8_0._effectUrl .. "_effect")

		var_8_12:setLocalPos(var_8_9 + var_8_6, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_8_1, var_8_12)

		arg_8_0._effects2[var_8_1] = var_8_12
	end
end

local var_0_1 = "_RolePos"

function var_0_0._onFrameUpdateEffectPos(arg_9_0)
	if arg_9_0._effects then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._effects) do
			local var_9_0 = FightHelper.getEntity(iter_9_0)

			if var_9_0 then
				local var_9_1 = arg_9_0._standPos[iter_9_0]
				local var_9_2, var_9_3, var_9_4 = transformhelper.getLocalPos(var_9_0.go.transform)

				if var_9_2 ~= var_9_1[1] or var_9_3 ~= var_9_1[2] or var_9_4 ~= var_9_1[3] then
					local var_9_5 = iter_9_1.effectGO
					local var_9_6 = gohelper.findChildComponent(var_9_5, "root/wave", typeof(UnityEngine.MeshRenderer))

					if var_9_6 and var_9_6.material then
						local var_9_7 = FightHelper.getEntity(iter_9_0):getHangPoint(ModuleEnum.SpineHangPoint.mountbody)
						local var_9_8, var_9_9, var_9_10 = transformhelper.getPos(var_9_7.transform)
						local var_9_11 = arg_9_0._originPos[iter_9_0]
						local var_9_12 = var_9_8 - var_9_11[1]
						local var_9_13 = var_9_9 - var_9_11[2]
						local var_9_14 = var_9_10 - var_9_11[3]
						local var_9_15 = string.format("%f,%f,%f,0", var_9_12, var_9_13, var_9_14)

						MaterialUtil.setPropValue(var_9_6.material, var_0_1, "Vector4", MaterialUtil.getPropValueFromStr("Vector4", var_9_15))

						if var_9_8 < 0 and var_9_13 < 1 then
							arg_9_0._effects2[iter_9_0]:setLocalPos(var_9_8, 0, var_9_10)
						end
					end
				end
			end
		end
	end
end

local var_0_2 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function var_0_0._onSkillPlayStart(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		[arg_10_3.fromId] = true,
		[arg_10_3.toId] = true
	}

	for iter_10_0, iter_10_1 in ipairs(arg_10_3.actEffect) do
		if var_0_2[iter_10_1.effectType] then
			var_10_0[iter_10_1.targetId] = true
		end
	end

	if arg_10_0._effects2 then
		for iter_10_2, iter_10_3 in pairs(arg_10_0._effects2) do
			if not var_10_0[iter_10_2] then
				iter_10_3:setActive(false, "FightSceneWadingEffect")
			end
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_11_0)
	if arg_11_0._effects2 then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._effects2) do
			iter_11_1:setActive(true, "FightSceneWadingEffect")
		end
	end
end

function var_0_0._onSetEntityAlpha(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._effects2 and arg_12_0._effects2[arg_12_1] then
		arg_12_0._effects2[arg_12_1]:setActive(arg_12_2, "_onSetEntityAlpha")
	end
end

function var_0_0._releaseEntityEffect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._effects and arg_13_0._effects[arg_13_1]

	if var_13_0 then
		local var_13_1 = FightHelper.getEntity(arg_13_1)

		if var_13_1 and var_13_1.effect then
			var_13_1.effect:removeEffect(var_13_0)
			var_13_1.effect:removeEffect(arg_13_0._effects2[arg_13_1])
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_13_1, var_13_0)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_13_1, arg_13_0._effects2[arg_13_1])

		arg_13_0._effects[arg_13_1] = nil
		arg_13_0._effects2[arg_13_1] = nil
	end
end

function var_0_0._releaseAllEntityEffect(arg_14_0)
	if arg_14_0._effects then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._effects) do
			arg_14_0:_releaseEntityEffect(iter_14_0)
		end
	end
end

function var_0_0._releaseEffect(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._onFrameUpdateEffectPos, arg_15_0)
	arg_15_0:_releaseAllEntityEffect()

	arg_15_0._effects = nil
	arg_15_0._originPos = nil
	arg_15_0._standPos = nil
	arg_15_0._effectUrl = nil
end

return var_0_0
