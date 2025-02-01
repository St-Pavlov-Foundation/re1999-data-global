module("modules.logic.versionactivity1_6.act152.model.Activity152Model", package.seeall)

slot0 = class("Activity152Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._act152Presents = {}
end

function slot0.setActivity152Infos(slot0, slot1)
	slot0._act152Presents = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0._act152Presents, slot6)
	end
end

function slot0.setActivity152PresentGet(slot0, slot1)
	table.insert(slot0._act152Presents, slot1)
end

function slot0.getActivity152Presents(slot0)
	return slot0._act152Presents
end

function slot0.isPresentAccepted(slot0, slot1)
	for slot5, slot6 in pairs(slot0._act152Presents) do
		if slot6 == slot1 then
			return true
		end
	end

	slot2 = AntiqueModel.instance:getAntiqueList()

	for slot8, slot9 in ipairs(string.split(Activity152Config.instance:getAct152Co(slot1).bonus, "|")) do
		if string.splitToNumber(slot9, "#")[1] == MaterialEnum.MaterialType.Antique and slot10[2] == slot1 then
			return true
		end
	end

	return false
end

function slot0.getPresentUnaccepted(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(slot0:getAllUnlockPresents()) do
		if not slot0:isPresentAccepted(slot7) then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getAllUnlockPresents(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(Activity152Config.instance:getAct152Cos()) do
		if TimeUtil.stringToTimestamp(slot7.acceptDate) <= ServerTime.now() then
			table.insert(slot2, slot7.presentId)
		end
	end

	return slot2
end

function slot0.hasPresentAccepted(slot0)
	for slot5, slot6 in pairs(slot0:getAllUnlockPresents()) do
		if slot0:isPresentAccepted(slot6) then
			return true
		end
	end

	return false
end

function slot0.getNextUnlockLimitTime(slot0)
	slot2 = -1

	for slot6, slot7 in pairs(Activity152Config.instance:getAct152Cos()) do
		if ServerTime.now() <= TimeUtil.stringToTimestamp(slot7.acceptDate) and (slot2 == -1 or slot2 > slot8 - ServerTime.now()) then
			slot2 = slot8 - ServerTime.now()
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
