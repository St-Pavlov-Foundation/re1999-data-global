module("projbooter.hotupdate.optionpackage.OptionPackageDownloader", package.seeall)

local var_0_0 = class("OptionPackageDownloader")
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

function var_0_0.start(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._adppter = arg_1_4

	local var_1_0 = arg_1_1 or {}

	arg_1_0._lang2DownloadList = {}
	arg_1_0._download_pack_list = {}
	arg_1_0._totalSize = 0

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1 and iter_1_1.res and #iter_1_1.res > 0 then
			arg_1_0._lang2DownloadList[iter_1_0] = iter_1_1

			table.insert(arg_1_0._download_pack_list, iter_1_0)

			for iter_1_2, iter_1_3 in ipairs(iter_1_1.res) do
				arg_1_0._totalSize = arg_1_0._totalSize + iter_1_3.length
			end
		end
	end

	arg_1_0._statHotUpdatePerList = {}
	arg_1_0._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	arg_1_0._statHotUpdatePerList[2] = {
		0.5,
		"50%"
	}
	arg_1_0._statHotUpdatePerList[3] = {
		1,
		"100%"
	}
	arg_1_0._statHotUpdatePerNum = #arg_1_0._statHotUpdatePerList
	arg_1_0._nowStatHotUpdatePerIndex = 1
	arg_1_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	arg_1_0._downloadSize = 0

	if arg_1_0._totalSize > 0 then
		arg_1_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		arg_1_0._optionalUpdateInst = arg_1_0._optionalUpdate.Instance

		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.NotEnoughDiskSpace, arg_1_0._onNotEnoughDiskSpace, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadStart, arg_1_0._onDownloadStart, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadProgressRefresh, arg_1_0._onDownloadProgressRefresh, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadPackFail, arg_1_0._onDownloadPackFail, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.DownloadPackSuccess, arg_1_0._onDownloadPackSuccess, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.PackUnZipFail, arg_1_0._onPackUnZipFail, arg_1_0)
		arg_1_0._optionalUpdateInst:Register(arg_1_0._optionalUpdate.PackItemStateChange, arg_1_0._onPackItemStateChange, arg_1_0)

		arg_1_0._onDownloadFinish = arg_1_2
		arg_1_0._onDownloadFinishObj = arg_1_3
		arg_1_0._downloadSuccSize = 0

		arg_1_0:_startOneLangDownload()
		arg_1_0:_checkAdppterFuncNames()
	else
		arg_1_2(arg_1_3)
	end
end

function var_0_0._startOneLangDownload(arg_2_0)
	local var_2_0, var_2_1 = next(arg_2_0._lang2DownloadList)

	if var_2_0 and var_2_1 and var_2_1.res then
		logNormal("OptionPackageDownloader:_startOneLangDownload, start download packName = " .. var_2_0)

		arg_2_0._downloadingList = {}

		tabletool.addValues(arg_2_0._downloadingList, var_2_1.res)
		arg_2_0._optionalUpdateInst:SetRemoteAssetUrl(var_2_1.download_url, var_2_1.download_url_bak)

		local var_2_2 = {}
		local var_2_3 = {}
		local var_2_4 = {}
		local var_2_5 = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_1.res) do
			table.insert(var_2_2, iter_2_1.name)
			table.insert(var_2_3, iter_2_1.hash)
			table.insert(var_2_4, iter_2_1.order)
			table.insert(var_2_5, iter_2_1.length)
		end

		local var_2_6 = string.splitToNumber(var_2_1.latest_ver, ".")[2] or 0

		arg_2_0._optionalUpdateInst:StartDownload(var_2_0, var_2_2, var_2_3, var_2_4, var_2_5, var_2_6)

		arg_2_0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

		arg_2_0._eventMgrInst:AddLuaLisenter(SLFramework.GameUpdate.HotUpdateEvent.UnzipProgress, arg_2_0._onUnzipProgress, arg_2_0)
	else
		logNormal("OptionPackageDownloader:_startOneLangDownload, download finish all")
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

		arg_2_0._onDownloadFinish(arg_2_0._onDownloadFinishObj)

		if arg_2_0._eventMgrInst then
			arg_2_0._eventMgrInst:ClearLuaListener()

			arg_2_0._eventMgrInst = nil
		end
	end
end

function var_0_0._onDownloadStart(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	logNormal("OptionPackageDownloader:_onDownloadStart, packName = " .. arg_3_1 .. " curSize = " .. arg_3_2 .. " allSize = " .. arg_3_3)

	arg_3_2 = tonumber(tostring(arg_3_2))
	arg_3_3 = tonumber(tostring(arg_3_3))
	arg_3_0._downloadSize = arg_3_2 + arg_3_0._downloadSuccSize

	arg_3_0:_callAdppterFunc(var_0_1.DownloadStart, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:statHotUpdate(0, arg_3_0._downloadSize)
end

function var_0_0._onDownloadProgressRefresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_2 = tonumber(tostring(arg_4_2))
	arg_4_3 = tonumber(tostring(arg_4_3))

	logNormal("OptionPackageDownloader:_onDownloadProgressRefresh, packName = " .. arg_4_1 .. " curSize = " .. arg_4_2 .. " allSize = " .. arg_4_3)

	local var_4_0 = arg_4_2 + arg_4_0._downloadSuccSize

	arg_4_0._downloadSize = var_4_0

	local var_4_1 = var_4_0 / arg_4_0._totalSize

	arg_4_0:_callAdppterFunc(var_0_1.DownloadProgressRefresh, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:statHotUpdate(var_4_1, var_4_0)
end

function var_0_0.statHotUpdate(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0 = arg_5_0._nowStatHotUpdatePerIndex, arg_5_0._statHotUpdatePerNum do
		local var_5_0 = arg_5_0._statHotUpdatePerList[iter_5_0]
		local var_5_1 = var_5_0[1]

		if var_5_1 <= arg_5_1 or var_5_1 == 1 and arg_5_0._totalSize - arg_5_2 < 1024 then
			local var_5_2 = {
				step = var_5_0[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_5_0._downLoadStartTime,
				update_amount = arg_5_0:_fixSizeMB(arg_5_0._totalSize - arg_5_2),
				resource_type = arg_5_0._download_pack_list
			}

			SDKDataTrackMgr.instance:trackOptionPackDownloading(var_5_2)

			arg_5_0._nowStatHotUpdatePerIndex = iter_5_0 + 1
		else
			break
		end
	end
end

function var_0_0._onPackItemStateChange(arg_6_0, arg_6_1)
	logNormal("OptionPackageDownloader:_onPackItemStateChange, packName = " .. arg_6_1)
	arg_6_0:_callAdppterFunc(var_0_1.PackItemStateChange, arg_6_1)
end

function var_0_0._onDownloadPackSuccess(arg_7_0, arg_7_1)
	logNormal("OptionPackageDownloader:_onDownloadPackSuccess, packName = " .. arg_7_1)

	if arg_7_0._downloadingList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._downloadingList) do
			arg_7_0._downloadSuccSize = arg_7_0._downloadSuccSize + iter_7_1.length
		end
	end

	arg_7_0._downloadSize = arg_7_0._downloadSuccSize
	arg_7_0._lang2DownloadList[arg_7_1] = nil
	arg_7_0._downloadingList = nil

	arg_7_0:_callAdppterFunc(var_0_1.DownloadPackSuccess, arg_7_1)
	Timer.New(function()
		arg_7_0:_startOneLangDownload()
	end, 0.2):Start()
end

function var_0_0._onDownloadPackFail(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	logNormal("OptionPackageDownloader:_onDownloadPackFail, packName = " .. arg_9_1 .. " resUrl = " .. arg_9_2 .. " failError = " .. arg_9_3)
	arg_9_0:_callAdppterFunc(var_0_1.DownloadPackFail, arg_9_1, arg_9_2, arg_9_3, arg_9_4)

	local var_9_0 = {}

	var_9_0.step = "fail"
	var_9_0.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_9_0._downLoadStartTime
	var_9_0.result_msg = arg_9_0:_getDownloadFailedTip(arg_9_3, arg_9_4)
	var_9_0.update_amount = arg_9_0:_fixSizeMB(arg_9_0._totalSize - arg_9_0._downloadSize)
	var_9_0.resource_type = arg_9_0._download_pack_list

	SDKDataTrackMgr.instance:trackOptionPackDownloading(var_9_0)
end

function var_0_0._onNotEnoughDiskSpace(arg_10_0, arg_10_1)
	arg_10_0:_callAdppterFunc(var_0_1.NotEnoughDiskSpace, arg_10_1)
end

function var_0_0.getDownloadSize(arg_11_0)
	return arg_11_0._downloadSize
end

function var_0_0.getTotalSize(arg_12_0)
	return arg_12_0._totalSize
end

function var_0_0.getDownloadSuccSize(arg_13_0)
	return arg_13_0._downloadSuccSize
end

function var_0_0._callAdppterFunc(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_0._adppter and arg_14_0._adppter[arg_14_1] then
		arg_14_0._adppter[arg_14_1](arg_14_0._adppter, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	end
end

function var_0_0._checkAdppterFuncNames(arg_15_0)
	if arg_15_0._adppter then
		for iter_15_0, iter_15_1 in pairs(var_0_1) do
			if not arg_15_0._adppter[iter_15_1] then
				logWarn(string.format("class : [%s], can not find function : [%s]", arg_15_0._adppter.__cname or "nil", iter_15_1))
			end
		end
	end
end

function var_0_0._onPackUnZipFail(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:_callAdppterFunc(var_0_1.PackUnZipFail, arg_16_1, arg_16_2)
end

function var_0_0._quitGame(arg_17_0)
	ProjBooter.instance:quitGame()
end

function var_0_0.retry(arg_18_0)
	arg_18_0._optionalUpdateInst:RunNextStepAction()
end

function var_0_0._onUnzipProgress(arg_19_0, arg_19_1)
	logNormal("正在解压独立资源包，请稍后... progress = " .. arg_19_1)

	if tostring(arg_19_1) == "nan" then
		return
	end

	arg_19_0:_callAdppterFunc(var_0_1.UnzipProgress, arg_19_1)
end

function var_0_0.cancelDownload(arg_20_0)
	if arg_20_0._optionalUpdateInst then
		arg_20_0._optionalUpdateInst:StopDownload()

		arg_20_0._errorCode = nil
	end
end

function var_0_0._getDownloadFailedTip(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._errorCode = arg_21_1

	return var_0_0.getDownloadFailedTip(arg_21_1, arg_21_2)
end

function var_0_0._getUnzipFailedTip(arg_22_0, arg_22_1)
	return var_0_0.getUnzipFailedTip(arg_22_1)
end

function var_0_0._fixSizeStr(arg_23_0, arg_23_1)
	return HotUpdateMgr.fixSizeStr(arg_23_1)
end

function var_0_0._fixSizeMB(arg_24_0, arg_24_1)
	return HotUpdateMgr.fixSizeMB(arg_24_1)
end

function var_0_0.getDownloadFailedTip(arg_25_0, arg_25_1)
	local var_25_0 = SLFramework.GameUpdate.FailError

	arg_25_0 = var_25_0.IntToEnum(arg_25_0)
	arg_25_1 = arg_25_1 or ""

	if arg_25_0 == var_25_0.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif arg_25_0 == var_25_0.NotFound then
		return booterLang("download_fail_not_found")
	elseif arg_25_0 == var_25_0.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif arg_25_0 == var_25_0.TimeOut then
		return booterLang("download_fail_time_out")
	elseif arg_25_0 == var_25_0.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif arg_25_0 == var_25_0.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(arg_25_1)
	end
end

function var_0_0.getUnzipFailedTip(arg_26_0)
	local var_26_0 = SLFramework.GameUpdate.UnzipStatus

	arg_26_0 = var_26_0.IntToEnum(arg_26_0)

	if arg_26_0 == var_26_0.Running then
		return booterLang("unpack_error_running")
	elseif arg_26_0 == var_26_0.Done then
		return booterLang("unpack_error_done")
	elseif arg_26_0 == var_26_0.FileNotFound then
		return booterLang("unpack_error_file_not_found")
	elseif arg_26_0 == var_26_0.NotEnoughSpace then
		return booterLang("unpack_error_not_enough_space")
	elseif arg_26_0 == var_26_0.ThreadAbort then
		return booterLang("unpack_error_thread_abort")
	elseif arg_26_0 == var_26_0.Exception then
		return booterLang("unpack_error_exception")
	else
		return booterLang("unpack_error_unknown")
	end
end

return var_0_0
