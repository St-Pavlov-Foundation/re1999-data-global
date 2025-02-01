slot0 = require("framework.helper.gohelper")

module("modules.logic.optionpackage.view.OptionPackageDownloadView", package.seeall)

slot1 = class("OptionPackageDownloadView", BaseView)

function slot1.onInitView(slot0)
	slot0._txtpercent = uv0.findChildText(slot0.viewGO, "view/progress/#txt_percent")
	slot0._imageprogress = uv0.findChildImage(slot0.viewGO, "view/progress/loadingline/#img_progress")
	slot0._goprogress = uv0.findChild(slot0.viewGO, "view/progress")
	slot0._gomessgeBox = uv0.findChild(slot0.viewGO, "view/#go_messgeBox")
	slot0._txtdesc = uv0.findChildText(slot0.viewGO, "view/#go_messgeBox/#txt_desc")
	slot0._btnyes = uv0.findChildButtonWithAudio(slot0.viewGO, "view/#go_messgeBox/#btn_yes")
	slot0._btnno = uv0.findChildButtonWithAudio(slot0.viewGO, "view/#go_messgeBox/#btn_no")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
end

function slot1.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
end

function slot1._btnyesOnClick(slot0)
	slot0:_closeInvokeCallback(true)
end

function slot1._btnnoOnClick(slot0)
	slot0:_closeInvokeCallback(false)
end

function slot1._editableInitView(slot0)
	slot0._goNo = slot0._btnno.gameObject
	slot0._goYes = slot0._btnyes.gameObject
	slot0._txtYes = uv0.findChildText(slot0._goYes, "#txt_confirm")
	slot0._txtNo = uv0.findChildText(slot0._goNo, "#txt_cancel")
	slot0._txtYesen = uv0.findChildText(slot0._goYes, "#txt_seitchen")
	slot0._txtNoen = uv0.findChildText(slot0._goNo, "#txt_cancelen")

	slot0:_showMessgeBoxGo(false)
end

function slot1.onOpen(slot0)
	slot0:addEventCb(OptionPackageController.instance, OptionPackageEvent.DownloadProgressRefresh, slot0._onDownloadProgress, slot0)
	slot0:addEventCb(OptionPackageController.instance, OptionPackageEvent.UnZipProgressRefresh, slot0._onUnZipProgress, slot0)
	slot0:addEventCb(OptionPackageController.instance, OptionPackageEvent.DownladErrorMsg, slot0._onDownladErrorMsg, slot0)
end

function slot1._show(slot0, slot1, slot2)
	slot0._imageprogress.fillAmount = slot1
	slot0._txtpercent.text = slot2
end

function slot1._onDownloadProgress(slot0, slot1, slot2, slot3)
	slot0._downProgressS1 = HotUpdateMgr.fixSizeStr(slot2)
	slot0._downProgressS2 = HotUpdateMgr.fixSizeStr(slot3)
	slot7 = nil

	slot0:_show(slot2 / slot3, (UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("download_info_wifi"), slot5, slot6)) and string.format(booterLang("download_info"), slot5, slot6))
end

function slot1._onUnZipProgress(slot0, slot1)
	slot2 = slot0._downProgressS1 or ""
	slot3 = slot0._downProgressS2 or ""
	slot4 = math.floor(100 * slot1 + 0.5)
	slot5 = nil
	slot0._txtpercent.text = (UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork or string.format(booterLang("unziping_progress_wifi"), tostring(slot4), slot2, slot3)) and string.format(booterLang("unziping_progress"), tostring(slot4), slot2, slot3)
end

function slot1._closeInvokeCallback(slot0, slot1)
	slot0:_showMessgeBoxGo(false)

	slot0._errorMsgInfo = nil

	if slot0._errorMsgInfo then
		if slot1 == true then
			if slot2.yesCallback then
				slot2.yesCallback(slot2.yesCallbackObj)
			end
		elseif slot2.noCallback then
			slot2.noCallback(slot2.noCallbackObj)
		end
	end
end

function slot1._showMessgeBoxGo(slot0, slot1)
	uv0.setActive(slot0._gomessgeBox, slot1)
	uv0.setActive(slot0._goprogress, slot1 == false)
end

function slot1._showErrorUI(slot0)
	slot0:_showMessgeBoxGo(slot0._errorMsgInfo ~= nil)

	if slot0._errorMsgInfo then
		slot0._txtdesc.text = slot0._errorMsgInfo.msg
		slot0._txtYes.text = slot0._errorMsgInfo.yesStr or luaLang("confirm")
		slot0._txtNo.text = slot0._errorMsgInfo.noStr or luaLang("cancel")
		slot0._txtYesen.text = slot0._errorMsgInfo.yesStrEn or "CONFIRM"
		slot0._txtNoen.text = slot0._errorMsgInfo.noStrEn or "CANCEL"
	end
end

function slot1._onDownladErrorMsg(slot0, slot1)
	slot0._errorMsgInfo = slot1

	slot0:_showErrorUI()
end

return slot1
