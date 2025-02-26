module("modules.logic.settings.model.SettingsModel", package.seeall)

slot0 = class("SettingsModel", BaseModel)
slot0.ResolutionRatioWidthList = {
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

function slot0.onInit(slot0)
	slot0._curCategoryId = 1
	slot0._categoryList = {}
	slot0.showHelper = slot0.showHelper or SettingsShowHelper.New()
	slot1 = 80

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.FirstBootForBetaTest, 0) == 1 or not BootNativeUtil.isStandalonePlayer() or SLFramework.FrameworkSettings.IsEditor then
		slot0._musicValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsMusicValue, slot1)
		slot0._voiceValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVoiceValue, slot1)
		slot0._effectValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEffectValue, slot1)
		slot0._globalAudioVolume = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, 100)
	else
		slot0._musicValue = slot1
		slot0._voiceValue = slot1
		slot0._effectValue = slot1
		slot0._globalAudioVolume = slot2
		slot0._pushStates = {}

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.FirstBootForBetaTest, 1)
	end

	slot0._musicValue = math.ceil(slot0._musicValue)
	slot0._voiceValue = math.ceil(slot0._voiceValue)
	slot0._effectValue = math.ceil(slot0._effectValue)
	slot0._energyMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEnergyMode, 0)
	slot0._screenshotSwitch = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsScreenshotSwitch, BootNativeUtil.isAndroid() and 0 or 1)

	if BootNativeUtil.isAndroid() and SDKMgr.instance:checkReadExternalStoragePermissions() then
		slot0._screenshotSwitch = 0
	end

	slot0._minRate = 1.3333333333333333
	slot0._maxRate = 2.4

	if SLFramework.FrameworkSettings.IsEditor then
		slot0._screenHeight = UnityEngine.Screen.height
		slot0._screenWidth = UnityEngine.Screen.width
	elseif BootNativeUtil.isWindows() then
		slot0:initRateAndSystemSize()
		slot0:initWindowsResolution()
		slot0:initResolutionRationDataList()
	else
		slot0._screenHeight = UnityEngine.Screen.height
		slot0._screenWidth = UnityEngine.Screen.width
	end

	slot0.limitedRoleMO = SettingsLimitedRoleMO.New()
end

function slot0.reInit(slot0)
	slot0.limitedRoleMO:reInit()
end

function slot0.initRateAndSystemSize(slot0)
	slot0._systemScreenWidth, slot0._systemScreenHeight = BootNativeUtil.getDisplayResolution()
	slot0._curRate = slot0._systemScreenWidth / slot0._systemScreenHeight

	if slot0._curRate < slot0._minRate then
		slot0._systemScreenHeight = slot0._systemScreenWidth / slot0._minRate
		slot0._curRate = slot0._minRate
	end

	if slot0._maxRate < slot0._curRate then
		slot0._systemScreenWidth = slot0._systemScreenHeight * slot0._maxRate
		slot0._curRate = slot0._maxRate
	end
end

function slot0.initResolutionRationDataList(slot0)
	slot0._resolutionRatioDataList = {}

	if SLFramework.FrameworkSettings.IsEditor then
		slot0:_appendResolutionData(UnityEngine.Screen.width, UnityEngine.Screen.height, false)

		return
	end

	slot2 = UnityEngine.Screen.currentResolution.width

	if slot0._resolutionRatioDataList and #slot0._resolutionRatioDataList >= 1 and slot0._resolutionRatioDataList[1] == slot2 then
		return
	end

	slot7 = math.floor(slot2 / slot0._curRate)
	slot8 = true

	slot0:_appendResolutionData(slot2, slot7, slot8)

	for slot7, slot8 in ipairs(uv0.ResolutionRatioWidthList) do
		if slot8 <= slot0._systemScreenWidth and slot8 <= slot2 then
			slot0:_appendResolutionData(slot8, math.floor(slot8 / slot0._curRate), false)
		end
	end

	slot4, slot5 = slot0:getCurrentDropDownIndex()

	if slot5 then
		slot6, slot7, slot8 = slot0:getCurrentResolutionWHAndIsFull()

		slot0:_appendResolutionData(slot6, slot7, slot8)
	end
end

function slot0.initWindowsResolution(slot0)
	if SLFramework.FrameworkSettings.IsEditor then
		slot0._screenHeight = UnityEngine.Screen.height
		slot0._screenWidth = UnityEngine.Screen.width

		slot0:_setIsFullScreen(false)

		slot0._resolutionRatio = slot0:_resolutionStr(slot0._screenWidth, slot0._screenHeight)
	else
		slot0._resolutionRatio = PlayerPrefsHelper.getString(PlayerPrefsKey.ResolutionRatio, nil)

		slot0:_setIsFullScreen(PlayerPrefsHelper.getNumber(PlayerPrefsKey.FullScreenKey, ModuleEnum.FullScreenState.On) == ModuleEnum.FullScreenState.On)

		if slot0:isFullScreen() then
			slot2 = UnityEngine.Screen.currentResolution
			slot0._screenWidth = slot2.width
			slot0._screenHeight = slot2.height
		else
			slot2 = not string.nilorempty(slot0._resolutionRatio) and slot0._resolutionRatio ~= "nil"
			slot3 = slot2 and string.splitToNumber(slot0._resolutionRatio, "*") or {
				1920,
				1080
			}

			if slot2 and UnityEngine.Screen.width <= slot3[1] then
				slot0._screenWidth = slot3[1]
				slot0._screenHeight = slot3[2]
			else
				slot5 = math.floor(slot4 / slot0._curRate)
				slot0._screenWidth = slot4
				slot0._screenHeight = slot5
				slot0._resolutionRatio = slot0:_resolutionStr(slot4, slot5)
			end
		end
	end

	slot0:setResolutionRatio()
end

function slot0.getCurCategoryId(slot0)
	return slot0._curCategoryId
end

function slot0.setCurCategoryId(slot0, slot1)
	slot0._curCategoryId = slot1
end

function slot0.setSettingsCategoryList(slot0, slot1)
	slot0._categoryList = slot1
end

function slot0.getSettingsCategoryList(slot0)
	slot0._categoryList = {}

	for slot4, slot5 in ipairs(SettingsEnum.CategoryList) do
		if slot0:canShowCategory(slot5) then
			table.insert(slot0._categoryList, slot5)
		end
	end

	return slot0._categoryList
end

function slot0.canShowCategory(slot0, slot1)
	if slot1.name == "settings_push" and BootNativeUtil.isWindows() then
		return false
	end

	if slot1.name == "key_binding" then
		return false
	end

	slot2 = #slot1.openIds == 0 and slot1.showIds == nil or false

	for slot6, slot7 in pairs(slot1.openIds) do
		if OpenModel.instance:isFuncBtnShow(slot7) then
			slot2 = true

			break
		end
	end

	if not slot2 and slot1.showIds then
		for slot6, slot7 in pairs(slot1.showIds) do
			if slot0.showHelper:canShow(slot7) then
				slot2 = true

				break
			end
		end
	end

	if slot1.hideOnGamepadModle and GamepadController.instance:isOpen() then
		slot2 = false
	end

	return slot2
end

function slot0.isBilibili()
	slot0 = SDKMgr.instance:getChannelId() and tostring(slot0)

	return not string.nilorempty(slot0) and slot0 == "101"
end

function slot0.getScreenshotSwitch(slot0)
	return slot0._screenshotSwitch > 0
end

function slot0.setScreenshotSwitch(slot0, slot1)
	slot0._screenshotSwitch = slot1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsScreenshotSwitch, slot0._screenshotSwitch)
end

function slot0.changeEnergyMode(slot0)
	if slot0._energyMode == 1 then
		slot0._energyMode = 0

		GameGlobalMgr.instance:getScreenState():setLocalQuality(slot0:getModelGraphicsQuality())
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(slot0._frameRate)
	else
		slot0._energyMode = 1

		GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEnergyMode, slot0._energyMode)
end

function slot0.getEnergyMode(slot0)
	return slot0._energyMode
end

function slot0.getMusicValue(slot0)
	return slot0._musicValue
end

function slot0.setMusicValue(slot0, slot1)
	slot0._musicValue = slot1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Music_Volume, slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsMusicValue, slot0._musicValue)
end

function slot0.getVoiceValue(slot0)
	return slot0._voiceValue
end

function slot0.setVoiceValue(slot0, slot1)
	slot0._voiceValue = slot1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Voc_Volume, slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVoiceValue, slot0._voiceValue)

	if slot0._voiceValue > 0 then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("no"))
	else
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("yes"))
	end
end

function slot0.getEffectValue(slot0)
	return slot0._effectValue
end

function slot0.setEffectValue(slot0, slot1)
	slot0._effectValue = slot1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.SFX_Volume, slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEffectValue, slot0._effectValue)
end

function slot0.getGlobalAudioVolume(slot0)
	return slot0._globalAudioVolume
end

function slot0.setGlobalAudioVolume(slot0, slot1)
	slot0._globalAudioVolume = slot1

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, slot0._globalAudioVolume)
end

function slot0.getRealGraphicsQuality(slot0)
	return GameGlobalMgr.instance:getScreenState():getLocalQuality()
end

function slot0.getModelGraphicsQuality(slot0)
	if not slot0._graphicsQuality then
		slot0._graphicsQuality = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGraphicsQuality, slot0:getRecommendQuality())
	end

	return slot0._graphicsQuality
end

function slot0.setGraphicsQuality(slot0, slot1)
	slot0._graphicsQuality = slot1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGraphicsQuality, slot0._graphicsQuality)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(slot1)
end

function slot0.getRecommendQuality(slot0)
	return HardwareUtil.getPerformanceGrade()
end

function slot0.getRealTargetFrameRate(slot0)
	return GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
end

function slot0.getModelTargetFrameRate(slot0)
	if not slot0._frameRate then
		slot0._frameRate = GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
	end

	return slot0._frameRate
end

function slot0.setTargetFrameRate(slot0, slot1)
	slot0._frameRate = slot1

	GameGlobalMgr.instance:getScreenState():setTargetFrameRate(slot1)
end

function slot0._setIsFullScreen(slot0, slot1)
	slot0._isFullScreen = slot1 and ModuleEnum.FullScreenState.On or ModuleEnum.FullScreenState.Off
end

function slot0._setScreenWidthAndHeight(slot0, slot1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if slot0._systemScreenWidth < string.splitToNumber(slot1, "*")[1] or slot0._systemScreenHeight < slot2[2] then
		GameFacade.showToast(ToastEnum.SetScreenWidthAndHeightFail)

		return false
	end

	slot0._screenWidth = slot2[1]
	slot0._screenHeight = slot2[2]

	slot0:_setIsFullScreen(false)

	slot0._resolutionRatio = slot1

	slot0:setResolutionRatio()

	return true
end

function slot0.getResolutionRatio(slot0)
	return slot0._resolutionRatio
end

function slot0.setResolutionRatio(slot0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.ResolutionRatio, slot0._resolutionRatio)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, slot0._isFullScreen)
	ZProj.GameHelper.SetResolutionRatio(slot0._screenWidth, slot0._screenHeight, slot0:isFullScreen())
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, slot0._screenWidth, slot0._screenHeight)
end

function slot0.getCurrentScreenResolutionRatio(slot0)
	return slot0._screenWidth / slot0._screenHeight
end

function slot0.getCurrentScreenSize(slot0)
	return slot0._screenWidth, slot0._screenHeight
end

function slot0.isFullScreen(slot0)
	return slot0._isFullScreen == ModuleEnum.FullScreenState.On
end

function slot0.setFullChange(slot0, slot1)
	slot0._isFullScreen = slot1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, slot1)

	if slot0:isFullScreen() then
		ZProj.GameHelper.SetResolutionRatio(slot0._systemScreenWidth, slot0._systemScreenHeight, true)
	else
		ZProj.GameHelper.SetResolutionRatio(slot0._screenWidth, slot0._screenHeight, false)
	end
end

function slot0.getRegion(slot0)
	return GameConfig:GetCurRegionType()
end

function slot0.getRegionShortcut(slot0)
	return RegionEnum.shortcutTab[GameConfig:GetCurRegionType()] or "en"
end

function slot0.isZhRegion(slot0)
	return slot0:getRegion() == RegionEnum.zh
end

function slot0.isJpRegion(slot0)
	return slot0:getRegion() == RegionEnum.jp
end

function slot0.isEnRegion(slot0)
	return slot0:getRegion() == RegionEnum.en
end

function slot0.isTwRegion(slot0)
	return slot0:getRegion() == RegionEnum.tw
end

function slot0.isKrRegion(slot0)
	return slot0:getRegion() == RegionEnum.ko
end

function slot0.setVideoCompatible(slot0, slot1)
	slot0._isVideoCompatible = slot1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoCompatible, slot0._isVideoCompatible)
end

function slot0.getVideoCompatible(slot0)
	if slot0._isVideoCompatible == nil then
		slot0._isVideoCompatible = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoCompatible, 0)
	end

	return slot0._isVideoCompatible == 1
end

function slot0.setVideoEnabled(slot0, slot1)
	slot0._isVideoEnabled = slot1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoEnabled, slot0._isVideoEnabled)
end

function slot0.getVideoEnabled(slot0)
	if slot0._isVideoEnabled == nil then
		slot0._isVideoEnabled = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoEnabled, 1)
	end

	return slot0._isVideoEnabled == 1
end

function slot0.getScreenSizeMinRate(slot0)
	return slot0._minRate
end

function slot0.getScreenSizeMaxRate(slot0)
	return slot0._maxRate
end

function slot0.checkInitRecordVideo(slot0)
	if slot0._isRecordVideo ~= nil then
		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) then
		slot0._isRecordVideo = 0

		return
	end

	slot0._isRecordVideo = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsRecordVideo, 0)
end

function slot0.setRecordVideo(slot0, slot1)
	slot0:checkInitRecordVideo()

	slot0._isRecordVideo = slot1 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsRecordVideo, slot0._isRecordVideo)
end

function slot0.getRecordVideo(slot0)
	slot0:checkInitRecordVideo()

	return slot0._isRecordVideo == 1
end

function slot0._resolutionStr(slot0, slot1, slot2)
	return string.format("%s * %s", slot1, slot2)
end

function slot0.getResolutionRatioStrList(slot0)
	slot0:initResolutionRationDataList()

	slot1 = {}

	for slot5, slot6 in ipairs(slot0._resolutionRatioDataList) do
		slot7 = slot0:_resolutionStr(slot6.width, slot6.height)

		if slot6.isFullscreen then
			slot7 = luaLang("settings_fullscreen")
		end

		table.insert(slot1, slot7)
	end

	return slot1
end

function slot0._appendResolutionData(slot0, slot1, slot2, slot3)
	table.insert(slot0._resolutionRatioDataList, {
		width = slot1,
		height = slot2,
		isFullscreen = slot3
	})
end

function slot0.setScreenResolutionByIndex(slot0, slot1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if not slot0._resolutionRatioDataList then
		return false
	end

	if not slot0._resolutionRatioDataList[slot1] then
		GameFacade.showToastString("error index:" .. slot1)

		return false
	end

	slot0._screenWidth = slot2.width
	slot0._screenHeight = slot2.height

	slot0:_setIsFullScreen(slot2.isFullscreen)

	slot0._resolutionRatio = slot0:_resolutionStr(slot0._screenWidth, slot0._screenHeight)

	slot0:setResolutionRatio()

	return true
end

function slot0.getCurrentResolutionWHAndIsFull(slot0)
	if not slot0._resolutionRatio then
		slot0:initWindowsResolution()
	end

	if not string.splitToNumber(slot0._resolutionRatio, "*") then
		return 0, 0, false
	end

	return slot1[1], slot1[2], slot0:isFullScreen()
end

function slot0.getCurrentDropDownIndex(slot0)
	slot1, slot2, slot3 = slot0:getCurrentResolutionWHAndIsFull()

	if slot3 then
		return 0
	end

	for slot7, slot8 in ipairs(slot0._resolutionRatioDataList or {}) do
		if not slot8.isFullscreen and slot1 == slot8.width and slot2 == slot8.height then
			return slot7 - 1
		end
	end

	return 0, true
end

function slot0.setPushState(slot0, slot1)
	slot0._pushStates = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._pushStates[slot6.type] = {
			type = slot6.type,
			param = slot6.param
		}
	end
end

function slot0.updatePushState(slot0, slot1, slot2)
	if not slot0._pushStates[slot1] then
		slot0._pushStates[slot1] = {
			type = slot1
		}
	end

	slot0._pushStates[slot1].param = slot2
end

function slot0.isPushTypeOn(slot0, slot1)
	return SDKMgr.instance:isNotificationEnable() and (slot0._pushStates[slot1] and slot0._pushStates[slot1].param == "1")
end

function slot0.isTypeOn(slot0, slot1)
	return slot0._pushStates[slot1] and slot0._pushStates[slot1].param == "1"
end

function slot0._resolutionStr(slot0, slot1, slot2)
	return string.format("%s * %s", slot1, slot2)
end

function slot0.getResolutionRatioStrList(slot0)
	slot0:initResolutionRationDataList()

	slot1 = {}

	for slot5, slot6 in ipairs(slot0._resolutionRatioDataList) do
		slot7 = slot0:_resolutionStr(slot6.width, slot6.height)

		if slot6.isFullscreen then
			slot7 = luaLang("settings_fullscreen")
		end

		table.insert(slot1, slot7)
	end

	return slot1
end

function slot0._appendResolutionData(slot0, slot1, slot2, slot3)
	table.insert(slot0._resolutionRatioDataList, {
		width = slot1,
		height = slot2,
		isFullscreen = slot3
	})
end

function slot0.setScreenResolutionByIndex(slot0, slot1)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if not slot0._resolutionRatioDataList then
		return false
	end

	if not slot0._resolutionRatioDataList[slot1] then
		GameFacade.showToastString("error index:" .. slot1)

		return false
	end

	slot0._screenWidth = slot2.width
	slot0._screenHeight = slot2.height

	slot0:_setIsFullScreen(slot2.isFullscreen)

	slot0._resolutionRatio = slot0:_resolutionStr(slot0._screenWidth, slot0._screenHeight)

	slot0:setResolutionRatio()

	return true
end

function slot0.getCurrentResolutionWHAndIsFull(slot0)
	if not slot0._resolutionRatio then
		slot0:initWindowsResolution()
	end

	if not string.splitToNumber(slot0._resolutionRatio, "*") then
		return 0, 0, false
	end

	return slot1[1], slot1[2], slot0:isFullScreen()
end

function slot0.getCurrentDropDownIndex(slot0)
	slot1, slot2, slot3 = slot0:getCurrentResolutionWHAndIsFull()

	if slot3 then
		return 0
	end

	for slot7, slot8 in ipairs(slot0._resolutionRatioDataList or {}) do
		if not slot8.isFullscreen and slot1 == slot8.width and slot2 == slot8.height then
			return slot7 - 1
		end
	end

	return 0, true
end

slot0.instance = slot0.New()

return slot0
