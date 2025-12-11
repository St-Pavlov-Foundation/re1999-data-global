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
	gohelper.setActive(arg_1_0._taskRoot, false)
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
	arg_2_0:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, arg_2_0._showPlayerFinisherSkill)
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
		elseif var_13_0 == 3 then
			var_13_1 = "ui/viewres/fight/fightcoldview.prefab"
			var_13_2 = FightCommonalitySlider3
		elseif var_13_0 == 4 then
			var_13_1 = "ui/viewres/fight/fightcoldview.prefab"
			var_13_2 = FightCommonalitySlider4
		end

		arg_13_0._progressView = arg_13_0:com_openSubView(var_13_2, var_13_1, arg_13_0._progressRoot, arg_13_0._goRoot)
	end
end

function var_0_0.showFightNewProgress(arg_14_0)
	arg_14_0:com_openSubView(FightNewProgressView, arg_14_0.viewGO)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.top = arg_15_0:com_openSubView(FightTopView, arg_15_0.viewGO)
	arg_15_0.topLeft = arg_15_0:com_openSubView(FightTopLeftView, arg_15_0.viewGO)
	arg_15_0.topRight = arg_15_0:com_openSubView(FightTopRightView, arg_15_0.viewGO)
	arg_15_0.center = arg_15_0:com_openSubView(FightCenterView, arg_15_0.viewGO)
	arg_15_0.left = arg_15_0:com_openSubView(FightLeftView, arg_15_0.viewGO)
	arg_15_0.right = arg_15_0:com_openSubView(FightRightView, arg_15_0.viewGO)
	arg_15_0.bottom = arg_15_0:com_openSubView(FightBottomView, arg_15_0.viewGO)
	arg_15_0.bottomLeft = arg_15_0:com_openSubView(FightBottomLeftView, arg_15_0.viewGO)
	arg_15_0.bottomRight = arg_15_0:com_openSubView(FightBottomRightView, arg_15_0.viewGO)

	arg_15_0:_showCardDeckBtn()
	arg_15_0:_showSeasonTalentBtn()
	arg_15_0:_showPlayerFinisherSkill()
	arg_15_0:_showSimplePolarizationLevel()
	arg_15_0:_showTaskPart()
	arg_15_0:_showBloodPool()
	arg_15_0:_showDoomsdayClock()
	arg_15_0:showDouQuQuHunting()
	arg_15_0:showFightNewProgress()
	arg_15_0:showItemSkillInfos()
	arg_15_0:showBattleId_9290103_Task()
	arg_15_0:showDouQuQuBoss()
	arg_15_0:showSurvivalTalent2()
end

function var_0_0.showSurvivalTalent2(arg_16_0)
	if arg_16_0.survivalTalent2View then
		return
	end

	local var_16_0 = FightDataHelper.entityMgr:getVorpalith()

	if var_16_0 and var_16_0:getPowerInfo(FightEnum.PowerType.SurvivalDot) then
		local var_16_1 = "ui/viewres/fight/fightsurvivaltalentview2.prefab"
		local var_16_2 = arg_16_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.SurvivalTalent2)

		arg_16_0.survivalTalent2View = arg_16_0:com_openSubView(FightSurvivalTalent2View, var_16_1, var_16_2)

		arg_16_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.SurvivalTalent2)
	end
end

function var_0_0.showItemSkillInfos(arg_17_0)
	local var_17_0 = FightDataHelper.teamDataMgr.myData.itemSkillInfos

	if var_17_0 and #var_17_0 > 0 then
		local var_17_1 = "ui/viewres/fight/fightassassinwheelbtnview.prefab"
		local var_17_2 = gohelper.findChild(arg_17_0.viewGO, "root")

		arg_17_0:com_openSubView(FightItemSkillInfosBtnView, var_17_1, var_17_2)
	end
end

function var_0_0.showDouQuQuHunting(arg_18_0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	local var_18_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	if not var_18_0 then
		return
	end

	if var_18_0.minNeedHuntValue == -1 then
		return
	end

	local var_18_1 = FightRightElementEnum.Elements.DouQuQuHunting
	local var_18_2 = arg_18_0.viewContainer.rightElementLayoutView:getElementContainer(var_18_1)

	arg_18_0:com_openSubView(FightDouQuQuHuntingView, "ui/viewres/fight/fight_act191huntview.prefab", var_18_2)
	arg_18_0.viewContainer.rightElementLayoutView:showElement(var_18_1)
end

function var_0_0.showDouQuQuCoin(arg_19_0)
	if not FightDataHelper.fieldMgr.customData then
		return
	end

	if not FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191] then
		return
	end

	local var_19_0 = FightRightElementEnum.Elements.DouQuQuCoin
	local var_19_1 = arg_19_0.viewContainer.rightElementLayoutView:getElementContainer(var_19_0)

	arg_19_0:com_openSubView(FightDouQuQuCoinView, "ui/viewres/fight/fight_act191coinview.prefab", var_19_1)
	arg_19_0.viewContainer.rightElementLayoutView:showElement(var_19_0)
end

function var_0_0.showDouQuQuBoss(arg_20_0)
	local var_20_0 = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.TeamType.MySide)

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if iter_20_1.entityType == FightEnum.EntityType.Act191Boss and iter_20_1:getPowerInfo(FightEnum.PowerType.Act191Boss) then
			local var_20_1 = arg_20_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DouQuQuBoss)

			arg_20_0:com_openSubView(FightDouQuQuBossView, "ui/viewres/fight/fight_act191assistbossview.prefab", var_20_1, iter_20_1)
			arg_20_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DouQuQuBoss)

			break
		end
	end
end

function var_0_0._showDoomsdayClock(arg_21_0)
	local var_21_0 = FightDataHelper.fieldMgr.param

	if var_21_0 and var_21_0:getKey(FightParamData.ParamKey.DoomsdayClock_Range4) then
		arg_21_0:createDoomsdayClock()
	end
end

function var_0_0.createDoomsdayClock(arg_22_0)
	if arg_22_0.doomsdayClockView then
		return
	end

	local var_22_0 = arg_22_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DoomsdayClock)

	arg_22_0.doomsdayClockView = arg_22_0:com_openSubView(FightDoomsdayClockView, "ui/viewres/fight/fightclockview.prefab", var_22_0)

	arg_22_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.DoomsdayClock)
end

function var_0_0._showBloodPool(arg_23_0)
	if FightDataHelper.getBloodPool(FightEnum.TeamType.MySide) then
		arg_23_0:_createBloodPool(FightEnum.TeamType.MySide)
	end
end

function var_0_0._createBloodPool(arg_24_0, arg_24_1)
	if arg_24_0.bloodPoolView then
		return
	end

	local var_24_0 = arg_24_0.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.BloodPool)

	arg_24_0.bloodPoolView = arg_24_0:com_openSubView(FightBloodPoolView, "ui/viewres/fight/fightbloodview.prefab", var_24_0, arg_24_1)

	arg_24_0.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.BloodPool)
end

function var_0_0._createSurvivalTalent(arg_25_0)
	if arg_25_0.survivalTalentView then
		return
	end

	local var_25_0 = arg_25_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.SurvivalTalent)

	arg_25_0.survivalTalentView = arg_25_0:com_openSubView(FightSurvivalTalentView, "ui/viewres/fight/fightsurvivaltalentview.prefab", var_25_0)

	arg_25_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.SurvivalTalent)
end

function var_0_0._showPlayerFinisherSkill(arg_26_0)
	local var_26_0 = FightDataHelper.fieldMgr.playerFinisherInfo

	if not var_26_0 then
		return
	end

	if var_26_0.type == FightPlayerFinisherInfoData.Type.SurvivalTalent then
		arg_26_0:_createSurvivalTalent()

		return
	end

	if var_26_0 and #var_26_0.skills > 0 then
		arg_26_0:_onRefreshPlayerFinisherSkill()
	end
end

function var_0_0._showCardDeckBtn(arg_27_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		arg_27_0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", arg_27_0._onBtnLoaded)
	end
end

function var_0_0.onDeckGenerate_Anim(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1 and #arg_28_1 or 0

	if var_28_0 <= 0 then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.goPaiList) do
		gohelper.setActive(iter_28_1, iter_28_0 <= var_28_0)
	end

	arg_28_0:showDeckActiveGo()
	arg_28_0.deckAnimatorPlayer:Play("generate", arg_28_0.hideDeckActiveGo, arg_28_0)
	AudioMgr.instance:trigger(20250502)
end

function var_0_0.onPlayGenerateAnimDone(arg_29_0)
	arg_29_0:hideDeckActiveGo()
	arg_29_0:com_sendFightEvent(FightEvent.CardDeckGenerateDone)
end

function var_0_0.onDeckDelete_Anim(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1 and #arg_30_1 or 0

	if var_30_0 <= 0 then
		return arg_30_0:onPlayDeleteAnimDone()
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.goPaiList) do
		gohelper.setActive(iter_30_1, iter_30_0 <= var_30_0)
	end

	arg_30_0:showDeckActiveGo()
	arg_30_0.deckAnimatorPlayer:Play("delete", arg_30_0.onPlayDeleteAnimAnchorDone, arg_30_0)
	AudioMgr.instance:trigger(20250503)
end

function var_0_0.onPlayDeleteAnimAnchorDone(arg_31_0)
	local var_31_0 = {
		dissolveScale = 1,
		dissolveSkillItemGOs = {
			arg_31_0.goDeckActive
		}
	}

	arg_31_0:clearFlow()

	arg_31_0.dissolveFlow = FlowSequence.New()

	arg_31_0.dissolveFlow:addWork(FightCardDissolveEffect.New())
	arg_31_0.dissolveFlow:registerDoneListener(arg_31_0.onPlayDeleteAnimDone, arg_31_0)
	arg_31_0.dissolveFlow:start(var_31_0)
end

function var_0_0.clearFlow(arg_32_0)
	if arg_32_0.dissolveFlow then
		arg_32_0.dissolveFlow:stop()

		arg_32_0.dissolveFlow = nil
	end
end

function var_0_0.onPlayDeleteAnimDone(arg_33_0)
	arg_33_0:hideDeckActiveGo()
	arg_33_0:com_sendFightEvent(FightEvent.CardDeckDeleteDone)
end

function var_0_0.hideDeckActiveGo(arg_34_0)
	gohelper.setActive(arg_34_0.goDeckActive, false)
end

function var_0_0.showDeckActiveGo(arg_35_0)
	gohelper.setActive(arg_35_0.goDeckActive, true)
end

var_0_0.MaxDeckAnimLen = 15

function var_0_0._onBtnLoaded(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1 then
		return
	end

	local var_36_0 = arg_36_2:GetResource()
	local var_36_1 = gohelper.clone(var_36_0, arg_36_0._topRightBtnRoot, "cardBox")

	arg_36_0.goDeckBtn = var_36_1

	arg_36_0:com_registClick(gohelper.getClickWithDefaultAudio(var_36_1), arg_36_0._onCardBoxClick, arg_36_0)
	gohelper.setAsFirstSibling(var_36_1)

	arg_36_0._deckCardAnimator = gohelper.onceAddComponent(var_36_1, typeof(UnityEngine.Animator))
	arg_36_0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(var_36_1)
	arg_36_0.txtNum = gohelper.findChildText(var_36_1, "txt_Num")

	gohelper.setActive(arg_36_0.txtNum.gameObject, false)

	local var_36_2 = gohelper.findChild(arg_36_0.goDeckBtn, "#go_Active")

	gohelper.setActive(var_36_2, false)

	arg_36_0.deckContainer = gohelper.findChild(arg_36_0.goDeckBtn, "#deckbtn")

	gohelper.setActive(arg_36_0.deckContainer, true)

	arg_36_0.deckAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_36_0.deckContainer)
	arg_36_0.goDeckActive = gohelper.findChild(arg_36_0.deckContainer, "active")

	arg_36_0:hideDeckActiveGo()

	arg_36_0.goPaiList = arg_36_0:newUserDataTable()

	for iter_36_0 = 1, var_0_0.MaxDeckAnimLen do
		local var_36_3 = gohelper.findChild(arg_36_0.goDeckActive, string.format("#pai%02d", iter_36_0))

		if not var_36_3 then
			logError("deck view not find pai , index : " .. iter_36_0)
		end

		table.insert(arg_36_0.goPaiList, var_36_3)
	end

	arg_36_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_36_0._onCardDeckGenerate)
	arg_36_0:com_registFightEvent(FightEvent.CardClear, arg_36_0._onCardClear)
	arg_36_0:com_registFightEvent(FightEvent.CardBoxNumChange, arg_36_0.onCardBoxNumChange)
	arg_36_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_36_0.onDeckGenerate_Anim)
	arg_36_0:com_registFightEvent(FightEvent.CardDeckDelete, arg_36_0.onDeckDelete_Anim)
end

function var_0_0.activeDeck(arg_37_0)
	local var_37_0 = FightDataHelper.fieldMgr

	if var_37_0 and var_37_0:isAct183() then
		local var_37_1 = gohelper.findChild(arg_37_0.goDeckBtn, "#go_Active")

		gohelper.setActive(var_37_1, true)
		gohelper.setActive(arg_37_0.txtNum.gameObject, true)
	end
end

function var_0_0.clearTweenId(arg_38_0)
	if arg_38_0.tweenId then
		ZProj.TweenHelper.KillById(arg_38_0.tweenId)

		arg_38_0.tweenId = nil
	end
end

var_0_0.DeckNumChangeDuration = 0.5

function var_0_0.onCardBoxNumChange(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:activeDeck()
	arg_39_0:clearTweenId()

	local var_39_0 = tonumber(arg_39_0.txtNum.text) or 0

	arg_39_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_39_0, arg_39_2, var_0_0.DeckNumChangeDuration, arg_39_0.directSetDeckNum, nil, arg_39_0)
end

function var_0_0.directSetDeckNum(arg_40_0, arg_40_1)
	arg_40_0.txtNum.text = math.ceil(arg_40_1)
end

function var_0_0.onNumChangeDone(arg_41_0)
	arg_41_0:directSetDeckNum(FightDataHelper.fieldMgr.deckNum)
end

function var_0_0._onCardBoxClick(arg_42_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function var_0_0._showSeasonTalentBtn(arg_43_0)
	if not Season166Model.instance:getBattleContext(true) then
		return
	end

	if Season166Model.instance:checkCanShowSeasonTalent() then
		arg_43_0:com_loadAsset("ui/viewres/fight/fightseasontalentbtn.prefab", arg_43_0._onBtnSeasonTalentLoaded)
	end
end

function var_0_0._onBtnSeasonTalentLoaded(arg_44_0, arg_44_1, arg_44_2)
	if not arg_44_1 then
		return
	end

	local var_44_0 = arg_44_2:GetResource()
	local var_44_1 = gohelper.clone(var_44_0, arg_44_0._topRightBtnRoot, "fightseasontalentbtn")

	arg_44_0:com_registClick(gohelper.getClickWithDefaultAudio(var_44_1), arg_44_0._onSeasonTalentClick, arg_44_0)
	gohelper.setAsFirstSibling(var_44_1)
end

function var_0_0._onSeasonTalentClick(arg_45_0)
	Season166Controller.instance:openTalentInfoView()
end

function var_0_0._deckAniFinish(arg_46_0)
	arg_46_0._deckCardAnimator.enabled = true

	arg_46_0._deckCardAnimator:Play("idle")
end

function var_0_0._onCardDeckGenerate(arg_47_0)
	arg_47_0._deckBtnAniPlayer:Play("add", arg_47_0._deckAniFinish, arg_47_0)
end

function var_0_0._onCardClear(arg_48_0)
	arg_48_0._deckBtnAniPlayer:Play("delete", arg_48_0._deckAniFinish, arg_48_0)
end

function var_0_0._showTaskPart(arg_49_0)
	local var_49_0 = FightDataHelper.fieldMgr.episodeId

	if FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.Act183) then
		local var_49_1 = lua_challenge_episode.configDict[var_49_0]

		if not var_49_1 then
			return
		end

		if string.nilorempty(var_49_1.condition) then
			return
		end

		gohelper.setActive(arg_49_0._taskRoot, true)
		arg_49_0:com_openSubView(Fight183TaskView, "ui/viewres/fight/fighttaskview.prefab", arg_49_0._taskRoot, var_49_1.condition)
	end
end

function var_0_0.showBattleId_9290103_Task(arg_50_0)
	if FightDataHelper.fieldMgr.battleId == 9290103 then
		gohelper.setActive(arg_50_0._taskRoot, true)
		arg_50_0:com_openSubView(FightBattleId_9290103TaskView, "ui/viewres/fight/fighttaskview.prefab", arg_50_0._taskRoot)
	end
end

function var_0_0.onClose(arg_51_0)
	return
end

function var_0_0.onDestroyView(arg_52_0)
	arg_52_0:clearFlow()
	arg_52_0:clearTweenId()
end

return var_0_0
