module("modules.common.global.screen.GameScreenState", package.seeall)

slot0 = class("GameScreenState")

function slot0.ctor(slot0)
	if SDKMgr.instance:isEmulator() then
		UnityEngine.QualitySettings.resolutionScalingFixedDPIFactor = 10
	end

	if SLFramework.FrameworkSettings.IsEditor then
		slot0:setLocalQuality(PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High))
		slot0:setTargetFrameRate(PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, ModuleEnum.TargetFrameRate.High))
	else
		slot1 = HardwareUtil.getPerformanceGrade()

		slot0:setLocalQuality(PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, nil) or slot1)
		slot0:setTargetFrameRate(PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, nil) or (slot1 ~= ModuleEnum.Performance.High or ModuleEnum.TargetFrameRate.High) and ModuleEnum.TargetFrameRate.Low)
		MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, slot0._onFirstEnterMain, slot0)
	end

	slot0._width, slot0._height = SettingsModel.instance:getCurrentScreenSize()

	ZProj.ScreenSizeMgr.Instance:SetLuaCallback(slot0._onResolutionChange, slot0)
end

function slot0._onFirstEnterMain(slot0)
	if SLFramework.FrameworkSettings.IsEditor then
		return
	end

	MainController.instance:unregisterCallback(MainEvent.OnFirstEnterMain, slot0._onFirstEnterMain, slot0)

	if not PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMCollectCPUGPU, nil) then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMCollectCPUGPU, 1)

		if CommonConfig.instance:getCPULevel(BootNativeUtil.getCpuName() or "") == ModuleEnum.Performance.Undefine or CommonConfig.instance:getGPULevel(UnityEngine.SystemInfo.graphicsDeviceName or "") == ModuleEnum.Performance.Undefine then
			GMRpc.instance:sendGpuCpuLogRequest(slot2, slot3)
		end
	end
end

function slot0.getLocalQuality(slot0)
	return slot0.grade
end

function slot0.getTargetFrameRate(slot0)
	return slot0.targetFrameRate
end

function slot0.setLocalQuality(slot0, slot1, slot2)
	slot0.grade = slot1

	if not slot2 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, slot1)
	end

	slot3 = 2
	slot4 = 7
	slot5 = 1
	slot6 = 1
	slot7 = 0
	slot8 = 1
	slot9 = 1
	slot10 = 300

	if BootNativeUtil.isWindows() then
		UnityEngine.QualitySettings.vSyncCount = 1
	else
		UnityEngine.QualitySettings.vSyncCount = 0

		if UnityEngine.SystemInfo.deviceModel:find("Huawei Tablet M5") or slot11:find("bah2-w09") then
			UnityEngine.QualitySettings.vSyncCount = 1
		end
	end

	slot11 = 8

	if slot1 == ModuleEnum.Performance.Low then
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier1
		slot10 = 100
		slot11 = 8
	elseif slot1 == ModuleEnum.Performance.Middle then
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier2
		slot10 = 150
		slot11 = 10
	else
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier3
		slot10 = 300
		slot11 = 12
	end

	UnityEngine.QualitySettings.SetQualityLevel(slot3, true)
	PostProcessingMgr.instance:setMainPPLevel(slot1)
	CameraMgr.instance:setRenderScale(slot8)

	UnityEngine.Shader.globalMaximumLOD = slot10

	GameResMgr:SetMaxFileLoadingCount(slot11)
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnQualityChange)
end

function slot0.resetMaxFileLoadingCount(slot0)
	slot1 = 8

	GameResMgr:SetMaxFileLoadingCount(slot0.grade == ModuleEnum.Performance.Low and 8 or slot0.grade == ModuleEnum.Performance.Middle and 10 or 12)
end

function slot0.setTargetFrameRate(slot0, slot1, slot2)
	slot0.targetFrameRate = slot1

	if not slot2 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, slot1)
	end

	UnityEngine.Application.targetFrameRate = slot1
end

function slot0._onResolutionChange(slot0, slot1, slot2)
	slot0._width = slot1
	slot0._height = slot2

	TaskDispatcher.cancelTask(slot0._delayDispatchResizeEvent, slot0)
	TaskDispatcher.runDelay(slot0._delayDispatchResizeEvent, slot0, 0.01)
	slot0:_setSoftMaskEnable(false)
end

function slot0._delayDispatchResizeEvent(slot0)
	slot0:_setSoftMaskEnable(true)
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, slot0._width, slot0._height)
end

function slot0._setSoftMaskEnable(slot0, slot1)
	slot7 = false

	for slot7 = 0, ViewMgr.instance:getUIRoot():GetComponentsInChildren(typeof(Coffee.UISoftMask.SoftMask), slot7).Length - 1 do
		slot3[slot7].enabled = slot1
	end
end

function slot0.getScreenSize(slot0)
	return slot0._width, slot0._height
end

return slot0
