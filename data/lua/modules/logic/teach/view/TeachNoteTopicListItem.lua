module("modules.logic.teach.view.TeachNoteTopicListItem", package.seeall)

slot0 = class("TeachNoteTopicListItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.go = slot1
	slot0.id = slot2
	slot0.index = slot3
	slot0._showReward = slot4
	slot0._allFinishState = slot5
	slot0._goSelected = gohelper.findChild(slot1, "go_selected")
	slot0._imagebg = gohelper.findChildImage(slot1, "image_bg")
	slot0._txtSelectCn = gohelper.findChildText(slot1, "go_selected/txt_itemcn2")
	slot0._goSelectFinish = gohelper.findChild(slot1, "go_selected/go_finish2")
	slot0._txtSelectEn = gohelper.findChildText(slot1, "go_selected/txt_itemen2")
	slot0._goUnselected = gohelper.findChild(slot1, "go_unselected")
	slot0._txtUnselectCn = gohelper.findChildText(slot1, "go_unselected/txt_itemcn1")
	slot0._goUnselectFinish = gohelper.findChild(slot1, "go_unselected/go_finish1")
	slot0._txtUnselectEn = gohelper.findChildText(slot1, "go_unselected/txt_itemen1")
	slot0._goLocked = gohelper.findChild(slot1, "go_locked")
	slot0._goReddot = gohelper.findChild(slot1, "redpoint")
	slot0._itemClick = gohelper.getClickWithAudio(slot1)

	slot0:addEvents()
	slot0:_refreshItem()
end

function slot0.addEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	TeachNoteController.instance:registerCallback(TeachNoteEvent.ClickTopicItem, slot0._refreshItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._itemClick:RemoveClickListener()
	TeachNoteController.instance:unregisterCallback(TeachNoteEvent.ClickTopicItem, slot0._refreshItem, slot0)
end

function slot0._onItemClick(slot0)
	if slot0.id == TeachNoteModel.instance:getTeachNoticeTopicId() then
		return
	end

	if not TeachNoteModel.instance:isTopicUnlock(slot0.id) then
		GameFacade.showToast(ToastEnum.TeachNoteTopic)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_no_requirement)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_activity_switch)
	TeachNoteModel.instance:setTeachNoticeTopicId(slot0.id, 0)
	TeachNoteController.instance:dispatchEvent(TeachNoteEvent.ClickTopicItem, slot0.id)
end

function slot0._refreshItem(slot0)
	if TeachNoteModel.instance:isTopicUnlock(slot0.id) then
		slot2 = TeachNoteModel.instance:getTeachNoticeTopicId()

		if slot0._showReward then
			slot2 = 0
		end

		UISpriteSetMgr.instance:setTeachNoteSprite(slot0._imagebg, slot2 == slot0.id and "bg_jiaoxuebiji_biaoqian_" .. slot0.index .. "_ovr" or "bg_jiaoxuebiji_biaoqian_" .. slot0.index)
		gohelper.setActive(slot0._goSelected, slot2 == slot0.id)
		gohelper.setActive(slot0._goUnselected, slot2 ~= slot0.id)
		gohelper.setActive(slot0._goLocked, false)
		gohelper.setActive(slot0._goSelectFinish, slot0._allFinishState)
		gohelper.setActive(slot0._goUnselectFinish, slot0._allFinishState)

		slot5 = DungeonConfig.instance:getChapterCO(TeachNoteConfig.instance:getInstructionTopicCO(slot0.id).chapterId).name
		slot0._txtSelectCn.text = slot5
		slot0._txtUnselectCn.text = slot5
	else
		gohelper.setActive(slot0._goSelected, false)
		gohelper.setActive(slot0._goUnselected, false)
		gohelper.setActive(slot0._goLocked, true)
		UISpriteSetMgr.instance:setTeachNoteSprite(slot0._imagebg, "bg_jiaoxuebiji_biaoqian_" .. slot0.index .. "_dis")
	end

	gohelper.setActive(slot0._goReddot, TeachNoteModel.instance:isTopicNew(slot0.id))
end

function slot0.onDestroyView(slot0)
	slot0:removeEvents()
	gohelper.destroy(slot0.go)
end

return slot0
