-- chunkname: @modules/logic/optionpackage/controller/OptionPackageDownloadMgr.lua

module("modules.logic.optionpackage.controller.OptionPackageDownloadMgr", package.seeall)

local OptionPackageDownloadMgr = class("OptionPackageDownloadMgr", BaseController)

OptionPackageDownloadMgr.instance = OptionPackageDownloadMgr.New()

function OptionPackageDownloadMgr:initResInfo()
	if ProjBooter.instance:isUseBigZip() then
		return
	end

	if GameResMgr.IsFromEditorDir or VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		return
	end

	if BootNativeUtil.isIOS() then
		-- block empty
	else
		SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false
	end

	self._useLuaCheck = false

	local url, backupUrl = GameUrlConfig.getMassHotUpdateUrl()
	local gameId = SDKMgr.instance:getGameId()
	local serverType = GameChannelConfig.getServerType()

	if serverType == 4 then
		url = url .. "/" .. gameId
		backupUrl = backupUrl .. "/" .. gameId
	elseif serverType == 3 then
		url = url .. "/" .. gameId
		backupUrl = backupUrl .. "/" .. gameId
	else
		local branchName = GameConfig.BranchName

		if string.find(branchName, "stable") then
			url = url .. "/" .. gameId
			backupUrl = backupUrl .. "/" .. gameId
		else
			url = url .. "/overseas"
			backupUrl = backupUrl .. "/overseas"
		end
	end

	SLFramework.GameUpdate.MassHotUpdate.Instance:SetUrlAndBackupUrl(url, backupUrl)

	if self._useLuaCheck then
		if GameResMgr.IsFromEditorDir then
			local resInfoPath = "configs/resinfo.json"

			loadNonAbAsset(resInfoPath, SLFramework.AssetType.TEXT, self._onLoadResinfo, self)
		else
			local resInfoPath = "configs/resinfo" .. SLFramework.FrameworkSettings.DataExt

			loadNonAbAsset(resInfoPath, SLFramework.AssetType.DATA, self._onLoadResinfo, self)
		end
	else
		SLFramework.ResChecker.Instance:CheckAllResFast()
	end
end

function OptionPackageDownloadMgr:_onLoadResinfo(assetItem)
	local jsonString = GameResMgr.IsFromEditorDir and assetItem.TextAsset or SLFramework.GameUpdate.UnityZipUtil.UnzipStr(assetItem.DataAsset)
	local remoteJson = cjson.decode(jsonString)

	jsonString = SLFramework.FileHelper.ReadText(ResCheckMgr.instance._loaclHashPath)
	self._allFileLocalHash = string.nilorempty(jsonString) and {} or cjson.decode(jsonString)
	self._allFileRemoteInfo = {}
	self._dlcFileListDic = {}

	local remoteDlcDic = remoteJson[SLFramework.ResChecker.KEY_DLC]

	for dlcType, v in pairs(remoteDlcDic) do
		local fileList = {}

		for key, value in pairs(v) do
			table.insert(fileList, key)

			self._allFileRemoteInfo[key] = value
		end

		self._dlcFileListDic[dlcType] = fileList
	end
end

function OptionPackageDownloadMgr:updateFileLocalHash(fileName, hash)
	self._allFileLocalHash[fileName] = hash
end

function OptionPackageDownloadMgr:checkHashFast(fileName)
	return self._allFileRemoteInfo[fileName].md5 == self._allFileLocalHash[fileName]
end

function OptionPackageDownloadMgr:getFileSize(fileName)
	return self._allFileRemoteInfo[fileName].size
end

function OptionPackageDownloadMgr:getPackageDLCList(packageName)
	local dlcTypeList = {}
	local langStrList = {}

	tabletool.addValues(langStrList, OptionPackageEnum.NeedPackLangList)

	local forecSelect = HotUpdateVoiceMgr.ForceSelect or {}
	local defaultVoiceLang = GameConfig:GetDefaultVoiceShortcut()
	local curVoiceLang = GameConfig:GetCurVoiceShortcut()

	if not tabletool.indexOf(langStrList, defaultVoiceLang) then
		table.insert(langStrList, defaultVoiceLang)
	end

	for langStr, _ in pairs(forecSelect) do
		if not tabletool.indexOf(langStrList, langStr) then
			table.insert(langStrList, langStr)
		end
	end

	if not tabletool.indexOf(langStrList, curVoiceLang) then
		table.insert(langStrList, curVoiceLang)
	end

	if langStrList and #langStrList > 0 then
		local langPackList = HotUpdateOptionPackageMgr.instance:formatLangPackList(langStrList, {
			packageName
		})

		tabletool.addValues(dlcTypeList, langPackList)
	end

	return dlcTypeList
end

function OptionPackageDownloadMgr:getDLCDiff(packageName)
	local dlcTypeList = self:getPackageDLCList(packageName)
	local diffList, allSize = self:checkLocalHash(dlcTypeList)

	return diffList, allSize, dlcTypeList
end

function OptionPackageDownloadMgr:checkLocalHash(dlcTypeList)
	local diffList = {}
	local allSize = 0

	if self._useLuaCheck then
		for i, v in pairs(dlcTypeList) do
			local fileList = self._dlcFileListDic[v]

			if fileList then
				for n, fileName in pairs(fileList) do
					if self:checkHashFast(fileName) == false then
						table.insert(diffList, fileName)

						allSize = allSize + self:getFileSize(fileName)
					end
				end
			end
		end
	else
		SLFramework.ResChecker.Instance:CheckAllResFast()

		allSize = SLFramework.ResChecker.Instance:GetUnmatchResSize(dlcTypeList)
		allSize = tonumber(tostring(allSize))
	end

	return diffList, allSize
end

function OptionPackageDownloadMgr:GetUnmatchResSize(dlcType)
	local allSize = SLFramework.ResChecker.Instance:GetUnmatchResSize(dlcType)

	allSize = tonumber(tostring(allSize))

	return allSize
end

function OptionPackageDownloadMgr:startDownload(packSetName, fileList, dlcTypeList, onFinish, finishObj)
	if BootNativeUtil.isIOS() then
		require("tolua.reflection")
		tolua.loadassembly("Assembly-CSharp")

		local type = tolua.findtype("SLFramework.SdkUtil")
		local method = tolua.gettypemethod(type, "StopAllDownload")

		method:Call()
	end

	self._packSetName = packSetName
	self._onDownloadFinish = onFinish
	self._onDownloadFinishObj = finishObj
	self._statHotUpdatePerList = {}
	self._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	self._statHotUpdatePerList[2] = {
		0.5,
		"50%"
	}
	self._statHotUpdatePerList[3] = {
		1,
		"100%"
	}
	self._statHotUpdatePerNum = #self._statHotUpdatePerList
	self._nowStatHotUpdatePerIndex = 1
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	self.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_DownloadFinish, self.onDownloadFinish, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_Progress, self.onDownloadProgress, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace, self._onDiskSpaceNotEnough, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_OneFileDownloadFinish, self.onOneFileDownloadFinish, self)
	self.eventDispatcher:AddListener(204, self.onDownloadNumProgress, self)

	self._allSize = 0
	self._lastRecvSize = 0

	if self._useLuaCheck then
		SLFramework.GameUpdate.MassHotUpdate.Instance:SetLoadFilesLua(fileList)
	else
		SLFramework.ResChecker.Instance:LoadUnmatchRes(dlcTypeList)
	end

	SLFramework.GameUpdate.MassHotUpdate.Instance:StartLoad()

	local allSize = SLFramework.GameUpdate.MassHotUpdate.Instance:GetAllSize()

	self._allSize = tonumber(tostring(allSize))
	self._fakerPerSize = 1
	self._fakerRecvSize = 0
	self._fakerInterval = 0.1
	self._fakerSpeed = 1048576 * self._fakerInterval
	self._backgroundSuccNum = 0
	self._backgroundAllNum = 0
	self._backgroundTarSize = 0
	self._timer = Timer.New(function()
		self:updateFakerSize()
	end, self._fakerInterval)
end

function OptionPackageDownloadMgr:_finish()
	HotUpdateOptionPackageMgr.instance:addLocalPackSetName(self._packSetName)
	self:clear()
	SLFramework.ResChecker.Instance:CheckAllResFast()

	if self._onDownloadFinish then
		self._onDownloadFinish(self._onDownloadFinishObj)
	end

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownloadFinish)
end

function OptionPackageDownloadMgr:clear()
	if self.eventDispatcher then
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_DownloadFinish)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_Progress)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_OneFileDownloadFinish)
		self.eventDispatcher:RemoveListener(204)
	end
end

function OptionPackageDownloadMgr:onOneFileDownloadFinish(downloadInfo, succ, failError, errorMsg)
	if self._useLuaCheck and succ then
		self:updateFileLocalHash(downloadInfo.fileName, downloadInfo.hash)
	end
end

function OptionPackageDownloadMgr:onDownloadFinish(failedFileCount, failSize, errorCodeList, errorMsgList)
	self:stopFakerSize()

	failSize = tonumber(tostring(failSize))

	local recvSize = self._allSize - failSize

	logNormal("OptionPackageDownloadMgr:onDownloadFinish  :    recvSize = " .. recvSize .. "    failSize = " .. failSize)

	self._lastRecvSize = recvSize

	if failedFileCount == 0 then
		self:_finish()
	else
		local ErrorDefine = SLFramework.GameUpdate.FailError
		local failedTip, count
		local mainCode = 0

		if errorCodeList.Count > 0 then
			failedTip = MassHotUpdateMgr.instance:_getDownloadFailedTip(errorCodeList[0], errorMsgList[0])
			count = errorCodeList.Count
		else
			failedTip = booterLang("download_fail_time_out")
			count = 1
		end

		for i = 1, count - 1 do
			local code = errorCodeList[i]

			if code == ErrorDefine.NoEnoughDisk then
				mainCode = ErrorDefine.NoEnoughDisk
				failedTip = MassHotUpdateMgr.instance:_getDownloadFailedTip(errorCodeList[i], errorMsgList[i])

				break
			end
		end

		if mainCode == ErrorDefine.NoEnoughDisk then
			self:_onDiskSpaceNotEnough()
		else
			self:_showErrorMsgBox(failedTip)
		end
	end
end

function OptionPackageDownloadMgr:onDownloadProgress(curSize, allSize)
	local curSizeNum = tonumber(tostring(curSize))

	curSize = self._lastRecvSize + curSizeNum

	logNormal("下载进度" .. tonumber(tostring(curSize)) .. "/" .. tonumber(tostring(allSize)))
	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownloadProgressRefresh, "", tonumber(tostring(curSize)), tonumber(tostring(allSize)))
end

OptionPackageDownloadMgr.FakerAdvanceNumDic = {
	{
		10000,
		50
	},
	{
		1000,
		10
	},
	{
		500,
		5
	},
	{
		100,
		2
	}
}

function OptionPackageDownloadMgr:onDownloadNumProgress(curNum, allNum)
	curNum = tonumber(tostring(curNum))
	self._fakerPerSize = self._allSize / allNum
	self._backgroundAllNum = allNum
	self._backgroundSuccNum = curNum

	self:startFakerSize(curNum, allNum)

	local leftNum = allNum - curNum
	local offNum = 1

	for i, v in ipairs(MassHotUpdateMgr.FakerAdvanceNumDic) do
		if leftNum > v[1] then
			offNum = v[2]

			break
		end
	end

	self._backgroundTarSize = math.max(self._backgroundTarSize, math.min(curNum + offNum, allNum) * self._fakerPerSize)
end

function OptionPackageDownloadMgr:startFakerSize()
	if not self._fakerSizeRun then
		self._fakerSizeRun = true

		self._timer:Start()
	end
end

function OptionPackageDownloadMgr:stopFakerSize()
	if self._fakerSizeRun then
		self._fakerSizeRun = false

		self._timer:Stop()
	end
end

function OptionPackageDownloadMgr:updateFakerSize()
	self._timer.loop = 5

	if self._backgroundTarSize > self._fakerRecvSize then
		self._fakerRecvSize = self._fakerRecvSize + (self._backgroundTarSize - self._fakerRecvSize) / 10
	end

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownloadProgressRefresh, "", tonumber(tostring(self._fakerRecvSize)), tonumber(tostring(self._allSize)))
end

function OptionPackageDownloadMgr:_onDiskSpaceNotEnough()
	logNormal("sdk空间不足下载失败")

	local tipsStr = booterLang("download_fail_no_enough_disk")

	self:_showErrorMsgBox(tipsStr)
end

function OptionPackageDownloadMgr:_showErrorMsgBox(tipsStr)
	local messageBoxId = MessageBoxIdDefine.OptPackDownloadError
	local msgBoxType = MsgBoxEnum.BoxType.Yes_No
	local yesStr = booterLang("retry")
	local yesStrEn = "RETRY"
	local noStr = booterLang("exit")
	local noStrEn = "CANCEL"
	local yesCallback = self._retryDownload
	local noCallback = self._exitDownload
	local msgInfo = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		msgBoxType = msgBoxType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		yesCallbackObj = self,
		noCallbackObj = self,
		yesStr = yesStr,
		noStr = noStr,
		yesStrEn = yesStrEn,
		noStrEn = noStrEn,
		extra = tipsStr
	}

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownladErrorMsg, msgInfo)
end

function OptionPackageDownloadMgr:_retryDownload()
	SLFramework.GameUpdate.MassHotUpdate.Instance:RetryFailedFiles()
end

function OptionPackageDownloadMgr:_exitDownload()
	SLFramework.GameUpdate.MassHotUpdate.Instance:StopDownload()
	OptionPackageController.instance:stopDownload()
end

function OptionPackageDownloadMgr:StopDownload()
	logNormal("OptionPackageDownloadMgr:StopDownload")
	SLFramework.GameUpdate.MassHotUpdate.Instance:StopDownload()
	OptionPackageController.instance:stopDownload()
	SLFramework.ResChecker.Instance:CheckAllResFast()
end

function OptionPackageDownloadMgr:deletePack(packname)
	HotUpdateOptionPackageMgr.instance:delLocalPackSetName(packname)

	if not ProjBooter.instance:isUseBigZip() then
		SLFramework.ResChecker.Instance:DelBigTypeLoalHash(packname)
		SLFramework.ResChecker.Instance:CheckAllResFast()
	end
end

return OptionPackageDownloadMgr
