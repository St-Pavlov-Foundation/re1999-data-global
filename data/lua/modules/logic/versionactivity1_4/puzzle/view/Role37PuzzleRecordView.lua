module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordView", package.seeall)

local var_0_0 = class("Role37PuzzleRecordView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnCloseMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_CloseMask")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_Title")
	arg_1_0._scrollList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_List")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_Empty")
	arg_1_0._txtEmpty = gohelper.findChildText(arg_1_0.viewGO, "#go_Empty/#txt_Empty")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._itemPrefab = gohelper.findChild(arg_1_0.viewGO, "#scroll_List/Viewport/Content/RecordItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseMask:AddClickListener(arg_2_0._btnCloseMaskOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseMask:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseMaskOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	Role37PuzzleController.instance:registerCallback(Role37PuzzleEvent.RecordCntChange, arg_6_0.onRecordChange, arg_6_0)

	local var_6_0 = PuzzleRecordListModel.instance:getCount()

	arg_6_0:onRecordChange(var_6_0)
	arg_6_0:initRecordItem()
end

function var_0_0.onDestroyView(arg_7_0)
	Role37PuzzleController.instance:unregisterCallback(Role37PuzzleEvent.RecordCntChange, arg_7_0.onRecordChange, arg_7_0)
end

function var_0_0.onRecordChange(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goEmpty, arg_8_1 <= 0)
end

function var_0_0.initRecordItem(arg_9_0)
	local var_9_0 = PuzzleRecordListModel.instance:getList()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._itemPrefab)

		gohelper.setActive(var_9_1, true)
		MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, PuzzleRecordViewItem):onUpdateMO(iter_9_1)
	end
end

return var_0_0
