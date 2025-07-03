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
	arg_2_0:addEventCb(FightController.instance, FightEvent.GuideRecordAutoState, arg_2_0.onGuideRecordAutoState, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.GuideRefreshAutoStateByRecord, arg_2_0.onGuideRefreshAutoStateByRecord, arg_2_0)
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

	local var_4_6 = FightDataHelper.fieldMgr.customData

	if var_4_6 then
		local var_4_7 = var_4_6[FightCustomData.CustomDataType.Act191]

		if var_4_7 and var_4_7.auto then
			arg_4_0.forceAuto = true

			FightModel.instance:setAuto(true)
		end
	end

	arg_4_0:_updateRound()
	TaskDispatcher.runDelay(arg_4_0._updateAutoAnim, arg_4_0, 1)
	arg_4_0:_updateReplay()

	local var_4_8 = GuideModel.instance:isDoingFirstGuide()
	local var_4_9 = GuideController.instance:isForbidGuides()
	local var_4_10 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not var_4_8 or var_4_9)
	local var_4_11 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightSpeed) and (not var_4_8 or var_4_9)
	local var_4_12 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightProperty)
	local var_4_13 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) and (not var_4_8 or var_4_9)

	var_4_10 = var_4_10 and var_4_4

	if FightReplayModel.instance:isReplay() then
		gohelper.setActive(arg_4_0._btnAuto.gameObject, false)
	else
		gohelper.setActive(arg_4_0._btnAuto.gameObject, DungeonModel.instance:hasPassLevelAndStory(10101))
		gohelper.setActive(arg_4_0._btnAutoLockObj, arg_4_0.forceAuto or FightDataHelper.fieldMgr:isDouQuQu())
	end

	gohelper.setActive(arg_4_0._btnSpecialTip.gameObject, var_0_0.canShowSpecialBtn())

	if var_4_10 then
		UISpriteSetMgr.instance:setFightSprite(arg_4_0._imageAuto, "bt_zd", true)
	else
		UISpriteSetMgr.instance:setFightSprite(arg_4_0._imageAuto, "zd_dis", true)
	end

	if not var_4_11 and (var_4_0 == OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.FightSpeed).episodeId or GuideModel.instance:isGuideFinish(110)) then
		var_4_11 = true
	end

	if var_4_11 then
		if FightReplayModel.instance:isReplay() then
			FightModel.instance:setUserSpeed(2)
		else
			local var_4_14 = PlayerPrefsHelper.getNumber(arg_4_0:_getPlayerPrefKeySpeed(), 1)

			FightModel.instance:setUserSpeed(var_4_14)
		end
	else
		FightModel.instance:setUserSpeed(1)
	end

	arg_4_0:_updateSpeed()
	gohelper.setActive(arg_4_0._btnSpeed.gameObject, var_4_11)
	gohelper.setActive(arg_4_0._btnCareerRestrain.gameObject, false)
	gohelper.setActive(arg_4_0._btnBack.gameObject, var_4_13)
	gohelper.setActive(arg_4_0._roundGO, var_4_13 and GMFightShowState.topRightRound)
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

function var_0_0.onGuideRecordAutoState(arg_12_0)
	arg_12_0.guideRecordAutoState = FightModel.instance:isAuto()

	if arg_12_0.forceAuto then
		arg_12_0.guideRecordAutoState = true
	end
end

function var_0_0.onGuideRefreshAutoStateByRecord(arg_13_0)
	FightModel.instance:setAuto(arg_13_0.guideRecordAutoState)
	arg_13_0:_updateAutoAnim()

	if arg_13_0.guideRecordAutoState then
		arg_13_0:_checkAutoCard()
	end
end

function var_0_0._onFightDialogShow(arg_14_0)
	FightModel.instance:setAuto(false)
	arg_14_0:_updateAutoAnim()
end

function var_0_0.OnKeyAutoPress(arg_15_0)
	if not FightReplayModel.instance:isReplay() then
		arg_15_0:_onClickAuto()
	end
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.GuideView or arg_16_1 == arg_16_1.StoryView then
		FightModel.instance:setAuto(false)
		arg_16_0:_updateAutoAnim()
	end
end

function var_0_0._onCloseView(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.GuideView or arg_17_1 == arg_17_1.StoryView then
		arg_17_0:_checkContinueAuto()
	end

	if arg_17_1 == ViewName.FightFocusView then
		TaskDispatcher.runDelay(arg_17_0._resetCamera, arg_17_0, 0.16)
	end

	if arg_17_1 == ViewName.FightEnemyActionView and arg_17_0.actionStatus == FightEnum.EnemyActionStatus.Select then
		arg_17_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

local var_0_1 = {}

function var_0_0._checkContinueAuto(arg_18_0)
	if not FightModel.instance:isAuto() then
		local var_18_0 = GuideModel.instance:isDoingFirstGuide()
		local var_18_1 = GuideController.instance:isForbidGuides()
		local var_18_2 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not var_18_0 or var_18_1)
		local var_18_3 = FightModel.instance:getFightParam().battleId
		local var_18_4 = var_18_3 and lua_battle.configDict[var_18_3]
		local var_18_5 = var_18_4 and (not var_18_4.noAutoFight or var_18_4.noAutoFight == 0)
		local var_18_6 = not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight)
		local var_18_7 = not FightReplayModel.instance:isReplay()

		if FightController.instance:getPlayerPrefKeyAuto(0) and var_18_7 and var_18_6 and var_18_5 and var_18_2 then
			if not FightModel.instance:isFinish() and FightModel.instance:getCurStage() == FightEnum.Stage.Card then
				FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
				ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)
			end

			FightModel.instance:setAuto(true)
			arg_18_0:_updateAutoAnim()
			arg_18_0:_checkStartAutoCards()
		end
	end
end

function var_0_0._onBlockOperateEnd(arg_19_0)
	if arg_19_0._blockOperate then
		arg_19_0._blockOperate = nil

		arg_19_0:_checkAutoCard()
	end
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_20_0)
	if not FightModel.instance:isFinish() and not FightReplayModel.instance:isReplay() and FightDataHelper.operationDataMgr:isCardOpEnd() then
		local var_20_0 = FightModel.instance:getCurStage()

		if var_20_0 == FightEnum.Stage.Card or var_20_0 == FightEnum.Stage.AutoCard then
			FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())
		end
	end
end

function var_0_0._checkStartAutoCards(arg_21_0)
	arg_21_0:_updateRound()
	TaskDispatcher.runDelay(arg_21_0._delayStartAutoCards, arg_21_0, 0.1)
	UIBlockMgr.instance:startBlock(UIBlockKey.FightAuto)
end

function var_0_0._delayStartAutoCards(arg_22_0)
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
		if FightDataHelper.operationDataMgr:isCardOpEnd() then
			local var_22_0 = FightModel.instance:getCurStage()

			if var_22_0 == FightEnum.Stage.Card or var_22_0 == FightEnum.Stage.AutoCard then
				FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())
			end
		elseif FightModel.instance:isAuto() and FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
			arg_22_0:_autoPlayCard()
		end
	end
end

function var_0_0._updateSpeed(arg_23_0)
	local var_23_0 = FightModel.instance:getUserSpeed() == 1 and 1 or 2

	UISpriteSetMgr.instance:setFightSprite(arg_23_0._imageSpeed, "btn_x" .. var_23_0, true)

	arg_23_0._txtSpeed.text = string.format("%s%d", luaLang("multiple"), var_23_0)

	TaskDispatcher.runDelay(arg_23_0._showBtnSpeedAni, arg_23_0, 0.001)
end

function var_0_0._showBtnSpeedAni(arg_24_0)
	local var_24_0 = FightModel.instance:getUserSpeed() == 1 and "idle" or "click"

	arg_24_0._btnSpeed:GetComponent(typeof(UnityEngine.Animator)):Play(var_24_0)
end

function var_0_0._updateAutoAnim(arg_25_0)
	if not arg_25_0._autoRotateAnimation then
		arg_25_0._autoRotateAnimation = arg_25_0._imageAuto:GetComponent(typeof(UnityEngine.Animation))
	end

	if FightModel.instance:isAuto() then
		arg_25_0._autoRotateAnimation.enabled = true

		arg_25_0._autoRotateAnimation:Play()
	else
		arg_25_0._autoRotateAnimation:Stop()

		arg_25_0._autoRotateAnimation.enabled = false

		transformhelper.setLocalRotation(arg_25_0._imageAuto.transform, 0, 0, 0)
	end
end

function var_0_0._onRefreshUIRound(arg_26_0)
	arg_26_0:_updateRound()
end

function var_0_0._updateRound(arg_27_0)
	arg_27_0:_refreshWaveUI()
	arg_27_0:_refreshRoundUI()
	arg_27_0:_showEnemySubHeroCount()
end

function var_0_0._refreshWaveUI(arg_28_0)
	local var_28_0 = FightModel.instance.maxWave
	local var_28_1 = FightModel.instance:getCurWaveId()
	local var_28_2 = math.min(var_28_1, var_28_0)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		local var_28_3 = FightDataModel.instance.douQuQuMgr

		var_28_2 = var_28_3.index or 1
		var_28_0 = var_28_3.maxIndex or 1
	end

	arg_28_0._txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), var_28_2, var_28_0)
end

function var_0_0._refreshRoundUI(arg_29_0)
	local var_29_0 = FightModel.instance:getMaxRound()
	local var_29_1 = FightModel.instance:getCurRoundId()
	local var_29_2 = math.min(var_29_1, var_29_0)

	arg_29_0._txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), var_29_2, var_29_0)
end

function var_0_0._onChangeRound(arg_30_0)
	arg_30_0:_refreshRoundUI()
end

function var_0_0._showEnemySubHeroCount(arg_31_0)
	local var_31_0 = FightDataHelper.entityMgr:getEnemySubList()

	arg_31_0._txtEnemyNum.text = #var_31_0

	if #var_31_0 > 0 then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowEnemyNum)
	end

	local var_31_1 = FightDataHelper.fieldMgr.customData

	if var_31_1 and var_31_1[FightCustomData.CustomDataType.WeekwalkVer2] then
		arg_31_0._txtEnemyNum.text = "∞"
	end
end

function var_0_0.onBtnCheckSub(arg_32_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	local var_32_0 = FightDataHelper.fieldMgr.customData

	if var_32_0 and var_32_0[FightCustomData.CustomDataType.WeekwalkVer2] then
		ViewMgr.instance:openView(ViewName.FightWeekWalkEnemyTipsView)
	end
end

function var_0_0._showEnemySubCount(arg_33_0)
	local var_33_0 = FightDataHelper.entityMgr:getEnemySubList()
	local var_33_1 = GMFightShowState.leftMonster

	gohelper.setActive(arg_33_0._goEnemyNum, #var_33_0 > 0 and var_33_1)
	gohelper.setActive(arg_33_0.weeklyWalkSubEnemy, false)

	local var_33_2 = FightDataHelper.fieldMgr.customData

	if var_33_2 and var_33_2[FightCustomData.CustomDataType.WeekwalkVer2] then
		gohelper.setActive(arg_33_0._goEnemyNum, false)
		gohelper.setActive(arg_33_0.weeklyWalkSubEnemy, true)
	end
end

function var_0_0._onAddSubEntity(arg_34_0)
	arg_34_0:_showEnemySubCount()
	arg_34_0:_showEnemySubHeroCount()
end

function var_0_0._onClearMonsterSub(arg_35_0)
	arg_35_0:_showEnemySubHeroCount()
end

function var_0_0._onRefreshMonsterSubCount(arg_36_0)
	arg_36_0:_showEnemySubHeroCount()
end

function var_0_0._onBeginWave(arg_37_0)
	arg_37_0:_showEnemySubCount()
end

function var_0_0._onChangeEntity(arg_38_0)
	arg_38_0:_showEnemySubHeroCount()
end

function var_0_0._updateReplay(arg_39_0)
	gohelper.setActive(arg_39_0._goReplay, FightReplayModel.instance:isReplay())
end

function var_0_0._onEscapeBtnClick(arg_40_0)
	if arg_40_0._btnBack.gameObject.activeInHierarchy then
		arg_40_0:_onClickBack()
	end
end

function var_0_0._onClickBack(arg_41_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		local var_41_0, var_41_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightBack)

		GameFacade.showToast(var_41_0, var_41_1)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_41_2 = FightModel.instance:getCurStage()
	local var_41_3 = FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Distribute1Card)

	if var_41_2 == FightEnum.Stage.StartRound or var_41_2 == FightEnum.Stage.Distribute or var_41_3 then
		local var_41_4 = GuideModel.instance:getDoingGuideIdList()

		if var_41_4 and #var_41_4 > 0 then
			return
		end
	end

	GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
	ViewMgr.instance:openView(ViewName.FightQuitTipView)
end

function var_0_0._onClickAuto(arg_42_0)
	if arg_42_0.forceAuto then
		return
	end

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
		local var_42_0, var_42_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightAuto)

		GameFacade.showToast(var_42_0, var_42_1)

		return
	end

	local var_42_2 = FightModel.instance:getFightParam().battleId
	local var_42_3 = var_42_2 and lua_battle.configDict[var_42_2]

	if not (var_42_3 and (not var_42_3.noAutoFight or var_42_3.noAutoFight == 0)) then
		GameFacade.showToast(ToastEnum.EpisodeCantUse)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_42_4 = FightModel.instance:isAuto()

	FightModel.instance:setAuto(not var_42_4)
	FightController.instance:setPlayerPrefKeyAuto(0, not var_42_4)
	arg_42_0:_updateAutoAnim()

	if FightViewHandCard.blockOperate then
		arg_42_0._blockOperate = true

		return
	end

	arg_42_0:_checkAutoCard()
end

function var_0_0._checkAutoCard(arg_43_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card and FightModel.instance:isAuto() then
		FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
		ViewMgr.instance:closeView(ViewName.FightSkillStrengthenView, true)

		if not FightDataHelper.operationDataMgr:isCardOpEnd() then
			TaskDispatcher.cancelTask(arg_43_0._delayStartAutoCards, arg_43_0)
			UIBlockMgr.instance:endBlock(UIBlockKey.FightAuto)
			arg_43_0:_autoPlayCard()
		end
	end
end

function var_0_0._onClickSpeed(arg_44_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidSpeed) then
		return
	end

	local var_44_0 = FightModel.instance:getUserSpeed() == 1 and 2 or 1

	FightModel.instance:setUserSpeed(var_44_0)
	PlayerPrefsHelper.setNumber(arg_44_0:_getPlayerPrefKeySpeed(), var_44_0)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	arg_44_0:_updateSpeed()
end

function var_0_0._onClickBtnSpecialTip(arg_45_0)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickOpenView) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_45_0 = GuideModel.instance:getDoingGuideIdList()
	local var_45_1 = var_45_0 and #var_45_0 or 0

	if not FightModel.instance:isStartFinish() and var_45_1 > 0 then
		return
	end

	FightController.instance:openFightSpecialTipView()
end

function var_0_0._getPlayerPrefKeySpeed(arg_46_0)
	return PlayerPrefsKey.FightSpeed .. PlayerModel.instance:getPlayinfo().userId
end

function var_0_0._autoPlayCard(arg_47_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Season2AutoChangeHero) then
		return
	end

	if not FightReplayModel.instance:isReplay() then
		if #FightPlayerOperateMgr.detectUpgrade() > 0 and #FightDataHelper.operationDataMgr:getOpList() > 0 and not FightDataHelper.operationDataMgr:isCardOpEnd() then
			FightRpc.instance:sendResetRoundRequest()
		end

		FightRpc.instance:sendAutoRoundRequest(FightDataHelper.operationDataMgr:getOpList())
	end
end

function var_0_0._onClickCareerRestrain(arg_48_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightProperty) then
		local var_48_0, var_48_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightProperty)

		GameFacade.showToast(var_48_0, var_48_1)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._onFightReconnectLastWork(arg_49_0)
	gohelper.setActive(arg_49_0._btnSpecialTip.gameObject, var_0_0.canShowSpecialBtn())
end

function var_0_0._onGMShowChange(arg_50_0)
	arg_50_0:_showEnemySubCount()
end

function var_0_0.onDestroyView(arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0._resetCamera, arg_51_0)
end

function var_0_0.canShowSpecialBtn()
	local var_52_0 = FightWorkBeforeStartNoticeView.canShowTips()

	if not var_52_0 then
		local var_52_1 = FightModel.instance:getFightParam().episodeId
		local var_52_2 = DungeonConfig.instance:getEpisodeCO(var_52_1)
		local var_52_3 = var_52_2 and var_52_2.type

		if Activity104Model.instance:isSeasonEpisodeType(var_52_3) then
			local var_52_4 = Activity104Model.instance:getFightCardDataList()

			var_52_0 = var_52_4 and #var_52_4 > 0
		elseif Season123Controller.canUse123EquipEpisodeType(var_52_3) then
			local var_52_5 = Season123Model.instance:getFightCardDataList()

			var_52_0 = var_52_5 and #var_52_5 > 0
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView) then
		var_52_0 = false
	end

	return var_52_0
end

function var_0_0._resetCamera(arg_53_0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	local var_53_0 = FightHelper.getAllEntitys()

	for iter_53_0, iter_53_1 in ipairs(var_53_0) do
		iter_53_1:setVisibleByPos(true)

		if iter_53_1.buff then
			iter_53_1.buff:hideBuffEffects()
			iter_53_1.buff:showBuffEffects()
		end

		if iter_53_1.nameUI then
			iter_53_1.nameUI:setActive(true)
		end
	end

	local var_53_1 = GameSceneMgr.instance:getScene(SceneType.Fight)

	var_53_1.level:setFrontVisible(true)
	var_53_1.camera:setSceneCameraOffset()
end

function var_0_0._onSetStateForDialogBeforeStartFight(arg_54_0, arg_54_1)
	gohelper.setActive(arg_54_0._topRightBtnRoot, not arg_54_1)
	gohelper.setActive(arg_54_0._roundGO, not arg_54_1)

	if FightDataHelper.fieldMgr:isDouQuQu() or FightDataHelper.fieldMgr:is191DouQuQu() then
		gohelper.setActive(arg_54_0._enemyinfoRoot, false)
	else
		gohelper.setActive(arg_54_0._enemyinfoRoot, not arg_54_1)
	end

	arg_54_0:refreshEnemyAction(not arg_54_1)
end

function var_0_0.refreshEnemyAction(arg_55_0, arg_55_1)
	if arg_55_0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		gohelper.setActive(arg_55_0._enemyActionRoot, false)

		return
	end

	gohelper.setActive(arg_55_0._enemyActionRoot, arg_55_1)
	gohelper.setActive(arg_55_0.enemyActionNormal, arg_55_0.actionStatus == FightEnum.EnemyActionStatus.Normal)
	gohelper.setActive(arg_55_0.enemyActionSelect, arg_55_0.actionStatus == FightEnum.EnemyActionStatus.Select)
	gohelper.setActive(arg_55_0.enemyActionLocked, arg_55_0.actionStatus == FightEnum.EnemyActionStatus.Lock)
end

function var_0_0.onStageChange(arg_56_0)
	if arg_56_0.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		arg_56_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Lock)
	else
		arg_56_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function var_0_0.setEnemyActionStatus(arg_57_0, arg_57_1)
	arg_57_0.actionStatus = arg_57_1

	FightController.instance:dispatchEvent(FightEvent.OnEnemyActionStatusChange, arg_57_0.actionStatus)
	arg_57_0:refreshEnemyAction(true)
end

function var_0_0.onClickEnemyAction(arg_58_0)
	if arg_58_0.actionStatus ~= FightEnum.EnemyActionStatus.Normal then
		return
	end

	if arg_58_0:checkMonsterCardIsEmpty() then
		return
	end

	arg_58_0:setEnemyActionStatus(FightEnum.EnemyActionStatus.Select)
	ViewMgr.instance:openView(ViewName.FightEnemyActionView)
end

function var_0_0.checkMonsterCardIsEmpty(arg_59_0)
	local var_59_0 = FightDataHelper.roundMgr:getRoundData()
	local var_59_1 = var_59_0 and var_59_0:getAIUseCardMOList()

	if var_59_1 then
		for iter_59_0, iter_59_1 in ipairs(var_59_1) do
			if FightDataHelper.entityMgr:getById(iter_59_1.uid) then
				return false
			end
		end
	end

	return true
end

return var_0_0
