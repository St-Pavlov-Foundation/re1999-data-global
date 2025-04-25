module("modules.logic.activity.view.V2a7_Labor_FullSignView", package.seeall)

slot0 = class("V2a7_Labor_FullSignView", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDec = gohelper.findChildText(slot0.viewGO, "Root/image_DecBG/#txt_Dec")
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Root/Task/#go_NormalBG")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	slot0._simagereward = gohelper.findChildSingleImage(slot0.viewGO, "Root/Task/#go_NormalBG/#simage_reward")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "Root/Task/#go_canget")
	slot0._goFinishedBG = gohelper.findChild(slot0.viewGO, "Root/Task/#go_FinishedBG")
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

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""

	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function slot0.onOpen(slot0)
	slot0:internal_onOpen()
	slot0:_clearTimeTick()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0.onClose(slot0)
	slot0:_clearTimeTick()
end

function slot0.onDestroyView(slot0)
	Activity101SignViewBase._internal_onDestroy(slot0)
	slot0:_clearTimeTick()
end

function slot0._clearTimeTick(slot0)
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
