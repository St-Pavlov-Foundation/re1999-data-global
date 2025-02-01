module("modules.logic.activity.view.V2a1_Role_FullSignView", package.seeall)

slot0 = class("V2a1_Role_FullSignView", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity101SignViewBase.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	Activity101SignViewBase.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0._txtLimitTime.text = ""

	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	slot0:internal_onOpen()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0.onClose(slot0)
	slot0._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onDestroyView(slot0)
	Activity101SignViewBase._internal_onDestroy(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageTitle:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_refreshTimeTick()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

return slot0
