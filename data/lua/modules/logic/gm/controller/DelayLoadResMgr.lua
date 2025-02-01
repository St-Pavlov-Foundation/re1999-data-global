module("modules.logic.gm.controller.DelayLoadResMgr", package.seeall)

slot0 = class("ResObj")
slot0.Stage = {
	Using = 2,
	Callbacking = 3,
	InPool = 4,
	Init = 1
}

function slot0.ctor(slot0)
	slot0.stage = uv0.Stage.Init
	slot0.resUrl = nil
	slot0.startLoadTime = nil
	slot0.startLoadFrame = nil
	slot0.realLoadedTime = nil
	slot0.delayTime = nil
	slot0.assetItem = nil
	slot0.callbackList = {}
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.stage = uv0.Stage.Using
	slot0.resUrl = slot1
	slot0.startLoadTime = slot2
	slot0.startLoadFrame = slot3
end

function slot0.addCallback(slot0, slot1, slot2)
	if slot0.stage ~= uv0.Stage.Using then
		logError("【add】 callback error, cur stage : " .. slot0.stage)

		return
	end

	table.insert(slot0.callbackList, DelayLoadResMgr.instance:getResCallbackObj(slot1, slot2))
end

function slot0.removeCallback(slot0, slot1, slot2)
	if slot0.stage ~= uv0.Stage.Using then
		logError("【remove】 callback error, cur stage : " .. slot0.stage)

		return
	end

	for slot6 = #slot0.callbackList, 1, -1 do
		if slot0.callbackList[slot6].callback == slot1 and slot7.callbackObj == slot2 then
			DelayLoadResMgr.instance:recycleResCallbackObj(slot7)
			table.remove(slot0.callbackList, slot6)
		end
	end
end

function slot0.hadAnyOneCallback(slot0)
	return #slot0.callbackList > 0
end

function slot0.doCallbackAddRecycle(slot0)
	slot0.stage = uv0.Stage.Callbacking

	for slot4, slot5 in ipairs(slot0.callbackList) do
		if slot5.callbackObj then
			slot5.callback(slot7, slot0.assetItem)
		else
			slot6(slot0.assetItem)
		end
	end

	DelayLoadResMgr.instance:recycleResObj(slot0)
end

function slot0.reset(slot0)
	slot0.stage = uv0.Stage.InPool
	slot0.resUrl = nil
	slot0.startLoadTime = nil
	slot0.startLoadFrame = nil
	slot0.realLoadedTime = nil
	slot0.delayTime = nil

	if slot0.assetItem then
		slot0.assetItem:Release()
	end

	slot0.assetItem = nil

	for slot4, slot5 in ipairs(slot0.callbackList) do
		DelayLoadResMgr.instance:recycleResCallbackObj(slot5)
	end

	tabletool.clear(slot0.callbackList)
end

slot1 = class("DelayLoadResMgr")
slot1.DelayStrategyEnum = {
	Multiple = 1,
	Fixed = 2
}
slot1.DelayStrategyName = {
	[slot1.DelayStrategyEnum.Multiple] = "延长倍数",
	[slot1.DelayStrategyEnum.Fixed] = "延长固定时间"
}

function slot1.ctor(slot0)
	slot0.srcLoadAbAsset = loadAbAsset
	slot0.srcLoadNonAbAsset = loadNonAbAsset
	slot0.srcLoadPersistentRes = loadPersistentRes
	slot0.srcRemoveAssetLoadCb = removeAssetLoadCb
	slot0.loadingResDict = {}
	slot0.loadedResDict = {}
	slot0.doingCallbackList = {}
	slot0.resPool = {}
	slot0.callbackObjPool = {}
	slot0.enablePatternList = {}
	slot0.disablePatternList = {
		"ui/viewres/"
	}
	slot0.strategy = uv0.DelayStrategyEnum.Multiple
	slot0.strategyValue = 2
	slot0.frameHandle = UpdateBeat:CreateListener(slot0._onFrame, slot0)
end

function slot1.setDelayStrategy(slot0, slot1)
	slot0.strategy = slot1
end

function slot1.getDelayStrategy(slot0)
	return slot0.strategy
end

function slot1.setDelayStrategyValue(slot0, slot1)
	slot0.strategyValue = slot1
end

function slot1.getDelayStrategyValue(slot0)
	return slot0.strategyValue
end

function slot1.setEnablePatternList(slot0, slot1)
	tabletool.clear(slot0.enablePatternList)

	for slot5, slot6 in ipairs(slot1) do
		if not string.nilorempty(slot6) then
			slot0.enablePatternList[#slot0.enablePatternList + 1] = slot6
		end
	end
end

function slot1.setDisablePatternList(slot0, slot1)
	tabletool.clear(slot0.disablePatternList)

	for slot5, slot6 in ipairs(slot1) do
		if not string.nilorempty(slot6) then
			slot0.disablePatternList[#slot0.disablePatternList + 1] = slot6
		end
	end
end

function slot1.getEnablePatternList(slot0)
	return slot0.enablePatternList
end

function slot1.getDisablePatternList(slot0)
	return slot0.disablePatternList
end

function slot1.startDelayLoad(slot0)
	slot0.start = true

	setGlobal("loadAbAsset", uv0.LoadAbAssetWrap)
	setGlobal("loadNonAbAsset", uv0.LoadNonAbAssetWrap)
	setGlobal("loadPersistentRes", uv0.LoadPersistentResWrap)
	setGlobal("removeAssetLoadCb", uv0.RemoveAssetLoadCbWrap)
	UpdateBeat:AddListener(slot0.frameHandle)
end

function slot1.stopDelayLoad(slot0)
	for slot4, slot5 in pairs(slot0.loadingResDict) do
		slot0:recycleResObj(slot5)
	end

	for slot4, slot5 in pairs(slot0.loadedResDict) do
		slot0:recycleResObj(slot5)
	end

	for slot4, slot5 in ipairs(slot0.doingCallbackList) do
		slot0:recycleResObj(slot5)
	end

	tabletool.clear(slot0.loadingResDict)
	tabletool.clear(slot0.loadedResDict)
	tabletool.clear(slot0.doingCallbackList)

	slot0.start = false

	setGlobal("loadAbAsset", slot0.srcLoadAbAsset)
	setGlobal("loadNonAbAsset", slot0.srcLoadNonAbAsset)
	setGlobal("loadPersistentRes", slot0.srcLoadPersistentRes)
	setGlobal("removeAssetLoadCb", slot0.srcRemoveAssetLoadCb)
	UpdateBeat:RemoveListener(slot0.frameHandle)
end

function slot1.getResObj(slot0)
	if #slot0.resPool > 0 then
		return table.remove(slot0.resPool)
	end

	return uv0.New()
end

function slot1.recycleResObj(slot0, slot1)
	slot1:reset()
	table.insert(slot0.resPool, slot1)
end

function slot1.recycleResCallbackObj(slot0, slot1)
	tabletool.clear(slot1)
	table.insert(slot0.callbackObjPool, slot1)
end

function slot1.getResCallbackObj(slot0, slot1, slot2)
	slot3 = nil
	slot3 = (#slot0.callbackObjPool <= 0 or table.remove(slot0.callbackObjPool)) and {}
	slot3.callback = slot1
	slot3.callbackObj = slot2

	return slot3
end

function slot1.isStartDelayLoad(slot0)
	return slot0.start
end

function slot1.getLoadingResObj(slot0, slot1)
	return slot0.loadingResDict[slot1]
end

function slot1.addLoadingResObj(slot0, slot1)
	slot0.loadingResDict[slot1.resUrl] = slot1
end

function slot1.removeLoadingResObj(slot0, slot1)
	slot0.loadingResDict[slot1.resUrl] = nil
end

function slot1.getLoadedResObj(slot0, slot1)
	return slot0.loadedResDict[slot1]
end

function slot1.addLoadedResObj(slot0, slot1)
	slot0.loadedResDict[slot1.resUrl] = slot1
end

function slot1.removeLoadedResObj(slot0, slot1)
	slot0.loadedResDict[slot1.resUrl] = nil
end

function slot1.checkNeedDelay(slot0, slot1)
	if not slot0.start then
		return false
	end

	if slot0:checkIsDisableFile(slot1) then
		return false
	end

	if #slot0.enablePatternList <= 0 then
		return true
	end

	for slot5, slot6 in ipairs(slot0.enablePatternList) do
		if string.match(slot1, slot6) then
			return true
		end
	end

	return false
end

function slot1.checkIsDisableFile(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.disablePatternList) do
		if string.match(slot1, slot6) then
			return true
		end
	end

	return false
end

function slot1.getDelayTime(slot0, slot1)
	if not slot0.start then
		return 0
	end

	if slot0.strategy == uv0.DelayStrategyEnum.Fixed then
		return slot0.strategyValue
	else
		return (slot1.realLoadedTime - slot1.startLoadTime) * slot0.strategyValue
	end
end

function slot1._onFrame(slot0)
	tabletool.clear(slot0.doingCallbackList)

	for slot5, slot6 in pairs(slot0.loadedResDict) do
		if slot6.realLoadedTime and slot6.delayTime <= UnityEngine.Time.time - slot6.realLoadedTime then
			table.insert(slot0.doingCallbackList, slot6)
		end
	end

	for slot5, slot6 in ipairs(slot0.doingCallbackList) do
		slot0:removeLoadedResObj(slot6)
		slot6:doCallbackAddRecycle()
	end
end

function slot1.loadAssetBase(slot0, slot1, slot2, slot3)
	uv0.log("load Asset Base : " .. slot1)

	if not (slot0:getLoadingResObj(slot1) ~= nil) then
		slot4 = slot0:getResObj()

		slot4:init(slot1, UnityEngine.Time.time, UnityEngine.Time.frameCount)
		slot0:addLoadingResObj(slot4)
	end

	slot4:addCallback(slot2, slot3)

	return slot5
end

function slot1.LoadAbAssetWrap(slot0, slot1, slot2, slot3)
	if not uv0.instance:loadAssetBase(slot0, slot2, slot3) then
		uv0.instance.srcLoadAbAsset(slot0, slot1, uv0.onLoadAssetDone)
	end
end

function slot1.LoadNonAbAssetWrap(slot0, slot1, slot2, slot3)
	if not uv0.instance:loadAssetBase(slot0, slot2, slot3) then
		uv0.instance.srcLoadNonAbAsset(slot0, slot1, uv0.onLoadAssetDone)
	end
end

function slot1.LoadPersistentResWrap(slot0, slot1, slot2, slot3)
	if not uv0.instance:loadAssetBase(slot0, slot2, slot3) then
		uv0.instance.srcLoadPersistentRes(slot0, slot1, uv0.onLoadAssetDone)
	end
end

function slot1.RemoveAssetLoadCbWrap(slot0, slot1, slot2)
	if uv0.instance:getLoadedResObj(slot0) then
		uv0.log("remove asset load : " .. slot0)
		slot3:removeCallback(slot1, slot2)
		uv0.instance:tryRecycleResObj(slot3)
	end

	if uv0.instance:getLoadingResObj(slot0) then
		uv0.log("remove asset load : " .. slot0)
		slot3:removeCallback(slot1, slot2)
		uv0.instance:tryRecycleResObj(slot3)
	end
end

function slot1.tryRecycleResObj(slot0, slot1)
	if not slot1:hadAnyOneCallback() then
		uv0.instance:removeLoadingResObj(slot1)
		uv0.instance:recycleResObj(slot1)
		uv0.instance.srcRemoveAssetLoadCb(slot1.resUrl, uv0.onLoadAssetDone)
	end
end

function slot1.onLoadAssetDone(slot0)
	if not uv0.instance:getLoadingResObj(slot0.ResPath) then
		return
	end

	slot2.assetItem = slot0

	slot0:Retain()
	uv0.instance:removeLoadingResObj(slot2)

	if UnityEngine.Time.frameCount == slot2.startLoadFrame then
		uv0.log(string.format("%s 在同一帧加载完", slot1))
		slot2:doCallbackAddRecycle()

		return
	end

	if not uv0.instance:checkNeedDelay(slot1) then
		uv0.log(string.format("%s 不需要延迟", slot1))
		slot2:doCallbackAddRecycle()

		return
	end

	uv0.instance:addLoadedResObj(slot2)

	slot2.realLoadedTime = UnityEngine.Time.time
	slot2.delayTime = uv0.instance:getDelayTime(slot2)

	uv0.log(string.format("%s 延迟了 %s 秒", slot1, slot2.delayTime))
end

function slot1.log(slot0)
	logNormal("[DelayLoadResMgr] " .. (slot0 or "") .. "\n" .. debug.traceback())
end

slot1.instance = slot1.New()

return slot1
