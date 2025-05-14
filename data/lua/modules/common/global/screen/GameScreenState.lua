module("modules.common.global.screen.GameScreenState", package.seeall)

local var_0_0 = class("GameScreenState")

function var_0_0.ctor(arg_1_0)
	if SDKMgr.instance:isEmulator() then
		UnityEngine.QualitySettings.resolutionScalingFixedDPIFactor = 10
	end

	if SLFramework.FrameworkSettings.IsEditor then
		local var_1_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High)
		local var_1_1 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, ModuleEnum.TargetFrameRate.High)

		arg_1_0:setLocalQuality(var_1_0)
		arg_1_0:setTargetFrameRate(var_1_1)
	else
		local var_1_2 = HardwareUtil.getPerformanceGrade()
		local var_1_3 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, nil) or var_1_2
		local var_1_4 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, nil)

		if not var_1_4 then
			if var_1_2 == ModuleEnum.Performance.High then
				var_1_4 = ModuleEnum.TargetFrameRate.High
			else
				var_1_4 = ModuleEnum.TargetFrameRate.Low
			end
		end

		arg_1_0:setLocalQuality(var_1_3)
		arg_1_0:setTargetFrameRate(var_1_4)
		MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, arg_1_0._onFirstEnterMain, arg_1_0)
	end

	arg_1_0._width, arg_1_0._height = SettingsModel.instance:getCurrentScreenSize()

	ZProj.ScreenSizeMgr.Instance:SetLuaCallback(arg_1_0._onResolutionChange, arg_1_0)
end

function var_0_0._onFirstEnterMain(arg_2_0)
	if SLFramework.FrameworkSettings.IsEditor then
		return
	end

	MainController.instance:unregisterCallback(MainEvent.OnFirstEnterMain, arg_2_0._onFirstEnterMain, arg_2_0)

	if not PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMCollectCPUGPU, nil) then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMCollectCPUGPU, 1)

		local var_2_0 = BootNativeUtil.getCpuName()
		local var_2_1 = UnityEngine.SystemInfo.graphicsDeviceName
		local var_2_2 = CommonConfig.instance:getCPULevel(var_2_0 or "")
		local var_2_3 = CommonConfig.instance:getGPULevel(var_2_1 or "")

		if var_2_2 == ModuleEnum.Performance.Undefine or var_2_3 == ModuleEnum.Performance.Undefine then
			GMRpc.instance:sendGpuCpuLogRequest(var_2_0, var_2_1)
		end
	end
end

function var_0_0.getLocalQuality(arg_3_0)
	return arg_3_0.grade
end

function var_0_0.getTargetFrameRate(arg_4_0)
	return arg_4_0.targetFrameRate
end

function var_0_0.setLocalQuality(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.grade = arg_5_1

	if not arg_5_2 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, arg_5_1)
	end

	local var_5_0 = 2
	local var_5_1 = 7
	local var_5_2 = 1
	local var_5_3 = 1
	local var_5_4 = 0
	local var_5_5 = 1
	local var_5_6 = 1
	local var_5_7 = 300

	if BootNativeUtil.isWindows() then
		local var_5_8 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVSyncCount, 1)

		arg_5_0:setVSyncCount(var_5_8, true)
	else
		UnityEngine.QualitySettings.vSyncCount = 0

		local var_5_9 = UnityEngine.SystemInfo.deviceModel

		if var_5_9:find("Huawei Tablet M5") or var_5_9:find("bah2-w09") then
			UnityEngine.QualitySettings.vSyncCount = 1
		end
	end

	local var_5_10 = 8
	local var_5_11

	if arg_5_1 == ModuleEnum.Performance.Low then
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier1
		var_5_7 = 100
		var_5_11 = 8
	elseif arg_5_1 == ModuleEnum.Performance.Middle then
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier2
		var_5_7 = 150
		var_5_11 = 10
	else
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier3
		var_5_7 = 300
		var_5_11 = 12
	end

	UnityEngine.QualitySettings.SetQualityLevel(var_5_0, true)
	PostProcessingMgr.instance:setMainPPLevel(arg_5_1)
	CameraMgr.instance:setRenderScale(var_5_5)

	UnityEngine.Shader.globalMaximumLOD = var_5_7

	GameResMgr:SetMaxFileLoadingCount(var_5_11)
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnQualityChange)
end

function var_0_0.resetMaxFileLoadingCount(arg_6_0)
	local var_6_0 = 8
	local var_6_1 = arg_6_0.grade == ModuleEnum.Performance.Low and 8 or arg_6_0.grade == ModuleEnum.Performance.Middle and 10 or 12

	GameResMgr:SetMaxFileLoadingCount(var_6_1)
end

function var_0_0.getVSyncCount(arg_7_0)
	return arg_7_0.vSyncCount
end

function var_0_0.setVSyncCount(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.vSyncCount = arg_8_1

	if not arg_8_2 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVSyncCount, arg_8_0.vSyncCount)
	end

	UnityEngine.QualitySettings.vSyncCount = arg_8_0.vSyncCount
end

function var_0_0.setTargetFrameRate(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.targetFrameRate = arg_9_1

	if not arg_9_2 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, arg_9_1)
	end

	UnityEngine.Application.targetFrameRate = arg_9_1
end

function var_0_0._onResolutionChange(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._width = arg_10_1
	arg_10_0._height = arg_10_2

	TaskDispatcher.cancelTask(arg_10_0._delayDispatchResizeEvent, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._delayDispatchResizeEvent, arg_10_0, 0.01)
	arg_10_0:_setSoftMaskEnable(false)
end

function var_0_0._delayDispatchResizeEvent(arg_11_0)
	arg_11_0:_setSoftMaskEnable(true)
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, arg_11_0._width, arg_11_0._height)
end

function var_0_0._setSoftMaskEnable(arg_12_0, arg_12_1)
	local var_12_0 = ViewMgr.instance:getUIRoot():GetComponentsInChildren(typeof(Coffee.UISoftMask.SoftMask), false)

	for iter_12_0 = 0, var_12_0.Length - 1 do
		var_12_0[iter_12_0].enabled = arg_12_1
	end
end

function var_0_0.getScreenSize(arg_13_0)
	return arg_13_0._width, arg_13_0._height
end

return var_0_0
