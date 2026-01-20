-- chunkname: @modules/logic/fight/controller/FightTLHelper.lua

module("modules.logic.fight.controller.FightTLHelper", package.seeall)

local FightTLHelper = _M

function FightTLHelper.getTableParam(paramStr, delimiter, isNumber)
	if isNumber then
		return FightStrUtil.instance:getSplitToNumberCache(paramStr, delimiter)
	else
		return FightStrUtil.instance:getSplitCache(paramStr, delimiter)
	end
end

function FightTLHelper.getBoolParam(paramStr)
	return paramStr == "1"
end

function FightTLHelper.getNumberParam(paramStr)
	return tonumber(paramStr)
end

return FightTLHelper
