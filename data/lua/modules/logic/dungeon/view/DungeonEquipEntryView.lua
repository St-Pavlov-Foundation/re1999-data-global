module("modules.logic.dungeon.view.DungeonEquipEntryView", package.seeall)

slot0 = class("DungeonEquipEntryView", BaseView)

function slot0.onInitView(slot0)
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "#go_scroll")
	slot0._goslider = gohelper.findChild(slot0.viewGO, "#go_slider")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_right")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_left")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnright:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
end

function slot0.playBtnLeftOrRightAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
end

function slot0.setTargetPageIndex(slot0, slot1)
	slot0._pageIndex = slot1
end

function slot0.getTargetPageIndex(slot0)
	return slot0._pageIndex
end

function slot0._btnleftOnClick(slot0)
	slot0:setTargetPageIndex(slot0:getTargetPageIndex() - 1)
	slot0:selectHelpItem()
end

function slot0._btnrightOnClick(slot0)
	slot0:setTargetPageIndex(slot0:getTargetPageIndex() + 1)
	slot0:selectHelpItem()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(slot0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	slot0._selectItems = slot0:getUserDataTb_()
	slot0._helpItems = slot0:getUserDataTb_()
	slot0._space = recthelper.getWidth(slot0.viewGO.transform) + 400
	slot0._scroll = SLFramework.UGUI.UIDragListener.Get(slot0._goscroll)

	slot0._scroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0._scroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)
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
		slot0:setTargetPageIndex(slot0:getTargetPageIndex() - 1)
		slot0:selectHelpItem()
	elseif slot4 < -100 and slot0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		slot0:setTargetPageIndex(slot0:getTargetPageIndex() + 1)
		slot0:selectHelpItem()
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._chapterId = slot0.viewParam
	slot0._pagesCo = {}
	slot1 = DungeonConfig.instance:getChapterEpisodeCOList(slot0._chapterId)
	slot0._episodeCount = #slot1

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot0._pagesCo, slot7.id)

		if DungeonModel.instance:hasPassLevel(slot7.id) and DungeonModel.instance:getEpisodeInfo(slot7.id).challengeCount == 1 then
			slot2 = 0 + 1
		else
			slot0._readyChapterId = slot7.id

			break
		end
	end

	slot0:setTargetPageIndex(slot2 + 1)
	slot0:setSelectItem()
	slot0:setHelpItem()
	slot0:setBtnItem()
	slot0:selectHelpItem(true)
	NavigateMgr.instance:addEscape(ViewName.DungeonEquipEntryView, slot0.closeThis, slot0)
end

function slot0.setSelectItem(slot0)
	for slot5 = 1, #slot0._pagesCo do
		slot7 = DungeonEquipEntryViewSelectItem.New()

		slot7:init({
			go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goslider, "DungeonEquipEntryViewSelectItem"),
			index = slot5,
			config = slot0._pagesCo[slot5],
			pos = 55 * (slot5 - 0.5 * (#slot0._pagesCo + 1))
		})
		slot7:updateItem(slot0:getTargetPageIndex())
		table.insert(slot0._selectItems, slot7)
	end
end

function slot0.setHelpItem(slot0)
	for slot5 = 1, #slot0._pagesCo do
		slot6 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gocontent, "DungeonEquipEntryItem")

		transformhelper.setLocalPos(slot6.transform, slot0._space * (slot5 - 1), 0, 0)
		table.insert(slot0._helpItems, MonoHelper.addNoUpdateLuaComOnceToGo(slot6, DungeonEquipEntryItem, {
			slot5,
			slot0._episodeCount,
			slot0._pagesCo[slot5],
			#slot0._pagesCo
		}))
	end
end

function slot0.setBtnItem(slot0)
	gohelper.setActive(slot0._btnright.gameObject, slot0:getTargetPageIndex() < #slot0._pagesCo)
	gohelper.setActive(slot0._btnleft.gameObject, slot1 > 1)
end

function slot0.selectHelpItem(slot0, slot1)
	for slot5, slot6 in pairs(slot0._selectItems) do
		slot6:updateItem(slot0:getTargetPageIndex())
	end

	if slot1 then
		recthelper.setAnchorX(slot0._gocontent.transform, (1 - slot0:getTargetPageIndex()) * slot0._space)
	else
		ZProj.TweenHelper.DOAnchorPosX(slot0._gocontent.transform, slot2, 0.25)
	end

	slot0:setBtnItem()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

function slot0.onDestroyView(slot0)
	if slot0._selectItems then
		for slot4, slot5 in pairs(slot0._selectItems) do
			slot5:destroy()
		end

		slot0._selectItems = nil
	end

	slot0._scroll:RemoveDragBeginListener()
	slot0._scroll:RemoveDragEndListener()
end

return slot0
