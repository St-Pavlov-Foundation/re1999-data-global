module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3081_Ball", package.seeall)

local var_0_0 = class("FightEntitySpecialEffect3081_Ball", FightEntitySpecialEffectBase)

function var_0_0.initClass(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, arg_1_0._onSetBuffEffectVisible, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0, LuaEventSystem.High)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_1_0._onBeforeEnterStepBehaviour, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_1_0._onBeforeDeadEffect, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, arg_1_0._onSkillEditorRefreshBuff, arg_1_0)

	arg_1_0._ballEffect = {}
end

local var_0_1 = "default"

var_0_0.skin2EffectPath = {
	{
		[308103] = "v2a1_ysed_jscq/ysed_jscq_idle_01_head02",
		[var_0_1] = "v1a7_ysed/ysed_idle_01_head02"
	},
	{
		[308103] = "v2a1_ysed_jscq/ysed_jscq_idle_02_head02",
		[var_0_1] = "v1a7_ysed/ysed_idle_02_head02"
	},
	{
		[308103] = "v2a1_ysed_jscq/ysed_jscq_idle_03_head02",
		[var_0_1] = "v1a7_ysed/ysed_idle_03_head02"
	}
}
var_0_0.buffId2EffectPath = {
	[30810101] = var_0_0.skin2EffectPath[1],
	[30810102] = var_0_0.skin2EffectPath[2],
	[30810110] = var_0_0.skin2EffectPath[2],
	[30810112] = var_0_0.skin2EffectPath[2],
	[30810114] = var_0_0.skin2EffectPath[2],
	[30810103] = var_0_0.skin2EffectPath[3],
	[30810111] = var_0_0.skin2EffectPath[3],
	[30810113] = var_0_0.skin2EffectPath[3],
	[30810115] = var_0_0.skin2EffectPath[3]
}

function var_0_0._onBuffUpdate(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 ~= arg_2_0._entity.id then
		return
	end

	if not lua_skill_buff.configDict[arg_2_3] then
		logError("buff表找不到id:" .. arg_2_3)

		return
	end

	local var_2_0 = arg_2_0._entity:getMO()

	if not var_2_0 then
		return
	end

	local var_2_1 = var_0_0.buffId2EffectPath[arg_2_3]

	if var_2_1 then
		var_2_1 = var_2_1[var_2_0.skin] or var_2_1[var_0_1]

		if arg_2_2 == FightEnum.EffectType.BUFFADD then
			arg_2_0:_releaseEffect(arg_2_3)

			local var_2_2 = arg_2_0._entity.effect:addHangEffect(var_2_1, ModuleEnum.SpineHangPointRoot)

			var_2_2:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 9)

			local var_2_3 = arg_2_0._entity:isMySide() and 1 or -1

			var_2_2:setLocalPos(var_2_3, 3.1, 0)

			arg_2_0._ballEffect[arg_2_3] = var_2_2
		elseif arg_2_2 == FightEnum.EffectType.BUFFDEL then
			arg_2_0:_releaseEffect(arg_2_3)
		end
	end
end

function var_0_0._onBeforeEnterStepBehaviour(arg_3_0)
	local var_3_0 = arg_3_0._entity:getMO()

	if var_3_0 then
		local var_3_1 = var_3_0:getBuffDic()

		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			arg_3_0:_onBuffUpdate(arg_3_0._entity.id, FightEnum.EffectType.BUFFADD, iter_3_1.buffId, iter_3_1.uid)
		end
	end
end

function var_0_0._onSkillEditorRefreshBuff(arg_4_0)
	arg_4_0:releaseAllEffect()
	arg_4_0:_onBeforeEnterStepBehaviour()
end

function var_0_0._onSetBuffEffectVisible(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0._entity.id == arg_5_1 and arg_5_0._ballEffect then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._ballEffect) do
			iter_5_1:setActive(arg_5_2, arg_5_3 or "FightEntitySpecialEffect3081_Ball")
		end
	end
end

function var_0_0._onSkillPlayStart(arg_6_0, arg_6_1)
	arg_6_0:_onSetBuffEffectVisible(arg_6_1.id, false, "FightEntitySpecialEffect3081_Ball_PlaySkill")
end

function var_0_0._onSkillPlayFinish(arg_7_0, arg_7_1)
	arg_7_0:_onSetBuffEffectVisible(arg_7_1.id, true, "FightEntitySpecialEffect3081_Ball_PlaySkill")
end

function var_0_0._releaseEffect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._ballEffect[arg_8_1]

	if var_8_0 then
		arg_8_0._entity.effect:removeEffect(var_8_0)
	end

	arg_8_0._ballEffect[arg_8_1] = nil
end

function var_0_0.releaseAllEffect(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._ballEffect) do
		arg_9_0:_releaseEffect(iter_9_0)
	end
end

function var_0_0._onBeforeDeadEffect(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0._entity.id then
		arg_10_0:releaseAllEffect()
	end
end

function var_0_0.releaseSelf(arg_11_0)
	arg_11_0:releaseAllEffect()
end

return var_0_0
