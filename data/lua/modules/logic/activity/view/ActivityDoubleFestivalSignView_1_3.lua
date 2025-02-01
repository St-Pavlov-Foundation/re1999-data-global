module("modules.logic.activity.view.ActivityDoubleFestivalSignView_1_3", package.seeall)

slot0 = class("ActivityDoubleFestivalSignView_1_3", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/#txt_LimitTime")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_fulltitle"))
	slot0._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_fullbg"))
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
	slot0._simageTitle:UnLoadImage()
	slot0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_refreshTimeTick()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0.updateRewardCouldGetHorizontalScrollPixel(slot0)
	slot1, slot2 = slot0:getRewardCouldGetIndex()
	slot3 = slot0.viewContainer:getCsListScroll()
	slot4 = slot0.viewContainer:getListScrollParam()
	slot3.HorizontalScrollPixel = math.max(0, (slot4.cellWidth + slot4.cellSpaceH) * math.max(0, slot2 <= 4 and slot2 - 4 or 10))

	slot3:UpdateCells(false)
end

return slot0
