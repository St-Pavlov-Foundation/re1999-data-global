module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameView", package.seeall)

slot0 = class("YaXianGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtEpisodeIndex = gohelper.findChildText(slot0.viewGO, "root/upleft/bg/#txt_classnum")
	slot0._txtEpisodeName = gohelper.findChildText(slot0.viewGO, "root/upleft/bg/#txt_title")
	slot0._txtroundnum = gohelper.findChildText(slot0.viewGO, "root/upleft/round/cn/#txt_roundnum")
	slot0._txtmaxroundnum = gohelper.findChildText(slot0.viewGO, "root/upleft/round/cn/#txt_roundnum/#txt_fullnum")
	slot0._btnfallback = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/upright/#btn_fallback")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/upright/#btn_reset")
	slot0._cloudmask = gohelper.findChildSingleImage(slot0.viewGO, "cloudmask")
	slot0._middlemask = gohelper.findChildSingleImage(slot0.viewGO, "middlemask")
	slot0._mask = gohelper.findChildSingleImage(slot0.viewGO, "mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnfallback:AddClickListener(slot0._btnfallbackOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
	slot0._btnfallback:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesclose)
	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, slot0.playResetAnimation, nil, , slot0)
end

function slot0.playResetAnimation(slot0)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Reset)
	UIBlockMgr.instance:startBlock(slot0.viewName .. "excessive")
	slot0.viewAnimator:Play("excessive", 0, 0)

	slot0.resetMap = true

	TaskDispatcher.cancelTask(slot0.onExcessiveAnimationDone, slot0)
	TaskDispatcher.runDelay(slot0.onExcessiveAnimationDone, slot0, 1)
end

function slot0.onExcessiveAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "excessive")
end

function slot0.startReset(slot0)
	YaXianGameController.instance:stopRunningStep()
	ViewMgr.instance:closeView(ViewName.YaXianGameResultView)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnResetView)
	YaXianGameController.instance:enterChessGame(YaXianGameModel.instance:getEpisodeId())
end

function slot0._btnfallbackOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	Activity115Rpc.instance:sendAct115RevertRequest(YaXianGameModel.instance:getActId())
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.YaXianGameTipView then
		slot0:setUIVisible(false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.YaXianGameTipView then
		slot0:setUIVisible(true)
	end
end

function slot0._editableInitView(slot0)
	slot0._cloudmask:LoadImage(ResUrl.getYaXianImage("img_gezi_cloud"))
	slot0._middlemask:LoadImage(ResUrl.getYaXianImage("img_gezi_deco"))
	slot0._mask:LoadImage(ResUrl.getYaXianImage("img_gezi_deco2"))

	slot0.goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0.goBtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0.conditionItemList = {}
	slot0.goConditionItem = gohelper.findChild(slot0.viewGO, "root/upleft/nodelist/condition_item")

	gohelper.setActive(slot0.goConditionItem, false)

	slot0.viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.animationEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0.animationEventWrap:AddEventListener("startReset", slot0.startReset, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.UpdateRound, slot0.onUpdateRound, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameVictory, slot0.onGameOverCheckGuide, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameFail, slot0.onGameOver, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.QuitGame, slot0.onQuitGame, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnRevert, slot0.onRevert, slot0, LuaEventSystem.High)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)
	slot0:addEventCb(YaXianController.instance, YaXianEvent.OnPlayingClickAnimationValueChange, slot0.onPlayingClickAnimationValueChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0:initData()

	slot0._txtEpisodeIndex.text = slot0.episodeCo.index
	slot0._txtEpisodeName.text = slot0.episodeCo.name

	slot0:refreshRound()
	slot0:initConditions()
	slot0:refreshConditionsStatus()
end

function slot0.initData(slot0)
	slot0.episodeId = YaXianGameModel.instance:getEpisodeId()
	slot0.actId = YaXianGameModel.instance:getActId()
	slot0.episodeCo = YaXianConfig.instance:getEpisodeConfig(slot0.actId, slot0.episodeId)
	slot0.conditionList = nil
end

function slot0.initConditions(slot0)
	slot0.conditionList = YaXianConfig.instance:getConditionList(slot0.episodeCo)
	slot1 = string.split(slot0.episodeCo.conditionStr, "|")

	for slot5, slot6 in ipairs(slot0.conditionList) do
		if not slot0.conditionItemList[slot5] then
			table.insert(slot0.conditionItemList, slot0:createConditionItem())
		end

		gohelper.setActive(slot7.go, true)

		slot7.txtCondition.text = slot1[slot5]
	end
end

function slot0.createConditionItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.goConditionItem)
	slot1.toothLight = gohelper.findChild(slot1.go, "#go_toothlight")
	slot1.toothDark = gohelper.findChild(slot1.go, "#go_toothdark")
	slot1.txtCondition = gohelper.findChildText(slot1.go, "#txt_condition")

	return slot1
end

function slot0.refreshConditionsStatus(slot0)
	for slot4, slot5 in ipairs(slot0.conditionList) do
		slot6 = slot0.conditionItemList[slot4]
		slot7 = YaXianGameModel.instance:checkFinishCondition(slot5[1], slot5[2])

		gohelper.setActive(slot6.toothLight, slot7)
		gohelper.setActive(slot6.toothDark, not slot7)
	end
end

function slot0.refreshRound(slot0)
	slot0._txtroundnum.text = YaXianGameModel.instance:getRound()
	slot0._txtmaxroundnum.text = "/" .. slot0.episodeCo.maxRound
end

function slot0.onUpdateRound(slot0)
	slot0:refreshRound()
	slot0:refreshConditionsStatus()
end

function slot0.onGameOverCheckGuide(slot0)
	slot1 = YaXianGameModel.instance:getEpisodeId()
	slot2 = "OnChessResultViewPause"

	GuideController.instance:GuideFlowPauseAndContinue(slot2, GuideEvent[slot2], GuideEvent.OnChessResultViewContinue, uv0.onGameOver, slot0)
end

function slot0.onGameOver(slot0)
	slot0:refreshConditionsStatus()

	if YaXianGameModel.instance:getResult() and slot0.episodeCo.tooth ~= 0 and not StoryModel.instance:isStoryFinished(YaXianConfig.instance:getToothConfig(slot2).story) then
		slot0.flow = FlowSequence.New()

		slot0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.YaXianFindToothView, {
			toothId = slot2
		}))
		slot0.flow:addWork(PlayStoryWork.New(slot3.story))
		slot0.flow:registerDoneListener(slot0.openGameResultView, slot0)
		slot0.flow:start()

		return
	end

	slot0:openGameResultView()
end

function slot0.openGameResultView(slot0)
	slot2 = YaXianGameModel.instance:getResult()

	if YaXianGameModel.instance:getEpisodeCo() == nil then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)

		return
	end

	ViewMgr.instance:openView(ViewName.YaXianGameResultView, {
		result = slot2,
		episodeConfig = slot1
	})
end

function slot0.onQuitGame(slot0)
	slot0:closeThis()
end

function slot0.setUIVisible(slot0, slot1)
	gohelper.setActive(slot0.goRoot, slot1)
	gohelper.setActive(slot0.goBtns, slot1)
end

function slot0.onRevert(slot0)
	slot0:onUpdateRound()

	slot0.revertMap = true
end

function slot0.onGameLoadDone(slot0)
	if slot0.resetMap or slot0.revertMap then
		slot0.resetMap = nil
		slot0.revertMap = nil

		return
	end

	slot0:onPlayingClickAnimationValueChange()
end

function slot0.onPlayingClickAnimationValueChange(slot0)
	slot0.viewContainer:refreshViewGo()

	if not YaXianModel.instance:checkIsPlayingClickAnimation() and not slot0.playedOpenAnimation then
		slot0.viewAnimator:Play(UIAnimationName.Open, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.YaXian.EnterYaXianGame)

		slot0.playedOpenAnimation = true
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onExcessiveAnimationDone, slot0)

	if slot0.flow then
		slot0.flow:destroy()
	end

	ViewMgr.instance:closeView(ViewName.YaXianGameTipView)
end

function slot0.onDestroyView(slot0)
	slot0.animationEventWrap:RemoveAllEventListener()
	slot0._cloudmask:UnLoadImage()
	slot0._middlemask:UnLoadImage()
	slot0._mask:UnLoadImage()
end

return slot0
