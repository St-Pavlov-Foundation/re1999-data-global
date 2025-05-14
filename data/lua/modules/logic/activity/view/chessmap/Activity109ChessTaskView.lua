module("modules.logic.activity.view.chessmap.Activity109ChessTaskView", package.seeall)

local var_0_0 = class("Activity109ChessTaskView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagedog = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dog")
	arg_1_0._txtremaintime = gohelper.findChildTextMesh(arg_1_0.viewGO, "remaintime/#txt_remaintime")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_task")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#go_task_item")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall/#simage_getallbg")
	arg_1_0._btngetallreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall/#btn_getallreward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._onFinishTask, arg_2_0)
	arg_2_0._btngetallreward:AddClickListener(arg_2_0._btngetallrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._onFinishTask, arg_3_0)
	arg_3_0._btngetallreward:RemoveClickListener()
end

function var_0_0._btngetallrewardOnClick(arg_4_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity109)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getVersionactivitychessIcon("full/bg"))
	arg_5_0._simagedog:LoadImage(ResUrl.getVersionactivitychessIcon("img_gou"))
	arg_5_0._simagegetallbg:LoadImage(ResUrl.getVersionactivitychessIcon("img_quanbulingqu"))
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._activity_data = ActivityModel.instance:getActivityInfo()[Activity109Model.instance:getCurActivityID()]
	arg_6_0._task_list = Activity109Config.instance:getTaskList()

	arg_6_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_6_0._showLeftTime, arg_6_0, 60)
	arg_6_0:_showTaskList()
end

function var_0_0._showLeftTime(arg_7_0)
	arg_7_0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), arg_7_0._activity_data:getRemainTimeStr())
end

function var_0_0._onFinishTask(arg_8_0)
	arg_8_0:_showTaskList()
end

function var_0_0._showTaskList(arg_9_0)
	table.sort(arg_9_0._task_list, var_0_0.sortTaskList)

	if not arg_9_0._obj_list then
		arg_9_0._obj_list = arg_9_0:getUserDataTb_()
	end

	TaskDispatcher.runDelay(arg_9_0._showTaskItem, arg_9_0, 0.2)
end

function var_0_0._showTaskItem(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0._task_list) do
		table.insert(var_10_0, iter_10_1)

		if Activity109Model.instance:getTaskData(iter_10_1.id).hasFinished then
			var_10_1 = var_10_1 + 1
		end
	end

	table.insert(var_10_0, 1, {
		isGetAllTaskUI = true,
		isNeedShowGetAllUI = var_10_1 >= 2
	})
	arg_10_0:com_createObjList(arg_10_0._onItemShow, var_10_0, arg_10_0._gotaskitemcontent, arg_10_0._gotaskitem, nil, 0.06)
end

function var_0_0.sortTaskList(arg_11_0, arg_11_1)
	local var_11_0 = Activity109Model.instance:getTaskData(arg_11_0.id)
	local var_11_1 = Activity109Model.instance:getTaskData(arg_11_1.id)

	if not var_11_0 or not var_11_1 then
		return false
	end

	local var_11_2 = var_11_0.finishCount > 0
	local var_11_3 = var_11_1.finishCount > 0

	if var_11_2 and not var_11_3 then
		return false
	elseif not var_11_2 and var_11_3 then
		return true
	else
		local var_11_4 = var_11_0.hasFinished
		local var_11_5 = var_11_1.hasFinished

		if var_11_4 and not var_11_5 then
			return true
		elseif not var_11_4 and var_11_5 then
			return false
		else
			if arg_11_0.sortId ~= arg_11_1.sortId then
				return arg_11_0.sortId < arg_11_1.sortId
			end

			return arg_11_0.id < arg_11_1.id
		end
	end
end

function var_0_0._onItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2.isGetAllTaskUI then
		gohelper.setActive(arg_12_1, arg_12_2.isNeedShowGetAllUI)

		return
	end

	local var_12_0 = Activity109Model.instance:getTaskData(arg_12_2.id)

	if not var_12_0 then
		gohelper.setActive(arg_12_1, false)

		return
	end

	arg_12_3 = arg_12_3 - 1

	arg_12_1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Idle, 0, 0)

	arg_12_1.name = arg_12_3

	local var_12_1 = gohelper.findChildTextMesh(arg_12_1, "#txt_progress")
	local var_12_2 = gohelper.findChildTextMesh(arg_12_1, "#txt_maxprogress")
	local var_12_3 = gohelper.findChildTextMesh(arg_12_1, "#txt_taskdes")
	local var_12_4 = gohelper.findChildClickWithAudio(arg_12_1, "#go_notget/#btn_notfinishbg")
	local var_12_5 = gohelper.findChildClickWithAudio(arg_12_1, "#go_notget/#btn_finishbg")
	local var_12_6 = gohelper.findChild(arg_12_1, "#go_notget")
	local var_12_7 = gohelper.findChild(arg_12_1, "#go_get")
	local var_12_8 = gohelper.findChild(arg_12_1, "#go_blackmask")
	local var_12_9 = gohelper.findChild(arg_12_1, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	local var_12_10 = gohelper.findChild(arg_12_1, "scroll_reward/Viewport/#go_rewards")
	local var_12_11 = gohelper.findChildSingleImage(arg_12_1, "#simage_bg")
	local var_12_12 = gohelper.findChildSingleImage(arg_12_1, "#go_blackmask")

	var_12_1.text = var_12_0.progress
	var_12_2.text = arg_12_2.maxProgress
	var_12_3.text = arg_12_2.desc

	arg_12_0:addClickCb(var_12_4, arg_12_0._onClickTaskJump, arg_12_0, arg_12_3)
	arg_12_0:addClickCb(var_12_5, arg_12_0._onClickTaskReward, arg_12_0, arg_12_3)
	gohelper.setActive(var_12_6, var_12_0.finishCount == 0)
	gohelper.setActive(var_12_7, var_12_0.finishCount > 0)
	gohelper.setActive(var_12_8, true)

	gohelper.findChildImage(arg_12_1, "#go_blackmask").raycastTarget = false

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(arg_12_1, "#go_blackmask"), var_12_0.finishCount > 0 and 1 or 0)
	gohelper.setActive(var_12_4.gameObject, var_12_0.progress < arg_12_2.maxProgress)
	gohelper.setActive(var_12_5.gameObject, var_12_0.hasFinished)

	local var_12_13 = ItemModel.instance:getItemDataListByConfigStr(arg_12_2.bonus)

	IconMgr.instance:getCommonPropItemIconList(arg_12_0, arg_12_0._onRewardItemShow, var_12_13, var_12_10)

	local var_12_14 = string.split(arg_12_2.bonus, "|")

	var_12_10:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_12_14 > 1
	var_12_9.parentGameObject = arg_12_0._scrolltask.gameObject

	var_12_11:LoadImage(ResUrl.getVersionactivitychessIcon("img_changgui"))
	var_12_12:LoadImage(ResUrl.getVersionactivitychessIcon("img_mengban"))

	if not arg_12_0._image_list then
		arg_12_0._image_list = {}
	end

	if not arg_12_0._image_list[arg_12_3] then
		arg_12_0._image_list[arg_12_3] = arg_12_0:getUserDataTb_()

		table.insert(arg_12_0._image_list[arg_12_3], var_12_11)
		table.insert(arg_12_0._image_list[arg_12_3], var_12_12)
		arg_12_1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
	end

	table.insert(arg_12_0._obj_list, arg_12_1)
end

function var_0_0._releaseTaskItemImage(arg_13_0)
	if arg_13_0._image_list then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._image_list) do
			for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
				iter_13_3:UnLoadImage()
			end
		end
	end

	arg_13_0._image_list = {}
end

function var_0_0._onRewardItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:onUpdateMO(arg_14_2)
	arg_14_1:setConsume(true)
	arg_14_1:showStackableNum2()
	arg_14_1:isShowEffect(true)
	arg_14_1:setAutoPlay(true)
	arg_14_1:setCountFontSize(48)
	arg_14_1:setScale(0.6)
end

function var_0_0._onClickTaskJump(arg_15_0, arg_15_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_15_0 = arg_15_0._task_list[arg_15_1]

	Activity109ChessController.instance:dispatchEvent(ActivityChessEvent.TaskJump, var_15_0)
	arg_15_0:closeThis()
end

function var_0_0._onClickTaskReward(arg_16_0, arg_16_1)
	UIBlockMgr.instance:startBlock("Activity109ChessTaskView")
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)

	arg_16_0._reward_task_id = arg_16_0._task_list[arg_16_1].id

	local var_16_0 = arg_16_0._obj_list[arg_16_1]

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(var_16_0, "#go_blackmask"), 1)
	var_16_0:GetComponent(typeof(UnityEngine.Animator)):Play("finsh", 0, 0)
	TaskDispatcher.runDelay(arg_16_0._getTaskReward, arg_16_0, 0.6)
end

function var_0_0._getTaskReward(arg_17_0)
	UIBlockMgr.instance:endBlock("Activity109ChessTaskView")
	TaskRpc.instance:sendFinishTaskRequest(arg_17_0._reward_task_id)
end

function var_0_0.onClose(arg_18_0)
	UIBlockMgr.instance:endBlock("Activity109ChessTaskView")
	TaskDispatcher.cancelTask(arg_18_0._getTaskReward, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showTaskItem, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showLeftTime, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:_releaseTaskItemImage()
	arg_19_0._simagebg:UnLoadImage()
	arg_19_0._simagedog:UnLoadImage()
	arg_19_0._simagegetallbg:UnLoadImage()
end

return var_0_0
