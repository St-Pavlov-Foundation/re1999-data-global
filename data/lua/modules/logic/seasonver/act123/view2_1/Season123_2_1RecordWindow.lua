module("modules.logic.seasonver.act123.view2_1.Season123_2_1RecordWindow", package.seeall)

local var_0_0 = class("Season123_2_1RecordWindow", BaseView)
local var_0_1 = 5
local var_0_2 = 0.06
local var_0_3 = 0.2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gobestrecorditem = gohelper.findChild(arg_1_0.viewGO, "#go_bestrecorditem")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_recordlist/Viewport/Content")
	arg_1_0._gorecorditem = gohelper.findChild(arg_1_0.viewGO, "#scroll_recordlist/Viewport/Content/#go_recorditem")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:onClickModalMask()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gorecorditem, false)
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = Season123RecordModel.instance:getRecordList(true)

	if var_7_0 and #var_7_0 > 0 then
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._gobestrecorditem, Season123_2_1RecordWindowItem):onUpdateMO(var_7_0[1])
		gohelper.setActive(arg_7_0._gobestrecorditem, true)
	else
		gohelper.setActive(arg_7_0._gobestrecorditem, false)
	end

	local var_7_1 = Season123RecordModel.instance:getRecordList(false)

	if var_7_1 and #var_7_1 > 0 then
		gohelper.setActive(arg_7_0._goempty, false)
		UIBlockMgr.instance:startBlock(arg_7_0.viewName .. "itemPlayAnim")
		gohelper.CreateObjList(arg_7_0, arg_7_0._onRecordItemLoad, var_7_1, arg_7_0._goContent, arg_7_0._gorecorditem, Season123_2_1RecordWindowItem)

		local var_7_2 = var_0_1 * var_0_2 + var_0_3

		TaskDispatcher.runDelay(arg_7_0._onItemPlayAnimFinish, arg_7_0, var_7_2)
	else
		gohelper.setActive(arg_7_0._goempty, true)
	end
end

function var_0_0._onRecordItemLoad(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_2 then
		return
	end

	local var_8_0 = arg_8_3
	local var_8_1 = true

	if arg_8_3 > var_0_1 then
		var_8_0 = var_0_1
		var_8_1 = false
	end

	local var_8_2 = var_8_0 * var_0_2

	if not arg_8_2.isEmpty then
		arg_8_1:onLoad(var_8_2, var_8_1)
	end

	arg_8_1:onUpdateMO(arg_8_2)
end

function var_0_0._onItemPlayAnimFinish(arg_9_0)
	UIBlockMgr.instance:endBlock(arg_9_0.viewName .. "itemPlayAnim")
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onItemPlayAnimFinish, arg_10_0)
	arg_10_0:_onItemPlayAnimFinish()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
