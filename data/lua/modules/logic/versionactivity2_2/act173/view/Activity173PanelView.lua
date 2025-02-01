module("modules.logic.versionactivity2_2.act173.view.Activity173PanelView", package.seeall)

slot0 = class("Activity173PanelView", BaseView)
slot1 = 3900001
slot2 = 1
slot3 = "first"
slot4 = "open"
slot5 = "get"
slot6 = "idle"
slot7 = 0.18

function slot0.onInitView(slot0)
	slot0._goClose = gohelper.findChild(slot0.viewGO, "#go_Close")
	slot0._goOpen = gohelper.findChild(slot0.viewGO, "#go_Open")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "#go_Open/Left/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#go_Open/Left/#txt_Descr")
	slot0._imageFG = gohelper.findChildImage(slot0.viewGO, "#go_Open/Right/Schedule/Slide/image_FG")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnrewardIconOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.onUpdateTaskList, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0.onUpdateTaskList, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._stageStateCache = {}
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId
	slot0._config = ActivityConfig.instance:getActivityCo(slot0._actId)
	slot0._txtDescr.text = slot0._config.actDesc

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, slot0.onUpdateTaskList, slot0)
	slot0:initAct()

	if slot0:isFirstEnter() then
		TaskDispatcher.cancelTask(slot0.playFirstEnterAudio, slot0)
		TaskDispatcher.runDelay(slot0.playFirstEnterAudio, slot0, uv0)
		slot0:markHasEnter()
	end

	slot0._animator:Play(slot2 and uv1 or uv2, 0, 0)
end

function slot0.playFirstEnterAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_fistenter_act173)
end

function slot0.initAct(slot0)
	slot0:refreshActRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshActRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshActRemainTime, slot0, uv0)
	slot0:initTasks()
	slot0:initOrRefreshGlobalTaskProgress()
end

function slot0.onUpdateTaskList(slot0)
	slot0:initOrRefreshGlobalTaskProgress(true)
	slot0:refreshAllTask()
end

function slot0.initTasks(slot0)
	for slot5 = 1, #Activity173Config.instance:getAllOnlineTasks() do
		slot0:getOrCreateTaskItem(slot5):init(slot1[slot5])
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1)
	slot0._taskItems = slot0._taskItems or {}

	if not slot0._taskItems[slot1] then
		slot0._taskItems[slot1] = Activity173TaskItem.New(gohelper.findChild(slot0.viewGO, "#go_Open/Right/Reward" .. slot1))
	end

	return slot2
end

function slot0.refreshActRemainTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_2Enum.ActivityId.LimitDecorate)
end

function slot0.refreshAllTask(slot0)
	for slot4, slot5 in ipairs(slot0._taskItems) do
		slot5:refresh()
	end
end

function slot0.initOrRefreshGlobalTaskProgress(slot0, slot1)
	slot3 = TaskModel.instance:getTaskById(uv0) and slot2.progress or 0
	slot8 = nil

	for slot12 = 1, slot5 do
		slot15 = slot4[slot12].endValue <= slot3
		slot16 = slot0:getOrCreateGlobalTaskStageItem(slot12)
		slot16.txtNum.text = Activity173Controller.numberDisplay(slot14)

		gohelper.setActive(slot16.goPointFG, slot15)
		gohelper.setActive(slot16.goGet, slot15)
		ZProj.UGUIHelper.SetGrayscale(slot16.imageRewardBG.gameObject, not slot15)

		slot8 = slot4[slot12 - 1] or slot13
		slot17 = slot8 and slot8.endValue or 0
		slot6 = 0 + (slot14 - slot17 ~= 0 and GameUtil.clamp((slot3 - slot17) / slot19, 0, 1) or 0) * 1 / ((Activity173Config.instance:getGlobalVisibleTaskStages() and #slot4 or 0) - 1)

		if slot2 then
			slot21 = slot15 and slot0._stageStateCache[slot13.id] == false

			if slot1 and slot21 then
				slot16.animGet:Play(slot21 and uv1 or uv2, 0, 0)
			end

			slot0._stageStateCache[slot13.id] = slot15
		end
	end

	slot0._imageFG.fillAmount = slot6
end

function slot0.getOrCreateGlobalTaskStageItem(slot0, slot1)
	slot0._globalTaskStageItems = slot0._globalTaskStageItems or slot0:getUserDataTb_()

	if not slot0._globalTaskStageItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.findChild(slot0.viewGO, "#go_Open/Right/Schedule/HorizonLayout/Point" .. slot1)

		if gohelper.isNil(slot2.viewGO) then
			logError("缺少全服奖励阶段ui url = " .. slot3)

			return
		end

		slot2.imageRewardBG = gohelper.findChildImage(slot2.viewGO, "image_RewardBG")
		slot2.txtNum = gohelper.findChildText(slot2.viewGO, "image_RewardBG/txt_Num")
		slot2.goGet = gohelper.findChild(slot2.viewGO, "#go_Get")
		slot2.goPointFG = gohelper.findChild(slot2.viewGO, "#go_PointFG")
		slot2.animGet = gohelper.onceAddComponent(slot2.goGet, gohelper.Type_Animator)
		slot0._globalTaskStageItems[slot1] = slot2
	end

	return slot2
end

function slot0.isFirstEnter(slot0)
	return string.nilorempty(PlayerPrefsHelper.getString(slot0:getPrefsKey(), ""))
end

function slot0.markHasEnter(slot0)
	PlayerPrefsHelper.setString(slot0:getPrefsKey(), "hasEnter")
end

function slot0.getPrefsKey(slot0)
	return PlayerPrefsKey.FirstEnterActivity173PanelView .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshActRemainTime, slot0)
	TaskDispatcher.cancelTask(slot0.switch2NormalView, slot0)
	TaskDispatcher.cancelTask(slot0.playFirstEnterAudio, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._taskItems then
		for slot4, slot5 in pairs(slot0._taskItems) do
			slot5:destroy()
		end

		slot0._taskItems = nil
	end
end

return slot0
