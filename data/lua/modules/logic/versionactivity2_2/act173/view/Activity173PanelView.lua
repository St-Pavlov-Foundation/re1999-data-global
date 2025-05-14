module("modules.logic.versionactivity2_2.act173.view.Activity173PanelView", package.seeall)

local var_0_0 = class("Activity173PanelView", BaseView)
local var_0_1 = 3900001
local var_0_2 = 1
local var_0_3 = "first"
local var_0_4 = "open"
local var_0_5 = "get"
local var_0_6 = "idle"
local var_0_7 = 0.18

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goClose = gohelper.findChild(arg_1_0.viewGO, "#go_Close")
	arg_1_0._goOpen = gohelper.findChild(arg_1_0.viewGO, "#go_Open")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#go_Open/Left/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_Open/Left/#txt_Descr")
	arg_1_0._imageFG = gohelper.findChildImage(arg_1_0.viewGO, "#go_Open/Right/Schedule/Slide/image_FG")

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

function var_0_0._btnrewardIconOnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_5_0.onUpdateTaskList, arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_5_0.onUpdateTaskList, arg_5_0)

	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_Animator)
	arg_5_0._stageStateCache = {}
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0._actId = arg_6_0.viewParam.actId
	arg_6_0._config = ActivityConfig.instance:getActivityCo(arg_6_0._actId)
	arg_6_0._txtDescr.text = arg_6_0._config.actDesc

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, arg_6_0.onUpdateTaskList, arg_6_0)
	arg_6_0:initAct()

	local var_6_1 = arg_6_0:isFirstEnter()

	if var_6_1 then
		TaskDispatcher.cancelTask(arg_6_0.playFirstEnterAudio, arg_6_0)
		TaskDispatcher.runDelay(arg_6_0.playFirstEnterAudio, arg_6_0, var_0_7)
		arg_6_0:markHasEnter()
	end

	local var_6_2 = var_6_1 and var_0_3 or var_0_4

	arg_6_0._animator:Play(var_6_2, 0, 0)
end

function var_0_0.playFirstEnterAudio(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_fistenter_act173)
end

function var_0_0.initAct(arg_8_0)
	arg_8_0:refreshActRemainTime()
	TaskDispatcher.cancelTask(arg_8_0.refreshActRemainTime, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.refreshActRemainTime, arg_8_0, var_0_2)
	arg_8_0:initTasks()
	arg_8_0:initOrRefreshGlobalTaskProgress()
end

function var_0_0.onUpdateTaskList(arg_9_0)
	arg_9_0:initOrRefreshGlobalTaskProgress(true)
	arg_9_0:refreshAllTask()
end

function var_0_0.initTasks(arg_10_0)
	local var_10_0 = Activity173Config.instance:getAllOnlineTasks()

	for iter_10_0 = 1, #var_10_0 do
		local var_10_1 = var_10_0[iter_10_0]

		arg_10_0:getOrCreateTaskItem(iter_10_0):init(var_10_1)
	end
end

function var_0_0.getOrCreateTaskItem(arg_11_0, arg_11_1)
	arg_11_0._taskItems = arg_11_0._taskItems or {}

	local var_11_0 = arg_11_0._taskItems[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.findChild(arg_11_0.viewGO, "#go_Open/Right/Reward" .. arg_11_1)

		var_11_0 = Activity173TaskItem.New(var_11_1)
		arg_11_0._taskItems[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.refreshActRemainTime(arg_12_0)
	arg_12_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_2Enum.ActivityId.LimitDecorate)
end

function var_0_0.refreshAllTask(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._taskItems) do
		iter_13_1:refresh()
	end
end

function var_0_0.initOrRefreshGlobalTaskProgress(arg_14_0, arg_14_1)
	local var_14_0 = TaskModel.instance:getTaskById(var_0_1)
	local var_14_1 = var_14_0 and var_14_0.progress or 0
	local var_14_2 = Activity173Config.instance:getGlobalVisibleTaskStages()
	local var_14_3 = var_14_2 and #var_14_2 or 0
	local var_14_4 = 0
	local var_14_5 = 1 / (var_14_3 - 1)
	local var_14_6

	for iter_14_0 = 1, var_14_3 do
		local var_14_7 = var_14_2[iter_14_0]
		local var_14_8 = var_14_7.endValue
		local var_14_9 = var_14_8 <= var_14_1
		local var_14_10 = arg_14_0:getOrCreateGlobalTaskStageItem(iter_14_0)

		var_14_10.txtNum.text = Activity173Controller.numberDisplay(var_14_8)

		gohelper.setActive(var_14_10.goPointFG, var_14_9)
		gohelper.setActive(var_14_10.goGet, var_14_9)
		ZProj.UGUIHelper.SetGrayscale(var_14_10.imageRewardBG.gameObject, not var_14_9)

		local var_14_11 = var_14_2[iter_14_0 - 1] or var_14_7
		local var_14_12 = var_14_11 and var_14_11.endValue or 0
		local var_14_13 = var_14_1 - var_14_12
		local var_14_14 = var_14_8 - var_14_12

		var_14_4 = var_14_4 + (var_14_14 ~= 0 and GameUtil.clamp(var_14_13 / var_14_14, 0, 1) or 0) * var_14_5

		if var_14_0 then
			local var_14_15 = var_14_9 and arg_14_0._stageStateCache[var_14_7.id] == false

			if arg_14_1 and var_14_15 then
				local var_14_16 = var_14_15 and var_0_5 or var_0_6

				var_14_10.animGet:Play(var_14_16, 0, 0)
			end

			arg_14_0._stageStateCache[var_14_7.id] = var_14_9
		end
	end

	arg_14_0._imageFG.fillAmount = var_14_4
end

function var_0_0.getOrCreateGlobalTaskStageItem(arg_15_0, arg_15_1)
	arg_15_0._globalTaskStageItems = arg_15_0._globalTaskStageItems or arg_15_0:getUserDataTb_()

	local var_15_0 = arg_15_0._globalTaskStageItems[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()

		local var_15_1 = "#go_Open/Right/Schedule/HorizonLayout/Point" .. arg_15_1

		var_15_0.viewGO = gohelper.findChild(arg_15_0.viewGO, var_15_1)

		if gohelper.isNil(var_15_0.viewGO) then
			logError("缺少全服奖励阶段ui url = " .. var_15_1)

			return
		end

		var_15_0.imageRewardBG = gohelper.findChildImage(var_15_0.viewGO, "image_RewardBG")
		var_15_0.txtNum = gohelper.findChildText(var_15_0.viewGO, "image_RewardBG/txt_Num")
		var_15_0.goGet = gohelper.findChild(var_15_0.viewGO, "#go_Get")
		var_15_0.goPointFG = gohelper.findChild(var_15_0.viewGO, "#go_PointFG")
		var_15_0.animGet = gohelper.onceAddComponent(var_15_0.goGet, gohelper.Type_Animator)
		arg_15_0._globalTaskStageItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.isFirstEnter(arg_16_0)
	local var_16_0 = arg_16_0:getPrefsKey()
	local var_16_1 = PlayerPrefsHelper.getString(var_16_0, "")

	return string.nilorempty(var_16_1)
end

function var_0_0.markHasEnter(arg_17_0)
	local var_17_0 = arg_17_0:getPrefsKey()

	PlayerPrefsHelper.setString(var_17_0, "hasEnter")
end

function var_0_0.getPrefsKey(arg_18_0)
	return PlayerPrefsKey.FirstEnterActivity173PanelView .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.refreshActRemainTime, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.switch2NormalView, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.playFirstEnterAudio, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._taskItems then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._taskItems) do
			iter_20_1:destroy()
		end

		arg_20_0._taskItems = nil
	end
end

return var_0_0
