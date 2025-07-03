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

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_showCardDeckBtn()
	arg_14_0:_showSeasonTalentBtn()
	arg_14_0:_showPlayerFinisherSkill()
	arg_14_0:_showSimplePolarizationLevel()
	arg_14_0:_showTaskPart()
	arg_14_0:_showBloodPool()
	arg_14_0:_showDoomsdayClock()
	arg_14_0:showDouQuQuCoin()
	arg_14_0:showDouQuQuHunting()
end

function var_0_0.showDouQuQuHunting(arg_15_0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	local var_15_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if not var_15_0 then
		return
	end

	if var_15_0.minNeedHuntValue == -1 then
		return
	end

	local var_15_1 = FightRightElementEnum.Elements.DouQuQuHunting
	local var_15_2 = arg_15_0.viewContainer.rightElementLayoutView:getElementContainer(var_15_1)

	arg_15_0:com_openSubView(FightDouQuQuHuntingView, "ui/viewres/fight/fight_act191huntview.prefab", var_15_2)
	arg_15_0.viewContainer.rightElementLayoutView:showElement(var_15_1)
end

function var_0_0.showDouQuQuCoin(arg_16_0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	if not FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191] then
		return
	end

	local var_16_0 = FightRightElementEnum.Elements.DouQuQuCoin
	local var_16_1 = arg_16_0.viewContainer.rightElementLayoutView:getElementContainer(var_16_0)

	arg_16_0:com_openSubView(FightDouQuQuCoinView, "ui/viewres/fight/fight_act191coinview.prefab", var_16_1)
	arg_16_0.viewContainer.rightElementLayoutView:showElement(var_16_0)
end

function var_0_0._showDoomsdayClock(arg_17_0)
	local var_17_0 = FightDataHelper.fieldMgr.param

	if var_17_0 and var_17_0:getKey(FightParamData.ParamKey.DoomsdayClock_Range4) then
		arg_17_0:createDoomsdayClock()
	end
end

function var_0_0.createDoomsdayClock(arg_18_0)
	if arg_18_0.doomsdayClockView then
		return
	end

	local var_18_0 = arg_18_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DoomsdayClock)

	arg_18_0.doomsdayClockView = arg_18_0:com_openSubView(FightDoomsdayClockView, "ui/viewres/fight/fightclockview.prefab", var_18_0)

	arg_18_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DoomsdayClock)
end

function var_0_0._showBloodPool(arg_19_0)
	if FightDataHelper.getBloodPool(FightEnum.TeamType.MySide) then
		arg_19_0:_createBloodPool(FightEnum.TeamType.MySide)
	end
end

function var_0_0._createBloodPool(arg_20_0, arg_20_1)
	if arg_20_0.bloodPoolView then
		return
	end

	local var_20_0 = arg_20_0.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.BloodPool)

	arg_20_0.bloodPoolView = arg_20_0:com_openSubView(FightBloodPoolView, "ui/viewres/fight/fightbloodview.prefab", var_20_0, arg_20_1)

	arg_20_0.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.BloodPool)
end

function var_0_0._showPlayerFinisherSkill(arg_21_0)
	local var_21_0 = FightDataHelper.fieldMgr.playerFinisherInfo

	if var_21_0 and #var_21_0.skills > 0 then
		arg_21_0:_onRefreshPlayerFinisherSkill()
	end
end

function var_0_0._showCardDeckBtn(arg_22_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		arg_22_0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", arg_22_0._onBtnLoaded)
	end
end

function var_0_0.onDeckGenerate_Anim(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 and #arg_23_1 or 0

	if var_23_0 <= 0 then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.goPaiList) do
		gohelper.setActive(iter_23_1, iter_23_0 <= var_23_0)
	end

	arg_23_0:showDeckActiveGo()
	arg_23_0.deckAnimatorPlayer:Play("generate", arg_23_0.hideDeckActiveGo, arg_23_0)
	AudioMgr.instance:trigger(20250502)
end

function var_0_0.onPlayGenerateAnimDone(arg_24_0)
	arg_24_0:hideDeckActiveGo()
	arg_24_0:com_sendFightEvent(FightEvent.CardDeckGenerateDone)
end

function var_0_0.onDeckDelete_Anim(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1 and #arg_25_1 or 0

	if var_25_0 <= 0 then
		return arg_25_0:onPlayDeleteAnimDone()
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.goPaiList) do
		gohelper.setActive(iter_25_1, iter_25_0 <= var_25_0)
	end

	arg_25_0:showDeckActiveGo()
	arg_25_0.deckAnimatorPlayer:Play("delete", arg_25_0.onPlayDeleteAnimAnchorDone, arg_25_0)
	AudioMgr.instance:trigger(20250503)
end

function var_0_0.onPlayDeleteAnimAnchorDone(arg_26_0)
	local var_26_0 = {
		dissolveScale = 1,
		dissolveSkillItemGOs = {
			arg_26_0.goDeckActive
		}
	}

	arg_26_0:clearFlow()

	arg_26_0.dissolveFlow = FlowSequence.New()

	arg_26_0.dissolveFlow:addWork(FightCardDissolveEffect.New())
	arg_26_0.dissolveFlow:registerDoneListener(arg_26_0.onPlayDeleteAnimDone, arg_26_0)
	arg_26_0.dissolveFlow:start(var_26_0)
end

function var_0_0.clearFlow(arg_27_0)
	if arg_27_0.dissolveFlow then
		arg_27_0.dissolveFlow:stop()

		arg_27_0.dissolveFlow = nil
	end
end

function var_0_0.onPlayDeleteAnimDone(arg_28_0)
	arg_28_0:hideDeckActiveGo()
	arg_28_0:com_sendFightEvent(FightEvent.CardDeckDeleteDone)
end

function var_0_0.hideDeckActiveGo(arg_29_0)
	gohelper.setActive(arg_29_0.goDeckActive, false)
end

function var_0_0.showDeckActiveGo(arg_30_0)
	gohelper.setActive(arg_30_0.goDeckActive, true)
end

var_0_0.MaxDeckAnimLen = 15

function var_0_0._onBtnLoaded(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_1 then
		return
	end

	local var_31_0 = arg_31_2:GetResource()
	local var_31_1 = gohelper.clone(var_31_0, arg_31_0._topRightBtnRoot, "cardBox")

	arg_31_0.goDeckBtn = var_31_1

	arg_31_0:com_registClick(gohelper.getClickWithDefaultAudio(var_31_1), arg_31_0._onCardBoxClick, arg_31_0)
	gohelper.setAsFirstSibling(var_31_1)

	arg_31_0._deckCardAnimator = gohelper.onceAddComponent(var_31_1, typeof(UnityEngine.Animator))
	arg_31_0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(var_31_1)
	arg_31_0.txtNum = gohelper.findChildText(var_31_1, "txt_Num")

	gohelper.setActive(arg_31_0.txtNum.gameObject, false)

	local var_31_2 = gohelper.findChild(arg_31_0.goDeckBtn, "#go_Active")

	gohelper.setActive(var_31_2, false)

	arg_31_0.deckContainer = gohelper.findChild(arg_31_0.goDeckBtn, "#deckbtn")

	gohelper.setActive(arg_31_0.deckContainer, true)

	arg_31_0.deckAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_31_0.deckContainer)
	arg_31_0.goDeckActive = gohelper.findChild(arg_31_0.deckContainer, "active")

	arg_31_0:hideDeckActiveGo()

	arg_31_0.goPaiList = arg_31_0:newUserDataTable()

	for iter_31_0 = 1, var_0_0.MaxDeckAnimLen do
		local var_31_3 = gohelper.findChild(arg_31_0.goDeckActive, string.format("#pai%02d", iter_31_0))

		if not var_31_3 then
			logError("deck view not find pai , index : " .. iter_31_0)
		end

		table.insert(arg_31_0.goPaiList, var_31_3)
	end

	arg_31_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_31_0._onCardDeckGenerate)
	arg_31_0:com_registFightEvent(FightEvent.CardClear, arg_31_0._onCardClear)
	arg_31_0:com_registFightEvent(FightEvent.CardBoxNumChange, arg_31_0.onCardBoxNumChange)
	arg_31_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_31_0.onDeckGenerate_Anim)
	arg_31_0:com_registFightEvent(FightEvent.CardDeckDelete, arg_31_0.onDeckDelete_Anim)
end

function var_0_0.activeDeck(arg_32_0)
	local var_32_0 = FightDataHelper.fieldMgr

	if var_32_0 and var_32_0:isAct183() then
		local var_32_1 = gohelper.findChild(arg_32_0.goDeckBtn, "#go_Active")

		gohelper.setActive(var_32_1, true)
		gohelper.setActive(arg_32_0.txtNum.gameObject, true)
	end
end

function var_0_0.clearTweenId(arg_33_0)
	if arg_33_0.tweenId then
		ZProj.TweenHelper.KillById(arg_33_0.tweenId)

		arg_33_0.tweenId = nil
	end
end

var_0_0.DeckNumChangeDuration = 0.5

function var_0_0.onCardBoxNumChange(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:activeDeck()
	arg_34_0:clearTweenId()

	local var_34_0 = tonumber(arg_34_0.txtNum.text) or 0

	arg_34_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_34_0, arg_34_2, var_0_0.DeckNumChangeDuration, arg_34_0.directSetDeckNum, nil, arg_34_0)
end

function var_0_0.directSetDeckNum(arg_35_0, arg_35_1)
	arg_35_0.txtNum.text = math.ceil(arg_35_1)
end

function var_0_0.onNumChangeDone(arg_36_0)
	arg_36_0:directSetDeckNum(FightDataHelper.fieldMgr.deckNum)
end

function var_0_0._onCardBoxClick(arg_37_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function var_0_0._showSeasonTalentBtn(arg_38_0)
	if not Season166Model.instance:getBattleContext(true) then
		return
	end

	if Season166Model.instance:checkCanShowSeasonTalent() then
		arg_38_0:com_loadAsset("ui/viewres/fight/fightseasontalentbtn.prefab", arg_38_0._onBtnSeasonTalentLoaded)
	end
end

function var_0_0._onBtnSeasonTalentLoaded(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_1 then
		return
	end

	local var_39_0 = arg_39_2:GetResource()
	local var_39_1 = gohelper.clone(var_39_0, arg_39_0._topRightBtnRoot, "fightseasontalentbtn")

	arg_39_0:com_registClick(gohelper.getClickWithDefaultAudio(var_39_1), arg_39_0._onSeasonTalentClick, arg_39_0)
	gohelper.setAsFirstSibling(var_39_1)
end

function var_0_0._onSeasonTalentClick(arg_40_0)
	Season166Controller.instance:openTalentInfoView()
end

function var_0_0._deckAniFinish(arg_41_0)
	arg_41_0._deckCardAnimator.enabled = true

	arg_41_0._deckCardAnimator:Play("idle")
end

function var_0_0._onCardDeckGenerate(arg_42_0)
	arg_42_0._deckBtnAniPlayer:Play("add", arg_42_0._deckAniFinish, arg_42_0)
end

function var_0_0._onCardClear(arg_43_0)
	arg_43_0._deckBtnAniPlayer:Play("delete", arg_43_0._deckAniFinish, arg_43_0)
end

function var_0_0._showTaskPart(arg_44_0)
	local var_44_0 = FightDataHelper.fieldMgr.episodeId

	if FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.Act183) then
		local var_44_1 = lua_challenge_episode.configDict[var_44_0]

		if not var_44_1 then
			return
		end

		if string.nilorempty(var_44_1.condition) then
			return
		end

		arg_44_0:com_openSubView(Fight183TaskView, "ui/viewres/fight/fighttaskview.prefab", arg_44_0._taskRoot, var_44_1.condition)
	end
end

function var_0_0.onClose(arg_45_0)
	return
end

function var_0_0.onDestroyView(arg_46_0)
	arg_46_0:clearFlow()
	arg_46_0:clearTweenId()
end

return var_0_0
