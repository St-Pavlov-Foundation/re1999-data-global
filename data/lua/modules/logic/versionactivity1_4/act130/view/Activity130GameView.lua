module("modules.logic.versionactivity1_4.act130.view.Activity130GameView", package.seeall)

local var_0_0 = class("Activity130GameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_stage")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.viewGO, "#go_lefttop/#go_stage/#txt_stagenum")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "#go_lefttop/#go_stage/#txt_stagename")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop/#go_targetitem")
	arg_1_0._imagetargeticon = gohelper.findChildImage(arg_1_0.viewGO, "#go_lefttop/#go_targetitem/#image_targeticon")
	arg_1_0._txttargetdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_lefttop/#go_targetitem/targetbg/#txt_targetdesc")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_topbtns")
	arg_1_0._gocollect = gohelper.findChild(arg_1_0.viewGO, "#go_collect")
	arg_1_0._btncollect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_collect/#btn_collect")
	arg_1_0._gocollectreddot = gohelper.findChild(arg_1_0.viewGO, "#go_collect/#go_collectreddot")
	arg_1_0._gocollecteffect = gohelper.findChild(arg_1_0.viewGO, "vx_collect")
	arg_1_0._godecrypt = gohelper.findChild(arg_1_0.viewGO, "#go_decrypt")
	arg_1_0._btndecrypt = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_decrypt/#btn_decrypt", 25001033)
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncollect:AddClickListener(arg_2_0._btncollectOnClick, arg_2_0)
	arg_2_0._btndecrypt:AddClickListener(arg_2_0._btndecryptOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncollect:RemoveClickListener()
	arg_3_0._btndecrypt:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btncollectOnClick(arg_4_0)
	local var_4_0 = Activity130Model.instance:getCurEpisodeId()

	Activity130Model.instance:setNewCollect(var_4_0, false)
	arg_4_0:_showCollect(true)
	Activity130Controller.instance:openActivity130CollectView()
end

function var_0_0._btndecryptOnClick(arg_5_0)
	local var_5_0 = Activity130Model.instance:getCurEpisodeId()
	local var_5_1 = Activity130Model.instance:getEpisodeDecryptId(var_5_0)

	if var_5_1 ~= 0 then
		Role37PuzzleModel.instance:setPuzzleId(var_5_1)
		Activity130Controller.instance:openPuzzleView()
	end
end

function var_0_0._btnresetOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function()
		local var_7_0 = VersionActivity1_4Enum.ActivityId.Role37
		local var_7_1 = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130RestartEpisodeRequest(var_7_0, var_7_1)
		Activity130Model.instance:setNewCollect(var_7_1, false)
		StatActivity130Controller.instance:statReset()
	end)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._viewAnim = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._collectAnimator = arg_8_0._gocollecteffect:GetComponent(typeof(UnityEngine.Animator))

	arg_8_0:_addEvents()
end

function var_0_0.onOpen(arg_9_0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowLevelScene, false)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)

	local var_9_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_9_1 = Activity130Model.instance:getCurEpisodeId()

	arg_9_0._config = Activity130Config.instance:getActivity130EpisodeCo(var_9_0, var_9_1)

	local var_9_2 = Activity130Model.instance:getCurMapInfo().progress

	if var_9_2 == Activity130Enum.ProgressType.BeforeStory then
		if arg_9_0._config.beforeStoryId > 0 then
			StoryController.instance:playStory(arg_9_0._config.beforeStoryId, nil, arg_9_0._onStoryFinished, arg_9_0)
		else
			arg_9_0:_onStoryFinished()
		end
	elseif var_9_2 == Activity130Enum.ProgressType.Interact then
		arg_9_0:_backToGameView()
	elseif var_9_2 == Activity130Enum.ProgressType.AfterStory then
		if arg_9_0._config.afterStoryId > 0 then
			StoryController.instance:playStory(arg_9_0._config.afterStoryId, nil, arg_9_0._onStoryFinished, arg_9_0)
		else
			arg_9_0:_onStoryFinished()
		end
	else
		arg_9_0:_backToGameView()
	end
end

function var_0_0._onStoryFinished(arg_10_0)
	Activity130Rpc.instance:sendAct130StoryRequest(arg_10_0._config.activityId, arg_10_0._config.episodeId, arg_10_0._storyBackToGame, arg_10_0)
end

function var_0_0._storyBackToGame(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 ~= 0 then
		return
	end

	arg_11_0:_backToGameView()
end

function var_0_0._puzzleSuccess(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0, var_12_1 = Activity130Model.instance:getEpisodeDecryptId(arg_12_0._config.episodeId)

	if not var_12_1 and var_12_0 ~= 0 then
		local var_12_2 = VersionActivity1_4Enum.ActivityId.Role37
		local var_12_3 = Activity130Model.instance:getCurEpisodeId()
		local var_12_4 = Activity130Model.instance:getElementInfoByDecryptId(var_12_0, var_12_3)

		Activity130Rpc.instance:sendAct130GeneralRequest(var_12_2, var_12_3, var_12_4.elementId, arg_12_0._waitDecryptResultClose, arg_12_0)
	end
end

function var_0_0._waitDecryptResultClose(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 ~= 0 then
		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_13_0._onCloseViewFinish, arg_13_0)
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.Role37PuzzleResultView then
		arg_14_0:_backToGameView()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_14_0._onCloseViewFinish, arg_14_0)
	end
end

function var_0_0._backToGameView(arg_15_0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.AutoStartElement)
	arg_15_0:_refreshUI()
end

function var_0_0._refreshUI(arg_16_0)
	arg_16_0:_showStage(true)

	local var_16_0, var_16_1 = Activity130Model.instance:getEpisodeTaskTip(arg_16_0._config.episodeId)

	if var_16_0 ~= 0 then
		local var_16_2 = Activity130Config.instance:getActivity130DialogCo(var_16_0, var_16_1)

		arg_16_0:_showTarget(true, var_16_2)
	else
		arg_16_0:_showTarget(false)
	end

	arg_16_0:_showCollect(true)

	if Activity130Model.instance:getEpisodeDecryptId(arg_16_0._config.episodeId) ~= 0 then
		arg_16_0:_showDecrypt(true)
	else
		arg_16_0:_showDecrypt(false)
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

function var_0_0._showCollect(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._gocollect, arg_19_1)

	if not arg_19_1 then
		return
	end

	local var_19_0 = Activity130Model.instance:getCurEpisodeId()
	local var_19_1 = Activity130Model.instance:getNewCollectState(var_19_0)

	gohelper.setActive(arg_19_0._gocollectreddot, var_19_1)
end

function var_0_0._showDecrypt(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._godecrypt, arg_20_1)

	if not arg_20_1 then
		return
	end
end

function var_0_0.onRefreshTaskTips(arg_21_0, arg_21_1)
	local var_21_0 = Activity130Model.instance:getCurEpisodeId()
	local var_21_1 = VersionActivity1_4Enum.ActivityId.Role37

	Activity130Rpc.instance:sendAct130GeneralRequest(var_21_1, var_21_0, arg_21_1.elementId, arg_21_0._backToRefreshTaskTips, arg_21_0)
end

function var_0_0._backToRefreshTaskTips(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 ~= 0 then
		return
	end

	local var_22_0 = Activity130Model.instance:getCurEpisodeId()
	local var_22_1, var_22_2 = Activity130Model.instance:getEpisodeTaskTip(var_22_0)
	local var_22_3 = Activity130Config.instance:getActivity130DialogCo(var_22_1, var_22_2)

	arg_22_0:_showTarget(true, var_22_3)
	arg_22_0:_backToGameView()
end

function var_0_0.onRefreshCollect(arg_23_0, arg_23_1)
	local var_23_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_23_1 = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130GeneralRequest(var_23_0, var_23_1, arg_23_1.elementId, arg_23_0._unlockCollectSuccess, arg_23_0)
end

function var_0_0._unlockCollectSuccess(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 ~= 0 then
		return
	end

	gohelper.setActive(arg_24_0._gocollecteffect, true)
	arg_24_0._collectAnimator:Play("open", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_gather)
	TaskDispatcher.runDelay(arg_24_0._collectEffectFinished, arg_24_0, 1.87)

	local var_24_0 = Activity130Model.instance:getCurEpisodeId()

	Activity130Model.instance:setNewCollect(var_24_0, true)
	arg_24_0:_showCollect(true)
	arg_24_0:_backToGameView()
end

function var_0_0._collectEffectFinished(arg_25_0)
	gohelper.setActive(arg_25_0._gocollecteffect, false)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnCollectEffectFinished)
end

function var_0_0.onRefreshDecrypt(arg_26_0, arg_26_1)
	arg_26_0:_showDecrypt(true)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnUnlockDecryptBtn, arg_26_1.elementId)
end

function var_0_0.onCheckDecrypt(arg_27_0, arg_27_1)
	local var_27_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_27_1 = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130GeneralRequest(var_27_0, var_27_1, arg_27_1.elementId, arg_27_0._checkDecryptBackToGame, arg_27_0)
end

function var_0_0._checkDecryptBackToGame(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_2 ~= 0 then
		return
	end

	arg_28_0:_backToGameView()
end

function var_0_0._onCheckAutoStartElement(arg_29_0)
	arg_29_0:_refreshUI()
end

function var_0_0._onRestartSet(arg_30_0)
	arg_30_0:_backToGameView()
end

function var_0_0._onShowTipDialog(arg_31_0, arg_31_1)
	local var_31_0 = {
		dialogParam = arg_31_1
	}

	var_31_0.isClient = true

	Activity130Controller.instance:openActivity130DialogView(var_31_0)
end

function var_0_0.onClose(arg_32_0)
	arg_32_0:_removeEvents()
end

function var_0_0._addEvents(arg_33_0)
	arg_33_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, arg_33_0._puzzleSuccess, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.RefreshTaskTip, arg_33_0.onRefreshTaskTips, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.UnlockDecrypt, arg_33_0.onRefreshDecrypt, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.UnlockCollect, arg_33_0.onRefreshCollect, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.CheckDecrypt, arg_33_0.onCheckDecrypt, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, arg_33_0._refreshUI, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, arg_33_0._onRestartSet, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, arg_33_0._onCheckAutoStartElement, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, arg_33_0._onCheckAutoStartElement, arg_33_0)
	arg_33_0:addEventCb(Activity130Controller.instance, Activity130Event.ShowTipDialog, arg_33_0._onShowTipDialog, arg_33_0)
end

function var_0_0._removeEvents(arg_34_0)
	arg_34_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, arg_34_0._puzzleSuccess, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.RefreshTaskTip, arg_34_0.onRefreshTaskTips, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.UnlockDecrypt, arg_34_0.onRefreshDecrypt, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.UnlockCollect, arg_34_0.onRefreshCollect, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.CheckDecrypt, arg_34_0.onCheckDecrypt, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnElementUpdate, arg_34_0._refreshUI, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, arg_34_0._onRestartSet, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, arg_34_0._onCheckAutoStartElement, arg_34_0)
	arg_34_0:removeEventCb(Activity130Controller.instance, Activity130Event.ShowTipDialog, arg_34_0._onShowTipDialog, arg_34_0)
end

function var_0_0.onDestroyView(arg_35_0)
	return
end

return var_0_0
