module("modules.logic.gm.controller.PerformanceRecorder", package.seeall)

slot0 = class("PerformanceRecorder")

function slot0.init(slot0)
	slot0._curTime = 0
	slot0._curFrameCount = 0
	slot0._curSceondTime = 0
	slot0._record = {}
end

function slot0.initProfilerConnection()
	ZProj.ProfilerConnection.Instance:Init()
	ZProj.ProfilerConnection.Instance:RegisterReceiveMsgLuaCallback(uv0.onProfilerMsg, uv0.instance)
end

function slot0.beginRecord(slot0, slot1)
	slot0._recording = true
	slot0._startSceondTime = os.time()
	slot0._startTime = Time.realtimeSinceStartup
	slot0._curSceondTime = 0
	slot0._luaMemoryList = {}
	slot0._allocatedMemoryList = {}
	slot0._reservedMemoryList = {}
	slot0._monoReservedMemoryList = {}
	slot0._monoUsedMemoryList = {}
	slot0._fpsList = {}
	slot0._monoGCCount = ZProj.ProfilerHelper.GetGCCount()
	slot0._monoGCAllocated = ZProj.ProfilerHelper.GetGCAllocated()
	slot0._monoGCAllocated2 = ZProj.ProfilerHelper.GetMonoUsedSizeLong()
	slot0._monoGCAmount = 0
	slot0._luaAllocated = ZProj.ProfilerHelper.GetLuaMemory()
	slot0._luaAllocateAmount = 0
	slot0._luaAllocateAmountMax = 0
	slot0._luaGCAmount = 0
	slot0._lowestFps = 60
	slot0._recordFrameNum = slot1
	slot0._curRecordFrame = 0
	slot0._beginTextureAsset = ZProj.ProfilerHelper.GetTextureAssetMemory()

	LateUpdateBeat:Add(slot0._lateUpdate, slot0)
	ZProj.ProfilerConnection.Instance:SendToEditor(cjson.encode({
		sheetIdx = slot0._curCaseIdx,
		cmd = "BeginRecord",
		frameNum = slot1
	}))

	slot0._curCaseIdx = slot0._curCaseIdx + 1
end

function slot0.endRecord(slot0)
	slot0._endSecondTime = os.time()

	LateUpdateBeat:Remove(slot0._lateUpdate, slot0)

	slot2, slot3 = slot0.getAverageAndMax(slot0._luaMemoryList)
	slot2, slot3 = slot0.getAverageAndMax(slot0._luaMemoryList)
	slot4, slot5 = slot0.getAverageAndMax(slot0._allocatedMemoryList)
	slot4, slot5 = slot0.getAverageAndMax(slot0._reservedMemoryList)
	slot4, slot5 = slot0.getAverageAndMax(slot0._monoUsedMemoryList)
	slot4, slot5 = slot0.getAverageAndMax(slot0._monoReservedMemoryList)
	slot4, slot5 = slot0.getAverageAndMin(slot0._fpsList)

	ZProj.ProfilerConnection.Instance:SendToEditor(cjson.encode({
		monoGCAmount = slot0._monoGCAmount,
		luaMemory = {
			slot0._luaMemoryList[1],
			slot0._luaMemoryList[#slot0._luaMemoryList],
			slot2,
			slot3
		},
		luaAllocateAmount = {
			0,
			slot0._luaAllocateAmount,
			slot0._luaAllocateAmount / (slot0._curRecordFrame - 1),
			slot0._luaAllocateAmountMax
		},
		allocatedMemory = {
			slot0._allocatedMemoryList[1],
			slot0._allocatedMemoryList[#slot0._allocatedMemoryList],
			slot4,
			slot5
		},
		reservedMemory = {
			slot0._reservedMemoryList[1],
			slot0._reservedMemoryList[#slot0._reservedMemoryList],
			slot4,
			slot5
		},
		monoUsedMemory = {
			slot0._monoUsedMemoryList[1],
			slot0._monoUsedMemoryList[#slot0._monoUsedMemoryList],
			slot4,
			slot5
		},
		monoReservedMemory = {
			slot0._monoReservedMemoryList[1],
			slot0._monoReservedMemoryList[#slot0._monoReservedMemoryList],
			slot4,
			slot5
		},
		fps = {
			slot0._fpsList[1],
			slot0._fpsList[#slot0._fpsList],
			slot4,
			slot5
		},
		lowestFps = slot0._lowestFps,
		textureAssetMemory = {
			slot0._beginTextureAsset,
			ZProj.ProfilerHelper.GetTextureAssetMemory(),
			0,
			0
		},
		graphicsDriverMemory = {
			0,
			ZProj.ProfilerHelper.GetGraphicsDriverMemory(),
			0,
			0
		},
		cmd = "EndRecord",
		frameNum = slot0._curRecordFrame - 1
	}))

	if slot0._cases[slot0._curCaseIdx].screenshot then
		ZProj.ScreenCaptureUtil.Instance:CaptureScreenshotAsTexture(slot0._onCaptureDone, slot0)
	end

	logNormal("EndRecord")
	slot0:dispatchEvent(PerformanceRecordEvent.onRecordDone)
end

function slot0.endRecordByEvent(slot0)
	slot0._endTime = Time.realtimeSinceStartup

	slot0:endRecord()
end

function slot0._lateUpdate(slot0)
	slot0._curRecordFrame = slot0._curRecordFrame + 1

	if slot0._recordFrameNum > 0 and slot0._recordFrameNum < slot0._curRecordFrame then
		slot0._endTime = Time.realtimeSinceStartup

		if slot0._recordFrameNum < 10 then
			TaskDispatcher.runDelay(slot0.endRecord, slot0, 0.75)
			LateUpdateBeat:Remove(slot0._lateUpdate, slot0)
		else
			slot0:endRecord()
		end

		return
	end

	slot0:_updatePerFrameData()

	if slot0._recordFrameNum <= 120 then
		if slot0._curRecordFrame % 10 == 1 then
			slot0:_updatePerSecondData()
		end
	elseif slot0._curSceondTime < os.time() then
		slot0._curSceondTime = slot1

		slot0:_updatePerSecondData()
	end
end

function slot0.onProfilerMsg(slot0, slot1)
	if string.split(slot1, "#")[1] == "BeginRecord" then
		slot0:beginRecord(tonumber(slot2[2]) or 100)
	elseif slot3 == "GetDeviceInfo" then
		slot0:_sendDevicesInfo()
	elseif slot3 == "StartCases" then
		slot0._cases = {}

		for slot9, slot10 in ipairs(string.split(slot2[2], "|")) do
			slot12 = string.split(slot10, "@")
			slot0._cases[#slot0._cases + 1] = {
				preAction = slot12[2],
				delay = slot12[3],
				startEventParams = slot12[4],
				sampleFrameNum = slot12[5],
				endEventParams = slot12[6],
				endAction = slot12[7],
				screenshot = slot12[8] == "True",
				endActionDelay = slot12[9]
			}
		end

		slot0:beginCheckCasesFlow()
	end
end

function slot0.isRecording(slot0)
	return slot0._recording
end

function slot0.exportCurFramePerformanceData(slot0)
	slot2 = string.format("%s/../curFramePerformanceData.json", UnityEngine.Application.dataPath)

	SLFramework.FileHelper.WriteTextToPath(slot2, JsonUtil.encode({
		LuaMemory = ZProj.ProfilerHelper.GetLuaMemory(),
		TotalAllocatedMemory = ZProj.ProfilerHelper.GetTotalAllocatedMemory(),
		TotalReservedMemory = ZProj.ProfilerHelper.GetTotalReservedMemory(),
		MonoHeapReservedMemory = ZProj.ProfilerHelper.GetMonoHeapReservedMemory(),
		MonoHeapUsedMemory = ZProj.ProfilerHelper.GetMonoHeapUsedMemory(),
		TextureAssetMemory = ZProj.ProfilerHelper.GetTextureAssetMemory()
	}))
	logNormal(slot2)
end

function slot0._updatePerFrameData(slot0)
	slot1 = ZProj.ProfilerHelper.GetGCAllocated()

	if slot0._monoGCCount < ZProj.ProfilerHelper.GetGCCount() then
		slot0._monoGCCount = slot2
		slot0._monoGCAmount = slot0._monoGCAmount + slot0._monoGCAllocated - slot1
	end

	slot0._monoGCAllocated = slot1
	slot0._monoGCAllocated2 = ZProj.ProfilerHelper.GetMonoUsedSizeLong()

	if slot0._luaAllocated < ZProj.ProfilerHelper.GetLuaMemory() then
		slot4 = slot3 - slot0._luaAllocated
		slot0._luaAllocateAmount = slot0._luaAllocateAmount + slot4
		slot0._luaAllocateAmountMax = math.max(slot0._luaAllocateAmountMax, slot4)
	end

	slot0._luaAllocated = slot3
	slot0._lowestFps = math.min(slot0._lowestFps, 1 / Time.deltaTime)
	slot0._fpsList[#slot0._fpsList + 1] = 1 / Time.deltaTime
end

function slot0._updatePerSecondData(slot0)
	slot1 = #slot0._luaMemoryList + 1
	slot0._luaMemoryList[slot1] = ZProj.ProfilerHelper.GetLuaMemory()
	slot0._allocatedMemoryList[slot1] = ZProj.ProfilerHelper.GetTotalAllocatedMemory()
	slot0._reservedMemoryList[slot1] = ZProj.ProfilerHelper.GetTotalReservedMemory()
	slot0._monoReservedMemoryList[slot1] = ZProj.ProfilerHelper.GetMonoHeapReservedMemory()
	slot0._monoUsedMemoryList[slot1] = ZProj.ProfilerHelper.GetMonoHeapUsedMemory()
end

function slot0.getAverageAndMax(slot0)
	slot1 = 0

	for slot7 = 1, #slot0 do
		slot3 = 0 + slot0[slot7]
		slot2 = math.max(0, slot0[slot7])
	end

	return slot3 / #slot0, slot2
end

function slot0.getAverageAndMin(slot0)
	slot1 = 0

	for slot7 = 1, #slot0 do
		slot3 = 0 + slot0[slot7]
		slot2 = math.min(999, slot0[slot7])
	end

	return slot3 / #slot0, slot2
end

function slot0._onCaptureDone(slot0, slot1)
	ZProj.ProfilerConnection.Instance:SendToEditor(UnityEngine.ImageConversion.EncodeToPNG(slot1))
end

slot1 = {
	[ModuleEnum.Performance.High] = "High",
	[ModuleEnum.Performance.Middle] = "Middle",
	[ModuleEnum.Performance.Low] = "Low"
}

function slot0._sendDevicesInfo(slot0)
	slot5, slot6 = HardwareUtil.getPerformanceGrade()

	ZProj.ProfilerConnection.Instance:SendToEditor(cjson.encode({
		deviceName = UnityEngine.SystemInfo.deviceModel,
		cpuName = BootNativeUtil.getCpuName(),
		gpuName = UnityEngine.SystemInfo.graphicsDeviceName,
		memory = UnityEngine.SystemInfo.systemMemorySize .. "M",
		DPI = UnityEngine.Screen.dpi,
		resolution = UnityEngine.Screen.currentResolution:ToString(),
		grade = uv0[slot5],
		cmd = "DeviceInfo"
	}))
end

function slot0.beginCheckCasesFlow(slot0)
	slot1 = FlowSequence.New()
	slot2 = 3
	slot0._curCaseIdx = 0

	for slot6, slot7 in ipairs(slot0._cases) do
		if not string.nilorempty(slot7.preAction) then
			slot1:addWork(DoStringActionWork.New(slot7.preAction))
		end

		if not string.nilorempty(slot7.startEventParams) then
			slot1:addWork(WaitEventWork.New(slot7.startEventParams))
		end

		slot8 = 0

		if not string.nilorempty(slot7.delay) then
			slot8 = tonumber(slot7.delay)
		end

		slot9 = tonumber(slot7.sampleFrameNum) or 120

		if not string.nilorempty(slot7.endEventParams) then
			slot9 = -1
		end

		slot1:addWork(DelayDoFuncWork.New(slot0.beginRecord, slot0, slot8, slot9))

		if not string.nilorempty(slot7.endEventParams) then
			slot1:addWork(WaitEventWork.New(slot7.endEventParams))
			slot1:addWork(DelayDoFuncWork.New(slot0.endRecordByEvent, slot0, 0))
		else
			slot1:addWork(WaitRecordDoneWork.New())
		end

		if not string.nilorempty(slot7.endAction) then
			slot10 = 0

			if not string.nilorempty(slot7.endActionDelay) then
				slot10 = tonumber(slot7.endActionDelay)
			end

			if slot10 > 0 then
				slot1:addWork(BpWaitSecWork.New(slot10))
			end

			slot1:addWork(DoStringActionWork.New(slot7.endAction))
		end

		slot1:addWork(BpWaitSecWork.New(slot2))
	end

	slot1:start()
end

function slot0.doProfilerCmdAction(slot0, slot1)
	slot0._record = {}
	slot0._recordDataCmdList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot8 = slot6.stop

		if slot0:_getProfilerAciton(slot6.cmd) then
			if slot6.frame then
				if slot10 > 1 then
					-- Nothing
				elseif slot10 == 1 then
					-- Nothing
				end
			else
				slot0:addProfilerAcitonInUpdate(slot7)
			end
		elseif slot7 == "WaitSceond" then
			-- Nothing
		end

		if slot8 then
			slot0:removeProfilerAcitonInUpdate(slot8)
		end
	end

	if slot0.workFlow then
		slot0.workFlow:registerDoneListener(slot0.onFlowDone, slot0)
		slot0.workFlow:start()
	end
end

function slot0._getProfilerAciton(slot0, slot1)
	if slot0._cmdActionDict == nil then
		slot0._cmdActionDict = {
			GetTextureMemory = slot0.recordTextureMemory,
			WaitSceond = nil,
			GetLuaMemory = slot0.recordLuaMemory,
			LogLuaMemory = slot0.logLuaMemory,
			LogRenderData = slot0.logRenderDataAction,
			LogTextureMemory = slot0.logTextureMemory
		}
	end

	return slot0._cmdActionDict[slot1]
end

function slot0._getStopProfilerAciton(slot0, slot1)
	if slot0._stopActionDict == nil then
		slot0._stopActionDict = {
			GetRenderData = slot0.stopLogRenderDataAction
		}
	end

	return slot0._stopActionDict[slot1]
end

function slot0.addProfilerAcitonInUpdate(slot0, slot1)
	if slot0:_getProfilerAciton(slot1) then
		if not slot0._secondsProfilerAcitons then
			slot0._secondsProfilerAcitons = {}

			LateUpdateBeat:Add(slot0.doProfilerAcitonInUpdate, slot0)
		end

		slot0._secondsProfilerAcitons[slot1] = slot2
	end
end

function slot0.removeProfilerAcitonInUpdate(slot0, slot1)
	slot2 = slot0:_getStopProfilerAciton(slot1)

	if not slot0._secondsProfilerAcitons then
		return
	end

	slot0._secondsProfilerAcitons[slot1] = nil

	if tabletool.len(slot0._secondsProfilerAcitons) == 0 then
		LateUpdateBeat:Remove(slot0.doProfilerAcitonInUpdate, slot0)
	end

	if slot2 then
		slot2(slot0)
	end
end

function slot0.doProfilerAcitonInUpdate(slot0)
	if not slot0._secondsProfilerAcitons then
		return
	end

	slot0._curSceondTime = slot0._curSceondTime or 0

	if os.time() <= slot0._curSceondTime then
		return
	end

	slot0._curSceondTime = slot1

	for slot6, slot7 in pairs(slot0._secondsProfilerAcitons) do
		slot2 = 0 + 1

		slot7(slot0)
	end

	if slot2 == 0 then
		LateUpdateBeat:Remove(slot0.doProfilerAcitonInUpdate, slot0)
	end
end

function slot0.getTextureMemory(slot0)
	return ZProj.ProfilerHelper.GetTextureAssetMemory()
end

function slot0.recordTextureMemory(slot0, slot1)
	if not slot1 then
		slot0._record[#slot0._record + 1] = slot0:getTextureMemory()
	else
		if slot1 == 0 then
			slot0._record[#slot0._record + 1] = {}
		end

		slot0._record[#slot0._record][slot1 + 1] = slot0:getTextureMemory()
	end
end

function slot0.getLuaMemory(slot0)
	return ZProj.ProfilerHelper.GetLuaMemory()
end

function slot0.recordLuaMemory(slot0, slot1)
	if not slot1 then
		slot0._record[#slot0._record + 1] = slot0:getLuaMemory()
	else
		if slot1 == 0 then
			slot0._record[#slot0._record + 1] = {}
		end

		slot0._record[#slot0._record][slot1 + 1] = slot0:getLuaMemory()
	end
end

function slot0.logLuaMemory(slot0)
	BenchmarkApi.AndroidLog(string.format("luaMemory:%.2f MB", slot0:getLuaMemory()))
end

function slot0.logRenderDataAction(slot0)
	if SLFramework.NativeUtil.IsAndroidX8664() then
		logWarn("X86_64 not support Catch Render Data For the [ShadowHook] is not supported On X86")

		return
	end

	if not slot0._benchMarkInited then
		slot0._benchMarkInited = BenchmarkApi.init()
	end

	if not slot0._benchMarkInlineHooked then
		BenchmarkApi.hook()

		slot0._benchMarkInlineHooked = true
	end

	if slot0._catchedFrameData then
		slot0._catchedFrameData = false

		BenchmarkApi.AndroidLog(string.format("drawCall:%s|vertCount:%s|triCount:%s", slot0:getReadableNum(BenchmarkApi.pop_draw_num()), slot0:getReadableNum(BenchmarkApi.pop_num_vertices()), slot0:getReadableNum(BenchmarkApi.pop_num_triangles())))
	end

	if not slot0._catchedFrameData then
		BenchmarkApi.clearInfo()
		BenchmarkApi.CatchSingleFrameData()

		slot0._catchedFrameData = true
	end
end

function slot0.logTextureMemory(slot0)
	BenchmarkApi.AndroidLog(string.format("textrueMemory:%.0f MB", slot0:getTextureMemory()))
end

function slot0.stopLogRenderDataAction(slot0)
	if not slot0._benchMarkInited then
		return
	end

	if slot0._benchMarkInlineHooked then
		BenchmarkApi.clearInfo()
		BenchmarkApi.unhook()
	end

	slot0._catchedFrameData = false
end

function slot0.getReadableNum(slot0, slot1)
	if slot1 < 1000 then
		return slot1
	elseif slot1 < 1000000 then
		return string.format("%.1f", slot1 / 1000) .. "k"
	else
		return string.format("%.1f", slot1 / 1000000) .. "m"
	end
end

function slot0.onFlowDone(slot0)
	for slot5, slot6 in ipairs(slot0._record) do
		-- Nothing
	end

	slot2 = JsonUtil.encode({
		[slot5 .. slot0._recordDataCmdList[slot5].cmd] = slot6
	})
	slot6 = io.open(System.IO.Path.Combine(System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "profiler"), "profilerResult.json"), "w")

	slot6:write(tostring(slot2))
	slot6:close()
	BenchmarkApi.AndroidLog(slot2)

	slot0.flow = nil
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
