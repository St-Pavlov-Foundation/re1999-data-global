module("modules.logic.fight.entity.comp.skill.FightTLEventDefHeal", package.seeall)

local var_0_0 = class("FightTLEventDefHeal", FightTimelineTrackItem)
local var_0_1 = {
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.AVERAGELIFE] = true
}

function var_0_0.setContext(arg_1_0, arg_1_1)
	arg_1_0._context = arg_1_1
end

function var_0_0.onTrackStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.fightStepData = arg_2_1
	arg_2_0._hasRatio = not string.nilorempty(arg_2_3[1])
	arg_2_0._ratio = tonumber(arg_2_3[1]) or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.actEffect) do
		local var_2_0 = FightHelper.getEntity(iter_2_1.targetId)

		if var_2_0 then
			if var_0_1[iter_2_1.effectType] then
				arg_2_0:_playDefHeal(var_2_0, iter_2_1)
			end
		else
			logNormal("defender heal fail, entity not exist: " .. iter_2_1.targetId)
		end
	end

	local var_2_1 = arg_2_3[2]

	arg_2_0:_buildSkillEffect(var_2_1)
	arg_2_0:_playSkillBehavior()
end

function var_0_0._playDefHeal(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2.effectType == FightEnum.EffectType.HEAL or arg_3_2.effectType == FightEnum.EffectType.HEALCRIT then
		FightDataHelper.playEffectData(arg_3_2)

		local var_3_0 = arg_3_0:_calcNum(arg_3_2.clientId, arg_3_2.targetId, arg_3_2.effectNum, arg_3_0._ratio)

		if arg_3_1.nameUI then
			arg_3_1.nameUI:addHp(var_3_0)
		end

		local var_3_1 = arg_3_2.effectType == FightEnum.EffectType.HEAL and FightEnum.FloatType.heal or FightEnum.FloatType.crit_heal

		FightFloatMgr.instance:float(arg_3_2.targetId, var_3_1, var_3_0)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, arg_3_1, var_3_0)
	elseif arg_3_2.effectType == FightEnum.EffectType.AVERAGELIFE and not arg_3_2.hasDoAverageLiveEffect then
		FightDataHelper.playEffectData(arg_3_2)

		arg_3_2.hasDoAverageLiveEffect = true

		local var_3_2 = arg_3_1.nameUI and arg_3_1.nameUI:getHp() or 0
		local var_3_3 = arg_3_2.effectNum - var_3_2

		if arg_3_1.nameUI then
			arg_3_1.nameUI:addHp(var_3_3)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, arg_3_1, var_3_3)
	end

	FightController.instance:dispatchEvent(FightEvent.OnTimelineHeal, arg_3_2)
end

function var_0_0._calcNum(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_0._hasRatio then
		arg_4_0._context.healFloatNum = arg_4_0._context.healFloatNum or {}
		arg_4_0._context.healFloatNum[arg_4_2] = arg_4_0._context.healFloatNum[arg_4_2] or {}
		arg_4_0._context.healFloatNum[arg_4_2][arg_4_1] = arg_4_0._context.healFloatNum[arg_4_2][arg_4_1] or {}

		local var_4_0 = arg_4_0._context.healFloatNum[arg_4_2][arg_4_1]
		local var_4_1 = var_4_0.ratio or 0
		local var_4_2 = var_4_0.total or 0
		local var_4_3 = arg_4_4 + var_4_1

		var_4_3 = var_4_3 < 1 and var_4_3 or 1

		local var_4_4 = math.floor(var_4_3 * arg_4_3) - var_4_2

		var_4_0.ratio = arg_4_4 + var_4_1
		var_4_0.total = var_4_2 + var_4_4

		return var_4_4
	else
		return 0
	end
end

function var_0_0._buildSkillEffect(arg_5_0, arg_5_1)
	arg_5_0._behaviorTypeDict = nil

	local var_5_0 = FightStrUtil.instance:getSplitToNumberCache(arg_5_1, "#")

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = lua_skill_effect.configDict[iter_5_1]

		if var_5_1 then
			for iter_5_2 = 1, FightEnum.MaxBehavior do
				local var_5_2 = var_5_1["behavior" .. iter_5_2]
				local var_5_3 = FightStrUtil.instance:getSplitToNumberCache(var_5_2, "#")
				local var_5_4 = var_5_3[1]

				if var_5_3 and #var_5_3 > 0 then
					arg_5_0._behaviorTypeDict = arg_5_0._behaviorTypeDict or {}
					arg_5_0._behaviorTypeDict[var_5_4] = true
				end
			end
		else
			logError("技能调用效果不存在" .. iter_5_1)
		end
	end
end

function var_0_0._playSkillBehavior(arg_6_0)
	if not arg_6_0._behaviorTypeDict then
		return
	end

	FightSkillBehaviorMgr.instance:playSkillBehavior(arg_6_0.fightStepData, arg_6_0._behaviorTypeDict, true)
end

return var_0_0
