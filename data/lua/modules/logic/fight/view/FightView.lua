module("modules.logic.fight.view.FightView", package.seeall)

local var_0_0 = class("FightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._rootGO = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._topRightBtnRoot = gohelper.findChild(arg_1_0.viewGO, "root/btns")
	arg_1_0._btnBack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnBack")
	arg_1_0._btnAuto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnAuto")
	arg_1_0._btnAutoLockObj = gohelper.findChild(arg_1_0.viewGO, "root/btns/btnAuto/lock")
	arg_1_0._btnSpecialTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnSpecialTip")
	arg_1_0._imageAuto = gohelper.findChildImage(arg_1_0.viewGO, "root/btns/btnAuto/image")
	arg_1_0._btnSpeed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btns/btnSpeed")
	arg_1_0._imageSpeed = gohelper.findChildImage(arg_1_0.viewGO, "root/btns/btnSpeed/image")
	arg_1_0._btnCareerRestrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnRestraintInfo")
	arg_1_0._roundGO = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/imgRound")
	arg_1_0._txtWave = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/imgRound/txtWave")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/imgRound/txtRound")
	arg_1_0._txtSpeed = gohelper.findChildText(arg_1_0.viewGO, "root/btns/btnSpeed/Text")
	arg_1_0._goReplay = gohelper.findChild(arg_1_0.viewGO, "root/#go_replay")
	arg_1_0._goEnemyNum = gohelper.findChild(arg_1_0.viewGO, "root/enemynum")
	arg_1_0._txtEnemyNum = gohelper.findChildText(arg_1_0.viewGO, "root/enemynum/#txt_enemynum")
	arg_1_0._enemyinfoRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyinfo")
	arg_1_0._enemyActionRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction")
	arg_1_0.enemyActionNormal = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction/normal")
	arg_1_0.enemyActionSelect = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction/selected")
	arg_1_0.enemyActionLocked = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/enemyaction/locked")
	arg_1_0.btnEnemyAction = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/topLeftContent/enemyaction/#btn_enemyaction")
	arg_1_0.weeklyWalkSubEnemy = gohelper.findChild(arg_1_0.viewGO, "root/enemyweekwalkheart")
	arg_1_0.btnCheckSub = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/enemyweekwalkheart/btn_checkSub")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBack:AddClickListener(arg_2_0._onClickBack, arg_2_0)

	if not FightReplayModel.instance:isReplay() then
		arg_2_0._btnAuto:AddClickListener(arg_2_0._onClickAuto, arg_2_0)
	end

	arg_2_0._btnSpeed:AddClickListener(arg_2_0._onClickSpeed, arg_2_0)
	arg_2_0._btnSpecialTip:AddClickListener(arg_2_0._onClickBtnSpecialTip, arg_2_0)
	arg_2_0._btnCareerRestrain:AddClickListener(arg_2_0._onClickCareerRestrain, arg_2_0)
	arg_2_0.btnEnemyAction:AddClickListener(arg_2_0.onClickEnemyAction, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCheckSub, arg_2_0.onBtnCheckSub, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._checkStartAutoCards, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._checkStartAutoCards, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_2_0._onBlockOperateEnd, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnUniversalAppear, arg_2_0._onBlockOperateEnd, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_2_0._setIsShowUI, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnGuideStopAutoFight, arg_2_0._onGuideStopAutoFight, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AfterPlayAppearTimeline, arg_2_0._onAfterPlayAppearTimeline, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StartReplay, arg_2_0._checkStartReplay, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_2_0._onChangeEntity, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBeginWave, arg_2_0._onBeginWave, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, arg_2_0._onFightReconnectLastWork, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_2_0._onGMShowChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.FightDialogShow, arg_2_0._onFightDialogShow, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.FightDialogEnd, arg_2_0._checkContinueAuto, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, arg_2_0._onSetStateForDialogBeforeStartFight, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStageChange, arg_2_0.onStageChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RefreshUIRound, arg_2_0._onRefreshUIRound, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AddSubEntity, arg_2_0._onAddSubEntity, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ClearMonsterSub, arg_2_0._onClearMonsterSub, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RefreshMonsterSubCount, arg_2_0._onRefreshMonsterSubCount, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ChangeRound, arg_2_0._onChangeRound, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpentips, arg_2_0._onClickBack, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, arg_2_0.OnKeyAutoPress, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, arg_2_0._onClickSpeed, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBack:RemoveClickListener()
	arg_3_0._btnAuto:RemoveClickListener()
	arg_3_0._btnSpecialTip:RemoveClickListener()
	arg_3_0._btnSpeed:RemoveClickListener()
	arg_3_0._btnCareerRestrain:RemoveClickListener()
	arg_3_0.btnEnemyAction:RemoveClickListener()
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_3_0._checkStartAutoCards, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._checkStartAutoCards, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_3_0._onBlockOperateEnd, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnUniversalAppear, arg_3_0._onBlockOperateEnd, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_3_0._setIsShowUI, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnGuideStopAutoFight, arg_3_0._onGuideStopAutoFight, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.AfterPlayAppearTimeline, arg_3_0._onAfterPlayAppearTimeline, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StartReplay, arg_3_0._checkStartReplay, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, arg_3_0._onChangeEntity, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, arg_3_0._onBeginWave, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, arg_3_0._onFightReconnectLastWork, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._onGMShowChange, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.FightDialogShow, arg_3_0._onFightDialogShow, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.FightDialogEnd, arg_3_0._checkContinueAuto, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, arg_3_0._onSetStateForDialogBeforeStartFight, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.ChangeRound, arg_3_0._onChangeRound, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpentips, arg_3_0._onClickBack, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, arg_3_0.OnKeyAutoPress, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, arg_3_0._onClickSpeed, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayStartAutoCards, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._updateAutoAnim, arg_3_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_checkStartReplay()

	local var_4_0 = FightModel.instance:getFightParam().episodeId
	local var_4_1 = FightModel.instance:getFightParam().battleId
	local var_4_2

	var_4_2 = var_4_0 and DungeonModel.instance:getEpisodeInfo(var_4_0)

	local var_4_3 = var_4_1 and lua_battle.configDict[var_4_1]
	local var_4_4 = var_4_3 and (not var_4_3.noAutoFight or var_4_3.noAutoFight == 0)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		FightModel.instance:setAuto(false)
	elseif FightReplayModel.instance:isReplay() then
		FightModel.instance:setAuto(false)
	elseif not var_4_4 then
		FightModel.instance:setAuto(false)
	elseif FightDataHelper.fieldMgr:isDouQuQu() then
		FightModel.instance:setAuto(false)
	else
		local var_4_5 = FightController.instance:getPlayerPrefKeyAuto(0)

		FightModel.instance:setAuto(var_4_5)
	end

	arg_4_0:_updateRound()
	TaskDispatcher.runDelay(arg_4_0._updateAutoAnim, arg_4_0, 1)
	arg_4_0:_updateReplay()

	local var_4_6 = GuideModel.instance:isDoingFirstGuide()
	local var_4_7 = GuideController.instance:isForbidGuides()
	local var_4_8 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not var_4_6 or var_4_7)
	local var_4_9 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightSpeed) and (not var_4_6 or var_4_7)
	local var_4_10 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightProperty)
	local var_4_11 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) and (not var_4_6 or var_4_7)

	var_4_8 = var_4_8 and var_4_4

	if FightReplayModel.instance:isReplay() then
		gohelper.setActive(arg_4_0._btnAuto.gameObject, false)
	else
		gohelper.setActive(arg_4_0._btnAuto.gameObject, DungeonModel.instance:hasPassLevelAndStory(10101))
		gohelper.setActive(arg_4_0._btnAutoLockObj, FightDataHelper.fieldMgr:isDouQuQu())
	end

	gohelper.setActive(arg_4_0._btnSpecialTip.gameObject, var_0_0.canShowSpecialBtn())

	if var_4_8 then
		UISpriteSetMgr.instance:setFightSprite(arg_4_0._imageAuto, "bt_zd", true)
	else
		UISpriteSetMgr.instance:setFightSprite(arg_4_0._imageAuto, "zd_dis", true)
	end

	if not var_4_9 and (var_4_0 == OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.FightSpeed).episodeId or GuideModel.instance:isGuideFinish(110)) then
		var_4_9 = true
	end

	if var_4_9 then
		if FightReplayModel.instance:isReplay() then
			FightModel.instance:setUserSpeed(2)
		else
			local var_4_12 = PlayerPrefsHelper.getNumber(arg_4_0:_getPlayerPrefKeySpeed(), 1)

			FightModel.instance:setUserSpeed(var_4_12)
		end
	else
		FightModel.instance:setUserSpeed(1)
	end

	arg_4_0:_updateSpeed()
	gohelper.setActive(arg_4_0._btnSpeed.gameObject, var_4_9)
	gohelper.setActive(arg_4_0._btnCareerRestrain.gameObject, false)
	gohelper.setActive(arg_4_0._btnBack.gameObject, var_4_11)
	gohelper.setActive(arg_4_0._roundGO, var_4_11 and GMFightShowState.topRightRound)
	NavigateMgr.instance:addEscape(ViewName.FightView, arg_4_0._onEscapeBtnClick, arg_4_0)
	arg_4_0:_showEnemySubCount()
	arg_4_0:initEnemyActionStatus()
	arg_4_0:_refreshDouQuQu()
end

function var_0_0._refreshDouQuQu(arg_5_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		gohelper.setActive(arg_5_0._enemyinfoRoot, false)

		if FightDataModel.instance.douQuQuMgr and FightDataModel.instance.douQuQuMgr.isRecord then
			return
		end

		gohelper.setActive(arg_5_0._btnBack.gameObject, false)
		NavigateMgr.instance:removeEscape(ViewName.FightView)
	end
end

function var_0_0.initEnemyActionStatus(arg_6_0)
	local var_6_0 = FightModel.instance:getBattleId()
	local var_6_1 = var_6_0 and lua_battle.configDict[var_6_0]

	if var_6_1 and var_6_1.aiLink ~= 0 then
		arg_6_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	else
		arg_6_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.NotOpen)
	end
end

function var_0_0.onClose(arg_7_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
	FightModel.instance:setUserSpeed(1)
	TaskDispatcher.cancelTask(arg_7_0._showBtnSpeedAni, arg_7_0, 0.001)
end

function var_0_0._onAfterPlayAppearTimeline(arg_8_0)
	arg_8_0:_updateAutoAnim()
end

function var_0_0._checkStartReplay(arg_9_0)
	if FightReplayModel.instance:isReplay() then
		FightModel.instance:setAuto(false)
		arg_9_0._btnAuto:RemoveClickListener()
		gohelper.setActive(arg_9_0._btnAuto.gameObject, false)
	end
end

function var_0_0._setIsShowUI(arg_10_0, arg_10_1)
	if not arg_10_0._canvasGroup then
		arg_10_0._canvasGroup = gohelper.onceAddComponent(arg_10_0._rootGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_10_0._canvasGroup, arg_10_1)
end

function var_0_0._onGuideStopAutoFight(arg_11_0)
	FightModel.instance:setAuto(false)
	arg_11_0:_updateAutoAnim()
end

function var_0_0._onFightDialogShow(arg_12_0)
	FightModel.instance:setAuto(false)
	arg_12_0:_updateAutoAnim()
end

function var_0_0.OnKeyAutoPress(arg_13_0)
	if not FightReplayModel.instance:isReplay() then
		arg_13_0:_onClickAuto()
	end
end

function var_0_0._onOpenView(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.GuideView or arg_14_1 == arg_14_1.StoryView then
		FightModel.instance:setAuto(false)
		arg_14_0:_updateAutoAnim()
	end
end

function var_0_0._onCloseView(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.GuideView or arg_15_1 == arg_15_1.StoryView then
		arg_15_0:_checkContinueAuto()
	end

	if arg_15_1 == ViewName.FightFocusView then
		TaskDispatcher.runDelay(arg_15_0._resetCamera, arg_15_0, 0.16)
	end

	if arg_15_1 == ViewName.FightEnemyActionView and arg_15_0.actionStatus == FightEnum.EnemyActionStatus.Select then
		arg_15_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

local var_0_1 = {}

function var_0_0._checkContinueAuto(arg_16_0)
	if not FightModel.instance:isAuto() then
		local var_16_0 = GuideModel.instance:isDoingFirstGuide()
		local var_16_1 = GuideController.instance:isForbidGuides()
		local var_16_2 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not var_16_0 or var_16_1)
		local var_16_3 = FightModel.instance:getFightParam().battleId
		local var_16_4 = var_16_3 and lua_battle.configDict[var_16_3]
		local var_16_5 = var_16_4 and (not var_16_4.noAutoFight or var_16_4.noAutoFight == 0)
		local var_16_6 = not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight)
		local var_16_7 = not FightReplayModel.instance:isReplay()

		if FightController.instance:getPlayerPrefKeyAuto(0) and var_16_7 and var_16_6 and var_16_5 and var_16_2 then
			if not FightModel.instance:isFinish() and FightModel.instance:getCurStage() == FightEnum.Stage.Card then
				FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
				ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)
			end

			FightModel.instance:setAuto(true)
			arg_16_0:_updateAutoAnim()
			arg_16_0:_checkStartAutoCards()
		end
	end
end

function var_0_0._onBlockOperateEnd(arg_17_0)
	if arg_17_0._blockOperate then
		arg_17_0._blockOperate = nil

		arg_17_0:_checkAutoCard()
	end
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_18_0)
	if not FightModel.instance:isFinish() and not FightReplayModel.instance:isReplay() and FightCardModel.instance:isCardOpEnd() then
		local var_18_0 = FightModel.instance:getCurStage()

		if var_18_0 == FightEnum.Stage.Card or var_18_0 == FightEnum.Stage.AutoCard then
			FightRpc.instance:sendBeginRoundRequest(FightCardModel.instance:getCardOps())
		end
	end
end

function var_0_0._checkStartAutoCards(arg_19_0)
	arg_19_0:_updateRound()
	TaskDispatcher.runDelay(arg_19_0._delayStartAutoCards, arg_19_0, 0.1)
	UIBlockMgr.instance:startBlock(UIBlockKey.FightAuto)
end

function var_0_0._delayStartAutoCards(arg_20_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)

	if FightModel.instance:isFinish() then
		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		if FightDataHelper.stageMgr:isNormalStage() then
			FightRpc.instance:sendEndFightRequest(false)
		end

		return
	end

	if not FightModel.instance:isFinish() and not FightReplayModel.instance:isReplay() then
		if FightCardModel.instance:isCardOpEnd() then
			local var_20_0 = FightModel.instance:getCurStage()

			if var_20_0 == FightEnum.Stage.Card or var_20_0 == FightEnum.Stage.AutoCard then
				FightRpc.instance:sendBeginRoundRequest(FightCardModel.instance:getCardOps())
			end
		elseif FightModel.instance:isAuto() and FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
			arg_20_0:_autoPlayCard()
		end
	end
end

function var_0_0._updateSpeed(arg_21_0)
	local var_21_0 = FightModel.instance:getUserSpeed() == 1 and 1 or 2

	UISpriteSetMgr.instance:setFightSprite(arg_21_0._imageSpeed, "btn_x" .. var_21_0, true)

	arg_21_0._txtSpeed.text = string.format("%s%d", luaLang("multiple"), var_21_0)

	TaskDispatcher.runDelay(arg_21_0._showBtnSpeedAni, arg_21_0, 0.001)
end

function var_0_0._showBtnSpeedAni(arg_22_0)
	local var_22_0 = FightModel.instance:getUserSpeed() == 1 and "idle" or "click"

	arg_22_0._btnSpeed:GetComponent(typeof(UnityEngine.Animator)):Play(var_22_0)
end

function var_0_0._updateAutoAnim(arg_23_0)
	if not arg_23_0._autoRotateAnimation then
		arg_23_0._autoRotateAnimation = arg_23_0._imageAuto:GetComponent(typeof(UnityEngine.Animation))
	end

	if FightModel.instance:isAuto() then
		arg_23_0._autoRotateAnimation.enabled = true

		arg_23_0._autoRotateAnimation:Play()
	else
		arg_23_0._autoRotateAnimation:Stop()

		arg_23_0._autoRotateAnimation.enabled = false

		transformhelper.setLocalRotation(arg_23_0._imageAuto.transform, 0, 0, 0)
	end
end

function var_0_0._onRefreshUIRound(arg_24_0)
	arg_24_0:_updateRound()
end

function var_0_0._updateRound(arg_25_0)
	arg_25_0:_refreshWaveUI()
	arg_25_0:_refreshRoundUI()
	arg_25_0:_showEnemySubHeroCount()
end

function var_0_0._refreshWaveUI(arg_26_0)
	local var_26_0 = FightModel.instance.maxWave
	local var_26_1 = FightModel.instance:getCurWaveId()
	local var_26_2 = math.min(var_26_1, var_26_0)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		local var_26_3 = FightDataModel.instance.douQuQuMgr

		var_26_2 = var_26_3.index or 1
		var_26_0 = var_26_3.maxIndex or 1
	end

	arg_26_0._txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), var_26_2, var_26_0)
end

function var_0_0._refreshRoundUI(arg_27_0)
	local var_27_0 = FightModel.instance:getMaxRound()
	local var_27_1 = FightModel.instance:getCurRoundId()
	local var_27_2 = math.min(var_27_1, var_27_0)

	arg_27_0._txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), var_27_2, var_27_0)
end

function var_0_0._onChangeRound(arg_28_0)
	arg_28_0:_refreshRoundUI()
end

function var_0_0._showEnemySubHeroCount(arg_29_0)
	local var_29_0 = FightDataHelper.entityMgr:getEnemySubList()

	arg_29_0._txtEnemyNum.text = #var_29_0

	if #var_29_0 > 0 then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowEnemyNum)
	end

	local var_29_1 = FightDataHelper.fieldMgr.customData

	if var_29_1 and var_29_1[FightCustomData.CustomDataType.WeekwalkVer2] then
		arg_29_0._txtEnemyNum.text = "∞"
	end
end

function var_0_0.onBtnCheckSub(arg_30_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	local var_30_0 = FightDataHelper.fieldMgr.customData

	if var_30_0 and var_30_0[FightCustomData.CustomDataType.WeekwalkVer2] then
		ViewMgr.instance:openView(ViewName.FightWeekWalkEnemyTipsView)
	end
end

function var_0_0._showEnemySubCount(arg_31_0)
	local var_31_0 = FightDataHelper.entityMgr:getEnemySubList()
	local var_31_1 = GMFightShowState.leftMonster

	gohelper.setActive(arg_31_0._goEnemyNum, #var_31_0 > 0 and var_31_1)
	gohelper.setActive(arg_31_0.weeklyWalkSubEnemy, false)

	local var_31_2 = FightDataHelper.fieldMgr.customData

	if var_31_2 and var_31_2[FightCustomData.CustomDataType.WeekwalkVer2] then
		gohelper.setActive(arg_31_0._goEnemyNum, false)
		gohelper.setActive(arg_31_0.weeklyWalkSubEnemy, true)
	end
end

function var_0_0._onAddSubEntity(arg_32_0)
	arg_32_0:_showEnemySubCount()
	arg_32_0:_showEnemySubHeroCount()
end

function var_0_0._onClearMonsterSub(arg_33_0)
	arg_33_0:_showEnemySubHeroCount()
end

function var_0_0._onRefreshMonsterSubCount(arg_34_0)
	arg_34_0:_showEnemySubHeroCount()
end

function var_0_0._onBeginWave(arg_35_0)
	arg_35_0:_showEnemySubCount()
end

function var_0_0._onChangeEntity(arg_36_0)
	arg_36_0:_showEnemySubHeroCount()
end

function var_0_0._updateReplay(arg_37_0)
	gohelper.setActive(arg_37_0._goReplay, FightReplayModel.instance:isReplay())
end

function var_0_0._onEscapeBtnClick(arg_38_0)
	if arg_38_0._btnBack.gameObject.activeInHierarchy then
		arg_38_0:_onClickBack()
	end
end

function var_0_0._onClickBack(arg_39_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		local var_39_0, var_39_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightBack)

		GameFacade.showToast(var_39_0, var_39_1)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_39_2 = FightModel.instance:getCurStage()
	local var_39_3 = FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Distribute1Card)

	if var_39_2 == FightEnum.Stage.StartRound or var_39_2 == FightEnum.Stage.Distribute or var_39_3 then
		local var_39_4 = GuideModel.instance:getDoingGuideIdList()

		if var_39_4 and #var_39_4 > 0 then
			return
		end
	end

	GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
	ViewMgr.instance:openView(ViewName.FightQuitTipView)
end

function var_0_0._onClickAuto(arg_40_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero) then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAuto) then
		local var_40_0, var_40_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightAuto)

		GameFacade.showToast(var_40_0, var_40_1)

		return
	end

	local var_40_2 = FightModel.instance:getFightParam().battleId
	local var_40_3 = var_40_2 and lua_battle.configDict[var_40_2]

	if not (var_40_3 and (not var_40_3.noAutoFight or var_40_3.noAutoFight == 0)) then
		GameFacade.showToast(ToastEnum.EpisodeCantUse)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_40_4 = FightModel.instance:isAuto()

	FightModel.instance:setAuto(not var_40_4)
	FightController.instance:setPlayerPrefKeyAuto(0, not var_40_4)
	arg_40_0:_updateAutoAnim()

	if FightViewHandCard.blockOperate then
		arg_40_0._blockOperate = true

		return
	end

	arg_40_0:_checkAutoCard()
end

function var_0_0._checkAutoCard(arg_41_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card and FightModel.instance:isAuto() then
		FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
		ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)

		if not FightCardModel.instance:isCardOpEnd() then
			TaskDispatcher.cancelTask(arg_41_0._delayStartAutoCards, arg_41_0)
			UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
			arg_41_0:_autoPlayCard()
		end
	end
end

function var_0_0._onClickSpeed(arg_42_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidSpeed) then
		return
	end

	local var_42_0 = FightModel.instance:getUserSpeed() == 1 and 2 or 1

	FightModel.instance:setUserSpeed(var_42_0)
	PlayerPrefsHelper.setNumber(arg_42_0:_getPlayerPrefKeySpeed(), var_42_0)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	arg_42_0:_updateSpeed()
end

function var_0_0._onClickBtnSpecialTip(arg_43_0)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickOpenView) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_43_0 = GuideModel.instance:getDoingGuideIdList()
	local var_43_1 = var_43_0 and #var_43_0 or 0

	if not FightModel.instance:isStartFinish() and var_43_1 > 0 then
		return
	end

	FightController.instance:openFightSpecialTipView()
end

function var_0_0._getPlayerPrefKeySpeed(arg_44_0)
	return PlayerPrefsKey.FightSpeed .. PlayerModel.instance:getPlayinfo().userId
end

function var_0_0._autoPlayCard(arg_45_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Season2AutoChangeHero) then
		return
	end

	if not FightReplayModel.instance:isReplay() then
		if #FightPlayerOperateMgr.detectUpgrade() > 0 and #FightCardModel.instance:getCardOps() > 0 and not FightCardModel.instance:isCardOpEnd() then
			FightRpc.instance:sendResetRoundRequest()
			FightCardModel.instance:clearCardOps()
		end

		FightRpc.instance:sendAutoRoundRequest(FightCardModel.instance:getCardOps())
	end
end

function var_0_0._onClickCareerRestrain(arg_46_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightProperty) then
		local var_46_0, var_46_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightProperty)

		GameFacade.showToast(var_46_0, var_46_1)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._onFightReconnectLastWork(arg_47_0)
	gohelper.setActive(arg_47_0._btnSpecialTip.gameObject, var_0_0.canShowSpecialBtn())
end

function var_0_0._onGMShowChange(arg_48_0)
	arg_48_0:_showEnemySubCount()
end

function var_0_0.onDestroyView(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._resetCamera, arg_49_0)
end

function var_0_0.canShowSpecialBtn()
	local var_50_0 = FightWorkBeforeStartNoticeView.canShowTips()

	if not var_50_0 then
		local var_50_1 = FightModel.instance:getFightParam().episodeId
		local var_50_2 = DungeonConfig.instance:getEpisodeCO(var_50_1)
		local var_50_3 = var_50_2 and var_50_2.type

		if Activity104Model.instance:isSeasonEpisodeType(var_50_3) then
			local var_50_4 = Activity104Model.instance:getFightCardDataList()

			var_50_0 = var_50_4 and #var_50_4 > 0
		elseif Season123Controller.canUse123EquipEpisodeType(var_50_3) then
			local var_50_5 = Season123Model.instance:getFightCardDataList()

			var_50_0 = var_50_5 and #var_50_5 > 0
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView) then
		var_50_0 = false
	end

	return var_50_0
end

function var_0_0._resetCamera(arg_51_0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	local var_51_0 = FightHelper.getAllEntitys()

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		iter_51_1:setVisibleByPos(true)

		if iter_51_1.buff then
			iter_51_1.buff:hideBuffEffects()
			iter_51_1.buff:showBuffEffects()
		end

		if iter_51_1.nameUI then
			iter_51_1.nameUI:setActive(true)
		end
	end

	local var_51_1 = GameSceneMgr.instance:getScene(SceneType.Fight)

	var_51_1.level:setFrontVisible(true)
	var_51_1.camera:setSceneCameraOffset()
end

function var_0_0._onSetStateForDialogBeforeStartFight(arg_52_0, arg_52_1)
	gohelper.setActive(arg_52_0._topRightBtnRoot, not arg_52_1)
	gohelper.setActive(arg_52_0._roundGO, not arg_52_1)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		gohelper.setActive(arg_52_0._enemyinfoRoot, false)
	else
		gohelper.setActive(arg_52_0._enemyinfoRoot, not arg_52_1)
	end

	arg_52_0:refreshEnemyAction(not arg_52_1)
end

function var_0_0.refreshEnemyAction(arg_53_0, arg_53_1)
	if arg_53_0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		gohelper.setActive(arg_53_0._enemyActionRoot, false)

		return
	end

	gohelper.setActive(arg_53_0._enemyActionRoot, arg_53_1)
	gohelper.setActive(arg_53_0.enemyActionNormal, arg_53_0.actionStatus == FightEnum.EnemyActionStatus.Normal)
	gohelper.setActive(arg_53_0.enemyActionSelect, arg_53_0.actionStatus == FightEnum.EnemyActionStatus.Select)
	gohelper.setActive(arg_53_0.enemyActionLocked, arg_53_0.actionStatus == FightEnum.EnemyActionStatus.Lock)
end

function var_0_0.onStageChange(arg_54_0)
	if arg_54_0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		arg_54_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Lock)
	else
		arg_54_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function var_0_0.setEnemyActionStatus(arg_55_0, arg_55_1)
	arg_55_0.actionStatus = arg_55_1

	FightController.instance:dispatchEvent(FightEvent.OnEnemyActionStatusChange, arg_55_0.actionStatus)
	arg_55_0:refreshEnemyAction(true)
end

function var_0_0.onClickEnemyAction(arg_56_0)
	if arg_56_0.actionStatus ~= FightEnum.EnemyActionStatus.Normal then
		return
	end

	if arg_56_0:checkMonsterCardIsEmpty() then
		return
	end

	arg_56_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Select)
	ViewMgr.instance:openView(ViewName.FightEnemyActionView)
end

function var_0_0.checkMonsterCardIsEmpty(arg_57_0)
	local var_57_0 = FightModel.instance:getCurRoundMO()
	local var_57_1 = var_57_0 and var_57_0:getAIUseCardMOList()

	if var_57_1 then
		for iter_57_0, iter_57_1 in ipairs(var_57_1) do
			if FightDataHelper.entityMgr:getById(iter_57_1.uid) then
				return false
			end
		end
	end

	return true
end

return var_0_0
