module("projbooter.ProjBooter", package.seeall)

slot0 = class("ProjBooter")

addGlobalModule("projbooter.utils.VersionUtil", "VersionUtil")
addGlobalModule("projbooter.lang.BootLangEnum", "BootLangEnum")
addGlobalModule("projbooter.lang.BootLangFontMgr", "BootLangFontMgr")
addGlobalModule("projbooter.native.BootNativeUtil", "BootNativeUtil")
addGlobalModule("projbooter.screen.GameAdaptionBgMgr", "GameAdaptionBgMgr")
addGlobalModule("projbooter.config.BooterLoadingConfig", "BooterLoadingConfig")
addGlobalModule("projbooter.BootResMgr", "BootResMgr")
addGlobalModule("projbooter.config.UrlConfig", "UrlConfig")
addGlobalModule("projbooter.config.GameUrlConfig", "GameUrlConfig")
addGlobalModule("projbooter.config.GameChannelConfig", "GameChannelConfig")
addGlobalModule("projbooter.config.BooterLanguageConfig", "BooterLanguageConfig")
addGlobalModule("projbooter.ui.BootMsgBox", "BootMsgBox")
addGlobalModule("projbooter.ui.BootLoadingView", "BootLoadingView")
addGlobalModule("projbooter.ui.BootNoticeView", "BootNoticeView")
addGlobalModule("projbooter.ui.BootVoiceView", "BootVoiceView")
addGlobalModule("projbooter.ui.BootVersionView", "BootVersionView")
addGlobalModule("projbooter.hotupdate.HotUpdateMgr", "HotUpdateMgr")
addGlobalModule("projbooter.hotupdate.VersionValidator", "VersionValidator")
addGlobalModule("projbooter.hotupdate.VoiceHttpGetter", "VoiceHttpGetter")
addGlobalModule("projbooter.hotupdate.VoiceDownloader", "VoiceDownloader")
addGlobalModule("projbooter.hotupdate.HotUpdateVoiceMgr", "HotUpdateVoiceMgr")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageHttpGetter", "OptionPackageHttpGetter")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageDownloader", "OptionPackageDownloader")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageHttpWorker", "OptionPackageHttpWorker")
addGlobalModule("projbooter.hotupdate.optionpackage.HotUpateOptionPackageAdapter", "HotUpateOptionPackageAdapter")
addGlobalModule("projbooter.hotupdate.HotUpdateOptionPackageMgr", "HotUpdateOptionPackageMgr")
addGlobalModule("projbooter.audio.BootAudioMgr", "BootAudioMgr")
addGlobalModule("projbooter.sdk.SDKNativeUtil", "SDKNativeUtil")
addGlobalModule("projbooter.sdk.SDKMgr", "SDKMgr")
addGlobalModule("projbooter.sdk.SDKDataTrackMgr", "SDKDataTrackMgr")
addGlobalModule("projbooter.gamepad.GamepadBooter", "GamepadBooter")

function slot0.start(slot0)
	slot0:setCrashsightUid()
	slot0:intGamepad()
	slot0:setSkipHotUpdate()

	if isDebugBuild then
		SLFramework.DebugView.Instance:SetLogReportUrl(GameUrlConfig.getLogReportUrl())
	end

	slot0:checkSystemLanguage()
	slot0:checkWidowsBackGroundSound()
	GameResMgr:InitAbDependencies(slot0.onAbDependenciesInited, slot0)
end

function slot0.checkWidowsBackGroundSound(slot0)
	if BootNativeUtil.isWindows() then
		if UnityEngine.PlayerPrefs.HasKey("WWise_SL_ActivateDuringFocusLoss") then
			return
		end

		UnityEngine.PlayerPrefs.SetFloat(slot1, 1)
	end
end

function slot0.checkSystemLanguage(slot0)
	if GameChannelConfig.isGpGlobal() == false then
		return
	end

	if UnityEngine.PlayerPrefs.HasKey("ProjBooter:checkSystemLanguage") then
		return
	end

	if BootLangEnum.SystemLanguageShortcut[UnityEngine.Application.systemLanguage] then
		GameConfig:SetCurLangType(slot3)
	end

	UnityEngine.PlayerPrefs.SetFloat(slot1, 1)
end

function slot0.onAbDependenciesInited(slot0)
	logNormal("ProjBooter:onAbDependenciesInited")
	BootResMgr.instance:startLoading(slot0.onBootResLoaded, slot0)
end

function slot0.setCrashsightUid(slot0)
	if not string.nilorempty(UnityEngine.PlayerPrefs.GetString("PlayerUid")) then
		CrashSightAgent.SetUserId(slot1)
	end
end

function slot0.intGamepad(slot0)
	GamepadBooter.instance:init()
end

function slot0.setSkipHotUpdate(slot0)
	SLFramework.GameUpdate.HotUpdateInfoMgr.LoadLocalVersion()

	slot0._skipHotUpdate = not GameConfig.CanHotUpdate
end

function slot0.onBootResLoaded(slot0)
	logNormal("ProjBooter:onBootResLoaded")
	GameAdaptionBgMgr.instance:loadAdaptionBg()
	BootMsgBox.instance:init()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))
	BootLoadingView.instance:init()
	SDKMgr.instance:initSDK(slot0.onSdkInited, slot0)
end

function slot0.onSdkInited(slot0)
	logNormal("ProjBooter:onSdkInited")

	slot1 = tostring(SDKMgr.instance:getDeviceInfo().deviceId)

	UnityEngine.PlayerPrefs.SetString("deviceId", slot1)
	logNormal("deviceId=" .. slot1)

	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		SDKMgr.instance:setScreenLightingOff(true)
	end

	HotUpdateVoiceMgr.instance:init()
	HotUpdateOptionPackageMgr.instance:init()

	if slot0._skipHotUpdate then
		slot0._hotupdateDownloadFinished = true
		slot0._hotupdateFinished = true
		slot0._needCopyAb = BootNativeUtil.isAndroid() and GameResMgr:CopyInnerAbToPersistPath(slot0.onCopyAbRes, slot0)

		slot0:onUpdateFinish()

		return
	end

	slot0:checkVersion()
	BootVersionView.instance:show()
end

function slot0.checkVersion(slot0)
	if not GameResMgr.IsFromEditorDir then
		VersionValidator.instance:start(slot0.onCheckVersion, slot0)
	else
		slot0:onCheckVersion("0.0.0", false, "", 1)
	end
end

function slot0.onCheckVersion(slot0, slot1, slot2, slot3, slot4)
	UpdateBeat:Add(slot0._onFrame, slot0)

	if slot2 and BootNativeUtil.isIOS() then
		slot0:loadLogicLua()

		return
	end

	if HotUpdateVoiceMgr.EnableEditorDebug or string.split(SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr, ".")[1] == string.split(slot1, ".")[1] then
		HotUpdateVoiceMgr.instance:showDownload(slot0.startUpdate, slot0)
	else
		slot0:startUpdate()
	end
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		SDKMgr.instance:exitSdk()

		return
	end
end

function slot0.startUpdate(slot0)
	logNormal("ProjBooter:startUpdate")

	slot0._needCopyAb = BootNativeUtil.isAndroid() and GameResMgr:CopyInnerAbToPersistPath(slot0.onCopyAbRes, slot0)

	HotUpdateMgr.instance:start(slot0.onUpdateFinish, slot0, slot0.onUpdateDownloadFinish, slot0)
end

function slot0.onCopyAbRes(slot0, slot1)
	if slot1 == -1 then
		HotUpdateMgr.instance:stop()
		BootMsgBox.instance:show({
			title = booterLang("copy_ab"),
			content = booterLang("copy_ab_error"),
			leftMsg = booterLang("exit"),
			leftCb = slot0.quitGame,
			leftCbObj = slot0,
			rightMsg = nil
		})
		BootMsgBox.instance:disable()
	else
		logNormal("ProjBooter:onCopyAbRes progress:" .. tostring(slot1))

		if slot0._hotupdateDownloadFinished or slot0._hotupdateFinished then
			if not slot0._copyProgress then
				slot0._copyProgress = 0
			end

			BootLoadingView.instance:show((slot1 - slot0._copyProgress) / (1 - slot0._copyProgress), booterLang("unpacking"))
		else
			slot0._copyProgress = slot1
		end

		if slot1 >= 1 then
			slot0._abCopyFinished = true

			if slot0._hotupdateFinished then
				slot0:hotUpdateVoice()
			end
		end
	end
end

function slot0.onUpdateDownloadFinish(slot0)
	slot0._hotupdateDownloadFinished = true

	logNormal("ProjBooter:onUpdateDownloadFinish()")
end

function slot0.onUpdateFinish(slot0)
	logNormal("ProjBooter:onUpdateFinish")

	slot0._hotupdateFinished = true

	if slot0._needCopyAb and not slot0._abCopyFinished then
		return
	end

	slot0:hotUpdateVoice()
end

function slot0.hotUpdateVoice(slot0)
	if slot0._skipHotUpdate then
		logNormal("ProjBooter:hotUpdateVoice skip")

		if HotUpdateOptionPackageMgr.EnableEditorDebug then
			slot0:showDownloadOptionalPackage()

			return
		end

		slot0:loadLogicLua()
	else
		logNormal("ProjBooter:hotUpdateVoice")
		HotUpdateVoiceMgr.instance:startDownload(slot0.showDownloadOptionalPackage, slot0)
	end
end

function slot0.showDownloadOptionalPackage(slot0)
	logNormal("ProjBooter:showDownloadOptionalPackage")
	HotUpdateOptionPackageMgr.instance:showDownload(slot0.hotUpdateOptionalPackage, slot0, HotUpateOptionPackageAdapter.New())
end

function slot0.hotUpdateOptionalPackage(slot0)
	logNormal("ProjBooter:hotUpdateOptionalPackage")
	HotUpdateOptionPackageMgr.instance:startDownload(slot0.loadLogicLua, slot0)
end

function slot0.loadLogicLua(slot0)
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTmepDir2)
	logNormal("ProjBooter:loadLogicLua")
	BootLoadingView.instance:show(0.1, booterLang("loading_res"))
	BootLoadingView.instance:showFixBtn()

	if not GameResMgr.NeedLoadLuaBytes then
		slot0:OnLogicLuaLoaded()
		logNormal("ProjBooter:loadLogicLua, src mode, skip loading!")
	else
		LuaInterface.LuaFileUtils.Instance:LoadLogic(nil, slot0.OnLogicLuaLoaded, slot0)
		logNormal("ProjBooter:loadLogicLua, bytecode mode, start loading!")
	end
end

function slot0.OnLogicLuaLoaded(slot0)
	UpdateBeat:Remove(slot0._onFrame, slot0)
	BootLoadingView.instance:show(0.2, booterLang("loading_res"))
	logNormal("ProjBooter:OnLogicLuaLoaded, start game logic!")
	addGlobalModule("modules.ProjModuleStart", "ProjModuleStart")
end

function slot0.quitGame(slot0)
	if BootNativeUtil.isAndroid() then
		SDKMgr.instance:destroyGame()
	else
		ZProj.AudioManager.Instance:BootDispose()
		UnityEngine.Application.Quit()
	end
end

slot0.instance = slot0.New()

slot0.instance:start()

return slot0
