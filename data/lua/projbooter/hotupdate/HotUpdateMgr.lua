module("projbooter.hotupdate.HotUpdateMgr", package.seeall)

local var_0_0 = class("HotUpdateMgr")

var_0_0.FailAlertCount = 4

function var_0_0.ctor(arg_1_0)
	arg_1_0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	arg_1_0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance
	arg_1_0._started = false
	arg_1_0._useBackupUrl = false
end

function var_0_0.getUseBackup(arg_2_0)
	return arg_2_0._useBackupUrl
end

function var_0_0.inverseUseBackup(arg_3_0)
	arg_3_0._useBackupUrl = not arg_3_0._useBackupUrl
end

function var_0_0.getFailCount(arg_4_0)
	return arg_4_0._failCount or 0
end

function var_0_0.resetFailCount(arg_5_0)
	arg_5_0._failCount = 0
	arg_5_0._failAlertCount = 0
end

function var_0_0.incFailCount(arg_6_0)
	arg_6_0._failCount = arg_6_0._failCount and arg_6_0._failCount + 1 or 1
	arg_6_0._failAlertCount = arg_6_0._failAlertCount and arg_6_0._failAlertCount + 1 or 1
end

function var_0_0.getFailAlertCount(arg_7_0)
	return arg_7_0._failAlertCount or 0
end

function var_0_0.resetFailAlertCount(arg_8_0)
	arg_8_0._failAlertCount = 0
end

function var_0_0.isFailNeedAlert(arg_9_0)
	return arg_9_0._failAlertCount >= var_0_0.FailAlertCount
end

function var_0_0.hideConnectTips(arg_10_0)
	BootLoadingView.instance:hide()
end

function var_0_0.showConnectTips(arg_11_0)
	if BootVoiceView.instance:isShow() then
		BootVoiceView.instance:updateTips()
		BootLoadingView.instance:hide()
	elseif arg_11_0:getFailAlertCount() > 0 then
		local var_11_0 = string.format(booterLang("network_reconnect"), tostring(arg_11_0:getFailAlertCount()))

		BootLoadingView.instance:showMsg(var_11_0, "")
	else
		local var_11_1 = string.format(booterLang("network_connecting"))

		BootLoadingView.instance:showMsg(var_11_1, "")
	end
end

function var_0_0.initStatHotUpdatePer(arg_12_0)
	arg_12_0._statHotUpdatePerList = {}
	arg_12_0._statHotUpdatePerList[1] = {
		0,
		SDKDataTrackMgr.EventName.hotupdate_0_20
	}
	arg_12_0._statHotUpdatePerList[2] = {
		0.21,
		SDKDataTrackMgr.EventName.hotupdate_21_40
	}
	arg_12_0._statHotUpdatePerList[3] = {
		0.41,
		SDKDataTrackMgr.EventName.hotupdate_41_60
	}
	arg_12_0._statHotUpdatePerList[4] = {
		0.61,
		SDKDataTrackMgr.EventName.hotupdate_61_80
	}
	arg_12_0._statHotUpdatePerList[5] = {
		0.81,
		SDKDataTrackMgr.EventName.hotupdate_81_100
	}
	arg_12_0._statHotUpdatePerNum = 5
	arg_12_0._nowStatHotUpdatePerIndex = 1
end

function var_0_0.start(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0:initStatHotUpdatePer()

	arg_13_0._onFinishCb = arg_13_1
	arg_13_0._onFinishObj = arg_13_2
	arg_13_0._onDownloadSuccCb = arg_13_3
	arg_13_0._onDownloadSuccObj = arg_13_4

	if GameResMgr.IsFromEditorDir then
		-- block empty
	end

	arg_13_0._started = true

	arg_13_0:resetFailCount()
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.GetRemoteVersionFail, arg_13_0._onGetRemoteVersionFail, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.GetRemoteVersionSuccess, arg_13_0._onGetRemoteVersionSuccess, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.GetUpdateManifestFail, arg_13_0._onGetUpdateResInfoFail, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.GetUpdateManifestSuccess, arg_13_0._onGetUpdateResInfoSuccess, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.NeedInstallNewPackage, arg_13_0._onNeedInstallNewPackage, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.StartHotUpdateNotify, arg_13_0._onStartHotUpdateNotify, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.HotUpdateDownloadProgress, arg_13_0._onHotUpdateDownloadProgress, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.HotUpdateDownloadFail, arg_13_0._onHotUpdateDownloadFail, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.DownloadDiskFull, arg_13_0._onDownloadDiskFull, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.HotUpdateDownloadSuccess, arg_13_0._onHotUpdateDownloadSuccess, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.StartUnzipNotify, arg_13_0._onStartUnzipNotify, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.DiskSpaceNotEnough, arg_13_0._onDiskSpaceNotEnough, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.UnzipProgress, arg_13_0._onUnzipProgress, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.UnzipFail, arg_13_0._onUnzipFail, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.UnzipSuccess, arg_13_0._onUnzipSuccess, arg_13_0)
	arg_13_0._eventMgrInst:AddLuaLisenter(arg_13_0._eventMgr.HotUpdateComplete, arg_13_0._onHotUpdateComplete, arg_13_0)

	local var_13_0 = arg_13_0:getDomainUrl()
	local var_13_1 = SDKMgr.instance:getGameId()
	local var_13_2 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_13_2 = 2
	end

	local var_13_3 = SDKMgr.instance:getChannelId()
	local var_13_4 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local var_13_5 = tonumber(BootNativeUtil.getAppVersion())
	local var_13_6 = BootNativeUtil.getPackageName()
	local var_13_7 = SDKMgr.instance:getSubChannelId()

	arg_13_0:statStartUpdate()
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_check)

	local var_13_8 = GameChannelConfig.getServerType()

	arg_13_0._eventMgrInst:StartUpdate(var_13_0, var_13_1, var_13_2, var_13_3, var_13_8, var_13_4, var_13_5, var_13_6, var_13_7)
end

function var_0_0.stop(arg_14_0)
	arg_14_0._eventMgrInst:StopUpdate()
end

function var_0_0.getDomainUrl(arg_15_0)
	local var_15_0, var_15_1 = GameUrlConfig.getHotUpdateUrl()

	return arg_15_0:getUseBackup() and var_15_1 or var_15_0
end

function var_0_0._onFinish(arg_16_0)
	if not arg_16_0._onFinishCb then
		return
	end

	if arg_16_0._started then
		arg_16_0._eventMgrInst:ClearLuaListener()
	end

	arg_16_0._onFinishCb(arg_16_0._onFinishObj)

	arg_16_0._started = false

	if arg_16_0._audioInited then
		BootAudioMgr.instance:dispose()
	end
end

function var_0_0._initAudio(arg_17_0)
	arg_17_0._audioInited = true

	BootAudioMgr.instance:init(arg_17_0._onAudioInited, arg_17_0)
end

function var_0_0._onAudioInited(arg_18_0)
	logNormal("启动音效初始化成功！")
end

function var_0_0._onGetRemoteVersionFail(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	logWarn("HotUpdateMgr:_onGetRemoteVersionFail, 获取版本失败, error = " .. arg_19_1)
	arg_19_0:inverseUseBackup()

	local var_19_0 = arg_19_0:getDomainUrl()

	arg_19_0._eventMgrInst:ChangeGetInfoDomainUrl(var_19_0)
	arg_19_0:incFailCount()

	if arg_19_0:isFailNeedAlert() then
		arg_19_0:resetFailAlertCount()

		local var_19_1 = {
			title = booterLang("hotupdate"),
			content = booterLang("error_request_version") .. arg_19_1,
			leftMsg = booterLang("exit"),
			leftCb = arg_19_0._quitGame,
			leftCbObj = arg_19_0,
			rightMsg = booterLang("retry"),
			rightCb = arg_19_0._retryGetVersion,
			rightCbObj = arg_19_0
		}

		BootMsgBox.instance:show(var_19_1)
		arg_19_0:hideConnectTips()
	else
		logNormal("HotUpdateMgr 静默重试获取版本！")
		arg_19_0._eventMgrInst:DoRetryAction()
		arg_19_0:showConnectTips()
	end

	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, arg_19_3, arg_19_2, arg_19_1)
end

function var_0_0._quitGame(arg_20_0)
	logNormal("HotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function var_0_0._retryGetVersion(arg_21_0)
	logNormal("HotUpdateMgr:_retryGetVersion, 重试获取版本！")
	arg_21_0._eventMgrInst:DoRetryAction()
	arg_21_0:showConnectTips()
end

function var_0_0._onGetRemoteVersionSuccess(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	arg_22_0:hideConnectTips()

	local var_22_0 = arg_22_0:getDomainUrl()

	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_versioncheck", var_22_0, arg_22_0:getFailCount())
	arg_22_0:resetFailCount()
	logNormal("HotUpdateMgr:_onGetRemoteVersionSuccess ！")

	arg_22_0.shouldHotUpdate = SLFramework.GameUpdate.HotUpdateInfoMgr.ShouldHotUpdate

	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, arg_22_5)
end

function var_0_0._onGetUpdateResInfoFail(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	logWarn("HotUpdateMgr:_onGetUpdateResInfoFail, 获取更新资源信息失败, error = " .. arg_23_1)
	arg_23_0:inverseUseBackup()

	local var_23_0 = arg_23_0:getDomainUrl()

	arg_23_0._eventMgrInst:ChangeGetInfoDomainUrl(var_23_0)
	arg_23_0:incFailCount()

	if arg_23_0:isFailNeedAlert() then
		arg_23_0:resetFailAlertCount()

		local var_23_1 = {
			title = booterLang("hotupdate"),
			content = booterLang("error_request_update") .. arg_23_1,
			leftMsg = booterLang("exit"),
			leftCb = arg_23_0._quitGame,
			leftCbObj = arg_23_0,
			rightMsg = booterLang("retry"),
			rightCb = arg_23_0._retryGetUpdateManifest,
			rightCbObj = arg_23_0
		}

		BootMsgBox.instance:show(var_23_1)
		arg_23_0:hideConnectTips()
	else
		logNormal("HotUpdateMgr 静默重试获取更新资源信息！")
		arg_23_0._eventMgrInst:DoRetryAction()
		arg_23_0:showConnectTips()
	end

	SDKDataTrackMgr.instance:trackHotUpdateResourceEvent(SDKDataTrackMgr.RequestResult.fail, arg_23_3, arg_23_2, arg_23_1)
end

function var_0_0._retryGetUpdateManifest(arg_24_0)
	logNormal("HotUpdateMgr:_retryGetUpdateManifest, 重试获取更新信息失败！")
	arg_24_0._eventMgrInst:DoRetryAction()
	arg_24_0:showConnectTips()
end

function var_0_0._onGetUpdateResInfoSuccess(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:hideConnectTips()

	local var_25_0 = arg_25_0:getDomainUrl()

	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_srcrequest", var_25_0, arg_25_0:getFailCount())
	arg_25_0:resetFailCount()
	logNormal("HotUpdateMgr:_onGetUpdateResInfoSuccess targetVersion = ", arg_25_1)
	SDKDataTrackMgr.instance:trackHotUpdateResourceEvent(SDKDataTrackMgr.RequestResult.success, arg_25_2)
end

function var_0_0._onNeedInstallNewPackage(arg_26_0, arg_26_1)
	logNormal("HotUpdateMgr:_onNeedInstallNewPackage, 需要整包更新！appUrl = " .. arg_26_1)

	arg_26_0._appUrl = arg_26_1

	local var_26_0 = {
		title = booterLang("hotupdate"),
		content = booterLang("need_update_package"),
		leftMsg = booterLang("exit"),
		leftCb = arg_26_0._quitGame,
		leftCbObj = arg_26_0,
		rightMsg = booterLang("download")
	}

	if VersionUtil.isVersionLargeEqual("2.7.0") then
		var_26_0.rightCb = arg_26_0._gotoDownloadPackageNew
	else
		var_26_0.rightCb = arg_26_0._gotoDownloadPackageLegacy
	end

	arg_26_0:_addRewardFlagParams(var_26_0)

	var_26_0.rightCbObj = arg_26_0

	BootMsgBox.instance:show(var_26_0)
end

function var_0_0._addRewardFlagParams(arg_27_0, arg_27_1)
	arg_27_1.contentStr = arg_27_1.content
	arg_27_1.isShowRewardTips = true

	if not string.nilorempty(arg_27_0._hotUpdateRewardTips) then
		arg_27_1.content = arg_27_1.contentStr .. "\n" .. arg_27_0._hotUpdateRewardTips
	end
end

function var_0_0._onHotUpdateTipsHttpResult(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 then
		arg_28_0._hotUpdateRewardTips = arg_28_2:getTipsStr()

		local var_28_0 = BootMsgBox.instance.args

		if var_28_0 and var_28_0.isShowRewardTips and not string.nilorempty(arg_28_0._hotUpdateRewardTips) then
			BootMsgBox.instance:setContentText(var_28_0.contentStr .. "\n" .. arg_28_0._hotUpdateRewardTips)
		end
	end
end

function var_0_0.getRewardTipsStr(arg_29_0)
	return arg_29_0._hotUpdateRewardTips
end

function var_0_0._gotoDownloadPackageNew(arg_30_0)
	logNormal("HotUpdateMgr:_gotoDownloadPackageNew, 打开下载Url = " .. arg_30_0._appUrl)

	if BootNativeUtil.isAndroid() then
		SDKNativeUtil.updateGame(arg_30_0._appUrl)
		Timer.New(function()
			arg_30_0:_onNeedInstallNewPackage(arg_30_0._appUrl)
		end, 0.1):Start()

		return
	end

	if BootNativeUtil.isIOS() then
		local var_30_0 = {
			deepLink = "",
			url = arg_30_0._appUrl
		}
		local var_30_1 = cjson.encode(var_30_0)

		ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", var_30_1)
		Timer.New(function()
			arg_30_0:_onNeedInstallNewPackage(arg_30_0._appUrl)
		end, 0.1):Start()

		return
	end

	if BootNativeUtil.isWindows() and GameChannelConfig.isBilibili() then
		SDKMgr.instance:openLauncher()

		return
	end

	if string.nilorempty(arg_30_0._appUrl) == false then
		UnityEngine.Application.OpenURL(arg_30_0._appUrl)
	end

	if not BootNativeUtil.isAndroid() then
		ProjBooter.instance:quitGame()
	end
end

function var_0_0._gotoDownloadPackageLegacy(arg_33_0)
	logNormal("HotUpdateMgr:_gotoDownloadPackageLegacy, 打开下载Url = " .. arg_33_0._appUrl)

	if BootNativeUtil.isAndroid() and tostring(SDKMgr.instance:getSubChannelId()) == "1001" then
		SDKNativeUtil.updateGame(arg_33_0._appUrl)
		Timer.New(function()
			arg_33_0:_onNeedInstallNewPackage(arg_33_0._appUrl)
		end, 0.1):Start()

		return
	end

	if BootNativeUtil.isWindows() and GameChannelConfig.isBilibili() then
		SDKMgr.instance:openLauncher()

		return
	end

	if string.nilorempty(arg_33_0._appUrl) == false then
		UnityEngine.Application.OpenURL(arg_33_0._appUrl)
	end

	if BootNativeUtil.isAndroid() then
		Timer.New(function()
			arg_33_0:_onNeedInstallNewPackage(arg_33_0._appUrl)
		end, 0.1):Start()
	else
		ProjBooter.instance:quitGame()
	end
end

function var_0_0._onStartHotUpdateNotify(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._hasHotUpdate = true
	arg_36_1 = tonumber(tostring(arg_36_1))
	arg_36_2 = tonumber(tostring(arg_36_2))

	logNormal("HotUpdateMgr:_onStartHotUpdateNotify, 热更新 curSize = " .. arg_36_1 .. " allSize = " .. arg_36_2)
	arg_36_0:_showConfirmUpdateSize(arg_36_2, arg_36_1, arg_36_0._startDownload)
	arg_36_0:_initAudio()
end

function var_0_0._startDownload(arg_37_0)
	logNormal("HotUpdateMgr:_startDownload, 开始下载！")
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_download)
	SLFramework.GameUpdate.HotUpdate.Instance:SetUseReserveDomain(arg_37_0:getUseBackup())
	arg_37_0._eventMgrInst:DoRetryAction()
end

function var_0_0._onHotUpdateDownloadProgress(arg_38_0, arg_38_1, arg_38_2)
	arg_38_1 = tonumber(tostring(arg_38_1))
	arg_38_2 = tonumber(tostring(arg_38_2))

	local var_38_0 = not arg_38_0._prevSize or arg_38_1 ~= arg_38_0._prevSize

	arg_38_0._prevSize = arg_38_1

	if arg_38_0:getFailCount() > 0 and var_38_0 then
		local var_38_1 = arg_38_0:getDomainUrl()

		SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_srcdownload", var_38_1, arg_38_0:getFailCount())
		arg_38_0:resetFailCount()
	end

	logNormal("HotUpdateMgr:_onHotUpdateDownloadProgress, 下载进度 curSize = " .. arg_38_1 .. " allSize = " .. arg_38_2)

	local var_38_2 = arg_38_1 / arg_38_2
	local var_38_3 = arg_38_0:_fixSizeMB(arg_38_2)

	if var_38_0 then
		HotUpdateProgress.instance:setProgressDownloadHotupdate(arg_38_1)
	end

	arg_38_0:statHotUpdate(var_38_2, var_38_3)
end

function var_0_0._setUseReserveDomain(arg_39_0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_39_0 = typeof(SLFramework.GameUpdate.HotUpdate)

	tolua.getfield(var_39_0, "_useReserveDomain", 36):Set(SLFramework.GameUpdate.HotUpdate.Instance, arg_39_0:getUseBackup())
end

function var_0_0._onHotUpdateDownloadFail(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 == SLFramework.GameUpdate.FailError.MD5CheckError then
		arg_40_0:_checkSendFullPonitStat()
	end

	arg_40_0:inverseUseBackup()
	arg_40_0:_setUseReserveDomain()
	arg_40_0:incFailCount()

	if arg_40_0:isFailNeedAlert() then
		arg_40_0:resetFailAlertCount()

		local var_40_0 = {
			title = booterLang("hotupdate"),
			content = arg_40_0:_getDownloadFailedTip(arg_40_1, arg_40_2),
			leftMsg = booterLang("exit"),
			leftCb = arg_40_0._quitGame,
			leftCbObj = arg_40_0,
			rightMsg = booterLang("retry"),
			rightCb = arg_40_0._retryDownload,
			rightCbObj = arg_40_0
		}

		BootMsgBox.instance:show(var_40_0)
	else
		logNormal("HotUpdateMgr 静默重试下载！")
		arg_40_0._eventMgrInst:DoRetryAction()
		arg_40_0:showConnectTips()
	end
end

function var_0_0._onDownloadDiskFull(arg_41_0)
	local var_41_0 = {
		title = booterLang("hotupdate"),
		content = booterLang("download_fail_no_enough_disk"),
		leftMsg = booterLang("exit"),
		leftCb = arg_41_0._quitGame,
		leftCbObj = arg_41_0,
		rightMsg = booterLang("retry"),
		rightCb = arg_41_0._retryDownload,
		rightCbObj = arg_41_0
	}

	BootMsgBox.instance:show(var_41_0)
end

function var_0_0._retryDownload(arg_42_0)
	logNormal("HotUpdateMgr:_retryDownload, 重试下载！")
	arg_42_0._eventMgrInst:DoRetryAction()
	arg_42_0:showConnectTips()
end

function var_0_0._getDownloadFailedTip(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = SLFramework.GameUpdate.FailError

	if arg_43_1 == var_43_0.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif arg_43_1 == var_43_0.NotFound then
		return booterLang("download_fail_not_found")
	elseif arg_43_1 == var_43_0.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif arg_43_1 == var_43_0.TimeOut then
		return booterLang("download_fail_time_out")
	elseif arg_43_1 == var_43_0.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif arg_43_1 == var_43_0.MD5CheckError then
		SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.fail, arg_43_2)

		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(arg_43_2)
	end
end

function var_0_0._onHotUpdateDownloadSuccess(arg_44_0)
	logNormal("下载热更新资源包完成，开始解压所有资源包！")
	SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.success)
	SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.game_source_completed)
	arg_44_0:_checkSendFullPonitStat()
	SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.success)

	if arg_44_0._onDownloadSuccCb then
		arg_44_0._onDownloadSuccCb(arg_44_0._onDownloadSuccObj)
	end
end

function var_0_0._onStartUnzipNotify(arg_45_0)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.unzip_start)
end

function var_0_0._onDiskSpaceNotEnough(arg_46_0)
	logNormal("解压所有资源包遇到错误，设备磁盘空间不足！")

	local var_46_0 = {
		title = booterLang("hotupdate"),
		content = booterLang("unpack_error"),
		leftMsg = booterLang("exit"),
		leftCb = arg_46_0._quitGame,
		leftCbObj = arg_46_0
	}

	var_46_0.rightMsg = nil

	BootMsgBox.instance:show(var_46_0)
end

function var_0_0._onUnzipProgress(arg_47_0, arg_47_1, arg_47_2)
	logNormal("正在解压资源包，请稍后... progress = " .. arg_47_1 .. " totalProgress = " .. arg_47_2)

	if tostring(arg_47_1) == "nan" then
		return
	end

	HotUpdateProgress.instance:setProgressUnzipHotupdate(arg_47_2)
end

function var_0_0._onUnzipFail(arg_48_0, arg_48_1)
	logNormal("解压所有资源包遇到错误，解压失败！")

	local var_48_0 = {
		title = booterLang("hotupdate"),
		content = arg_48_0:_getUnzipFailedTip(arg_48_1),
		leftMsg = booterLang("exit"),
		leftCb = arg_48_0._quitGame,
		leftCbObj = arg_48_0,
		rightMsg = booterLang("retry"),
		rightCb = arg_48_0._retryUnzipFile,
		rightCbObj = arg_48_0
	}

	BootMsgBox.instance:show(var_48_0)
	SDKDataTrackMgr.instance:trackUnzipFinishEvent(SDKDataTrackMgr.Result.fail, var_48_0.content)
end

function var_0_0._retryUnzipFile(arg_49_0)
	logNormal("HotUpdateMgr:_retryUnzipFile, 重试解压资源包！")
	arg_49_0._eventMgrInst:DoRetryAction()
end

function var_0_0._getUnzipFailedTip(arg_50_0, arg_50_1)
	local var_50_0 = SLFramework.GameUpdate.UnzipStatus

	if arg_50_1 == var_50_0.Running then
		return booterLang("unpack_error_running")
	elseif arg_50_1 == var_50_0.Done then
		return booterLang("unpack_error_done")
	elseif arg_50_1 == var_50_0.FileNotFound then
		return booterLang("unpack_error_file_not_found")
	elseif arg_50_1 == var_50_0.NotEnoughSpace then
		return booterLang("unpack_error_not_enough_space")
	elseif arg_50_1 == var_50_0.ThreadAbort then
		return booterLang("unpack_error_thread_abort")
	elseif arg_50_1 == var_50_0.Exception then
		return booterLang("unpack_error_exception")
	else
		return booterLang("unpack_error_unknown")
	end
end

function var_0_0._onUnzipSuccess(arg_51_0)
	SDKDataTrackMgr.instance:trackUnzipFinishEvent(SDKDataTrackMgr.Result.success)
end

function var_0_0.hasHotUpdate(arg_52_0)
	return arg_52_0._hasHotUpdate
end

function var_0_0._onHotUpdateComplete(arg_53_0)
	if arg_53_0._hasHotUpdate then
		arg_53_0:_onFinish()
	else
		arg_53_0:_showConfirmUpdateSize(0, 0, arg_53_0._onFinish)
	end
end

function var_0_0._showConfirmUpdateSize(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = HotUpdateVoiceMgr.instance:getTotalSize()

	HotUpdateProgress.instance:initDownloadSize(arg_54_1, arg_54_2)

	local var_54_1 = HotUpdateVoiceMgr.instance:getNeedDownloadSize()
	local var_54_2 = HotUpdateOptionPackageMgr.instance:getNeedDownloadSize()
	local var_54_3 = arg_54_1 - arg_54_2
	local var_54_4 = var_54_1 + var_54_3 + var_54_2

	if not BootVoiceView.instance:isFirstDownloadDone() and not VersionValidator.instance:isInReviewing() then
		local var_54_5 = BootVoiceView.instance:getDownloadChoices()

		if var_54_4 > 0 or #var_54_5 > 0 and var_54_0 == 0 then
			BootVoiceView.instance:showDownloadSize(var_54_3, arg_54_3, arg_54_0)
		else
			BootVoiceView.instance:hide()
			arg_54_3(arg_54_0)
		end
	elseif var_54_4 > 0 then
		if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			BootVoiceView.instance:hide()
			arg_54_3(arg_54_0)
		else
			local var_54_6 = arg_54_0:_fixSizeStr(var_54_4)
			local var_54_7 = {
				title = booterLang("hotupdate")
			}
			local var_54_8 = arg_54_2 == 0 and booterLang("hotupdate_info") or booterLang("hotupdate_continue_info")

			var_54_7.content = string.format(var_54_8, var_54_6)
			var_54_7.leftMsg = booterLang("exit")
			var_54_7.leftCb = arg_54_0._quitGame
			var_54_7.leftCbObj = arg_54_0
			var_54_7.rightMsg = arg_54_2 == 0 and booterLang("download") or booterLang("continue_download")
			var_54_7.rightCb = arg_54_3
			var_54_7.rightCbObj = arg_54_0

			arg_54_0:_addRewardFlagParams(var_54_7)
			BootMsgBox.instance:show(var_54_7)
		end
	else
		BootVoiceView.instance:hide()
		arg_54_3(arg_54_0)
	end
end

function var_0_0.statStartUpdate(arg_55_0)
	arg_55_0._statNextPoint = 0
	arg_55_0._statAllSize = 0
end

function var_0_0.statHotUpdate(arg_56_0, arg_56_1, arg_56_2)
	for iter_56_0 = arg_56_0._nowStatHotUpdatePerIndex, arg_56_0._statHotUpdatePerNum do
		local var_56_0 = arg_56_0._statHotUpdatePerList[iter_56_0]

		if arg_56_1 >= var_56_0[1] then
			SDKDataTrackMgr.instance:track(var_56_0[2])

			arg_56_0._nowStatHotUpdatePerIndex = iter_56_0 + 1
		else
			break
		end
	end

	if not arg_56_0._statNextPoint then
		return
	end

	arg_56_0._statAllSize = arg_56_2

	if arg_56_1 >= arg_56_0._statNextPoint then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.HotUpdate, {
			[SDKDataTrackMgr.EventProperties.UpdateAmount] = arg_56_2,
			[SDKDataTrackMgr.EventProperties.UpdatePercentage] = tostring(arg_56_0._statNextPoint)
		})

		arg_56_0._statNextPoint = arg_56_0._statNextPoint + 0.5
	end
end

function var_0_0._checkSendFullPonitStat(arg_57_0)
	if arg_57_0._statNextPoint and arg_57_0._statNextPoint < 1.5 and arg_57_0._statAllSize and arg_57_0._statAllSize ~= 0 then
		arg_57_0._statNextPoint = 1

		arg_57_0:statHotUpdate(1, arg_57_0._statAllSize)
	end
end

function var_0_0._fixSizeStr(arg_58_0, arg_58_1)
	return var_0_0.fixSizeStr(arg_58_1)
end

function var_0_0._fixSizeMB(arg_59_0, arg_59_1)
	return var_0_0.fixSizeMB(arg_59_1)
end

var_0_0.MB_SIZE = 1048576
var_0_0.KB_SIZE = 1024

function var_0_0.fixSizeStr(arg_60_0)
	local var_60_0 = arg_60_0 / var_0_0.MB_SIZE
	local var_60_1 = "MB"

	if var_60_0 < 1 then
		var_60_0 = arg_60_0 / var_0_0.KB_SIZE
		var_60_1 = "KB"

		if var_60_0 < 0.01 then
			var_60_0 = 0.01
		end
	end

	local var_60_2 = var_60_0 - var_60_0 % 0.01

	return string.format("%.2f %s", var_60_2, var_60_1)
end

function var_0_0.fixSizeMB(arg_61_0)
	local var_61_0 = arg_61_0 / var_0_0.MB_SIZE

	if var_61_0 < 0.001 then
		return 0.001
	end

	return var_61_0 - var_61_0 % 0.001
end

var_0_0.instance = var_0_0.New()

return var_0_0
