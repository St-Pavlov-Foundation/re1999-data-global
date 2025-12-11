module("modules.logic.gm.controller.DelayLoadResMgr", package.seeall)

local var_0_0 = class("ResObj")

var_0_0.Stage = {
	Using = 2,
	Callbacking = 3,
	InPool = 4,
	Init = 1
}

function var_0_0.ctor(arg_1_0)
	arg_1_0.stage = var_0_0.Stage.Init
	arg_1_0.resUrl = nil
	arg_1_0.startLoadTime = nil
	arg_1_0.startLoadFrame = nil
	arg_1_0.realLoadedTime = nil
	arg_1_0.delayTime = nil
	arg_1_0.assetItem = nil
	arg_1_0.callbackList = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.stage = var_0_0.Stage.Using
	arg_2_0.resUrl = arg_2_1
	arg_2_0.startLoadTime = arg_2_2
	arg_2_0.startLoadFrame = arg_2_3
end

function var_0_0.addCallback(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.stage ~= var_0_0.Stage.Using then
		logError("【add】 callback error, cur stage : " .. arg_3_0.stage)

		return
	end

	local var_3_0 = DelayLoadResMgr.instance:getResCallbackObj(arg_3_1, arg_3_2)

	table.insert(arg_3_0.callbackList, var_3_0)
end

function var_0_0.removeCallback(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.stage ~= var_0_0.Stage.Using then
		logError("【remove】 callback error, cur stage : " .. arg_4_0.stage)

		return
	end

	for iter_4_0 = #arg_4_0.callbackList, 1, -1 do
		local var_4_0 = arg_4_0.callbackList[iter_4_0]

		if var_4_0.callback == arg_4_1 and var_4_0.callbackObj == arg_4_2 then
			DelayLoadResMgr.instance:recycleResCallbackObj(var_4_0)
			table.remove(arg_4_0.callbackList, iter_4_0)
		end
	end
end

function var_0_0.hadAnyOneCallback(arg_5_0)
	return #arg_5_0.callbackList > 0
end

function var_0_0.doCallbackAddRecycle(arg_6_0)
	arg_6_0.stage = var_0_0.Stage.Callbacking

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.callbackList) do
		local var_6_0 = iter_6_1.callback
		local var_6_1 = iter_6_1.callbackObj

		if var_6_1 then
			var_6_0(var_6_1, arg_6_0.assetItem)
		else
			var_6_0(arg_6_0.assetItem)
		end
	end

	DelayLoadResMgr.instance:recycleResObj(arg_6_0)
end

function var_0_0.setAssetItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1

	arg_7_0.assetItem = arg_7_1

	if arg_7_1 then
		arg_7_1:Retain()
	end

	if var_7_0 then
		var_7_0:Release()
	end
end

function var_0_0.reset(arg_8_0)
	arg_8_0.stage = var_0_0.Stage.InPool
	arg_8_0.resUrl = nil
	arg_8_0.startLoadTime = nil
	arg_8_0.startLoadFrame = nil
	arg_8_0.realLoadedTime = nil
	arg_8_0.delayTime = nil

	if arg_8_0.assetItem then
		arg_8_0.assetItem:Release()
	end

	arg_8_0.assetItem = nil

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.callbackList) do
		DelayLoadResMgr.instance:recycleResCallbackObj(iter_8_1)
	end

	tabletool.clear(arg_8_0.callbackList)
end

local var_0_1 = class("DelayLoadResMgr")

var_0_1.DelayStrategyEnum = {
	Multiple = 1,
	Fixed = 2
}
var_0_1.DelayStrategyName = {
	[var_0_1.DelayStrategyEnum.Multiple] = "延长倍数",
	[var_0_1.DelayStrategyEnum.Fixed] = "延长固定时间"
}

function var_0_1.ctor(arg_9_0)
	arg_9_0.srcLoadAbAsset = loadAbAsset
	arg_9_0.srcLoadNonAbAsset = loadNonAbAsset
	arg_9_0.srcLoadPersistentRes = loadPersistentRes
	arg_9_0.srcRemoveAssetLoadCb = removeAssetLoadCb
	arg_9_0.loadingResDict = {}
	arg_9_0.loadedResDict = {}
	arg_9_0.doingCallbackList = {}
	arg_9_0.resPool = {}
	arg_9_0.callbackObjPool = {}
	arg_9_0.enablePatternList = {}
	arg_9_0.disablePatternList = {
		"ui/viewres/"
	}
	arg_9_0.strategy = var_0_1.DelayStrategyEnum.Multiple
	arg_9_0.strategyValue = 2
	arg_9_0.frameHandle = UpdateBeat:CreateListener(arg_9_0._onFrame, arg_9_0)
end

function var_0_1.setDelayStrategy(arg_10_0, arg_10_1)
	arg_10_0.strategy = arg_10_1
end

function var_0_1.getDelayStrategy(arg_11_0)
	return arg_11_0.strategy
end

function var_0_1.setDelayStrategyValue(arg_12_0, arg_12_1)
	arg_12_0.strategyValue = arg_12_1
end

function var_0_1.getDelayStrategyValue(arg_13_0)
	return arg_13_0.strategyValue
end

function var_0_1.setEnablePatternList(arg_14_0, arg_14_1)
	tabletool.clear(arg_14_0.enablePatternList)

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if not string.nilorempty(iter_14_1) then
			arg_14_0.enablePatternList[#arg_14_0.enablePatternList + 1] = iter_14_1
		end
	end
end

function var_0_1.setDisablePatternList(arg_15_0, arg_15_1)
	tabletool.clear(arg_15_0.disablePatternList)

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if not string.nilorempty(iter_15_1) then
			arg_15_0.disablePatternList[#arg_15_0.disablePatternList + 1] = iter_15_1
		end
	end
end

function var_0_1.getEnablePatternList(arg_16_0)
	return arg_16_0.enablePatternList
end

function var_0_1.getDisablePatternList(arg_17_0)
	return arg_17_0.disablePatternList
end

function var_0_1.startDelayLoad(arg_18_0)
	arg_18_0.start = true

	setGlobal("loadAbAsset", var_0_1.LoadAbAssetWrap)
	setGlobal("loadNonAbAsset", var_0_1.LoadNonAbAssetWrap)
	setGlobal("loadPersistentRes", var_0_1.LoadPersistentResWrap)
	setGlobal("removeAssetLoadCb", var_0_1.RemoveAssetLoadCbWrap)
	UpdateBeat:AddListener(arg_18_0.frameHandle)
end

function var_0_1.stopDelayLoad(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.loadingResDict) do
		arg_19_0:recycleResObj(iter_19_1)
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.loadedResDict) do
		arg_19_0:recycleResObj(iter_19_3)
	end

	for iter_19_4, iter_19_5 in ipairs(arg_19_0.doingCallbackList) do
		arg_19_0:recycleResObj(iter_19_5)
	end

	tabletool.clear(arg_19_0.loadingResDict)
	tabletool.clear(arg_19_0.loadedResDict)
	tabletool.clear(arg_19_0.doingCallbackList)

	arg_19_0.start = false

	setGlobal("loadAbAsset", arg_19_0.srcLoadAbAsset)
	setGlobal("loadNonAbAsset", arg_19_0.srcLoadNonAbAsset)
	setGlobal("loadPersistentRes", arg_19_0.srcLoadPersistentRes)
	setGlobal("removeAssetLoadCb", arg_19_0.srcRemoveAssetLoadCb)
	UpdateBeat:RemoveListener(arg_19_0.frameHandle)
end

function var_0_1.getResObj(arg_20_0)
	if #arg_20_0.resPool > 0 then
		return table.remove(arg_20_0.resPool)
	end

	return var_0_0.New()
end

function var_0_1.recycleResObj(arg_21_0, arg_21_1)
	arg_21_1:reset()
	table.insert(arg_21_0.resPool, arg_21_1)
end

function var_0_1.recycleResCallbackObj(arg_22_0, arg_22_1)
	tabletool.clear(arg_22_1)
	table.insert(arg_22_0.callbackObjPool, arg_22_1)
end

function var_0_1.getResCallbackObj(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0

	if #arg_23_0.callbackObjPool > 0 then
		var_23_0 = table.remove(arg_23_0.callbackObjPool)
	else
		var_23_0 = {}
	end

	var_23_0.callback = arg_23_1
	var_23_0.callbackObj = arg_23_2

	return var_23_0
end

function var_0_1.isStartDelayLoad(arg_24_0)
	return arg_24_0.start
end

function var_0_1.getLoadingResObj(arg_25_0, arg_25_1)
	return arg_25_0.loadingResDict[arg_25_1]
end

function var_0_1.addLoadingResObj(arg_26_0, arg_26_1)
	arg_26_0.loadingResDict[arg_26_1.resUrl] = arg_26_1
end

function var_0_1.removeLoadingResObj(arg_27_0, arg_27_1)
	arg_27_0.loadingResDict[arg_27_1.resUrl] = nil
end

function var_0_1.getLoadedResObj(arg_28_0, arg_28_1)
	return arg_28_0.loadedResDict[arg_28_1]
end

function var_0_1.addLoadedResObj(arg_29_0, arg_29_1)
	arg_29_0.loadedResDict[arg_29_1.resUrl] = arg_29_1
end

function var_0_1.removeLoadedResObj(arg_30_0, arg_30_1)
	arg_30_0.loadedResDict[arg_30_1.resUrl] = nil
end

function var_0_1.checkNeedDelay(arg_31_0, arg_31_1)
	if not arg_31_0.start then
		return false
	end

	if arg_31_0:checkIsDisableFile(arg_31_1) then
		return false
	end

	if #arg_31_0.enablePatternList <= 0 then
		return true
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.enablePatternList) do
		if string.match(arg_31_1, iter_31_1) then
			return true
		end
	end

	return false
end

function var_0_1.checkIsDisableFile(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.disablePatternList) do
		if string.match(arg_32_1, iter_32_1) then
			return true
		end
	end

	return false
end

function var_0_1.getDelayTime(arg_33_0, arg_33_1)
	if not arg_33_0.start then
		return 0
	end

	if arg_33_0.strategy == var_0_1.DelayStrategyEnum.Fixed then
		return arg_33_0.strategyValue
	else
		return (arg_33_1.realLoadedTime - arg_33_1.startLoadTime) * arg_33_0.strategyValue
	end
end

function var_0_1._onFrame(arg_34_0)
	local var_34_0 = UnityEngine.Time.time

	tabletool.clear(arg_34_0.doingCallbackList)

	for iter_34_0, iter_34_1 in pairs(arg_34_0.loadedResDict) do
		if iter_34_1.realLoadedTime and var_34_0 - iter_34_1.realLoadedTime >= iter_34_1.delayTime then
			table.insert(arg_34_0.doingCallbackList, iter_34_1)
		end
	end

	for iter_34_2, iter_34_3 in ipairs(arg_34_0.doingCallbackList) do
		arg_34_0:removeLoadedResObj(iter_34_3)
		iter_34_3:doCallbackAddRecycle()
	end
end

function var_0_1.loadAssetBase(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	var_0_1.log("load Asset Base : " .. arg_35_1)

	local var_35_0 = arg_35_0:getLoadingResObj(arg_35_1)
	local var_35_1 = var_35_0 ~= nil

	if not var_35_1 then
		var_35_0 = arg_35_0:getResObj()

		var_35_0:init(arg_35_1, UnityEngine.Time.time, UnityEngine.Time.frameCount)
		arg_35_0:addLoadingResObj(var_35_0)
	end

	var_35_0:addCallback(arg_35_2, arg_35_3)

	return var_35_1
end

function var_0_1.LoadAbAssetWrap(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if not var_0_1.instance:loadAssetBase(arg_36_0, arg_36_2, arg_36_3) then
		var_0_1.instance.srcLoadAbAsset(arg_36_0, arg_36_1, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.LoadNonAbAssetWrap(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if not var_0_1.instance:loadAssetBase(arg_37_0, arg_37_2, arg_37_3) then
		var_0_1.instance.srcLoadNonAbAsset(arg_37_0, arg_37_1, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.LoadPersistentResWrap(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not var_0_1.instance:loadAssetBase(arg_38_0, arg_38_2, arg_38_3) then
		var_0_1.instance.srcLoadPersistentRes(arg_38_0, arg_38_1, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.RemoveAssetLoadCbWrap(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = var_0_1.instance:getLoadedResObj(arg_39_0)

	if var_39_0 then
		var_0_1.log("remove asset load : " .. arg_39_0)
		var_39_0:removeCallback(arg_39_1, arg_39_2)
		var_0_1.instance:tryRecycleResObj(var_39_0)
	end

	local var_39_1 = var_0_1.instance:getLoadingResObj(arg_39_0)

	if var_39_1 then
		var_0_1.log("remove asset load : " .. arg_39_0)
		var_39_1:removeCallback(arg_39_1, arg_39_2)
		var_0_1.instance:tryRecycleResObj(var_39_1)
	end
end

function var_0_1.tryRecycleResObj(arg_40_0, arg_40_1)
	if not arg_40_1:hadAnyOneCallback() then
		var_0_1.instance:removeLoadingResObj(arg_40_1)
		var_0_1.instance:recycleResObj(arg_40_1)
		var_0_1.instance.srcRemoveAssetLoadCb(arg_40_1.resUrl, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.onLoadAssetDone(arg_41_0)
	local var_41_0 = arg_41_0.ResPath
	local var_41_1 = var_0_1.instance:getLoadingResObj(var_41_0)

	if not var_41_1 then
		return
	end

	var_41_1:setAssetItem(arg_41_0)
	var_0_1.instance:removeLoadingResObj(var_41_1)

	if UnityEngine.Time.frameCount == var_41_1.startLoadFrame then
		var_0_1.log(string.format("%s 在同一帧加载完", var_41_0))
		var_41_1:doCallbackAddRecycle()

		return
	end

	if not var_0_1.instance:checkNeedDelay(var_41_0) then
		var_0_1.log(string.format("%s 不需要延迟", var_41_0))
		var_41_1:doCallbackAddRecycle()

		return
	end

	var_0_1.instance:addLoadedResObj(var_41_1)

	var_41_1.realLoadedTime = UnityEngine.Time.time
	var_41_1.delayTime = var_0_1.instance:getDelayTime(var_41_1)

	var_0_1.log(string.format("%s 延迟了 %s 秒", var_41_0, var_41_1.delayTime))
end

function var_0_1.log(arg_42_0)
	logNormal("[DelayLoadResMgr] " .. (arg_42_0 or "") .. "\n" .. debug.traceback())
end

var_0_1.instance = var_0_1.New()

return var_0_1
