module("modules.logic.gm.controller.PerformanceRecorder", package.seeall)

slot0 = class("PerformanceRecorder")

function slot0.init(slot0)
	slot0._curTime = 0
	slot0._curFrameCount = 0
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

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
