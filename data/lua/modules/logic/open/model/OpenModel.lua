module("modules.logic.open.model.OpenModel", package.seeall)

slot0 = class("OpenModel", BaseModel)

function slot0.onInit(slot0)
	slot0._unlocks = {}
end

function slot0.reInit(slot0)
	slot0._unlocks = {}
end

function slot0.setOpenInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = tonumber(slot6.id)

		if VersionValidator.instance:isInReviewing() then
			slot8 = slot6.isOpen and OpenConfig.instance:getOpenCo(slot7).verifingHide == 0
		end

		slot0._unlocks[slot7] = slot8
	end
end

function slot0.updateOpenInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = tonumber(slot6.id)

		if VersionValidator.instance:isInReviewing() then
			slot8 = slot6.isOpen and OpenConfig.instance:getOpenCo(slot7).verifingHide == 0
		end

		slot0._unlocks[slot7] = slot8
	end
end

function slot0.isFunctionUnlock(slot0, slot1)
	return slot0._unlocks[tonumber(slot1)]
end

function slot0.isFuncBtnShow(slot0, slot1)
	slot2 = OpenConfig.instance:getOpenCo(slot1)

	if VersionValidator.instance:isInReviewing() and slot2.verifingHide == 1 then
		return false
	end

	if tonumber(slot2.isOnline) == 0 then
		return false
	end

	return tonumber(slot2.isAlwaysShowBtn) > 0 or slot0._unlocks[slot1]
end

function slot0.getFuncUnlockDesc(slot0, slot1)
	if OpenConfig.instance:getOpenCo(slot1).dec == 2003 then
		if (not VersionValidator.instance:isInReviewing() or not slot2.verifingEpisodeId) and not slot2.episodeId or slot4 == 0 then
			return slot3
		end

		return slot3, DungeonConfig.instance:getEpisodeDisplay(slot4)
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
