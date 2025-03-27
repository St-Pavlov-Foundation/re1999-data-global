module("projbooter.hotupdate.optionpackage.HotUpateOptionPackageAdapter", package.seeall)

slot0 = class("HotUpateOptionPackageAdapter")

function slot0.ctor(slot0)
	slot0._downloadSuccSize = 0
end

function slot0.getHttpGetterList(slot0)
	slot2 = {}

	if HotUpdateOptionPackageMgr.instance:getHotUpdateLangPacks() and #slot1 > 0 then
		table.insert(slot2, OptionPackageHttpGetter.New(3, slot1))
	end

	return slot2
end

function slot0.setDownloder(slot0, slot1, slot2)
	slot0._downloader = slot1
	slot0._packageMgr = slot2 or HotUpdateOptionPackageMgr.instance
end

function slot0._downloadRetry(slot0)
	slot0._downloader:retry()
end

function slot0._quitGame(slot0)
	ProjBooter.instance:quitGame()
end

function slot0._fixSizeStr(slot0, slot1)
	return HotUpdateMgr.fixSizeStr(slot1)
end

function slot0._fixSizeMB(slot0, slot1)
	return HotUpdateMgr.fixSizeMB(slot1)
end

function slot0.onDownloadStart(slot0, slot1, slot2, slot3)
end

function slot0.onDownloadProgressRefresh(slot0, slot1, slot2, slot3)
	logNormal("HotUpateOptionPackageAdapter:onDownloadProgressRefresh, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)

	slot4 = slot0._downloader:getDownloadSize()
	slot5 = slot0._downloader:getTotalSize()
	slot0._downProgressS1 = slot0:_fixSizeStr(slot4)
	slot0._downProgressS2 = slot0:_fixSizeStr(slot5)
	slot9 = nil

	BootLoadingView.instance:show(slot4 / slot5, (UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("download_info_wifi"), slot7, slot8)) and string.format(booterLang("download_info"), slot7, slot8))
end

function slot0.onDownloadPackSuccess(slot0, slot1)
end

function slot0.onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
	if slot3 == 5 then
		slot0:onNotEnoughDiskSpace(slot1)
	else
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = OptionPackageDownloader.getDownloadFailedTip(slot3, slot4),
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0._downloadRetry,
			rightCbObj = slot0
		})
	end
end

function slot0.onNotEnoughDiskSpace(slot0, slot1)
	logNormal("HotUpateOptionPackageAdapter:_onNotEnoughDiskSpace, packName = " .. slot1)
	BootMsgBox.instance:show({
		title = booterLang("hotupdate"),
		content = booterLang("download_fail_no_enough_disk"),
		rightMsg = booterLang("exit"),
		rightCb = slot0._quitGame,
		rightCbObj = slot0
	})
end

function slot0.onUnzipProgress(slot0, slot1)
	if tostring(slot1) == "nan" then
		return
	end

	slot2 = slot0._downProgressS1 or ""
	slot3 = slot0._downProgressS2 or ""
	slot4 = math.floor(100 * slot1 + 0.5)
	slot5 = nil

	BootLoadingView.instance:setProgressMsg((UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("unziping_progress_wifi"), tostring(slot4), slot2, slot3)) and string.format(booterLang("unziping_progress"), tostring(slot4), slot2, slot3))
end

function slot0.onPackUnZipFail(slot0, slot1, slot2)
	if slot1 then
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = OptionPackageDownloader._getUnzipFailedTip(slot2),
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("retry"),
			rightCb = slot0._downloadRetry,
			rightCbObj = slot0
		})
	end
end

function slot0.onPackItemStateChange(slot0, slot1)
end

return slot0
