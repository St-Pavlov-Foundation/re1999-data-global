module("modules.logic.versionactivity1_4.act131.view.Activity131LevelView", package.seeall)

local var_0_0 = class("Activity131LevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_title/#go_time")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task", 25001038)
	arg_1_0._gotaskani = gohelper.findChild(arg_1_0.viewGO, "#btn_task/ani")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	Activity131Controller.instance:openActivity131TaskView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._viewAnimator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_5_0._simagemask:LoadImage(ResUrl.getV1a4Role37SingleBg("v1a4_role37_igfullmask"))

	arg_5_0._pathAnimator = gohelper.findChild(arg_5_0.viewGO, "#go_path/#go_scrollcontent/path/path_2"):GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._taskAnimator = arg_5_0._gotaskani:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_4Enum.ActivityId.Role6)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_4Enum.ActivityId.Role6
	})
	RedDotController.instance:addRedDot(arg_7_0._goreddotreward, RedDotEnum.DotNode.Activity1_4Role6Task)

	if Activity131Model.instance:getMaxUnlockEpisode() == 1 then
		arg_7_0._pathAnimator:Play("go1", 0, 0)

		arg_7_0._pathAnimator.speed = 0
	end

	arg_7_0:_initStages()
	arg_7_0:_addEvents()
	arg_7_0:_backToLevelView()
	arg_7_0:_refreshTask()
end

function var_0_0._refreshTask(arg_8_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity1_4Role6Task, 0) then
		arg_8_0._taskAnimator:Play("loop", 0, 0)
	else
		arg_8_0._taskAnimator:Play("idle", 0, 0)
	end
end

function var_0_0._initStages(arg_9_0)
	if arg_9_0._stageItemList then
		return
	end

	local var_9_0 = arg_9_0.viewContainer:getSetting().otherRes[1]

	arg_9_0._stageItemList = {}

	local var_9_1 = Activity131Model.instance:getMaxEpisode()

	for iter_9_0 = 1, var_9_1 do
		local var_9_2 = gohelper.findChild(arg_9_0._gostages, "stage" .. iter_9_0)
		local var_9_3 = arg_9_0:getResInst(var_9_0, var_9_2)
		local var_9_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_3, Activity131LevelViewStageItem, arg_9_0)
		local var_9_5 = VersionActivity1_4Enum.ActivityId.Role6
		local var_9_6 = Activity131Config.instance:getActivity131EpisodeCo(var_9_5, iter_9_0)

		var_9_4:refreshItem(var_9_6, iter_9_0)
		table.insert(arg_9_0._stageItemList, var_9_4)
	end
end

function var_0_0._refreshStageItem(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = 1, #arg_10_0._stageItemList do
		local var_10_0 = VersionActivity1_4Enum.ActivityId.Role6
		local var_10_1 = Activity131Config.instance:getActivity131EpisodeCo(var_10_0, iter_10_0)

		arg_10_0._stageItemList[iter_10_0]:refreshItem(var_10_1, iter_10_0)
	end
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = Activity131Model.instance:getMaxUnlockEpisode()
	local var_11_1 = Activity131Model.instance:getNewUnlockEpisode()

	if var_11_1 > -1 then
		var_11_0 = var_11_1
	end

	if var_11_0 == 1 then
		arg_11_0._pathAnimator.speed = 0

		arg_11_0._pathAnimator:Play("go1", 0, 0)
	else
		arg_11_0._pathAnimator.speed = 1

		arg_11_0._pathAnimator:Play("go" .. var_11_0 - 1, 0, 1)
	end

	Activity131Model.instance:setNewUnlockEpisode(-1)
	arg_11_0:_refreshStageItem()
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:_removeEvents()
end

function var_0_0._onDragBegin(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._initDragPos = arg_13_2.position.x
end

function var_0_0._onDrag(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2.position.x
	local var_14_1 = recthelper.getAnchorX(arg_14_0._goscrollcontent.transform) + arg_14_2.delta.x * Activity131Enum.SlideSpeed

	var_14_1 = var_14_1 > 0 and 0 or var_14_1
	var_14_1 = var_14_1 > -Activity131Enum.MaxSlideX and var_14_1 or -Activity131Enum.MaxSlideX

	recthelper.setAnchorX(arg_14_0._goscrollcontent.transform, var_14_1)

	local var_14_2 = var_14_1 * Activity131Enum.SceneMaxX / Activity131Enum.MaxSlideX

	Activity131Controller.instance:dispatchEvent(Activity131Event.SetScenePos, var_14_2)
end

function var_0_0._onDragEnd(arg_15_0, arg_15_1, arg_15_2)
	return
end

function var_0_0._checkLevelUpdate(arg_16_0)
	local var_16_0 = Activity131Model.instance:getCurEpisodeId()
	local var_16_1 = Activity131Model.instance:getEpisodeState(var_16_0)
	local var_16_2 = Activity131Model.instance:isEpisodeFinished(var_16_0)
	local var_16_3 = var_16_0 < Activity131Model.instance:getMaxEpisode() and var_16_0 + 1 or var_16_0
	local var_16_4 = Activity131Model.instance:isEpisodeUnlock(var_16_3)

	if not var_16_2 then
		return
	end

	if var_16_4 and var_16_3 ~= var_16_0 then
		return
	end

	Activity131Model.instance:setNewFinishEpisode(var_16_0)

	local var_16_5 = var_16_3 == var_16_0 and -1 or var_16_3

	Activity131Model.instance:setNewUnlockEpisode(var_16_5)

	local var_16_6 = VersionActivity1_4Enum.ActivityId.Role6

	Activity131Rpc.instance:sendGet131InfosRequest(var_16_6, arg_16_0._getInfoSuccess, arg_16_0)
end

function var_0_0._getInfoSuccess(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.NewEpisodeUnlock)
	arg_17_0:_backToLevelView()
end

function var_0_0._setToPos(arg_18_0)
	arg_18_0:_onSlideFinish()
end

function var_0_0._onSlideFinish(arg_19_0)
	local var_19_0 = Activity131Model.instance:getCurEpisodeId()
	local var_19_1 = Activity131Model.instance:getNewUnlockEpisode()

	if var_19_1 > -1 then
		var_19_0 = var_19_1
	end

	local var_19_2 = var_19_0 and var_19_0 or 1

	if var_19_2 < Activity131Enum.MaxShowEpisodeCount + 1 then
		return
	end

	local var_19_3 = Activity131Model.instance:getTotalEpisodeCount()
	local var_19_4 = (var_19_2 - Activity131Enum.MaxShowEpisodeCount) * Activity131Enum.MaxSlideX / (var_19_3 - Activity131Enum.MaxShowEpisodeCount)

	var_19_4 = var_19_4 > Activity131Enum.MaxSlideX and Activity131Enum.MaxSlideX or var_19_4

	transformhelper.setLocalPos(arg_19_0._goscrollcontent.transform, -var_19_4, 0, 0)

	local var_19_5 = -var_19_4 * Activity131Enum.SceneMaxX / Activity131Enum.MaxSlideX

	Activity131Controller.instance:dispatchEvent(Activity131Event.SetScenePos, var_19_5)
end

function var_0_0._backToLevelView(arg_20_0)
	StoryController.instance:closeStoryView()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("newepisode")
	arg_20_0._viewAnimator:Play("open", 0, 0)

	local var_20_0 = Activity131Model.instance:getNewFinishEpisode()
	local var_20_1 = Activity131Model.instance:getCurEpisodeId()

	if var_20_0 > -1 then
		local var_20_2 = var_20_0

		if var_20_2 == 1 then
			arg_20_0._pathAnimator.speed = 0

			arg_20_0._pathAnimator:Play("go1", 0, 0)
		else
			arg_20_0._pathAnimator.speed = 1

			arg_20_0._pathAnimator:Play("go" .. var_20_2 - 1, 0, 1)
		end
	else
		local var_20_3 = Activity131Model.instance:getMaxUnlockEpisode()

		arg_20_0._pathAnimator.speed = 1

		arg_20_0._pathAnimator:Play("go" .. var_20_3 - 1, 0, 1)
	end

	arg_20_0:_setToPos()
	TaskDispatcher.runDelay(arg_20_0._checkNewFinishEpisode, arg_20_0, 1)
end

function var_0_0._checkNewFinishEpisode(arg_21_0)
	local var_21_0 = Activity131Model.instance:getNewFinishEpisode()

	if var_21_0 > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.playNewFinishEpisode, var_21_0)
		Activity131Model.instance:setNewFinishEpisode(-1)
		TaskDispatcher.runDelay(arg_21_0._checkNewUnlockEpisode, arg_21_0, 1.5)
	else
		arg_21_0:_checkNewUnlockEpisode()
	end
end

function var_0_0._checkNewUnlockEpisode(arg_22_0)
	local var_22_0 = Activity131Model.instance:getNewUnlockEpisode()

	if var_22_0 > -1 then
		arg_22_0._pathAnimator.speed = 1

		arg_22_0._pathAnimator:Play("go" .. var_22_0 - 1, 0, 0)
		TaskDispatcher.runDelay(arg_22_0._startShowUnlock, arg_22_0, 0.34)
	else
		arg_22_0:_startShowUnlock()
	end
end

function var_0_0._startShowUnlock(arg_23_0)
	UIBlockMgr.instance:endBlock("newepisode")

	local var_23_0 = Activity131Model.instance:getNewUnlockEpisode()

	if var_23_0 > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.playNewUnlockEpisode, var_23_0)
		TaskDispatcher.runDelay(arg_23_0._showUnlockFinished, arg_23_0, 0.67)
	else
		arg_23_0:_showUnlockFinished()
	end
end

function var_0_0._showUnlockFinished(arg_24_0)
	local var_24_0 = Activity131Model.instance:getNewUnlockEpisode()

	if var_24_0 > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.PlayChessAutoToNewEpisode, var_24_0)
	end

	arg_24_0:_refreshUI()
end

function var_0_0._enterGameView(arg_25_0)
	arg_25_0._viewAnimator:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_25_0._realEnterGameView, arg_25_0, 0.34)
end

function var_0_0._realEnterGameView(arg_26_0)
	local var_26_0 = {
		episodeId = Activity131Model.instance:getCurEpisodeId()
	}

	Activity131Controller.instance:openActivity131GameView(var_26_0)
end

function var_0_0._playCloseLevelView(arg_27_0)
	arg_27_0._viewAnimator:Play("close", 0, 0)
end

function var_0_0._addEvents(arg_28_0)
	arg_28_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_28_0._gopath.gameObject)

	arg_28_0._drag:AddDragBeginListener(arg_28_0._onDragBegin, arg_28_0)
	arg_28_0._drag:AddDragEndListener(arg_28_0._onDragEnd, arg_28_0)
	arg_28_0._drag:AddDragListener(arg_28_0._onDrag, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_28_0._checkLevelUpdate, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, arg_28_0._checkLevelUpdate, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnStoryFinishedSuccess, arg_28_0._checkLevelUpdate, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, arg_28_0._backToLevelView, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.StartEnterGameView, arg_28_0._enterGameView, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.PlayLeaveLevelView, arg_28_0._playCloseLevelView, arg_28_0)
	arg_28_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_28_0._refreshTask, arg_28_0)
end

function var_0_0._removeEvents(arg_29_0)
	arg_29_0._drag:RemoveDragBeginListener()
	arg_29_0._drag:RemoveDragListener()
	arg_29_0._drag:RemoveDragEndListener()
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_29_0._checkLevelUpdate, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, arg_29_0._checkLevelUpdate, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnStoryFinishedSuccess, arg_29_0._checkLevelUpdate, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, arg_29_0._backToLevelView, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.StartEnterGameView, arg_29_0._enterGameView, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.PlayLeaveLevelView, arg_29_0._playCloseLevelView, arg_29_0)
	arg_29_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_29_0._refreshTask, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	if arg_30_0._stageItemList then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0._stageItemList) do
			iter_30_1:onDestroyView()
		end

		arg_30_0._stageItemList = nil
	end

	TaskDispatcher.cancelTask(arg_30_0._showUnlockFinished, arg_30_0)
	arg_30_0._simagemask:UnLoadImage()
end

return var_0_0
