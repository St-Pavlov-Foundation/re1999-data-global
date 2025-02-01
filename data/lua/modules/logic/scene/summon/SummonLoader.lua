module("modules.logic.scene.summon.SummonLoader", package.seeall)

slot0 = class("SummonLoader")

function slot0.init(slot0, slot1)
	slot0._resList = slot1
	slot0.loadABCount = 5
	slot0.callbackPerFrameCount = 2
	slot0._isLoaded = false
	slot0._isLoading = false
	slot0._needSyncLoad = false
	slot0._assetItemDict = {}
	slot0._loadFrameBuffer = nil
	slot0._loadOneCallback = nil
	slot0._loadOneCallbackObj = nil
	slot0._loadAllCallback = nil
	slot0._loadAllCallbackObj = nil
end

function slot0.checkStartLoad(slot0, slot1)
	slot0._needSyncLoad = slot0._needSyncLoad or slot1

	if not slot0._isLoaded and not slot0._isLoading then
		slot0:startLoad()
	end
end

function slot0.startLoad(slot0)
	if not slot0._resList then
		logError("_resList need be filled!")

		return
	end

	slot0._isLoading = true
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:setPathList(slot0._resList)
	slot0._loader:setConcurrentCount(slot0.loadABCount)
	slot0._loader:startLoad(slot0.onLoadCompletedSwitch, slot0)
end

function slot0.onLoadCompletedSwitch(slot0)
	logNormal("onLoadCompletedSwitch")

	if not slot0._isLoading then
		return
	end

	if slot0._needSyncLoad then
		slot0:onLoadCompletedSync()
	else
		slot0:onLoadCompletedAsync()
	end
end

function slot0.onLoadCompletedSync(slot0)
	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		if slot0._loadOneCallback then
			slot6:Retain()

			slot0._assetItemDict[slot5] = slot6

			slot0:doOneItemCallback(slot5, slot6)
		end
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._isLoading = false
	slot0._isLoaded = true

	slot0:doAllItemCallback()
end

function slot0.onLoadCompletedAsync(slot0)
	slot0._loadFrameBuffer = slot0._loadFrameBuffer or {}

	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot6:Retain()

		slot0._assetItemDict[slot5] = slot6

		table.insert(slot0._loadFrameBuffer, slot5)
	end

	if slot0._uiLoader then
		slot0._uiLoader:dispose()

		slot0._uiLoader = nil
	end

	TaskDispatcher.runRepeat(slot0.repeatCallbackFrame, slot0, 0.001)
end

function slot0.repeatCallbackFrame(slot0)
	if not slot0._isLoading or slot0._isLoaded then
		TaskDispatcher.cancelTask(slot0.repeatCallbackFrame, slot0)

		return
	end

	slot1 = slot0.callbackPerFrameCount

	if slot0._needSyncLoad then
		slot1 = 9999
	end

	for slot5 = 1, slot1 do
		if #slot0._loadFrameBuffer > 0 then
			slot0._loadFrameBuffer[slot6] = nil

			if slot0._assetItemDict[slot0._loadFrameBuffer[slot6]] then
				slot0:doOneItemCallback(slot7, slot8)
			end
		else
			TaskDispatcher.cancelTask(slot0.repeatCallbackFrame, slot0)

			slot0._isLoading = false
			slot0._isLoaded = true

			slot0:doAllItemCallback()

			return
		end
	end
end

function slot0.setLoadOneItemCallback(slot0, slot1, slot2)
	slot0._loadOneCallback = slot1
	slot0._loadOneCallbackObj = slot2
end

function slot0.setLoadFinishCallback(slot0, slot1, slot2)
	slot0._loadAllCallback = slot1
	slot0._loadAllCallbackObj = slot2
end

function slot0.doOneItemCallback(slot0, slot1, slot2)
	if not slot0._loadOneCallback then
		return
	end

	if slot0._loadOneCallbackObj then
		slot0._loadOneCallback(slot0._loadOneCallbackObj, slot1, slot2)
	else
		slot0._loadOneCallback(slot1, slot2)
	end
end

function slot0.doAllItemCallback(slot0)
	if not slot0._loadAllCallback then
		return
	end

	if slot0._loadAllCallbackObj then
		slot0._loadAllCallback(slot0._loadAllCallbackObj, slot0)
	else
		slot0:_loadAllCallback()
	end
end

function slot0.getAssetItem(slot0, slot1)
	if slot0._assetItemDict[slot1] then
		return slot2
	end
end

function slot0.dispose(slot0)
	if not slot0._isDisposed then
		slot0._isDisposed = true
		slot0._isLoading = false
		slot0._isLoaded = false

		TaskDispatcher.cancelTask(slot0.repeatCallbackFrame, slot0)

		if slot0._loader then
			slot0._loader:dispose()

			slot0._loader = nil
		end

		for slot4, slot5 in pairs(slot0._assetItemDict) do
			slot5:Release()

			slot0._assetItemDict[slot4] = nil
		end

		slot0._assetItemDict = nil
	end
end

return slot0
