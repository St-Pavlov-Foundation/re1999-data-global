module("modules.logic.fight.view.FightViewPartVisible", package.seeall)

local var_0_0 = class("FightViewPartVisible", BaseView)
local var_0_1 = false
local var_0_2 = false
local var_0_3 = false
local var_0_4 = false
local var_0_5 = false

function var_0_0.setWaitAreaActive(arg_1_0)
	var_0_5 = arg_1_0

	FightController.instance:dispatchEvent(FightEvent.UpdateUIPartVisible)
end

function var_0_0.set(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_1 = arg_2_0
	var_0_2 = arg_2_1
	var_0_3 = arg_2_2
	var_0_4 = arg_2_3
	var_0_5 = arg_2_4

	FightController.instance:dispatchEvent(FightEvent.UpdateUIPartVisible)
end

function var_0_0.setPlayStatus(arg_3_0, arg_3_1)
	var_0_4 = arg_3_0

	if FightModel.instance:getVersion() >= 1 then
		return
	end

	var_0_5 = arg_3_1
end

function var_0_0.setWaitingStatus(arg_4_0)
	var_0_5 = arg_4_0
end

function var_0_0.onInitView(arg_5_0)
	arg_5_0._clothSkillGO = gohelper.findChild(arg_5_0.viewGO, "root/heroSkill")
	arg_5_0._handCardGO = gohelper.findChild(arg_5_0.viewGO, "root/handcards")
	arg_5_0._handCardInnerGO = gohelper.findChild(arg_5_0.viewGO, "root/handcards/handcards")
	arg_5_0._playCardGO = gohelper.findChild(arg_5_0.viewGO, "root/playcards")
	arg_5_0._enemyRoundGO = gohelper.findChild(arg_5_0.viewGO, "root/enemyRound")
	arg_5_0._enemyRoundTextGO = gohelper.findChild(arg_5_0.viewGO, "root/enemyRoundText")
	arg_5_0._waitingAreaGO = gohelper.findChild(arg_5_0.viewGO, "root/waitingArea")
	arg_5_0._rogueSkillRoot = gohelper.findChild(arg_5_0.viewGO, "root/rogueSkillRoot")
	var_0_1 = false
	var_0_2 = false
	var_0_3 = false
	var_0_4 = false
	var_0_5 = false
	arg_5_0._play_card_origin_x, arg_5_0._play_card_origin_y = recthelper.getAnchor(arg_5_0._playCardGO.transform)
end

function var_0_0.addEvents(arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.UpdateUIPartVisible, arg_6_0._updateUI, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_6_0.onCameraFocusChanged, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnUniversalAppear, arg_6_0._tweenHandCardContainerScale, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_6_0._onPlayHandCard, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_6_0._tweenHandCardContainerScale, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnClothSkillExpand, arg_6_0._onClothSkillExpand, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnClothSkillShrink, arg_6_0._onClothSkillShrink, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnCombineOneCard, arg_6_0._onCombineOneCard, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_6_0._onClothSkillShrink, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_6_0._onClothSkillShrink, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.SetPlayCardPartOutScreen, arg_6_0._onSetPlayCardPartOutScreen, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.SetPlayCardPartOriginPos, arg_6_0._onSetPlayCardPartOriginPos, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_6_0._updateUI, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.SetHandCardVisible, arg_6_0._onSetHandCardVisible, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.CancelVisibleViewScaleTween, arg_6_0._onCancelVisibleViewScaleTween, arg_6_0)
end

function var_0_0.removeEvents(arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.UpdateUIPartVisible, arg_7_0._updateUI, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_7_0.onCameraFocusChanged, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnUniversalAppear, arg_7_0._tweenHandCardContainerScale, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_7_0._onPlayHandCard, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnResetCard, arg_7_0._tweenHandCardContainerScale, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnClothSkillExpand, arg_7_0._onClothSkillExpand, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnClothSkillShrink, arg_7_0._onClothSkillShrink, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnCombineOneCard, arg_7_0._onCombineOneCard, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_7_0._onClothSkillShrink, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_7_0._onClothSkillShrink, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.SetPlayCardPartOutScreen, arg_7_0._onSetPlayCardPartOutScreen, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.SetPlayCardPartOriginPos, arg_7_0._onSetPlayCardPartOriginPos, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_7_0._updateUI, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.SetHandCardVisible, arg_7_0._onSetHandCardVisible, arg_7_0)
	arg_7_0:removeEventCb(FightController.instance, FightEvent.CancelVisibleViewScaleTween, arg_7_0._onCancelVisibleViewScaleTween, arg_7_0)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_updateUI()

	arg_8_0._clothSkillExpand = false

	arg_8_0:_tweenHandCardContainerScale()
end

function var_0_0._onClothSkillExpand(arg_9_0)
	arg_9_0._clothSkillExpand = true

	arg_9_0:_tweenHandCardContainerScale()
end

function var_0_0._onClothSkillShrink(arg_10_0)
	arg_10_0._clothSkillExpand = false

	arg_10_0:_tweenHandCardContainerScale()
end

function var_0_0._onCombineOneCard(arg_11_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		arg_11_0:_onClothSkillShrink()
	end
end

function var_0_0._onPlayHandCard(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 then
		return
	end

	arg_12_0:_tweenHandCardContainerScale()
end

function var_0_0._tweenHandCardContainerScale(arg_13_0)
	local var_13_0 = FightWorkEffectDistributeCard.getHandCardScaleTime()
	local var_13_1 = FightCardDataHelper.getHandCardContainerScale(arg_13_0._clothSkillExpand)

	arg_13_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_13_0._handCardGO.transform, var_13_1, var_13_1, var_13_1, var_13_0)
end

function var_0_0._onCancelVisibleViewScaleTween(arg_14_0)
	if arg_14_0._scaleTweenId then
		ZProj.TweenHelper.KillById(arg_14_0._scaleTweenId)

		arg_14_0._scaleTweenId = nil
	end
end

function var_0_0._updateUI(arg_15_0)
	local var_15_0 = gohelper.onceAddComponent(arg_15_0._playCardGO, typeof(UnityEngine.CanvasGroup))
	local var_15_1 = arg_15_0._playCardGO.activeInHierarchy and var_15_0.alpha > 0.9

	if not var_15_1 and var_0_3 then
		if GMFightShowState.cards then
			ZProj.TweenHelper.KillByObj(var_15_0)
			ZProj.TweenHelper.DOFadeCanvasGroup(arg_15_0._playCardGO, 0, 1, 0.165)
		end
	elseif var_15_1 and not var_0_3 then
		ZProj.TweenHelper.KillByObj(var_15_0)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_15_0._playCardGO, 1, 0, 0.165)
	end

	local var_15_2 = PlayerClothModel.instance:getSpEpisodeClothID() or OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) and FightModel.instance.clothId > 0

	gohelper.setActive(arg_15_0._clothSkillGO, var_0_1 and var_15_2 and GMFightShowState.clothSkill)

	local var_15_3 = var_0_1 and var_15_2 and GMFightShowState.clothSkill

	if var_15_3 then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowRougeSkill)
	end

	gohelper.setActive(arg_15_0._rogueSkillRoot, var_15_3)
	gohelper.setActive(arg_15_0._handCardGO, var_0_2)
	gohelper.setActive(arg_15_0._playCardGO, var_0_3)
	gohelper.setActive(arg_15_0._enemyRoundGO, var_0_4 and GMFightShowState.bottomEnemyRound)
	gohelper.setActive(arg_15_0._enemyRoundTextGO, var_0_4 and GMFightShowState.bottomEnemyRound)
	gohelper.setActive(arg_15_0._waitingAreaGO, var_0_5 and GMFightShowState.cards)
	arg_15_0:setActiveCanvasGroup(arg_15_0._handCardInnerGO, GMFightShowState.cards)
	arg_15_0:setActiveCanvasGroup(arg_15_0._playCardGO, GMFightShowState.cards)
	arg_15_0:setActiveCanvasGroup(arg_15_0._waitingAreaGO, GMFightShowState.cards)
end

function var_0_0.setActiveCanvasGroup(arg_16_0, arg_16_1, arg_16_2)
	gohelper.onceAddComponent(arg_16_1, gohelper.Type_CanvasGroup).alpha = arg_16_2 and 1 or 0
end

function var_0_0.onCameraFocusChanged(arg_17_0, arg_17_1)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or FightModel.instance:getCurStage() == FightEnum.Stage.ClothSkill then
		arg_17_0:setActiveCanvasGroup(arg_17_0._playCardGO, not arg_17_1)
		gohelper.setActive(arg_17_0._handCardGO, not arg_17_1)
		gohelper.setActiveCanvasGroup(FightNameMgr.instance:getNameParent(), not arg_17_1)
	end
end

function var_0_0._onSetPlayCardPartOutScreen(arg_18_0)
	recthelper.setAnchor(arg_18_0._playCardGO.transform, 10000, 10000)
end

function var_0_0._onSetPlayCardPartOriginPos(arg_19_0)
	recthelper.setAnchor(arg_19_0._playCardGO.transform, arg_19_0._play_card_origin_x, arg_19_0._play_card_origin_y)
end

function var_0_0._onSetHandCardVisible(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		gohelper.setActive(arg_20_0._waitingAreaGO, var_0_5)
		gohelper.setActive(arg_20_0._handCardGO, var_0_2)
	else
		gohelper.setActive(arg_20_0._waitingAreaGO, false)
		gohelper.setActive(arg_20_0._handCardGO, arg_20_1)
	end
end

return var_0_0
