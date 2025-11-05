module("modules.logic.settings.model.SettingsModel", package.seeall)

local var_0_0 = class("SettingsModel", BaseModel)

function var_0_0.setVideoEnabled(arg_1_0, arg_1_1)
	arg_1_0._isVideoEnabled = arg_1_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoEnabled, arg_1_0._isVideoEnabled)
end

function var_0_0.getVideoEnabled(arg_2_0)
	if arg_2_0._isVideoEnabled == nil then
		arg_2_0._isVideoEnabled = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoEnabled, 1)
	end

	return arg_2_0._isVideoEnabled == 1
end

var_0_0.ResolutionRatioWidthList = {
	15360,
	7680,
	3840,
	2560,
	1920,
	1600,
	1366,
	1280,
	1152,
	1024,
	800
}
var_0_0.FrameRate = {
	30,
	60,
	120,
	144
}

function var_0_0.onInit(arg_3_0)
	arg_3_0._curCategoryId = 1
	arg_3_0._categoryList = {}
	arg_3_0.showHelper = arg_3_0.showHelper or SettingsShowHelper.New()

	local var_3_0 = 80
	local var_3_1 = 100

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.FirstBootForBetaTest, 0) == 1 or not BootNativeUtil.isStandalonePlayer() or SLFramework.FrameworkSettings.IsEditor then
		arg_3_0._musicValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsMusicValue, var_3_0)
		arg_3_0._voiceValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVoiceValue, var_3_0)
		arg_3_0._effectValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEffectValue, var_3_0)
		arg_3_0._globalAudioVolume = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, var_3_1)
	else
		arg_3_0._musicValue = var_3_0
		arg_3_0._voiceValue = var_3_0
		arg_3_0._effectValue = var_3_0
		arg_3_0._globalAudioVolume = var_3_1
		arg_3_0._pushStates = {}

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.FirstBootForBetaTest, 1)
	end

	arg_3_0._musicValue = math.ceil(arg_3_0._musicValue)
	arg_3_0._voiceValue = math.ceil(arg_3_0._voiceValue)
	arg_3_0._effectValue = math.ceil(arg_3_0._effectValue)
	arg_3_0._energyMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEnergyMode, 0)

	local var_3_2 = BootNativeUtil.isAndroid() and 0 or 1

	arg_3_0._screenshotSwitch = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsScreenshotSwitch, var_3_2)

	if BootNativeUtil.isAndroid() and SDKMgr.instance:checkReadExternalStoragePermissions() then
		arg_3_0._screenshotSwitch = 0
	end

	arg_3_0._minRate = 1.3333333333333333
	arg_3_0._maxRate = 2.4

	if SLFramework.FrameworkSettings.IsEditor then
		arg_3_0._screenWidth, arg_3_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	elseif BootNativeUtil.isWindows() then
		arg_3_0:initRateAndSystemSize()
		arg_3_0:initWindowsResolution()
		arg_3_0:initResolutionRationDataList()
	else
		arg_3_0._screenWidth, arg_3_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	end

	arg_3_0.limitedRoleMO = SettingsLimitedRoleMO.New()
end

function var_0_0.reInit(arg_4_0)
	arg_4_0.limitedRoleMO:reInit()
end

function var_0_0.initRateAndSystemSize(arg_5_0)
	arg_5_0._systemScreenWidth, arg_5_0._systemScreenHeight = BootNativeUtil.getDisplayResolution()
	arg_5_0._curRate = arg_5_0._systemScreenWidth / arg_5_0._systemScreenHeight

	if arg_5_0._curRate < arg_5_0._minRate then
		arg_5_0._systemScreenHeight = arg_5_0._systemScreenWidth / arg_5_0._minRate
		arg_5_0._curRate = arg_5_0._minRate
	end

	if arg_5_0._curRate > arg_5_0._maxRate then
		arg_5_0._systemScreenWidth = arg_5_0._systemScreenHeight * arg_5_0._maxRate
		arg_5_0._curRate = arg_5_0._maxRate
	end
end

function var_0_0.initResolutionRationDataList(arg_6_0)
	arg_6_0._resolutionRatioDataList = {}

	if SLFramework.FrameworkSettings.IsEditor then
		arg_6_0:_appendResolutionData(UnityEngine.Screen.width, UnityEngine.Screen.height, false)

		return
	end

	local var_6_0 = UnityEngine.Screen.currentResolution.width

	if arg_6_0._resolutionRatioDataList and #arg_6_0._resolutionRatioDataList >= 1 and arg_6_0._resolutionRatioDataList[1] == var_6_0 then
		return
	end

	local var_6_1 = math.floor(var_6_0 / arg_6_0._curRate)

	arg_6_0:_appendResolutionData(var_6_0, var_6_1, true)

	for iter_6_0, iter_6_1 in ipairs(var_0_0.ResolutionRatioWidthList) do
		if iter_6_1 <= arg_6_0._systemScreenWidth and iter_6_1 <= var_6_0 then
			local var_6_2 = math.floor(iter_6_1 / arg_6_0._curRate)

			arg_6_0:_appendResolutionData(iter_6_1, var_6_2, false)
		end
	end

	local var_6_3, var_6_4 = arg_6_0:getCurrentDropDownIndex()

	if var_6_4 then
		local var_6_5, var_6_6, var_6_7 = arg_6_0:getCurrentResolutionWHAndIsFull()

		arg_6_0:_appendResolutionData(var_6_5, var_6_6, var_6_7)
	end
end

function var_0_0.initWindowsResolution(arg_7_0)
	if SLFramework.FrameworkSettings.IsEditor then
		arg_7_0._screenWidth, arg_7_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height

		arg_7_0:_setIsFullScreen(false)

		arg_7_0._resolutionRatio = arg_7_0:_resolutionStr(arg_7_0._screenWidth, arg_7_0._screenHeight)
	else
		arg_7_0._resolutionRatio = PlayerPrefsHelper.getString(PlayerPrefsKey.ResolutionRatio, nil)

		local var_7_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FullScreenKey, ModuleEnum.FullScreenState.On)

		arg_7_0:_setIsFullScreen(var_7_0 == ModuleEnum.FullScreenState.On)

		if arg_7_0:isFullScreen() then
			local var_7_1 = UnityEngine.Screen.currentResolution

			arg_7_0._screenWidth = var_7_1.width
			arg_7_0._screenHeight = var_7_1.height
		else
			local var_7_2 = not string.nilorempty(arg_7_0._resolutionRatio) and arg_7_0._resolutionRatio ~= "nil"
			local var_7_3 = var_7_2 and string.splitToNumber(arg_7_0._resolutionRatio, "*") or {
				1920,
				1080
			}
			local var_7_4 = UnityEngine.Screen.width

			if var_7_2 and var_7_4 <= var_7_3[1] then
				arg_7_0._screenWidth = var_7_3[1]
				arg_7_0._screenHeight = var_7_3[2]
			else
				local var_7_5 = math.floor(var_7_4 / arg_7_0._curRate)

				arg_7_0._screenWidth = var_7_4
				arg_7_0._screenHeight = var_7_5
				arg_7_0._resolutionRatio = arg_7_0:_resolutionStr(var_7_4, var_7_5)
			end
		end
	end

	arg_7_0:setResolutionRatio()
end

function var_0_0.getCurCategoryId(arg_8_0)
	return arg_8_0._curCategoryId
end

function var_0_0.setCurCategoryId(arg_9_0, arg_9_1)
	arg_9_0._curCategoryId = arg_9_1
end

function var_0_0.setSettingsCategoryList(arg_10_0, arg_10_1)
	arg_10_0._categoryList = arg_10_1
end

function var_0_0.getSettingsCategoryList(arg_11_0)
	arg_11_0._categoryList = {}

	for iter_11_0, iter_11_1 in ipairs(SettingsEnum.CategoryList) do
		if arg_11_0:canShowCategory(iter_11_1) then
			table.insert(arg_11_0._categoryList, iter_11_1)
		end
	end

	return arg_11_0._categoryList
end

function var_0_0.canShowCategory(arg_12_0, arg_12_1)
	if arg_12_1.name == "settings_push" and BootNativeUtil.isWindows() then
		return false
	end

	local var_12_0 = #arg_12_1.openIds == 0 and arg_12_1.showIds == nil or false

	for iter_12_0, iter_12_1 in pairs(arg_12_1.openIds) do
		if OpenModel.instance:isFuncBtnShow(iter_12_1) then
			var_12_0 = true

			break
		end
	end

	if not var_12_0 and arg_12_1.showIds then
		for iter_12_2, iter_12_3 in pairs(arg_12_1.showIds) do
			if arg_12_0.showHelper:canShow(iter_12_3) then
				var_12_0 = true

				break
			end
		end
	end

	if arg_12_1.hideOnGamepadModle and GamepadController.instance:isOpen() then
		var_12_0 = false
	end

	return var_12_0
end

function var_0_0.isBilibili()
	local var_13_0 = SDKMgr.instance:getChannelId()

	var_13_0 = var_13_0 and tostring(var_13_0)

	return not string.nilorempty(var_13_0) and var_13_0 == "101"
end

function var_0_0.getScreenshotSwitch(arg_14_0)
	return arg_14_0._screenshotSwitch > 0
end

function var_0_0.setScreenshotSwitch(arg_15_0, arg_15_1)
	arg_15_0._screenshotSwitch = arg_15_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsScreenshotSwitch, arg_15_0._screenshotSwitch)
end

function var_0_0.changeEnergyMode(arg_16_0)
	if arg_16_0._energyMode == 1 then
		arg_16_0._energyMode = 0

		GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_16_0:getModelGraphicsQuality())
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_16_0._frameRate)
	else
		arg_16_0._energyMode = 1

		GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEnergyMode, arg_16_0._energyMode)
end

function var_0_0.getEnergyMode(arg_17_0)
	return arg_17_0._energyMode
end

function var_0_0.getMusicValue(arg_18_0)
	return arg_18_0._musicValue
end

function var_0_0.setMusicValue(arg_19_0, arg_19_1)
	arg_19_0._musicValue = arg_19_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Music_Volume, arg_19_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsMusicValue, arg_19_0._musicValue)
end

function var_0_0.getVoiceValue(arg_20_0)
	return arg_20_0._voiceValue
end

function var_0_0.setVoiceValue(arg_21_0, arg_21_1)
	arg_21_0._voiceValue = arg_21_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Voc_Volume, arg_21_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVoiceValue, arg_21_0._voiceValue)

	if arg_21_0._voiceValue > 0 then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("no"))
	else
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("yes"))
	end
end

function var_0_0.getEffectValue(arg_22_0)
	return arg_22_0._effectValue
end

function var_0_0.setEffectValue(arg_23_0, arg_23_1)
	arg_23_0._effectValue = arg_23_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.SFX_Volume, arg_23_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEffectValue, arg_23_0._effectValue)
end

function var_0_0.getGlobalAudioVolume(arg_24_0)
	return arg_24_0._globalAudioVolume
end

function var_0_0.setGlobalAudioVolume(arg_25_0, arg_25_1)
	arg_25_0._globalAudioVolume = arg_25_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, arg_25_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, arg_25_0._globalAudioVolume)
end

function var_0_0.getRealGraphicsQuality(arg_26_0)
	return GameGlobalMgr.instance:getScreenState():getLocalQuality()
end

function var_0_0.getModelGraphicsQuality(arg_27_0)
	if not arg_27_0._graphicsQuality then
		arg_27_0._graphicsQuality = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGraphicsQuality, arg_27_0:getRecommendQuality())
	end

	return arg_27_0._graphicsQuality
end

function var_0_0.setGraphicsQuality(arg_28_0, arg_28_1)
	arg_28_0._graphicsQuality = arg_28_1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGraphicsQuality, arg_28_0._graphicsQuality)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_28_1)
end

function var_0_0.getRecommendQuality(arg_29_0)
	return HardwareUtil.getPerformanceGrade()
end

function var_0_0.getRealTargetFrameRate(arg_30_0)
	return GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
end

function var_0_0.getModelTargetFrameRate(arg_31_0)
	if not arg_31_0._frameRate then
		arg_31_0._frameRate = GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
	end

	return arg_31_0._frameRate
end

function var_0_0.setTargetFrameRate(arg_32_0, arg_32_1)
	arg_32_0._frameRate = arg_32_1

	GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_32_1)
end

function var_0_0.getVSyncCount(arg_33_0)
	return GameGlobalMgr.instance:getScreenState():getVSyncCount()
end

function var_0_0.setVSyncCount(arg_34_0, arg_34_1)
	GameGlobalMgr.instance:getScreenState():setVSyncCount(arg_34_1)
end

function var_0_0._setIsFullScreen(arg_35_0, arg_35_1)
	arg_35_0._isFullScreen = arg_35_1 and ModuleEnum.FullScreenState.On or ModuleEnum.FullScreenState.Off
end

function var_0_0._setScreenWidthAndHeight(arg_36_0, arg_36_1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	local var_36_0 = string.splitToNumber(arg_36_1, "*")

	if var_36_0[1] > arg_36_0._systemScreenWidth or var_36_0[2] > arg_36_0._systemScreenHeight then
		GameFacade.showToast(ToastEnum.SetScreenWidthAndHeightFail)

		return false
	end

	arg_36_0._screenWidth = var_36_0[1]
	arg_36_0._screenHeight = var_36_0[2]

	arg_36_0:_setIsFullScreen(false)

	arg_36_0._resolutionRatio = arg_36_1

	arg_36_0:setResolutionRatio()

	return true
end

function var_0_0.getResolutionRatio(arg_37_0)
	return arg_37_0._resolutionRatio
end

function var_0_0.setResolutionRatio(arg_38_0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.ResolutionRatio, arg_38_0._resolutionRatio)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, arg_38_0._isFullScreen)
	ZProj.GameHelper.SetResolutionRatio(arg_38_0._screenWidth, arg_38_0._screenHeight, arg_38_0:isFullScreen())
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, arg_38_0._screenWidth, arg_38_0._screenHeight)
end

function var_0_0.getCurrentScreenResolutionRatio(arg_39_0)
	return arg_39_0._screenWidth / arg_39_0._screenHeight
end

function var_0_0.getCurrentScreenSize(arg_40_0)
	return arg_40_0._screenWidth, arg_40_0._screenHeight
end

function var_0_0.isFullScreen(arg_41_0)
	return arg_41_0._isFullScreen == ModuleEnum.FullScreenState.On
end

function var_0_0.setFullChange(arg_42_0, arg_42_1)
	arg_42_0._isFullScreen = arg_42_1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, arg_42_1)

	if arg_42_0:isFullScreen() then
		ZProj.GameHelper.SetResolutionRatio(arg_42_0._systemScreenWidth, arg_42_0._systemScreenHeight, true)
	else
		ZProj.GameHelper.SetResolutionRatio(arg_42_0._screenWidth, arg_42_0._screenHeight, false)
	end
end

function var_0_0.getScreenSizeMinRate(arg_43_0)
	return arg_43_0._minRate
end

function var_0_0.getScreenSizeMaxRate(arg_44_0)
	return arg_44_0._maxRate
end

function var_0_0.checkInitRecordVideo(arg_45_0)
	if arg_45_0._isRecordVideo ~= nil then
		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) then
		arg_45_0._isRecordVideo = 0

		return
	end

	arg_45_0._isRecordVideo = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsRecordVideo, 0)
end

function var_0_0.setRecordVideo(arg_46_0, arg_46_1)
	arg_46_0:checkInitRecordVideo()

	arg_46_0._isRecordVideo = arg_46_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsRecordVideo, arg_46_0._isRecordVideo)
end

function var_0_0.getRecordVideo(arg_47_0)
	arg_47_0:checkInitRecordVideo()

	return arg_47_0._isRecordVideo == 1
end

function var_0_0.setVideoCompatible(arg_48_0, arg_48_1)
	arg_48_0._isVideoCompatible = arg_48_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoCompatible, arg_48_0._isVideoCompatible)
end

function var_0_0.getVideoCompatible(arg_49_0)
	if arg_49_0._isVideoCompatible == nil then
		arg_49_0._isVideoCompatible = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoCompatible, 0)
	end

	return arg_49_0._isVideoCompatible == 1
end

function var_0_0.setVideoHDMode(arg_50_0, arg_50_1)
	arg_50_0._isVideoHDMode = arg_50_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoHDMode, arg_50_0._isVideoHDMode)
end

function var_0_0.getVideoHDMode(arg_51_0)
	if not PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVideoHDMode) and BootNativeUtil.isWindows() then
		arg_51_0:setVideoHDMode(true)
	end

	local var_51_0 = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if var_51_0 == nil or var_51_0:needDownload() then
		arg_51_0:setVideoHDMode(false)
	end

	if arg_51_0._isVideoHDMode == nil then
		arg_51_0._isVideoHDMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoHDMode, 0)
	end

	return arg_51_0._isVideoHDMode == 1
end

function var_0_0.setPushState(arg_52_0, arg_52_1)
	arg_52_0._pushStates = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		arg_52_0._pushStates[iter_52_1.type] = {}
		arg_52_0._pushStates[iter_52_1.type].type = iter_52_1.type
		arg_52_0._pushStates[iter_52_1.type].param = iter_52_1.param
	end
end

function var_0_0.updatePushState(arg_53_0, arg_53_1, arg_53_2)
	if not arg_53_0._pushStates[arg_53_1] then
		arg_53_0._pushStates[arg_53_1] = {}
		arg_53_0._pushStates[arg_53_1].type = arg_53_1
	end

	arg_53_0._pushStates[arg_53_1].param = arg_53_2
end

function var_0_0.isPushTypeOn(arg_54_0, arg_54_1)
	local var_54_0 = SDKMgr.instance:isNotificationEnable()
	local var_54_1 = arg_54_0._pushStates[arg_54_1] and arg_54_0._pushStates[arg_54_1].param == "1"

	return var_54_0 and var_54_1
end

function var_0_0.isTypeOn(arg_55_0, arg_55_1)
	return arg_55_0._pushStates[arg_55_1] and arg_55_0._pushStates[arg_55_1].param == "1"
end

function var_0_0._resolutionStr(arg_56_0, arg_56_1, arg_56_2)
	return string.format("%s * %s", arg_56_1, arg_56_2)
end

function var_0_0.getResolutionRatioStrList(arg_57_0)
	arg_57_0:initResolutionRationDataList()

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_0._resolutionRatioDataList) do
		local var_57_1 = arg_57_0:_resolutionStr(iter_57_1.width, iter_57_1.height)

		if iter_57_1.isFullscreen then
			var_57_1 = luaLang("settings_fullscreen")
		end

		table.insert(var_57_0, var_57_1)
	end

	return var_57_0
end

function var_0_0._appendResolutionData(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	table.insert(arg_58_0._resolutionRatioDataList, {
		width = arg_58_1,
		height = arg_58_2,
		isFullscreen = arg_58_3
	})
end

function var_0_0.setScreenResolutionByIndex(arg_59_0, arg_59_1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if not arg_59_0._resolutionRatioDataList then
		return false
	end

	local var_59_0 = arg_59_0._resolutionRatioDataList[arg_59_1]

	if not var_59_0 then
		GameFacade.showToastString("error index:" .. arg_59_1)

		return false
	end

	arg_59_0._screenWidth = var_59_0.width
	arg_59_0._screenHeight = var_59_0.height

	arg_59_0:_setIsFullScreen(var_59_0.isFullscreen)

	arg_59_0._resolutionRatio = arg_59_0:_resolutionStr(arg_59_0._screenWidth, arg_59_0._screenHeight)

	arg_59_0:setResolutionRatio()

	return true
end

function var_0_0.getCurrentResolutionWHAndIsFull(arg_60_0)
	if not arg_60_0._resolutionRatio then
		arg_60_0:initWindowsResolution()
	end

	local var_60_0 = string.splitToNumber(arg_60_0._resolutionRatio, "*")

	if not var_60_0 then
		return 0, 0, false
	end

	local var_60_1 = arg_60_0:isFullScreen()

	return var_60_0[1], var_60_0[2], var_60_1
end

function var_0_0.getCurrentDropDownIndex(arg_61_0)
	local var_61_0, var_61_1, var_61_2 = arg_61_0:getCurrentResolutionWHAndIsFull()

	if var_61_2 then
		return 0
	end

	for iter_61_0, iter_61_1 in ipairs(arg_61_0._resolutionRatioDataList or {}) do
		if not iter_61_1.isFullscreen and var_61_0 == iter_61_1.width and var_61_1 == iter_61_1.height then
			return iter_61_0 - 1
		end
	end

	return 0, true
end

function var_0_0.getCurrentFrameRateIndex(arg_62_0)
	local var_62_0 = arg_62_0:getModelTargetFrameRate()

	for iter_62_0, iter_62_1 in ipairs(var_0_0.FrameRate) do
		if var_62_0 == iter_62_1 then
			return iter_62_0
		end
	end

	return 1
end

function var_0_0.setModelTargetFrameRate(arg_63_0, arg_63_1)
	local var_63_0 = var_0_0.FrameRate[arg_63_1 + 1]

	if var_63_0 then
		logNormal("设置帧率: ", var_63_0)
		arg_63_0:setTargetFrameRate(var_63_0)
	end
end

function var_0_0.isNatives(arg_64_0)
	return not arg_64_0:isOverseas()
end

function var_0_0.isOverseas(arg_65_0)
	return true
end

function var_0_0.getRegion(arg_66_0)
	if arg_66_0:isNatives() then
		return RegionEnum.zh
	else
		local var_66_0 = SDKMgr.instance:getGameId()

		if tostring(var_66_0) == "80001" then
			return RegionEnum.tw
		elseif tostring(var_66_0) == "90001" then
			return RegionEnum.ko
		end

		return GameConfig:GetCurRegionType()
	end
end

function var_0_0.isZhRegion(arg_67_0)
	return arg_67_0:getRegion() == RegionEnum.zh
end

function var_0_0.isJpRegion(arg_68_0)
	return arg_68_0:getRegion() == RegionEnum.jp
end

function var_0_0.isEnRegion(arg_69_0)
	return arg_69_0:getRegion() == RegionEnum.en
end

function var_0_0.isTwRegion(arg_70_0)
	return arg_70_0:getRegion() == RegionEnum.tw
end

function var_0_0.isKrRegion(arg_71_0)
	return arg_71_0:getRegion() == RegionEnum.ko
end

function var_0_0.getRegionShortcut(arg_72_0)
	return RegionEnum.shortcutTab[arg_72_0:getRegion()] or "en"
end

function var_0_0.extractByRegion(arg_73_0, arg_73_1)
	if string.nilorempty(arg_73_1) then
		return arg_73_1
	end

	local var_73_0 = GameUtil.splitString2(arg_73_1, false)
	local var_73_1 = arg_73_0:getRegionShortcut()

	for iter_73_0, iter_73_1 in ipairs(var_73_0) do
		if iter_73_1[1] == var_73_1 then
			return iter_73_1[2]
		end
	end

	return arg_73_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
