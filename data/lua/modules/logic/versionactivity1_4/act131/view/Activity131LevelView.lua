module("modules.logic.versionactivity1_4.act131.view.Activity131LevelView", package.seeall)

slot0 = class("Activity131LevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._gopath = gohelper.findChild(slot0.viewGO, "#go_path")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_title/#go_time")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task", 25001038)
	slot0._gotaskani = gohelper.findChild(slot0.viewGO, "#btn_task/ani")
	slot0._goreddotreward = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddotreward")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	Activity131Controller.instance:openActivity131TaskView()
end

function slot0._editableInitView(slot0)
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simagemask:LoadImage(ResUrl.getV1a4Role37SingleBg("v1a4_role37_igfullmask"))

	slot0._pathAnimator = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/path/path_2"):GetComponent(typeof(UnityEngine.Animator))
	slot0._taskAnimator = slot0._gotaskani:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_4Enum.ActivityId.Role6)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_4Enum.ActivityId.Role6
	})
	RedDotController.instance:addRedDot(slot0._goreddotreward, RedDotEnum.DotNode.Activity1_4Role6Task)

	if Activity131Model.instance:getMaxUnlockEpisode() == 1 then
		slot0._pathAnimator:Play("go1", 0, 0)

		slot0._pathAnimator.speed = 0
	end

	slot0:_initStages()
	slot0:_addEvents()
	slot0:_backToLevelView()
	slot0:_refreshTask()
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity1_4Role6Task, 0) then
		slot0._taskAnimator:Play("loop", 0, 0)
	else
		slot0._taskAnimator:Play("idle", 0, 0)
	end
end

function slot0._initStages(slot0)
	if slot0._stageItemList then
		return
	end

	slot0._stageItemList = {}

	for slot6 = 1, Activity131Model.instance:getMaxEpisode() do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostages, "stage" .. slot6)), Activity131LevelViewStageItem, slot0)

		slot9:refreshItem(Activity131Config.instance:getActivity131EpisodeCo(VersionActivity1_4Enum.ActivityId.Role6, slot6), slot6)
		table.insert(slot0._stageItemList, slot9)
	end
end

function slot0._refreshStageItem(slot0, slot1, slot2)
	for slot6 = 1, #slot0._stageItemList do
		slot0._stageItemList[slot6]:refreshItem(Activity131Config.instance:getActivity131EpisodeCo(VersionActivity1_4Enum.ActivityId.Role6, slot6), slot6)
	end
end

function slot0._refreshUI(slot0)
	slot1 = Activity131Model.instance:getMaxUnlockEpisode()

	if Activity131Model.instance:getNewUnlockEpisode() > -1 then
		slot1 = slot2
	end

	if slot1 == 1 then
		slot0._pathAnimator.speed = 0

		slot0._pathAnimator:Play("go1", 0, 0)
	else
		slot0._pathAnimator.speed = 1

		slot0._pathAnimator:Play("go" .. slot1 - 1, 0, 1)
	end

	Activity131Model.instance:setNewUnlockEpisode(-1)
	slot0:_refreshStageItem()
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._initDragPos = slot2.position.x
end

function slot0._onDrag(slot0, slot1, slot2)
	slot3 = slot2.position.x

	if recthelper.getAnchorX(slot0._goscrollcontent.transform) + slot2.delta.x * Activity131Enum.SlideSpeed > 0 then
		slot4 = 0
	end

	slot4 = slot4 > -Activity131Enum.MaxSlideX and slot4 or -Activity131Enum.MaxSlideX

	recthelper.setAnchorX(slot0._goscrollcontent.transform, slot4)
	Activity131Controller.instance:dispatchEvent(Activity131Event.SetScenePos, slot4 * Activity131Enum.SceneMaxX / Activity131Enum.MaxSlideX)
end

function slot0._onDragEnd(slot0, slot1, slot2)
end

function slot0._checkLevelUpdate(slot0)
	slot1 = Activity131Model.instance:getCurEpisodeId()
	slot2 = Activity131Model.instance:getEpisodeState(slot1)
	slot6 = Activity131Model.instance:isEpisodeUnlock(slot1 < Activity131Model.instance:getMaxEpisode() and slot1 + 1 or slot1)

	if not Activity131Model.instance:isEpisodeFinished(slot1) then
		return
	end

	if slot6 and slot5 ~= slot1 then
		return
	end

	Activity131Model.instance:setNewFinishEpisode(slot1)
	Activity131Model.instance:setNewUnlockEpisode(slot5 == slot1 and -1 or slot5)
	Activity131Rpc.instance:sendGet131InfosRequest(VersionActivity1_4Enum.ActivityId.Role6, slot0._getInfoSuccess, slot0)
end

function slot0._getInfoSuccess(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.NewEpisodeUnlock)
	slot0:_backToLevelView()
end

function slot0._setToPos(slot0)
	slot0:_onSlideFinish()
end

function slot0._onSlideFinish(slot0)
	slot1 = Activity131Model.instance:getCurEpisodeId()

	if Activity131Model.instance:getNewUnlockEpisode() > -1 then
		slot1 = slot2
	end

	if (slot1 and slot1 or 1) < Activity131Enum.MaxShowEpisodeCount + 1 then
		return
	end

	if Activity131Enum.MaxSlideX < (slot3 - Activity131Enum.MaxShowEpisodeCount) * Activity131Enum.MaxSlideX / (Activity131Model.instance:getTotalEpisodeCount() - Activity131Enum.MaxShowEpisodeCount) then
		slot5 = Activity131Enum.MaxSlideX or slot5
	end

	transformhelper.setLocalPos(slot0._goscrollcontent.transform, -slot5, 0, 0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.SetScenePos, -slot5 * Activity131Enum.SceneMaxX / Activity131Enum.MaxSlideX)
end

function slot0._backToLevelView(slot0)
	StoryController.instance:closeStoryView()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("newepisode")
	slot0._viewAnimator:Play("open", 0, 0)

	slot2 = Activity131Model.instance:getCurEpisodeId()

	if Activity131Model.instance:getNewFinishEpisode() > -1 then
		if slot1 == 1 then
			slot0._pathAnimator.speed = 0

			slot0._pathAnimator:Play("go1", 0, 0)
		else
			slot0._pathAnimator.speed = 1

			slot0._pathAnimator:Play("go" .. slot2 - 1, 0, 1)
		end
	else
		slot0._pathAnimator.speed = 1

		slot0._pathAnimator:Play("go" .. Activity131Model.instance:getMaxUnlockEpisode() - 1, 0, 1)
	end

	slot0:_setToPos()
	TaskDispatcher.runDelay(slot0._checkNewFinishEpisode, slot0, 1)
end

function slot0._checkNewFinishEpisode(slot0)
	if Activity131Model.instance:getNewFinishEpisode() > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.playNewFinishEpisode, slot1)
		Activity131Model.instance:setNewFinishEpisode(-1)
		TaskDispatcher.runDelay(slot0._checkNewUnlockEpisode, slot0, 1.5)
	else
		slot0:_checkNewUnlockEpisode()
	end
end

function slot0._checkNewUnlockEpisode(slot0)
	if Activity131Model.instance:getNewUnlockEpisode() > -1 then
		slot0._pathAnimator.speed = 1

		slot0._pathAnimator:Play("go" .. slot1 - 1, 0, 0)
		TaskDispatcher.runDelay(slot0._startShowUnlock, slot0, 0.34)
	else
		slot0:_startShowUnlock()
	end
end

function slot0._startShowUnlock(slot0)
	UIBlockMgr.instance:endBlock("newepisode")

	if Activity131Model.instance:getNewUnlockEpisode() > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.playNewUnlockEpisode, slot1)
		TaskDispatcher.runDelay(slot0._showUnlockFinished, slot0, 0.67)
	else
		slot0:_showUnlockFinished()
	end
end

function slot0._showUnlockFinished(slot0)
	if Activity131Model.instance:getNewUnlockEpisode() > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.PlayChessAutoToNewEpisode, slot1)
	end

	slot0:_refreshUI()
end

function slot0._enterGameView(slot0)
	slot0._viewAnimator:Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0._realEnterGameView, slot0, 0.34)
end

function slot0._realEnterGameView(slot0)
	Activity131Controller.instance:openActivity131GameView({
		episodeId = Activity131Model.instance:getCurEpisodeId()
	})
end

function slot0._playCloseLevelView(slot0)
	slot0._viewAnimator:Play("close", 0, 0)
end

function slot0._addEvents(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gopath.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, slot0._checkLevelUpdate, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, slot0._checkLevelUpdate, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnStoryFinishedSuccess, slot0._checkLevelUpdate, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, slot0._backToLevelView, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.StartEnterGameView, slot0._enterGameView, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.PlayLeaveLevelView, slot0._playCloseLevelView, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshTask, slot0)
end

function slot0._removeEvents(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, slot0._checkLevelUpdate, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, slot0._checkLevelUpdate, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnStoryFinishedSuccess, slot0._checkLevelUpdate, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, slot0._backToLevelView, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.StartEnterGameView, slot0._enterGameView, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.PlayLeaveLevelView, slot0._playCloseLevelView, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshTask, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._stageItemList then
		for slot4, slot5 in ipairs(slot0._stageItemList) do
			slot5:onDestroyView()
		end

		slot0._stageItemList = nil
	end

	TaskDispatcher.cancelTask(slot0._showUnlockFinished, slot0)
	slot0._simagemask:UnLoadImage()
end

return slot0
