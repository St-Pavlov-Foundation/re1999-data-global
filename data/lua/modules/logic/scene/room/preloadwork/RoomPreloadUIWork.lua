module("modules.logic.scene.room.preloadwork.RoomPreloadUIWork", package.seeall)

slot0 = class("RoomPreloadUIWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._loader = MultiAbLoader.New()

	for slot6, slot7 in ipairs(slot0:_getUIUrlList()) do
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
	logError("RoomPreloadUIWork: 加载失败, url: " .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getUIUrlList(slot0)
	slot1 = {}

	if RoomController.instance:isDebugPackageMode() then
		table.insert(slot1, RoomScenePreloader.ResDebugPackageUI)
	end

	table.insert(slot1, RoomViewConfirm.prefabPath)

	for slot5, slot6 in ipairs(slot1) do
		slot0.context.poolUIDict[slot6] = true
	end

	return slot1
end

return slot0
