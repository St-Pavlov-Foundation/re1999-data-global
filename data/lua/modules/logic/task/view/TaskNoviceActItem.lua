module("modules.logic.task.view.TaskNoviceActItem", package.seeall)

local var_0_0 = class("TaskNoviceActItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._tag = arg_1_2
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "unselected")
	arg_1_0._gounselecticon = gohelper.findChild(arg_1_1, "unselected/icon")
	arg_1_0._gounselectlock = gohelper.findChild(arg_1_1, "unselected/lock")
	arg_1_0._txtunselectTitle = gohelper.findChildText(arg_1_0._gounselect, "act")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "selected")
	arg_1_0._goselecticon = gohelper.findChild(arg_1_1, "selected/icon")
	arg_1_0._goselectlock = gohelper.findChild(arg_1_1, "selected/lock")
	arg_1_0._txtselectTitle = gohelper.findChildText(arg_1_0._goselect, "act")

	local var_1_0 = gohelper.findChild(arg_1_1, "click")

	arg_1_0._btnClick = gohelper.getClickWithAudio(var_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	gohelper.setActive(arg_2_0.go, true)
	gohelper.setActive(arg_2_0._goselected, false)
	gohelper.setActive(arg_2_0._gounselected, false)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnActItemOnClick, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.RefreshActState, arg_2_0._refreshItem, arg_2_0)
	arg_2_0:_refreshItem()
end

function var_0_0._btnActItemOnClick(arg_3_0)
	if arg_3_0._tag == TaskModel.instance:getNoviceTaskCurSelectStage() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_act)

	local var_3_0 = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	if var_3_0 >= arg_3_0._tag then
		TaskModel.instance:setNoviceTaskCurStage(arg_3_0._tag)
	end

	TaskModel.instance:setNoviceTaskCurSelectStage(arg_3_0._tag)

	local var_3_1 = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(var_3_1 + 1)

	local var_3_2 = {}

	var_3_2.isActClick = true

	TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem, var_3_2)

	local var_3_3 = {}

	var_3_3.num = 0
	var_3_3.taskType = TaskEnum.TaskType.Novice
	var_3_3.force = var_3_0 >= arg_3_0._tag

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, var_3_3)
end

function var_0_0._refreshItem(arg_4_0, arg_4_1)
	local var_4_0 = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	local var_4_1 = TaskModel.instance:getNoviceTaskCurStage()
	local var_4_2 = TaskModel.instance:getNoviceTaskCurSelectStage()

	gohelper.setActive(arg_4_0._goselect, var_4_2 == arg_4_0._tag)
	gohelper.setActive(arg_4_0._gounselect, var_4_2 ~= arg_4_0._tag)
	gohelper.setActive(arg_4_0._goselectlock, var_4_0 < arg_4_0._tag)
	gohelper.setActive(arg_4_0._gounselectlock, var_4_0 < arg_4_0._tag)
	gohelper.setActive(arg_4_0._goselecticon, arg_4_0._tag == var_4_0)
	gohelper.setActive(arg_4_0._gounselecticon, arg_4_0._tag == var_4_0)

	arg_4_0._txtunselectTitle.text = "Act." .. tostring(arg_4_0._tag)
	arg_4_0._txtselectTitle.text = "Act." .. tostring(arg_4_0._tag)

	ZProj.UGUIHelper.SetColorAlpha(arg_4_0._txtunselectTitle, var_4_0 < arg_4_0._tag and 0.6 or 0.7)
end

function var_0_0.destroy(arg_5_0)
	gohelper.destroy(arg_5_0.go)
	arg_5_0._btnClick:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.RefreshActState, arg_5_0._refreshItem, arg_5_0)
end

return var_0_0
