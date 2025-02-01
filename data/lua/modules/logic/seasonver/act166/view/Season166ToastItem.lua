module("modules.logic.seasonver.act166.view.Season166ToastItem", package.seeall)

slot0 = class("Season166ToastItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._toastItem = slot1
	slot0._toastParams = slot2
	slot0._rootGO = slot0._toastItem:getToastRootByType(ToastItem.ToastType.Season166)

	slot0:_onUpdate()
end

slot0.ToastGOName = "Season166ToastItem"

function slot0._onUpdate(slot0)
	slot0.viewGO = gohelper.findChild(slot0._rootGO, uv0.ToastGOName)

	if not slot0.viewGO and Season166Controller.instance:tryGetToastAsset(slot0._onToastLoadedCallBack, slot0) then
		slot0.viewGO = gohelper.clone(slot1, slot0._rootGO, uv0.ToastGOName)
	end

	if slot0.viewGO then
		slot0:initComponents()
		slot0:refreshUI()
	end
end

function slot0._onToastLoadedCallBack(slot0, slot1)
	slot0:_onUpdate()
end

function slot0.initComponents(slot0)
	if slot0.viewGO then
		slot0._txtToast = gohelper.findChildText(slot0.viewGO, "#go_tips/txt_tips")
		slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "#go_tips/icon")
	end
end

function slot0.refreshUI(slot0)
	slot0._txtToast.text = tostring(slot0._toastParams.toastTip)

	UISpriteSetMgr.instance:setSeason166Sprite(slot0._imageIcon, string.format("season166_result_tipsicon%s", slot0._toastParams.icon or 2))
	slot0._toastItem:setToastType(ToastItem.ToastType.Season166)
end

function slot0.dispose(slot0)
	if slot0._toastLoader then
		slot0._toastLoader:dispose()

		slot0._toastLoader = nil
	end

	if slot0._simageAssessIcon then
		slot0._simageAssessIcon:UnLoadImage()
	end

	slot0._toastItem = nil
	slot0._toastParams = nil

	slot0:__onDispose()
end

return slot0
