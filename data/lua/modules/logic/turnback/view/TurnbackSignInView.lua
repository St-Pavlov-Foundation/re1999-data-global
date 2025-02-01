module("modules.logic.turnback.view.TurnbackSignInView", package.seeall)

slot0 = class("TurnbackSignInView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "tips/#txt_desc")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "tips/#txt_time")
	slot0._scrolldaylist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_daylist")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_daylist/Viewport/#go_content")
	slot0._rectMask2d = gohelper.findChild(slot0.viewGO, "#scroll_daylist/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._mask = gohelper.findChild(slot0.viewGO, "#scroll_daylist/Viewport"):GetComponent(typeof(UnityEngine.UI.Mask))
	slot0._maskImage = gohelper.findChild(slot0.viewGO, "#scroll_daylist/Viewport"):GetComponent(gohelper.Type_Image)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInScroll, slot0._refreshScrollPos, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
	slot0._scrolldaylist:AddOnValueChanged(slot0._onScrollValueChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInScroll, slot0._refreshScrollPos, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
	slot0._scrolldaylist:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_signfullbg"))
end

function slot0.onOpen(slot0)
	slot0.viewConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0.viewParam.actId)

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:_refreshUI()
	TurnbackSignInModel.instance:setOpenTimeStamp()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function slot0._refreshUI(slot0)
	slot0._txtdesc.text = slot0.viewConfig.actDesc

	slot0:_refreshRemainTime()
	slot0:_refreshScrollPos()
	slot0:_refreshMaskShowState()
end

function slot0._refreshRemainTime(slot0)
	slot0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function slot0._refreshScrollPos(slot0)
	slot2 = TurnbackModel.instance:getCurSignInDay()
	slot4 = slot0.viewContainer._scrollView:getCsListScroll()
	slot5 = slot0.viewContainer._scrollParam
	slot8 = 0
	slot10 = GameUtil.getTabLen(TurnbackSignInModel.instance:getSignInInfoMoList()) - 7
	slot11 = slot5.cellWidth + slot5.cellSpaceH
	slot4.HorizontalScrollPixel = math.max(0, TurnbackSignInModel.instance:getTheFirstCanGetIndex() ~= 0 and (slot10 < slot1 - 1 and slot11 * (slot10 + 1) or slot11 * math.max(0, slot1 - 2)) or slot10 < slot2 and slot11 * (slot10 + 1) or slot11 * (slot2 - 1))

	slot4:UpdateCells(true)
end

function slot0._onScrollValueChange(slot0)
	slot0._rectMask2d.enabled = slot0._scrolldaylist.horizontalNormalizedPosition < 0.95
end

function slot0._refreshMaskShowState(slot0)
	slot3 = recthelper.getWidth(slot0._scrolldaylist.gameObject.transform) < recthelper.getWidth(slot0._gocontent.transform)
	slot0._rectMask2d.enabled = slot3
	slot0._mask.enabled = slot3
	slot0._maskImage.enabled = slot3
end

function slot0.onClose(slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
