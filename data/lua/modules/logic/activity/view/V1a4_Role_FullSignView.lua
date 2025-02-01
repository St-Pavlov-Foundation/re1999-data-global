module("modules.logic.activity.view.V1a4_Role_FullSignView", package.seeall)

slot0 = class("V1a4_Role_FullSignView", Activity101SignViewBase)

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

	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.MainActivityCenterView)
	slot0:internal_onOpen()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0._updateScrollViewPos(slot0)
	if slot0._isFirstUpdateScrollPos then
		return
	end

	slot0._isFirstUpdateScrollPos = true

	slot0:updateRewardCouldGetHorizontalScrollPixel(function (slot0)
		if slot0 <= 4 then
			return slot0 - 4
		else
			return uv0:getTempDataList() and #slot1 or slot0
		end
	end)
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
	slot0:_updateScrollViewPos()
	slot0:_refreshTimeTick()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0._setPinStartIndex(slot0, slot1)
	slot2, slot3 = slot0:getRewardCouldGetIndex()

	slot0.viewContainer:getScrollModel():setStartPinIndex(slot3 <= 4 and 1 or 3)
end

return slot0
