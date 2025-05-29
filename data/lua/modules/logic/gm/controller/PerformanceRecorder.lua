module("modules.logic.gm.controller.PerformanceRecorder", package.seeall)

local var_0_0 = class("PerformanceRecorder")

function var_0_0.init(arg_1_0)
	arg_1_0._curTime = 0
	arg_1_0._curFrameCount = 0
	arg_1_0._curSceondTime = 0
	arg_1_0._record = {}
end

function var_0_0.initProfilerConnection()
	ZProj.ProfilerConnection.Instance:Init()
	ZProj.ProfilerConnection.Instance:RegisterReceiveMsgLuaCallback(var_0_0.onProfilerMsg, var_0_0.instance)
end

function var_0_0.beginRecord(arg_3_0, arg_3_1)
	arg_3_0._recording = true
	arg_3_0._startSceondTime = os.time()
	arg_3_0._startTime = Time.realtimeSinceStartup
	arg_3_0._curSceondTime = 0
	arg_3_0._luaMemoryList = {}
	arg_3_0._allocatedMemoryList = {}
	arg_3_0._reservedMemoryList = {}
	arg_3_0._monoReservedMemoryList = {}
	arg_3_0._monoUsedMemoryList = {}
	arg_3_0._fpsList = {}
	arg_3_0._monoGCCount = ZProj.ProfilerHelper.GetGCCount()
	arg_3_0._monoGCAllocated = ZProj.ProfilerHelper.GetGCAllocated()
	arg_3_0._monoGCAllocated2 = ZProj.ProfilerHelper.GetMonoUsedSizeLong()
	arg_3_0._monoGCAmount = 0
	arg_3_0._luaAllocated = ZProj.ProfilerHelper.GetLuaMemory()
	arg_3_0._luaAllocateAmount = 0
	arg_3_0._luaAllocateAmountMax = 0
	arg_3_0._luaGCAmount = 0
	arg_3_0._lowestFps = 60
	arg_3_0._recordFrameNum = arg_3_1
	arg_3_0._curRecordFrame = 0
	arg_3_0._beginTextureAsset = ZProj.ProfilerHelper.GetTextureAssetMemory()

	LateUpdateBeat:Add(arg_3_0._lateUpdate, arg_3_0)

	local var_3_0 = {
		sheetIdx = arg_3_0._curCaseIdx
	}

	var_3_0.cmd = "BeginRecord"
	var_3_0.frameNum = arg_3_1

	local var_3_1 = cjson.encode(var_3_0)

	ZProj.ProfilerConnection.Instance:SendToEditor(var_3_1)

	arg_3_0._curCaseIdx = arg_3_0._curCaseIdx + 1
end

function var_0_0.endRecord(arg_4_0)
	arg_4_0._endSecondTime = os.time()

	LateUpdateBeat:Remove(arg_4_0._lateUpdate, arg_4_0)

	local var_4_0 = {
		monoGCAmount = arg_4_0._monoGCAmount
	}
	local var_4_1, var_4_2 = arg_4_0.getAverageAndMax(arg_4_0._luaMemoryList)

	var_4_0.luaMemory = {
		arg_4_0._luaMemoryList[1],
		arg_4_0._luaMemoryList[#arg_4_0._luaMemoryList],
		var_4_1,
		var_4_2
	}

	local var_4_3, var_4_4 = arg_4_0.getAverageAndMax(arg_4_0._luaMemoryList)

	var_4_0.luaAllocateAmount = {
		0,
		arg_4_0._luaAllocateAmount,
		arg_4_0._luaAllocateAmount / (arg_4_0._curRecordFrame - 1),
		arg_4_0._luaAllocateAmountMax
	}

	local var_4_5, var_4_6 = arg_4_0.getAverageAndMax(arg_4_0._allocatedMemoryList)

	var_4_0.allocatedMemory = {
		arg_4_0._allocatedMemoryList[1],
		arg_4_0._allocatedMemoryList[#arg_4_0._allocatedMemoryList],
		var_4_5,
		var_4_6
	}

	local var_4_7, var_4_8 = arg_4_0.getAverageAndMax(arg_4_0._reservedMemoryList)

	var_4_0.reservedMemory = {
		arg_4_0._reservedMemoryList[1],
		arg_4_0._reservedMemoryList[#arg_4_0._reservedMemoryList],
		var_4_7,
		var_4_8
	}

	local var_4_9, var_4_10 = arg_4_0.getAverageAndMax(arg_4_0._monoUsedMemoryList)

	var_4_0.monoUsedMemory = {
		arg_4_0._monoUsedMemoryList[1],
		arg_4_0._monoUsedMemoryList[#arg_4_0._monoUsedMemoryList],
		var_4_9,
		var_4_10
	}

	local var_4_11, var_4_12 = arg_4_0.getAverageAndMax(arg_4_0._monoReservedMemoryList)

	var_4_0.monoReservedMemory = {
		arg_4_0._monoReservedMemoryList[1],
		arg_4_0._monoReservedMemoryList[#arg_4_0._monoReservedMemoryList],
		var_4_11,
		var_4_12
	}

	local var_4_13, var_4_14 = arg_4_0.getAverageAndMin(arg_4_0._fpsList)

	var_4_0.fps = {
		arg_4_0._fpsList[1],
		arg_4_0._fpsList[#arg_4_0._fpsList],
		var_4_13,
		var_4_14
	}
	var_4_0.lowestFps = arg_4_0._lowestFps
	var_4_0.textureAssetMemory = {
		arg_4_0._beginTextureAsset,
		ZProj.ProfilerHelper.GetTextureAssetMemory(),
		0,
		0
	}
	var_4_0.graphicsDriverMemory = {
		0,
		ZProj.ProfilerHelper.GetGraphicsDriverMemory(),
		0,
		0
	}
	var_4_0.cmd = "EndRecord"
	var_4_0.frameNum = arg_4_0._curRecordFrame - 1

	local var_4_15 = cjson.encode(var_4_0)

	ZProj.ProfilerConnection.Instance:SendToEditor(var_4_15)

	if arg_4_0._cases[arg_4_0._curCaseIdx].screenshot then
		ZProj.ScreenCaptureUtil.Instance:CaptureScreenshotAsTexture(arg_4_0._onCaptureDone, arg_4_0)
	end

	logNormal("EndRecord")
	arg_4_0:dispatchEvent(PerformanceRecordEvent.onRecordDone)
end

function var_0_0.endRecordByEvent(arg_5_0)
	arg_5_0._endTime = Time.realtimeSinceStartup

	arg_5_0:endRecord()
end

function var_0_0._lateUpdate(arg_6_0)
	arg_6_0._curRecordFrame = arg_6_0._curRecordFrame + 1

	if arg_6_0._recordFrameNum > 0 and arg_6_0._curRecordFrame > arg_6_0._recordFrameNum then
		arg_6_0._endTime = Time.realtimeSinceStartup

		if arg_6_0._recordFrameNum < 10 then
			TaskDispatcher.runDelay(arg_6_0.endRecord, arg_6_0, 0.75)
			LateUpdateBeat:Remove(arg_6_0._lateUpdate, arg_6_0)
		else
			arg_6_0:endRecord()
		end

		return
	end

	arg_6_0:_updatePerFrameData()

	if arg_6_0._recordFrameNum <= 120 then
		if arg_6_0._curRecordFrame % 10 == 1 then
			arg_6_0:_updatePerSecondData()
		end
	else
		local var_6_0 = os.time()

		if var_6_0 > arg_6_0._curSceondTime then
			arg_6_0._curSceondTime = var_6_0

			arg_6_0:_updatePerSecondData()
		end
	end
end

function var_0_0.onProfilerMsg(arg_7_0, arg_7_1)
	local var_7_0 = string.split(arg_7_1, "#")
	local var_7_1 = var_7_0[1]

	if var_7_1 == "BeginRecord" then
		local var_7_2 = tonumber(var_7_0[2])

		arg_7_0:beginRecord(var_7_2 or 100)
	elseif var_7_1 == "GetDeviceInfo" then
		arg_7_0:_sendDevicesInfo()
	elseif var_7_1 == "StartCases" then
		local var_7_3 = var_7_0[2]

		arg_7_0._cases = {}

		local var_7_4 = string.split(var_7_3, "|")

		for iter_7_0, iter_7_1 in ipairs(var_7_4) do
			local var_7_5 = {}
			local var_7_6 = string.split(iter_7_1, "@")

			var_7_5.preAction = var_7_6[2]
			var_7_5.delay = var_7_6[3]
			var_7_5.startEventParams = var_7_6[4]
			var_7_5.sampleFrameNum = var_7_6[5]
			var_7_5.endEventParams = var_7_6[6]
			var_7_5.endAction = var_7_6[7]
			var_7_5.screenshot = var_7_6[8] == "True"
			var_7_5.endActionDelay = var_7_6[9]
			arg_7_0._cases[#arg_7_0._cases + 1] = var_7_5
		end

		arg_7_0:beginCheckCasesFlow()
	end
end

function var_0_0.isRecording(arg_8_0)
	return arg_8_0._recording
end

function var_0_0.exportCurFramePerformanceData(arg_9_0)
	local var_9_0 = {
		LuaMemory = ZProj.ProfilerHelper.GetLuaMemory(),
		TotalAllocatedMemory = ZProj.ProfilerHelper.GetTotalAllocatedMemory(),
		TotalReservedMemory = ZProj.ProfilerHelper.GetTotalReservedMemory(),
		MonoHeapReservedMemory = ZProj.ProfilerHelper.GetMonoHeapReservedMemory(),
		MonoHeapUsedMemory = ZProj.ProfilerHelper.GetMonoHeapUsedMemory(),
		TextureAssetMemory = ZProj.ProfilerHelper.GetTextureAssetMemory()
	}
	local var_9_1 = string.format("%s/../curFramePerformanceData.json", UnityEngine.Application.dataPath)
	local var_9_2 = JsonUtil.encode(var_9_0)

	SLFramework.FileHelper.WriteTextToPath(var_9_1, var_9_2)
	logNormal(var_9_1)
end

function var_0_0._updatePerFrameData(arg_10_0)
	local var_10_0 = ZProj.ProfilerHelper.GetGCAllocated()
	local var_10_1 = ZProj.ProfilerHelper.GetGCCount()

	if var_10_1 > arg_10_0._monoGCCount then
		arg_10_0._monoGCCount = var_10_1
		arg_10_0._monoGCAmount = arg_10_0._monoGCAmount + arg_10_0._monoGCAllocated - var_10_0
	end

	arg_10_0._monoGCAllocated = var_10_0
	arg_10_0._monoGCAllocated2 = ZProj.ProfilerHelper.GetMonoUsedSizeLong()

	local var_10_2 = ZProj.ProfilerHelper.GetLuaMemory()

	if var_10_2 > arg_10_0._luaAllocated then
		local var_10_3 = var_10_2 - arg_10_0._luaAllocated

		arg_10_0._luaAllocateAmount = arg_10_0._luaAllocateAmount + var_10_3
		arg_10_0._luaAllocateAmountMax = math.max(arg_10_0._luaAllocateAmountMax, var_10_3)
	end

	arg_10_0._luaAllocated = var_10_2
	arg_10_0._lowestFps = math.min(arg_10_0._lowestFps, 1 / Time.deltaTime)
	arg_10_0._fpsList[#arg_10_0._fpsList + 1] = 1 / Time.deltaTime
end

function var_0_0._updatePerSecondData(arg_11_0)
	local var_11_0 = #arg_11_0._luaMemoryList + 1

	arg_11_0._luaMemoryList[var_11_0] = ZProj.ProfilerHelper.GetLuaMemory()
	arg_11_0._allocatedMemoryList[var_11_0] = ZProj.ProfilerHelper.GetTotalAllocatedMemory()
	arg_11_0._reservedMemoryList[var_11_0] = ZProj.ProfilerHelper.GetTotalReservedMemory()
	arg_11_0._monoReservedMemoryList[var_11_0] = ZProj.ProfilerHelper.GetMonoHeapReservedMemory()
	arg_11_0._monoUsedMemoryList[var_11_0] = ZProj.ProfilerHelper.GetMonoHeapUsedMemory()
end

function var_0_0.getAverageAndMax(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = 0

	for iter_12_0 = 1, #arg_12_0 do
		var_12_2 = var_12_2 + arg_12_0[iter_12_0]
		var_12_1 = math.max(var_12_1, arg_12_0[iter_12_0])
	end

	return var_12_2 / #arg_12_0, var_12_1
end

function var_0_0.getAverageAndMin(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 999
	local var_13_2 = 0

	for iter_13_0 = 1, #arg_13_0 do
		var_13_2 = var_13_2 + arg_13_0[iter_13_0]
		var_13_1 = math.min(var_13_1, arg_13_0[iter_13_0])
	end

	return var_13_2 / #arg_13_0, var_13_1
end

function var_0_0._onCaptureDone(arg_14_0, arg_14_1)
	local var_14_0 = UnityEngine.ImageConversion.EncodeToPNG(arg_14_1)

	ZProj.ProfilerConnection.Instance:SendToEditor(var_14_0)
end

local var_0_1 = {
	[ModuleEnum.Performance.High] = "High",
	[ModuleEnum.Performance.Middle] = "Middle",
	[ModuleEnum.Performance.Low] = "Low"
}

function var_0_0._sendDevicesInfo(arg_15_0)
	local var_15_0 = UnityEngine.SystemInfo.deviceModel
	local var_15_1 = BootNativeUtil.getCpuName()
	local var_15_2 = UnityEngine.SystemInfo.graphicsDeviceName
	local var_15_3 = UnityEngine.SystemInfo.systemMemorySize
	local var_15_4, var_15_5 = HardwareUtil.getPerformanceGrade()
	local var_15_6 = var_0_1[var_15_4]
	local var_15_7 = {
		deviceName = var_15_0,
		cpuName = var_15_1,
		gpuName = var_15_2,
		memory = var_15_3 .. "M",
		DPI = UnityEngine.Screen.dpi,
		resolution = UnityEngine.Screen.currentResolution:ToString(),
		grade = var_15_6
	}

	var_15_7.cmd = "DeviceInfo"

	local var_15_8 = cjson.encode(var_15_7)

	ZProj.ProfilerConnection.Instance:SendToEditor(var_15_8)
end

function var_0_0.beginCheckCasesFlow(arg_16_0)
	local var_16_0 = FlowSequence.New()
	local var_16_1 = 3

	arg_16_0._curCaseIdx = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._cases) do
		if not string.nilorempty(iter_16_1.preAction) then
			var_16_0:addWork(DoStringActionWork.New(iter_16_1.preAction))
		end

		if not string.nilorempty(iter_16_1.startEventParams) then
			var_16_0:addWork(WaitEventWork.New(iter_16_1.startEventParams))
		end

		local var_16_2 = 0

		if not string.nilorempty(iter_16_1.delay) then
			var_16_2 = tonumber(iter_16_1.delay)
		end

		local var_16_3 = tonumber(iter_16_1.sampleFrameNum) or 120

		if not string.nilorempty(iter_16_1.endEventParams) then
			var_16_3 = -1
		end

		var_16_0:addWork(DelayDoFuncWork.New(arg_16_0.beginRecord, arg_16_0, var_16_2, var_16_3))

		if not string.nilorempty(iter_16_1.endEventParams) then
			var_16_0:addWork(WaitEventWork.New(iter_16_1.endEventParams))
			var_16_0:addWork(DelayDoFuncWork.New(arg_16_0.endRecordByEvent, arg_16_0, 0))
		else
			var_16_0:addWork(WaitRecordDoneWork.New())
		end

		if not string.nilorempty(iter_16_1.endAction) then
			local var_16_4 = 0

			if not string.nilorempty(iter_16_1.endActionDelay) then
				var_16_4 = tonumber(iter_16_1.endActionDelay)
			end

			if var_16_4 > 0 then
				var_16_0:addWork(BpWaitSecWork.New(var_16_4))
			end

			var_16_0:addWork(DoStringActionWork.New(iter_16_1.endAction))
		end

		var_16_0:addWork(BpWaitSecWork.New(var_16_1))
	end

	var_16_0:start()
end

function var_0_0.doProfilerCmdAction(arg_17_0, arg_17_1)
	arg_17_0._record = {}
	arg_17_0._recordDataCmdList = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_0 = iter_17_1.cmd
		local var_17_1 = iter_17_1.stop

		if arg_17_0:_getProfilerAciton(var_17_0) then
			local var_17_2 = iter_17_1.frame

			if var_17_2 then
				if var_17_2 > 1 then
					-- block empty
				elseif var_17_2 == 1 then
					-- block empty
				end
			else
				arg_17_0:addProfilerAcitonInUpdate(var_17_0)
			end
		elseif var_17_0 == "WaitSceond" then
			-- block empty
		end

		if var_17_1 then
			arg_17_0:removeProfilerAcitonInUpdate(var_17_1)
		end
	end

	if arg_17_0.workFlow then
		arg_17_0.workFlow:registerDoneListener(arg_17_0.onFlowDone, arg_17_0)
		arg_17_0.workFlow:start()
	end
end

function var_0_0._getProfilerAciton(arg_18_0, arg_18_1)
	if arg_18_0._cmdActionDict == nil then
		arg_18_0._cmdActionDict = {}
		arg_18_0._cmdActionDict.GetTextureMemory = arg_18_0.recordTextureMemory
		arg_18_0._cmdActionDict.WaitSceond = nil
		arg_18_0._cmdActionDict.GetLuaMemory = arg_18_0.recordLuaMemory
		arg_18_0._cmdActionDict.LogMonoMemory = arg_18_0.logMonoMemory
		arg_18_0._cmdActionDict.LogMonoGCInfo = arg_18_0.logMonoGCInfo
		arg_18_0._cmdActionDict.LogLuaMemory = arg_18_0.logLuaMemory
		arg_18_0._cmdActionDict.LogRenderData = arg_18_0.logRenderDataAction
		arg_18_0._cmdActionDict.LogTextureMemory = arg_18_0.logTextureMemory
	end

	return arg_18_0._cmdActionDict[arg_18_1]
end

function var_0_0._getStopProfilerAciton(arg_19_0, arg_19_1)
	if arg_19_0._stopActionDict == nil then
		arg_19_0._stopActionDict = {}
		arg_19_0._stopActionDict.GetRenderData = arg_19_0.stopLogRenderDataAction
		arg_19_0._stopActionDict.LogMonoGCInfo = arg_19_0.stopLogMonoGCInfoAction
	end

	return arg_19_0._stopActionDict[arg_19_1]
end

function var_0_0.addProfilerAcitonInUpdate(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:_getProfilerAciton(arg_20_1)

	if var_20_0 then
		if not arg_20_0._secondsProfilerAcitons then
			arg_20_0._secondsProfilerAcitons = {}

			LateUpdateBeat:Add(arg_20_0.doProfilerAcitonInUpdate, arg_20_0)
		end

		arg_20_0._secondsProfilerAcitons[arg_20_1] = var_20_0
	end
end

function var_0_0.removeProfilerAcitonInUpdate(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:_getStopProfilerAciton(arg_21_1)

	if not arg_21_0._secondsProfilerAcitons then
		return
	end

	arg_21_0._secondsProfilerAcitons[arg_21_1] = nil

	if tabletool.len(arg_21_0._secondsProfilerAcitons) == 0 then
		LateUpdateBeat:Remove(arg_21_0.doProfilerAcitonInUpdate, arg_21_0)
	end

	if var_21_0 then
		var_21_0(arg_21_0)
	end
end

function var_0_0.doProfilerAcitonInUpdate(arg_22_0)
	if not arg_22_0._secondsProfilerAcitons then
		return
	end

	arg_22_0._curSceondTime = arg_22_0._curSceondTime or 0

	local var_22_0 = os.time()

	if var_22_0 <= arg_22_0._curSceondTime then
		return
	end

	arg_22_0._curSceondTime = var_22_0

	local var_22_1 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_0._secondsProfilerAcitons) do
		var_22_1 = var_22_1 + 1

		iter_22_1(arg_22_0)
	end

	if var_22_1 == 0 then
		LateUpdateBeat:Remove(arg_22_0.doProfilerAcitonInUpdate, arg_22_0)
	end
end

function var_0_0.getTextureMemory(arg_23_0)
	return ZProj.ProfilerHelper.GetTextureAssetMemory()
end

function var_0_0.recordTextureMemory(arg_24_0, arg_24_1)
	if not arg_24_1 then
		arg_24_0._record[#arg_24_0._record + 1] = arg_24_0:getTextureMemory()
	else
		if arg_24_1 == 0 then
			arg_24_0._record[#arg_24_0._record + 1] = {}
		end

		arg_24_0._record[#arg_24_0._record][arg_24_1 + 1] = arg_24_0:getTextureMemory()
	end
end

function var_0_0.getLuaMemory(arg_25_0)
	return ZProj.ProfilerHelper.GetLuaMemory()
end

function var_0_0.recordLuaMemory(arg_26_0, arg_26_1)
	if not arg_26_1 then
		arg_26_0._record[#arg_26_0._record + 1] = arg_26_0:getLuaMemory()
	else
		if arg_26_1 == 0 then
			arg_26_0._record[#arg_26_0._record + 1] = {}
		end

		arg_26_0._record[#arg_26_0._record][arg_26_1 + 1] = arg_26_0:getLuaMemory()
	end
end

function var_0_0.logLuaMemory(arg_27_0)
	local var_27_0 = arg_27_0:getLuaMemory()

	BenchmarkApi.AndroidLog(string.format("LuaMemory:%.2f MB", var_27_0))
end

function var_0_0.logMonoMemory(arg_28_0)
	local var_28_0 = ZProj.ProfilerHelper.GetGCAllocated()

	BenchmarkApi.AndroidLog(string.format("MonoMemory:%.2f MB", Bitwise[">>"](var_28_0, 10) / 1024))
end

function var_0_0.logMonoGCInfo(arg_29_0)
	local var_29_0 = ZProj.ProfilerHelper.GetGCCount()

	if not arg_29_0._gcCount then
		arg_29_0._gcCount = var_29_0
	end

	if var_29_0 > arg_29_0._gcCount then
		BenchmarkApi.AndroidLog(string.format("GCCount:%d", var_29_0 - arg_29_0._gcCount))

		arg_29_0._gcCount = var_29_0
	end
end

function var_0_0.logUnuseMemory(arg_30_0)
	local var_30_0 = ZProj.ProfilerHelper.GetGCAllocated()

	BenchmarkApi.AndroidLog(string.format("Unuse Memory:%f MB", var_30_0))
end

function var_0_0.logTotalMemory(arg_31_0)
	local var_31_0 = ZProj.ProfilerHelper.GetTotalAllocatedMemory()
	local var_31_1 = ZProj.ProfilerHelper.GetTotalReservedMemory()

	BenchmarkApi.AndroidLog(string.format("Total:%.2f / %.2f MB", var_31_0, var_31_1))
end

function var_0_0.logRenderDataAction(arg_32_0)
	if SLFramework.NativeUtil.IsAndroidX8664() then
		logWarn("X86_64 not support Catch Render Data For the [ShadowHook] is not supported On X86")

		return
	end

	if not arg_32_0._benchMarkInited then
		arg_32_0._benchMarkInited = BenchmarkApi.init()
	end

	if not arg_32_0._benchMarkInited then
		return
	end

	if not arg_32_0._benchMarkInlineHooked then
		BenchmarkApi.hook()

		arg_32_0._benchMarkInlineHooked = true
	end

	if arg_32_0._catchedFrameData then
		arg_32_0._catchedFrameData = false

		local var_32_0 = BenchmarkApi.pop_draw_num()
		local var_32_1 = arg_32_0:getReadableNum(var_32_0)
		local var_32_2 = BenchmarkApi.pop_num_vertices()
		local var_32_3 = arg_32_0:getReadableNum(var_32_2)
		local var_32_4 = BenchmarkApi.pop_num_triangles()
		local var_32_5 = arg_32_0:getReadableNum(var_32_4)

		BenchmarkApi.AndroidLog(string.format("DrawCall:%s|VertCount:%s|TriCount:%s", var_32_1, var_32_3, var_32_5))
	end

	if not arg_32_0._catchedFrameData then
		BenchmarkApi.clearInfo()
		BenchmarkApi.CatchSingleFrameData()

		arg_32_0._catchedFrameData = true
	end
end

function var_0_0.logTextureMemory(arg_33_0)
	local var_33_0 = arg_33_0:getTextureMemory()

	BenchmarkApi.AndroidLog(string.format("TextrueMemory:%.0f MB", var_33_0))
end

function var_0_0.stopLogRenderDataAction(arg_34_0)
	if not arg_34_0._benchMarkInited then
		return
	end

	if arg_34_0._benchMarkInlineHooked then
		BenchmarkApi.clearInfo()
		BenchmarkApi.unhook()
	end

	arg_34_0._catchedFrameData = false
end

function var_0_0.stopLogMonoGCInfoAction(arg_35_0)
	arg_35_0._gcCount = nil
end

function var_0_0.getReadableNum(arg_36_0, arg_36_1)
	if arg_36_1 < 1000 then
		return arg_36_1
	elseif arg_36_1 < 1000000 then
		arg_36_1 = arg_36_1 / 1000

		return string.format("%.1f", arg_36_1) .. "k"
	else
		arg_36_1 = arg_36_1 / 1000000

		return string.format("%.1f", arg_36_1) .. "m"
	end
end

function var_0_0.onFlowDone(arg_37_0)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_0._record) do
		local var_37_1 = arg_37_0._recordDataCmdList[iter_37_0]

		var_37_0[iter_37_0 .. var_37_1.cmd] = iter_37_1
	end

	local var_37_2 = JsonUtil.encode(var_37_0)
	local var_37_3 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler")
	local var_37_4 = "profilerResult.json"
	local var_37_5 = System.IO.Path.Combine(var_37_3, var_37_4)
	local var_37_6 = io.open(var_37_5, "w")

	var_37_6:write(tostring(var_37_2))
	var_37_6:close()
	BenchmarkApi.AndroidLog(var_37_2)

	arg_37_0.flow = nil
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
