module("modules.logic.fight.mgr.FightWadingEffectMgr", package.seeall)

local var_0_0 = class("FightWadingEffectMgr", FightBaseClass)
local var_0_1 = pairs
local var_0_2 = FightHelper
local var_0_3 = transformhelper
local var_0_4 = gohelper
local var_0_5 = typeof
local var_0_6 = UnityEngine.MeshRenderer
local var_0_7 = ModuleEnum.SpineHangPoint.mountbody
local var_0_8 = string
local var_0_9 = MaterialUtil

function var_0_0.onConstructor(arg_1_0)
	arg_1_0:com_registFightEvent(FightEvent.OnSpineLoaded, arg_1_0.onSpineLoaded)
	arg_1_0:com_registFightEvent(FightEvent.BeforeDeadEffect, arg_1_0.releaseEntityEffect)
	arg_1_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_1_0.releaseAllEntityEffect)
	arg_1_0:com_registFightEvent(FightEvent.BeforeChangeSubHero, arg_1_0.releaseEntityEffect)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0.onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0.onSkillPlayFinish)
	arg_1_0:com_registFightEvent(FightEvent.SetEntityAlpha, arg_1_0.onSetEntityAlpha)

	local var_1_0 = GameSceneMgr.instance:getCurScene()

	arg_1_0:com_registEvent(var_1_0.level, CommonSceneLevelComp.OnLevelLoaded, arg_1_0.onLevelLoaded)
end

function var_0_0.onSpineLoaded(arg_2_0, arg_2_1)
	if not arg_2_1 or not arg_2_0.effectUrl then
		return
	end

	arg_2_0:setSpineEffect(arg_2_1)
end

function var_0_0.onLevelLoaded(arg_3_0, arg_3_1)
	arg_3_0:releaseEffect()
	arg_3_0:setLevelCO(arg_3_1)
	arg_3_0:setAllSpineEffect()
end

function var_0_0.setLevelCO(arg_4_0, arg_4_1)
	local var_4_0 = lua_scene_level.configDict[arg_4_1].wadeEffect

	if not var_0_8.nilorempty(var_4_0) then
		arg_4_0:com_registUpdate(arg_4_0.onUpdate)

		local var_4_1 = var_0_8.split(var_4_0, "#")
		local var_4_2 = var_4_1[1]

		if var_4_2 == "1" then
			arg_4_0.side = FightEnum.EntitySide.EnemySide
		elseif var_4_2 == "2" then
			arg_4_0.side = FightEnum.EntitySide.MySide
		elseif var_4_2 == "3" then
			arg_4_0.side = nil
		end

		arg_4_0.effectUrl = var_4_1[2]
	end
end

function var_0_0.setAllSpineEffect(arg_5_0)
	if not arg_5_0.effectUrl then
		return
	end

	local var_5_0

	if arg_5_0.side then
		var_5_0 = var_0_2.getSideEntitys(arg_5_0.side, true)
	else
		var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(var_0_2.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
			table.insert(var_5_0, iter_5_1)
		end

		for iter_5_2, iter_5_3 in ipairs(var_0_2.getSideEntitys(FightEnum.EntitySide.EnemySide, true)) do
			table.insert(var_5_0, iter_5_3)
		end
	end

	for iter_5_4, iter_5_5 in ipairs(var_5_0) do
		if iter_5_5.spine then
			arg_5_0:setSpineEffect(iter_5_5.spine)
		end
	end
end

function var_0_0.setSpineEffect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.unitSpawn
	local var_6_1 = var_6_0.id
	local var_6_2 = var_6_0:getMO()

	if not var_6_2 then
		return
	end

	local var_6_3 = FightConfig.instance:getSkinCO(var_6_2.skin)

	if not var_6_3 or var_6_3.isFly == 1 then
		return
	end

	if arg_6_0.side and arg_6_0.side ~= var_6_0:getSide() then
		return
	end

	if not arg_6_0.effects then
		arg_6_0.effects = {}
		arg_6_0.originPos = {}
		arg_6_0.standPos = {}
		arg_6_0.effects2 = {}
	end

	if arg_6_0.effects[var_6_1] then
		return
	end

	local var_6_4 = var_6_0:getHangPoint(var_0_7)

	if var_6_4 then
		local var_6_5 = var_6_0.effect:addHangEffect(arg_6_0.effectUrl, ModuleEnum.SpineHangPointRoot)

		arg_6_0.effects[var_6_1] = var_6_5

		arg_6_0.effects[var_6_1]:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_6_1, var_6_5)

		local var_6_6, var_6_7, var_6_8 = var_0_2.getEntityStandPos(var_6_2)
		local var_6_9, var_6_10, var_6_11 = var_0_3.getLocalPos(var_6_4.transform)

		arg_6_0.originPos[var_6_1] = {
			var_6_6 + var_6_9,
			var_6_7 + var_6_10,
			var_6_8 + var_6_11
		}
		arg_6_0.standPos[var_6_1] = {
			var_6_6,
			var_6_7,
			var_6_8
		}

		local var_6_12 = var_6_0.effect:addGlobalEffect(arg_6_0.effectUrl .. "effect")

		var_6_12:setLocalPos(var_6_9 + var_6_6, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_6_1, var_6_12)

		arg_6_0.effects2[var_6_1] = var_6_12
	end
end

local var_0_10 = "RolePos"

function var_0_0.onUpdate(arg_7_0)
	if arg_7_0.effects then
		for iter_7_0, iter_7_1 in var_0_1(arg_7_0.effects) do
			local var_7_0 = var_0_2.getEntity(iter_7_0)

			if var_7_0 then
				local var_7_1 = arg_7_0.standPos[iter_7_0]
				local var_7_2, var_7_3, var_7_4 = var_0_3.getLocalPos(var_7_0.go.transform)

				if var_7_2 ~= var_7_1[1] or var_7_3 ~= var_7_1[2] or var_7_4 ~= var_7_1[3] then
					local var_7_5 = iter_7_1.effectGO
					local var_7_6 = var_0_4.findChildComponent(var_7_5, "root/wave", var_0_5(var_0_6))

					if var_7_6 and var_7_6.material then
						local var_7_7 = var_0_2.getEntity(iter_7_0):getHangPoint(var_0_7)
						local var_7_8, var_7_9, var_7_10 = var_0_3.getPos(var_7_7.transform)
						local var_7_11 = arg_7_0.originPos[iter_7_0]
						local var_7_12 = var_7_8 - var_7_11[1]
						local var_7_13 = var_7_9 - var_7_11[2]
						local var_7_14 = var_7_10 - var_7_11[3]
						local var_7_15 = var_0_8.format("%f,%f,%f,0", var_7_12, var_7_13, var_7_14)

						var_0_9.setPropValue(var_7_6.material, var_0_10, "Vector4", var_0_9.getPropValueFromStr("Vector4", var_7_15))

						if var_7_8 < 0 and var_7_13 < 1 then
							arg_7_0.effects2[iter_7_0]:setLocalPos(var_7_8, 0, var_7_10)
						end
					end
				end
			end
		end
	end
end

local var_0_11 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function var_0_0.onSkillPlayStart(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {
		[arg_8_3.fromId] = true,
		[arg_8_3.toId] = true
	}

	for iter_8_0, iter_8_1 in ipairs(arg_8_3.actEffect) do
		if var_0_11[iter_8_1.effectType] then
			var_8_0[iter_8_1.targetId] = true
		end
	end

	if arg_8_0.effects2 then
		for iter_8_2, iter_8_3 in var_0_1(arg_8_0.effects2) do
			if not var_8_0[iter_8_2] then
				iter_8_3:setActive(false, "FightWadingEffectMgr")
			end
		end
	end
end

function var_0_0.onSkillPlayFinish(arg_9_0)
	if arg_9_0.effects2 then
		for iter_9_0, iter_9_1 in var_0_1(arg_9_0.effects2) do
			iter_9_1:setActive(true, "FightWadingEffectMgr")
		end
	end
end

function var_0_0.onSetEntityAlpha(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.effects2 and arg_10_0.effects2[arg_10_1] then
		arg_10_0.effects2[arg_10_1]:setActive(arg_10_2, "onSetEntityAlpha")
	end
end

function var_0_0.releaseEntityEffect(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.effects and arg_11_0.effects[arg_11_1]

	if var_11_0 then
		local var_11_1 = var_0_2.getEntity(arg_11_1)

		if var_11_1 and var_11_1.effect then
			var_11_1.effect:removeEffect(var_11_0)
			var_11_1.effect:removeEffect(arg_11_0.effects2[arg_11_1])
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_11_1, var_11_0)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_11_1, arg_11_0.effects2[arg_11_1])

		arg_11_0.effects[arg_11_1] = nil
		arg_11_0.effects2[arg_11_1] = nil
	end
end

function var_0_0.releaseAllEntityEffect(arg_12_0)
	if arg_12_0.effects then
		for iter_12_0, iter_12_1 in var_0_1(arg_12_0.effects) do
			arg_12_0:releaseEntityEffect(iter_12_0)
		end
	end
end

function var_0_0.releaseEffect(arg_13_0)
	arg_13_0:releaseAllEntityEffect()

	arg_13_0.effects = nil
	arg_13_0.originPos = nil
	arg_13_0.standPos = nil
	arg_13_0.effectUrl = nil
end

function var_0_0.onDestructor(arg_14_0)
	arg_14_0:releaseEffect()
end

return var_0_0
