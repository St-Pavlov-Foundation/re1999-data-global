module("modules.logic.versionactivity1_4.act131.view.Activity131GameView", package.seeall)

local var_0_0 = class("Activity131GameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_stage")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.viewGO, "#go_lefttop/#go_stage/#txt_stagenum")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "#go_lefttop/#go_stage/#txt_stagename")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_targetitem")
	arg_1_0._imagetargeticon = gohelper.findChildImage(arg_1_0.viewGO, "#go_lefttop/#go_targetitem/#image_targeticon")
	arg_1_0._txttargetdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_lefttop/#go_targetitem/#txt_targetdesc")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_topbtns")
	arg_1_0._btnStory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Story")
	arg_1_0._goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_Finished")
	arg_1_0._gofinishing = gohelper.findChild(arg_1_0.viewGO, "#go_Finished/vx_finished")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "#go_Finished/image_Finished")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStory:AddClickListener(arg_2_0._btnStoryOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStory:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnStoryOnClick(arg_4_0)
	Activity131Controller.instance:openLogView()
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function()
		local var_6_0 = VersionActivity1_4Enum.ActivityId.Role6
		local var_6_1 = Activity131Model.instance:getCurEpisodeId()

		Activity131Rpc.instance:sendAct131RestartEpisodeRequest(var_6_0, var_6_1)
	end)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._viewAnim = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_7_0:_addEvents()
end

function var_0_0.onOpen(arg_8_0)
	Activity131Model.instance:refreshLogDics()
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)

	local var_8_0 = VersionActivity1_4Enum.ActivityId.Role6
	local var_8_1 = Activity131Model.instance:getCurEpisodeId()

	arg_8_0._config = Activity131Config.instance:getActivity131EpisodeCo(var_8_0, var_8_1)

	local var_8_2 = Activity131Model.instance:getEpisodeProgress(arg_8_0._config.episodeId)

	if arg_8_0.viewParam and arg_8_0.viewParam.exitFromBattle and var_8_2 == Activity131Enum.ProgressType.Finished then
		arg_8_0:onPlayFinishAnim()
	else
		gohelper.setActive(arg_8_0._gofinishing, false)
		gohelper.setActive(arg_8_0._gofinished, var_8_2 == Activity131Enum.ProgressType.Finished)
	end

	if var_8_2 == Activity131Enum.ProgressType.BeforeStory then
		if arg_8_0._config.beforeStoryId > 0 then
			StoryController.instance:playStory(arg_8_0._config.beforeStoryId, nil, arg_8_0._onStoryFinished, arg_8_0)
		else
			arg_8_0:_onStoryFinished()
		end
	elseif var_8_2 == Activity131Enum.ProgressType.Interact then
		arg_8_0:_backToGameView()
	else
		arg_8_0:_backToGameView()
	end
end

function var_0_0.onPlayFinishAnim(arg_9_0)
	if arg_9_0.viewParam.exitFromBattle then
		arg_9_0.viewParam.exitFromBattle = nil
	end

	gohelper.setActive(arg_9_0._gofinished, false)
	gohelper.setActive(arg_9_0._gofinishing, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_molu_exit_appear)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("finishAnim")
	TaskDispatcher.runDelay(arg_9_0._finishAnimCallBack, arg_9_0, 3.5)
end

function var_0_0._finishAnimCallBack(arg_10_0)
	UIBlockMgr.instance:endBlock("finishAnim")

	if arg_10_0._config.afterStoryId > 0 and not StoryModel.instance:isStoryFinished(arg_10_0._config.afterStoryId) then
		local var_10_0 = VersionActivity1_4Enum.ActivityId.Role6
		local var_10_1 = Activity131Model.instance:getCurEpisodeId()
		local var_10_2 = Activity131Config.instance:getActivity131EpisodeCo(var_10_0, var_10_1)

		StoryController.instance:playStory(var_10_2.afterStoryId, nil, arg_10_0._onPlayStorySucess, arg_10_0)
	elseif arg_10_0.firstFinishId and arg_10_0.firstFinishId == arg_10_0._config.episodeId then
		arg_10_0:_backToLevelView()

		arg_10_0.firstFinishId = nil
	end
end

function var_0_0._onPlayStorySucess(arg_11_0)
	Activity131Rpc.instance:sendAct131StoryRequest(arg_11_0._config.activityId, arg_11_0._config.episodeId)
	arg_11_0:_backToLevelView()
end

function var_0_0._backToLevelView(arg_12_0)
	arg_12_0:closeThis()
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)
end

function var_0_0._onFirstFinish(arg_13_0, arg_13_1)
	arg_13_0.firstFinishId = arg_13_1
end

function var_0_0._onStoryFinished(arg_14_0)
	Activity131Rpc.instance:sendAct131StoryRequest(arg_14_0._config.activityId, arg_14_0._config.episodeId, arg_14_0._backToGameView, arg_14_0)
end

function var_0_0._backToGameView(arg_15_0)
	if not arg_15_0._viewAnim then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.AutoStartElement)
	arg_15_0:_refreshUI()
end

function var_0_0._refreshUI(arg_16_0)
	arg_16_0:_showStage(true)

	local var_16_0 = Activity131Model.instance:isEpisodeFinished(arg_16_0._config.episodeId)
	local var_16_1, var_16_2 = Activity131Model.instance:getEpisodeTaskTip(arg_16_0._config.episodeId)

	if var_16_1 ~= 0 and not var_16_0 then
		local var_16_3 = Activity131Config.instance:getActivity131DialogCo(var_16_1, var_16_2)

		arg_16_0:_showTarget(true, var_16_3)
	else
		arg_16_0:_showTarget(false)
	end
end

function var_0_0._showStage(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._gostage, arg_17_1)

	if not arg_17_1 then
		return
	end

	arg_17_0._txtstagenum.text = arg_17_0._config.episodetag
	arg_17_0._txtstagename.text = arg_17_0._config.name
end

function var_0_0._showTarget(arg_18_0, arg_18_1, arg_18_2)
	gohelper.setActive(arg_18_0._gotargetitem, arg_18_1)

	if not arg_18_1 then
		return
	end

	arg_18_0._txttargetdesc.text = arg_18_2.content
end

function var_0_0.onRefreshTaskTips(arg_19_0, arg_19_1)
	local var_19_0 = Activity131Model.instance:getCurEpisodeId()
	local var_19_1 = VersionActivity1_4Enum.ActivityId.Role6

	Activity131Rpc.instance:sendAct131GeneralRequest(var_19_1, var_19_0, arg_19_1.elementId, arg_19_0._backToRefreshTaskTips, arg_19_0)
end

function var_0_0.onElementUpdate(arg_20_0)
	local var_20_0 = Activity131Model.instance:getEpisodeProgress(arg_20_0._config.episodeId)

	if var_20_0 == Activity131Enum.ProgressType.Finished then
		arg_20_0:onPlayFinishAnim()
	elseif var_20_0 ~= Activity131Enum.ProgressType.AfterStory then
		gohelper.setActive(arg_20_0._gofinishing, false)
		gohelper.setActive(arg_20_0._gofinished, false)
	end

	arg_20_0:_refreshUI()
end

function var_0_0._backToRefreshTaskTips(arg_21_0)
	if not arg_21_0._viewAnim then
		return
	end

	local var_21_0 = Activity131Model.instance:getCurEpisodeId()
	local var_21_1, var_21_2 = Activity131Model.instance:getEpisodeTaskTip(var_21_0)
	local var_21_3 = Activity131Config.instance:getActivity131DialogCo(var_21_1, var_21_2)

	arg_21_0:_showTarget(true, var_21_3)
	arg_21_0:_backToGameView()
end

function var_0_0._onCheckAutoStartElement(arg_22_0)
	arg_22_0:_refreshUI()
end

function var_0_0._onRestartSet(arg_23_0)
	arg_23_0:_backToGameView()
end

function var_0_0.onClose(arg_24_0)
	arg_24_0:_removeEvents()
end

function var_0_0.onTriggerLogElement(arg_25_0, arg_25_1)
	local var_25_0 = VersionActivity1_4Enum.ActivityId.Role6
	local var_25_1 = Activity131Model.instance:getCurEpisodeId()

	Activity131Rpc.instance:sendAct131GeneralRequest(var_25_0, var_25_1, arg_25_1.elementId, arg_25_0._backToGameView, arg_25_0)
end

function var_0_0.onTriggerBattleElement(arg_26_0, arg_26_1)
	local var_26_0 = VersionActivity1_4Enum.ActivityId.Role6
	local var_26_1 = Activity131Model.instance:getCurEpisodeId()

	Activity131Rpc.instance:sendBeforeAct131BattleRequest(var_26_0, var_26_1, arg_26_1.elementId)
end

function var_0_0.OnBattleBeforeSucess(arg_27_0, arg_27_1)
	local var_27_0 = Activity131Model.instance:getCurMapElementInfo(arg_27_1)
	local var_27_1 = var_27_0:getType()
	local var_27_2 = var_27_0:getParam()

	if var_27_1 == 1 then
		ViewMgr.instance:openView(ViewName.Activity131BattleView, var_27_2)
	else
		logError("元件类型%s不是战斗元件", var_27_1)
	end
end

function var_0_0._addEvents(arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.RefreshTaskTip, arg_28_0.onRefreshTaskTips, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnElementUpdate, arg_28_0.onElementUpdate, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, arg_28_0._onRestartSet, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, arg_28_0._onCheckAutoStartElement, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_28_0._onCheckAutoStartElement, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.TriggerLogElement, arg_28_0.onTriggerLogElement, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.TriggerBattleElement, arg_28_0.onTriggerBattleElement, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.OnBattleBeforeSucess, arg_28_0.OnBattleBeforeSucess, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.ShowFinish, arg_28_0.onPlayFinishAnim, arg_28_0)
	arg_28_0:addEventCb(Activity131Controller.instance, Activity131Event.FirstFinish, arg_28_0._onFirstFinish, arg_28_0)
end

function var_0_0._removeEvents(arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.RefreshTaskTip, arg_29_0.onRefreshTaskTips, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnElementUpdate, arg_29_0.onElementUpdate, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, arg_29_0._onRestartSet, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, arg_29_0._onCheckAutoStartElement, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, arg_29_0._onCheckAutoStartElement, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.TriggerLogElement, arg_29_0.onTriggerLogElement, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.TriggerBattleElement, arg_29_0.onTriggerBattleElement, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.OnBattleBeforeSucess, arg_29_0.OnBattleBeforeSucess, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.ShowFinish, arg_29_0.onPlayFinishAnim, arg_29_0)
	arg_29_0:removeEventCb(Activity131Controller.instance, Activity131Event.FirstFinish, arg_29_0._onFirstFinish, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0._viewAnim = nil

	TaskDispatcher.cancelTask(arg_30_0._finishAnimCallBack, arg_30_0)
end

return var_0_0
