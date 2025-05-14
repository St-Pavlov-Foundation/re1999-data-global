module("modules.logic.optionpackage.controller.OptionPackageController", package.seeall)

local var_0_0 = class("OptionPackageController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	arg_1_0._optionalUpdateInst = arg_1_0._optionalUpdate.Instance
	arg_1_0._initialized = false

	if not HotUpdateVoiceMgr then
		return
	end

	arg_1_0._initialized = true
	arg_1_0._downloader = OptionPackageDownloader.New()
	arg_1_0._httpWorker = OptionPackageHttpWorker.New()
	arg_1_0._adapter = DownloadOptPackAdapter.New()
end

function var_0_0.onInitFinish(arg_2_0)
	if not arg_2_0._initialized then
		return
	end

	arg_2_0:_startHttpWorker()

	arg_2_0._localPackageNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	arg_2_0:_updateLocalVersion()
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0._startHttpWorker(arg_5_0)
	logNormal("OptionPackageController:_startHttpWorker()")

	local var_5_0 = OptionPackageEnum.PackageNameList

	if #var_5_0 < 1 then
		return
	end

	local var_5_1 = {}
	local var_5_2 = OptionPackageModel.instance:getSupportVoiceLangs()
	local var_5_3 = {}

	tabletool.addValues(var_5_3, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(var_5_3, var_5_2)

	if var_5_3 and #var_5_3 > 0 then
		local var_5_4 = HotUpdateOptionPackageMgr.instance:formatLangPackList(var_5_3, var_5_0)

		table.insert(var_5_1, OptionPackageHttpGetter.New(OptionPackageEnum.SourceType.OptResVoice, var_5_4))
	end

	arg_5_0._httpWorkerRequestCount = 0

	arg_5_0._httpWorker:start(var_5_1, arg_5_0._onHttpWorkerDone, arg_5_0)
end

function var_0_0._onHttpWorkerDone(arg_6_0, arg_6_1)
	if not arg_6_1 and arg_6_0._httpWorkerRequestCount < 3 then
		arg_6_0._httpWorkerRequestCount = arg_6_0._httpWorkerRequestCount + 1

		arg_6_0._httpWorker:againGetHttp(arg_6_0._onHttpWorkerDone, arg_6_0)

		return
	end

	if not arg_6_1 then
		arg_6_0:_endHttpBlock()

		return
	end

	local var_6_0 = arg_6_0._httpWorker:getHttpResult()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_1 = OptionPackageModel.instance:getPackageMO(iter_6_0)

		if not var_6_1 then
			local var_6_2 = string.split(iter_6_0, "-")

			if var_6_2 and #var_6_2 > 1 then
				var_6_1 = OptionPackageMO.New()

				local var_6_3 = var_6_2[1]
				local var_6_4 = var_6_2[2]

				var_6_1:init(var_6_4, var_6_3)
				OptionPackageModel.instance:addPackageMO(var_6_1)
			end
		end

		if var_6_1 then
			logNormal(string.format("packMO:setPackInfo() langPackName :%s localVersion:%s", iter_6_0, var_6_1.localVersion))
			var_6_1:setPackInfo(iter_6_1)

			if #var_6_1.downloadResList.names > 0 then
				local var_6_5 = var_6_1.downloadResList

				arg_6_0._optionalUpdateInst:InitBreakPointInfo(var_6_5.names, var_6_5.hashs, var_6_5.orders, var_6_5.lengths)

				local var_6_6 = arg_6_0._optionalUpdateInst:GetRecvSize()
				local var_6_7 = tonumber(var_6_6)

				var_6_1:setLocalSize(var_6_7)
			end
		end
	end

	arg_6_0:_endHttpBlock()
end

function var_0_0._updateLocalVersion(arg_7_0)
	local var_7_0 = OptionPackageModel.instance:getPackageMOList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1 then
			local var_7_1 = arg_7_0:getLocalVersionInt(iter_7_1.langPack)

			iter_7_1:setLocalVersion(var_7_1)
		end
	end
end

var_0_0.OPTION_PACKAGE_HTTP_REQUEST = "OptionPackageController.OPTION_PACKAGE_HTTP_REQUEST"

function var_0_0._startHttpBlock(arg_8_0)
	UIBlockMgr.instance:startBlock(var_0_0.OPTION_PACKAGE_HTTP_REQUEST)
	TaskDispatcher.cancelTask(arg_8_0._endHttpBlock, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._endHttpBlock, arg_8_0, 10)
end

function var_0_0._endHttpBlock(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._endHttpBlock, arg_9_0)
	UIBlockMgr.instance:endBlock(var_0_0.OPTION_PACKAGE_HTTP_REQUEST)
end

function var_0_0.checkNeedDownload(arg_10_0, arg_10_1)
	if not arg_10_0._initialized or not OptionPackageEnum.HasPackageNameDict[arg_10_1] then
		return false
	end

	if GameResMgr.IsFromEditorDir and not HotUpdateOptionPackageMgr.EnableEditorDebug then
		return false
	end

	local var_10_0, var_10_1 = arg_10_0._httpWorker:checkWorkDone()

	if not var_10_0 then
		arg_10_0:_startHttpBlock()

		return true
	end

	if var_10_0 and not var_10_1 then
		arg_10_0._httpWorker:againGetHttp(arg_10_0._onHttpWorkerDone, arg_10_0)
		arg_10_0:_startHttpBlock()

		return true
	end

	local var_10_2 = OptionPackageModel.instance:getPackageSetMO(arg_10_1)
	local var_10_3 = OptionPackageModel.instance:getNeedVoiceLangList()

	if var_10_2:isNeedDownload(var_10_3) then
		local var_10_4, var_10_5 = var_10_2:getDownloadSize(var_10_3)
		local var_10_6, var_10_7, var_10_8 = OptionPackageHelper.getLeftSizeMBorGB(var_10_4, var_10_5)
		local var_10_9 = formatLuaLang("OptionPackageController_checkNeedDownload", var_10_6, var_10_8)

		arg_10_0:_showDownloadMsgBox(arg_10_1, var_10_9)

		return true
	end

	return false
end

function var_0_0._showDownloadMsgBox(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._downloadPackName = arg_11_1

	local var_11_0 = MessageBoxIdDefine.ForbidLogin
	local var_11_1 = MsgBoxEnum.BoxType.Yes_No
	local var_11_2 = "确定下载"
	local var_11_3 = "YES DOWNLOAD"
	local var_11_4 = "取消下载"
	local var_11_5 = "CANCEL DOWNLOAD"
	local var_11_6 = var_0_0._downloaderYes
	local var_11_7 = var_0_0._downloaderNo

	MessageBoxController.instance:showSystemMsgBox(var_11_0, var_11_1, var_11_6, var_11_7, nil, nil, nil, nil, arg_11_2)
end

function var_0_0.stopDownload(arg_12_0)
	if arg_12_0._downloader then
		arg_12_0._downloader:cancelDownload()
	end

	var_0_0.instance._downloadPackName = nil

	arg_12_0:_updateLocalVersion()
	ViewMgr.instance:closeView(ViewName.OptionPackageDownloadView)
end

function var_0_0._downloaderNo()
	var_0_0.instance._downloadPackName = nil
end

function var_0_0._downloaderYes()
	var_0_0.instance:_onStartDownload()
end

function var_0_0._onStartDownload(arg_15_0)
	local var_15_0 = arg_15_0._downloadPackName

	arg_15_0._downloadPackName = nil

	local var_15_1 = OptionPackageModel.instance:getPackageSetMO(var_15_0)
	local var_15_2 = OptionPackageModel.instance:getNeedVoiceLangList()
	local var_15_3 = var_15_1:getDownloadInfoListTb(var_15_2)

	arg_15_0._adapter:setDownloder(arg_15_0._downloader, arg_15_0._httpWorker)
	ViewMgr.instance:openView(ViewName.OptionPackageDownloadView)
	arg_15_0._downloader:start(var_15_3, arg_15_0._onDownloadFinish, arg_15_0, arg_15_0._adapter)
	OptionPackageModel.instance:addLocalPackSetName(var_15_0)

	local var_15_4 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_3) do
		if iter_15_1 and iter_15_1.res and #iter_15_1.res > 0 then
			table.insert(var_15_4, iter_15_0)
		end
	end

	local var_15_5 = {
		resource_type = var_15_4
	}

	SDKDataTrackMgr.instance:trackOptionPackConfirmDownload(var_15_5)
end

function var_0_0._onDownloadFinish(arg_16_0)
	GameFacade.showToast(ToastEnum.VersionResDownloadSuccess)
	arg_16_0:_updateLocalVersion()
	ViewMgr.instance:closeView(ViewName.OptionPackageDownloadView)
end

function var_0_0.getLocalVersionInt(arg_17_0, arg_17_1)
	if not arg_17_0._initialized then
		return 0
	end

	local var_17_0 = arg_17_0._optionalUpdateInst:GetLocalVersion(arg_17_1)

	if not string.nilorempty(var_17_0) then
		return tonumber(var_17_0)
	end

	return 0
end

function var_0_0.getPackItemState(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._initialized then
		return OptionPackageEnum.UpdateState.AlreadyLatest
	end

	return arg_18_0._optionalUpdateInst:GetPackItemState(arg_18_1, arg_18_2)
end

function var_0_0._getPackageName(arg_19_0, arg_19_1)
	if not arg_19_0._initialized or not OptionPackageEnum.HasPackageNameDict[arg_19_1] then
		return
	end

	local var_19_0 = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	if not tabletool.indexOf(var_19_0, arg_19_1) then
		-- block empty
	end
end

function OptionPackageHttpWorker.againGetHttp(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._httpGetterOnFinshFunc = arg_20_1
	arg_20_0._httpGetterOnFinshObj = arg_20_2

	for iter_20_0, iter_20_1 in pairs(arg_20_0._httpGetterList) do
		if not arg_20_0._httpGetterFinishDict[iter_20_1:getHttpId()] then
			iter_20_1:start(arg_20_0._onHttpGetterFinish, arg_20_0)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
