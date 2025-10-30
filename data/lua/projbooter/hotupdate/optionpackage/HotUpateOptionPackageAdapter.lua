module("projbooter.hotupdate.optionpackage.HotUpateOptionPackageAdapter", package.seeall)

local var_0_0 = class("HotUpateOptionPackageAdapter")

function var_0_0.ctor(arg_1_0)
	arg_1_0._downloadSuccSize = 0
end

function var_0_0.getHttpGetterList(arg_2_0)
	local var_2_0 = HotUpdateOptionPackageMgr.instance:getHotUpdateLangPacks()
	local var_2_1 = {}

	if var_2_0 and #var_2_0 > 0 then
		table.insert(var_2_1, OptionPackageHttpGetter.New(3, var_2_0))
	end

	return var_2_1
end

function var_0_0.setDownloder(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._downloader = arg_3_1
	arg_3_0._packageMgr = arg_3_2 or HotUpdateOptionPackageMgr.instance
end

function var_0_0._downloadRetry(arg_4_0)
	arg_4_0._downloader:retry()
end

function var_0_0._quitGame(arg_5_0)
	ProjBooter.instance:quitGame()
end

function var_0_0._fixSizeStr(arg_6_0, arg_6_1)
	return HotUpdateMgr.fixSizeStr(arg_6_1)
end

function var_0_0._fixSizeMB(arg_7_0, arg_7_1)
	return HotUpdateMgr.fixSizeMB(arg_7_1)
end

function var_0_0.onDownloadStart(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._nowPackSize = arg_8_3
end

function var_0_0.onDownloadProgressRefresh(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	logNormal("HotUpateOptionPackageAdapter:onDownloadProgressRefresh, packName = " .. arg_9_1 .. " curSize = " .. arg_9_2 .. " allSize = " .. arg_9_3)

	arg_9_2 = tonumber(tostring(arg_9_2))
	arg_9_3 = tonumber(tostring(arg_9_3))

	local var_9_0 = arg_9_0._downloader:getDownloadSize()
	local var_9_1 = arg_9_0._downloader:getTotalSize()
	local var_9_2 = var_9_0 / var_9_1
	local var_9_3 = arg_9_0:_fixSizeStr(var_9_0)
	local var_9_4 = arg_9_0:_fixSizeStr(var_9_1)

	arg_9_0._downProgressS1 = var_9_3
	arg_9_0._downProgressS2 = var_9_4

	local var_9_5

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_9_5 = string.format(booterLang("download_info_wifi"), var_9_3, var_9_4)
	else
		var_9_5 = string.format(booterLang("download_info"), var_9_3, var_9_4)
	end

	HotUpdateProgress.instance:setProgressDownloadOptionPackage(arg_9_2, arg_9_0._downloader:getDownloadSuccSize(), var_9_5)
end

function var_0_0.onDownloadPackSuccess(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDownloadPackFail(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_3 == 5 then
		arg_11_0:onNotEnoughDiskSpace(arg_11_1)
	else
		local var_11_0 = {
			title = booterLang("hotupdate"),
			content = OptionPackageDownloader.getDownloadFailedTip(arg_11_3, arg_11_4),
			leftMsg = booterLang("exit"),
			leftCb = arg_11_0._quitGame,
			leftCbObj = arg_11_0,
			rightMsg = booterLang("retry"),
			rightCb = arg_11_0._downloadRetry,
			rightCbObj = arg_11_0
		}

		BootMsgBox.instance:show(var_11_0)
	end
end

function var_0_0.onNotEnoughDiskSpace(arg_12_0, arg_12_1)
	logNormal("HotUpateOptionPackageAdapter:_onNotEnoughDiskSpace, packName = " .. arg_12_1)

	local var_12_0 = {
		title = booterLang("hotupdate"),
		content = booterLang("download_fail_no_enough_disk"),
		rightMsg = booterLang("exit"),
		rightCb = arg_12_0._quitGame,
		rightCbObj = arg_12_0
	}

	BootMsgBox.instance:show(var_12_0)
end

function var_0_0.onUnzipProgress(arg_13_0, arg_13_1)
	if tostring(arg_13_1) == "nan" then
		return
	end

	local var_13_0 = arg_13_0._downProgressS1 or ""
	local var_13_1 = arg_13_0._downProgressS2 or ""
	local var_13_2 = math.floor(100 * arg_13_1 + 0.5)
	local var_13_3

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_13_3 = string.format(booterLang("unziping_progress_wifi"), tostring(var_13_2), var_13_0, var_13_1)
	else
		var_13_3 = string.format(booterLang("unziping_progress"), tostring(var_13_2), var_13_0, var_13_1)
	end

	HotUpdateProgress.instance:setProgressUnzipOptionPackage(arg_13_1, arg_13_0._nowPackSize, arg_13_0._downloader:getDownloadSuccSize(), var_13_3)
end

function var_0_0.onPackUnZipFail(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 then
		local var_14_0 = {
			title = booterLang("hotupdate"),
			content = OptionPackageDownloader._getUnzipFailedTip(arg_14_2),
			leftMsg = booterLang("exit"),
			leftCb = arg_14_0._quitGame,
			leftCbObj = arg_14_0,
			rightMsg = booterLang("retry"),
			rightCb = arg_14_0._downloadRetry,
			rightCbObj = arg_14_0
		}

		BootMsgBox.instance:show(var_14_0)
	end
end

function var_0_0.onPackItemStateChange(arg_15_0, arg_15_1)
	return
end

return var_0_0
