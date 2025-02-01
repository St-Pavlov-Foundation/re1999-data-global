module("modules.logic.versionactivity1_4.act131.view.Activity131GameView", package.seeall)

slot0 = class("Activity131GameView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._gostage = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_stage")
	slot0._txtstagenum = gohelper.findChildText(slot0.viewGO, "#go_lefttop/#go_stage/#txt_stagenum")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "#go_lefttop/#go_stage/#txt_stagename")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_targetitem")
	slot0._imagetargeticon = gohelper.findChildImage(slot0.viewGO, "#go_lefttop/#go_targetitem/#image_targeticon")
	slot0._txttargetdesc = gohelper.findChildText(slot0.viewGO, "#go_lefttop/#go_targetitem/#txt_targetdesc")
	slot0._gotopbtns = gohelper.findChild(slot0.viewGO, "#go_topbtns")
	slot0._btnStory = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Story")
	slot0._goFinished = gohelper.findChild(slot0.viewGO, "#go_Finished")
	slot0._gofinishing = gohelper.findChild(slot0.viewGO, "#go_Finished/vx_finished")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "#go_Finished/image_Finished")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStory:AddClickListener(slot0._btnStoryOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStory:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnStoryOnClick(slot0)
	Activity131Controller.instance:openLogView()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity131Rpc.instance:sendAct131RestartEpisodeRequest(VersionActivity1_4Enum.ActivityId.Role6, Activity131Model.instance:getCurEpisodeId())
	end)
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	Activity131Model.instance:refreshLogDics()
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)

	slot0._config = Activity131Config.instance:getActivity131EpisodeCo(VersionActivity1_4Enum.ActivityId.Role6, Activity131Model.instance:getCurEpisodeId())

	if slot0.viewParam and slot0.viewParam.exitFromBattle and Activity131Model.instance:getEpisodeProgress(slot0._config.episodeId) == Activity131Enum.ProgressType.Finished then
		slot0:onPlayFinishAnim()
	else
		gohelper.setActive(slot0._gofinishing, false)
		gohelper.setActive(slot0._gofinished, slot3 == Activity131Enum.ProgressType.Finished)
	end

	if slot3 == Activity131Enum.ProgressType.BeforeStory then
		if slot0._config.beforeStoryId > 0 then
			StoryController.instance:playStory(slot0._config.beforeStoryId, nil, slot0._onStoryFinished, slot0)
		else
			slot0:_onStoryFinished()
		end
	elseif slot3 == Activity131Enum.ProgressType.Interact then
		slot0:_backToGameView()
	else
		slot0:_backToGameView()
	end
end

function slot0.onPlayFinishAnim(slot0)
	if slot0.viewParam.exitFromBattle then
		slot0.viewParam.exitFromBattle = nil
	end

	gohelper.setActive(slot0._gofinished, false)
	gohelper.setActive(slot0._gofinishing, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_molu_exit_appear)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("finishAnim")
	TaskDispatcher.runDelay(slot0._finishAnimCallBack, slot0, 3.5)
end

function slot0._finishAnimCallBack(slot0)
	UIBlockMgr.instance:endBlock("finishAnim")

	if slot0._config.afterStoryId > 0 and not StoryModel.instance:isStoryFinished(slot0._config.afterStoryId) then
		StoryController.instance:playStory(Activity131Config.instance:getActivity131EpisodeCo(VersionActivity1_4Enum.ActivityId.Role6, Activity131Model.instance:getCurEpisodeId()).afterStoryId, nil, slot0._onPlayStorySucess, slot0)
	elseif slot0.firstFinishId and slot0.firstFinishId == slot0._config.episodeId then
		slot0:_backToLevelView()

		slot0.firstFinishId = nil
	end
end

function slot0._onPlayStorySucess(slot0)
	Activity131Rpc.instance:sendAct131StoryRequest(slot0._config.activityId, slot0._config.episodeId)
	slot0:_backToLevelView()
end

function slot0._backToLevelView(slot0)
	slot0:closeThis()
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)
end

function slot0._onFirstFinish(slot0, slot1)
	slot0.firstFinishId = slot1
end

function slot0._onStoryFinished(slot0)
	Activity131Rpc.instance:sendAct131StoryRequest(slot0._config.activityId, slot0._config.episodeId, slot0._backToGameView, slot0)
end

function slot0._backToGameView(slot0)
	if not slot0._viewAnim then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.AutoStartElement)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:_showStage(true)

	slot2, slot3 = Activity131Model.instance:getEpisodeTaskTip(slot0._config.episodeId)

	if slot2 ~= 0 and not Activity131Model.instance:isEpisodeFinished(slot0._config.episodeId) then
		slot0:_showTarget(true, Activity131Config.instance:getActivity131DialogCo(slot2, slot3))
	else
		slot0:_showTarget(false)
	end
end

function slot0._showStage(slot0, slot1)
	gohelper.setActive(slot0._gostage, slot1)

	if not slot1 then
		return
	end

	slot0._txtstagenum.text = slot0._config.episodetag
	slot0._txtstagename.text = slot0._config.name
end

function slot0._showTarget(slot0, slot1, slot2)
	gohelper.setActive(slot0._gotargetitem, slot1)

	if not slot1 then
		return
	end

	slot0._txttargetdesc.text = slot2.content
end

function slot0.onRefreshTaskTips(slot0, slot1)
	Activity131Rpc.instance:sendAct131GeneralRequest(VersionActivity1_4Enum.ActivityId.Role6, Activity131Model.instance:getCurEpisodeId(), slot1.elementId, slot0._backToRefreshTaskTips, slot0)
end

function slot0.onElementUpdate(slot0)
	if Activity131Model.instance:getEpisodeProgress(slot0._config.episodeId) == Activity131Enum.ProgressType.Finished then
		slot0:onPlayFinishAnim()
	elseif slot1 ~= Activity131Enum.ProgressType.AfterStory then
		gohelper.setActive(slot0._gofinishing, false)
		gohelper.setActive(slot0._gofinished, false)
	end

	slot0:_refreshUI()
end

function slot0._backToRefreshTaskTips(slot0)
	if not slot0._viewAnim then
		return
	end

	slot2, slot3 = Activity131Model.instance:getEpisodeTaskTip(Activity131Model.instance:getCurEpisodeId())

	slot0:_showTarget(true, Activity131Config.instance:getActivity131DialogCo(slot2, slot3))
	slot0:_backToGameView()
end

function slot0._onCheckAutoStartElement(slot0)
	slot0:_refreshUI()
end

function slot0._onRestartSet(slot0)
	slot0:_backToGameView()
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0.onTriggerLogElement(slot0, slot1)
	Activity131Rpc.instance:sendAct131GeneralRequest(VersionActivity1_4Enum.ActivityId.Role6, Activity131Model.instance:getCurEpisodeId(), slot1.elementId, slot0._backToGameView, slot0)
end

function slot0.onTriggerBattleElement(slot0, slot1)
	Activity131Rpc.instance:sendBeforeAct131BattleRequest(VersionActivity1_4Enum.ActivityId.Role6, Activity131Model.instance:getCurEpisodeId(), slot1.elementId)
end

function slot0.OnBattleBeforeSucess(slot0, slot1)
	slot2 = Activity131Model.instance:getCurMapElementInfo(slot1)

	if slot2:getType() == 1 then
		ViewMgr.instance:openView(ViewName.Activity131BattleView, slot2:getParam())
	else
		logError("元件类型%s不是战斗元件", slot3)
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.RefreshTaskTip, slot0.onRefreshTaskTips, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnElementUpdate, slot0.onElementUpdate, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, slot0._onRestartSet, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.TriggerLogElement, slot0.onTriggerLogElement, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.TriggerBattleElement, slot0.onTriggerBattleElement, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.OnBattleBeforeSucess, slot0.OnBattleBeforeSucess, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.ShowFinish, slot0.onPlayFinishAnim, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.FirstFinish, slot0._onFirstFinish, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.RefreshTaskTip, slot0.onRefreshTaskTips, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnElementUpdate, slot0.onElementUpdate, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, slot0._onRestartSet, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.TriggerLogElement, slot0.onTriggerLogElement, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.TriggerBattleElement, slot0.onTriggerBattleElement, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.OnBattleBeforeSucess, slot0.OnBattleBeforeSucess, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.ShowFinish, slot0.onPlayFinishAnim, slot0)
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.FirstFinish, slot0._onFirstFinish, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._viewAnim = nil

	TaskDispatcher.cancelTask(slot0._finishAnimCallBack, slot0)
end

return slot0
