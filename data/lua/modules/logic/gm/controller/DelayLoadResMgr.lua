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

function var_0_0.reset(arg_7_0)
	arg_7_0.stage = var_0_0.Stage.InPool
	arg_7_0.resUrl = nil
	arg_7_0.startLoadTime = nil
	arg_7_0.startLoadFrame = nil
	arg_7_0.realLoadedTime = nil
	arg_7_0.delayTime = nil

	if arg_7_0.assetItem then
		arg_7_0.assetItem:Release()
	end

	arg_7_0.assetItem = nil

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.callbackList) do
		DelayLoadResMgr.instance:recycleResCallbackObj(iter_7_1)
	end

	tabletool.clear(arg_7_0.callbackList)
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

function var_0_1.ctor(arg_8_0)
	arg_8_0.srcLoadAbAsset = loadAbAsset
	arg_8_0.srcLoadNonAbAsset = loadNonAbAsset
	arg_8_0.srcLoadPersistentRes = loadPersistentRes
	arg_8_0.srcRemoveAssetLoadCb = removeAssetLoadCb
	arg_8_0.loadingResDict = {}
	arg_8_0.loadedResDict = {}
	arg_8_0.doingCallbackList = {}
	arg_8_0.resPool = {}
	arg_8_0.callbackObjPool = {}
	arg_8_0.enablePatternList = {}
	arg_8_0.disablePatternList = {
		"ui/viewres/"
	}
	arg_8_0.strategy = var_0_1.DelayStrategyEnum.Multiple
	arg_8_0.strategyValue = 2
	arg_8_0.frameHandle = UpdateBeat:CreateListener(arg_8_0._onFrame, arg_8_0)
end

function var_0_1.setDelayStrategy(arg_9_0, arg_9_1)
	arg_9_0.strategy = arg_9_1
end

function var_0_1.getDelayStrategy(arg_10_0)
	return arg_10_0.strategy
end

function var_0_1.setDelayStrategyValue(arg_11_0, arg_11_1)
	arg_11_0.strategyValue = arg_11_1
end

function var_0_1.getDelayStrategyValue(arg_12_0)
	return arg_12_0.strategyValue
end

function var_0_1.setEnablePatternList(arg_13_0, arg_13_1)
	tabletool.clear(arg_13_0.enablePatternList)

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if not string.nilorempty(iter_13_1) then
			arg_13_0.enablePatternList[#arg_13_0.enablePatternList + 1] = iter_13_1
		end
	end
end

function var_0_1.setDisablePatternList(arg_14_0, arg_14_1)
	tabletool.clear(arg_14_0.disablePatternList)

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if not string.nilorempty(iter_14_1) then
			arg_14_0.disablePatternList[#arg_14_0.disablePatternList + 1] = iter_14_1
		end
	end
end

function var_0_1.getEnablePatternList(arg_15_0)
	return arg_15_0.enablePatternList
end

function var_0_1.getDisablePatternList(arg_16_0)
	return arg_16_0.disablePatternList
end

function var_0_1.startDelayLoad(arg_17_0)
	arg_17_0.start = true

	setGlobal("loadAbAsset", var_0_1.LoadAbAssetWrap)
	setGlobal("loadNonAbAsset", var_0_1.LoadNonAbAssetWrap)
	setGlobal("loadPersistentRes", var_0_1.LoadPersistentResWrap)
	setGlobal("removeAssetLoadCb", var_0_1.RemoveAssetLoadCbWrap)
	UpdateBeat:AddListener(arg_17_0.frameHandle)
end

function var_0_1.stopDelayLoad(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.loadingResDict) do
		arg_18_0:recycleResObj(iter_18_1)
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0.loadedResDict) do
		arg_18_0:recycleResObj(iter_18_3)
	end

	for iter_18_4, iter_18_5 in ipairs(arg_18_0.doingCallbackList) do
		arg_18_0:recycleResObj(iter_18_5)
	end

	tabletool.clear(arg_18_0.loadingResDict)
	tabletool.clear(arg_18_0.loadedResDict)
	tabletool.clear(arg_18_0.doingCallbackList)

	arg_18_0.start = false

	setGlobal("loadAbAsset", arg_18_0.srcLoadAbAsset)
	setGlobal("loadNonAbAsset", arg_18_0.srcLoadNonAbAsset)
	setGlobal("loadPersistentRes", arg_18_0.srcLoadPersistentRes)
	setGlobal("removeAssetLoadCb", arg_18_0.srcRemoveAssetLoadCb)
	UpdateBeat:RemoveListener(arg_18_0.frameHandle)
end

function var_0_1.getResObj(arg_19_0)
	if #arg_19_0.resPool > 0 then
		return table.remove(arg_19_0.resPool)
	end

	return var_0_0.New()
end

function var_0_1.recycleResObj(arg_20_0, arg_20_1)
	arg_20_1:reset()
	table.insert(arg_20_0.resPool, arg_20_1)
end

function var_0_1.recycleResCallbackObj(arg_21_0, arg_21_1)
	tabletool.clear(arg_21_1)
	table.insert(arg_21_0.callbackObjPool, arg_21_1)
end

function var_0_1.getResCallbackObj(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if #arg_22_0.callbackObjPool > 0 then
		var_22_0 = table.remove(arg_22_0.callbackObjPool)
	else
		var_22_0 = {}
	end

	var_22_0.callback = arg_22_1
	var_22_0.callbackObj = arg_22_2

	return var_22_0
end

function var_0_1.isStartDelayLoad(arg_23_0)
	return arg_23_0.start
end

function var_0_1.getLoadingResObj(arg_24_0, arg_24_1)
	return arg_24_0.loadingResDict[arg_24_1]
end

function var_0_1.addLoadingResObj(arg_25_0, arg_25_1)
	arg_25_0.loadingResDict[arg_25_1.resUrl] = arg_25_1
end

function var_0_1.removeLoadingResObj(arg_26_0, arg_26_1)
	arg_26_0.loadingResDict[arg_26_1.resUrl] = nil
end

function var_0_1.getLoadedResObj(arg_27_0, arg_27_1)
	return arg_27_0.loadedResDict[arg_27_1]
end

function var_0_1.addLoadedResObj(arg_28_0, arg_28_1)
	arg_28_0.loadedResDict[arg_28_1.resUrl] = arg_28_1
end

function var_0_1.removeLoadedResObj(arg_29_0, arg_29_1)
	arg_29_0.loadedResDict[arg_29_1.resUrl] = nil
end

function var_0_1.checkNeedDelay(arg_30_0, arg_30_1)
	if not arg_30_0.start then
		return false
	end

	if arg_30_0:checkIsDisableFile(arg_30_1) then
		return false
	end

	if #arg_30_0.enablePatternList <= 0 then
		return true
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.enablePatternList) do
		if string.match(arg_30_1, iter_30_1) then
			return true
		end
	end

	return false
end

function var_0_1.checkIsDisableFile(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0.disablePatternList) do
		if string.match(arg_31_1, iter_31_1) then
			return true
		end
	end

	return false
end

function var_0_1.getDelayTime(arg_32_0, arg_32_1)
	if not arg_32_0.start then
		return 0
	end

	if arg_32_0.strategy == var_0_1.DelayStrategyEnum.Fixed then
		return arg_32_0.strategyValue
	else
		return (arg_32_1.realLoadedTime - arg_32_1.startLoadTime) * arg_32_0.strategyValue
	end
end

function var_0_1._onFrame(arg_33_0)
	local var_33_0 = UnityEngine.Time.time

	tabletool.clear(arg_33_0.doingCallbackList)

	for iter_33_0, iter_33_1 in pairs(arg_33_0.loadedResDict) do
		if iter_33_1.realLoadedTime and var_33_0 - iter_33_1.realLoadedTime >= iter_33_1.delayTime then
			table.insert(arg_33_0.doingCallbackList, iter_33_1)
		end
	end

	for iter_33_2, iter_33_3 in ipairs(arg_33_0.doingCallbackList) do
		arg_33_0:removeLoadedResObj(iter_33_3)
		iter_33_3:doCallbackAddRecycle()
	end
end

function var_0_1.loadAssetBase(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	var_0_1.log("load Asset Base : " .. arg_34_1)

	local var_34_0 = arg_34_0:getLoadingResObj(arg_34_1)
	local var_34_1 = var_34_0 ~= nil

	if not var_34_1 then
		var_34_0 = arg_34_0:getResObj()

		var_34_0:init(arg_34_1, UnityEngine.Time.time, UnityEngine.Time.frameCount)
		arg_34_0:addLoadingResObj(var_34_0)
	end

	var_34_0:addCallback(arg_34_2, arg_34_3)

	return var_34_1
end

function var_0_1.LoadAbAssetWrap(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not var_0_1.instance:loadAssetBase(arg_35_0, arg_35_2, arg_35_3) then
		var_0_1.instance.srcLoadAbAsset(arg_35_0, arg_35_1, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.LoadNonAbAssetWrap(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if not var_0_1.instance:loadAssetBase(arg_36_0, arg_36_2, arg_36_3) then
		var_0_1.instance.srcLoadNonAbAsset(arg_36_0, arg_36_1, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.LoadPersistentResWrap(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if not var_0_1.instance:loadAssetBase(arg_37_0, arg_37_2, arg_37_3) then
		var_0_1.instance.srcLoadPersistentRes(arg_37_0, arg_37_1, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.RemoveAssetLoadCbWrap(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = var_0_1.instance:getLoadedResObj(arg_38_0)

	if var_38_0 then
		var_0_1.log("remove asset load : " .. arg_38_0)
		var_38_0:removeCallback(arg_38_1, arg_38_2)
		var_0_1.instance:tryRecycleResObj(var_38_0)
	end

	local var_38_1 = var_0_1.instance:getLoadingResObj(arg_38_0)

	if var_38_1 then
		var_0_1.log("remove asset load : " .. arg_38_0)
		var_38_1:removeCallback(arg_38_1, arg_38_2)
		var_0_1.instance:tryRecycleResObj(var_38_1)
	end
end

function var_0_1.tryRecycleResObj(arg_39_0, arg_39_1)
	if not arg_39_1:hadAnyOneCallback() then
		var_0_1.instance:removeLoadingResObj(arg_39_1)
		var_0_1.instance:recycleResObj(arg_39_1)
		var_0_1.instance.srcRemoveAssetLoadCb(arg_39_1.resUrl, var_0_1.onLoadAssetDone)
	end
end

function var_0_1.onLoadAssetDone(arg_40_0)
	local var_40_0 = arg_40_0.ResPath
	local var_40_1 = var_0_1.instance:getLoadingResObj(var_40_0)

	if not var_40_1 then
		return
	end

	var_40_1.assetItem = arg_40_0

	arg_40_0:Retain()
	var_0_1.instance:removeLoadingResObj(var_40_1)

	if UnityEngine.Time.frameCount == var_40_1.startLoadFrame then
		var_0_1.log(string.format("%s 在同一帧加载完", var_40_0))
		var_40_1:doCallbackAddRecycle()

		return
	end

	if not var_0_1.instance:checkNeedDelay(var_40_0) then
		var_0_1.log(string.format("%s 不需要延迟", var_40_0))
		var_40_1:doCallbackAddRecycle()

		return
	end

	var_0_1.instance:addLoadedResObj(var_40_1)

	var_40_1.realLoadedTime = UnityEngine.Time.time
	var_40_1.delayTime = var_0_1.instance:getDelayTime(var_40_1)

	var_0_1.log(string.format("%s 延迟了 %s 秒", var_40_0, var_40_1.delayTime))
end

function var_0_1.log(arg_41_0)
	logNormal("[DelayLoadResMgr] " .. (arg_41_0 or "") .. "\n" .. debug.traceback())
end

var_0_1.instance = var_0_1.New()

return var_0_1
