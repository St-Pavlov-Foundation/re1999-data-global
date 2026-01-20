-- chunkname: @modules/logic/fight/controller/FightBuffGetDescHelper.lua

module("modules.logic.fight.controller.FightBuffGetDescHelper", package.seeall)

local FightBuffGetDescHelper = _M

function FightBuffGetDescHelper.getBuffDesc(buffMo)
	if not buffMo then
		return ""
	end

	local buffCo = lua_skill_buff.configDict[buffMo.buffId]

	if not buffCo then
		return ""
	end

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffMo.buffId) then
		return FightBuffGetDescHelper.getKSDLBuffDesc(buffMo, buffCo)
	end

	if not string.nilorempty(buffMo.actCommonParams) then
		local arr = string.split(buffMo.actCommonParams, "|")

		for _, v in ipairs(arr) do
			local paramArray = string.split(v, "#")
			local featureId = tonumber(paramArray[1])
			local buffActConfig = lua_buff_act.configDict[featureId]
			local handle = buffActConfig and FightBuffGetDescHelper.getBuffFeatureHandle(buffActConfig.type)

			if handle then
				local desc = handle(buffMo, buffCo, buffActConfig, paramArray)

				return FightBuffGetDescHelper.buildDesc(desc)
			end
		end
	end

	for _, buffActInfo in ipairs(buffMo.actInfo) do
		local buffActConfig = lua_buff_act.configDict[buffActInfo.actId]
		local handle = buffActConfig and FightBuffGetDescHelper.getBuffFeatureHandle(buffActConfig.type)

		if handle then
			local desc = handle(buffMo, buffCo, buffActConfig, nil, buffActInfo)

			return FightBuffGetDescHelper.buildDesc(desc)
		end
	end

	return FightBuffGetDescHelper.buildDesc(buffCo.desc)
end

function FightBuffGetDescHelper.buildDesc(desc)
	return SkillHelper.buildDesc(desc, "#D65F3C", "#485E92")
end

function FightBuffGetDescHelper.getBuffFeatureHandle(feature)
	if not FightBuffGetDescHelper.FeatureHandleDict then
		FightBuffGetDescHelper.FeatureHandleDict = {
			[FightEnum.BuffFeature.InjuryBank] = FightBuffGetDescHelper.getInjuryBankDesc,
			[FightEnum.BuffFeature.AttrFixFromInjuryBank] = FightBuffGetDescHelper.getAttrFixFromInjuryBankDesc,
			[FightEnum.BuffFeature.ModifyAttrByBuffLayer] = FightBuffGetDescHelper.getModifyAttrByBuffLayerDesc,
			[FightEnum.BuffFeature.ResistancesAttr] = FightBuffGetDescHelper.getResistancesAttrDesc,
			[FightEnum.BuffFeature.FixAttrTeamEnergyAndBuff] = FightBuffGetDescHelper.getFixAttrTeamEnergyAndBuffDesc,
			[FightEnum.BuffFeature.FixAttrTeamEnergy] = FightBuffGetDescHelper.getFixAttrTeamEnergyDesc,
			[FightEnum.BuffFeature.SpecialCountContinueChannelBuff] = FightBuffGetDescHelper.getSpecialCountCastBuffDesc,
			[FightEnum.BuffFeature.AddAttrBySpecialCount] = FightBuffGetDescHelper.getAddAttrBySpecialCountDesc,
			[FightEnum.BuffFeature.SpecialCountCastChannel] = FightBuffGetDescHelper.getSpecialCountCastChannelDesc,
			[FightEnum.BuffFeature.ConsumeBuffAddBuffContinueChannel] = FightBuffGetDescHelper.formatActInfoStrParam,
			[FightEnum.BuffFeature.BeAttackAccrualFixAttr] = FightBuffGetDescHelper.getBeAttackAccrualFixAttr,
			[FightEnum.BuffFeature.Raspberry] = FightBuffGetDescHelper.formatActInfoTwoParam,
			[FightEnum.BuffFeature.RaspberryBigSkill] = FightBuffGetDescHelper.formatActInfoOneParam,
			[FightEnum.BuffFeature.AttrByHeatScale] = FightBuffGetDescHelper.getAttrByHeatScaleDesc,
			[FightEnum.BuffFeature.HeatScaleUseSkill] = FightBuffGetDescHelper.formatActInfoOneParam
		}
	end

	return FightBuffGetDescHelper.FeatureHandleDict[feature]
end

function FightBuffGetDescHelper.getInjuryBankDesc(buffMo, buffCo, buffActCo, paramArray)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(buffCo.desc, paramArray[2], paramArray[3])
end

function FightBuffGetDescHelper.getAttrFixFromInjuryBankDesc(buffMo, buffCo, buffActCo, paramArray)
	local num = tonumber(paramArray[2]) or 0

	num = num < 1 and 1 or math.floor(num)

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, num)
end

function FightBuffGetDescHelper.getModifyAttrByBuffLayerDesc(buffMo, buffCo, buffActCo, paramArray)
	local num = tonumber(paramArray[2] or 0)

	if num < 1 then
		num = 1
	end

	num = math.floor(num)

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, num)
end

function FightBuffGetDescHelper.getResistancesAttrDesc(buffMo, buffCo, buffActCo, paramArray)
	local num = tonumber(paramArray[3])

	num = math.floor(num / 10)

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, num .. "%%")
end

function FightBuffGetDescHelper.getFixAttrTeamEnergyAndBuffDesc(buffMo, buffCo, buffActCo, paramArray)
	local num = tonumber(paramArray[2])

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, num)
end

function FightBuffGetDescHelper.getFixAttrTeamEnergyDesc(buffMo, buffCo, buffActCo, paramArray)
	local features = buffCo.features

	if string.nilorempty(features) then
		return buffCo.desc
	end

	local value = 0
	local featureList = FightStrUtil.instance:getSplitString2Cache(features, true)

	for _, feature in ipairs(featureList) do
		if feature[1] == buffActCo.id then
			value = feature[3] + feature[4] * tonumber(paramArray[2])

			break
		end
	end

	value = value / 10

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, value .. "%%")
end

function FightBuffGetDescHelper.getStorageDamageDesc(buffMo, buffCo, buffActCo, paramArray)
	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, paramArray[2])
end

function FightBuffGetDescHelper.getKSDLBuffDesc(buffMo, buffCo)
	local buffList = FightBuffHelper.getKSDLSpecialBuffList(buffMo)

	if #buffList < 1 then
		return FightBuffGetDescHelper.buildDesc(buffCo.desc)
	end

	local str = ""

	for _, _buffMo in ipairs(buffList) do
		local _buffCo = lua_skill_buff.configDict[_buffMo.buffId]

		if _buffCo then
			str = str .. FightBuffGetDescHelper.buildDesc(_buffCo.desc)
		end
	end

	return str
end

function FightBuffGetDescHelper.getSpecialCountCastBuffDesc(buffMo, buffCo, buffActCo, paramArray)
	local text = SkillHelper.getColorFormat("#D65F3C", paramArray[2])

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, text)
end

function FightBuffGetDescHelper.getAddAttrBySpecialCountDesc(buffMo, buffCo, buffActCo, paramArray)
	local num = tonumber(paramArray[2])

	num = num / 10

	local text = string.format("%+.1f", num)

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, text .. "%%")
end

function FightBuffGetDescHelper.getSpecialCountCastChannelDesc(buffMo, buffCo, buffActCo, paramArray)
	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, paramArray[2])
end

function FightBuffGetDescHelper.getBeAttackAccrualFixAttr(buffMo, buffCo, buffActCo, paramArray, buffActInfo)
	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, math.abs(tonumber(buffActInfo.strParam) or 0) / 10)
end

function FightBuffGetDescHelper.formatActInfoStrParam(buffMo, buffCo, buffActCo, paramArray, buffActInfo)
	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, buffActInfo.strParam)
end

function FightBuffGetDescHelper.formatActInfoOneParam(buffMo, buffCo, buffActCo, paramArray, buffActInfo)
	local param = buffActInfo.param

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, param[1])
end

function FightBuffGetDescHelper.formatActInfoTwoParam(buffMo, buffCo, buffActCo, paramArray, buffActInfo)
	local param = buffActInfo.param

	return GameUtil.getSubPlaceholderLuaLangTwoParam(buffCo.desc, param[1], param[2])
end

function FightBuffGetDescHelper.getAttrByHeatScaleDesc(buffMo, buffCo, buffActCo, paramArray, buffActInfo)
	local param = buffActInfo.param

	return GameUtil.getSubPlaceholderLuaLangOneParam(buffCo.desc, param[1] / 10)
end

return FightBuffGetDescHelper
