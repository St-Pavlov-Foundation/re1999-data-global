module("modules.logic.antique.model.AntiqueModel", package.seeall)

slot0 = class("AntiqueModel", BaseModel)

function slot0.onInit(slot0)
	slot0._antiqueList = {}
end

function slot0.reInit(slot0)
	slot0._antiqueList = {}
end

function slot0.getAntique(slot0, slot1)
	return slot0._antiqueList[slot1]
end

function slot0.getAntiqueList(slot0)
	return slot0._antiqueList
end

function slot0.setAntiqueInfo(slot0, slot1)
	slot0._antiqueList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = AntiqueMo.New()

		slot7:init(slot6)

		slot0._antiqueList[tonumber(slot6.antiqueId)] = slot7
	end
end

function slot0.updateAntiqueInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0._antiqueList[slot6.antiqueId] then
			slot7 = AntiqueMo.New()

			slot7:init(slot6)

			slot0._antiqueList[tonumber(slot6.antiqueId)] = slot7
		else
			slot0._antiqueList[slot6.antiqueId]:reset(slot6)
		end
	end
end

function slot0.getAntiqueGetTime(slot0, slot1)
	return slot0._antiqueList[slot1] or 0
end

function slot0.getAntiques(slot0)
	return slot0._antiqueList
end

function slot0.isAntiqueUnlock(slot0)
	return next(slot0._antiqueList)
end

slot0.instance = slot0.New()

return slot0
