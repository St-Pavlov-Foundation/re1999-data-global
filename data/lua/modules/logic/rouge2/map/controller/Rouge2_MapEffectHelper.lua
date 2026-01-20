-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapEffectHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapEffectHelper", package.seeall)

local Rouge2_MapEffectHelper = class("Rouge2_MapEffectHelper")

function Rouge2_MapEffectHelper.checkHadEffect(type, param)
	local effectDict = Rouge2_Model.instance:getEffectDict()

	if not effectDict then
		return false
	end

	Rouge2_MapEffectHelper._initEffectHandle()

	local handle = Rouge2_MapEffectHelper.effectHandleDict[type]

	if not handle then
		return false
	end

	for _, effectCo in pairs(effectDict) do
		if effectCo.type == type and handle(effectCo, param) then
			return true
		end
	end

	return false
end

function Rouge2_MapEffectHelper._initEffectHandle()
	if not Rouge2_MapEffectHelper.effectHandleDict then
		Rouge2_MapEffectHelper.effectHandleDict = {
			[Rouge2_MapEnum.EffectType.UnlockRestRefresh] = Rouge2_MapEffectHelper.defaultCheck,
			[Rouge2_MapEnum.EffectType.UnlockFightDropRefresh] = Rouge2_MapEffectHelper._checkUnlockFightDropRefresh,
			[Rouge2_MapEnum.EffectType.UnlockShowPassFightMask] = Rouge2_MapEffectHelper._checkUnlockShowPassFightMask
		}
	end
end

function Rouge2_MapEffectHelper.defaultCheck(effectCo)
	return true
end

function Rouge2_MapEffectHelper._checkUnlockFightDropRefresh(effectCo, fightType)
	local paramList = string.splitToNumber(effectCo.typeParam, "#")

	return paramList[1] == fightType
end

function Rouge2_MapEffectHelper._checkUnlockShowPassFightMask(effectCo, fightType)
	return tonumber(effectCo.typeParam) == fightType
end

return Rouge2_MapEffectHelper
