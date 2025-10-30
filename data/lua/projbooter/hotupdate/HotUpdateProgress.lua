module("projbooter.hotupdate.HotUpdateProgress", package.seeall)

local var_0_0 = class("HotUpdateMgr")

var_0_0.NotFixProgress = 0.75
var_0_0.UnzipPer = 0.1
var_0_0.DownloadPer = 1 - var_0_0.UnzipPer
var_0_0.CheckResPer = 0.5
var_0_0.DownloadResPer = 1 - var_0_0.CheckResPer
var_0_0.ShowDetailMsg = true

function var_0_0.initDownloadSize(arg_1_0, arg_1_1, arg_1_2)
	if GameResMgr.IsFromEditorDir or VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		var_0_0.NotFixProgress = 1
	else
		local var_1_0 = tonumber(BootNativeUtil.getAppVersion())
		local var_1_1 = SLFramework.FileHelper.ReadText(SLFramework.ResChecker.OutVersionPath)

		if tostring(var_1_0) == var_1_1 then
			var_0_0.NotFixProgress = 1
		else
			var_0_0.NotFixProgress = 0.75
		end
	end

	arg_1_0._voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getNeedDownloadSize()
	arg_1_0._optionPackageNeedDownloadSize = HotUpdateOptionPackageMgr.instance:getNeedDownloadSize()
	arg_1_0._hotupdateNeedDownloadSize = arg_1_1 - arg_1_2

	if arg_1_0._hotupdateNeedDownloadSize == 0 then
		-- block empty
	end

	arg_1_0._hotupdateNeedDownloadSize = arg_1_1

	if arg_1_0._optionPackageNeedDownloadSize == 0 then
		-- block empty
	end

	arg_1_0._optionPackageNeedDownloadSize = HotUpdateOptionPackageMgr.instance:getTotalSize()

	if arg_1_0._voiceNeedDownloadSize == 0 then
		-- block empty
	end

	arg_1_0._voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getTotalSize()

	logNormal("hotupdate need download size: ", arg_1_0._hotupdateNeedDownloadSize)
	logNormal("voice need download size: ", arg_1_0._voiceNeedDownloadSize)
	logNormal("optionPackage need download size: ", arg_1_0._optionPackageNeedDownloadSize)

	arg_1_0._totalNeedDownloadSize = arg_1_0._voiceNeedDownloadSize + arg_1_0._hotupdateNeedDownloadSize + arg_1_0._optionPackageNeedDownloadSize

	local var_1_2 = 0

	if arg_1_0._totalNeedDownloadSize <= 0 then
		var_0_0.NotFixProgress = 0
	end

	var_0_0.FixProgress = 1 - var_0_0.NotFixProgress
	arg_1_0._totalNeedDownloadSizeStr = HotUpdateMgr.fixSizeStr(arg_1_0._totalNeedDownloadSize)
end

function var_0_0.updateVoiceNeedDownloadSize(arg_2_0)
	arg_2_0._voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getTotalSize()
	arg_2_0._totalNeedDownloadSize = arg_2_0._voiceNeedDownloadSize + arg_2_0._hotupdateNeedDownloadSize + arg_2_0._optionPackageNeedDownloadSize

	if arg_2_0._totalNeedDownloadSize <= 0 then
		var_0_0.NotFixProgress = 0
	end

	var_0_0.FixProgress = 1 - var_0_0.NotFixProgress
	arg_2_0._totalNeedDownloadSizeStr = HotUpdateMgr.fixSizeStr(arg_2_0._totalNeedDownloadSize)
end

function var_0_0.getTotalNeedDownloadSize(arg_3_0)
	return arg_3_0._totalNeedDownloadSize
end

function var_0_0.getTotalNeedDownloadSizeStr(arg_4_0)
	return arg_4_0._totalNeedDownloadSizeStr
end

function var_0_0.getHotupdateNeedDownloadSize(arg_5_0)
	return arg_5_0._hotupdateNeedDownloadSize
end

function var_0_0.getVoiceNeedDownloadSize(arg_6_0)
	return arg_6_0._voiceNeedDownloadSize
end

function var_0_0.getOptionPackageNeedDownloadSize(arg_7_0)
	return arg_7_0._optionPackageNeedDownloadSize
end

function var_0_0.setProgressDownloadHotupdate(arg_8_0, arg_8_1)
	local var_8_0 = HotUpdateMgr.fixSizeStr(arg_8_1)
	local var_8_1 = string.format(booterLang("downloading_progress_new"), var_8_0, arg_8_0:getTotalNeedDownloadSizeStr())
	local var_8_2 = arg_8_1 * var_0_0.DownloadPer / arg_8_0._totalNeedDownloadSize

	arg_8_0:setProgressNotFix(var_8_2, var_8_1)
end

function var_0_0.setProgressUnzipHotupdate(arg_9_0, arg_9_1)
	local var_9_0 = HotUpdateMgr.fixSizeStr(arg_9_0:getHotupdateNeedDownloadSize())
	local var_9_1 = string.format(booterLang("unziping_progress_new"), math.floor(100 * arg_9_1 + 0.5), var_9_0, arg_9_0:getTotalNeedDownloadSizeStr())
	local var_9_2 = arg_9_0._hotupdateNeedDownloadSize * (var_0_0.DownloadPer + arg_9_1 * var_0_0.UnzipPer) / arg_9_0._totalNeedDownloadSize

	arg_9_0:setProgressNotFix(var_9_2, var_9_1)
end

function var_0_0.setProgressDownloadVoice(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 == 0 then
		return
	end

	local var_10_0 = arg_10_0:getHotupdateNeedDownloadSize() + arg_10_1 + arg_10_2
	local var_10_1 = HotUpdateMgr.fixSizeStr(var_10_0)
	local var_10_2 = string.format(booterLang("downloading_progress_new"), var_10_1, arg_10_0:getTotalNeedDownloadSizeStr())
	local var_10_3 = (arg_10_1 * var_0_0.DownloadPer + arg_10_2 + arg_10_0._hotupdateNeedDownloadSize) / arg_10_0._totalNeedDownloadSize

	arg_10_0:setProgressNotFix(var_10_3, var_10_2)
end

function var_0_0.setProgressUnzipVoice(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_0:getHotupdateNeedDownloadSize() + arg_11_2 + arg_11_3
	local var_11_1 = HotUpdateMgr.fixSizeStr(var_11_0)
	local var_11_2 = string.format(booterLang("unziping_progress_new"), math.floor(100 * arg_11_1 + 0.5), var_11_1, arg_11_0:getTotalNeedDownloadSizeStr())
	local var_11_3 = (arg_11_2 * (var_0_0.DownloadPer + arg_11_1 * var_0_0.UnzipPer) + arg_11_3 + arg_11_0._hotupdateNeedDownloadSize) / arg_11_0._totalNeedDownloadSize

	arg_11_0:setProgressNotFix(var_11_3, var_11_2)
end

function var_0_0.setProgressDownloadOptionPackage(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1 == 0 then
		return
	end

	local var_12_0 = arg_12_0:getHotupdateNeedDownloadSize() + arg_12_0:getVoiceNeedDownloadSize() + arg_12_1 + arg_12_2
	local var_12_1 = HotUpdateMgr.fixSizeStr(var_12_0)
	local var_12_2 = string.format(booterLang("downloading_progress_new"), var_12_1, arg_12_0:getTotalNeedDownloadSizeStr())
	local var_12_3 = (arg_12_1 * var_0_0.DownloadPer + arg_12_2 + arg_12_0._hotupdateNeedDownloadSize + arg_12_0._voiceNeedDownloadSize) / arg_12_0._totalNeedDownloadSize

	arg_12_0:setProgressNotFix(var_12_3, var_12_2)
end

function var_0_0.setProgressUnzipOptionPackage(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_0:getHotupdateNeedDownloadSize() + arg_13_0:getVoiceNeedDownloadSize() + arg_13_2 + arg_13_3
	local var_13_1 = HotUpdateMgr.fixSizeStr(var_13_0)
	local var_13_2 = string.format(booterLang("unziping_progress_new"), math.floor(100 * arg_13_1 + 0.5), var_13_1, arg_13_0:getTotalNeedDownloadSizeStr())
	local var_13_3 = (arg_13_2 * (var_0_0.DownloadPer + arg_13_1 * var_0_0.UnzipPer) + arg_13_3 + arg_13_0._hotupdateNeedDownloadSize + arg_13_0._voiceNeedDownloadSize) / arg_13_0._totalNeedDownloadSize

	arg_13_0:setProgressNotFix(var_13_3, var_13_2)
end

function var_0_0.setProgressCheckRes(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_0.CheckResPer * arg_14_1

	arg_14_0:setProgressFix(var_14_0, arg_14_2)
end

function var_0_0.setProgressDownloadRes(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_0.CheckResPer + var_0_0.DownloadResPer * arg_15_1

	arg_15_0:setProgressFix(var_15_0, arg_15_2)
end

var_0_0.tmp = 0

function var_0_0.setProgressNotFix(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1 = math.max(arg_16_1, var_0_0.tmp)
	var_0_0.tmp = arg_16_1
	arg_16_1 = math.min(arg_16_1, 1)

	local var_16_0

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_16_0 = booterLang("downloading_and_unzip_wifi")
	else
		var_16_0 = booterLang("downloading_and_unzip")
	end

	if var_0_0.ShowDetailMsg then
		var_16_0 = var_16_0 .. "\n" .. arg_16_2
	end

	BootLoadingView.instance:show(arg_16_1 * var_0_0.NotFixProgress, var_16_0)
end

function var_0_0.setProgressFix(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2 = arg_17_2 or ""
	arg_17_1 = math.min(arg_17_1, 1)

	local var_17_0

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		local var_17_1 = booterLang("downloading_and_unzip_wifi")
	else
		local var_17_2 = booterLang("downloading_and_unzip")
	end

	local var_17_3 = arg_17_1 > 0.5 and booterLang("res_fixing") or booterLang("res_checking")

	if var_0_0.ShowDetailMsg then
		var_17_3 = var_17_3 .. "\n" .. arg_17_2
	end

	BootLoadingView.instance:show(var_0_0.NotFixProgress + arg_17_1 * var_0_0.FixProgress, var_17_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
