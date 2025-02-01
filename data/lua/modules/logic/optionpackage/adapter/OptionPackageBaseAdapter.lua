module("modules.logic.optionpackage.adapter.OptionPackageBaseAdapter", package.seeall)

slot0 = class("OptionPackageBaseAdapter")

function slot0.ctor(slot0)
end

function slot0.setDownloder(slot0, slot1, slot2)
	slot0._downloader = slot1
	slot0._httpWorker = slot2
end

function slot0.getHttpGetterList(slot0)
	logError("[OptionPackageBaseAdapter:getHttpGetterList()]子类及派生类重新该接口")
end

function slot0.getDownloadList(slot0)
	logError("[OptionPackageBaseAdapter:getHttpGetterList()]子类及派生类重新该接口")
end

function slot0.getDownloadUrl(slot0, slot1)
	if slot0._httpWorker then
		return slot0._httpWorker:getDownloadUrl(slot1)
	end
end

function slot0.onDownloadStart(slot0, slot1, slot2, slot3)
end

function slot0.onDownloadProgressRefresh(slot0, slot1, slot2, slot3)
end

function slot0.onDownloadPackSuccess(slot0, slot1)
end

function slot0.onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
end

function slot0.onNotEnoughDiskSpace(slot0, slot1)
end

function slot0.onUnzipProgress(slot0, slot1)
end

function slot0.onPackUnZipFail(slot0, slot1, slot2)
end

function slot0.onPackItemStateChange(slot0, slot1)
end

return slot0
