module("projbooter.hotupdate.HotUpdateMgr", package.seeall)

slot0 = class("HotUpdateMgr")
slot0.FailAlertCount = 4

function slot0.ctor(slot0)
	slot0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	slot0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance
	slot0._started = false
	slot0._useBackupUrl = false
end

function slot0.getUseBackup(slot0)
	return slot0._useBackupUrl
end

function slot0.inverseUseBackup(slot0)
	slot0._useBackupUrl = not slot0._useBackupUrl
end

function slot0.getFailCount(slot0)
	return slot0._failCount or 0
end

function slot0.resetFailCount(slot0)
	slot0._failCount = 0
	slot0._failAlertCount = 0
end

function slot0.incFailCount(slot0)
	slot0._failCount = slot0._failCount and slot0._failCount + 1 or 1
	slot0._failAlertCount = slot0._failAlertCount and slot0._failAlertCount + 1 or 1
end

function slot0.getFailAlertCount(slot0)
	return slot0._failAlertCount or 0
end

function slot0.resetFailAlertCount(slot0)
	slot0._failAlertCount = 0
end

function slot0.isFailNeedAlert(slot0)
	return uv0.FailAlertCount <= slot0._failAlertCount
end

function slot0.hideConnectTips(slot0)
	BootLoadingView.instance:hide()
end

function slot0.showConnectTips(slot0)
	if BootVoiceView.instance:isShow() then
		BootVoiceView.instance:updateTips()
		BootLoadingView.instance:hide()
	elseif slot0:getFailAlertCount() > 0 then
		BootLoadingView.instance:showMsg(string.format(booterLang("network_reconnect"), tostring(slot0:getFailAlertCount())), "")
	else
		BootLoadingView.instance:showMsg(string.format(booterLang("network_connecting")), "")
	end
end

function slot0.initStatHotUpdatePer(slot0)
	slot0._statHotUpdatePerList = {
		{
			0,
			SDKDataTrackMgr.EventName.hotupdate_0_20
		},
		{
			0.21,
			SDKDataTrackMgr.EventName.hotupdate_21_40
		},
		{
			0.41,
			SDKDataTrackMgr.EventName.hotupdate_41_60
		},
		{
			0.61,
			SDKDataTrackMgr.EventName.hotupdate_61_80
		},
		{
			0.81,
			SDKDataTrackMgr.EventName.hotupdate_81_100
		}
	}
	slot0._statHotUpdatePerNum = 5
	slot0._nowStatHotUpdatePerIndex = 1
end

function slot0.start(slot0, slot1, slot2, slot3, slot4)
	slot0:initStatHotUpdatePer()

	slot0._onFinishCb = slot1
	slot0._onFinishObj = slot2
	slot0._onDownloadSuccCb = slot3
	slot0._onDownloadSuccObj = slot4

	if GameResMgr.IsFromEditorDir then
		-- Nothing
	end

	slot0._started = true

	slot0:resetFailCount()
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetRemoteVersionFail, slot0._onGetRemoteVersionFail, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetRemoteVersionSuccess, slot0._onGetRemoteVersionSuccess, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetUpdateManifestFail, slot0._onGetUpdateResInfoFail, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetUpdateManifestSuccess, slot0._onGetUpdateResInfoSuccess, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.NeedInstallNewPackage, slot0._onNeedInstallNewPackage, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.StartHotUpdateNotify, slot0._onStartHotUpdateNotify, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.HotUpdateDownloadProgress, slot0._onHotUpdateDownloadProgress, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.HotUpdateDownloadFail, slot0._onHotUpdateDownloadFail, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.DownloadDiskFull, slot0._onDownloadDiskFull, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.HotUpdateDownloadSuccess, slot0._onHotUpdateDownloadSuccess, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.StartUnzipNotify, slot0._onStartUnzipNotify, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.DiskSpaceNotEnough, slot0._onDiskSpaceNotEnough, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.UnzipProgress, slot0._onUnzipProgress, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.UnzipFail, slot0._onUnzipFail, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.UnzipSuccess, slot0._onUnzipSuccess, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.HotUpdateComplete, slot0._onHotUpdateComplete, slot0)

	slot5 = slot0:getDomainUrl()
	slot6 = SDKMgr.instance:getGameId()
	slot7 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		slot7 = 2
	end

	slot0:statStartUpdate()
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_check)
	slot0._eventMgrInst:StartUpdate(slot5, slot6, slot7, SDKMgr.instance:getChannelId(), GameChannelConfig.getServerType(), SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr, tonumber(BootNativeUtil.getAppVersion()), BootNativeUtil.getPackageName(), SDKMgr.instance:getSubChannelId())
end

function slot0.stop(slot0)
	slot0._eventMgrInst:StopUpdate()
end

function slot0.getDomainUrl(slot0)
	slot1, slot2 = GameUrlConfig.getHotUpdateUrl()

	return slot0:getUseBackup() and slot2 or slot1
end

function slot0._onFinish(slot0)
	if not slot0._onFinishCb then
		return
	end

	if slot0._started then
		slot0._eventMgrInst:ClearLuaListener()
	end

	slot0._onFinishCb(slot0._onFinishObj)

	slot0._started = false

	if slot0._audioInited then
		BootAudioMgr.instance:dispose()
	end
end

function slot0._initAudio(slot0)
	slot0._audioInited = true

	BootAudioMgr.instance:init(slot0._onAudioInited, slot0)
end

function slot0._onAudioInited(slot0)
	logNormal("启动音效初始化成功！")
end

function slot0._onGetRemoteVersionFail(slot0, slot1, slot2, slot3)
	logWarn("HotUpdateMgr:_onGetRemoteVersionFail, 获取版本失败, error = " .. slot1)
	slot0:inverseUseBackup()
	slot0._eventMgrInst:ChangeGetInfoDomainUrl(slot0:getDomainUrl())
	slot0:incFailCount()

	if slot0:isFailNeedAlert() then
		slot0:resetFailAlertCount()
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = booterLang("error_request_version") .. slot1,
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0._retryGetVersion,
			rightCbObj = slot0
		})
		slot0:hideConnectTips()
	else
		logNormal("HotUpdateMgr 静默重试获取版本！")
		slot0._eventMgrInst:DoRetryAction()
		slot0:showConnectTips()
	end

	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, slot3, slot2, slot1)
end

function slot0._quitGame(slot0)
	logNormal("HotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function slot0._retryGetVersion(slot0)
	logNormal("HotUpdateMgr:_retryGetVersion, 重试获取版本！")
	slot0._eventMgrInst:DoRetryAction()
	slot0:showConnectTips()
end

function slot0._onGetRemoteVersionSuccess(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:hideConnectTips()
	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_versioncheck", slot0:getDomainUrl(), slot0:getFailCount())
	slot0:resetFailCount()
	logNormal("HotUpdateMgr:_onGetRemoteVersionSuccess ！")

	slot0.shouldHotUpdate = SLFramework.GameUpdate.HotUpdateInfoMgr.ShouldHotUpdate

	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, slot5)
end

function slot0._onGetUpdateResInfoFail(slot0, slot1, slot2, slot3)
	logWarn("HotUpdateMgr:_onGetUpdateResInfoFail, 获取更新资源信息失败, error = " .. slot1)
	slot0:inverseUseBackup()
	slot0._eventMgrInst:ChangeGetInfoDomainUrl(slot0:getDomainUrl())
	slot0:incFailCount()

	if slot0:isFailNeedAlert() then
		slot0:resetFailAlertCount()
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = booterLang("error_request_update") .. slot1,
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0._retryGetUpdateManifest,
			rightCbObj = slot0
		})
		slot0:hideConnectTips()
	else
		logNormal("HotUpdateMgr 静默重试获取更新资源信息！")
		slot0._eventMgrInst:DoRetryAction()
		slot0:showConnectTips()
	end

	SDKDataTrackMgr.instance:trackHotUpdateResourceEvent(SDKDataTrackMgr.RequestResult.fail, slot3, slot2, slot1)
end

function slot0._retryGetUpdateManifest(slot0)
	logNormal("HotUpdateMgr:_retryGetUpdateManifest, 重试获取更新信息失败！")
	slot0._eventMgrInst:DoRetryAction()
	slot0:showConnectTips()
end

function slot0._onGetUpdateResInfoSuccess(slot0, slot1, slot2)
	slot0:hideConnectTips()
	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_srcrequest", slot0:getDomainUrl(), slot0:getFailCount())
	slot0:resetFailCount()
	logNormal("HotUpdateMgr:_onGetUpdateResInfoSuccess targetVersion = ", slot1)
	SDKDataTrackMgr.instance:trackHotUpdateResourceEvent(SDKDataTrackMgr.RequestResult.success, slot2)
end

function slot0._onNeedInstallNewPackage(slot0, slot1)
	logNormal("HotUpdateMgr:_onNeedInstallNewPackage, 需要整包更新！appUrl = " .. slot1)

	slot0._appUrl = slot1

	BootMsgBox.instance:show({
		title = booterLang("hotupdate"),
		content = booterLang("need_update_package"),
		leftMsg = booterLang("exit"),
		leftCb = slot0._quitGame,
		leftCbObj = slot0,
		rightMsg = booterLang("download"),
		rightCb = slot0._gotoDownloadPackage,
		rightCbObj = slot0
	})
end

function slot0._taptapUpdateGame()
	if BootNativeUtil.isAndroid() and tostring(SDKMgr.instance:getSubChannelId()) == "1001" then
		SDKNativeUtil.updateGame()

		return true
	end
end

function slot0._gotoDownloadPackage(slot0)
	logNormal("HotUpdateMgr:_gotoDownloadPackage, 打开下载Url = " .. slot0._appUrl)

	if uv0._taptapUpdateGame() then
		Timer.New(function ()
			uv0:_onNeedInstallNewPackage(uv0._appUrl)
		end, 0.1):Start()

		return
	end

	if BootNativeUtil.isWindows() and GameChannelConfig.isBilibili() then
		SDKMgr.instance:openLauncher()

		return
	end

	if string.nilorempty(slot0._appUrl) == false then
		if not BootNativeUtil.isIOS() then
			UnityEngine.Application.OpenURL(slot0._appUrl)
		else
			ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", cjson.encode({
				deepLink = "",
				url = slot0._appUrl
			}))
		end
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		Timer.New(function ()
			uv0:_onNeedInstallNewPackage(uv0._appUrl)
		end, 0.1):Start()
	else
		ProjBooter.instance:quitGame()
	end
end

function slot0._onStartHotUpdateNotify(slot0, slot1, slot2)
	slot0._hasHotUpdate = true
	slot1 = tonumber(tostring(slot1))
	slot2 = tonumber(tostring(slot2))

	logNormal("HotUpdateMgr:_onStartHotUpdateNotify, 热更新 curSize = " .. slot1 .. " allSize = " .. slot2)
	slot0:_showConfirmUpdateSize(slot2, slot1, slot0._startDownload)
	slot0:_initAudio()
end

function slot0._startDownload(slot0)
	logNormal("HotUpdateMgr:_startDownload, 开始下载！")
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_download)
	SLFramework.GameUpdate.HotUpdate.Instance:SetUseReserveDomain(slot0:getUseBackup())
	slot0._eventMgrInst:DoRetryAction()
end

function slot0._onHotUpdateDownloadProgress(slot0, slot1, slot2)
	slot1 = tonumber(tostring(slot1))
	slot2 = tonumber(tostring(slot2))
	slot3 = not slot0._prevSize or slot1 ~= slot0._prevSize
	slot0._prevSize = slot1

	if slot0:getFailCount() > 0 and slot3 then
		SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_srcdownload", slot0:getDomainUrl(), slot0:getFailCount())
		slot0:resetFailCount()
	end

	logNormal("HotUpdateMgr:_onHotUpdateDownloadProgress, 下载进度 curSize = " .. slot1 .. " allSize = " .. slot2)

	slot4 = slot1 / slot2
	slot5 = slot0:_fixSizeMB(slot2)
	slot1 = slot0:_fixSizeStr(slot1)
	slot2 = slot0:_fixSizeStr(slot2)
	slot6 = nil

	if slot3 then
		BootLoadingView.instance:show(slot4, (UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("download_info_wifi"), slot1, slot2)) and string.format(booterLang("download_info"), slot1, slot2))
	end

	slot0:statHotUpdate(slot4, slot5)
end

function slot0._setUseReserveDomain(slot0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")
	tolua.getfield(typeof(SLFramework.GameUpdate.HotUpdate), "_useReserveDomain", 36):Set(SLFramework.GameUpdate.HotUpdate.Instance, slot0:getUseBackup())
end

function slot0._onHotUpdateDownloadFail(slot0, slot1, slot2)
	if slot1 == SLFramework.GameUpdate.FailError.MD5CheckError then
		slot0:_checkSendFullPonitStat()
	end

	slot0:inverseUseBackup()
	slot0:_setUseReserveDomain()
	slot0:incFailCount()

	if slot0:isFailNeedAlert() then
		slot0:resetFailAlertCount()
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = slot0:_getDownloadFailedTip(slot1, slot2),
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0._retryDownload,
			rightCbObj = slot0
		})
	else
		logNormal("HotUpdateMgr 静默重试下载！")
		slot0._eventMgrInst:DoRetryAction()
		slot0:showConnectTips()
	end
end

function slot0._onDownloadDiskFull(slot0)
	BootMsgBox.instance:show({
		title = booterLang("hotupdate"),
		content = booterLang("download_fail_no_enough_disk"),
		leftMsg = booterLang("exit"),
		leftCb = slot0._quitGame,
		leftCbObj = slot0,
		rightMsg = booterLang("retry"),
		rightCb = slot0._retryDownload,
		rightCbObj = slot0
	})
end

function slot0._retryDownload(slot0)
	logNormal("HotUpdateMgr:_retryDownload, 重试下载！")
	slot0._eventMgrInst:DoRetryAction()
	slot0:showConnectTips()
end

function slot0._getDownloadFailedTip(slot0, slot1, slot2)
	if slot1 == SLFramework.GameUpdate.FailError.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif slot1 == slot3.NotFound then
		return booterLang("download_fail_not_found")
	elseif slot1 == slot3.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif slot1 == slot3.TimeOut then
		return booterLang("download_fail_time_out")
	elseif slot1 == slot3.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif slot1 == slot3.MD5CheckError then
		SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.fail, slot2)

		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(slot2)
	end
end

function slot0._onHotUpdateDownloadSuccess(slot0)
	logNormal("下载热更新资源包完成，开始解压所有资源包！")
	SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.success)
	SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.game_source_completed)
	slot0:_checkSendFullPonitStat()
	SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.success)

	if slot0._onDownloadSuccCb then
		slot0._onDownloadSuccCb(slot0._onDownloadSuccObj)
	end
end

function slot0._onStartUnzipNotify(slot0)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.unzip_start)
	BootLoadingView.instance:show(0.05, booterLang("unpacking"))
end

function slot0._onDiskSpaceNotEnough(slot0)
	logNormal("解压所有资源包遇到错误，设备磁盘空间不足！")
	BootMsgBox.instance:show({
		title = booterLang("hotupdate"),
		content = booterLang("unpack_error"),
		leftMsg = booterLang("exit"),
		leftCb = slot0._quitGame,
		leftCbObj = slot0,
		rightMsg = nil
	})
end

function slot0._onUnzipProgress(slot0, slot1)
	logNormal("正在解压资源包，请稍后... progress = " .. slot1)

	if tostring(slot1) == "nan" then
		return
	end

	BootLoadingView.instance:show(slot1, booterLang("unpacking"))
end

function slot0._onUnzipFail(slot0, slot1)
	logNormal("解压所有资源包遇到错误，解压失败！")

	slot2 = {
		title = booterLang("hotupdate"),
		content = slot0:_getUnzipFailedTip(slot1),
		leftMsg = booterLang("exit"),
		leftCb = slot0._quitGame,
		leftCbObj = slot0,
		rightMsg = booterLang("retry"),
		rightCb = slot0._retryUnzipFile,
		rightCbObj = slot0
	}

	BootMsgBox.instance:show(slot2)
	SDKDataTrackMgr.instance:trackUnzipFinishEvent(SDKDataTrackMgr.Result.fail, slot2.content)
end

function slot0._retryUnzipFile(slot0)
	logNormal("HotUpdateMgr:_retryUnzipFile, 重试解压资源包！")
	slot0._eventMgrInst:DoRetryAction()
end

function slot0._getUnzipFailedTip(slot0, slot1)
	if slot1 == SLFramework.GameUpdate.UnzipStatus.Running then
		return booterLang("unpack_error_running")
	elseif slot1 == slot2.Done then
		return booterLang("unpack_error_done")
	elseif slot1 == slot2.FileNotFound then
		return booterLang("unpack_error_file_not_found")
	elseif slot1 == slot2.NotEnoughSpace then
		return booterLang("unpack_error_not_enough_space")
	elseif slot1 == slot2.ThreadAbort then
		return booterLang("unpack_error_thread_abort")
	elseif slot1 == slot2.Exception then
		return booterLang("unpack_error_exception")
	else
		return booterLang("unpack_error_unknown")
	end
end

function slot0._onUnzipSuccess(slot0)
	SDKDataTrackMgr.instance:trackUnzipFinishEvent(SDKDataTrackMgr.Result.success)
	BootLoadingView.instance:show(1, booterLang("unpack_done"))
end

function slot0.hasHotUpdate(slot0)
	return slot0._hasHotUpdate
end

function slot0._onHotUpdateComplete(slot0)
	if slot0._hasHotUpdate then
		slot0:_onFinish()
	else
		slot0:_showConfirmUpdateSize(0, 0, slot0._onFinish)
	end
end

function slot0._showConfirmUpdateSize(slot0, slot1, slot2, slot3)
	if not BootVoiceView.instance:isFirstDownloadDone() and not VersionValidator.instance:isInReviewing() then
		if HotUpdateVoiceMgr.instance:getNeedDownloadSize() + slot1 - slot2 > 0 or #BootVoiceView.instance:getDownloadChoices() > 0 and HotUpdateVoiceMgr.instance:getTotalSize() == 0 then
			BootVoiceView.instance:showDownloadSize(slot6, slot3, slot0)
		else
			BootVoiceView.instance:hide()
			slot3(slot0)
		end
	elseif slot7 > 0 then
		if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			BootVoiceView.instance:hide()
			slot3(slot0)
		else
			BootMsgBox.instance:show({
				title = booterLang("hotupdate"),
				content = string.format(slot2 == 0 and booterLang("hotupdate_info") or booterLang("hotupdate_continue_info"), slot0:_fixSizeStr(slot7)),
				leftMsg = booterLang("exit"),
				leftCb = slot0._quitGame,
				leftCbObj = slot0,
				rightMsg = slot2 == 0 and booterLang("download") or booterLang("continue_download"),
				rightCb = slot3,
				rightCbObj = slot0
			})
		end
	else
		BootVoiceView.instance:hide()
		slot3(slot0)
	end
end

function slot0.statStartUpdate(slot0)
	slot0._statNextPoint = 0
	slot0._statAllSize = 0
end

function slot0.statHotUpdate(slot0, slot1, slot2)
	for slot6 = slot0._nowStatHotUpdatePerIndex, slot0._statHotUpdatePerNum do
		if slot0._statHotUpdatePerList[slot6][1] <= slot1 then
			SDKDataTrackMgr.instance:track(slot7[2])

			slot0._nowStatHotUpdatePerIndex = slot6 + 1
		else
			break
		end
	end

	if not slot0._statNextPoint then
		return
	end

	slot0._statAllSize = slot2

	if slot0._statNextPoint <= slot1 then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.HotUpdate, {
			[SDKDataTrackMgr.EventProperties.UpdateAmount] = slot2,
			[SDKDataTrackMgr.EventProperties.UpdatePercentage] = tostring(slot0._statNextPoint)
		})

		slot0._statNextPoint = slot0._statNextPoint + 0.5
	end
end

function slot0._checkSendFullPonitStat(slot0)
	if slot0._statNextPoint and slot0._statNextPoint < 1.5 and slot0._statAllSize and slot0._statAllSize ~= 0 then
		slot0._statNextPoint = 1

		slot0:statHotUpdate(1, slot0._statAllSize)
	end
end

function slot0._fixSizeStr(slot0, slot1)
	return uv0.fixSizeStr(slot1)
end

function slot0._fixSizeMB(slot0, slot1)
	return uv0.fixSizeMB(slot1)
end

slot0.MB_SIZE = 1048576
slot0.KB_SIZE = 1024

function slot0.fixSizeStr(slot0)
	slot2 = "MB"

	if slot0 / uv0.MB_SIZE < 1 then
		slot2 = "KB"

		if slot0 / uv0.KB_SIZE < 0.01 then
			slot1 = 0.01
		end
	end

	return string.format("%.2f %s", slot1 - slot1 % 0.01, slot2)
end

function slot0.fixSizeMB(slot0)
	if slot0 / uv0.MB_SIZE < 0.001 then
		return 0.001
	end

	return slot1 - slot1 % 0.001
end

slot0.instance = slot0.New()

return slot0
