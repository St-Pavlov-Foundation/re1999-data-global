module("modules.logic.optionpackage.adapter.DownloadOptPackAdapter", package.seeall)

local var_0_0 = class("DownloadOptPackAdapter", OptionPackageBaseAdapter)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._langList = {}

	tabletool.addValues(arg_1_0._langList, arg_1_1)
end

function var_0_0.getHttpGetterList(arg_2_0)
	return {}
end

function var_0_0.getDownloadList(arg_3_0)
	if arg_3_0._httpWorker then
		return arg_3_0._httpWorker:getHttpResult()
	end
end

function var_0_0.onDownloadProgressRefresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	logNormal("DownloadOptPackAdapter:onDownloadProgressRefresh, packName = " .. arg_4_1 .. " curSize = " .. arg_4_2 .. " allSize = " .. arg_4_3)

	local var_4_0 = arg_4_0._downloader:getDownloadSize() or 0
	local var_4_1 = arg_4_0._downloader:getTotalSize()

	OptionPackageModel.instance:setDownloadProgress(arg_4_1, arg_4_2, arg_4_3)
	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownloadProgressRefresh, arg_4_1, var_4_0, var_4_1)
end

function var_0_0.onDownloadPackSuccess(arg_5_0, arg_5_1)
	logNormal("包体下载成功, packName = " .. arg_5_1)
	OptionPackageModel.instance:onDownloadSucc(arg_5_1)
end

function var_0_0.onDownloadPackFail(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_3 == 5 then
		arg_6_0:onNotEnoughDiskSpace(arg_6_1)
	else
		local var_6_0 = OptionPackageDownloader.getDownloadFailedTip(arg_6_3, arg_6_4)

		logNormal("下载失败, packName = " .. arg_6_1 .. " " .. var_6_0)
		arg_6_0:_showErrorMsgBox(string.format("%s(%s)", var_6_0, arg_6_1))
	end
end

function var_0_0.onNotEnoughDiskSpace(arg_7_0, arg_7_1)
	logNormal("sdk空间不足下载失败, packName = " .. arg_7_1)

	local var_7_0 = booterLang("download_fail_no_enough_disk")

	arg_7_0:_showErrorMsgBox(string.format("%s(%s)", var_7_0, arg_7_1))
end

function var_0_0.onUnzipProgress(arg_8_0, arg_8_1)
	if tostring(arg_8_1) == "nan" then
		return
	end

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.UnZipProgressRefresh, arg_8_1)
end

function var_0_0.onPackUnZipFail(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		local var_9_0 = OptionPackageDownloader.getUnzipFailedTip(arg_9_2)

		logNormal(var_9_0)
		arg_9_0:_showErrorMsgBox(var_9_0)
	end
end

function var_0_0._retryDownload(arg_10_0)
	if arg_10_0._downloader then
		arg_10_0._downloader:retry()
	end
end

function var_0_0._exitDownload(arg_11_0)
	if arg_11_0._downloader then
		arg_11_0._downloader:cancelDownload()
	end

	OptionPackageController.instance:stopDownload()
end

function var_0_0._showErrorMsgBox(arg_12_0, arg_12_1)
	local var_12_0 = MessageBoxIdDefine.OptPackDownloadError
	local var_12_1 = MsgBoxEnum.BoxType.Yes_No
	local var_12_2 = booterLang("retry")
	local var_12_3 = "RETRY"
	local var_12_4 = booterLang("exit")
	local var_12_5 = "CANCEL"
	local var_12_6 = arg_12_0._retryDownload
	local var_12_7 = arg_12_0._exitDownload
	local var_12_8 = {
		msg = MessageBoxConfig.instance:getMessage(var_12_0),
		msgBoxType = var_12_1,
		yesCallback = var_12_6,
		noCallback = var_12_7,
		yesCallbackObj = arg_12_0,
		noCallbackObj = arg_12_0,
		yesStr = var_12_2,
		noStr = var_12_4,
		yesStrEn = var_12_3,
		noStrEn = var_12_5,
		extra = arg_12_1
	}

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownladErrorMsg, var_12_8)
end

local var_0_1 = {
	DownloadStart = "onDownloadStart",
	DownloadProgressRefresh = "onDownloadProgressRefresh",
	DownloadPackFail = "onDownloadPackFail",
	PackUnZipFail = "onPackUnZipFail",
	PackItemStateChange = "onPackItemStateChange",
	DownloadPackSuccess = "onDownloadPackSuccess",
	UnzipProgress = "onUnzipProgress",
	NotEnoughDiskSpace = "onNotEnoughDiskSpace"
}

function OptionPackageDownloader.start(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0._adppter = arg_13_4

	local var_13_0 = arg_13_1 or {}

	arg_13_0._lang2DownloadList = {}
	arg_13_0._download_pack_list = {}
	arg_13_0._totalSize = 0

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1 and iter_13_1.res and #iter_13_1.res > 0 then
			arg_13_0._lang2DownloadList[iter_13_0] = iter_13_1

			table.insert(arg_13_0._download_pack_list, iter_13_0)

			for iter_13_2, iter_13_3 in ipairs(iter_13_1.res) do
				arg_13_0._totalSize = arg_13_0._totalSize + iter_13_3.length
			end
		end
	end

	arg_13_0._statHotUpdatePerList = {}
	arg_13_0._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	arg_13_0._statHotUpdatePerList[2] = {
		0.5,
		"50%"
	}
	arg_13_0._statHotUpdatePerList[3] = {
		1,
		"100%"
	}
	arg_13_0._statHotUpdatePerNum = #arg_13_0._statHotUpdatePerList
	arg_13_0._nowStatHotUpdatePerIndex = 1
	arg_13_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	arg_13_0._downloadSize = 0

	if arg_13_0._totalSize > 0 then
		arg_13_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		arg_13_0._optionalUpdateInst = arg_13_0._optionalUpdate.Instance

		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.NotEnoughDiskSpace, arg_13_0._onNotEnoughDiskSpace, arg_13_0)
		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.DownloadStart, arg_13_0._onDownloadStart, arg_13_0)
		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.DownloadProgressRefresh, arg_13_0._onDownloadProgressRefresh, arg_13_0)
		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.DownloadPackFail, arg_13_0._onDownloadPackFail, arg_13_0)
		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.DownloadPackSuccess, arg_13_0._onDownloadPackSuccess, arg_13_0)
		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.PackUnZipFail, arg_13_0._onPackUnZipFail, arg_13_0)
		arg_13_0._optionalUpdateInst:Register(arg_13_0._optionalUpdate.PackItemStateChange, arg_13_0._onPackItemStateChange, arg_13_0)

		arg_13_0._onDownloadFinish = arg_13_2
		arg_13_0._onDownloadFinishObj = arg_13_3
		arg_13_0._downloadSuccSize = 0

		arg_13_0:_startOneLangDownload()
		arg_13_0:_checkAdppterFuncNames()
	else
		arg_13_2(arg_13_3)
	end
end

function OptionPackageDownloader.statHotUpdate(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0 = arg_14_0._nowStatHotUpdatePerIndex, arg_14_0._statHotUpdatePerNum do
		local var_14_0 = arg_14_0._statHotUpdatePerList[iter_14_0]
		local var_14_1 = var_14_0[1]

		if var_14_1 <= arg_14_1 or var_14_1 == 1 and arg_14_0._totalSize - arg_14_2 < 1024 then
			local var_14_2 = {
				step = var_14_0[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_14_0._downLoadStartTime,
				update_amount = arg_14_0:_fixSizeMB(arg_14_0._totalSize - arg_14_2),
				resource_type = arg_14_0._download_pack_list
			}

			SDKDataTrackMgr.instance:trackOptionPackDownloading(var_14_2)

			arg_14_0._nowStatHotUpdatePerIndex = iter_14_0 + 1
		else
			break
		end
	end
end

function OptionPackageDownloader._onDownloadPackFail(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	logNormal("OptionPackageDownloader:_onDownloadPackFail, packName = " .. arg_15_1 .. " resUrl = " .. arg_15_2 .. " failError = " .. arg_15_3)
	arg_15_0:_callAdppterFunc(var_0_1.DownloadPackFail, arg_15_1, arg_15_2, arg_15_3, arg_15_4)

	local var_15_0 = {}

	var_15_0.step = "fail"
	var_15_0.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_15_0._downLoadStartTime
	var_15_0.result_msg = arg_15_0:_getDownloadFailedTip(arg_15_3, arg_15_4)
	var_15_0.update_amount = arg_15_0:_fixSizeMB(arg_15_0._totalSize - arg_15_0._downloadSize)
	var_15_0.resource_type = arg_15_0._download_pack_list

	SDKDataTrackMgr.instance:trackOptionPackDownloading(var_15_0)
end

return var_0_0
