module("modules.logic.scene.summon.SummonLoader", package.seeall)

local var_0_0 = class("SummonLoader")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._resList = arg_1_1
	arg_1_0.loadABCount = 5
	arg_1_0.callbackPerFrameCount = 2
	arg_1_0._isLoaded = false
	arg_1_0._isLoading = false
	arg_1_0._needSyncLoad = false
	arg_1_0._assetItemDict = {}
	arg_1_0._loadFrameBuffer = nil
	arg_1_0._loadOneCallback = nil
	arg_1_0._loadOneCallbackObj = nil
	arg_1_0._loadAllCallback = nil
	arg_1_0._loadAllCallbackObj = nil
end

function var_0_0.checkStartLoad(arg_2_0, arg_2_1)
	arg_2_0._needSyncLoad = arg_2_0._needSyncLoad or arg_2_1

	if not arg_2_0._isLoaded and not arg_2_0._isLoading then
		arg_2_0:startLoad()
	end
end

function var_0_0.startLoad(arg_3_0)
	if not arg_3_0._resList then
		logError("_resList need be filled!")

		return
	end

	arg_3_0._isLoading = true
	arg_3_0._loader = SequenceAbLoader.New()

	arg_3_0._loader:setPathList(arg_3_0._resList)
	arg_3_0._loader:setConcurrentCount(arg_3_0.loadABCount)
	arg_3_0._loader:startLoad(arg_3_0.onLoadCompletedSwitch, arg_3_0)
end

function var_0_0.onLoadCompletedSwitch(arg_4_0)
	logNormal("onLoadCompletedSwitch")

	if not arg_4_0._isLoading then
		return
	end

	if arg_4_0._needSyncLoad then
		arg_4_0:onLoadCompletedSync()
	else
		arg_4_0:onLoadCompletedAsync()
	end
end

function var_0_0.onLoadCompletedSync(arg_5_0)
	local var_5_0 = arg_5_0._loader:getAssetItemDict()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if arg_5_0._loadOneCallback then
			iter_5_1:Retain()

			arg_5_0._assetItemDict[iter_5_0] = iter_5_1

			arg_5_0:doOneItemCallback(iter_5_0, iter_5_1)
		end
	end

	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end

	arg_5_0._isLoading = false
	arg_5_0._isLoaded = true

	arg_5_0:doAllItemCallback()
end

function var_0_0.onLoadCompletedAsync(arg_6_0)
	arg_6_0._loadFrameBuffer = arg_6_0._loadFrameBuffer or {}

	local var_6_0 = arg_6_0._loader:getAssetItemDict()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		iter_6_1:Retain()

		arg_6_0._assetItemDict[iter_6_0] = iter_6_1

		table.insert(arg_6_0._loadFrameBuffer, iter_6_0)
	end

	if arg_6_0._uiLoader then
		arg_6_0._uiLoader:dispose()

		arg_6_0._uiLoader = nil
	end

	TaskDispatcher.runRepeat(arg_6_0.repeatCallbackFrame, arg_6_0, 0.001)
end

function var_0_0.repeatCallbackFrame(arg_7_0)
	if not arg_7_0._isLoading or arg_7_0._isLoaded then
		TaskDispatcher.cancelTask(arg_7_0.repeatCallbackFrame, arg_7_0)

		return
	end

	local var_7_0 = arg_7_0.callbackPerFrameCount

	if arg_7_0._needSyncLoad then
		var_7_0 = 9999
	end

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = #arg_7_0._loadFrameBuffer

		if var_7_1 > 0 then
			local var_7_2 = arg_7_0._loadFrameBuffer[var_7_1]

			arg_7_0._loadFrameBuffer[var_7_1] = nil

			local var_7_3 = arg_7_0._assetItemDict[var_7_2]

			if var_7_3 then
				arg_7_0:doOneItemCallback(var_7_2, var_7_3)
			end
		else
			TaskDispatcher.cancelTask(arg_7_0.repeatCallbackFrame, arg_7_0)

			arg_7_0._isLoading = false
			arg_7_0._isLoaded = true

			arg_7_0:doAllItemCallback()

			return
		end
	end
end

function var_0_0.setLoadOneItemCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._loadOneCallback = arg_8_1
	arg_8_0._loadOneCallbackObj = arg_8_2
end

function var_0_0.setLoadFinishCallback(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._loadAllCallback = arg_9_1
	arg_9_0._loadAllCallbackObj = arg_9_2
end

function var_0_0.doOneItemCallback(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._loadOneCallback then
		return
	end

	if arg_10_0._loadOneCallbackObj then
		arg_10_0._loadOneCallback(arg_10_0._loadOneCallbackObj, arg_10_1, arg_10_2)
	else
		arg_10_0._loadOneCallback(arg_10_1, arg_10_2)
	end
end

function var_0_0.doAllItemCallback(arg_11_0)
	if not arg_11_0._loadAllCallback then
		return
	end

	if arg_11_0._loadAllCallbackObj then
		arg_11_0._loadAllCallback(arg_11_0._loadAllCallbackObj, arg_11_0)
	else
		arg_11_0._loadAllCallback(arg_11_0)
	end
end

function var_0_0.getAssetItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._assetItemDict[arg_12_1]

	if var_12_0 then
		return var_12_0
	end
end

function var_0_0.dispose(arg_13_0)
	if not arg_13_0._isDisposed then
		arg_13_0._isDisposed = true
		arg_13_0._isLoading = false
		arg_13_0._isLoaded = false

		TaskDispatcher.cancelTask(arg_13_0.repeatCallbackFrame, arg_13_0)

		if arg_13_0._loader then
			arg_13_0._loader:dispose()

			arg_13_0._loader = nil
		end

		for iter_13_0, iter_13_1 in pairs(arg_13_0._assetItemDict) do
			iter_13_1:Release()

			arg_13_0._assetItemDict[iter_13_0] = nil
		end

		arg_13_0._assetItemDict = nil
	end
end

return var_0_0
