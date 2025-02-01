module("modules.logic.versionactivity1_5.aizila.view.AiZiLaMapView", package.seeall)

slot0 = class("AiZiLaMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "LeftTop/#simage_Title")
	slot0._goLimitTime = gohelper.findChild(slot0.viewGO, "LeftTop/LimitTime")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LeftTop/LimitTime/#txt_LimitTime")
	slot0._btnPlayBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftTop/#btn_PlayBtn")
	slot0._btnHandBookBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftBottom/#btn_HandBookBtn")
	slot0._goredHandBook = gohelper.findChild(slot0.viewGO, "LeftBottom/#btn_HandBookBtn/#go_redHandBook")
	slot0._btnRecordBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftBottom/#btn_RecordBtn")
	slot0._goredRecord = gohelper.findChild(slot0.viewGO, "LeftBottom/#btn_RecordBtn/#go_redRecord")
	slot0._btnEquipBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightBottom/#btn_EquipBtn")
	slot0._goredEquip = gohelper.findChild(slot0.viewGO, "RightBottom/#btn_EquipBtn/#go_redEquip")
	slot0._btnTaskBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightBottom/#btn_TaskBtn")
	slot0._goredTask = gohelper.findChild(slot0.viewGO, "RightBottom/#btn_TaskBtn/#go_redTask")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlayBtn:AddClickListener(slot0._btnPlayBtnOnClick, slot0)
	slot0._btnHandBookBtn:AddClickListener(slot0._btnHandBookBtnOnClick, slot0)
	slot0._btnRecordBtn:AddClickListener(slot0._btnRecordBtnOnClick, slot0)
	slot0._btnEquipBtn:AddClickListener(slot0._btnEquipBtnOnClick, slot0)
	slot0._btnTaskBtn:AddClickListener(slot0._btnTaskBtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlayBtn:RemoveClickListener()
	slot0._btnHandBookBtn:RemoveClickListener()
	slot0._btnRecordBtn:RemoveClickListener()
	slot0._btnEquipBtn:RemoveClickListener()
	slot0._btnTaskBtn:RemoveClickListener()
end

function slot0._btnRecordBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AiZiLaRecordView)
end

function slot0._btnPlayBtnOnClick(slot0)
	AiZiLaController.instance:playOpenStory(AiZiLaEnum.OpenStoryEpisodeId)
end

function slot0._btnHandBookBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AiZiLaHandbookView)
end

function slot0._btnEquipBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AiZiLaEquipView)
end

function slot0._btnTaskBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AiZiLaTaskView)
end

function slot0._editableInitView(slot0)
	slot0._goTaskTips = gohelper.findChild(slot0.viewGO, "RightBottom/TaskTips")
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot0._stageItemList = {}
	slot0._checkTaskMO = AiZiLaTaskMO.New()
	slot0._episodeCfgList = AiZiLaConfig.instance:getEpisodeList(VersionActivity1_5Enum.ActivityId.AiZiLa) or {}

	for slot6 = 1, math.min(4, #slot0._episodeCfgList) do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AiZiLaStageItem.prefabPath, gohelper.findChild(slot0.viewGO, "Map/Stage" .. slot6)), AiZiLaStageItem, slot0)

		slot8:setCfg(slot0._episodeCfgList[slot6])
		table.insert(slot0._stageItemList, slot8)
	end

	RedDotController.instance:addRedDot(slot0._goredRecord, RedDotEnum.DotNode.V1a5AiZiLaRecord)
	RedDotController.instance:addRedDot(slot0._goredHandBook, RedDotEnum.DotNode.V1a5AiZiLaHandbook)
	RedDotController.instance:addRedDot(slot0._goredEquip, RedDotEnum.DotNode.V1a5AiZiLaEquip)
	RedDotController.instance:addRedDot(slot0._goredTask, RedDotEnum.DotNode.V1a5AiZiLaTask)
	gohelper.setActive(slot0._goLimitTime, false)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshTaskUI, slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.EpisodePush, slot0._refreshStageItemList, slot0)
	slot0:addEventCb(AiZiLaGameController.instance, AiZiLaEvent.GameStoryPlayFinish, slot0._refreshStageItemList, slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0._onExitGame, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:_refreshStageItemList()
	slot0:_showLeftTime()
	slot0:_refreshTaskUI()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)
	slot0:_delayUnlockAnim(AiZiLaEnum.AnimatorTime.MapViewOpen)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_open)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshFinishAnim, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshStageItemList(slot0)
	for slot4 = 1, #slot0._stageItemList do
		slot0._stageItemList[slot4]:refreshUI()
	end
end

function slot0._onExitGame(slot0)
	slot1 = 0.5

	if AiZiLaGameModel.instance:getIsFirstPass() then
		slot0._clearNewEpisodeId = AiZiLaGameModel.instance:getEpisodeId()

		TaskDispatcher.cancelTask(slot0._onRefreshFinishAnim, slot0)
		TaskDispatcher.runDelay(slot0._onRefreshFinishAnim, slot0, slot1)

		slot1 = slot1 + 0.67
	end

	slot0:_delayUnlockAnim(slot1)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.StoryFrontView then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.V1a5AiZiLa)
	end
end

function slot0._onClearNewEpisode(slot0, slot1)
end

function slot0._delayUnlockAnim(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._onRefreshUnlockAnim, slot0)
	TaskDispatcher.runDelay(slot0._onRefreshUnlockAnim, slot0, slot1)
end

function slot0._onRefreshUnlockAnim(slot0)
	for slot4 = 1, #slot0._stageItemList do
		slot0._stageItemList[slot4]:playUnlockAnim()
	end
end

function slot0._onRefreshFinishAnim(slot0)
	for slot4 = 1, #slot0._stageItemList do
		slot5 = slot0._stageItemList[slot4]

		if slot0._clearNewEpisodeId and slot5:getEpisodeId() == slot0._clearNewEpisodeId then
			slot0._clearNewEpisodeId = nil

			slot5:playFinish()
			slot5:refreshUI()
		end
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = AiZiLaHelper.getLimitTimeStr()
end

function slot0._refreshTaskUI(slot0)
	gohelper.setActive(slot0._goTaskTips, slot0:_isNotFinishMainTask())
end

function slot0._isNotFinishMainTask(slot0)
	slot1 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleAiZiLa)
	slot3 = slot0._checkTaskMO

	for slot7, slot8 in ipairs(AiZiLaConfig.instance:getTaskList(VersionActivity1_5Enum.ActivityId.AiZiLa)) do
		slot3:init(slot8, slot1 and slot1[slot8.id])

		if slot3:isMainTask() and not slot3:isFinished() then
			return true
		end
	end

	return false
end

return slot0
