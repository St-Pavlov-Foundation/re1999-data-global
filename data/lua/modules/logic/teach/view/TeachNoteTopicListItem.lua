module("modules.logic.teach.view.TeachNoteTopicListItem", package.seeall)

local var_0_0 = class("TeachNoteTopicListItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.go = arg_1_1
	arg_1_0.id = arg_1_2
	arg_1_0.index = arg_1_3
	arg_1_0._showReward = arg_1_4
	arg_1_0._allFinishState = arg_1_5
	arg_1_0._goSelected = gohelper.findChild(arg_1_1, "go_selected")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_1, "image_bg")
	arg_1_0._txtSelectCn = gohelper.findChildText(arg_1_1, "go_selected/txt_itemcn2")
	arg_1_0._goSelectFinish = gohelper.findChild(arg_1_1, "go_selected/go_finish2")
	arg_1_0._txtSelectEn = gohelper.findChildText(arg_1_1, "go_selected/txt_itemen2")
	arg_1_0._goUnselected = gohelper.findChild(arg_1_1, "go_unselected")
	arg_1_0._txtUnselectCn = gohelper.findChildText(arg_1_1, "go_unselected/txt_itemcn1")
	arg_1_0._goUnselectFinish = gohelper.findChild(arg_1_1, "go_unselected/go_finish1")
	arg_1_0._txtUnselectEn = gohelper.findChildText(arg_1_1, "go_unselected/txt_itemen1")
	arg_1_0._goLocked = gohelper.findChild(arg_1_1, "go_locked")
	arg_1_0._goReddot = gohelper.findChild(arg_1_1, "redpoint")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_1)

	arg_1_0:addEvents()
	arg_1_0:_refreshItem()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	TeachNoteController.instance:registerCallback(TeachNoteEvent.ClickTopicItem, arg_2_0._refreshItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
	TeachNoteController.instance:unregisterCallback(TeachNoteEvent.ClickTopicItem, arg_3_0._refreshItem, arg_3_0)
end

function var_0_0._onItemClick(arg_4_0)
	local var_4_0 = TeachNoteModel.instance:getTeachNoticeTopicId()

	if arg_4_0.id == var_4_0 then
		return
	end

	if not TeachNoteModel.instance:isTopicUnlock(arg_4_0.id) then
		GameFacade.showToast(ToastEnum.TeachNoteTopic)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_no_requirement)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_activity_switch)
	TeachNoteModel.instance:setTeachNoticeTopicId(arg_4_0.id, 0)
	TeachNoteController.instance:dispatchEvent(TeachNoteEvent.ClickTopicItem, arg_4_0.id)
end

function var_0_0._refreshItem(arg_5_0)
	if TeachNoteModel.instance:isTopicUnlock(arg_5_0.id) then
		local var_5_0 = TeachNoteModel.instance:getTeachNoticeTopicId()

		if arg_5_0._showReward then
			var_5_0 = 0
		end

		local var_5_1 = var_5_0 == arg_5_0.id and "bg_jiaoxuebiji_biaoqian_" .. arg_5_0.index .. "_ovr" or "bg_jiaoxuebiji_biaoqian_" .. arg_5_0.index

		UISpriteSetMgr.instance:setTeachNoteSprite(arg_5_0._imagebg, var_5_1)
		gohelper.setActive(arg_5_0._goSelected, var_5_0 == arg_5_0.id)
		gohelper.setActive(arg_5_0._goUnselected, var_5_0 ~= arg_5_0.id)
		gohelper.setActive(arg_5_0._goLocked, false)
		gohelper.setActive(arg_5_0._goSelectFinish, arg_5_0._allFinishState)
		gohelper.setActive(arg_5_0._goUnselectFinish, arg_5_0._allFinishState)

		local var_5_2 = TeachNoteConfig.instance:getInstructionTopicCO(arg_5_0.id).chapterId
		local var_5_3 = DungeonConfig.instance:getChapterCO(var_5_2).name

		arg_5_0._txtSelectCn.text = var_5_3
		arg_5_0._txtUnselectCn.text = var_5_3
	else
		gohelper.setActive(arg_5_0._goSelected, false)
		gohelper.setActive(arg_5_0._goUnselected, false)
		gohelper.setActive(arg_5_0._goLocked, true)
		UISpriteSetMgr.instance:setTeachNoteSprite(arg_5_0._imagebg, "bg_jiaoxuebiji_biaoqian_" .. arg_5_0.index .. "_dis")
	end

	gohelper.setActive(arg_5_0._goReddot, TeachNoteModel.instance:isTopicNew(arg_5_0.id))
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0:removeEvents()
	gohelper.destroy(arg_6_0.go)
end

return var_0_0
