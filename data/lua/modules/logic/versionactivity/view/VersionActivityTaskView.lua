module("modules.logic.versionactivity.view.VersionActivityTaskView", package.seeall)

local var_0_0 = class("VersionActivityTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagedecorate2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decorate2")
	arg_1_0._scrollleft = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_left")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_left/Viewport/Content/#go_item")
	arg_1_0._txtgetcount = gohelper.findChildText(arg_1_0.viewGO, "horizontal/totalprogress/#txt_getcount")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goitem, false)

	arg_4_0.goTaskBonusContent = gohelper.findChild(arg_4_0.viewGO, "#scroll_left/Viewport/Content")
	arg_4_0.itemResPath = arg_4_0.viewContainer:getSetting().otherRes[1]
	arg_4_0.taskBonusItemList = {}

	arg_4_0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/bg1"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnReceiveFinishTaskReply, arg_6_0.onReceiveFinishTaskReply, arg_6_0)
	VersionActivityTaskListModel.instance:initTaskList()
	arg_6_0:setTaskBonusY()
	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:refreshLeftUI()
	arg_7_0:refreshRightUI()
end

function var_0_0.setTaskBonusY(arg_8_0)
	local var_8_0 = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon).defineId
	local var_8_1 = #TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.ActivityDungeon)
	local var_8_2 = math.min(var_8_0, var_8_1 - 5)
	local var_8_3 = 165 * var_8_2

	transformhelper.setLocalPosXY(arg_8_0.goTaskBonusContent.transform, 0, var_8_3)
	arg_8_0.viewContainer:setTaskBonusScrollViewIndexOffset(var_8_2)
end

function var_0_0.refreshLeftUI(arg_9_0)
	arg_9_0:refreshTaskBonusItem()
end

function var_0_0.refreshRightUI(arg_10_0)
	arg_10_0._txtgetcount.text = string.format(" %s/%s", VersionActivityTaskListModel.instance:getGetRewardTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivityEnum.ActivityId.Act113))

	VersionActivityTaskListModel.instance:sortTaskMoList()
	VersionActivityTaskListModel.instance:refreshList()
end

function var_0_0.refreshTaskBonusItem(arg_11_0)
	VersionActivityTaskBonusListModel.instance:refreshList()
end

function var_0_0.onReceiveFinishTaskReply(arg_12_0)
	arg_12_0:refreshRightUI()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.AddTaskActivityBonus)
	TaskDispatcher.runDelay(arg_12_0.onTaskBonusAnimationDone, arg_12_0, 0.833)
end

function var_0_0.onTaskBonusAnimationDone(arg_13_0)
	arg_13_0:refreshLeftUI()
	arg_13_0:setTaskBonusY()
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.onTaskBonusAnimationDone, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.taskBonusItemList) do
		iter_15_1:onDestroyView()
	end

	arg_15_0._simagebg:UnLoadImage()
end

return var_0_0
