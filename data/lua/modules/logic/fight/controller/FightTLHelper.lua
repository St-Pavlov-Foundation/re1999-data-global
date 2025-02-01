module("modules.logic.fight.controller.FightTLHelper", package.seeall)

slot0 = _M

function slot0.getTableParam(slot0, slot1, slot2)
	if slot2 then
		return FightStrUtil.instance:getSplitToNumberCache(slot0, slot1)
	else
		return FightStrUtil.instance:getSplitCache(slot0, slot1)
	end
end

function slot0.getBoolParam(slot0)
	return slot0 == "1"
end

function slot0.getNumberParam(slot0)
	return tonumber(slot0)
end

return slot0
