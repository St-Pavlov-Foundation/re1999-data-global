module("modules.logic.activity.view.chessmap.ActivityChessGameMain", package.seeall)

slot0 = class("ActivityChessGameMain", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagechessboard = gohelper.findChildSingleImage(slot0.viewGO, "scroll/viewport/#go_content/#simage_chessboard")
	slot0._txtcurround = gohelper.findChildText(slot0.viewGO, "roundbg/anim/curround/#txt_curround")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_restart")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "scroll/viewport/#go_content")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_taskitem")
	slot0._gooptip = gohelper.findChild(slot0.viewGO, "#go_optip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrestart:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot3 = Activity109Config.instance:getMapCo(ActivityChessGameModel.instance:getActId(), ActivityChessGameModel.instance:getMapId())
	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._conditionItems = {}
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetViewVictory, slot0.onSetViewVictory, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetViewFail, slot0.onSetViewFail, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.CurrentRoundUpdate, slot0.refreshRound, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.CurrentConditionUpdate, slot0.refreshConditions, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameMapDataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetCenterHintText, slot0.setUICenterHintText, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.ResetGameByResultView, slot0.handleResetByResult, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)

	if slot0.viewContainer:isManualClose() then
		Activity109ChessController.instance:statEnd(StatEnum.Result.Abort)
	end

	Activity109ChessController.instance:dispatchEvent(ActivityEvent.Play109EntryViewOpenAni)
end

function slot0.onSetViewVictory(slot0)
	Activity109ChessController.instance:statEnd(StatEnum.Result.Success)

	slot2 = Activity109ChessModel.instance:getEpisodeId()

	if Activity109ChessModel.instance:getActId() ~= nil and slot2 ~= nil then
		if Activity109Config.instance:getEpisodeCo(slot1, slot2) and slot3.storyClear == 0 then
			uv0.openWinResult()

			return
		end

		if not StoryModel.instance:isStoryHasPlayed(slot3.storyClear) then
			StoryController.instance:playStories({
				slot4
			}, nil, uv0.openWinResult)
		else
			uv0.openWinResult()
		end
	end
end

function slot0.openWinResult()
	slot1 = "OnChessWinPause" .. Activity109ChessModel.instance:getEpisodeId()

	GuideController.instance:GuideFlowPauseAndContinue(slot1, GuideEvent[slot1], GuideEvent.OnChessWinContinue, uv0._openSuccessView, nil)
end

function slot0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.ActivityChessGameResultView, {
		result = true
	})
end

function slot0.onSetViewFail(slot0)
	Activity109ChessController.instance:statEnd(StatEnum.Result.Fail)
	ViewMgr.instance:openView(ViewName.ActivityChessGameResultView, {
		result = false
	})
end

function slot0.refreshUI(slot0)
	slot0:refreshRound()
	slot0:refreshConditions()
end

function slot0.refreshRound(slot0)
	slot2 = Activity109ChessModel.instance:getEpisodeId()

	if not Activity109ChessModel.instance:getActId() or not slot2 then
		return
	end

	slot0._txtcurround.text = string.format("%s/<size=36>%s</size>", tostring(ActivityChessGameModel.instance:getRound()), Activity109Config.instance:getEpisodeCo(slot1, slot2).maxRound)
end

function slot0.refreshConditions(slot0)
	slot0:hideAllConditions()

	slot2 = Activity109ChessModel.instance:getEpisodeId()

	if not Activity109ChessModel.instance:getActId() or not slot2 then
		return
	end

	slot3 = Activity109Config.instance:getEpisodeCo(slot1, slot2)
	slot7 = #string.split(slot3.extStarCondition, "|") + 1
	slot11 = slot7

	logNormal("taskLen : " .. tostring(slot11))

	for slot11 = 1, slot7 do
		if slot11 == 1 then
			slot0:refreshConditionItem(slot0:getOrCreateConditionItem(slot11), nil, string.split(slot3.conditionStr, "|")[slot11])
		else
			slot0:refreshConditionItem(slot12, slot5[slot11 - 1], slot6[slot11])
		end
	end
end

function slot0.refreshConditionItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot4 = Activity109ChessModel.instance:getActId()
	slot5 = Activity109ChessModel.instance:getEpisodeId()
	slot6 = nil
	slot7 = false

	if not string.nilorempty(slot2) then
		slot8 = string.splitToNumber(slot2, "#")
		slot6 = slot3 or ActivityChessMapUtils.getClearConditionDesc(slot8, slot4)
		slot7 = ActivityChessMapUtils.isClearConditionFinish(slot8, slot4)
	else
		slot6 = slot3 or luaLang("chessgame_clear_normal")
		slot7 = ActivityChessGameModel.instance:getResult() == true
	end

	slot1.txtTaskDesc.text = slot6

	if not slot1.goFinish.activeSelf and slot7 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.StarLight)
	end

	gohelper.setActive(slot1.goFinish, slot7)
	gohelper.setActive(slot1.goUnFinish, not slot7)
end

function slot0.setUICenterHintText(slot0, slot1)
	slot3 = slot1.text

	gohelper.setActive(slot0._gooptip, slot1.visible)
end

function slot0.getOrCreateConditionItem(slot0, slot1)
	if not slot0._conditionItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gotaskitem, "taskitem_" .. tostring(slot1))
		slot2.txtTaskDesc = gohelper.findChildText(slot2.go, "txt_desc")
		slot2.goFinish = gohelper.findChild(slot2.go, "star/go_finish")
		slot2.goUnFinish = gohelper.findChild(slot2.go, "star/go_unfinish")
		slot0._conditionItems[slot1] = slot2
	end

	return slot2
end

function slot0.hideAllConditions(slot0)
	for slot4, slot5 in pairs(slot0._conditionItems) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0.onResultQuit(slot0)
	slot0:closeThis()
end

function slot0.handleResetByResult(slot0)
	slot0._animRoot:Play("open", 0, 0)
end

slot0.UI_RESTART_BLOCK_KEY = "ActivityChessGameMainDelayRestart"

function slot0._btnrestartOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity109ChessController.instance:statEnd(StatEnum.Result.Reset)
		UIBlockMgr.instance:startBlock(uv0.UI_RESTART_BLOCK_KEY)
		uv1._animRoot:Play("excessive", 0, 0)
		TaskDispatcher.runDelay(uv1.delayRestartGame, uv1, 0.56)
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end)
end

function slot0.delayRestartGame(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)

	if Activity109ChessModel.instance:getEpisodeId() then
		Activity109ChessController.instance:startNewEpisode(slot1)
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameReset)
end

return slot0
