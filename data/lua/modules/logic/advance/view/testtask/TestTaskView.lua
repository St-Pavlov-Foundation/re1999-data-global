module("modules.logic.advance.view.testtask.TestTaskView", package.seeall)

local var_0_0 = class("TestTaskView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagedog = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dog")
	arg_1_0._txtremaintime = gohelper.findChildTextMesh(arg_1_0.viewGO, "remaintime/#txt_remaintime")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_task")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#go_task_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionactivitychessIcon("full/bg"))
	arg_4_0._simagedog:LoadImage(ResUrl.getVersionactivitychessIcon("img_gou"))
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._task_list = TestTaskConfig.instance:getTaskList()
	arg_5_0._show_item_list = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._task_list) do
		if TestTaskModel.instance:getTaskData(iter_5_1.id) then
			arg_5_0._show_item_list[#arg_5_0._show_item_list + 1] = iter_5_1
		end
	end

	arg_5_0:_showTaskList()
end

function var_0_0._onFinishTask(arg_6_0)
	arg_6_0:_showTaskList()
end

function var_0_0._showTaskList(arg_7_0)
	table.sort(arg_7_0._show_item_list, var_0_0.sortTaskList)

	if not arg_7_0._obj_list then
		arg_7_0._obj_list = arg_7_0:getUserDataTb_()
	end

	TaskDispatcher.runDelay(arg_7_0._showTaskItem, arg_7_0, 0.2)
end

function var_0_0._showTaskItem(arg_8_0)
	arg_8_0:com_createObjList(arg_8_0._onItemShow, arg_8_0._show_item_list, arg_8_0._gotaskitemcontent, arg_8_0._gotaskitem, nil, 0.06)
end

function var_0_0.sortTaskList(arg_9_0, arg_9_1)
	local var_9_0 = TestTaskModel.instance:getTaskData(arg_9_0.id)
	local var_9_1 = TestTaskModel.instance:getTaskData(arg_9_1.id)

	if not var_9_0 or not var_9_1 then
		return false
	end

	local var_9_2 = var_9_0.finishCount > 0
	local var_9_3 = var_9_1.finishCount > 0

	if var_9_2 and not var_9_3 then
		return false
	elseif not var_9_2 and var_9_3 then
		return true
	else
		local var_9_4 = var_9_0.hasFinished
		local var_9_5 = var_9_1.hasFinished

		if var_9_4 and not var_9_5 then
			return true
		elseif not var_9_4 and var_9_5 then
			return false
		else
			return arg_9_0.id < arg_9_1.id
		end
	end
end

function var_0_0._onItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = TestTaskModel.instance:getTaskData(arg_10_2.id)

	if not var_10_0 then
		gohelper.setActive(arg_10_1, false)

		return
	end

	arg_10_1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Idle, 0, 0)

	arg_10_1.name = arg_10_3

	local var_10_1 = gohelper.findChildTextMesh(arg_10_1, "#txt_progress")
	local var_10_2 = gohelper.findChildTextMesh(arg_10_1, "#txt_maxprogress")
	local var_10_3 = gohelper.findChildTextMesh(arg_10_1, "#txt_taskdes")
	local var_10_4 = gohelper.findChildClickWithAudio(arg_10_1, "#go_notget/#btn_notfinishbg")
	local var_10_5 = gohelper.findChildClickWithAudio(arg_10_1, "#go_notget/#btn_finishbg")
	local var_10_6 = gohelper.findChild(arg_10_1, "#go_notget")
	local var_10_7 = gohelper.findChild(arg_10_1, "#go_get")
	local var_10_8 = gohelper.findChild(arg_10_1, "#go_blackmask")
	local var_10_9 = gohelper.findChild(arg_10_1, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	local var_10_10 = gohelper.findChild(arg_10_1, "scroll_reward/Viewport/#go_rewards")
	local var_10_11 = gohelper.findChildSingleImage(arg_10_1, "#simage_bg")
	local var_10_12 = gohelper.findChildSingleImage(arg_10_1, "#go_blackmask")

	var_10_1.text = var_10_0.progress
	var_10_2.text = arg_10_2.maxProgress
	var_10_3.text = arg_10_2.desc

	arg_10_0:addClickCb(var_10_4, arg_10_0._onClickTaskJump, arg_10_0, arg_10_3)
	arg_10_0:addClickCb(var_10_5, arg_10_0._onClickTaskReward, arg_10_0, arg_10_3)
	gohelper.setActive(var_10_6, var_10_0.finishCount == 0)
	gohelper.setActive(var_10_7, var_10_0.finishCount > 0)
	gohelper.setActive(var_10_8, true)

	gohelper.findChildImage(arg_10_1, "#go_blackmask").raycastTarget = false

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(arg_10_1, "#go_blackmask"), var_10_0.finishCount > 0 and 1 or 0)
	gohelper.setActive(var_10_4.gameObject, var_10_0.progress < arg_10_2.maxProgress)
	gohelper.setActive(var_10_5.gameObject, var_10_0.hasFinished)

	local var_10_13 = ItemModel.instance:getItemDataListByConfigStr(arg_10_2.bonus)

	IconMgr.instance:getCommonPropItemIconList(arg_10_0, arg_10_0._onRewardItemShow, var_10_13, var_10_10)

	local var_10_14 = string.split(arg_10_2.bonus, "|")

	var_10_10:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_10_14 > 1
	var_10_9.parentGameObject = arg_10_0._scrolltask.gameObject

	var_10_11:LoadImage(ResUrl.getVersionactivitychessIcon("img_changgui"))
	var_10_12:LoadImage(ResUrl.getVersionactivitychessIcon("img_mengban"))

	if not arg_10_0._image_list then
		arg_10_0._image_list = {}
	end

	if not arg_10_0._image_list[arg_10_3] then
		arg_10_0._image_list[arg_10_3] = arg_10_0:getUserDataTb_()

		table.insert(arg_10_0._image_list[arg_10_3], var_10_11)
		table.insert(arg_10_0._image_list[arg_10_3], var_10_12)
		arg_10_1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
	end

	table.insert(arg_10_0._obj_list, arg_10_1)
end

function var_0_0._releaseTaskItemImage(arg_11_0)
	if arg_11_0._image_list then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._image_list) do
			for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
				iter_11_3:UnLoadImage()
			end
		end
	end

	arg_11_0._image_list = {}
end

function var_0_0._onRewardItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:onUpdateMO(arg_12_2)
	arg_12_1:setConsume(true)
	arg_12_1:showStackableNum2()
	arg_12_1:isShowEffect(true)
	arg_12_1:setAutoPlay(true)
	arg_12_1:setCountFontSize(48)
	arg_12_1:setScale(0.6)
end

function var_0_0._onClickTaskJump(arg_13_0, arg_13_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_13_0 = arg_13_0._show_item_list[arg_13_1].jumpId

	if var_13_0 ~= 0 then
		GameFacade.jump(var_13_0)
	end

	arg_13_0:closeThis()
end

function var_0_0._onClickTaskReward(arg_14_0, arg_14_1)
	UIBlockMgr.instance:startBlock("TestTaskView")
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)

	arg_14_0._reward_task_id = arg_14_0._show_item_list[arg_14_1].id

	local var_14_0 = arg_14_0._obj_list[arg_14_1]

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(var_14_0, "#go_blackmask"), 1)
	var_14_0:GetComponent(typeof(UnityEngine.Animator)):Play("finsh", 0, 0)
	TaskDispatcher.runDelay(arg_14_0._getTaskReward, arg_14_0, 0.6)
end

function var_0_0._getTaskReward(arg_15_0)
	UIBlockMgr.instance:endBlock("TestTaskView")
	TaskRpc.instance:sendFinishTaskRequest(arg_15_0._reward_task_id)
end

function var_0_0.onClose(arg_16_0)
	UIBlockMgr.instance:endBlock("TestTaskView")
	TaskDispatcher.cancelTask(arg_16_0._getTaskReward, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._showTaskItem, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._showLeftTime, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()
	arg_17_0._simagedog:UnLoadImage()
	arg_17_0:_releaseTaskItemImage()
end

return var_0_0
