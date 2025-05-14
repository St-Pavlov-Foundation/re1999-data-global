module("framework.res.MultiAbLoader", package.seeall)

local var_0_0 = class("MultiAbLoader")

function var_0_0.ctor(arg_1_0)
	arg_1_0._pathList = {}
	arg_1_0._resDict = {}
	arg_1_0._singlePath2AssetItemDict = {}
	arg_1_0._resList = {}
	arg_1_0._finishCallback = nil
	arg_1_0._oneFinishCallback = nil
	arg_1_0._loadFailCallback = nil
	arg_1_0._callbackTarget = nil
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

function var_0_0.startLoad(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.isLoading = true
	arg_4_0._finishCallback = arg_4_1
	arg_4_0._callbackTarget = arg_4_2

	local var_4_0 = SLFramework.FrameworkSettings.IsEditor
	local var_4_1 = arg_4_0._pathList and #arg_4_0._pathList or 0

	if var_4_1 > 0 then
		for iter_4_0 = 1, var_4_1 do
			local var_4_2 = arg_4_0._pathList[iter_4_0]

			loadAbAsset(var_4_2, false, arg_4_0._onLoadCallback, arg_4_0)

			if var_4_0 and string.find(var_4_2, "\\") then
				logError(string.format("MultiAbLoader loadAbAsset path:%s error,can not contain \\", var_4_2))
			end
		end
	else
		arg_4_0:_callback()
	end
end

function var_0_0.setOneFinishCallback(arg_5_0, arg_5_1)
	arg_5_0._oneFinishCallback = arg_5_1
end

function var_0_0.setLoadFailCallback(arg_6_0, arg_6_1)
	arg_6_0._loadFailCallback = arg_6_1
end

function var_0_0.getAssetItemDict(arg_7_0)
	return arg_7_0._resDict
end

function var_0_0.getAssetItem(arg_8_0, arg_8_1)
	return arg_8_0._resDict[arg_8_1] or arg_8_0._singlePath2AssetItemDict[arg_8_1]
end

function var_0_0.getFirstAssetItem(arg_9_0)
	local var_9_0 = arg_9_0._pathList[1]

	return arg_9_0:getAssetItem(var_9_0)
end

function var_0_0.dispose(arg_10_0)
	if arg_10_0._pathList and #arg_10_0._resList < #arg_10_0._pathList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._pathList) do
			removeAssetLoadCb(iter_10_1, arg_10_0._onLoadCallback, arg_10_0)
		end
	end

	if arg_10_0._resList then
		for iter_10_2, iter_10_3 in ipairs(arg_10_0._resList) do
			iter_10_3:Release()
			rawset(arg_10_0._resList, iter_10_2, nil)
		end
	end

	arg_10_0._pathList = nil
	arg_10_0._resDict = nil
	arg_10_0._resList = nil
	arg_10_0._finishCallback = nil
	arg_10_0._oneFinishCallback = nil
	arg_10_0._callbackTarget = nil
end

function var_0_0._onLoadCallback(arg_11_0, arg_11_1)
	if not arg_11_0._resList then
		return
	end

	table.insert(arg_11_0._resList, arg_11_1)

	if arg_11_1.IsLoadSuccess then
		arg_11_1:Retain()

		arg_11_0._resDict[arg_11_1.ResPath] = arg_11_1

		local var_11_0 = arg_11_1.AllAssetNames

		if var_11_0 then
			for iter_11_0 = 0, var_11_0.Length - 1 do
				local var_11_1 = ResUrl.getPathWithoutAssetLib(var_11_0[iter_11_0])

				arg_11_0._singlePath2AssetItemDict[var_11_1] = arg_11_1
			end
		end

		if arg_11_0._oneFinishCallback then
			if arg_11_0._callbackTarget then
				arg_11_0._oneFinishCallback(arg_11_0._callbackTarget, arg_11_0, arg_11_1)
			else
				arg_11_0._oneFinishCallback(arg_11_0, arg_11_1)
			end
		end
	elseif arg_11_0._loadFailCallback then
		if arg_11_0._callbackTarget then
			arg_11_0._loadFailCallback(arg_11_0._callbackTarget, arg_11_0, arg_11_1)
		else
			arg_11_0._loadFailCallback(arg_11_0, arg_11_1)
		end
	end

	if #arg_11_0._resList >= #arg_11_0._pathList then
		arg_11_0:_callback()
	end
end

function var_0_0._callback(arg_12_0)
	arg_12_0.isLoading = false

	if arg_12_0._finishCallback then
		if arg_12_0._callbackTarget then
			arg_12_0._finishCallback(arg_12_0._callbackTarget, arg_12_0)
		else
			arg_12_0._finishCallback(arg_12_0)
		end
	end
end

return var_0_0
