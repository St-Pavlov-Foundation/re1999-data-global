module("modules.logic.versionactivity1_4.act131.view.Activity131LogView", package.seeall)

local var_0_0 = class("Activity131LogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_close")
	arg_1_0._scrolllog = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_log")

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
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goEmpty = gohelper.findChild(arg_5_0.viewGO, "Empty")
	arg_5_0.goChapterRoot = gohelper.findChild(arg_5_0.viewGO, "Left/scroll_chapterlist/viewport/content")

	local var_5_0 = Activity131Model.instance:getLogCategortList()

	if #var_5_0 > 0 then
		Activity131Model.instance:setSelectLogType(var_5_0[1].logType)
	end

	local var_5_1 = arg_5_0.viewContainer:getSetting().otherRes[2]

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = arg_5_0:getResInst(var_5_1, arg_5_0.goChapterRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_5_2, Activity131LogCategoryItem):setInfo(iter_5_1.logType)
	end
end

function var_0_0.onOpen(arg_6_0)
	Activity131Controller.instance:registerCallback(Activity131Event.SelectCategory, arg_6_0._onSelectCategoryChange, arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0.onClose(arg_7_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.SelectCategory, arg_7_0._onSelectCategoryChange, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0._refreshView(arg_9_0)
	local var_9_0 = Activity131Model.instance:getLog()

	Activity131LogListModel.instance:setLogList(var_9_0)

	arg_9_0._scrolllog.verticalNormalizedPosition = 0

	gohelper.setActive(arg_9_0.goEmpty, not next(var_9_0))
end

function var_0_0._onSelectCategoryChange(arg_10_0)
	arg_10_0:_refreshView()
end

return var_0_0
