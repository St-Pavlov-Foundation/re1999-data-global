module("modules.logic.fight.entity.comp.FightSkinSpineEffect", package.seeall)

local var_0_0 = class("FightSkinSpineEffect", LuaCompBase)
local var_0_1 = {
	buff_jjhhy = true
}
local var_0_2 = {
	buff_jjhhy = true
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectWrapDict = nil
	arg_1_0._monsterEffect = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._spine = arg_2_0.entity.spine

	arg_2_0._spine:registerCallback(UnitSpine.Evt_OnLoaded, arg_2_0._onLoaded, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._spine:unregisterCallback(UnitSpine.Evt_OnLoaded, arg_3_0._onLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayShowSpine, arg_3_0)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._effectWrapDict = nil
end

function var_0_0._onSkillPlayStart(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0.entity == arg_5_1 then
		arg_5_0:_setMonsterEffectActive(false, arg_5_0.__cname)
	end
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.entity == arg_6_1 then
		arg_6_0:_setMonsterEffectActive(true, arg_6_0.__cname)
	end
end

function var_0_0._setMonsterEffectActive(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._monsterEffect) do
		if not var_0_2[iter_7_0] then
			iter_7_1:setActive(arg_7_1, arg_7_2)
		end
	end
end

function var_0_0._onLoaded(arg_8_0)
	local var_8_0 = arg_8_0.entity:getMO()
	local var_8_1 = FightConfig.instance:getSkinCO(var_8_0.skin)

	if not string.nilorempty(var_8_1.effect) then
		local var_8_2 = string.split(var_8_1.effect, "#")
		local var_8_3 = string.split(var_8_1.effectHangPoint, "#")

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			arg_8_0:_addEffect(iter_8_1, var_8_3[iter_8_0])
		end

		arg_8_0:_setSpineAlphaForRoleEffect(var_8_2)
	end

	local var_8_4 = lua_monster.configDict[var_8_0.modelId]

	if var_8_4 and not string.nilorempty(var_8_4.effect) then
		local var_8_5 = string.split(var_8_4.effect, "#")
		local var_8_6 = string.split(var_8_4.effectHangPoint, "#")

		for iter_8_2, iter_8_3 in ipairs(var_8_5) do
			arg_8_0._monsterEffect[iter_8_3] = arg_8_0:_addEffect(iter_8_3, var_8_6[iter_8_2])
		end

		arg_8_0:_setSpineAlphaForRoleEffect(var_8_5)
	end
end

function var_0_0._setSpineAlphaForRoleEffect(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if var_0_1[iter_9_1] then
			arg_9_0.entity.spineRenderer:setAlpha(0, 0)
			TaskDispatcher.runDelay(arg_9_0._delayShowSpine, arg_9_0, 0.1)

			break
		end
	end
end

function var_0_0._delayShowSpine(arg_10_0)
	arg_10_0.entity.spineRenderer:setAlpha(1)
end

function var_0_0._addEffect(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.entity.effect:addHangEffect(arg_11_1, arg_11_2)

	var_11_0:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_11_0.entity.id, var_11_0)

	arg_11_0._effectWrapDict = arg_11_0._effectWrapDict or {}
	arg_11_0._effectWrapDict[arg_11_1] = var_11_0

	return var_11_0
end

function var_0_0.hideEffects(arg_12_0, arg_12_1)
	if arg_12_0._effectWrapDict then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._effectWrapDict) do
			if not var_0_2[iter_12_0] then
				iter_12_1:setActive(false, arg_12_1)
			end
		end
	end
end

function var_0_0.showEffects(arg_13_0, arg_13_1)
	if arg_13_0._effectWrapDict then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._effectWrapDict) do
			if not var_0_2[iter_13_0] then
				iter_13_1:setActive(true, arg_13_1)
			end
		end
	end
end

return var_0_0
