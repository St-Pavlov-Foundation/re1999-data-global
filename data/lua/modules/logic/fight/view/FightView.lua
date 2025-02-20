module("modules.logic.fight.view.FightView", package.seeall)

slot0 = class("FightView", BaseView)

function slot0.onInitView(slot0)
	slot0._rootGO = gohelper.findChild(slot0.viewGO, "root")
	slot0._topRightBtnRoot = gohelper.findChild(slot0.viewGO, "root/btns")
	slot0._btnBack = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btns/btnBack")
	slot0._btnAuto = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btns/btnAuto")
	slot0._btnAutoLockObj = gohelper.findChild(slot0.viewGO, "root/btns/btnAuto/lock")
	slot0._btnSpecialTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btns/btnSpecialTip")
	slot0._imageAuto = gohelper.findChildImage(slot0.viewGO, "root/btns/btnAuto/image")
	slot0._btnSpeed = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btns/btnSpeed")
	slot0._imageSpeed = gohelper.findChildImage(slot0.viewGO, "root/btns/btnSpeed/image")
	slot0._btnCareerRestrain = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnRestraintInfo")
	slot0._roundGO = gohelper.findChild(slot0.viewGO, "root/topLeftContent/imgRound")
	slot0._txtWave = gohelper.findChildText(slot0.viewGO, "root/topLeftContent/imgRound/txtWave")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "root/topLeftContent/imgRound/txtRound")
	slot0._txtSpeed = gohelper.findChildText(slot0.viewGO, "root/btns/btnSpeed/Text")
	slot0._goReplay = gohelper.findChild(slot0.viewGO, "root/#go_replay")
	slot0._goEnemyNum = gohelper.findChild(slot0.viewGO, "root/enemynum")
	slot0._txtEnemyNum = gohelper.findChildText(slot0.viewGO, "root/enemynum/#txt_enemynum")
	slot0._enemyinfoRoot = gohelper.findChild(slot0.viewGO, "root/topLeftContent/enemyinfo")
	slot0._enemyActionRoot = gohelper.findChild(slot0.viewGO, "root/topLeftContent/enemyaction")
	slot0.enemyActionNormal = gohelper.findChild(slot0.viewGO, "root/topLeftContent/enemyaction/normal")
	slot0.enemyActionSelect = gohelper.findChild(slot0.viewGO, "root/topLeftContent/enemyaction/selected")
	slot0.enemyActionLocked = gohelper.findChild(slot0.viewGO, "root/topLeftContent/enemyaction/locked")
	slot0.btnEnemyAction = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/topLeftContent/enemyaction/#btn_enemyaction")
end

function slot0.addEvents(slot0)
	slot0._btnBack:AddClickListener(slot0._onClickBack, slot0)

	if not FightReplayModel.instance:isReplay() then
		slot0._btnAuto:AddClickListener(slot0._onClickAuto, slot0)
	end

	slot0._btnSpeed:AddClickListener(slot0._onClickSpeed, slot0)
	slot0._btnSpecialTip:AddClickListener(slot0._onClickBtnSpecialTip, slot0)
	slot0._btnCareerRestrain:AddClickListener(slot0._onClickCareerRestrain, slot0)
	slot0.btnEnemyAction:AddClickListener(slot0.onClickEnemyAction, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._checkStartAutoCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._checkStartAutoCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCombineCardEnd, slot0._onBlockOperateEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnUniversalAppear, slot0._onBlockOperateEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0._setIsShowUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnGuideStopAutoFight, slot0._onGuideStopAutoFight, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AfterPlayAppearTimeline, slot0._onAfterPlayAppearTimeline, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0._onChangeEntity, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._onGMShowChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.FightDialogShow, slot0._onFightDialogShow, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.FightDialogEnd, slot0._checkContinueAuto, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, slot0._onSetStateForDialogBeforeStartFight, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0.onStageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshUIRound, slot0._onRefreshUIRound, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeRound, slot0._onChangeRound, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpentips, slot0._onClickBack, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, slot0.OnKeyAutoPress, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, slot0._onClickSpeed, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBack:RemoveClickListener()
	slot0._btnAuto:RemoveClickListener()
	slot0._btnSpecialTip:RemoveClickListener()
	slot0._btnSpeed:RemoveClickListener()
	slot0._btnCareerRestrain:RemoveClickListener()
	slot0.btnEnemyAction:RemoveClickListener()
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._checkStartAutoCards, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._checkStartAutoCards, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, slot0._onBlockOperateEnd, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnUniversalAppear, slot0._onBlockOperateEnd, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0._setIsShowUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnGuideStopAutoFight, slot0._onGuideStopAutoFight, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.AfterPlayAppearTimeline, slot0._onAfterPlayAppearTimeline, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0._onChangeEntity, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._onGMShowChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.FightDialogShow, slot0._onFightDialogShow, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.FightDialogEnd, slot0._checkContinueAuto, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, slot0._onSetStateForDialogBeforeStartFight, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ChangeRound, slot0._onChangeRound, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpentips, slot0._onClickBack, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, slot0.OnKeyAutoPress, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, slot0._onClickSpeed, slot0)
	TaskDispatcher.cancelTask(slot0._delayStartAutoCards, slot0)
	TaskDispatcher.cancelTask(slot0._updateAutoAnim, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
end

function slot0.onOpen(slot0)
	slot0:_checkStartReplay()

	slot2 = FightModel.instance:getFightParam().battleId
	slot3 = FightModel.instance:getFightParam().episodeId and DungeonModel.instance:getEpisodeInfo(slot1)
	slot4 = slot2 and lua_battle.configDict[slot2]
	slot5 = slot4 and (not slot4.noAutoFight or slot4.noAutoFight == 0)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		FightModel.instance:setAuto(false)
	elseif FightReplayModel.instance:isReplay() then
		FightModel.instance:setAuto(false)
	elseif not slot5 then
		FightModel.instance:setAuto(false)
	elseif FightDataHelper.fieldMgr:isDouQuQu() then
		FightModel.instance:setAuto(false)
	else
		FightModel.instance:setAuto(FightController.instance:getPlayerPrefKeyAuto(0))
	end

	slot0:_updateRound()
	TaskDispatcher.runDelay(slot0._updateAutoAnim, slot0, 1)
	slot0:_updateReplay()

	slot6 = GuideModel.instance:isDoingFirstGuide()
	slot7 = GuideController.instance:isForbidGuides()
	slot9 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightSpeed) and (not slot6 or slot7)
	slot10 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightProperty)
	slot11 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) and (not slot6 or slot7)
	slot8 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not slot6 or slot7) and slot5

	if FightReplayModel.instance:isReplay() then
		gohelper.setActive(slot0._btnAuto.gameObject, false)
	else
		gohelper.setActive(slot0._btnAuto.gameObject, DungeonModel.instance:hasPassLevelAndStory(10101))
		gohelper.setActive(slot0._btnAutoLockObj, FightDataHelper.fieldMgr:isDouQuQu())
	end

	gohelper.setActive(slot0._btnSpecialTip.gameObject, uv0.canShowSpecialBtn())

	if slot8 then
		UISpriteSetMgr.instance:setFightSprite(slot0._imageAuto, "bt_zd", true)
	else
		UISpriteSetMgr.instance:setFightSprite(slot0._imageAuto, "zd_dis", true)
	end

	if not slot9 and (slot1 == OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.FightSpeed).episodeId or GuideModel.instance:isGuideFinish(110)) then
		slot9 = true
	end

	if slot9 then
		if FightReplayModel.instance:isReplay() then
			FightModel.instance:setUserSpeed(2)
		else
			FightModel.instance:setUserSpeed(PlayerPrefsHelper.getNumber(slot0:_getPlayerPrefKeySpeed(), 1))
		end
	else
		FightModel.instance:setUserSpeed(1)
	end

	slot0:_updateSpeed()
	gohelper.setActive(slot0._btnSpeed.gameObject, slot9)
	gohelper.setActive(slot0._btnCareerRestrain.gameObject, false)
	gohelper.setActive(slot0._btnBack.gameObject, slot11)
	gohelper.setActive(slot0._roundGO, slot11 and GMFightShowState.topRightRound)
	NavigateMgr.instance:addEscape(ViewName.FightView, slot0._onEscapeBtnClick, slot0)
	slot0:_showEnemySubCount()
	slot0:initEnemyActionStatus()
	slot0:_refreshDouQuQu()
end

function slot0._refreshDouQuQu(slot0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		gohelper.setActive(slot0._enemyinfoRoot, false)

		if FightDataModel.instance.douQuQuMgr and FightDataModel.instance.douQuQuMgr.isRecord then
			return
		end

		gohelper.setActive(slot0._btnBack.gameObject, false)
		NavigateMgr.instance:removeEscape(ViewName.FightView)
	end
end

function slot0.initEnemyActionStatus(slot0)
	if FightModel.instance:getBattleId() and lua_battle.configDict[slot1] and slot2.aiLink ~= 0 then
		slot0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	else
		slot0:setEnemyActionStatus(FightEnum.EnemyActionStatus.NotOpen)
	end
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
	FightModel.instance:setUserSpeed(1)
	TaskDispatcher.cancelTask(slot0._showBtnSpeedAni, slot0, 0.001)
end

function slot0._onAfterPlayAppearTimeline(slot0)
	slot0:_updateAutoAnim()
end

function slot0._checkStartReplay(slot0)
	if FightReplayModel.instance:isReplay() then
		FightModel.instance:setAuto(false)
		slot0._btnAuto:RemoveClickListener()
		gohelper.setActive(slot0._btnAuto.gameObject, false)
	end
end

function slot0._setIsShowUI(slot0, slot1)
	if not slot0._canvasGroup then
		slot0._canvasGroup = gohelper.onceAddComponent(slot0._rootGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(slot0._canvasGroup, slot1)
end

function slot0._onGuideStopAutoFight(slot0)
	FightModel.instance:setAuto(false)
	slot0:_updateAutoAnim()
end

function slot0._onFightDialogShow(slot0)
	FightModel.instance:setAuto(false)
	slot0:_updateAutoAnim()
end

function slot0.OnKeyAutoPress(slot0)
	if not FightReplayModel.instance:isReplay() then
		slot0:_onClickAuto()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.GuideView or slot1 == slot1.StoryView then
		FightModel.instance:setAuto(false)
		slot0:_updateAutoAnim()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.GuideView or slot1 == slot1.StoryView then
		slot0:_checkContinueAuto()
	end

	if slot1 == ViewName.FightFocusView then
		TaskDispatcher.runDelay(slot0._resetCamera, slot0, 0.16)
	end

	if slot1 == ViewName.FightEnemyActionView and slot0.actionStatus == FightEnum.EnemyActionStatus.Select then
		slot0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

slot1 = {}

function slot0._checkContinueAuto(slot0)
	if not FightModel.instance:isAuto() then
		slot5 = FightModel.instance:getFightParam().battleId and lua_battle.configDict[slot4]

		if FightController.instance:getPlayerPrefKeyAuto(0) and not FightReplayModel.instance:isReplay() and not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) and (slot5 and (not slot5.noAutoFight or slot5.noAutoFight == 0)) and (OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not GuideModel.instance:isDoingFirstGuide() or GuideController.instance:isForbidGuides())) then
			if not FightModel.instance:isFinish() and FightModel.instance:getCurStage() == FightEnum.Stage.Card then
				FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
				ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)
			end

			FightModel.instance:setAuto(true)
			slot0:_updateAutoAnim()
			slot0:_checkStartAutoCards()
		end
	end
end

function slot0._onBlockOperateEnd(slot0)
	if slot0._blockOperate then
		slot0._blockOperate = nil

		slot0:_checkAutoCard()
	end
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	if not FightModel.instance:isFinish() and not FightReplayModel.instance:isReplay() and FightCardModel.instance:isCardOpEnd() and (FightModel.instance:getCurStage() == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard) then
		FightRpc.instance:sendBeginRoundRequest(FightCardModel.instance:getCardOps())
	end
end

function slot0._checkStartAutoCards(slot0)
	slot0:_updateRound()
	TaskDispatcher.runDelay(slot0._delayStartAutoCards, slot0, 0.1)
	UIBlockMgr.instance:startBlock(UIBlockKey.FightAuto)
end

function slot0._delayStartAutoCards(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)

	if not FightModel.instance:isFinish() and not FightReplayModel.instance:isReplay() then
		if FightCardModel.instance:isCardOpEnd() then
			if FightModel.instance:getCurStage() == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
				FightRpc.instance:sendBeginRoundRequest(FightCardModel.instance:getCardOps())
			end
		elseif FightModel.instance:isAuto() and FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
			slot0:_autoPlayCard()
		end
	end
end

function slot0._updateSpeed(slot0)
	slot2 = FightModel.instance:getUserSpeed() == 1 and 1 or 2

	UISpriteSetMgr.instance:setFightSprite(slot0._imageSpeed, "btn_x" .. slot2, true)

	slot0._txtSpeed.text = string.format("%s%d", luaLang("multiple"), slot2)

	TaskDispatcher.runDelay(slot0._showBtnSpeedAni, slot0, 0.001)
end

function slot0._showBtnSpeedAni(slot0)
	slot0._btnSpeed:GetComponent(typeof(UnityEngine.Animator)):Play(FightModel.instance:getUserSpeed() == 1 and "idle" or "click")
end

function slot0._updateAutoAnim(slot0)
	if not slot0._autoRotateAnimation then
		slot0._autoRotateAnimation = slot0._imageAuto:GetComponent(typeof(UnityEngine.Animation))
	end

	if FightModel.instance:isAuto() then
		slot0._autoRotateAnimation.enabled = true

		slot0._autoRotateAnimation:Play()
	else
		slot0._autoRotateAnimation:Stop()

		slot0._autoRotateAnimation.enabled = false

		transformhelper.setLocalRotation(slot0._imageAuto.transform, 0, 0, 0)
	end
end

function slot0._onRefreshUIRound(slot0)
	slot0:_updateRound()
end

function slot0._updateRound(slot0)
	slot4 = math.min(FightModel.instance:getCurWaveId(), FightModel.instance.maxWave)
	slot3 = math.min(FightModel.instance:getCurRoundId(), FightModel.instance.maxRound)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		slot4 = FightDataModel.instance.douQuQuMgr.index or 1
		slot1 = slot5.maxIndex or 1
	end

	slot0._txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), slot4, slot1)
	slot0._txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), slot3, slot2)

	slot0:_showEnemySubHeroCount()
end

function slot0._onChangeRound(slot0)
	slot0._txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), FightModel.instance:getCurRoundId(), FightModel.instance.maxRound)
end

function slot0._showEnemySubHeroCount(slot0)
	slot1 = FightDataHelper.entityMgr:getEnemySubList()
	slot0._txtEnemyNum.text = #slot1

	if #slot1 > 0 then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowEnemyNum)
	end
end

function slot0._showEnemySubCount(slot0)
	gohelper.setActive(slot0._goEnemyNum, #FightDataHelper.entityMgr:getEnemySubList() > 0 and GMFightShowState.leftMonster)
end

function slot0._onBeginWave(slot0)
	slot0:_showEnemySubCount()
end

function slot0._onChangeEntity(slot0)
	slot0:_showEnemySubHeroCount()
end

function slot0._updateReplay(slot0)
	gohelper.setActive(slot0._goReplay, FightReplayModel.instance:isReplay())
end

function slot0._onEscapeBtnClick(slot0)
	if slot0._btnBack.gameObject.activeInHierarchy then
		slot0:_onClickBack()
	end
end

function slot0._onClickBack(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		slot1, slot2 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightBack)

		GameFacade.showToast(slot1, slot2)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	if (FightModel.instance:getCurStage() == FightEnum.Stage.StartRound or slot1 == FightEnum.Stage.Distribute) and GuideModel.instance:getDoingGuideIdList() and #slot2 > 0 then
		return
	end

	GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
	ViewMgr.instance:openView(ViewName.FightQuitTipView)
end

function slot0._onClickAuto(slot0)
	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAuto) then
		slot1, slot2 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightAuto)

		GameFacade.showToast(slot1, slot2)

		return
	end

	slot2 = FightModel.instance:getFightParam().battleId and lua_battle.configDict[slot1]

	if not (slot2 and (not slot2.noAutoFight or slot2.noAutoFight == 0)) then
		GameFacade.showToast(ToastEnum.EpisodeCantUse)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	slot4 = FightModel.instance:isAuto()

	FightModel.instance:setAuto(not slot4)
	FightController.instance:setPlayerPrefKeyAuto(0, not slot4)
	slot0:_updateAutoAnim()

	if FightViewHandCard.blockOperate then
		slot0._blockOperate = true

		return
	end

	slot0:_checkAutoCard()
end

function slot0._checkAutoCard(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card and FightModel.instance:isAuto() then
		FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
		ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)

		if not FightCardModel.instance:isCardOpEnd() then
			TaskDispatcher.cancelTask(slot0._delayStartAutoCards, slot0)
			UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
			slot0:_autoPlayCard()
		end
	end
end

function slot0._onClickSpeed(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidSpeed) then
		return
	end

	slot2 = FightModel.instance:getUserSpeed() == 1 and 2 or 1

	FightModel.instance:setUserSpeed(slot2)
	PlayerPrefsHelper.setNumber(slot0:_getPlayerPrefKeySpeed(), slot2)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	slot0:_updateSpeed()
end

function slot0._onClickBtnSpecialTip(slot0)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickOpenView) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	if not FightModel.instance:isStartFinish() and (GuideModel.instance:getDoingGuideIdList() and #slot2 or 0) > 0 then
		return
	end

	FightController.instance:openFightSpecialTipView()
end

function slot0._getPlayerPrefKeySpeed(slot0)
	return PlayerPrefsKey.FightSpeed .. PlayerModel.instance:getPlayinfo().userId
end

function slot0._autoPlayCard(slot0)
	if not FightReplayModel.instance:isReplay() then
		if #FightPlayerOperateMgr.detectUpgrade() > 0 and #FightCardModel.instance:getCardOps() > 0 and not FightCardModel.instance:isCardOpEnd() then
			FightRpc.instance:sendResetRoundRequest()
			FightCardModel.instance:clearCardOps()
		end

		FightRpc.instance:sendAutoRoundRequest(FightCardModel.instance:getCardOps())
	end
end

function slot0._onClickCareerRestrain(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightProperty) then
		slot1, slot2 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightProperty)

		GameFacade.showToast(slot1, slot2)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function slot0._onFightReconnectLastWork(slot0)
	gohelper.setActive(slot0._btnSpecialTip.gameObject, uv0.canShowSpecialBtn())
end

function slot0._onGMShowChange(slot0)
	slot0:_showEnemySubCount()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._resetCamera, slot0)
end

function slot0.canShowSpecialBtn()
	if not FightWorkBeforeStartNoticeView.canShowTips() then
		if Activity104Model.instance:isSeasonEpisodeType(DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId) and slot2.type) then
			slot0 = Activity104Model.instance:getFightCardDataList() and #slot4 > 0
		elseif Season123Controller.canUse123EquipEpisodeType(slot3) then
			slot0 = Season123Model.instance:getFightCardDataList() and #slot4 > 0
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView) then
		slot0 = false
	end

	return slot0
end

function slot0._resetCamera(slot0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		slot6:setVisibleByPos(true)

		if slot6.buff then
			slot6.buff:hideBuffEffects()
			slot6.buff:showBuffEffects()
		end

		if slot6.nameUI then
			slot6.nameUI:setActive(true)
		end
	end

	slot2 = GameSceneMgr.instance:getScene(SceneType.Fight)

	slot2.level:setFrontVisible(true)
	slot2.camera:setSceneCameraOffset()
end

function slot0._onSetStateForDialogBeforeStartFight(slot0, slot1)
	gohelper.setActive(slot0._topRightBtnRoot, not slot1)
	gohelper.setActive(slot0._roundGO, not slot1)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		gohelper.setActive(slot0._enemyinfoRoot, false)
	else
		gohelper.setActive(slot0._enemyinfoRoot, not slot1)
	end

	slot0:refreshEnemyAction(not slot1)
end

function slot0.refreshEnemyAction(slot0, slot1)
	if slot0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		gohelper.setActive(slot0._enemyActionRoot, false)

		return
	end

	gohelper.setActive(slot0._enemyActionRoot, slot1)
	gohelper.setActive(slot0.enemyActionNormal, slot0.actionStatus == FightEnum.EnemyActionStatus.Normal)
	gohelper.setActive(slot0.enemyActionSelect, slot0.actionStatus == FightEnum.EnemyActionStatus.Select)
	gohelper.setActive(slot0.enemyActionLocked, slot0.actionStatus == FightEnum.EnemyActionStatus.Lock)
end

function slot0.onStageChange(slot0)
	if slot0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		slot0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Lock)
	else
		slot0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function slot0.setEnemyActionStatus(slot0, slot1)
	slot0.actionStatus = slot1

	FightController.instance:dispatchEvent(FightEvent.OnEnemyActionStatusChange, slot0.actionStatus)
	slot0:refreshEnemyAction(true)
end

function slot0.onClickEnemyAction(slot0)
	if slot0.actionStatus ~= FightEnum.EnemyActionStatus.Normal then
		return
	end

	if slot0:checkMonsterCardIsEmpty() then
		return
	end

	slot0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Select)
	ViewMgr.instance:openView(ViewName.FightEnemyActionView)
end

function slot0.checkMonsterCardIsEmpty(slot0)
	if FightModel.instance:getCurRoundMO() and slot1:getAIUseCardMOList() then
		for slot6, slot7 in ipairs(slot2) do
			if FightDataHelper.entityMgr:getById(slot7.uid) then
				return false
			end
		end
	end

	return true
end

return slot0
