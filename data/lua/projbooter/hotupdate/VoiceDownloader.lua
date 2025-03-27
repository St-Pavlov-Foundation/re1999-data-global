module("projbooter.hotupdate.VoiceDownloader", package.seeall)

slot0 = class("VoiceDownloader")

function slot0.start(slot0, slot1, slot2)
	slot0._lang2DownloadList = HotUpdateVoiceMgr.instance:getAllLangDownloadList()
	slot0._totalSize = 0
	slot0._download_voice_pack_list = BootVoiceView.instance:getDownloadChoices()

	for slot6, slot7 in pairs(slot0._lang2DownloadList) do
		for slot11, slot12 in ipairs(slot7) do
			slot0._totalSize = slot0._totalSize + slot12.length
		end
	end

	slot0._statHotUpdatePerList = {
		{
			0,
			"start"
		},
		{
			0.2,
			"20%"
		},
		{
			0.4,
			"40%"
		},
		{
			0.6,
			"60%"
		},
		{
			0.8,
			"80%"
		},
		{
			1,
			"100%"
		}
	}
	slot0._statHotUpdatePerNum = 6
	slot0._nowStatHotUpdatePerIndex = 1
	slot0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	slot0._downloadSize = 0

	if slot0._totalSize > 0 then
		slot0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		slot0._optionalUpdateInst = slot0._optionalUpdate.Instance

		slot0._optionalUpdateInst:SetUseReserveUrl(HotUpdateMgr.instance:getUseBackup())
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.NotEnoughDiskSpace, slot0._onNotEnoughDiskSpace, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadStart, slot0._onDownloadStart, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadProgressRefresh, slot0._onDownloadProgressRefresh, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackFail, slot0._onDownloadPackFail, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackSuccess, slot0._onDownloadPackSuccess, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackUnZipFail, slot0._onPackUnZipFail, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackItemStateChange, slot0._onPackItemStateChange, slot0)

		slot0._onDownloadFinish = slot1
		slot0._onDownloadFinishObj = slot2
		slot0._downloadSuccSize = 0

		slot0:_setUseReserveUrl()
		slot0:_startOneLangDownload()
	else
		slot0:_setDoneFirstDownload()
		slot1(slot2)
	end
end

function slot0._startOneLangDownload(slot0)
	slot1, slot2 = next(slot0._lang2DownloadList)

	if slot1 and slot2 then
		slot0._downloadingList = slot2
		slot0._downloadUrl, slot0._downloadUrlBak = HotUpdateVoiceMgr.instance:getDownloadUrl(slot1)

		slot0._optionalUpdateInst:SetRemoteAssetUrl(slot0._downloadUrl, slot0._downloadUrlBak)

		slot3 = {}
		slot4 = {}
		slot5 = {}
		slot6 = {}

		for slot11, slot12 in ipairs(slot2) do
			table.insert(slot3, slot12.name)
			table.insert(slot4, slot12.hash)
			table.insert(slot5, slot12.order)
			table.insert(slot6, slot12.length)

			slot7 = nil or string.splitToNumber(slot12.latest_ver, ".")[2] or 0
		end

		slot0._optionalUpdateInst:StartDownload(slot1, slot3, slot4, slot5, slot6, slot7)

		slot0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

		slot0._eventMgrInst:AddLuaLisenter(SLFramework.GameUpdate.HotUpdateEvent.UnzipProgress, slot0._onUnzipProgress, slot0)
	else
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.NotEnoughDiskSpace)
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.DownloadStart)
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.DownloadProgressRefresh)
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.DownloadPackFail)
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.DownloadPackSuccess)
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.PackUnZipFail)
		slot0._optionalUpdateInst:UnRegister(slot0._optionalUpdate.PackItemStateChange)

		slot0._optionalUpdateInst = nil
		slot0._optionalUpdate = nil
		slot0._lang2DownloadList = nil
		slot0._downloadDict = nil

		slot0:_setDoneFirstDownload()
		slot0._onDownloadFinish(slot0._onDownloadFinishObj)

		if slot0._eventMgrInst then
			slot0._eventMgrInst:ClearLuaListener()

			slot0._eventMgrInst = nil
		end
	end
end

function slot0._setDoneFirstDownload(slot0)
	BootVoiceView.instance:setFirstDownloadDone()
end

function slot0._onDownloadStart(slot0, slot1, slot2, slot3)
	slot0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	logNormal("VoiceDownloader:_onDownloadStart, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)

	slot3 = tonumber(tostring(slot3))
	slot0._downloadSize = tonumber(tostring(slot2)) + slot0._downloadSuccSize

	slot0:statHotUpdate(0, slot0._downloadSize)
end

function slot0._onDownloadProgressRefresh(slot0, slot1, slot2, slot3)
	slot2 = tonumber(tostring(slot2))
	slot3 = tonumber(tostring(slot3))
	slot4 = not slot0._prevSize or slot2 ~= slot0._prevSize
	slot0._prevSize = slot2

	if HotUpdateMgr.instance:getFailCount() > 0 and slot4 then
		SDKDataTrackMgr.instance:trackDomainFailCount("scene_voice_srcdownload", string.match(HotUpdateMgr.instance:getUseBackup() and slot0._downloadUrlBak or slot0._downloadUrl, "(https?://[^/]+)"), HotUpdateMgr.instance:getFailCount())
		HotUpdateMgr.instance:resetFailCount()
	end

	logNormal("VoiceDownloader:_onDownloadProgressRefresh, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)

	slot5 = slot2 + slot0._downloadSuccSize
	slot0._downloadSize = slot5
	slot6 = slot5 / slot0._totalSize
	slot7 = slot0:_fixSizeStr(slot5)
	slot8 = slot0:_fixSizeStr(slot0._totalSize)
	slot9 = nil
	slot0._downProgressS1 = slot7
	slot0._downProgressS2 = slot8

	if slot4 then
		BootLoadingView.instance:show(slot6, (UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("download_info_wifi"), slot7, slot8)) and string.format(booterLang("download_info"), slot7, slot8))
	end

	slot0:statHotUpdate(slot6, slot5)
end

function slot0.statHotUpdate(slot0, slot1, slot2)
	for slot6 = slot0._nowStatHotUpdatePerIndex, slot0._statHotUpdatePerNum do
		if slot0._statHotUpdatePerList[slot6][1] <= slot1 or slot8 == 1 and slot0._totalSize - slot2 < 1024 then
			SDKDataTrackMgr.instance:trackVoicePackDownloading({
				step = slot7[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - slot0._downLoadStartTime,
				update_amount = slot0:_fixSizeMB(slot0._totalSize - slot2),
				download_voice_pack_list = slot0._download_voice_pack_list
			})

			slot0._nowStatHotUpdatePerIndex = slot6 + 1
		else
			break
		end
	end
end

function slot0._onPackItemStateChange(slot0, slot1)
	logNormal("VoiceDownloader:_onPackItemStateChange, packName = " .. slot1)
end

function slot0._onDownloadPackSuccess(slot0, slot1)
	logNormal("VoiceDownloader:_onDownloadPackSuccess, packName = " .. slot1)

	if slot0._downloadingList then
		for slot5, slot6 in ipairs(slot0._downloadingList) do
			slot0._downloadSuccSize = slot0._downloadSuccSize + slot6.length
		end
	end

	slot0._downloadSize = slot0._downloadSuccSize
	slot0._lang2DownloadList[slot1] = nil
	slot0._downloadingList = nil

	slot0:_startOneLangDownload()
end

function slot0._setUseReserveUrl(slot0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")
	tolua.getfield(typeof(SLFramework.GameUpdate.OptionalUpdate), "_useReserveUrl", 36):Set(SLFramework.GameUpdate.OptionalUpdate.Instance, HotUpdateMgr.instance:getUseBackup())
end

function slot0._onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
	logNormal("VoiceDownloader:_onDownloadPackFail, packName = " .. slot1 .. " resUrl = " .. slot2 .. " failError = " .. slot3)

	if slot3 == 5 then
		slot0:_onNotEnoughDiskSpace(slot1)
	else
		HotUpdateMgr.instance:inverseUseBackup()
		slot0:_setUseReserveUrl()
		HotUpdateMgr.instance:incFailCount()

		if HotUpdateMgr.instance:isFailNeedAlert() then
			HotUpdateMgr.instance:resetFailAlertCount()
			BootMsgBox.instance:show({
				title = booterLang("hotupdate"),
				content = slot0:_getDownloadFailedTip(slot3, slot4),
				leftMsg = booterLang("exit"),
				leftCb = slot0._quitGame,
				leftCbObj = slot0,
				rightMsg = booterLang("retry"),
				rightCb = slot0._retry,
				rightCbObj = slot0
			})
		else
			logNormal("VoiceDownloader 静默重试下载！")
			slot0:_retry()
			HotUpdateMgr.instance:showConnectTips()
		end
	end

	SDKDataTrackMgr.instance:trackVoicePackDownloading({
		step = "fail",
		spend_time = math.floor(Time.realtimeSinceStartup * 1000) - slot0._downLoadStartTime,
		result_msg = slot0:_getDownloadFailedTip(slot3, slot4),
		download_voice_pack_list = slot0._download_voice_pack_list,
		update_amount = slot0:_fixSizeMB(slot0._totalSize - slot0._downloadSize)
	})
end

function slot0._onNotEnoughDiskSpace(slot0, slot1)
	logNormal("VoiceDownloader:_onNotEnoughDiskSpace, packName = " .. slot1)
	BootMsgBox.instance:show({
		title = booterLang("hotupdate"),
		content = booterLang("download_fail_no_enough_disk"),
		rightMsg = booterLang("exit"),
		rightCb = slot0._quitGame,
		rightCbObj = slot0
	})
end

function slot0._onPackUnZipFail(slot0, slot1, slot2)
	if slot1 then
		logNormal("VoiceDownloader:_onPackUnZipFail, packName = " .. slot1 .. " failReason = " .. slot2)
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = slot0:_getUnzipFailedTip(slot2),
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0._retry,
			rightCbObj = slot0
		})
	end
end

function slot0._quitGame(slot0)
	ProjBooter.instance:quitGame()
end

function slot0._retry(slot0)
	slot0._optionalUpdateInst:RunNextStepAction()
end

function slot0._onUnzipProgress(slot0, slot1)
	logNormal("正在解压语音包，请稍后... progress = " .. slot1)

	if tostring(slot1) == "nan" then
		return
	end

	slot2 = slot0._downProgressS1 or ""
	slot3 = slot0._downProgressS2 or ""
	slot4 = math.floor(100 * slot1 + 0.5)
	slot5 = nil

	BootLoadingView.instance:setProgressMsg((UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("unziping_progress_wifi"), tostring(slot4), slot2, slot3)) and string.format(booterLang("unziping_progress"), tostring(slot4), slot2, slot3))
end

function slot0.cancelDownload(slot0)
	if slot0._optionalUpdateInst then
		slot0._optionalUpdateInst:StopDownload()

		slot0._errorCode = nil
	end
end

function slot0._getDownloadFailedTip(slot0, slot1, slot2)
	slot0._errorCode = SLFramework.GameUpdate.FailError.IntToEnum(slot1)
	slot2 = slot2 or ""

	if slot1 == slot3.DownloadErrer then
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
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(slot2)
	end
end

function slot0._getUnzipFailedTip(slot0, slot1)
	slot2 = SLFramework.GameUpdate.UnzipStatus

	if slot2.IntToEnum(slot1) == slot2.Running then
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

function slot0._fixSizeStr(slot0, slot1)
	slot3 = "MB"

	if slot1 / HotUpdateMgr.MB_SIZE < 1 then
		slot3 = "KB"

		if slot1 / HotUpdateMgr.KB_SIZE < 0.01 then
			slot2 = 0.01
		end
	end

	return string.format("%.2f %s", slot2 - slot2 % 0.01, slot3)
end

function slot0._fixSizeMB(slot0, slot1)
	if slot1 / HotUpdateMgr.MB_SIZE < 0.001 then
		return 0.001
	end

	return slot2 - slot2 % 0.001
end

return slot0
