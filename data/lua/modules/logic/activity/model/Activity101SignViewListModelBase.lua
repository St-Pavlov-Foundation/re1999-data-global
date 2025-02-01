module("modules.logic.activity.model.Activity101SignViewListModelBase", package.seeall)

slot0 = class("Activity101SignViewListModelBase", ListScrollModel)

function slot0.getViewportItemCount(slot0)
	return 7.2
end

function slot0.setList(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot1[slot6] then
			slot8.__isPlayedOpenAnim = slot7.__isPlayedOpenAnim
		end
	end

	uv0.super.setList(slot0, slot1)
end

function slot0.setDefaultPinStartIndex(slot0, slot1, slot2)
	slot2 = slot2 or 1

	if not slot1 or #slot1 == 0 then
		slot0:setStartPinIndex(1)

		return
	end

	slot0:setStartPinIndex(math.max(1, math.ceil(#slot1 - slot0:getViewportItemCount())) < slot2 and slot4 or 1)
end

function slot0.setStartPinIndex(slot0, slot1)
	slot0._startPinIndex = slot1
end

function slot0.getStartPinIndex(slot0)
	return slot0._startPinIndex or 1
end

return slot0
