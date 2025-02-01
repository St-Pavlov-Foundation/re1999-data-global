module("modules.logic.versionactivity1_4.act130.view.Activity130GameView", package.seeall)

slot0 = class("Activity130GameView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._gostage = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_stage")
	slot0._txtstagenum = gohelper.findChildText(slot0.viewGO, "#go_lefttop/#go_stage/#txt_stagenum")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "#go_lefttop/#go_stage/#txt_stagename")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "#go_lefttop/#go_targetitem")
	slot0._imagetargeticon = gohelper.findChildImage(slot0.viewGO, "#go_lefttop/#go_targetitem/#image_targeticon")
	slot0._txttargetdesc = gohelper.findChildText(slot0.viewGO, "#go_lefttop/#go_targetitem/targetbg/#txt_targetdesc")
	slot0._gotopbtns = gohelper.findChild(slot0.viewGO, "#go_topbtns")
	slot0._gocollect = gohelper.findChild(slot0.viewGO, "#go_collect")
	slot0._btncollect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_collect/#btn_collect")
	slot0._gocollectreddot = gohelper.findChild(slot0.viewGO, "#go_collect/#go_collectreddot")
	slot0._gocollecteffect = gohelper.findChild(slot0.viewGO, "vx_collect")
	slot0._godecrypt = gohelper.findChild(slot0.viewGO, "#go_decrypt")
	slot0._btndecrypt = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_decrypt/#btn_decrypt", 25001033)
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncollect:AddClickListener(slot0._btncollectOnClick, slot0)
	slot0._btndecrypt:AddClickListener(slot0._btndecryptOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncollect:RemoveClickListener()
	slot0._btndecrypt:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._btncollectOnClick(slot0)
	Activity130Model.instance:setNewCollect(Activity130Model.instance:getCurEpisodeId(), false)
	slot0:_showCollect(true)
	Activity130Controller.instance:openActivity130CollectView()
end

function slot0._btndecryptOnClick(slot0)
	if Activity130Model.instance:getEpisodeDecryptId(Activity130Model.instance:getCurEpisodeId()) ~= 0 then
		Role37PuzzleModel.instance:setPuzzleId(slot2)
		Activity130Controller.instance:openPuzzleView()
	end
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function ()
		slot1 = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130RestartEpisodeRequest(VersionActivity1_4Enum.ActivityId.Role37, slot1)
		Activity130Model.instance:setNewCollect(slot1, false)
		StatActivity130Controller.instance:statReset()
	end)
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._collectAnimator = slot0._gocollecteffect:GetComponent(typeof(UnityEngine.Animator))

	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowLevelScene, false)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)

	slot0._config = Activity130Config.instance:getActivity130EpisodeCo(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId())

	if Activity130Model.instance:getCurMapInfo().progress == Activity130Enum.ProgressType.BeforeStory then
		if slot0._config.beforeStoryId > 0 then
			StoryController.instance:playStory(slot0._config.beforeStoryId, nil, slot0._onStoryFinished, slot0)
		else
			slot0:_onStoryFinished()
		end
	elseif slot3 == Activity130Enum.ProgressType.Interact then
		slot0:_backToGameView()
	elseif slot3 == Activity130Enum.ProgressType.AfterStory then
		if slot0._config.afterStoryId > 0 then
			StoryController.instance:playStory(slot0._config.afterStoryId, nil, slot0._onStoryFinished, slot0)
		else
			slot0:_onStoryFinished()
		end
	else
		slot0:_backToGameView()
	end
end

function slot0._onStoryFinished(slot0)
	Activity130Rpc.instance:sendAct130StoryRequest(slot0._config.activityId, slot0._config.episodeId, slot0._storyBackToGame, slot0)
end

function slot0._storyBackToGame(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot0:_backToGameView()
end

function slot0._puzzleSuccess(slot0, slot1)
	if not slot1 then
		return
	end

	slot2, slot3 = Activity130Model.instance:getEpisodeDecryptId(slot0._config.episodeId)

	if not slot3 and slot2 ~= 0 then
		slot5 = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130GeneralRequest(VersionActivity1_4Enum.ActivityId.Role37, slot5, Activity130Model.instance:getElementInfoByDecryptId(slot2, slot5).elementId, slot0._waitDecryptResultClose, slot0)
	end
end

function slot0._waitDecryptResultClose(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.Role37PuzzleResultView then
		slot0:_backToGameView()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	end
end

function slot0._backToGameView(slot0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.AutoStartElement)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:_showStage(true)

	slot1, slot2 = Activity130Model.instance:getEpisodeTaskTip(slot0._config.episodeId)

	if slot1 ~= 0 then
		slot0:_showTarget(true, Activity130Config.instance:getActivity130DialogCo(slot1, slot2))
	else
		slot0:_showTarget(false)
	end

	slot0:_showCollect(true)

	if Activity130Model.instance:getEpisodeDecryptId(slot0._config.episodeId) ~= 0 then
		slot0:_showDecrypt(true)
	else
		slot0:_showDecrypt(false)
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

function slot0._showCollect(slot0, slot1)
	gohelper.setActive(slot0._gocollect, slot1)

	if not slot1 then
		return
	end

	gohelper.setActive(slot0._gocollectreddot, Activity130Model.instance:getNewCollectState(Activity130Model.instance:getCurEpisodeId()))
end

function slot0._showDecrypt(slot0, slot1)
	gohelper.setActive(slot0._godecrypt, slot1)

	if not slot1 then
		return
	end
end

function slot0.onRefreshTaskTips(slot0, slot1)
	Activity130Rpc.instance:sendAct130GeneralRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot1.elementId, slot0._backToRefreshTaskTips, slot0)
end

function slot0._backToRefreshTaskTips(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot4, slot5 = Activity130Model.instance:getEpisodeTaskTip(Activity130Model.instance:getCurEpisodeId())

	slot0:_showTarget(true, Activity130Config.instance:getActivity130DialogCo(slot4, slot5))
	slot0:_backToGameView()
end

function slot0.onRefreshCollect(slot0, slot1)
	Activity130Rpc.instance:sendAct130GeneralRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot1.elementId, slot0._unlockCollectSuccess, slot0)
end

function slot0._unlockCollectSuccess(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	gohelper.setActive(slot0._gocollecteffect, true)
	slot0._collectAnimator:Play("open", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_gather)
	TaskDispatcher.runDelay(slot0._collectEffectFinished, slot0, 1.87)
	Activity130Model.instance:setNewCollect(Activity130Model.instance:getCurEpisodeId(), true)
	slot0:_showCollect(true)
	slot0:_backToGameView()
end

function slot0._collectEffectFinished(slot0)
	gohelper.setActive(slot0._gocollecteffect, false)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnCollectEffectFinished)
end

function slot0.onRefreshDecrypt(slot0, slot1)
	slot0:_showDecrypt(true)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnUnlockDecryptBtn, slot1.elementId)
end

function slot0.onCheckDecrypt(slot0, slot1)
	Activity130Rpc.instance:sendAct130GeneralRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot1.elementId, slot0._checkDecryptBackToGame, slot0)
end

function slot0._checkDecryptBackToGame(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot0:_backToGameView()
end

function slot0._onCheckAutoStartElement(slot0)
	slot0:_refreshUI()
end

function slot0._onRestartSet(slot0)
	slot0:_backToGameView()
end

function slot0._onShowTipDialog(slot0, slot1)
	Activity130Controller.instance:openActivity130DialogView({
		dialogParam = slot1,
		isClient = true
	})
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, slot0._puzzleSuccess, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.RefreshTaskTip, slot0.onRefreshTaskTips, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.UnlockDecrypt, slot0.onRefreshDecrypt, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.UnlockCollect, slot0.onRefreshCollect, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.CheckDecrypt, slot0.onCheckDecrypt, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, slot0._refreshUI, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, slot0._onRestartSet, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:addEventCb(Activity130Controller.instance, Activity130Event.ShowTipDialog, slot0._onShowTipDialog, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, slot0._puzzleSuccess, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.RefreshTaskTip, slot0.onRefreshTaskTips, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.UnlockDecrypt, slot0.onRefreshDecrypt, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.UnlockCollect, slot0.onRefreshCollect, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.CheckDecrypt, slot0.onCheckDecrypt, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, slot0._refreshUI, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, slot0._onRestartSet, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, slot0._onCheckAutoStartElement, slot0)
	slot0:removeEventCb(Activity130Controller.instance, Activity130Event.ShowTipDialog, slot0._onShowTipDialog, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
