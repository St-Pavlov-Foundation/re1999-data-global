module("modules.reschecker.ResCheckMgr", package.seeall)

local var_0_0 = class("ResCheckMgr")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.startCheck(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.cb = arg_2_1
	arg_2_0.cbObj = arg_2_2

	local var_2_0 = tonumber(BootNativeUtil.getAppVersion())
	local var_2_1 = SLFramework.FileHelper.ReadText(SLFramework.ResChecker.OutVersionPath)

	if tostring(var_2_0) == var_2_1 then
		logNormal("ResCheckMgr pass, is not first init")
		arg_2_0:doCallBack(true)

		return
	end

	SLFramework.TimeWatch.Instance:Start()

	arg_2_0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	arg_2_0.eventDispatcher:AddListener(arg_2_0.eventDispatcher.ResChecker_Finish, arg_2_0.onCheckFinish, arg_2_0)
	arg_2_0.eventDispatcher:AddListener(arg_2_0.eventDispatcher.ResChecker_Progress, arg_2_0.onCheckProgress, arg_2_0)

	local var_2_2 = arg_2_0:_getAllLocalLang()
	local var_2_3, var_2_4 = arg_2_0:_getDLCInfo(var_2_2)
	local var_2_5 = SLFramework.GameUpdate.OptionalUpdate.Instance:GetLocalVersion("res-HD")

	if not string.nilorempty(var_2_5) or not BootVoiceView.instance:isFirstDownloadDone() then
		var_2_3 = true

		table.insert(var_2_4, "res-HD")
	end

	logNormal("ResCheckMgr:startCheck, allLocalLang = " .. table.concat(var_2_2, ",") .. " useDLC = " .. tostring(var_2_3) .. " allDLCLocalLang = " .. table.concat(var_2_4, ","))
	SLFramework.ResChecker.Instance:CheckAllRes(var_2_2, var_2_3, var_2_4)
end

function var_0_0.onCheckProgress(arg_3_0, arg_3_1, arg_3_2)
	logNormal("ResCheckMgr:onCheckProgress, 检查进度 doneFileNum = " .. arg_3_1 .. " allFileNum = " .. arg_3_2)

	local var_3_0 = arg_3_1 / arg_3_2
	local var_3_1 = string.format(booterLang("rescheker"), arg_3_1, arg_3_2)

	BootLoadingView.instance:show(var_3_0, var_3_1)
end

function var_0_0.onCheckFinish(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2 = tonumber(tostring(arg_4_2))

	logNormal("ResCheckMgr:onCheckFinish:allPass = " .. tostring(arg_4_1) .. " #allSize = " .. arg_4_2 .. " #cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")

	if arg_4_1 then
		arg_4_0:doCallBack(true)
	elseif UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		arg_4_0:doCallBack()
	else
		local var_4_0 = {
			title = booterLang("hotupdate")
		}
		local var_4_1 = booterLang("hotupdate_info")

		var_4_0.content = string.format(var_4_1, HotUpdateMgr.instance:_fixSizeStr(arg_4_2))
		var_4_0.leftMsg = booterLang("exit")
		var_4_0.leftCb = arg_4_0._quitGame
		var_4_0.leftCbObj = arg_4_0
		var_4_0.rightMsg = booterLang("download")
		var_4_0.rightCb = arg_4_0.doCallBack
		var_4_0.rightCbObj = arg_4_0

		BootMsgBox.instance:show(var_4_0)
	end
end

function var_0_0.doCallBack(arg_5_0, arg_5_1)
	if arg_5_0.eventDispatcher then
		arg_5_0.eventDispatcher:RemoveListener(arg_5_0.eventDispatcher.ResChecker_Finish)
		arg_5_0.eventDispatcher:RemoveListener(arg_5_0.eventDispatcher.ResChecker_Progress)
	end

	if arg_5_1 then
		arg_5_0:markLastCheckAppVersion()
	end

	if arg_5_0.cb then
		arg_5_0.cb(arg_5_0.cbObj, arg_5_1)
	end
end

function var_0_0.markLastCheckAppVersion(arg_6_0)
	logNormal("ResCheckMgr:markLastCheckAppVersion")

	local var_6_0 = BootNativeUtil.getAppVersion()

	SLFramework.FileHelper.WriteTextToPath(SLFramework.ResChecker.OutVersionPath, var_6_0)
end

function var_0_0._quitGame(arg_7_0)
	logNormal("ResCheckMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function var_0_0._getAllLocalLang(arg_8_0)
	local var_8_0 = SLFramework.GameUpdate.OptionalUpdate.Instance

	var_8_0:Init()

	local var_8_1 = {}
	local var_8_2 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_8_3 = GameConfig:GetDefaultVoiceShortcut()

	table.insert(var_8_2, "HD")

	for iter_8_0 = 1, #var_8_2 do
		local var_8_4 = var_8_2[iter_8_0]
		local var_8_5 = var_8_4 == var_8_3
		local var_8_6 = var_8_0:GetLocalVersion(var_8_4)
		local var_8_7 = not string.nilorempty(var_8_6)
		local var_8_8 = not BootVoiceView.instance:isFirstDownloadDone()

		if var_8_5 or var_8_7 or var_8_8 then
			table.insert(var_8_1, var_8_4)
		end
	end

	return var_8_1
end

function var_0_0._getDLCInfo(arg_9_0, arg_9_1)
	local var_9_0 = HotUpdateOptionPackageMgr.instance:getPackageNameList()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		table.insert(var_9_1, HotUpdateOptionPackageMgr.instance:formatLangPackName("res", iter_9_1))
		table.insert(var_9_1, HotUpdateOptionPackageMgr.instance:formatLangPackName("media", iter_9_1))

		for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
			table.insert(var_9_1, HotUpdateOptionPackageMgr.instance:formatLangPackName(iter_9_3, iter_9_1))
		end
	end

	return #var_9_1 > 0, var_9_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
