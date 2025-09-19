module("modules.logic.survival.view.shelter.ShelterTaskView", package.seeall)

local var_0_0 = class("ShelterTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0.tabList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, arg_2_0.onTaskDataUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, arg_3_0.onTaskDataUpdate, arg_3_0)
end

function var_0_0.onClickTab(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	if SurvivalTaskModel.instance:setSelectType(arg_4_1.taskType) then
		arg_4_0:refreshTabList()
	end
end

function var_0_0.onTaskDataUpdate(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	local var_8_0 = arg_8_0.viewParam or {}

	SurvivalTaskModel.instance:initViewParam(var_8_0.moduleId, var_8_0.taskId)
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0:refreshTabList()
end

function var_0_0.refreshTabList(arg_10_0)
	local var_10_0 = {
		{
			isShow = true,
			taskType = SurvivalEnum.TaskModule.MainTask
		},
		{
			isShow = true,
			taskType = SurvivalEnum.TaskModule.StoryTask
		}
	}
	local var_10_1 = SurvivalShelterModel.instance:getWeekInfo()

	table.insert(var_10_0, {
		taskType = SurvivalEnum.TaskModule.NormalTask,
		isShow = var_10_1.inSurvival
	})

	for iter_10_0 = 1, #var_10_0 do
		arg_10_0:refreshTab(iter_10_0, var_10_0[iter_10_0])
	end

	TaskDispatcher.cancelTask(arg_10_0.refreshTaskView, arg_10_0)

	if arg_10_0.isNotFirstOpen then
		arg_10_0:refreshTaskView()
	else
		TaskDispatcher.runDelay(arg_10_0.refreshTaskView, arg_10_0, 0.4)

		arg_10_0.isNotFirstOpen = true
	end
end

function var_0_0.refreshTaskView(arg_11_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskViewUpdate, SurvivalTaskModel.instance:getSelectType())
end

function var_0_0.refreshTab(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.taskType
	local var_12_1 = arg_12_2.isShow
	local var_12_2 = SurvivalTaskModel.instance:getSelectType() == var_12_0
	local var_12_3 = arg_12_0.tabList[arg_12_1]

	if not var_12_3 then
		var_12_3 = arg_12_0:getUserDataTb_()
		var_12_3.go = gohelper.findChild(arg_12_0.viewGO, string.format("#go_tabcontainer/container/#go_tabitem%s", arg_12_1))
		var_12_3.goSelect = gohelper.findChild(var_12_3.go, "#go_select")
		var_12_3.goSelectFinished = gohelper.findChild(var_12_3.goSelect, "finished")
		var_12_3.goSelectUnFinish = gohelper.findChild(var_12_3.goSelect, "unfinish")
		var_12_3.txtSelectNum = gohelper.findChildTextMesh(var_12_3.goSelect, "unfinish/#txt_num")
		var_12_3.goUnSelect = gohelper.findChild(var_12_3.go, "#go_unselect")
		var_12_3.goUnSelectFinished = gohelper.findChild(var_12_3.goUnSelect, "finished")
		var_12_3.goUnSelectUnFinish = gohelper.findChild(var_12_3.goUnSelect, "unfinish")
		var_12_3.txtUnSelectNum = gohelper.findChildTextMesh(var_12_3.goUnSelect, "unfinish/#txt_num")
		var_12_3.btn = gohelper.findButtonWithAudio(var_12_3.go)

		var_12_3.btn:AddClickListener(arg_12_0.onClickTab, arg_12_0, var_12_3)

		arg_12_0.tabList[arg_12_1] = var_12_3
	end

	var_12_3.taskType = var_12_0

	gohelper.setActive(var_12_3.go, var_12_1)

	if not var_12_1 then
		return
	end

	gohelper.setActive(var_12_3.goSelect, var_12_2)
	gohelper.setActive(var_12_3.goUnSelect, not var_12_2)

	local var_12_4, var_12_5 = SurvivalTaskModel.instance:getTaskFinishedNum(var_12_0)

	if var_12_0 == SurvivalEnum.TaskModule.MainTask then
		local var_12_6, var_12_7 = SurvivalTaskModel.instance:getTaskFinishedNum(SurvivalEnum.TaskModule.SubTask)

		var_12_4 = var_12_4 + var_12_6
		var_12_5 = var_12_5 + var_12_7
	end

	local var_12_8 = var_12_5 == 0
	local var_12_9 = not var_12_8 and var_12_4 == var_12_5

	gohelper.setActive(var_12_3.go, true)

	if var_12_2 then
		gohelper.setActive(arg_12_0.goEmpty, var_12_8)
		gohelper.setActive(var_12_3.goSelectFinished, var_12_9)
		gohelper.setActive(var_12_3.goSelectUnFinish, not var_12_9)

		if var_12_8 then
			var_12_3.txtSelectNum.text = ""
		else
			var_12_3.txtSelectNum.text = string.format("<size=50>%s</size>/%s", var_12_4, var_12_5)
		end
	else
		gohelper.setActive(var_12_3.goUnSelectFinished, var_12_9)
		gohelper.setActive(var_12_3.goUnSelectUnFinish, not var_12_9)

		if var_12_8 then
			var_12_3.txtUnSelectNum.text = ""
		else
			var_12_3.txtUnSelectNum.text = string.format("<color=#FFFFFF><size=50>%s</size></color>/%s", var_12_4, var_12_5)
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.tabList) do
		iter_13_1.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_13_0.refreshTaskView, arg_13_0)
end

return var_0_0
