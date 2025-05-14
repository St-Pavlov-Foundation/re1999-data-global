module("framework.res.SequenceAbLoader", package.seeall)

local var_0_0 = class("SequenceAbLoader")

function var_0_0.ctor(arg_1_0)
	arg_1_0._pathList = {}
	arg_1_0._resDict = {}
	arg_1_0._singlePath2AssetItemDict = {}
	arg_1_0._resList = {}
	arg_1_0._finishCallback = nil
	arg_1_0._oneFinishCallback = nil
	arg_1_0._loadFailCallback = nil
	arg_1_0._callbackTarget = nil
	arg_1_0._interval = 0.01
	arg_1_0._concurrentCount = 1
	arg_1_0._loadIndex = 1
	arg_1_0._loadingCount = 0
	arg_1_0.isLoading = false
end

function var_0_0.addPath(arg_2_0, arg_2_1)
	table.insert(arg_2_0._pathList, arg_2_1)
end

function var_0_0.setPathList(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0._pathList = arg_3_1
	end
end

function var_0_0.setInterval(arg_4_0, arg_4_1)
	arg_4_0._interval = arg_4_1
end

function var_0_0.setConcurrentCount(arg_5_0, arg_5_1)
	arg_5_0._concurrentCount = arg_5_1
end

function var_0_0.startLoad(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.isLoading = true
	arg_6_0._finishCallback = arg_6_1
	arg_6_0._callbackTarget = arg_6_2
	arg_6_0._loadIndex = 0

	arg_6_0:_loadNext()
end

function var_0_0.setOneFinishCallback(arg_7_0, arg_7_1)
	arg_7_0._oneFinishCallback = arg_7_1
end

function var_0_0.setLoadFailCallback(arg_8_0, arg_8_1)
	arg_8_0._loadFailCallback = arg_8_1
end

function var_0_0.getAssetItemDict(arg_9_0)
	return arg_9_0._resDict
end

function var_0_0.getAssetItem(arg_10_0, arg_10_1)
	return arg_10_0._resDict[arg_10_1] or arg_10_0._singlePath2AssetItemDict[arg_10_1]
end

function var_0_0.getFirstAssetItem(arg_11_0)
	local var_11_0 = arg_11_0._pathList[1]

	return arg_11_0:getAssetItem(var_11_0)
end

function var_0_0.dispose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._loadNext, arg_12_0)

	if arg_12_0._pathList and #arg_12_0._resList < #arg_12_0._pathList then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._pathList) do
			removeAssetLoadCb(iter_12_1, arg_12_0._onLoadCallback, arg_12_0)
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._resList) do
		iter_12_3:Release()
	end

	arg_12_0._pathList = nil
	arg_12_0._resDict = nil
	arg_12_0._resList = nil
	arg_12_0._finishCallback = nil
	arg_12_0._oneFinishCallback = nil
	arg_12_0._callbackTarget = nil
end

function var_0_0._loadNext(arg_13_0)
	if arg_13_0._loadIndex >= #arg_13_0._pathList and arg_13_0._loadingCount == 0 then
		arg_13_0:_callback()

		return
	end

	local var_13_0 = SLFramework.FrameworkSettings.IsEditor

	for iter_13_0 = 1, arg_13_0._concurrentCount do
		arg_13_0._loadIndex = arg_13_0._loadIndex + 1

		local var_13_1 = arg_13_0._pathList and arg_13_0._pathList[arg_13_0._loadIndex]

		if var_13_1 then
			arg_13_0._loadingCount = arg_13_0._loadingCount + 1

			loadAbAsset(var_13_1, false, arg_13_0._onLoadCallback, arg_13_0)

			if var_13_0 and string.find(var_13_1, "\\") then
				logError(string.format("SequenceAbLoader loadAbAsset path:%s error,can not contain \\", var_13_1))
			end
		end
	end
end

function var_0_0._onLoadCallback(arg_14_0, arg_14_1)
	if not arg_14_0._resList then
		return
	end

	table.insert(arg_14_0._resList, arg_14_1)

	if arg_14_1.IsLoadSuccess then
		arg_14_1:Retain()

		arg_14_0._resDict[arg_14_1.ResPath] = arg_14_1

		local var_14_0 = arg_14_1.AllAssetNames

		if var_14_0 then
			for iter_14_0 = 0, var_14_0.Length - 1 do
				local var_14_1 = ResUrl.getPathWithoutAssetLib(var_14_0[iter_14_0])

				arg_14_0._singlePath2AssetItemDict[var_14_1] = arg_14_1
			end
		end

		if arg_14_0._oneFinishCallback then
			if arg_14_0._callbackTarget then
				arg_14_0._oneFinishCallback(arg_14_0._callbackTarget, arg_14_0, arg_14_1)
			else
				arg_14_0._oneFinishCallback(arg_14_0, arg_14_1)
			end
		end
	elseif arg_14_0._loadFailCallback then
		if arg_14_0._callbackTarget then
			arg_14_0._loadFailCallback(arg_14_0._callbackTarget, arg_14_0, arg_14_1)
		else
			arg_14_0._loadFailCallback(arg_14_0, arg_14_1)
		end
	end

	arg_14_0._loadingCount = arg_14_0._loadingCount - 1

	if arg_14_0._loadingCount <= 0 then
		if arg_14_0._interval and arg_14_0._interval > 0 then
			TaskDispatcher.runDelay(arg_14_0._loadNext, arg_14_0, arg_14_0._interval)
		else
			arg_14_0:_loadNext()
		end
	end
end

function var_0_0._callback(arg_15_0)
	arg_15_0.isLoading = false

	if arg_15_0._finishCallback then
		if arg_15_0._callbackTarget then
			arg_15_0._finishCallback(arg_15_0._callbackTarget, arg_15_0)
		else
			arg_15_0._finishCallback(arg_15_0)
		end
	end
end

return var_0_0
