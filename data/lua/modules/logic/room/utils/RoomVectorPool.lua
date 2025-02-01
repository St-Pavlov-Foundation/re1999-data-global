module("modules.logic.room.utils.RoomVectorPool", package.seeall)

slot0 = class("RoomVectorPool")

function slot0.ctor(slot0)
	slot0._posList = {}
	slot0._xCache = {}
	slot0._yCache = {}
	slot0._zCache = {}
end

function slot0.packPosList(slot0, slot1)
	slot2 = {}
	slot6 = slot0._yCache

	ZProj.AStarPathBridge.PosListToLuaTable(slot1, slot0._xCache, slot6, slot0._zCache)

	for slot6 = 1, #slot0._xCache do
		slot7 = slot0:get()
		slot7.z = slot0._zCache[slot6]
		slot7.y = slot0._yCache[slot6]
		slot7.x = slot0._xCache[slot6]

		table.insert(slot2, slot7)
	end

	slot0:cleanTable(slot0._xCache)
	slot0:cleanTable(slot0._yCache)
	slot0:cleanTable(slot0._zCache)

	return slot2
end

function slot0.get(slot0)
	if #slot0._posList > 0 then
		slot0._posList[slot1] = nil

		return slot0._posList[slot1]
	end

	return Vector3.New()
end

function slot0.recycle(slot0, slot1)
	slot1:Set(0, 0, 0)
	table.insert(slot0._posList, slot1)
end

function slot0.clean(slot0)
	slot0:cleanTable(slot0._posList)
end

function slot0.cleanTable(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot1[slot5] = nil
	end
end

slot0.instance = slot0.New()

return slot0
