module("modules.logic.versionactivity2_4.pinball.model.PinballTalentMo", package.seeall)

local var_0_0 = pureTable("PinballTalentMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._addResPers = {}
	arg_1_0._marblesLv = {}
	arg_1_0._unlockMarbles = {
		[PinballEnum.UnitType.MarblesNormal] = true
	}
	arg_1_0.co = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_1_1]

	if not arg_1_0.co then
		logError("没有天赋配置，id：" .. tostring(arg_1_1))

		return
	end

	local var_1_0 = string.splitToNumber(arg_1_0.co.effect, "#")
	local var_1_1 = var_1_0[1]

	if var_1_1 == PinballEnum.TalentEffectType.UnlockMarbles then
		arg_1_0._unlockMarbles[var_1_0[2]] = true
	elseif var_1_1 == PinballEnum.TalentEffectType.AddResPer then
		arg_1_0._addResPers[var_1_0[2]] = var_1_0[3] / 1000
	elseif var_1_1 == PinballEnum.TalentEffectType.EpisodeCostDec then
		arg_1_0._costDec = var_1_0[2]
	elseif var_1_1 == PinballEnum.TalentEffectType.PlayDec then
		arg_1_0._playDec = var_1_0[2]
	elseif var_1_1 == PinballEnum.TalentEffectType.MarblesLevel then
		arg_1_0._marblesLv[var_1_0[2]] = var_1_0[3]
	end
end

function var_0_0.getResAdd(arg_2_0, arg_2_1)
	return arg_2_0._addResPers[arg_2_1] or 0
end

function var_0_0.getCostDec(arg_3_0)
	return arg_3_0._costDec or 0
end

function var_0_0.getPlayDec(arg_4_0)
	return arg_4_0._playDec or 0
end

function var_0_0.getIsUnlockMarbles(arg_5_0, arg_5_1)
	return arg_5_0._unlockMarbles[arg_5_1] or false
end

function var_0_0.getMarblesLv(arg_6_0, arg_6_1)
	return arg_6_0._marblesLv[arg_6_1] or 1
end

return var_0_0
