module("modules.logic.room.entity.comp.RoomEffectCompCacheData", package.seeall)

slot0 = class("RoomEffectCompCacheData")

function slot0.ctor(slot0, slot1)
	slot0.effectComp = slot1
	slot0._cacheDataDic = {}
end

function slot0.getUserDataTb_(slot0)
	return slot0.effectComp:getUserDataTb_()
end

function slot0.addDataByKey(slot0, slot1, slot2, slot3)
	if not slot0._cacheDataDic[slot2] then
		slot4[slot2] = {}
	end

	slot5[slot1] = slot3
end

function slot0.getDataByKey(slot0, slot1, slot2)
	if slot0._cacheDataDic[slot2] then
		return slot4[slot1]
	end
end

function slot0.removeDataByKey(slot0, slot1)
	for slot6, slot7 in pairs(slot0._cacheDataDic) do
		if slot7[slot1] then
			slot0:_removeData(slot8)
			rawset(slot7, slot1, nil)
		end
	end
end

function slot0._removeData(slot0, slot1)
	if slot1 and type(slot1) == "table" then
		for slot5 in pairs(slot1) do
			rawset(slot1, slot5, nil)
		end
	end
end

function slot0.dispose(slot0)
	for slot5, slot6 in pairs(slot0._cacheDataDic) do
		for slot10, slot11 in pairs(slot6) do
			if slot11 then
				rawset(slot6, slot10, nil)
				slot0:_removeData(slot11)
			end
		end

		slot1[slot5] = nil
	end
end

return slot0
