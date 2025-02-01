module("modules.logic.optionpackage.controller.OptionPackageController", package.seeall)

slot0 = class("OptionPackageController", BaseController)

function slot0.onInit(slot0)
	slot0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	slot0._optionalUpdateInst = slot0._optionalUpdate.Instance
	slot0._initialized = false

	if not HotUpdateVoiceMgr then
		return
	end

	slot0._initialized = true
	slot0._downloader = OptionPackageDownloader.New()
	slot0._httpWorker = OptionPackageHttpWorker.New()
	slot0._adapter = DownloadOptPackAdapter.New()
end

function slot0.onInitFinish(slot0)
	if not slot0._initialized then
		return
	end

	slot0:_startHttpWorker()

	slot0._localPackageNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	slot0:_updateLocalVersion()
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0._startHttpWorker(slot0)
	logNormal("OptionPackageController:_startHttpWorker()")

	if #OptionPackageEnum.PackageNameList < 1 then
		return
	end

	slot2 = {}
	slot4 = {}

	tabletool.addValues(slot4, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(slot4, OptionPackageModel.instance:getSupportVoiceLangs())

	if slot4 and #slot4 > 0 then
		table.insert(slot2, OptionPackageHttpGetter.New(OptionPackageEnum.SourceType.OptResVoice, HotUpdateOptionPackageMgr.instance:formatLangPackList(slot4, slot1)))
	end

	slot0._httpWorkerRequestCount = 0

	slot0._httpWorker:start(slot2, slot0._onHttpWorkerDone, slot0)
end

function slot0._onHttpWorkerDone(slot0, slot1)
	if not slot1 and slot0._httpWorkerRequestCount < 3 then
		slot0._httpWorkerRequestCount = slot0._httpWorkerRequestCount + 1

		slot0._httpWorker:againGetHttp(slot0._onHttpWorkerDone, slot0)

		return
	end

	if not slot1 then
		slot0:_endHttpBlock()

		return
	end

	for slot6, slot7 in pairs(slot0._httpWorker:getHttpResult()) do
		if not OptionPackageModel.instance:getPackageMO(slot6) and string.split(slot6, "-") and #slot9 > 1 then
			slot8 = OptionPackageMO.New()

			slot8:init(slot9[2], slot9[1])
			OptionPackageModel.instance:addPackageMO(slot8)
		end

		if slot8 then
			logNormal(string.format("packMO:setPackInfo() langPackName :%s localVersion:%s", slot6, slot8.localVersion))
			slot8:setPackInfo(slot7)

			if #slot8.downloadResList.names > 0 then
				slot9 = slot8.downloadResList

				slot0._optionalUpdateInst:InitBreakPointInfo(slot9.names, slot9.hashs, slot9.orders, slot9.lengths)
				slot8:setLocalSize(tonumber(slot0._optionalUpdateInst:GetRecvSize()))
			end
		end
	end

	slot0:_endHttpBlock()
end

function slot0._updateLocalVersion(slot0)
	for slot5, slot6 in ipairs(OptionPackageModel.instance:getPackageMOList()) do
		if slot6 then
			slot6:setLocalVersion(slot0:getLocalVersionInt(slot6.langPack))
		end
	end
end

slot0.OPTION_PACKAGE_HTTP_REQUEST = "OptionPackageController.OPTION_PACKAGE_HTTP_REQUEST"

function slot0._startHttpBlock(slot0)
	UIBlockMgr.instance:startBlock(uv0.OPTION_PACKAGE_HTTP_REQUEST)
	TaskDispatcher.cancelTask(slot0._endHttpBlock, slot0)
	TaskDispatcher.runDelay(slot0._endHttpBlock, slot0, 10)
end

function slot0._endHttpBlock(slot0)
	TaskDispatcher.cancelTask(slot0._endHttpBlock, slot0)
	UIBlockMgr.instance:endBlock(uv0.OPTION_PACKAGE_HTTP_REQUEST)
end

function slot0.checkNeedDownload(slot0, slot1)
	if not slot0._initialized or not OptionPackageEnum.HasPackageNameDict[slot1] then
		return false
	end

	if GameResMgr.IsFromEditorDir and not HotUpdateOptionPackageMgr.EnableEditorDebug then
		return false
	end

	slot2, slot3 = slot0._httpWorker:checkWorkDone()

	if not slot2 then
		slot0:_startHttpBlock()

		return true
	end

	if slot2 and not slot3 then
		slot0._httpWorker:againGetHttp(slot0._onHttpWorkerDone, slot0)
		slot0:_startHttpBlock()

		return true
	end

	if OptionPackageModel.instance:getPackageSetMO(slot1):isNeedDownload(OptionPackageModel.instance:getNeedVoiceLangList()) then
		slot6, slot7 = slot4:getDownloadSize(slot5)
		slot8, slot9, slot10 = OptionPackageHelper.getLeftSizeMBorGB(slot6, slot7)

		slot0:_showDownloadMsgBox(slot1, formatLuaLang("OptionPackageController_checkNeedDownload", slot8, slot10))

		return true
	end

	return false
end

function slot0._showDownloadMsgBox(slot0, slot1, slot2)
	slot0._downloadPackName = slot1
	slot5 = "确定下载"
	slot6 = "YES DOWNLOAD"
	slot7 = "取消下载"
	slot8 = "CANCEL DOWNLOAD"

	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.ForbidLogin, MsgBoxEnum.BoxType.Yes_No, uv0._downloaderYes, uv0._downloaderNo, nil, , , , slot2)
end

function slot0.stopDownload(slot0)
	if slot0._downloader then
		slot0._downloader:cancelDownload()
	end

	uv0.instance._downloadPackName = nil

	slot0:_updateLocalVersion()
	ViewMgr.instance:closeView(ViewName.OptionPackageDownloadView)
end

function slot0._downloaderNo()
	uv0.instance._downloadPackName = nil
end

function slot0._downloaderYes()
	uv0.instance:_onStartDownload()
end

function slot0._onStartDownload(slot0)
	slot1 = slot0._downloadPackName
	slot0._downloadPackName = nil
	slot4 = OptionPackageModel.instance:getPackageSetMO(slot1):getDownloadInfoListTb(OptionPackageModel.instance:getNeedVoiceLangList())

	slot0._adapter:setDownloder(slot0._downloader, slot0._httpWorker)
	ViewMgr.instance:openView(ViewName.OptionPackageDownloadView)

	slot9 = slot0
	slot10 = slot0._adapter

	slot0._downloader:start(slot4, slot0._onDownloadFinish, slot9, slot10)
	OptionPackageModel.instance:addLocalPackSetName(slot1)

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		if slot10 and slot10.res and #slot10.res > 0 then
			table.insert(slot5, slot9)
		end
	end

	SDKDataTrackMgr.instance:trackOptionPackConfirmDownload({
		resource_type = slot5
	})
end

function slot0._onDownloadFinish(slot0)
	GameFacade.showToast(ToastEnum.VersionResDownloadSuccess)
	slot0:_updateLocalVersion()
	ViewMgr.instance:closeView(ViewName.OptionPackageDownloadView)
end

function slot0.getLocalVersionInt(slot0, slot1)
	if not slot0._initialized then
		return 0
	end

	if not string.nilorempty(slot0._optionalUpdateInst:GetLocalVersion(slot1)) then
		return tonumber(slot2)
	end

	return 0
end

function slot0.getPackItemState(slot0, slot1, slot2)
	if not slot0._initialized then
		return OptionPackageEnum.UpdateState.AlreadyLatest
	end

	return slot0._optionalUpdateInst:GetPackItemState(slot1, slot2)
end

function slot0._getPackageName(slot0, slot1)
	if not slot0._initialized or not OptionPackageEnum.HasPackageNameDict[slot1] then
		return
	end

	if not tabletool.indexOf(HotUpdateOptionPackageMgr.instance:getPackageNameList(), slot1) then
		-- Nothing
	end
end

function OptionPackageHttpWorker.againGetHttp(slot0, slot1, slot2)
	slot0._httpGetterOnFinshFunc = slot1
	slot0._httpGetterOnFinshObj = slot2

	for slot6, slot7 in pairs(slot0._httpGetterList) do
		if not slot0._httpGetterFinishDict[slot7:getHttpId()] then
			slot7:start(slot0._onHttpGetterFinish, slot0)
		end
	end
end

slot0.instance = slot0.New()

return slot0
