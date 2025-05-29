module("modules.reschecker.MassHotUpdateMgr", package.seeall)

local var_0_0 = class("MassHotUpdateMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._maxRetryCount = 3
end

function var_0_0.loadUnmatchRes(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._time = Time.time
	arg_2_0.cb = arg_2_1
	arg_2_0.cbObj = arg_2_2
	arg_2_0._retryCount = 0
	arg_2_0._useBackupUrl = false
	SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false

	local var_2_0, var_2_1 = GameUrlConfig.getMassHotUpdateUrl()
	local var_2_2 = SDKMgr.instance:getGameId()
	local var_2_3 = GameChannelConfig.getServerType()

	if var_2_3 == 4 then
		var_2_0 = var_2_0 .. "/" .. var_2_2
		var_2_1 = var_2_1 .. "/" .. var_2_2
	elseif var_2_3 == 3 then
		var_2_0 = var_2_0 .. "/" .. var_2_2
		var_2_1 = var_2_1 .. "/" .. var_2_2
	else
		local var_2_4 = GameConfig.BranchName

		if string.find(var_2_4, "stable") then
			var_2_0 = var_2_0 .. "/" .. var_2_2
			var_2_1 = var_2_1 .. "/" .. var_2_2
		else
			var_2_0 = var_2_0 .. "/overseas"
			var_2_1 = var_2_1 .. "/overseas"
		end
	end

	local var_2_5 = SLFramework.GameUpdate.MassHotUpdate.Instance:SetUrlAndBackupUrl(var_2_0, var_2_1)

	arg_2_0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	arg_2_0.eventDispatcher:AddListener(arg_2_0.eventDispatcher.MassHotUpdate_DownloadFinish, arg_2_0.onDownloadFinish, arg_2_0)
	arg_2_0.eventDispatcher:AddListener(arg_2_0.eventDispatcher.MassHotUpdate_Progress, arg_2_0.onDownloadProgress, arg_2_0)
	arg_2_0.eventDispatcher:AddListener(arg_2_0.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace, arg_2_0._onDiskSpaceNotEnough, arg_2_0)

	arg_2_0._fixResEntrance = UnityEngine.PlayerPrefs.GetFloat(PlayerPrefsKey.Manual_FixRes) == 1 and "主动修复" or "自动修复"

	local var_2_6 = {
		count = 0,
		status = "start",
		entrance = arg_2_0._fixResEntrance
	}

	SDKDataTrackMgr.instance:trackResourceFixup(var_2_6)

	arg_2_0._lastRecvSize = 0
	arg_2_0._allSize = 0

	SLFramework.ResChecker.Instance:LoadUnmatchRes()

	local var_2_7 = SLFramework.GameUpdate.MassHotUpdate.Instance:GetAllSize()

	arg_2_0._allSize = tonumber(tostring(var_2_7))
	arg_2_0._lastFailedFileCount = 0
end

function var_0_0.onDownloadProgress(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._allSize == 0 then
		local var_3_0 = booterLang("mass_download")

		BootLoadingView.instance:show(0, var_3_0)

		return
	end

	local var_3_1 = tonumber(tostring(arg_3_1))

	arg_3_1 = arg_3_0._lastRecvSize + var_3_1
	arg_3_2 = tonumber(tostring(arg_3_2))

	local var_3_2 = arg_3_1 / arg_3_0._allSize

	arg_3_1 = HotUpdateMgr.instance:_fixSizeStr(arg_3_1)

	local var_3_3 = HotUpdateMgr.instance:_fixSizeStr(arg_3_0._allSize)
	local var_3_4 = string.format(booterLang("mass_download_Progress"), arg_3_1, var_3_3)

	BootLoadingView.instance:show(var_3_2, var_3_4)
end

function var_0_0.onDownloadFinish(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_2 = tonumber(tostring(arg_4_2))

	local var_4_0 = arg_4_0._allSize - arg_4_2

	logNormal("MassHotUpdateMgr:onDownloadFinish cost time: " .. Time.time - arg_4_0._time .. " s      recvSize = " .. var_4_0 .. "    failSize = " .. arg_4_2)

	arg_4_0._lastRecvSize = var_4_0

	if arg_4_1 == 0 then
		arg_4_0:doCallBack()
	else
		arg_4_0._retryCount = arg_4_0._retryCount + 1

		if arg_4_0._lastFailedFileCount == 0 or arg_4_1 / arg_4_0._lastFailedFileCount < 0.5 then
			arg_4_0._lastFailedFileCount = arg_4_1

			arg_4_0:retryFailedFiles()

			return
		end

		local var_4_1 = SLFramework.GameUpdate.FailError
		local var_4_2 = arg_4_0:_getDownloadFailedTip(arg_4_3[0], arg_4_4[0])
		local var_4_3 = arg_4_3.Count

		for iter_4_0 = 1, var_4_3 - 1 do
			if arg_4_3[iter_4_0] == var_4_1.NoEnoughDisk then
				var_4_2 = arg_4_0:_getDownloadFailedTip(arg_4_3[iter_4_0], arg_4_4[iter_4_0])

				break
			end
		end

		if not arg_4_0._useBackupCount then
			arg_4_0._useBackupCount = 1
		else
			arg_4_0._useBackupCount = arg_4_0._useBackupCount + 1
		end

		local var_4_4 = arg_4_0._useBackupUrl

		if arg_4_0._useBackupCount == 2 then
			arg_4_0._useBackupUrl = not arg_4_0._useBackupUrl

			SLFramework.GameUpdate.MassHotUpdate.Instance:SetUseBackupDownloadUrl(arg_4_0._useBackupUrl)

			arg_4_0._useBackupCount = 0
		end

		if BootNativeUtil.getPackageName() ~= "com.shenlan.m.reverse1999.nearme.gamecenter" then
			if SDKMgr.instance:isIgnoreFileMissing() then
				if var_4_4 == true then
					arg_4_0._lastFailedFileCount = arg_4_1

					arg_4_0:_skip()
				else
					arg_4_0:retryFailedFiles()
				end

				return
			end

			return
		end

		arg_4_0._lastFailedFileCount = arg_4_1

		local var_4_5 = {
			title = booterLang("hotupdate"),
			content = string.format(booterLang("mass_download_fail_other"), var_4_2, arg_4_1),
			leftMsg = booterLang("skip")
		}

		var_4_5.leftMsgEn = "skip"
		var_4_5.leftCb = arg_4_0._skip
		var_4_5.leftCbObj = arg_4_0
		var_4_5.rightMsg = booterLang("retry")
		var_4_5.rightCb = arg_4_0.retryFailedFiles
		var_4_5.rightCbObj = arg_4_0

		BootMsgBox.instance:show(var_4_5)
	end
end

function var_0_0.retryFailedFiles(arg_5_0)
	logNormal("MassHotUpdateMgr:retryFailedFiles ,   retryCount:" .. arg_5_0._retryCount)
	SLFramework.GameUpdate.MassHotUpdate.Instance:RetryFailedFiles()
end

function var_0_0._onDiskSpaceNotEnough(arg_6_0)
	logNormal("修复错误，设备磁盘空间不足！")

	local var_6_0 = {
		title = booterLang("hotupdate"),
		content = booterLang("unpack_error"),
		leftMsg = booterLang("exit"),
		leftCb = arg_6_0._quitGame,
		leftCbObj = arg_6_0
	}

	var_6_0.rightMsg = nil

	BootMsgBox.instance:show(var_6_0)
end

function var_0_0._getDownloadFailedTip(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = SLFramework.GameUpdate.FailError

	arg_7_1 = var_7_0.IntToEnum(arg_7_1)
	arg_7_0._errorCode = arg_7_1
	arg_7_2 = arg_7_2 or ""

	if arg_7_1 == var_7_0.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif arg_7_1 == var_7_0.NotFound then
		return booterLang("download_fail_not_found")
	elseif arg_7_1 == var_7_0.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif arg_7_1 == var_7_0.TimeOut then
		return booterLang("download_fail_time_out")
	elseif arg_7_1 == var_7_0.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif arg_7_1 == var_7_0.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(arg_7_2)
	end
end

function var_0_0._skip(arg_8_0)
	arg_8_0:doCallBack(true)
end

function var_0_0.doCallBack(arg_9_0, arg_9_1)
	if arg_9_0.eventDispatcher then
		arg_9_0.eventDispatcher:RemoveListener(arg_9_0.eventDispatcher.MassHotUpdate_DownloadFinish)
		arg_9_0.eventDispatcher:RemoveListener(arg_9_0.eventDispatcher.MassHotUpdate_Progress)
		arg_9_0.eventDispatcher:RemoveListener(arg_9_0.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace)
	end

	if arg_9_1 ~= true then
		ResCheckMgr.instance:markLastCheckAppVersion()
		UnityEngine.PlayerPrefs.DeleteKey(PlayerPrefsKey.Manual_FixRes)
	end

	local var_9_0 = {
		status = arg_9_1 and "fail" or "success",
		count = arg_9_0._lastFailedFileCount,
		entrance = arg_9_0._fixResEntrance
	}

	SDKDataTrackMgr.instance:trackResourceFixup(var_9_0)

	if arg_9_0.cb then
		arg_9_0.cb(arg_9_0.cbObj)
	end
end

function var_0_0._quitGame(arg_10_0)
	logNormal("MassHotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

var_0_0.instance = var_0_0.New()

return var_0_0
