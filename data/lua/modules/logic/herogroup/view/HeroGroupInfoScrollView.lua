module("modules.logic.herogroup.view.HeroGroupInfoScrollView", package.seeall)

slot0 = class("HeroGroupInfoScrollView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#go_container/#scroll_info")
	slot0._container = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain")
	slot0._arrow = gohelper.findChild(slot0.viewGO, "#go_container/#go_arrow")
end

function slot0.addEvents(slot0)
	slot0._scrollinfo:AddOnValueChanged(slot0.onValueChange, slot0)
	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollinfo:RemoveOnValueChanged()
	slot0:removeEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._refreshUI, slot0)
end

function slot0._refreshUI(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._scrollinfo.transform)
end

function slot0.onOpen(slot0)
	slot0._scrollHeight = recthelper.getHeight(slot0._scrollinfo.transform)

	TaskDispatcher.runRepeat(slot0._checkContainHeight, slot0, 0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._checkContainHeight, slot0)
end

function slot0._checkContainHeight(slot0)
	if recthelper.getHeight(slot0._container.transform) == slot0._containerHeight then
		return
	end

	slot0._containerHeight = slot1
	slot0._showArrow = slot0._scrollHeight < slot0._containerHeight

	gohelper.setActive(slot0._arrow, slot0._showArrow)
end

function slot0.onValueChange(slot0, slot1, slot2)
	if not slot0._showArrow then
		return
	end

	gohelper.setActive(slot0._arrow, slot2 > 0)
end

return slot0
