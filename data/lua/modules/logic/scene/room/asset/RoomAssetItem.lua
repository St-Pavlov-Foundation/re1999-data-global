module("modules.logic.scene.room.asset.RoomAssetItem", package.seeall)

slot0 = class("RoomAssetItem")

function slot0.ctor(slot0)
	slot0._initialized = false
	slot0.createTime = 0
	slot0._refCount = 0
end

function slot0.init(slot0, slot1, slot2)
	if slot0._initialized then
		logError(string.format("初始化失败: [RoomAssetItem] ab: %s", tostring(slot2)))

		return
	end

	slot0._refCount = 0
	slot0._abPath = slot2
	slot0._initialized = true
	slot0._assetItem = slot1

	slot1:Retain()

	slot0._cacheResourceDict = {}
	slot0.createTime = Time.time
end

function slot0.getResource(slot0, slot1)
	if not slot0._initialized then
		return
	end

	if slot0._cacheResourceDict[slot1] then
		return slot2
	end

	slot2 = slot0._assetItem:GetResource(slot1)
	slot0._cacheResourceDict[slot1] = slot2

	if not slot2 then
		logError(string.format("获取资源失败, [RoomAssetItem] res: %s, ab: %s", tostring(slot1), tostring(slot0._abPath)))
	end

	return slot2
end

function slot0.dispose(slot0)
	slot0._initialized = false

	if slot0._cacheResourceDict then
		slot0._cacheResourceDict = nil

		for slot5, slot6 in pairs(slot0._cacheResourceDict) do
			slot1[slot5] = nil
		end
	end

	if slot0._assetItem then
		slot0._assetItem:Release()

		slot0._assetItem = nil
	end

	slot0._refCount = 0
end

function slot0.retain(slot0)
	if slot0._initialized then
		slot0._refCount = slot0._refCount + 1
	end
end

function slot0.release(slot0)
	if not slot0._initialized then
		return
	end

	if slot0._refCount <= 1 then
		slot0._refCount = 0

		slot0:dispose()
	else
		slot0._refCount = slot0._refCount - 1
	end
end

slot0.GetResource = slot0.getResource
slot0.Release = slot0.release
slot0.Retain = slot0.retain
slot0.Dispose = slot0.dispose

return slot0
