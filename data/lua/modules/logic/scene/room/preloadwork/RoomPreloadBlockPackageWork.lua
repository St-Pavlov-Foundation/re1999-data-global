module("modules.logic.scene.room.preloadwork.RoomPreloadBlockPackageWork", package.seeall)

slot0 = class("RoomPreloadBlockPackageWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._loader = MultiAbLoader.New()

	for slot6, slot7 in ipairs(slot0:_getMapBlockUrlList()) do
		slot0._loader:addPath(slot7)
	end

	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0, slot1)
	for slot6, slot7 in pairs(slot1:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6, slot7)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("RoomPreloadBlockPackageWork: 加载失败, url: " .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getMapBlockUrlList(slot0)
	slot1 = {}
	slot2 = {}
	slot4 = {
		[slot13] = true
	}

	for slot9, slot10 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		slot11 = slot10.defineId
		slot0.context.resABDict[RoomResHelper.getBlockPath(slot11)] = RoomResHelper.getBlockABPath(slot11)
	end

	for slot9, slot10 in pairs({
		[slot12] = true
	}) do
		table.insert(slot1, slot9)
	end

	for slot9, slot10 in pairs(slot4) do
		table.insert(slot2, slot9)
	end

	for slot9, slot10 in ipairs(slot1) do
		slot0.context.poolGODict[slot10] = 0
	end

	return slot2
end

return slot0
