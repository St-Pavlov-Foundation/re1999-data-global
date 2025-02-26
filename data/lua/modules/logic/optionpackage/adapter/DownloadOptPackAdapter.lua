module("modules.logic.optionpackage.adapter.DownloadOptPackAdapter", package.seeall)

slot0 = class("DownloadOptPackAdapter", OptionPackageBaseAdapter)

function slot0.ctor(slot0, slot1)
	slot0._langList = {}

	tabletool.addValues(slot0._langList, slot1)
end

function slot0.getHttpGetterList(slot0)
	return {}
end

function slot0.getDownloadList(slot0)
	if slot0._httpWorker then
		return slot0._httpWorker:getHttpResult()
	end
end

function slot0.onDownloadProgressRefresh(slot0, slot1, slot2, slot3)
	logNormal("DownloadOptPackAdapter:onDownloadProgressRefresh, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)
	OptionPackageModel.instance:setDownloadProgress(slot1, slot2, slot3)
	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownloadProgressRefresh, slot1, slot0._downloader:getDownloadSize() or 0, slot0._downloader:getTotalSize())
end

function slot0.onDownloadPackSuccess(slot0, slot1)
	logNormal("包体下载成功, packName = " .. slot1)
	OptionPackageModel.instance:onDownloadSucc(slot1)
end

function slot0.onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
	if slot3 == 5 then
		slot0:onNotEnoughDiskSpace(slot1)
	else
		slot5 = OptionPackageDownloader.getDownloadFailedTip(slot3, slot4)

		logNormal("下载失败, packName = " .. slot1 .. " " .. slot5)
		slot0:_showErrorMsgBox(string.format("%s(%s)", slot5, slot1))
	end
end

function slot0.onNotEnoughDiskSpace(slot0, slot1)
	logNormal("sdk空间不足下载失败, packName = " .. slot1)
	slot0:_showErrorMsgBox(string.format("%s(%s)", booterLang("download_fail_no_enough_disk"), slot1))
end

function slot0.onUnzipProgress(slot0, slot1)
	if tostring(slot1) == "nan" then
		return
	end

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.UnZipProgressRefresh, slot1)
end

function slot0.onPackUnZipFail(slot0, slot1, slot2)
	if slot1 then
		slot3 = OptionPackageDownloader.getUnzipFailedTip(slot2)

		logNormal(slot3)
		slot0:_showErrorMsgBox(slot3)
	end
end

function slot0._retryDownload(slot0)
	if slot0._downloader then
		slot0._downloader:retry()
	end
end

function slot0._exitDownload(slot0)
	if slot0._downloader then
		slot0._downloader:cancelDownload()
	end

	OptionPackageController.instance:stopDownload()
end

function slot0._showErrorMsgBox(slot0, slot1)
	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownladErrorMsg, {
		msg = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.OptPackDownloadError),
		msgBoxType = MsgBoxEnum.BoxType.Yes_No,
		yesCallback = slot0._retryDownload,
		noCallback = slot0._exitDownload,
		yesCallbackObj = slot0,
		noCallbackObj = slot0,
		yesStr = booterLang("retry"),
		noStr = booterLang("exit"),
		yesStrEn = "RETRY",
		noStrEn = "CANCEL",
		extra = slot1
	})
end

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

function OptionPackageDownloader.start(slot0, slot1, slot2, slot3, slot4)
	slot0._adppter = slot4
	slot0._lang2DownloadList = {}
	slot0._download_pack_list = {}
	slot0._totalSize = 0

	for slot9, slot10 in pairs(slot1 or {}) do
		if slot10 and slot10.res and #slot10.res > 0 then
			slot0._lang2DownloadList[slot9] = slot10

			table.insert(slot0._download_pack_list, slot9)

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

function OptionPackageDownloader.statHotUpdate(slot0, slot1, slot2)
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

function OptionPackageDownloader._onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
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

return slot0
