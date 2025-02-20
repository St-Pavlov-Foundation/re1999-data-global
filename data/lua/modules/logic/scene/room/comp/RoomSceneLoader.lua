module("modules.logic.scene.room.comp.RoomSceneLoader", package.seeall)

slot0 = class("RoomSceneLoader", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._assetItemDict = {}
	slot0._loader = nil
	slot0._needLoadList = {}
	slot0._needLoadDict = {}
	slot0._callbackList = {}
	slot0._loaderList = {}
	slot0._initialized = false
end

function slot0.init(slot0, slot1, slot2)
	slot0._initialized = true
end

function slot0.isLoaderInProgress(slot0)
	if slot0._loader then
		return true
	end

	if slot0._needLoadList and #slot0._needLoadList > 0 then
		return true
	end

	return false
end

function slot0.makeSureLoaded(slot0, slot1, slot2, slot3)
	if not slot0._initialized then
		return
	end

	slot4 = nil

	for slot9, slot10 in ipairs(slot1) do
		if not slot0:getCurScene().preloader:exist(slot10) then
			table.insert(slot4 or {}, slot10)
		end
	end

	if not slot4 then
		slot2(slot3)

		return
	end

	slot6 = MultiAbLoader.New()

	table.insert(slot0._loaderList, slot6)
	slot6:setPathList(slot4)
	slot6:startLoad(function (...)
		uv0:_onLoadFinish(uv1)
		uv2(uv3)
	end, slot0)
end

function slot0._delayStartLoad(slot0)
	slot0._needLoadList = {}
	slot0._needLoadDict = {}
	slot0._loader = MultiAbLoader.New()

	slot0._loader:setPathList(slot0._needLoadList)
	slot0._loader:startLoad(slot0._onLoadFinish, slot0)
end

function slot0._onLoadFinish(slot0, slot1)
	for slot7, slot8 in pairs(slot1:getAssetItemDict()) do
		slot0:getCurScene().preloader:addAssetItem(slot7, slot8)
	end

	tabletool.removeValue(slot0._loaderList, slot1)
	slot1:dispose()
end

function slot0.onSceneClose(slot0)
	slot0._initialized = false
	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._delayStartLoad, slot4)

	for slot4, slot5 in ipairs(slot0._loaderList) do
		slot5:dispose()
	end

	slot0._loaderList = {}

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
