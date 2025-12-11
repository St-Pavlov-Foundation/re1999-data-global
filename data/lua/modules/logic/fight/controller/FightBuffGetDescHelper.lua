module("modules.logic.fight.controller.FightBuffGetDescHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getBuffDesc(arg_1_0)
	if not arg_1_0 then
		return ""
	end

	local var_1_0 = lua_skill_buff.configDict[arg_1_0.buffId]

	if not var_1_0 then
		return ""
	end

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(arg_1_0.buffId) then
		return var_0_0.getKSDLBuffDesc(arg_1_0, var_1_0)
	end

	if not string.nilorempty(arg_1_0.actCommonParams) then
		local var_1_1 = string.split(arg_1_0.actCommonParams, "|")

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_2 = string.split(iter_1_1, "#")
			local var_1_3 = tonumber(var_1_2[1])
			local var_1_4 = lua_buff_act.configDict[var_1_3]
			local var_1_5 = var_1_4 and var_0_0.getBuffFeatureHandle(var_1_4.type)

			if var_1_5 then
				local var_1_6 = var_1_5(arg_1_0, var_1_0, var_1_4, var_1_2)

				return var_0_0.buildDesc(var_1_6)
			end
		end
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.actInfo) do
		local var_1_7 = lua_buff_act.configDict[iter_1_3.actId]
		local var_1_8 = var_1_7 and var_0_0.getBuffFeatureHandle(var_1_7.type)

		if var_1_8 then
			local var_1_9 = var_1_8(arg_1_0, var_1_0, var_1_7, nil, iter_1_3)

			return var_0_0.buildDesc(var_1_9)
		end
	end

	return var_0_0.buildDesc(var_1_0.desc)
end

function var_0_0.buildDesc(arg_2_0)
	return SkillHelper.buildDesc(arg_2_0, "#D65F3C", "#485E92")
end

function var_0_0.getBuffFeatureHandle(arg_3_0)
	if not var_0_0.FeatureHandleDict then
		var_0_0.FeatureHandleDict = {
			[FightEnum.BuffFeature.InjuryBank] = var_0_0.getInjuryBankDesc,
			[FightEnum.BuffFeature.AttrFixFromInjuryBank] = var_0_0.getAttrFixFromInjuryBankDesc,
			[FightEnum.BuffFeature.ModifyAttrByBuffLayer] = var_0_0.getModifyAttrByBuffLayerDesc,
			[FightEnum.BuffFeature.ResistancesAttr] = var_0_0.getResistancesAttrDesc,
			[FightEnum.BuffFeature.FixAttrTeamEnergyAndBuff] = var_0_0.getFixAttrTeamEnergyAndBuffDesc,
			[FightEnum.BuffFeature.FixAttrTeamEnergy] = var_0_0.getFixAttrTeamEnergyDesc,
			[FightEnum.BuffFeature.SpecialCountContinueChannelBuff] = var_0_0.getSpecialCountCastBuffDesc,
			[FightEnum.BuffFeature.AddAttrBySpecialCount] = var_0_0.getAddAttrBySpecialCountDesc,
			[FightEnum.BuffFeature.SpecialCountCastChannel] = var_0_0.getSpecialCountCastChannelDesc,
			[FightEnum.BuffFeature.ConsumeBuffAddBuffContinueChannel] = var_0_0.getConsumeBuffAddBuffContinueChannelDesc,
			[FightEnum.BuffFeature.BeAttackAccrualFixAttr] = var_0_0.getBeAttackAccrualFixAttr,
			[FightEnum.BuffFeature.Raspberry] = var_0_0.getRaspberryDesc,
			[FightEnum.BuffFeature.RaspberryBigSkill] = var_0_0.getRaspberryBigSkillDesc
		}
	end

	return var_0_0.FeatureHandleDict[arg_3_0]
end

function var_0_0.getInjuryBankDesc(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(arg_4_1.desc, arg_4_3[2], arg_4_3[3])
end

function var_0_0.getAttrFixFromInjuryBankDesc(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = tonumber(arg_5_3[2]) or 0

	var_5_0 = var_5_0 < 1 and 1 or math.floor(var_5_0)

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_5_1.desc, var_5_0)
end

function var_0_0.getModifyAttrByBuffLayerDesc(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = tonumber(arg_6_3[2] or 0)

	if var_6_0 < 1 then
		var_6_0 = 1
	end

	local var_6_1 = math.floor(var_6_0)

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_6_1.desc, var_6_1)
end

function var_0_0.getResistancesAttrDesc(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = tonumber(arg_7_3[3])
	local var_7_1 = math.floor(var_7_0 / 10)

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_7_1.desc, var_7_1 .. "%%")
end

function var_0_0.getFixAttrTeamEnergyAndBuffDesc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = tonumber(arg_8_3[2])

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_8_1.desc, var_8_0)
end

function var_0_0.getFixAttrTeamEnergyDesc(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1.features

	if string.nilorempty(var_9_0) then
		return arg_9_1.desc
	end

	local var_9_1 = 0
	local var_9_2 = FightStrUtil.instance:getSplitString2Cache(var_9_0, true)

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		if iter_9_1[1] == arg_9_2.id then
			var_9_1 = iter_9_1[3] + iter_9_1[4] * tonumber(arg_9_3[2])

			break
		end
	end

	local var_9_3 = var_9_1 / 10

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_9_1.desc, var_9_3 .. "%%")
end

function var_0_0.getStorageDamageDesc(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_10_1.desc, arg_10_3[2])
end

function var_0_0.getKSDLBuffDesc(arg_11_0, arg_11_1)
	local var_11_0 = FightBuffHelper.getKSDLSpecialBuffList(arg_11_0)

	if #var_11_0 < 1 then
		return var_0_0.buildDesc(arg_11_1.desc)
	end

	local var_11_1 = ""

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = lua_skill_buff.configDict[iter_11_1.buffId]

		if var_11_2 then
			var_11_1 = var_11_1 .. var_0_0.buildDesc(var_11_2.desc)
		end
	end

	return var_11_1
end

function var_0_0.getSpecialCountCastBuffDesc(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = SkillHelper.getColorFormat("#D65F3C", arg_12_3[2])

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_12_1.desc, var_12_0)
end

function var_0_0.getAddAttrBySpecialCountDesc(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = tonumber(arg_13_3[2]) / 10
	local var_13_1 = string.format("%+.1f", var_13_0)

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_13_1.desc, var_13_1 .. "%%")
end

function var_0_0.getSpecialCountCastChannelDesc(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_14_1.desc, arg_14_3[2])
end

function var_0_0.getConsumeBuffAddBuffContinueChannelDesc(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_15_1.desc, arg_15_4.strParam)
end

function var_0_0.getBeAttackAccrualFixAttr(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_16_1.desc, math.abs(tonumber(arg_16_4.strParam) or 0) / 10)
end

function var_0_0.getRaspberryDesc(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_4.param

	return GameUtil.getSubPlaceholderLuaLangTwoParam(arg_17_1.desc, var_17_0[1], var_17_0[2])
end

function var_0_0.getRaspberryBigSkillDesc(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_4.param

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_18_1.desc, var_18_0[1])
end

return var_0_0
