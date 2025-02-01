module("framework.core.pool.LuaObjPool", package.seeall)

slot0 = class("LuaObjPool")

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0._maxCount = slot1
	slot0._newFunc = slot2
	slot0._releaseFunc = slot3
	slot0._resetFunc = slot4

	if slot1 == nil or slot2 == nil or slot3 == nil or slot4 == nil then
		logError("LuaObjPool, 对象池构造，所有参数都不能为nil")
	end

	if slot0._maxCount == 0 then
		slot0._maxCount = 32
	end

	slot0._cacheList = {}
end

function slot0.getObject(slot0)
	if #slot0._cacheList < 1 then
		return slot0._newFunc()
	else
		return table.remove(slot0._cacheList)
	end
end

function slot0.putObject(slot0, slot1)
	slot0._resetFunc(slot1)

	if slot0._maxCount <= #slot0._cacheList then
		slot0._releaseFunc(slot1)
	elseif not tabletool.indexOf(slot0._cacheList, slot1) then
		table.insert(slot0._cacheList, slot1)
	end
end

function slot0.dispose(slot0)
	if #slot0._cacheList == 0 then
		return
	end

	slot2 = nil

	for slot6 = 1, slot1 do
		slot0._releaseFunc(slot0._cacheList[slot6])

		slot0._cacheList[slot6] = nil
	end
end

return slot0
