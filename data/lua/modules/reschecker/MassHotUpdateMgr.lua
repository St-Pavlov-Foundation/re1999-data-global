module("modules.reschecker.MassHotUpdateMgr", package.seeall)

slot0 = class("MassHotUpdateMgr")

function slot0.ctor(slot0)
	slot0._maxRetryCount = 3
end

function slot0.loadUnmatchRes(slot0, slot1, slot2)
	slot0._time = Time.time
	slot0.cb = slot1
	slot0.cbObj = slot2
	slot0._retryCount = 0
	slot0._useBackupUrl = false
	SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false
	slot3, slot4 = GameUrlConfig.getMassHotUpdateUrl()
	slot5 = SDKMgr.instance:getGameId()

	if GameChannelConfig.getServerType() == 4 then
		slot3 = slot3 .. "/" .. slot5
		slot4 = slot4 .. "/" .. slot5
	elseif slot6 == 3 then
		slot3 = slot3 .. "/" .. slot5
		slot4 = slot4 .. "/" .. slot5
	elseif string.find(GameConfig.BranchName, "stable") then
		slot3 = slot3 .. "/" .. slot5
		slot4 = slot4 .. "/" .. slot5
	else
		slot3 = slot3 .. "/overseas"
		slot4 = slot4 .. "/overseas"
	end

	slot7 = SLFramework.GameUpdate.MassHotUpdate.Instance:SetUrlAndBackupUrl(slot3, slot4)
	slot0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	slot0.eventDispatcher:AddListener(slot0.eventDispatcher.MassHotUpdate_DownloadFinish, slot0.onDownloadFinish, slot0)
	slot0.eventDispatcher:AddListener(slot0.eventDispatcher.MassHotUpdate_Progress, slot0.onDownloadProgress, slot0)
	slot0.eventDispatcher:AddListener(slot0.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace, slot0._onDiskSpaceNotEnough, slot0)

	slot0._lastRecvSize = 0
	slot0._allSize = 0

	SLFramework.ResChecker.Instance:LoadUnmatchRes()

	slot0._allSize = tonumber(tostring(SLFramework.GameUpdate.MassHotUpdate.Instance:GetAllSize()))
	slot0._lastFailedFileCount = 0
end

function slot0.onDownloadProgress(slot0, slot1, slot2)
	if slot0._allSize == 0 then
		BootLoadingView.instance:show(0, booterLang("mass_download"))

		return
	end

	slot1 = slot0._lastRecvSize + tonumber(tostring(slot1))
	slot2 = tonumber(tostring(slot2))

	BootLoadingView.instance:show(slot1 / slot0._allSize, string.format(booterLang("mass_download_Progress"), HotUpdateMgr.instance:_fixSizeStr(slot1), HotUpdateMgr.instance:_fixSizeStr(slot0._allSize)))
end

function slot0.onDownloadFinish(slot0, slot1, slot2, slot3, slot4)
	slot2 = tonumber(tostring(slot2))
	slot5 = slot0._allSize - slot2

	logNormal("MassHotUpdateMgr:onDownloadFinish cost time: " .. Time.time - slot0._time .. " s      recvSize = " .. slot5 .. "    failSize = " .. slot2)

	slot0._lastRecvSize = slot5

	if slot1 == 0 then
		slot0:doCallBack()
	else
		slot0._retryCount = slot0._retryCount + 1

		if slot0._lastFailedFileCount == 0 or slot1 / slot0._lastFailedFileCount < 0.5 then
			slot0._lastFailedFileCount = slot1

			slot0:retryFailedFiles()

			return
		end

		slot7 = slot0:_getDownloadFailedTip(slot3[0], slot4[0])

		for slot12 = 1, slot3.Count - 1 do
			if slot3[slot12] == SLFramework.GameUpdate.FailError.NoEnoughDisk then
				slot7 = slot0:_getDownloadFailedTip(slot3[slot12], slot4[slot12])

				break
			end
		end

		if not slot0._useBackupCount then
			slot0._useBackupCount = 1
		else
			slot0._useBackupCount = slot0._useBackupCount + 1
		end

		slot9 = slot0._useBackupUrl

		if slot0._useBackupCount == 2 then
			slot0._useBackupUrl = not slot0._useBackupUrl

			SLFramework.GameUpdate.MassHotUpdate.Instance:SetUseBackupDownloadUrl(slot0._useBackupUrl)

			slot0._useBackupCount = 0
		end

		if SDKMgr.instance:isIgnoreFileMissing() then
			if slot9 == true then
				slot0:_skip()
			else
				slot0:retryFailedFiles()
			end

			return
		end

		slot0._lastFailedFileCount = slot1

		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = string.format(booterLang("mass_download_fail_other"), slot7, slot1),
			leftMsg = booterLang("skip"),
			leftMsgEn = "skip",
			leftCb = slot0._skip,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0.retryFailedFiles,
			rightCbObj = slot0
		})
	end
end

function slot0.retryFailedFiles(slot0)
	logNormal("MassHotUpdateMgr:retryFailedFiles ,   retryCount:" .. slot0._retryCount)
	SLFramework.GameUpdate.MassHotUpdate.Instance:RetryFailedFiles()
end

function slot0._onDiskSpaceNotEnough(slot0)
	logNormal("修复错误，设备磁盘空间不足！")
	BootMsgBox.instance:show({
		title = booterLang("hotupdate"),
		content = booterLang("unpack_error"),
		leftMsg = booterLang("exit"),
		leftCb = slot0._quitGame,
		leftCbObj = slot0,
		rightMsg = nil
	})
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

function slot0._skip(slot0)
	slot0:doCallBack(true)
end

function slot0.doCallBack(slot0, slot1)
	if slot0.eventDispatcher then
		slot0.eventDispatcher:RemoveListener(slot0.eventDispatcher.MassHotUpdate_DownloadFinish)
		slot0.eventDispatcher:RemoveListener(slot0.eventDispatcher.MassHotUpdate_Progress)
		slot0.eventDispatcher:RemoveListener(slot0.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace)
	end

	if slot1 ~= true then
		ResCheckMgr.instance:markLastCheckAppVersion()
	end

	if slot0.cb then
		slot0.cb(slot0.cbObj)
	end
end

function slot0._quitGame(slot0)
	logNormal("MassHotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

slot0.instance = slot0.New()

return slot0
