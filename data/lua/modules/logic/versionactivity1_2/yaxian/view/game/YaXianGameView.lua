module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameView", package.seeall)

local var_0_0 = class("YaXianGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtEpisodeIndex = gohelper.findChildText(arg_1_0.viewGO, "root/upleft/bg/#txt_classnum")
	arg_1_0._txtEpisodeName = gohelper.findChildText(arg_1_0.viewGO, "root/upleft/bg/#txt_title")
	arg_1_0._txtroundnum = gohelper.findChildText(arg_1_0.viewGO, "root/upleft/round/cn/#txt_roundnum")
	arg_1_0._txtmaxroundnum = gohelper.findChildText(arg_1_0.viewGO, "root/upleft/round/cn/#txt_roundnum/#txt_fullnum")
	arg_1_0._btnfallback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/upright/#btn_fallback")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/upright/#btn_reset")
	arg_1_0._cloudmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "cloudmask")
	arg_1_0._middlemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "middlemask")
	arg_1_0._mask = gohelper.findChildSingleImage(arg_1_0.viewGO, "mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnfallback:AddClickListener(arg_2_0._btnfallbackOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnfallback:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesclose)
	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, arg_4_0.playResetAnimation, nil, nil, arg_4_0)
end

function var_0_0.playResetAnimation(arg_5_0)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Reset)
	UIBlockMgr.instance:startBlock(arg_5_0.viewName .. "excessive")
	arg_5_0.viewAnimator:Play("excessive", 0, 0)

	arg_5_0.resetMap = true

	TaskDispatcher.cancelTask(arg_5_0.onExcessiveAnimationDone, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.onExcessiveAnimationDone, arg_5_0, 1)
end

function var_0_0.onExcessiveAnimationDone(arg_6_0)
	UIBlockMgr.instance:endBlock(arg_6_0.viewName .. "excessive")
end

function var_0_0.startReset(arg_7_0)
	YaXianGameController.instance:stopRunningStep()
	ViewMgr.instance:closeView(ViewName.YaXianGameResultView)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnResetView)
	YaXianGameController.instance:enterChessGame(YaXianGameModel.instance:getEpisodeId())
end

function var_0_0._btnfallbackOnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	Activity115Rpc.instance:sendAct115RevertRequest(YaXianGameModel.instance:getActId())
end

function var_0_0._onOpenView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.YaXianGameTipView then
		arg_9_0:setUIVisible(false)
	end
end

function var_0_0._onCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.YaXianGameTipView then
		arg_10_0:setUIVisible(true)
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._cloudmask:LoadImage(ResUrl.getYaXianImage("img_gezi_cloud"))
	arg_11_0._middlemask:LoadImage(ResUrl.getYaXianImage("img_gezi_deco"))
	arg_11_0._mask:LoadImage(ResUrl.getYaXianImage("img_gezi_deco2"))

	arg_11_0.goRoot = gohelper.findChild(arg_11_0.viewGO, "root")
	arg_11_0.goBtns = gohelper.findChild(arg_11_0.viewGO, "#go_btns")
	arg_11_0.conditionItemList = {}
	arg_11_0.goConditionItem = gohelper.findChild(arg_11_0.viewGO, "root/upleft/nodelist/condition_item")

	gohelper.setActive(arg_11_0.goConditionItem, false)

	arg_11_0.viewAnimator = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_11_0.animationEventWrap = arg_11_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_11_0.animationEventWrap:AddEventListener("startReset", arg_11_0.startReset, arg_11_0)
	arg_11_0:addEventCb(YaXianGameController.instance, YaXianEvent.UpdateRound, arg_11_0.onUpdateRound, arg_11_0)
	arg_11_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameVictory, arg_11_0.onGameOverCheckGuide, arg_11_0)
	arg_11_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameFail, arg_11_0.onGameOver, arg_11_0)
	arg_11_0:addEventCb(YaXianGameController.instance, YaXianEvent.QuitGame, arg_11_0.onQuitGame, arg_11_0)
	arg_11_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnRevert, arg_11_0.onRevert, arg_11_0, LuaEventSystem.High)
	arg_11_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnGameLoadDone, arg_11_0.onGameLoadDone, arg_11_0)
	arg_11_0:addEventCb(YaXianController.instance, YaXianEvent.OnPlayingClickAnimationValueChange, arg_11_0.onPlayingClickAnimationValueChange, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_11_0._onOpenView, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_11_0._onCloseView, arg_11_0)
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:onOpen()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:initData()

	arg_13_0._txtEpisodeIndex.text = arg_13_0.episodeCo.index
	arg_13_0._txtEpisodeName.text = arg_13_0.episodeCo.name

	arg_13_0:refreshRound()
	arg_13_0:initConditions()
	arg_13_0:refreshConditionsStatus()
end

function var_0_0.initData(arg_14_0)
	arg_14_0.episodeId = YaXianGameModel.instance:getEpisodeId()
	arg_14_0.actId = YaXianGameModel.instance:getActId()
	arg_14_0.episodeCo = YaXianConfig.instance:getEpisodeConfig(arg_14_0.actId, arg_14_0.episodeId)
	arg_14_0.conditionList = nil
end

function var_0_0.initConditions(arg_15_0)
	arg_15_0.conditionList = YaXianConfig.instance:getConditionList(arg_15_0.episodeCo)

	local var_15_0 = string.split(arg_15_0.episodeCo.conditionStr, "|")

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.conditionList) do
		local var_15_1 = arg_15_0.conditionItemList[iter_15_0]

		if not var_15_1 then
			var_15_1 = arg_15_0:createConditionItem()

			table.insert(arg_15_0.conditionItemList, var_15_1)
		end

		gohelper.setActive(var_15_1.go, true)

		var_15_1.txtCondition.text = var_15_0[iter_15_0]
	end
end

function var_0_0.createConditionItem(arg_16_0)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0.go = gohelper.cloneInPlace(arg_16_0.goConditionItem)
	var_16_0.toothLight = gohelper.findChild(var_16_0.go, "#go_toothlight")
	var_16_0.toothDark = gohelper.findChild(var_16_0.go, "#go_toothdark")
	var_16_0.txtCondition = gohelper.findChildText(var_16_0.go, "#txt_condition")

	return var_16_0
end

function var_0_0.refreshConditionsStatus(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.conditionList) do
		local var_17_0 = arg_17_0.conditionItemList[iter_17_0]
		local var_17_1 = YaXianGameModel.instance:checkFinishCondition(iter_17_1[1], iter_17_1[2])

		gohelper.setActive(var_17_0.toothLight, var_17_1)
		gohelper.setActive(var_17_0.toothDark, not var_17_1)
	end
end

function var_0_0.refreshRound(arg_18_0)
	arg_18_0._txtroundnum.text = YaXianGameModel.instance:getRound()
	arg_18_0._txtmaxroundnum.text = "/" .. arg_18_0.episodeCo.maxRound
end

function var_0_0.onUpdateRound(arg_19_0)
	arg_19_0:refreshRound()
	arg_19_0:refreshConditionsStatus()
end

function var_0_0.onGameOverCheckGuide(arg_20_0)
	local var_20_0 = YaXianGameModel.instance:getEpisodeId()
	local var_20_1 = "OnChessResultViewPause"
	local var_20_2 = GuideEvent[var_20_1]
	local var_20_3 = GuideEvent.OnChessResultViewContinue
	local var_20_4 = var_0_0.onGameOver
	local var_20_5 = arg_20_0

	GuideController.instance:GuideFlowPauseAndContinue(var_20_1, var_20_2, var_20_3, var_20_4, var_20_5)
end

function var_0_0.onGameOver(arg_21_0)
	arg_21_0:refreshConditionsStatus()

	if YaXianGameModel.instance:getResult() then
		local var_21_0 = arg_21_0.episodeCo.tooth

		if var_21_0 ~= 0 then
			local var_21_1 = YaXianConfig.instance:getToothConfig(var_21_0)

			if not StoryModel.instance:isStoryFinished(var_21_1.story) then
				arg_21_0.flow = FlowSequence.New()

				arg_21_0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.YaXianFindToothView, {
					toothId = var_21_0
				}))
				arg_21_0.flow:addWork(PlayStoryWork.New(var_21_1.story))
				arg_21_0.flow:registerDoneListener(arg_21_0.openGameResultView, arg_21_0)
				arg_21_0.flow:start()

				return
			end
		end
	end

	arg_21_0:openGameResultView()
end

function var_0_0.openGameResultView(arg_22_0)
	local var_22_0 = YaXianGameModel.instance:getEpisodeCo()
	local var_22_1 = YaXianGameModel.instance:getResult()

	if var_22_0 == nil then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)

		return
	end

	ViewMgr.instance:openView(ViewName.YaXianGameResultView, {
		result = var_22_1,
		episodeConfig = var_22_0
	})
end

function var_0_0.onQuitGame(arg_23_0)
	arg_23_0:closeThis()
end

function var_0_0.setUIVisible(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0.goRoot, arg_24_1)
	gohelper.setActive(arg_24_0.goBtns, arg_24_1)
end

function var_0_0.onRevert(arg_25_0)
	arg_25_0:onUpdateRound()

	arg_25_0.revertMap = true
end

function var_0_0.onGameLoadDone(arg_26_0)
	if arg_26_0.resetMap or arg_26_0.revertMap then
		arg_26_0.resetMap = nil
		arg_26_0.revertMap = nil

		return
	end

	arg_26_0:onPlayingClickAnimationValueChange()
end

function var_0_0.onPlayingClickAnimationValueChange(arg_27_0)
	arg_27_0.viewContainer:refreshViewGo()

	if not YaXianModel.instance:checkIsPlayingClickAnimation() and not arg_27_0.playedOpenAnimation then
		arg_27_0.viewAnimator:Play(UIAnimationName.Open, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.YaXian.EnterYaXianGame)

		arg_27_0.playedOpenAnimation = true
	end
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.onExcessiveAnimationDone, arg_28_0)

	if arg_28_0.flow then
		arg_28_0.flow:destroy()
	end

	ViewMgr.instance:closeView(ViewName.YaXianGameTipView)
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0.animationEventWrap:RemoveAllEventListener()
	arg_29_0._cloudmask:UnLoadImage()
	arg_29_0._middlemask:UnLoadImage()
	arg_29_0._mask:UnLoadImage()
end

return var_0_0
