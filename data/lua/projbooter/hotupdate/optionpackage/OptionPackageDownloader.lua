module("projbooter.hotupdate.optionpackage.OptionPackageDownloader", package.seeall)

slot0 = class("OptionPackageDownloader")
slot1 = {
	DownloadStart = "onDownloadStart",
	DownloadProgressRefresh = "onDownloadProgressRefresh",
	DownloadPackFail = "onDownloadPackFail",
	PackUnZipFail = "onPackUnZipFail",
	PackItemStateChange = "onPackItemStateChange",
	DownloadPackSuccess = "onDownloadPackSuccess",
	UnzipProgress = "onUnzipProgress",
	NotEnoughDiskSpace = "onNotEnoughDiskSpace"
}

function slot0.start(slot0, slot1, slot2, slot3, slot4)
	slot0._adppter = slot4
	slot0._lang2DownloadList = {}
	slot0._download_pack_list = {}
	slot0._totalSize = 0

	for slot9, slot10 in pairs(slot1 or {}) do
		if slot10 and slot10.res and #slot10.res > 0 then
			slot0._lang2DownloadList[slot9] = slot10
			slot14 = slot9

			table.insert(slot0._download_pack_list, slot14)

			for slot14, slot15 in ipairs(slot10.res) do
				slot0._totalSize = slot0._totalSize + slot15.length
			end
		end
	end

	slot0._statHotUpdatePerList = {
		{
			0,
			"start"
		},
		{
			0.5,
			"50%"
		},
		{
			1,
			"100%"
		}
	}
	slot0._statHotUpdatePerNum = #slot0._statHotUpdatePerList
	slot0._nowStatHotUpdatePerIndex = 1
	slot0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	slot0._downloadSize = 0

	if slot0._totalSize > 0 then
		slot0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		slot0._optionalUpdateInst = slot0._optionalUpdate.Instance

		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.NotEnoughDiskSpace, slot0._onNotEnoughDiskSpace, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadStart, slot0._onDownloadStart, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadProgressRefresh, slot0._onDownloadProgressRefresh, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackFail, slot0._onDownloadPackFail, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackSuccess, slot0._onDownloadPackSuccess, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackUnZipFail, slot0._onPackUnZipFail, slot0)
		slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackItemStateChange, slot0._onPackItemStateChange, slot0)

		slot0._onDownloadFinish = slot2
		slot0._onDownloadFinishObj = slot3
		slot0._downloadSuccSize = 0

		slot0:_startOneLangDownload()
		slot0:_checkAdppterFuncNames()
	else
		slot2(slot3)
	end
end

function slot0._startOneLangDownload(slot0)
	slot1, slot2 = next(slot0._lang2DownloadList)

	if slot1 and slot2 and slot2.res then
		logNormal("OptionPackageDownloader:_startOneLangDownload, start download packName = " .. slot1)

		slot0._downloadingList = {}

		tabletool.addValues(slot0._downloadingList, slot2.res)
		slot0._optionalUpdateInst:SetRemoteAssetUrl(slot2.download_url, slot2.download_url_bak)

		slot3 = {}
		slot4 = {}
		slot5 = {}
		slot6 = {}

		for slot10, slot11 in ipairs(slot2.res) do
			table.insert(slot3, slot11.name)
			table.insert(slot4, slot11.hash)
			table.insert(slot5, slot11.order)
			table.insert(slot6, slot11.length)
		end

		slot0._optionalUpdateInst:StartDownload(slot1, slot3, slot4, slot5, slot6, string.splitToNumber(slot2.latest_ver, ".")[2] or 0)

		slot0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

		slot0._eventMgrInst:AddLuaLisenter(SLFramework.GameUpdate.HotUpdateEvent.UnzipProgress, slot0._onUnzipProgress, slot0)
	else
		logNormal("OptionPackageDownloader:_startOneLangDownload, download finish all")
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

		slot0._onDownloadFinish(slot0._onDownloadFinishObj)

		if slot0._eventMgrInst then
			slot0._eventMgrInst:ClearLuaListener()

			slot0._eventMgrInst = nil
		end
	end
end

function slot0._onDownloadStart(slot0, slot1, slot2, slot3)
	slot0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	logNormal("OptionPackageDownloader:_onDownloadStart, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)

	slot2 = tonumber(tostring(slot2))
	slot0._downloadSize = slot2 + slot0._downloadSuccSize

	slot0:_callAdppterFunc(uv0.DownloadStart, slot1, slot2, tonumber(tostring(slot3)))
	slot0:statHotUpdate(0, slot0._downloadSize)
end

function slot0._onDownloadProgressRefresh(slot0, slot1, slot2, slot3)
	slot2 = tonumber(tostring(slot2))
	slot3 = tonumber(tostring(slot3))

	logNormal("OptionPackageDownloader:_onDownloadProgressRefresh, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)

	slot4 = slot2 + slot0._downloadSuccSize
	slot0._downloadSize = slot4

	slot0:_callAdppterFunc(uv0.DownloadProgressRefresh, slot1, slot2, slot3)
	slot0:statHotUpdate(slot4 / slot0._totalSize, slot4)
end

function slot0.statHotUpdate(slot0, slot1, slot2)
	for slot6 = slot0._nowStatHotUpdatePerIndex, slot0._statHotUpdatePerNum do
		if slot0._statHotUpdatePerList[slot6][1] <= slot1 or slot8 == 1 and slot0._totalSize - slot2 < 1024 then
			SDKDataTrackMgr.instance:trackOptionPackDownloading({
				step = slot7[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - slot0._downLoadStartTime,
				update_amount = slot0:_fixSizeMB(slot0._totalSize - slot2),
				resource_type = slot0._download_pack_list
			})

			slot0._nowStatHotUpdatePerIndex = slot6 + 1
		else
			break
		end
	end
end

function slot0._onPackItemStateChange(slot0, slot1)
	logNormal("OptionPackageDownloader:_onPackItemStateChange, packName = " .. slot1)
	slot0:_callAdppterFunc(uv0.PackItemStateChange, slot1)
end

function slot0._onDownloadPackSuccess(slot0, slot1)
	logNormal("OptionPackageDownloader:_onDownloadPackSuccess, packName = " .. slot1)

	if slot0._downloadingList then
		for slot5, slot6 in ipairs(slot0._downloadingList) do
			slot0._downloadSuccSize = slot0._downloadSuccSize + slot6.length
		end
	end

	slot0._downloadSize = slot0._downloadSuccSize
	slot0._lang2DownloadList[slot1] = nil
	slot0._downloadingList = nil

	slot0:_callAdppterFunc(uv0.DownloadPackSuccess, slot1)
	Timer.New(function ()
		uv0:_startOneLangDownload()
	end, 0.2):Start()
end

function slot0._onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
	logNormal("OptionPackageDownloader:_onDownloadPackFail, packName = " .. slot1 .. " resUrl = " .. slot2 .. " failError = " .. slot3)
	slot0:_callAdppterFunc(uv0.DownloadPackFail, slot1, slot2, slot3, slot4)
	SDKDataTrackMgr.instance:trackOptionPackDownloading({
		step = "fail",
		spend_time = math.floor(Time.realtimeSinceStartup * 1000) - slot0._downLoadStartTime,
		result_msg = slot0:_getDownloadFailedTip(slot3, slot4),
		update_amount = slot0:_fixSizeMB(slot0._totalSize - slot0._downloadSize),
		resource_type = slot0._download_pack_list
	})
end

function slot0._onNotEnoughDiskSpace(slot0, slot1)
	slot0:_callAdppterFunc(uv0.NotEnoughDiskSpace, slot1)
end

function slot0.getDownloadSize(slot0)
	return slot0._downloadSize
end

function slot0.getTotalSize(slot0)
	return slot0._totalSize
end

function slot0.getDownloadSuccSize(slot0)
	return slot0._downloadSuccSize
end

function slot0._callAdppterFunc(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._adppter and slot0._adppter[slot1] then
		slot0._adppter[slot1](slot0._adppter, slot2, slot3, slot4, slot5)
	end
end

function slot0._checkAdppterFuncNames(slot0)
	if slot0._adppter then
		for slot4, slot5 in pairs(uv0) do
			if not slot0._adppter[slot5] then
				logWarn(string.format("class : [%s], can not find function : [%s]", slot0._adppter.__cname or "nil", slot5))
			end
		end
	end
end

function slot0._onPackUnZipFail(slot0, slot1, slot2)
	slot0:_callAdppterFunc(uv0.PackUnZipFail, slot1, slot2)
end

function slot0._quitGame(slot0)
	ProjBooter.instance:quitGame()
end

function slot0.retry(slot0)
	slot0._optionalUpdateInst:RunNextStepAction()
end

function slot0._onUnzipProgress(slot0, slot1)
	logNormal("正在解压独立资源包，请稍后... progress = " .. slot1)

	if tostring(slot1) == "nan" then
		return
	end

	slot0:_callAdppterFunc(uv0.UnzipProgress, slot1)
end

function slot0.cancelDownload(slot0)
	if slot0._optionalUpdateInst then
		slot0._optionalUpdateInst:StopDownload()

		slot0._errorCode = nil
	end
end

function slot0._getDownloadFailedTip(slot0, slot1, slot2)
	slot0._errorCode = slot1

	return uv0.getDownloadFailedTip(slot1, slot2)
end

function slot0._getUnzipFailedTip(slot0, slot1)
	return uv0.getUnzipFailedTip(slot1)
end

function slot0._fixSizeStr(slot0, slot1)
	return HotUpdateMgr.fixSizeStr(slot1)
end

function slot0._fixSizeMB(slot0, slot1)
	return HotUpdateMgr.fixSizeMB(slot1)
end

function slot0.getDownloadFailedTip(slot0, slot1)
	slot1 = slot1 or ""

	if SLFramework.GameUpdate.FailError.IntToEnum(slot0) == slot2.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif slot0 == slot2.NotFound then
		return booterLang("download_fail_not_found")
	elseif slot0 == slot2.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif slot0 == slot2.TimeOut then
		return booterLang("download_fail_time_out")
	elseif slot0 == slot2.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif slot0 == slot2.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(slot1)
	end
end

function slot0.getUnzipFailedTip(slot0)
	slot1 = SLFramework.GameUpdate.UnzipStatus

	if slot1.IntToEnum(slot0) == slot1.Running then
		return booterLang("unpack_error_running")
	elseif slot0 == slot1.Done then
		return booterLang("unpack_error_done")
	elseif slot0 == slot1.FileNotFound then
		return booterLang("unpack_error_file_not_found")
	elseif slot0 == slot1.NotEnoughSpace then
		return booterLang("unpack_error_not_enough_space")
	elseif slot0 == slot1.ThreadAbort then
		return booterLang("unpack_error_thread_abort")
	elseif slot0 == slot1.Exception then
		return booterLang("unpack_error_exception")
	else
		return booterLang("unpack_error_unknown")
	end
end

return slot0
