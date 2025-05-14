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
	arg_2_0:com_registMsg(FightMsgId.FightProgressValueChange, arg_2_0._showFightProgress)
	arg_2_0:com_registMsg(FightMsgId.FightMaxProgressValueChange, arg_2_0._showFightProgress)
	arg_2_0:com_registMsg(FightMsgId.ShowDouQuQuXianHouShou, arg_2_0._onShowDouQuQuXianHouShou)
	arg_2_0:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, arg_2_0._onRefreshPlayerFinisherSkill)
	arg_2_0:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, arg_2_0._onRefreshSimplePolarizationLevel)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._showSimplePolarizationLevel(arg_4_0)
	local var_4_0 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_1 = iter_4_1:getBuffList()

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			if iter_4_3.buffId == 6240501 then
				arg_4_0:_onRefreshSimplePolarizationLevel()

				return
			end
		end
	end
end

function var_0_0._onBuffUpdate(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_3 == 6240501 then
		arg_5_0:_onRefreshSimplePolarizationLevel()
	end
end

function var_0_0._onRefreshSimplePolarizationLevel(arg_6_0)
	if arg_6_0._simplePolarizationLevel then
		return
	end

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "root/melody/level")

	arg_6_0._simplePolarizationLevel = arg_6_0:com_openSubView(FightSimplePolarizationLevelView, "ui/viewres/fight/fightsimplepolarizationlevelview.prefab", var_6_0)
end

function var_0_0._onRefreshPlayerFinisherSkill(arg_7_0)
	if arg_7_0._playerFinisherSkill then
		return
	end

	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "root/melody/skill")

	arg_7_0._playerFinisherSkill = arg_7_0:com_openSubView(FightPlayerFinisherSkillView, "ui/viewres/fight/fightplayerfinisherskillview.prefab", var_7_0)
end

function var_0_0._onShowDouQuQuXianHouShou(arg_8_0, arg_8_1)
	arg_8_0:com_openSubView(FightAct174StartFirstView, "ui/viewres/fight/fight_act174startfirstview.prefab", arg_8_0.viewGO, arg_8_1)
end

function var_0_0._onBeforeEnterStepBehaviour(arg_9_0)
	if FightModel.instance:isSeason2() then
		gohelper.setActive(arg_9_0._fightSeasonChangeHero, true)
		arg_9_0:com_openSubView(FightSeasonChangeHeroView, arg_9_0._fightSeasonChangeHero)
	end

	arg_9_0:_showTopLeft()
end

function var_0_0._showTopLeft(arg_10_0)
	arg_10_0:_showFightProgress()
end

function var_0_0._showFightProgress(arg_11_0)
	if FightDataHelper.fieldMgr.progressMax > 0 then
		if arg_11_0._progressView then
			return
		end

		gohelper.setActive(arg_11_0._progressRoot, true)

		local var_11_0 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId] == 1 and "ui/viewres/fight/commonalityslider1.prefab" or "ui/viewres/fight/commonalityslider.prefab"

		arg_11_0._progressView = arg_11_0:com_openSubView(FightCommonalitySlider, var_11_0, arg_11_0._progressRoot)
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_showCardDeckBtn()
	arg_12_0:_showSeasonTalentBtn()
	arg_12_0:_showPlayerFinisherSkill()
	arg_12_0:_showSimplePolarizationLevel()
	arg_12_0:_showTaskPart()
end

function var_0_0._showPlayerFinisherSkill(arg_13_0)
	local var_13_0 = FightDataHelper.fieldMgr.playerFinisherInfo

	if var_13_0 and #var_13_0.skills > 0 then
		arg_13_0:_onRefreshPlayerFinisherSkill()
	end
end

function var_0_0._showCardDeckBtn(arg_14_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		arg_14_0:com_loadAsset("ui/viewres/fight/fightcarddeckbtnview.prefab", arg_14_0._onBtnLoaded)
	end
end

function var_0_0.onDeckGenerate_Anim(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and #arg_15_1 or 0

	if var_15_0 <= 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.goPaiList) do
		gohelper.setActive(iter_15_1, iter_15_0 <= var_15_0)
	end

	arg_15_0:showDeckActiveGo()
	arg_15_0.deckAnimatorPlayer:Play("generate", arg_15_0.hideDeckActiveGo, arg_15_0)
	AudioMgr.instance:trigger(20250502)
end

function var_0_0.onPlayGenerateAnimDone(arg_16_0)
	arg_16_0:hideDeckActiveGo()
	arg_16_0:com_sendFightEvent(FightEvent.CardDeckGenerateDone)
end

function var_0_0.onDeckDelete_Anim(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 and #arg_17_1 or 0

	if var_17_0 <= 0 then
		return arg_17_0:onPlayDeleteAnimDone()
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.goPaiList) do
		gohelper.setActive(iter_17_1, iter_17_0 <= var_17_0)
	end

	arg_17_0:showDeckActiveGo()
	arg_17_0.deckAnimatorPlayer:Play("delete", arg_17_0.onPlayDeleteAnimAnchorDone, arg_17_0)
	AudioMgr.instance:trigger(20250503)
end

function var_0_0.onPlayDeleteAnimAnchorDone(arg_18_0)
	local var_18_0 = {
		dissolveScale = 1,
		dissolveSkillItemGOs = {
			arg_18_0.goDeckActive
		}
	}

	arg_18_0:clearFlow()

	arg_18_0.dissolveFlow = FlowSequence.New()

	arg_18_0.dissolveFlow:addWork(FightCardDissolveEffect.New())
	arg_18_0.dissolveFlow:registerDoneListener(arg_18_0.onPlayDeleteAnimDone, arg_18_0)
	arg_18_0.dissolveFlow:start(var_18_0)
end

function var_0_0.clearFlow(arg_19_0)
	if arg_19_0.dissolveFlow then
		arg_19_0.dissolveFlow:stop()

		arg_19_0.dissolveFlow = nil
	end
end

function var_0_0.onPlayDeleteAnimDone(arg_20_0)
	arg_20_0:hideDeckActiveGo()
	arg_20_0:com_sendFightEvent(FightEvent.CardDeckDeleteDone)
end

function var_0_0.hideDeckActiveGo(arg_21_0)
	gohelper.setActive(arg_21_0.goDeckActive, false)
end

function var_0_0.showDeckActiveGo(arg_22_0)
	gohelper.setActive(arg_22_0.goDeckActive, true)
end

var_0_0.MaxDeckAnimLen = 15

function var_0_0._onBtnLoaded(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 then
		return
	end

	local var_23_0 = arg_23_2:GetResource()
	local var_23_1 = gohelper.clone(var_23_0, arg_23_0._topRightBtnRoot, "cardBox")

	arg_23_0.goDeckBtn = var_23_1

	arg_23_0:com_registClick(gohelper.getClickWithDefaultAudio(var_23_1), arg_23_0._onCardBoxClick, arg_23_0)
	gohelper.setAsFirstSibling(var_23_1)

	arg_23_0._deckCardAnimator = gohelper.onceAddComponent(var_23_1, typeof(UnityEngine.Animator))
	arg_23_0._deckBtnAniPlayer = SLFramework.AnimatorPlayer.Get(var_23_1)
	arg_23_0.txtNum = gohelper.findChildText(var_23_1, "txt_Num")

	gohelper.setActive(arg_23_0.txtNum.gameObject, false)

	local var_23_2 = gohelper.findChild(arg_23_0.goDeckBtn, "#go_Active")

	gohelper.setActive(var_23_2, false)

	arg_23_0.deckContainer = gohelper.findChild(arg_23_0.goDeckBtn, "#deckbtn")

	gohelper.setActive(arg_23_0.deckContainer, true)

	arg_23_0.deckAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_23_0.deckContainer)
	arg_23_0.goDeckActive = gohelper.findChild(arg_23_0.deckContainer, "active")

	arg_23_0:hideDeckActiveGo()

	arg_23_0.goPaiList = arg_23_0:newUserDataTable()

	for iter_23_0 = 1, var_0_0.MaxDeckAnimLen do
		local var_23_3 = gohelper.findChild(arg_23_0.goDeckActive, string.format("#pai%02d", iter_23_0))

		if not var_23_3 then
			logError("deck view not find pai , index : " .. iter_23_0)
		end

		table.insert(arg_23_0.goPaiList, var_23_3)
	end

	arg_23_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_23_0._onCardDeckGenerate)
	arg_23_0:com_registFightEvent(FightEvent.CardClear, arg_23_0._onCardClear)
	arg_23_0:com_registFightEvent(FightEvent.CardBoxNumChange, arg_23_0.onCardBoxNumChange)
	arg_23_0:com_registFightEvent(FightEvent.CardDeckGenerate, arg_23_0.onDeckGenerate_Anim)
	arg_23_0:com_registFightEvent(FightEvent.CardDeckDelete, arg_23_0.onDeckDelete_Anim)
end

function var_0_0.activeDeck(arg_24_0)
	local var_24_0 = FightDataHelper.fieldMgr

	if var_24_0 and var_24_0:isAct183() then
		local var_24_1 = gohelper.findChild(arg_24_0.goDeckBtn, "#go_Active")

		gohelper.setActive(var_24_1, true)
		gohelper.setActive(arg_24_0.txtNum.gameObject, true)
	end
end

function var_0_0.clearTweenId(arg_25_0)
	if arg_25_0.tweenId then
		ZProj.TweenHelper.KillById(arg_25_0.tweenId)

		arg_25_0.tweenId = nil
	end
end

var_0_0.DeckNumChangeDuration = 0.5

function var_0_0.onCardBoxNumChange(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:activeDeck()
	arg_26_0:clearTweenId()

	local var_26_0 = tonumber(arg_26_0.txtNum.text) or 0

	arg_26_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_26_0, arg_26_2, var_0_0.DeckNumChangeDuration, arg_26_0.directSetDeckNum, nil, arg_26_0)
end

function var_0_0.directSetDeckNum(arg_27_0, arg_27_1)
	arg_27_0.txtNum.text = math.ceil(arg_27_1)
end

function var_0_0.onNumChangeDone(arg_28_0)
	arg_28_0:directSetDeckNum(FightDataHelper.fieldMgr.deckNum)
end

function var_0_0._onCardBoxClick(arg_29_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.CardBox
	})
end

function var_0_0._showSeasonTalentBtn(arg_30_0)
	if not Season166Model.instance:getBattleContext(true) then
		return
	end

	if Season166Model.instance:checkCanShowSeasonTalent() then
		arg_30_0:com_loadAsset("ui/viewres/fight/fightseasontalentbtn.prefab", arg_30_0._onBtnSeasonTalentLoaded)
	end
end

function var_0_0._onBtnSeasonTalentLoaded(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_1 then
		return
	end

	local var_31_0 = arg_31_2:GetResource()
	local var_31_1 = gohelper.clone(var_31_0, arg_31_0._topRightBtnRoot, "fightseasontalentbtn")

	arg_31_0:com_registClick(gohelper.getClickWithDefaultAudio(var_31_1), arg_31_0._onSeasonTalentClick, arg_31_0)
	gohelper.setAsFirstSibling(var_31_1)
end

function var_0_0._onSeasonTalentClick(arg_32_0)
	Season166Controller.instance:openTalentInfoView()
end

function var_0_0._deckAniFinish(arg_33_0)
	arg_33_0._deckCardAnimator.enabled = true

	arg_33_0._deckCardAnimator:Play("idle")
end

function var_0_0._onCardDeckGenerate(arg_34_0)
	arg_34_0._deckBtnAniPlayer:Play("add", arg_34_0._deckAniFinish, arg_34_0)
end

function var_0_0._onCardClear(arg_35_0)
	arg_35_0._deckBtnAniPlayer:Play("delete", arg_35_0._deckAniFinish, arg_35_0)
end

function var_0_0._showTaskPart(arg_36_0)
	local var_36_0 = FightDataHelper.fieldMgr.episodeId

	if FightDataHelper.fieldMgr:isDungeonType(DungeonEnum.EpisodeType.Act183) then
		local var_36_1 = lua_challenge_episode.configDict[var_36_0]

		if not var_36_1 then
			return
		end

		if string.nilorempty(var_36_1.condition) then
			return
		end

		arg_36_0:com_openSubView(Fight183TaskView, "ui/viewres/fight/fighttaskview.prefab", arg_36_0._taskRoot, var_36_1.condition)
	end
end

function var_0_0.onClose(arg_37_0)
	return
end

function var_0_0.onDestroyView(arg_38_0)
	arg_38_0:clearFlow()
	arg_38_0:clearTweenId()
end

return var_0_0
