module("modules.logic.versionactivity1_5.aizila.view.AiZiLaMapView", package.seeall)

local var_0_0 = class("AiZiLaMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "LeftTop/#simage_Title")
	arg_1_0._goLimitTime = gohelper.findChild(arg_1_0.viewGO, "LeftTop/LimitTime")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/LimitTime/#txt_LimitTime")
	arg_1_0._btnPlayBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftTop/#btn_PlayBtn")
	arg_1_0._btnHandBookBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftBottom/#btn_HandBookBtn")
	arg_1_0._goredHandBook = gohelper.findChild(arg_1_0.viewGO, "LeftBottom/#btn_HandBookBtn/#go_redHandBook")
	arg_1_0._btnRecordBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftBottom/#btn_RecordBtn")
	arg_1_0._goredRecord = gohelper.findChild(arg_1_0.viewGO, "LeftBottom/#btn_RecordBtn/#go_redRecord")
	arg_1_0._btnEquipBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightBottom/#btn_EquipBtn")
	arg_1_0._goredEquip = gohelper.findChild(arg_1_0.viewGO, "RightBottom/#btn_EquipBtn/#go_redEquip")
	arg_1_0._btnTaskBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightBottom/#btn_TaskBtn")
	arg_1_0._goredTask = gohelper.findChild(arg_1_0.viewGO, "RightBottom/#btn_TaskBtn/#go_redTask")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayBtn:AddClickListener(arg_2_0._btnPlayBtnOnClick, arg_2_0)
	arg_2_0._btnHandBookBtn:AddClickListener(arg_2_0._btnHandBookBtnOnClick, arg_2_0)
	arg_2_0._btnRecordBtn:AddClickListener(arg_2_0._btnRecordBtnOnClick, arg_2_0)
	arg_2_0._btnEquipBtn:AddClickListener(arg_2_0._btnEquipBtnOnClick, arg_2_0)
	arg_2_0._btnTaskBtn:AddClickListener(arg_2_0._btnTaskBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlayBtn:RemoveClickListener()
	arg_3_0._btnHandBookBtn:RemoveClickListener()
	arg_3_0._btnRecordBtn:RemoveClickListener()
	arg_3_0._btnEquipBtn:RemoveClickListener()
	arg_3_0._btnTaskBtn:RemoveClickListener()
end

function var_0_0._btnRecordBtnOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.AiZiLaRecordView)
end

function var_0_0._btnPlayBtnOnClick(arg_5_0)
	AiZiLaController.instance:playOpenStory(AiZiLaEnum.OpenStoryEpisodeId)
end

function var_0_0._btnHandBookBtnOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.AiZiLaHandbookView)
end

function var_0_0._btnEquipBtnOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.AiZiLaEquipView)
end

function var_0_0._btnTaskBtnOnClick(arg_8_0)
	ViewMgr.instance:openView(ViewName.AiZiLaTaskView)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goTaskTips = gohelper.findChild(arg_9_0.viewGO, "RightBottom/TaskTips")
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	local var_9_0 = AiZiLaStageItem.prefabPath

	arg_9_0._stageItemList = {}
	arg_9_0._checkTaskMO = AiZiLaTaskMO.New()
	arg_9_0._episodeCfgList = AiZiLaConfig.instance:getEpisodeList(VersionActivity1_5Enum.ActivityId.AiZiLa) or {}

	local var_9_1 = math.min(4, #arg_9_0._episodeCfgList)

	for iter_9_0 = 1, var_9_1 do
		local var_9_2 = arg_9_0:getResInst(var_9_0, gohelper.findChild(arg_9_0.viewGO, "Map/Stage" .. iter_9_0))
		local var_9_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_2, AiZiLaStageItem, arg_9_0)

		var_9_3:setCfg(arg_9_0._episodeCfgList[iter_9_0])
		table.insert(arg_9_0._stageItemList, var_9_3)
	end

	RedDotController.instance:addRedDot(arg_9_0._goredRecord, RedDotEnum.DotNode.V1a5AiZiLaRecord)
	RedDotController.instance:addRedDot(arg_9_0._goredHandBook, RedDotEnum.DotNode.V1a5AiZiLaHandbook)
	RedDotController.instance:addRedDot(arg_9_0._goredEquip, RedDotEnum.DotNode.V1a5AiZiLaEquip)
	RedDotController.instance:addRedDot(arg_9_0._goredTask, RedDotEnum.DotNode.V1a5AiZiLaTask)
	gohelper.setActive(arg_9_0._goLimitTime, false)
end

function var_0_0.playViewAnimator(arg_10_0, arg_10_1)
	if arg_10_0._animator then
		arg_10_0._animator.enabled = true

		arg_10_0._animator:Play(arg_10_1, 0, 0)
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_12_0._refreshTaskUI, arg_12_0)
	arg_12_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.EpisodePush, arg_12_0._refreshStageItemList, arg_12_0)
	arg_12_0:addEventCb(AiZiLaGameController.instance, AiZiLaEvent.GameStoryPlayFinish, arg_12_0._refreshStageItemList, arg_12_0)
	arg_12_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_12_0._onExitGame, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_12_0._onCloseViewFinish, arg_12_0)
	arg_12_0:_refreshStageItemList()
	arg_12_0:_showLeftTime()
	arg_12_0:_refreshTaskUI()
	TaskDispatcher.runRepeat(arg_12_0._showLeftTime, arg_12_0, 1)
	arg_12_0:_delayUnlockAnim(AiZiLaEnum.AnimatorTime.MapViewOpen)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_open)
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._showLeftTime, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onRefreshUnlockAnim, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onRefreshFinishAnim, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

function var_0_0._refreshStageItemList(arg_15_0)
	for iter_15_0 = 1, #arg_15_0._stageItemList do
		arg_15_0._stageItemList[iter_15_0]:refreshUI()
	end
end

function var_0_0._onExitGame(arg_16_0)
	local var_16_0 = 0.5

	if AiZiLaGameModel.instance:getIsFirstPass() then
		arg_16_0._clearNewEpisodeId = AiZiLaGameModel.instance:getEpisodeId()

		TaskDispatcher.cancelTask(arg_16_0._onRefreshFinishAnim, arg_16_0)
		TaskDispatcher.runDelay(arg_16_0._onRefreshFinishAnim, arg_16_0, var_16_0)

		var_16_0 = var_16_0 + 0.67
	end

	arg_16_0:_delayUnlockAnim(var_16_0)
end

function var_0_0._onCloseViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.StoryFrontView then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.V1a5AiZiLa)
	end
end

function var_0_0._onClearNewEpisode(arg_18_0, arg_18_1)
	return
end

function var_0_0._delayUnlockAnim(arg_19_0, arg_19_1)
	TaskDispatcher.cancelTask(arg_19_0._onRefreshUnlockAnim, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._onRefreshUnlockAnim, arg_19_0, arg_19_1)
end

function var_0_0._onRefreshUnlockAnim(arg_20_0)
	for iter_20_0 = 1, #arg_20_0._stageItemList do
		arg_20_0._stageItemList[iter_20_0]:playUnlockAnim()
	end
end

function var_0_0._onRefreshFinishAnim(arg_21_0)
	for iter_21_0 = 1, #arg_21_0._stageItemList do
		local var_21_0 = arg_21_0._stageItemList[iter_21_0]

		if arg_21_0._clearNewEpisodeId and var_21_0:getEpisodeId() == arg_21_0._clearNewEpisodeId then
			arg_21_0._clearNewEpisodeId = nil

			var_21_0:playFinish()
			var_21_0:refreshUI()
		end
	end
end

function var_0_0._showLeftTime(arg_22_0)
	arg_22_0._txtLimitTime.text = AiZiLaHelper.getLimitTimeStr()
end

function var_0_0._refreshTaskUI(arg_23_0)
	gohelper.setActive(arg_23_0._goTaskTips, arg_23_0:_isNotFinishMainTask())
end

function var_0_0._isNotFinishMainTask(arg_24_0)
	local var_24_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleAiZiLa)
	local var_24_1 = AiZiLaConfig.instance:getTaskList(VersionActivity1_5Enum.ActivityId.AiZiLa)
	local var_24_2 = arg_24_0._checkTaskMO

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		var_24_2:init(iter_24_1, var_24_0 and var_24_0[iter_24_1.id])

		if var_24_2:isMainTask() and not var_24_2:isFinished() then
			return true
		end
	end

	return false
end

return var_0_0
