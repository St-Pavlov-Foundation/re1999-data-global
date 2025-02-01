module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffListItem", package.seeall)

slot0 = class("RougeLimiterBuffListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagebuffbg = gohelper.findChildImage(slot0.viewGO, "#image_buffbg")
	slot0._imagebufficon = gohelper.findChildImage(slot0.viewGO, "#image_bufficon")
	slot0._goequiped = gohelper.findChild(slot0.viewGO, "#go_equiped")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._gounnecessary = gohelper.findChild(slot0.viewGO, "#go_unnecessary")
	slot0._txtunnecessary = gohelper.findChildText(slot0.viewGO, "#go_unnecessary/txt_unnecessary")
	slot0._gocd = gohelper.findChild(slot0.viewGO, "#go_cd")
	slot0._txtcd = gohelper.findChildText(slot0.viewGO, "#go_cd/#txt_cd")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._lockedAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._golocked)
	slot0._isSelect = false
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, slot0._onUpdateBuffState, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	slot1 = not slot0._isSelect

	slot0._view:selectCell(slot0._index, slot1)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.OnSelectBuff, slot0._mo.id, slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._buffState = nil

	slot0:refreshSelectUI()
	slot0:refreshBuff()
end

function slot0.refreshBuff(slot0)
	slot0:refreshBuffState()
	UISpriteSetMgr.instance:setRouge4Sprite(slot0._imagebufficon, slot0._mo.icon)
	UISpriteSetMgr.instance:setRouge3Sprite(slot0._imagebuffbg, "rouge_dlc1_buffbg" .. slot0._mo.buffType)
end

function slot0.refreshSelectUI(slot0)
	gohelper.setActive(slot0._goselect, slot0._view:getFirstSelect() == slot0._mo)
end

function slot0.refreshBuffState(slot0)
	slot1 = RougeDLCModel101.instance:getLimiterBuffState(slot0._mo.id)
	slot0._buffState = slot1

	slot0._lockedAnimator:Stop()

	if slot0._buffState == RougeDLCEnum101.BuffState.Locked and slot1 ~= RougeDLCEnum101.BuffState.Locked then
		slot0._lockedAnimator:Play("unlock", slot0.refreshUI, slot0)

		return
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._golocked, slot0._buffState == RougeDLCEnum101.BuffState.Locked)
	gohelper.setActive(slot0._goequiped, slot0._buffState == RougeDLCEnum101.BuffState.Equiped)
	gohelper.setActive(slot0._gocd, slot0._buffState == RougeDLCEnum101.BuffState.CD)
	gohelper.setActive(slot0._gounnecessary, slot0._mo.blank == 1)

	if slot0._buffState == RougeDLCEnum101.BuffState.CD then
		slot0._txtcd.text = RougeDLCModel101.instance:getLimiterBuffCD(slot0._mo.id)
	end
end

function slot0._onUpdateBuffState(slot0, slot1)
	slot0:refreshBuffState()
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
