module("modules.logic.settings.model.SettingsModel", package.seeall)

local var_0_0 = class("SettingsModel", BaseModel)

function var_0_0.extractByRegion(arg_1_0, arg_1_1)
	if string.nilorempty(arg_1_1) then
		return arg_1_1
	end

	local var_1_0 = GameUtil.splitString2(arg_1_1, false)
	local var_1_1 = arg_1_0:getRegionShortcut()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1[1] == var_1_1 then
			return iter_1_1[2]
		end
	end

	return arg_1_1
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

function var_0_0.onInit(arg_2_0)
	arg_2_0._curCategoryId = 1
	arg_2_0._categoryList = {}
	arg_2_0.showHelper = arg_2_0.showHelper or SettingsShowHelper.New()

	local var_2_0 = 80
	local var_2_1 = 100

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.FirstBootForBetaTest, 0) == 1 or not BootNativeUtil.isStandalonePlayer() or SLFramework.FrameworkSettings.IsEditor then
		arg_2_0._musicValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsMusicValue, var_2_0)
		arg_2_0._voiceValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVoiceValue, var_2_0)
		arg_2_0._effectValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEffectValue, var_2_0)
		arg_2_0._globalAudioVolume = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, var_2_1)
	else
		arg_2_0._musicValue = var_2_0
		arg_2_0._voiceValue = var_2_0
		arg_2_0._effectValue = var_2_0
		arg_2_0._globalAudioVolume = var_2_1
		arg_2_0._pushStates = {}

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.FirstBootForBetaTest, 1)
	end

	arg_2_0._musicValue = math.ceil(arg_2_0._musicValue)
	arg_2_0._voiceValue = math.ceil(arg_2_0._voiceValue)
	arg_2_0._effectValue = math.ceil(arg_2_0._effectValue)
	arg_2_0._energyMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEnergyMode, 0)

	local var_2_2 = BootNativeUtil.isAndroid() and 0 or 1

	arg_2_0._screenshotSwitch = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsScreenshotSwitch, var_2_2)

	if BootNativeUtil.isAndroid() and SDKMgr.instance:checkReadExternalStoragePermissions() then
		arg_2_0._screenshotSwitch = 0
	end

	arg_2_0._minRate = 1.3333333333333333
	arg_2_0._maxRate = 2.4

	if SLFramework.FrameworkSettings.IsEditor then
		arg_2_0._screenWidth, arg_2_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	elseif BootNativeUtil.isWindows() then
		arg_2_0:initRateAndSystemSize()
		arg_2_0:initWindowsResolution()
		arg_2_0:initResolutionRationDataList()
	else
		arg_2_0._screenWidth, arg_2_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	end

	arg_2_0.limitedRoleMO = SettingsLimitedRoleMO.New()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0.limitedRoleMO:reInit()
end

function var_0_0.initRateAndSystemSize(arg_4_0)
	arg_4_0._systemScreenWidth, arg_4_0._systemScreenHeight = BootNativeUtil.getDisplayResolution()
	arg_4_0._curRate = arg_4_0._systemScreenWidth / arg_4_0._systemScreenHeight

	if arg_4_0._curRate < arg_4_0._minRate then
		arg_4_0._systemScreenHeight = arg_4_0._systemScreenWidth / arg_4_0._minRate
		arg_4_0._curRate = arg_4_0._minRate
	end

	if arg_4_0._curRate > arg_4_0._maxRate then
		arg_4_0._systemScreenWidth = arg_4_0._systemScreenHeight * arg_4_0._maxRate
		arg_4_0._curRate = arg_4_0._maxRate
	end
end

function var_0_0.initResolutionRationDataList(arg_5_0)
	arg_5_0._resolutionRatioDataList = {}

	if SLFramework.FrameworkSettings.IsEditor then
		arg_5_0:_appendResolutionData(UnityEngine.Screen.width, UnityEngine.Screen.height, false)

		return
	end

	local var_5_0 = UnityEngine.Screen.currentResolution.width

	if arg_5_0._resolutionRatioDataList and #arg_5_0._resolutionRatioDataList >= 1 and arg_5_0._resolutionRatioDataList[1] == var_5_0 then
		return
	end

	local var_5_1 = math.floor(var_5_0 / arg_5_0._curRate)

	arg_5_0:_appendResolutionData(var_5_0, var_5_1, true)

	for iter_5_0, iter_5_1 in ipairs(var_0_0.ResolutionRatioWidthList) do
		if iter_5_1 <= arg_5_0._systemScreenWidth and iter_5_1 <= var_5_0 then
			local var_5_2 = math.floor(iter_5_1 / arg_5_0._curRate)

			arg_5_0:_appendResolutionData(iter_5_1, var_5_2, false)
		end
	end

	local var_5_3, var_5_4 = arg_5_0:getCurrentDropDownIndex()

	if var_5_4 then
		local var_5_5, var_5_6, var_5_7 = arg_5_0:getCurrentResolutionWHAndIsFull()

		arg_5_0:_appendResolutionData(var_5_5, var_5_6, var_5_7)
	end
end

function var_0_0.initWindowsResolution(arg_6_0)
	if SLFramework.FrameworkSettings.IsEditor then
		arg_6_0._screenWidth, arg_6_0._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height

		arg_6_0:_setIsFullScreen(false)

		arg_6_0._resolutionRatio = arg_6_0:_resolutionStr(arg_6_0._screenWidth, arg_6_0._screenHeight)
	else
		arg_6_0._resolutionRatio = PlayerPrefsHelper.getString(PlayerPrefsKey.ResolutionRatio, nil)

		local var_6_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FullScreenKey, ModuleEnum.FullScreenState.On)

		arg_6_0:_setIsFullScreen(var_6_0 == ModuleEnum.FullScreenState.On)

		if arg_6_0:isFullScreen() then
			local var_6_1 = UnityEngine.Screen.currentResolution

			arg_6_0._screenWidth = var_6_1.width
			arg_6_0._screenHeight = var_6_1.height
		else
			local var_6_2 = not string.nilorempty(arg_6_0._resolutionRatio) and arg_6_0._resolutionRatio ~= "nil"
			local var_6_3 = var_6_2 and string.splitToNumber(arg_6_0._resolutionRatio, "*") or {
				1920,
				1080
			}
			local var_6_4 = UnityEngine.Screen.width

			if var_6_2 and var_6_4 <= var_6_3[1] then
				arg_6_0._screenWidth = var_6_3[1]
				arg_6_0._screenHeight = var_6_3[2]
			else
				local var_6_5 = math.floor(var_6_4 / arg_6_0._curRate)

				arg_6_0._screenWidth = var_6_4
				arg_6_0._screenHeight = var_6_5
				arg_6_0._resolutionRatio = arg_6_0:_resolutionStr(var_6_4, var_6_5)
			end
		end
	end

	arg_6_0:setResolutionRatio()
end

function var_0_0.getCurCategoryId(arg_7_0)
	return arg_7_0._curCategoryId
end

function var_0_0.setCurCategoryId(arg_8_0, arg_8_1)
	arg_8_0._curCategoryId = arg_8_1
end

function var_0_0.setSettingsCategoryList(arg_9_0, arg_9_1)
	arg_9_0._categoryList = arg_9_1
end

function var_0_0.getSettingsCategoryList(arg_10_0)
	arg_10_0._categoryList = {}

	for iter_10_0, iter_10_1 in ipairs(SettingsEnum.CategoryList) do
		if arg_10_0:canShowCategory(iter_10_1) then
			table.insert(arg_10_0._categoryList, iter_10_1)
		end
	end

	return arg_10_0._categoryList
end

function var_0_0.canShowCategory(arg_11_0, arg_11_1)
	if arg_11_1.name == "settings_push" and BootNativeUtil.isWindows() then
		return false
	end

	local var_11_0 = #arg_11_1.openIds == 0 and arg_11_1.showIds == nil or false

	for iter_11_0, iter_11_1 in pairs(arg_11_1.openIds) do
		if OpenModel.instance:isFuncBtnShow(iter_11_1) then
			var_11_0 = true

			break
		end
	end

	if not var_11_0 and arg_11_1.showIds then
		for iter_11_2, iter_11_3 in pairs(arg_11_1.showIds) do
			if arg_11_0.showHelper:canShow(iter_11_3) then
				var_11_0 = true

				break
			end
		end
	end

	if arg_11_1.hideOnGamepadModle and GamepadController.instance:isOpen() then
		var_11_0 = false
	end

	return var_11_0
end

function var_0_0.isBilibili()
	local var_12_0 = SDKMgr.instance:getChannelId()

	var_12_0 = var_12_0 and tostring(var_12_0)

	return not string.nilorempty(var_12_0) and var_12_0 == "101"
end

function var_0_0.getScreenshotSwitch(arg_13_0)
	return arg_13_0._screenshotSwitch > 0
end

function var_0_0.setScreenshotSwitch(arg_14_0, arg_14_1)
	arg_14_0._screenshotSwitch = arg_14_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsScreenshotSwitch, arg_14_0._screenshotSwitch)
end

function var_0_0.changeEnergyMode(arg_15_0)
	if arg_15_0._energyMode == 1 then
		arg_15_0._energyMode = 0

		GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_15_0:getModelGraphicsQuality())
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_15_0._frameRate)
	else
		arg_15_0._energyMode = 1

		GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEnergyMode, arg_15_0._energyMode)
end

function var_0_0.getEnergyMode(arg_16_0)
	return arg_16_0._energyMode
end

function var_0_0.getMusicValue(arg_17_0)
	return arg_17_0._musicValue
end

function var_0_0.setMusicValue(arg_18_0, arg_18_1)
	arg_18_0._musicValue = arg_18_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Music_Volume, arg_18_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsMusicValue, arg_18_0._musicValue)
end

function var_0_0.getVoiceValue(arg_19_0)
	return arg_19_0._voiceValue
end

function var_0_0.setVoiceValue(arg_20_0, arg_20_1)
	arg_20_0._voiceValue = arg_20_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Voc_Volume, arg_20_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVoiceValue, arg_20_0._voiceValue)

	if arg_20_0._voiceValue > 0 then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("no"))
	else
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("yes"))
	end
end

function var_0_0.getEffectValue(arg_21_0)
	return arg_21_0._effectValue
end

function var_0_0.setEffectValue(arg_22_0, arg_22_1)
	arg_22_0._effectValue = arg_22_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.SFX_Volume, arg_22_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEffectValue, arg_22_0._effectValue)
end

function var_0_0.getGlobalAudioVolume(arg_23_0)
	return arg_23_0._globalAudioVolume
end

function var_0_0.setGlobalAudioVolume(arg_24_0, arg_24_1)
	arg_24_0._globalAudioVolume = arg_24_1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, arg_24_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, arg_24_0._globalAudioVolume)
end

function var_0_0.getRealGraphicsQuality(arg_25_0)
	return GameGlobalMgr.instance:getScreenState():getLocalQuality()
end

function var_0_0.getModelGraphicsQuality(arg_26_0)
	if not arg_26_0._graphicsQuality then
		arg_26_0._graphicsQuality = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGraphicsQuality, arg_26_0:getRecommendQuality())
	end

	return arg_26_0._graphicsQuality
end

function var_0_0.setGraphicsQuality(arg_27_0, arg_27_1)
	arg_27_0._graphicsQuality = arg_27_1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGraphicsQuality, arg_27_0._graphicsQuality)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_27_1)
end

function var_0_0.getRecommendQuality(arg_28_0)
	return HardwareUtil.getPerformanceGrade()
end

function var_0_0.getRealTargetFrameRate(arg_29_0)
	return GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
end

function var_0_0.getModelTargetFrameRate(arg_30_0)
	if not arg_30_0._frameRate then
		arg_30_0._frameRate = GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
	end

	return arg_30_0._frameRate
end

function var_0_0.setTargetFrameRate(arg_31_0, arg_31_1)
	arg_31_0._frameRate = arg_31_1

	GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_31_1)
end

function var_0_0.getVSyncCount(arg_32_0)
	return GameGlobalMgr.instance:getScreenState():getVSyncCount()
end

function var_0_0.setVSyncCount(arg_33_0, arg_33_1)
	GameGlobalMgr.instance:getScreenState():setVSyncCount(arg_33_1)
end

function var_0_0._setIsFullScreen(arg_34_0, arg_34_1)
	arg_34_0._isFullScreen = arg_34_1 and ModuleEnum.FullScreenState.On or ModuleEnum.FullScreenState.Off
end

function var_0_0._setScreenWidthAndHeight(arg_35_0, arg_35_1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	local var_35_0 = string.splitToNumber(arg_35_1, "*")

	if var_35_0[1] > arg_35_0._systemScreenWidth or var_35_0[2] > arg_35_0._systemScreenHeight then
		GameFacade.showToast(ToastEnum.SetScreenWidthAndHeightFail)

		return false
	end

	arg_35_0._screenWidth = var_35_0[1]
	arg_35_0._screenHeight = var_35_0[2]

	arg_35_0:_setIsFullScreen(false)

	arg_35_0._resolutionRatio = arg_35_1

	arg_35_0:setResolutionRatio()

	return true
end

function var_0_0.getResolutionRatio(arg_36_0)
	return arg_36_0._resolutionRatio
end

function var_0_0.setResolutionRatio(arg_37_0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.ResolutionRatio, arg_37_0._resolutionRatio)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, arg_37_0._isFullScreen)
	ZProj.GameHelper.SetResolutionRatio(arg_37_0._screenWidth, arg_37_0._screenHeight, arg_37_0:isFullScreen())
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, arg_37_0._screenWidth, arg_37_0._screenHeight)
end

function var_0_0.getCurrentScreenResolutionRatio(arg_38_0)
	return arg_38_0._screenWidth / arg_38_0._screenHeight
end

function var_0_0.getCurrentScreenSize(arg_39_0)
	return arg_39_0._screenWidth, arg_39_0._screenHeight
end

function var_0_0.isFullScreen(arg_40_0)
	return arg_40_0._isFullScreen == ModuleEnum.FullScreenState.On
end

function var_0_0.setFullChange(arg_41_0, arg_41_1)
	arg_41_0._isFullScreen = arg_41_1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, arg_41_1)

	if arg_41_0:isFullScreen() then
		ZProj.GameHelper.SetResolutionRatio(arg_41_0._systemScreenWidth, arg_41_0._systemScreenHeight, true)
	else
		ZProj.GameHelper.SetResolutionRatio(arg_41_0._screenWidth, arg_41_0._screenHeight, false)
	end
end

function var_0_0.getRegion(arg_42_0)
	return GameConfig:GetCurRegionType()
end

function var_0_0.getRegionShortcut(arg_43_0)
	return RegionEnum.shortcutTab[GameConfig:GetCurRegionType()] or "en"
end

function var_0_0.isZhRegion(arg_44_0)
	return arg_44_0:getRegion() == RegionEnum.zh
end

function var_0_0.isJpRegion(arg_45_0)
	return arg_45_0:getRegion() == RegionEnum.jp
end

function var_0_0.isEnRegion(arg_46_0)
	return arg_46_0:getRegion() == RegionEnum.en
end

function var_0_0.isTwRegion(arg_47_0)
	return arg_47_0:getRegion() == RegionEnum.tw
end

function var_0_0.isKrRegion(arg_48_0)
	return arg_48_0:getRegion() == RegionEnum.ko
end

function var_0_0.setVideoCompatible(arg_49_0, arg_49_1)
	arg_49_0._isVideoCompatible = arg_49_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoCompatible, arg_49_0._isVideoCompatible)
end

function var_0_0.getVideoCompatible(arg_50_0)
	if arg_50_0._isVideoCompatible == nil then
		arg_50_0._isVideoCompatible = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoCompatible, 0)
	end

	return arg_50_0._isVideoCompatible == 1
end

function var_0_0.setVideoEnabled(arg_51_0, arg_51_1)
	arg_51_0._isVideoEnabled = arg_51_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoEnabled, arg_51_0._isVideoEnabled)
end

function var_0_0.getVideoEnabled(arg_52_0)
	if arg_52_0._isVideoEnabled == nil then
		arg_52_0._isVideoEnabled = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoEnabled, 1)
	end

	return arg_52_0._isVideoEnabled == 1
end

function var_0_0.getScreenSizeMinRate(arg_53_0)
	return arg_53_0._minRate
end

function var_0_0.getScreenSizeMaxRate(arg_54_0)
	return arg_54_0._maxRate
end

function var_0_0.checkInitRecordVideo(arg_55_0)
	if arg_55_0._isRecordVideo ~= nil then
		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) then
		arg_55_0._isRecordVideo = 0

		return
	end

	arg_55_0._isRecordVideo = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsRecordVideo, 0)
end

function var_0_0.setRecordVideo(arg_56_0, arg_56_1)
	arg_56_0:checkInitRecordVideo()

	arg_56_0._isRecordVideo = arg_56_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsRecordVideo, arg_56_0._isRecordVideo)
end

function var_0_0.getRecordVideo(arg_57_0)
	arg_57_0:checkInitRecordVideo()

	return arg_57_0._isRecordVideo == 1
end

function var_0_0.setVideoHDMode(arg_58_0, arg_58_1)
	arg_58_0._isVideoHDMode = arg_58_1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoHDMode, arg_58_0._isVideoHDMode)
end

function var_0_0.getVideoHDMode(arg_59_0)
	if not PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVideoHDMode) and BootNativeUtil.isWindows() then
		arg_59_0:setVideoHDMode(true)
	end

	local var_59_0 = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if var_59_0 == nil or var_59_0:needDownload() then
		arg_59_0:setVideoHDMode(false)
	end

	if arg_59_0._isVideoHDMode == nil then
		arg_59_0._isVideoHDMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoHDMode, 0)
	end

	return arg_59_0._isVideoHDMode == 1
end

function var_0_0.setPushState(arg_60_0, arg_60_1)
	arg_60_0._pushStates = {}

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		arg_60_0._pushStates[iter_60_1.type] = {}
		arg_60_0._pushStates[iter_60_1.type].type = iter_60_1.type
		arg_60_0._pushStates[iter_60_1.type].param = iter_60_1.param
	end
end

function var_0_0.updatePushState(arg_61_0, arg_61_1, arg_61_2)
	if not arg_61_0._pushStates[arg_61_1] then
		arg_61_0._pushStates[arg_61_1] = {}
		arg_61_0._pushStates[arg_61_1].type = arg_61_1
	end

	arg_61_0._pushStates[arg_61_1].param = arg_61_2
end

function var_0_0.isPushTypeOn(arg_62_0, arg_62_1)
	local var_62_0 = SDKMgr.instance:isNotificationEnable()
	local var_62_1 = arg_62_0._pushStates[arg_62_1] and arg_62_0._pushStates[arg_62_1].param == "1"

	return var_62_0 and var_62_1
end

function var_0_0.isTypeOn(arg_63_0, arg_63_1)
	return arg_63_0._pushStates[arg_63_1] and arg_63_0._pushStates[arg_63_1].param == "1"
end

function var_0_0._resolutionStr(arg_64_0, arg_64_1, arg_64_2)
	return string.format("%s * %s", arg_64_1, arg_64_2)
end

function var_0_0.getResolutionRatioStrList(arg_65_0)
	arg_65_0:initResolutionRationDataList()

	local var_65_0 = {}

	for iter_65_0, iter_65_1 in ipairs(arg_65_0._resolutionRatioDataList) do
		local var_65_1 = arg_65_0:_resolutionStr(iter_65_1.width, iter_65_1.height)

		if iter_65_1.isFullscreen then
			var_65_1 = luaLang("settings_fullscreen")
		end

		table.insert(var_65_0, var_65_1)
	end

	return var_65_0
end

function var_0_0._appendResolutionData(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	table.insert(arg_66_0._resolutionRatioDataList, {
		width = arg_66_1,
		height = arg_66_2,
		isFullscreen = arg_66_3
	})
end

function var_0_0.setScreenResolutionByIndex(arg_67_0, arg_67_1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if not arg_67_0._resolutionRatioDataList then
		return false
	end

	local var_67_0 = arg_67_0._resolutionRatioDataList[arg_67_1]

	if not var_67_0 then
		GameFacade.showToastString("error index:" .. arg_67_1)

		return false
	end

	arg_67_0._screenWidth = var_67_0.width
	arg_67_0._screenHeight = var_67_0.height

	arg_67_0:_setIsFullScreen(var_67_0.isFullscreen)

	arg_67_0._resolutionRatio = arg_67_0:_resolutionStr(arg_67_0._screenWidth, arg_67_0._screenHeight)

	arg_67_0:setResolutionRatio()

	return true
end

function var_0_0.getCurrentResolutionWHAndIsFull(arg_68_0)
	if not arg_68_0._resolutionRatio then
		arg_68_0:initWindowsResolution()
	end

	local var_68_0 = string.splitToNumber(arg_68_0._resolutionRatio, "*")

	if not var_68_0 then
		return 0, 0, false
	end

	local var_68_1 = arg_68_0:isFullScreen()

	return var_68_0[1], var_68_0[2], var_68_1
end

function var_0_0.getCurrentDropDownIndex(arg_69_0)
	local var_69_0, var_69_1, var_69_2 = arg_69_0:getCurrentResolutionWHAndIsFull()

	if var_69_2 then
		return 0
	end

	for iter_69_0, iter_69_1 in ipairs(arg_69_0._resolutionRatioDataList or {}) do
		if not iter_69_1.isFullscreen and var_69_0 == iter_69_1.width and var_69_1 == iter_69_1.height then
			return iter_69_0 - 1
		end
	end

	return 0, true
end

function var_0_0.getCurrentFrameRateIndex(arg_70_0)
	local var_70_0 = arg_70_0:getModelTargetFrameRate()

	for iter_70_0, iter_70_1 in ipairs(var_0_0.FrameRate) do
		if var_70_0 == iter_70_1 then
			return iter_70_0
		end
	end

	return 1
end

function var_0_0.setModelTargetFrameRate(arg_71_0, arg_71_1)
	local var_71_0 = var_0_0.FrameRate[arg_71_1 + 1]

	if var_71_0 then
		logNormal("设置帧率: ", var_71_0)
		arg_71_0:setTargetFrameRate(var_71_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
