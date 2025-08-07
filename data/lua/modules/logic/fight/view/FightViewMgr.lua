module("modules.logic.fight.view.FightViewMgr", package.seeall)

local var_0_0 = class("FightViewMgr", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topLeft = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent")
	arg_1_0._topRightBtnRoot = gohelper.findChild(arg_1_0.viewGO, "root/btns")
	arg_1_0._fightSeasonChangeHero = gohelper.findChild(arg_1_0.viewGO, "root/fightSeasonChangeHero")
	arg_1_0._progressRoot = gohelper.findChild(arg_1_0._topLeft, "#go_commonalityslider")
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._taskRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/#go_task")

	gohelper.setActive(arg_1_0._fightSeasonChangeHero, false)
	gohelper.setActive(arg_1_0._progressRoot, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, arg_2_0._onBeforeEnterStepBehaviour)
	arg_2_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate)
	arg_2_0:com_registFightEvent(FightEvent.BloodPool_OnCreate, arg_2_0.onBloodPoolCreate)
	arg_2_0:com_registFightEvent(FightEvent.DoomsdayClock_OnValueChange, arg_2_0.onCreateDoomsdayClock)
	arg_2_0:com_registFightEvent(FightEvent.DoomsdayClock_OnAreaChange, arg_2_0.onCreateDoomsdayClock)
	arg_2_0:com_registMsg(FightMsgId.FightProgressValueChange, arg_2_0._showFightProgress)
	arg_2_0:com_registMsg(FightMsgId.FightMaxProgressValueChange, arg_2_0._showFightProgress)
	arg_2_0:com_registMsg(FightMsgId.ShowDouQuQuXianHouShou, arg_2_0._onShowDouQuQuXianHouShou)
	arg_2_0:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, arg_2_0._onRefreshPlayerFinisherSkill)
	arg_2_0:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, arg_2_0._onRefreshSimplePolarizationLevel)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onCreateDoomsdayClock(arg_4_0)
	arg_4_0:createDoomsdayClock()
end

function var_0_0.onBloodPoolCreate(arg_5_0, arg_5_1)
	if arg_5_1 ~= FightEnum.TeamType.MySide then
		return
	end

	arg_5_0:_createBloodPool(arg_5_1)
end

function var_0_0._showSimplePolarizationLevel(arg_6_0)
	local var_6_0 = FightDataHelper.entityMgr:getMyVertin()

	if var_6_0 then
		local var_6_1 = var_6_0:getBuffList()

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			if iter_6_1.buffId == 6240501 then
				arg_6_0:_onRefreshSimplePolarizationLevel()

				return
			end
		end
	end
end

function var_0_0._onBuffUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_3 == 6240501 and arg_7_1 == FightEntityScene.MySideId then
		arg_7_0:_onRefreshSimplePolarizationLevel()
	end
end

function var_0_0._onRefreshSimplePolarizationLevel(arg_8_0)
	if arg_8_0._simplePolarizationLevel then
		return
	end

	local var_8_0 = arg_8_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.MelodyLevel)

	arg_8_0._simplePolarizationLevel = arg_8_0:com_openSubView(FightSimplePolarizationLevelView, "ui/viewres/fight/fightsimplepolarizationlevelview.prefab", var_8_0)

	arg_8_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.MelodyLevel)
end

function var_0_0._onRefreshPlayerFinisherSkill(arg_9_0)
	if arg_9_0._playerFinisherSkill then
		return
	end

	local var_9_0 = arg_9_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.MelodySkill)

	arg_9_0._playerFinisherSkill = arg_9_0:com_openSubView(FightPlayerFinisherSkillView, "ui/viewres/fight/fightplayerfinisherskillview.prefab", var_9_0)

	arg_9_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.MelodySkill)
end

function var_0_0._onShowDouQuQuXianHouShou(arg_10_0, arg_10_1)
	arg_10_0:com_openSubView(FightAct174StartFirstView, "ui/viewres/fight/fight_act174startfirstview.prefab", arg_10_0.viewGO, arg_10_1)
end

function var_0_0._onBeforeEnterStepBehaviour(arg_11_0)
	if FightModel.instance:isSeason2() then
		gohelper.setActive(arg_11_0._fightSeasonChangeHero, true)
		arg_11_0:com_openSubView(FightSeasonChangeHeroView, arg_11_0._fightSeasonChangeHero)
	end

	arg_11_0:_showTopLeft()
end

function var_0_0._showTopLeft(arg_12_0)
	arg_12_0:_showFightProgress()
end

function var_0_0._showFightProgress(arg_13_0)
	if FightDataHelper.fieldMgr.progressMax > 0 then
		if arg_13_0._progressView then
			return
		end

		gohelper.setActive(arg_13_0._progressRoot, true)

		local var_13_0 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId]
		local var_13_1 = "ui/viewres/fight/commonalityslider.prefab"
		local var_13_2 = FightCommonalitySlider

		if var_13_0 == 1 then
			var_13_1 = "ui/viewres/fight/commonalityslider1.prefab"
		elseif var_13_0 == 2 then
			var_13_1 = "ui/viewres/fight/commonalityslider2.prefab"
			var_13_2 = FightCommonalitySlider2
		end

		arg_13_0._progressView = arg_13_0:com_openSubView(var_13_2, var_13_1, arg_13_0._progressRoot, arg_13_0._goRoot)
	end
end

function var_0_0.showFightNewProgress(arg_14_0)
	arg_14_0:com_openSubView(FightNewProgressView, arg_14_0.viewGO)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_showCardDeckBtn()
	arg_15_0:_showSeasonTalentBtn()
	arg_15_0:_showPlayerFinisherSkill()
	arg_15_0:_showSimplePolarizationLevel()
	arg_15_0:_showTaskPart()
	arg_15_0:_showBloodPool()
	arg_15_0:_showDoomsdayClock()
	arg_15_0:showDouQuQuCoin()
	arg_15_0:showDouQuQuHunting()
	arg_15_0:showFightNewProgress()
	arg_15_0:showItemSkillInfos()
	arg_15_0:showBattleId_9290103_Task()
end

function var_0_0.showItemSkillInfos(arg_16_0)
	local var_16_0 = FightDataHelper.teamDataMgr.myData.itemSkillInfos

	if var_16_0 and #var_16_0 > 0 then
		local var_16_1 = "ui/viewres/fight/fightassassinwheelbtnview.prefab"
		local var_16_2 = gohelper.findChild(arg_16_0.viewGO, "root")

		arg_16_0:com_openSubView(FightItemSkillInfosBtnView, var_16_1, var_16_2)
	end
end

function var_0_0.showDouQuQuHunting(arg_17_0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	local var_17_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if not var_17_0 then
		return
	end

	if var_17_0.minNeedHuntValue == -1 then
		return
	end

	local var_17_1 = FightRightElementEnum.Elements.DouQuQuHunting
	local var_17_2 = arg_17_0.viewContainer.rightElementLayoutView:getElementContainer(var_17_1)

	arg_17_0:com_openSubView(FightDouQuQuHuntingView, "ui/viewres/fight/fight_act191huntview.prefab", var_17_2)
	arg_17_0.viewContainer.rightElementLayoutView:showElement(var_17_1)
end

function var_0_0.showDouQuQuCoin(arg_18_0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	if not FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191] then
		return
	end

	local var_18_0 = FightRightElementEnum.Elements.DouQuQuCoin
	local var_18_1 = arg_18_0.viewContainer.rightElementLayoutView:getElementContainer(var_18_0)

	arg_18_0:com_openSubView(FightDouQuQuCoinView, "ui/viewres/fight/fight_act191coinview.prefab", var_18_1)
	arg_18_0.viewContainer.rightElementLayoutView:showElement(var_18_0)
end

function var_0_0._showDoomsdayClock(arg_19_0)
	local var_19_0 = FightDataHelper.fieldMgr.param

	if var_19_0 and var_19_0:getKey(FightParamData.ParamKey.DoomsdayClock_Range4) then
		arg_19_0:createDoomsdayClock()
	end
end

function var_0_0.createDoomsdayClock(arg_20_0)
	if arg_20_0.doomsdayClockView then
		return
	end

	local var_20_0 = arg_20_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DoomsdayClock)

	arg_20_0.doomsdayClockView = arg_20_0:com_openSubView(FightDoomsdayClockView, "ui/viewres/fight/fightclockview.prefab", var_20_0)

	arg_20_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DoomsdayClock)
end

function var_0_0._showBloodPool(arg_21_0)
	if FightDataHelper.getBloodPool(FightEnum.TeamType.MySide) then
		arg_21_0:_createBloodPool(FightEnum.TeamType.MySide)
	end
end

function var_0_0._createBloodPool(arg_22_0, arg_22_1)
	if arg_22_0.bloodPoolView then
		return
	end

	local var_22_0 = arg_22_0.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.BloodPool)

	arg_22_0.bloodPoolView = arg_22_0:com_openSubView(FightBloodPoolView, "ui/viewres/fight/fightbloodview.prefab", var_22_0, arg_22_1)

	arg_22_0.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.BloodPool)
end

function var_0_0._showPlayerFinisherSkill(arg_23_0)
	local var_23_0 = FightDataHelper.fieldMgr.playerFinisherInfo

	if var_23_0 and #var_23_0.skills > 0 then
		arg_23_0:_onRefreshPlayerFinisherSkill()
	end
end

function var_0_0._showCardDeckBtn(arg_24_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		arg_24_0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", arg_24_0._onBtnLoaded)
	end
end

function var_0_0.onDeckGenerate_Anim(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1 and #arg_25_1 or 0

	if var_25_0 <= 0 then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.goPaiList) do
		gohelper.setActive(iter_25_1, iter_25_0 <= var_25_0)
	end

	arg_25_0:showDeckActiveGo()
	arg_25_0.deckAnimatorPlayer:Play("generate", arg_25_0.hideDeckActiveGo, arg_25_0)
	AudioMgr.instance:trigger(20250502)
end

function var_0_0.onPlayGenerateAnimDone(arg_26_0)
	arg_26_0:hideDeckActiveGo()
	arg_26_0:com_sendFightEvent(FightEvent.CardDeckGenerateDone)
end

function var_0_0.onDeckDelete_Anim(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1 and #arg_27_1 or 0

	if var_27_0 <= 0 then
		return arg_27_0:onPlayDeleteAnimDone()
	end

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.goPaiList) do
		gohelper.setActive(iter_27_1, iter_27_0 <= var_27_0)
	end

	arg_27_0:showDeckActiveGo()
	arg_27_0.deckAnimatorPlayer:Play("delete", arg_27_0.onPlayDeleteAnimAnchorDone, arg_27_0)
	AudioMgr.instance:trigger(20250503)
end

function var_0_0.onPlayDeleteAnimAnchorDone(arg_28_0)
	local var_28_0 = {
		dissolveScale = 1,
		dissolveSkillItemGOs = {
			arg_28_0.goDeckActive
		}
	}

	arg_28_0:clearFlow()

	arg_28_0.dissolveFlow = FlowSequence.New()

	arg_28_0.dissolveFlow:addWork(FightCardDissolveEffect.New())
	arg_28_0.dissolveFlow:registerDoneListener(arg_28_0.onPlayDeleteAnimDone, arg_28_0)
	arg_28_0.dissolveFlow:start(var_28_0)
end

function var_0_0.clearFlow(arg_29_0)
	if arg_29_0.dissolveFlow then
		arg_29_0.dissolveFlow:stop()

		arg_29_0.dissolveFlow = nil
	end
end

function var_0_0.onPlayDeleteAnimDone(arg_30_0)
	arg_30_0:hideDeckActiveGo()
	arg_30_0:com_sendFightEvent(FightEvent.CardDeckDeleteDone)
end

function var_0_0.hideDeckActiveGo(arg_31_0)
	gohelper.setActive(arg_31_0.goDeckActive, false)
end

function var_0_0.showDeckActiveGo(arg_32_0)
	gohelper.setActive(arg_32_0.goDeckActive, true)
end

var_0_0.MaxDeckAnimLen = 15

function var_0_0._onBtnLoaded(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1 then
		return
	end

	local var_33_0 = arg_33_2:GetResource()
	local var_33_1 = gohelper.clone(var_33_0, arg_33_0._topRightBtnRoot, "cardBox")

	arg_33_0.goDeckBtn = var_33_1

	arg_33_0:com_registClick(gohelper.getClickWithDefaultAudio(var_33_1), arg_33_0._onCardBoxClick, arg_33_0)
	gohelper.setAsFirstSibling(var_33_1)

	arg_33_0._deckCardAnimator = gohelper.onceAddComponent(var_33_1, typeof(UnityEngine.Animator))
	arg_33_0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(var_33_1)
	arg_33_0.txtNum = gohelper.findChildText(var_33_1, "txt_Num")

	gohelper.setActive(arg_33_0.txtNum.gameObject, false)

	local var_33_2 = gohelper.findChild(arg_33_0.goDeckBtn, "#go_Active")

	gohelper.setActive(var_33_2, false)

	arg_33_0.deckContainer = gohelper.findChild(arg_33_0.goDeckBtn, "#deckbtn")

	gohelper.setActive(arg_33_0.deckContainer, true)

	arg_33_0.deckAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_33_0.deckContainer)
	arg_33_0.goDeckActive = gohelper.findChild(arg_33_0.deckContainer, "active")

	arg_33_0:hideDeckActiveGo()

	arg_33_0.goPaiList = arg_33_0:newUserDataTable()

	for iter_33_0 = 1, var_0_0.MaxDeckAnimLen do
		local var_33_3 = gohelper.findChild(arg_33_0.goDeckActive, string.format("#pai%02d", iter_33_0))

		if not var_33_3 then
			logError("deck view not find pai , index : " .. iter_33_0)
		end

		table.insert(arg_33_0.goPaiList, var_33_3)
	end

	arg_33_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_33_0._onCardDeckGenerate)
	arg_33_0:com_registFightEvent(FightEvent.CardClear, arg_33_0._onCardClear)
	arg_33_0:com_registFightEvent(FightEvent.CardBoxNumChange, arg_33_0.onCardBoxNumChange)
	arg_33_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_33_0.onDeckGenerate_Anim)
	arg_33_0:com_registFightEvent(FightEvent.CardDeckDelete, arg_33_0.onDeckDelete_Anim)
end

function var_0_0.activeDeck(arg_34_0)
	local var_34_0 = FightDataHelper.fieldMgr

	if var_34_0 and var_34_0:isAct183() then
		local var_34_1 = gohelper.findChild(arg_34_0.goDeckBtn, "#go_Active")

		gohelper.setActive(var_34_1, true)
		gohelper.setActive(arg_34_0.txtNum.gameObject, true)
	end
end

function var_0_0.clearTweenId(arg_35_0)
	if arg_35_0.tweenId then
		ZProj.TweenHelper.KillById(arg_35_0.tweenId)

		arg_35_0.tweenId = nil
	end
end

var_0_0.DeckNumChangeDuration = 0.5

function var_0_0.onCardBoxNumChange(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0:activeDeck()
	arg_36_0:clearTweenId()

	local var_36_0 = tonumber(arg_36_0.txtNum.text) or 0

	arg_36_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_36_0, arg_36_2, var_0_0.DeckNumChangeDuration, arg_36_0.directSetDeckNum, nil, arg_36_0)
end

function var_0_0.directSetDeckNum(arg_37_0, arg_37_1)
	arg_37_0.txtNum.text = math.ceil(arg_37_1)
end

function var_0_0.onNumChangeDone(arg_38_0)
	arg_38_0:directSetDeckNum(FightDataHelper.fieldMgr.deckNum)
end

function var_0_0._onCardBoxClick(arg_39_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function var_0_0._showSeasonTalentBtn(arg_40_0)
	if not Season166Model.instance:getBattleContext(true) then
		return
	end

	if Season166Model.instance:checkCanShowSeasonTalent() then
		arg_40_0:com_loadAsset("ui/viewres/fight/fightseasontalentbtn.prefab", arg_40_0._onBtnSeasonTalentLoaded)
	end
end

function var_0_0._onBtnSeasonTalentLoaded(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_1 then
		return
	end

	local var_41_0 = arg_41_2:GetResource()
	local var_41_1 = gohelper.clone(var_41_0, arg_41_0._topRightBtnRoot, "fightseasontalentbtn")

	arg_41_0:com_registClick(gohelper.getClickWithDefaultAudio(var_41_1), arg_41_0._onSeasonTalentClick, arg_41_0)
	gohelper.setAsFirstSibling(var_41_1)
end

function var_0_0._onSeasonTalentClick(arg_42_0)
	Season166Controller.instance:openTalentInfoView()
end

function var_0_0._deckAniFinish(arg_43_0)
	arg_43_0._deckCardAnimator.enabled = true

	arg_43_0._deckCardAnimator:Play("idle")
end

function var_0_0._onCardDeckGenerate(arg_44_0)
	arg_44_0._deckBtnAniPlayer:Play("add", arg_44_0._deckAniFinish, arg_44_0)
end

function var_0_0._onCardClear(arg_45_0)
	arg_45_0._deckBtnAniPlayer:Play("delete", arg_45_0._deckAniFinish, arg_45_0)
end

function var_0_0._showTaskPart(arg_46_0)
	local var_46_0 = FightDataHelper.fieldMgr.episodeId

	if FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.Act183) then
		local var_46_1 = lua_challenge_episode.configDict[var_46_0]

		if not var_46_1 then
			return
		end

		if string.nilorempty(var_46_1.condition) then
			return
		end

		arg_46_0:com_openSubView(Fight183TaskView, "ui/viewres/fight/fighttaskview.prefab", arg_46_0._taskRoot, var_46_1.condition)
	end
end

function var_0_0.showBattleId_9290103_Task(arg_47_0)
	if FightDataHelper.fieldMgr.battleId == 9290103 then
		gohelper.setActive(arg_47_0._taskRoot, true)
		arg_47_0:com_openSubView(FightBattleId_9290103TaskView, "ui/viewres/fight/fighttaskview.prefab", arg_47_0._taskRoot)
	end
end

function var_0_0.onClose(arg_48_0)
	return
end

function var_0_0.onDestroyView(arg_49_0)
	arg_49_0:clearFlow()
	arg_49_0:clearTweenId()
end

return var_0_0
