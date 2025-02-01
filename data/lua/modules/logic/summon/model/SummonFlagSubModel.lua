module("modules.logic.summon.model.SummonFlagSubModel", package.seeall)

slot0 = class("SummonFlagSubModel", BaseModel)

function slot0.init(slot0)
	slot0._isNew = false
	slot0._newFlagDict = {}

	slot0:initLocalSave()
end

function slot0.initLocalSave(slot0)
	slot0._lastDict = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(slot0:getLocalKey(), "")) then
		for slot6, slot7 in ipairs(cjson.decode(slot1)) do
			slot0._lastDict[slot7] = 1
		end
	end
end

function slot0.compareRecord(slot0, slot1)
	slot0._newFlagDict = {}
	slot2 = {}

	for slot6 = 1, #slot1 do
		if not slot0._lastDict[slot1[slot6].id] then
			slot0._newFlagDict[slot7.id] = 1
		end

		slot2[slot7.id] = 1
	end

	slot3 = false

	for slot7, slot8 in pairs(slot0._lastDict) do
		if not slot2[slot7] then
			slot0._lastDict[slot7] = nil
			slot3 = true
		end
	end

	if slot3 then
		slot0:flush()
	end

	SummonController.instance:dispatchEvent(SummonEvent.onNewPoolChanged)
end

function slot0.cleanFlag(slot0, slot1)
	if slot0._newFlagDict[slot1] then
		slot0._newFlagDict[slot1] = nil
		slot0._lastDict[slot1] = 1

		slot0:flush()
		SummonController.instance:dispatchEvent(SummonEvent.onNewPoolChanged)
	end
end

function slot0.hasNew(slot0)
	if slot0._newFlagDict and next(slot0._newFlagDict) then
		return true
	end

	return false
end

function slot0.isNew(slot0, slot1)
	if slot0._newFlagDict and slot0._newFlagDict[slot1] then
		return true
	end

	return false
end

function slot0.flush(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._lastDict) do
		table.insert(slot1, slot5)
	end

	PlayerPrefsHelper.setString(slot0:getLocalKey(), cjson.encode(slot1))
end

function slot0.getLocalKey(slot0)
	return "SummonFlagSubModel#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return slot0
