module("projbooter.hotupdate.VoiceDownloader", package.seeall)

local var_0_0 = class("VoiceDownloader")

function var_0_0.start(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._lang2DownloadList = HotUpdateVoiceMgr.instance:getAllLangDownloadList()
	arg_1_0._totalSize = 0
	arg_1_0._download_voice_pack_list = BootVoiceView.instance:getDownloadChoices()

	for iter_1_0, iter_1_1 in pairs(arg_1_0._lang2DownloadList) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
			arg_1_0._totalSize = arg_1_0._totalSize + iter_1_3.length
		end
	end

	arg_1_0._statHotUpdatePerList = {}
	arg_1_0._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	arg_1_0._statHotUpdatePerList[2] = {
		0.2,
		"20%"
	}
	arg_1_0._statHotUpdatePerList[3] = {
		0.4,
		"40%"
	}
	arg_1_0._statHotUpdatePerList[4] = {
		0.6,
		"60%"
	}
	arg_1_0._statHotUpdatePerList[5] = {
		0.8,
		"80%"
	}
	arg_1_0._statHotUpdatePerList[6] = {
		1,
		"100%"
	}
	arg_1_0._statHotUpdatePerNum = 6
	arg_1_0._nowStatHotUpdatePerIndex = 1
	arg_1_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	arg_1_0._downloadSize = 0

	if arg_1_0._totalSize > 0 then
		arg_1_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		arg_1_0._optionalUpdateInst = arg_1_0._optionalUpdate.Instance

		arg_1_0._optionalUpdateInst:SetUseReserveUrl(HotUpdateMgr.instance:getUseBackup())
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.NotEnoughDiskSpace, arg_1_0._onNotEnoughDiskSpace, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadStart, arg_1_0._onDownloadStart, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadProgressRefresh, arg_1_0._onDownloadProgressRefresh, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadPackFail, arg_1_0._onDownloadPackFail, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadPackSuccess, arg_1_0._onDownloadPackSuccess, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.PackUnZipFail, arg_1_0._onPackUnZipFail, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.PackItemStateChange, arg_1_0._onPackItemStateChange, arg_1_0)

		arg_1_0._onDownloadFinish = arg_1_1
		arg_1_0._onDownloadFinishObj = arg_1_2
		arg_1_0._downloadSuccSize = 0

		arg_1_0:_setUseReserveUrl()
		arg_1_0:_startOneLangDownload()
	else
		arg_1_0:_setDoneFirstDownload()
		arg_1_1(arg_1_2)
	end
end

function var_0_0._startOneLangDownload(arg_2_0)
	local var_2_0, var_2_1 = next(arg_2_0._lang2DownloadList)

	if var_2_0 and var_2_1 then
		arg_2_0._downloadingList = var_2_1
		arg_2_0._downloadUrl, arg_2_0._downloadUrlBak = HotUpdateVoiceMgr.instance:getDownloadUrl(var_2_0)

		arg_2_0._optionalUpdateInst:SetRemoteAssetUrl(arg_2_0._downloadUrl, arg_2_0._downloadUrlBak)

		local var_2_2 = {}
		local var_2_3 = {}
		local var_2_4 = {}
		local var_2_5 = {}
		local var_2_6

		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			table.insert(var_2_2, iter_2_1.name)
			table.insert(var_2_3, iter_2_1.hash)
			table.insert(var_2_4, iter_2_1.order)
			table.insert(var_2_5, iter_2_1.length)

			var_2_6 = var_2_6 or string.splitToNumber(iter_2_1.latest_ver, ".")[2] or 0
		end

		arg_2_0._optionalUpdateInst:StartDownload(var_2_0, var_2_2, var_2_3, var_2_4, var_2_5, var_2_6)

		arg_2_0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

		arg_2_0._eventMgrInst:AddLuaLisenter(SLFramework.GameUpdate.HotUpdateEvent.UnzipProgress, arg_2_0._onUnzipProgress, arg_2_0)
	else
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.NotEnoughDiskSpace)
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.DownloadStart)
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.DownloadProgressRefresh)
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.DownloadPackFail)
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.DownloadPackSuccess)
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.PackUnZipFail)
		arg_2_0._optionalUpdateInst:UnRegister(arg_2_0._optionalUpdate.PackItemStateChange)

		arg_2_0._optionalUpdateInst = nil
		arg_2_0._optionalUpdate = nil
		arg_2_0._lang2DownloadList = nil
		arg_2_0._downloadDict = nil

		arg_2_0:_setDoneFirstDownload()
		arg_2_0._onDownloadFinish(arg_2_0._onDownloadFinishObj)

		if arg_2_0._eventMgrInst then
			arg_2_0._eventMgrInst:ClearLuaListener()

			arg_2_0._eventMgrInst = nil
		end
	end
end

function var_0_0._setDoneFirstDownload(arg_3_0)
	BootVoiceView.instance:setFirstDownloadDone()
end

function var_0_0._onDownloadStart(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	logNormal("VoiceDownloader:_onDownloadStart, packName = " .. arg_4_1 .. " curSize = " .. arg_4_2 .. " allSize = " .. arg_4_3)

	arg_4_2 = tonumber(tostring(arg_4_2))
	arg_4_3 = tonumber(tostring(arg_4_3))
	arg_4_0._downloadSize = arg_4_2 + arg_4_0._downloadSuccSize

	arg_4_0:statHotUpdate(0, arg_4_0._downloadSize)
end

function var_0_0._onDownloadProgressRefresh(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_2 = tonumber(tostring(arg_5_2))
	arg_5_3 = tonumber(tostring(arg_5_3))

	local var_5_0 = not arg_5_0._prevSize or arg_5_2 ~= arg_5_0._prevSize

	arg_5_0._prevSize = arg_5_2

	if HotUpdateMgr.instance:getFailCount() > 0 and var_5_0 then
		local var_5_1 = HotUpdateMgr.instance:getUseBackup() and arg_5_0._downloadUrlBak or arg_5_0._downloadUrl
		local var_5_2 = string.match(var_5_1, "(https?://[^/]+)")

		SDKDataTrackMgr.instance:trackDomainFailCount("scene_voice_srcdownload", var_5_2, HotUpdateMgr.instance:getFailCount())
		HotUpdateMgr.instance:resetFailCount()
	end

	logNormal("VoiceDownloader:_onDownloadProgressRefresh, packName = " .. arg_5_1 .. " curSize = " .. arg_5_2 .. " allSize = " .. arg_5_3)

	local var_5_3 = arg_5_2 + arg_5_0._downloadSuccSize

	arg_5_0._downloadSize = var_5_3

	local var_5_4 = var_5_3 / arg_5_0._totalSize
	local var_5_5 = arg_5_0:_fixSizeStr(var_5_3)
	local var_5_6 = arg_5_0:_fixSizeStr(arg_5_0._totalSize)
	local var_5_7

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_5_7 = string.format(booterLang("download_info_wifi"), var_5_5, var_5_6)
	else
		var_5_7 = string.format(booterLang("download_info"), var_5_5, var_5_6)
	end

	arg_5_0._downProgressS1 = var_5_5
	arg_5_0._downProgressS2 = var_5_6

	if var_5_0 then
		BootLoadingView.instance:show(var_5_4, var_5_7)
	end

	arg_5_0:statHotUpdate(var_5_4, var_5_3)
end

function var_0_0.statHotUpdate(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0 = arg_6_0._nowStatHotUpdatePerIndex, arg_6_0._statHotUpdatePerNum do
		local var_6_0 = arg_6_0._statHotUpdatePerList[iter_6_0]
		local var_6_1 = var_6_0[1]

		if var_6_1 <= arg_6_1 or var_6_1 == 1 and arg_6_0._totalSize - arg_6_2 < 1024 then
			local var_6_2 = {
				step = var_6_0[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_6_0._downLoadStartTime,
				update_amount = arg_6_0:_fixSizeMB(arg_6_0._totalSize - arg_6_2),
				download_voice_pack_list = arg_6_0._download_voice_pack_list
			}

			SDKDataTrackMgr.instance:trackVoicePackDownloading(var_6_2)

			arg_6_0._nowStatHotUpdatePerIndex = iter_6_0 + 1
		else
			break
		end
	end
end

function var_0_0._onPackItemStateChange(arg_7_0, arg_7_1)
	logNormal("VoiceDownloader:_onPackItemStateChange, packName = " .. arg_7_1)
end

function var_0_0._onDownloadPackSuccess(arg_8_0, arg_8_1)
	logNormal("VoiceDownloader:_onDownloadPackSuccess, packName = " .. arg_8_1)

	if arg_8_0._downloadingList then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._downloadingList) do
			arg_8_0._downloadSuccSize = arg_8_0._downloadSuccSize + iter_8_1.length
		end
	end

	arg_8_0._downloadSize = arg_8_0._downloadSuccSize
	arg_8_0._lang2DownloadList[arg_8_1] = nil
	arg_8_0._downloadingList = nil

	arg_8_0:_startOneLangDownload()
end

function var_0_0._setUseReserveUrl(arg_9_0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_9_0 = typeof(SLFramework.GameUpdate.OptionalUpdate)

	tolua.getfield(var_9_0, "_useReserveUrl", 36):Set(SLFramework.GameUpdate.OptionalUpdate.Instance, HotUpdateMgr.instance:getUseBackup())
end

function var_0_0._onDownloadPackFail(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	logNormal("VoiceDownloader:_onDownloadPackFail, packName = " .. arg_10_1 .. " resUrl = " .. arg_10_2 .. " failError = " .. arg_10_3)

	if arg_10_3 == 5 then
		arg_10_0:_onNotEnoughDiskSpace(arg_10_1)
	else
		HotUpdateMgr.instance:inverseUseBackup()
		arg_10_0:_setUseReserveUrl()
		HotUpdateMgr.instance:incFailCount()

		if HotUpdateMgr.instance:isFailNeedAlert() then
			HotUpdateMgr.instance:resetFailAlertCount()

			local var_10_0 = {
				title = booterLang("hotupdate"),
				content = arg_10_0:_getDownloadFailedTip(arg_10_3, arg_10_4),
				leftMsg = booterLang("exit"),
				leftCb = arg_10_0._quitGame,
				leftCbObj = arg_10_0,
				rightMsg = booterLang("retry"),
				rightCb = arg_10_0._retry,
				rightCbObj = arg_10_0
			}

			BootMsgBox.instance:show(var_10_0)
		else
			logNormal("VoiceDownloader 静默重试下载！")
			arg_10_0:_retry()
			HotUpdateMgr.instance:showConnectTips()
		end
	end

	local var_10_1 = {}

	var_10_1.step = "fail"
	var_10_1.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_10_0._downLoadStartTime
	var_10_1.result_msg = arg_10_0:_getDownloadFailedTip(arg_10_3, arg_10_4)
	var_10_1.download_voice_pack_list = arg_10_0._download_voice_pack_list
	var_10_1.update_amount = arg_10_0:_fixSizeMB(arg_10_0._totalSize - arg_10_0._downloadSize)

	SDKDataTrackMgr.instance:trackVoicePackDownloading(var_10_1)
end

function var_0_0._onNotEnoughDiskSpace(arg_11_0, arg_11_1)
	logNormal("VoiceDownloader:_onNotEnoughDiskSpace, packName = " .. arg_11_1)

	local var_11_0 = {
		title = booterLang("hotupdate"),
		content = booterLang("download_fail_no_enough_disk"),
		rightMsg = booterLang("exit"),
		rightCb = arg_11_0._quitGame,
		rightCbObj = arg_11_0
	}

	BootMsgBox.instance:show(var_11_0)
end

function var_0_0._onPackUnZipFail(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		logNormal("VoiceDownloader:_onPackUnZipFail, packName = " .. arg_12_1 .. " failReason = " .. arg_12_2)

		local var_12_0 = {
			title = booterLang("hotupdate"),
			content = arg_12_0:_getUnzipFailedTip(arg_12_2),
			leftMsg = booterLang("exit"),
			leftCb = arg_12_0._quitGame,
			leftCbObj = arg_12_0,
			rightMsg = booterLang("retry"),
			rightCb = arg_12_0._retry,
			rightCbObj = arg_12_0
		}

		BootMsgBox.instance:show(var_12_0)
	end
end

function var_0_0._quitGame(arg_13_0)
	ProjBooter.instance:quitGame()
end

function var_0_0._retry(arg_14_0)
	arg_14_0._optionalUpdateInst:RunNextStepAction()
end

function var_0_0._onUnzipProgress(arg_15_0, arg_15_1)
	logNormal("正在解压语音包，请稍后... progress = " .. arg_15_1)

	if tostring(arg_15_1) == "nan" then
		return
	end

	local var_15_0 = arg_15_0._downProgressS1 or ""
	local var_15_1 = arg_15_0._downProgressS2 or ""
	local var_15_2 = math.floor(100 * arg_15_1 + 0.5)
	local var_15_3

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_15_3 = string.format(booterLang("unziping_progress_wifi"), tostring(var_15_2), var_15_0, var_15_1)
	else
		var_15_3 = string.format(booterLang("unziping_progress"), tostring(var_15_2), var_15_0, var_15_1)
	end

	BootLoadingView.instance:setProgressMsg(var_15_3)
end

function var_0_0.cancelDownload(arg_16_0)
	if arg_16_0._optionalUpdateInst then
		arg_16_0._optionalUpdateInst:StopDownload()

		arg_16_0._errorCode = nil
	end
end

function var_0_0._getDownloadFailedTip(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = SLFramework.GameUpdate.FailError

	arg_17_1 = var_17_0.IntToEnum(arg_17_1)
	arg_17_0._errorCode = arg_17_1
	arg_17_2 = arg_17_2 or ""

	if arg_17_1 == var_17_0.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif arg_17_1 == var_17_0.NotFound then
		return booterLang("download_fail_not_found")
	elseif arg_17_1 == var_17_0.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif arg_17_1 == var_17_0.TimeOut then
		return booterLang("download_fail_time_out")
	elseif arg_17_1 == var_17_0.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif arg_17_1 == var_17_0.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(arg_17_2)
	end
end

function var_0_0._getUnzipFailedTip(arg_18_0, arg_18_1)
	local var_18_0 = SLFramework.GameUpdate.UnzipStatus

	arg_18_1 = var_18_0.IntToEnum(arg_18_1)

	if arg_18_1 == var_18_0.Running then
		return booterLang("unpack_error_running")
	elseif arg_18_1 == var_18_0.Done then
		return booterLang("unpack_error_done")
	elseif arg_18_1 == var_18_0.FileNotFound then
		return booterLang("unpack_error_file_not_found")
	elseif arg_18_1 == var_18_0.NotEnoughSpace then
		return booterLang("unpack_error_not_enough_space")
	elseif arg_18_1 == var_18_0.ThreadAbort then
		return booterLang("unpack_error_thread_abort")
	elseif arg_18_1 == var_18_0.Exception then
		return booterLang("unpack_error_exception")
	else
		return booterLang("unpack_error_unknown")
	end
end

function var_0_0._fixSizeStr(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1 / HotUpdateMgr.MB_SIZE
	local var_19_1 = "MB"

	if var_19_0 < 1 then
		var_19_0 = arg_19_1 / HotUpdateMgr.KB_SIZE
		var_19_1 = "KB"

		if var_19_0 < 0.01 then
			var_19_0 = 0.01
		end
	end

	local var_19_2 = var_19_0 - var_19_0 % 0.01

	return string.format("%.2f %s", var_19_2, var_19_1)
end

function var_0_0._fixSizeMB(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 / HotUpdateMgr.MB_SIZE

	if var_20_0 < 0.001 then
		return 0.001
	end

	return var_20_0 - var_20_0 % 0.001
end

return var_0_0
