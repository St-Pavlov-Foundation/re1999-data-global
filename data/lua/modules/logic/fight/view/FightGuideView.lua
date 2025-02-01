module("modules.logic.fight.view.FightGuideView", package.seeall)

slot0 = class("FightGuideView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goslider = gohelper.findChild(slot0.viewGO, "#go_slider")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "mask/#go_content")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "#go_scroll")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_right")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if slot0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		slot0:_setSelect(slot0._index + 1)
	else
		slot0:closeThis()
	end
end

function slot0._btnleftOnClick(slot0)
	slot0:_setSelect(slot0._index - 1)
end

function slot0._btnrightOnClick(slot0)
	slot0:_setSelect(slot0._index + 1)
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(slot0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	slot0._selectItems = {}
	slot0._contentItems = {}
	slot0._space = recthelper.getWidth(slot0._gocontent.transform)
	slot0._scroll = SLFramework.UGUI.UIDragListener.Get(slot0._goscroll)

	slot0._scroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0._scroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._scroll:RemoveDragBeginListener()
	slot0._scroll:RemoveDragEndListener()
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0._scrollStartPos = slot2.position
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	slot3 = slot2.position

	if math.abs(slot3.x - slot0._scrollStartPos.x) < math.abs(slot3.y - slot0._scrollStartPos.y) then
		return
	end

	if slot4 > 100 and slot0._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		slot0:_setSelect(slot0._index - 1)
	elseif slot4 < -100 and slot0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		slot0:_setSelect(slot0._index + 1)
	end
end

function slot0.onUpdateParam(slot0)
	if slot0._contentItems then
		for slot4, slot5 in pairs(slot0._contentItems) do
			gohelper.destroy(slot5.go)
		end
	end

	slot0._contentItems = {}

	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	if slot0.viewParam then
		slot0._list = slot0.viewParam.viewParam
	else
		slot0._list = {
			1,
			2,
			3,
			4,
			5
		}
	end

	slot0:_setSelectItems()
	slot0:_setContentItems()
	slot0:_setSelect(1)
	gohelper.setActive(slot0._goslider, #slot0._list > 1)
end

function slot0._setSelectItems(slot0, slot1)
	for slot6 = 1, #slot0._list do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goslider, "SelectItem" .. slot6), FightTechniqueSelectItem)

		slot8:updateItem({
			index = slot6,
			pos = 55 * (slot6 - 0.5 * (#slot0._list + 1))
		})
		slot8:setView(slot0)
		table.insert(slot0._selectItems, slot8)
	end
end

function slot0._setContentItems(slot0)
	for slot6 = #slot0._list, 1, -1 do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gocontent, "ContentItem" .. slot6), FightGuideItem)

		slot8:updateItem({
			index = slot6,
			maxIndex = slot2,
			id = slot0._list[slot6],
			pos = slot0._space * (slot6 - 1)
		})

		slot0._contentItems[slot6] = slot8
	end
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnright.gameObject, slot0._index < #slot0._list)
	gohelper.setActive(slot0._btnleft.gameObject, slot0._index > 1)
end

function slot0.setSelect(slot0, slot1)
	slot0:_setSelect(slot1)
end

function slot0._setSelect(slot0, slot1)
	slot0._index = slot1

	for slot5, slot6 in pairs(slot0._selectItems) do
		slot6:setSelect(slot1)
	end

	for slot5, slot6 in pairs(slot0._contentItems) do
		slot6:setSelect(slot1)
	end

	ZProj.TweenHelper.DOAnchorPosX(slot0._gocontent.transform, (1 - slot0._index) * slot0._space, 0.25)
	slot0:_updateBtns()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

return slot0
