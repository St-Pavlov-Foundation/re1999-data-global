module("modules.logic.activity.view.chessmap.Activity109ChessTaskView", package.seeall)

slot0 = class("Activity109ChessTaskView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagedog = gohelper.findChildSingleImage(slot0.viewGO, "#simage_dog")
	slot0._txtremaintime = gohelper.findChildTextMesh(slot0.viewGO, "remaintime/#txt_remaintime")
	slot0._scrolltask = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_task")
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#go_task_item")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall/#simage_getallbg")
	slot0._btngetallreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#scroll_task/viewport/#go_taskitemcontent/#go_getall/#btn_getallreward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._onFinishTask, slot0)
	slot0._btngetallreward:AddClickListener(slot0._btngetallrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._onFinishTask, slot0)
	slot0._btngetallreward:RemoveClickListener()
end

function slot0._btngetallrewardOnClick(slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity109)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionactivitychessIcon("full/bg"))
	slot0._simagedog:LoadImage(ResUrl.getVersionactivitychessIcon("img_gou"))
	slot0._simagegetallbg:LoadImage(ResUrl.getVersionactivitychessIcon("img_quanbulingqu"))
end

function slot0.onOpen(slot0)
	slot0._activity_data = ActivityModel.instance:getActivityInfo()[Activity109Model.instance:getCurActivityID()]
	slot0._task_list = Activity109Config.instance:getTaskList()

	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showTaskList()
end

function slot0._showLeftTime(slot0)
	slot0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), slot0._activity_data:getRemainTimeStr())
end

function slot0._onFinishTask(slot0)
	slot0:_showTaskList()
end

function slot0._showTaskList(slot0)
	table.sort(slot0._task_list, uv0.sortTaskList)

	if not slot0._obj_list then
		slot0._obj_list = slot0:getUserDataTb_()
	end

	TaskDispatcher.runDelay(slot0._showTaskItem, slot0, 0.2)
end

function slot0._showTaskItem(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(slot0._task_list) do
		table.insert(slot1, slot7)

		if Activity109Model.instance:getTaskData(slot7.id).hasFinished then
			slot2 = 0 + 1
		end
	end

	table.insert(slot1, 1, {
		isGetAllTaskUI = true,
		isNeedShowGetAllUI = slot2 >= 2
	})
	slot0:com_createObjList(slot0._onItemShow, slot1, slot0._gotaskitemcontent, slot0._gotaskitem, nil, 0.06)
end

function slot0.sortTaskList(slot0, slot1)
	slot3 = Activity109Model.instance:getTaskData(slot1.id)

	if not Activity109Model.instance:getTaskData(slot0.id) or not slot3 then
		return false
	end

	if slot2.finishCount > 0 and not (slot3.finishCount > 0) then
		return false
	elseif not slot4 and slot5 then
		return true
	elseif slot2.hasFinished and not slot3.hasFinished then
		return true
	elseif not slot6 and slot7 then
		return false
	else
		if slot0.sortId ~= slot1.sortId then
			return slot0.sortId < slot1.sortId
		end

		return slot0.id < slot1.id
	end
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	if slot2.isGetAllTaskUI then
		gohelper.setActive(slot1, slot2.isNeedShowGetAllUI)

		return
	end

	if not Activity109Model.instance:getTaskData(slot2.id) then
		gohelper.setActive(slot1, false)

		return
	end

	slot3 = slot3 - 1

	slot1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Idle, 0, 0)

	slot1.name = slot3
	slot14 = gohelper.findChild(slot1, "scroll_reward/Viewport/#go_rewards")
	gohelper.findChildTextMesh(slot1, "#txt_progress").text = slot4.progress
	gohelper.findChildTextMesh(slot1, "#txt_maxprogress").text = slot2.maxProgress
	gohelper.findChildTextMesh(slot1, "#txt_taskdes").text = slot2.desc

	slot0:addClickCb(gohelper.findChildClickWithAudio(slot1, "#go_notget/#btn_notfinishbg"), slot0._onClickTaskJump, slot0, slot3)
	slot0:addClickCb(gohelper.findChildClickWithAudio(slot1, "#go_notget/#btn_finishbg"), slot0._onClickTaskReward, slot0, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "#go_notget"), slot4.finishCount == 0)
	gohelper.setActive(gohelper.findChild(slot1, "#go_get"), slot4.finishCount > 0)
	gohelper.setActive(gohelper.findChild(slot1, "#go_blackmask"), true)

	gohelper.findChildImage(slot1, "#go_blackmask").raycastTarget = false

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(slot1, "#go_blackmask"), slot4.finishCount > 0 and 1 or 0)
	gohelper.setActive(slot8.gameObject, slot4.progress < slot2.maxProgress)
	gohelper.setActive(slot9.gameObject, slot4.hasFinished)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onRewardItemShow, ItemModel.instance:getItemDataListByConfigStr(slot2.bonus), slot14)

	slot14:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #string.split(slot2.bonus, "|") > 1
	gohelper.findChild(slot1, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect)).parentGameObject = slot0._scrolltask.gameObject

	gohelper.findChildSingleImage(slot1, "#simage_bg"):LoadImage(ResUrl.getVersionactivitychessIcon("img_changgui"))
	gohelper.findChildSingleImage(slot1, "#go_blackmask"):LoadImage(ResUrl.getVersionactivitychessIcon("img_mengban"))

	if not slot0._image_list then
		slot0._image_list = {}
	end

	if not slot0._image_list[slot3] then
		slot0._image_list[slot3] = slot0:getUserDataTb_()

		table.insert(slot0._image_list[slot3], slot15)
		table.insert(slot0._image_list[slot3], slot16)
		slot1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
	end

	table.insert(slot0._obj_list, slot1)
end

function slot0._releaseTaskItemImage(slot0)
	if slot0._image_list then
		for slot4, slot5 in ipairs(slot0._image_list) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:UnLoadImage()
			end
		end
	end

	slot0._image_list = {}
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:setScale(0.6)
end

function slot0._onClickTaskJump(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	Activity109ChessController.instance:dispatchEvent(ActivityChessEvent.TaskJump, slot0._task_list[slot1])
	slot0:closeThis()
end

function slot0._onClickTaskReward(slot0, slot1)
	UIBlockMgr.instance:startBlock("Activity109ChessTaskView")
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)

	slot0._reward_task_id = slot0._task_list[slot1].id
	slot2 = slot0._obj_list[slot1]

	ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(slot2, "#go_blackmask"), 1)
	slot2:GetComponent(typeof(UnityEngine.Animator)):Play("finsh", 0, 0)
	TaskDispatcher.runDelay(slot0._getTaskReward, slot0, 0.6)
end

function slot0._getTaskReward(slot0)
	UIBlockMgr.instance:endBlock("Activity109ChessTaskView")
	TaskRpc.instance:sendFinishTaskRequest(slot0._reward_task_id)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("Activity109ChessTaskView")
	TaskDispatcher.cancelTask(slot0._getTaskReward, slot0)
	TaskDispatcher.cancelTask(slot0._showTaskItem, slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_releaseTaskItemImage()
	slot0._simagebg:UnLoadImage()
	slot0._simagedog:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()
end

return slot0
