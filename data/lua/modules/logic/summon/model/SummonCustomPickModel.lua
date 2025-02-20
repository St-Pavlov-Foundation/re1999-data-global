module("modules.logic.summon.model.SummonCustomPickModel", package.seeall)

slot0 = class("SummonCustomPickModel", BaseModel)

function slot0.isCustomPickOver(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1) and slot2.customPickMO then
		return slot2.customPickMO:isPicked(slot1)
	end

	return false
end

function slot0.isHaveFirstSSR(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1) and slot2.customPickMO then
		return slot2.customPickMO:isHaveFirstSSR()
	end

	return false
end

function slot0.getMaxSelectCount(slot0, slot1)
	slot3 = -1

	if SummonConfig.instance:getSummonPool(slot1) then
		if slot2.type == SummonEnum.Type.StrongCustomOnePick then
			slot3 = 1
		elseif string.split(slot2.param, "|") and #slot4 > 0 then
			slot3 = tonumber(slot4[1]) or 0
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
