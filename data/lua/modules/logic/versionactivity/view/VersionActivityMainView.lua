module("modules.logic.versionactivity.view.VersionActivityMainView", package.seeall)

local var_0_0 = class("VersionActivityMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_enter")
	arg_1_0._gostamp = gohelper.findChild(arg_1_0.viewGO, "leftcontent/#go_stamp")
	arg_1_0._txtstampNum = gohelper.findChildText(arg_1_0.viewGO, "leftcontent/#go_stamp/#txt_stampNum")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "leftcontent/#go_stamp/#go_reddot")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftcontent/#btn_store")
	arg_1_0._txtendtime = gohelper.findChildText(arg_1_0.viewGO, "leftcontent/#txt_endtime")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
end

function var_0_0._btnenterOnClick(arg_4_0)
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnstoreOnClick(arg_5_0)
	VersionActivityController.instance:openLeiMiTeBeiStoreView()
end

function var_0_0.enterTaskView(arg_6_0)
	VersionActivityController.instance:openLeiMiTeBeiTaskView()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.taskClick = gohelper.getClick(arg_7_0._gostamp)

	arg_7_0.taskClick:AddClickListener(arg_7_0.enterTaskView, arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_7_0.refreshTaskUI, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshTaskUI()
	RedDotController.instance:addRedDot(arg_9_0._goreddot, RedDotEnum.DotNode.LeiMiTeBeiTask)

	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act113]

	if var_9_0 then
		local var_9_1 = {
			var_9_0:getEndTimeStr(),
			var_9_0:getRemainTimeStr()
		}

		arg_9_0._txtendtime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_baozhi_time"), var_9_1)
	end
end

function var_0_0.refreshTaskUI(arg_10_0)
	arg_10_0._txtstampNum.text = string.format("%s/%s", arg_10_0:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount())
end

function var_0_0.getFinishTaskCount(arg_11_0)
	arg_11_0.finishTaskCount = 0

	local var_11_0

	for iter_11_0, iter_11_1 in ipairs(lua_activity113_task.configList) do
		local var_11_1 = TaskModel.instance:getTaskById(iter_11_1.id)

		if var_11_1 and var_11_1.finishCount >= iter_11_1.maxFinishCount then
			arg_11_0.finishTaskCount = arg_11_0.finishTaskCount + 1
		end
	end

	return arg_11_0.finishTaskCount
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0.taskClick:RemoveClickListener()
end

return var_0_0
