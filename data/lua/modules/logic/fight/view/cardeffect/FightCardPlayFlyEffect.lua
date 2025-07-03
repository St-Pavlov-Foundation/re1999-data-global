module("modules.logic.fight.view.cardeffect.FightCardPlayFlyEffect", package.seeall)

local var_0_0 = class("FightCardPlayFlyEffect", UserDataDispose)
local var_0_1 = 1
local var_0_2 = 0.9
local var_0_3 = 0.9
local var_0_4 = Vector2.New(0.5, 0.5)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	local var_1_0 = 0.033 * var_0_1

	arg_1_0._fly_speed = 1 / var_0_2 * FightModel.instance:getUISpeed() * 2
	arg_1_0._dt = var_1_0 * var_0_3 / FightModel.instance:getUISpeed()
	arg_1_0._parent_view = arg_1_1
	arg_1_0._card_mo = arg_1_2
	arg_1_0._show_index = arg_1_1:getShowIndex(arg_1_4)
	arg_1_0._card_obj = arg_1_3
	arg_1_0._fightBeginRoundOp = arg_1_4
	arg_1_0._card_transform = arg_1_3.transform
	arg_1_0._fight_view_obj = arg_1_0._parent_view.viewGO
	arg_1_0.playcardTransform = gohelper.findChild(arg_1_0._fight_view_obj, "root/playcards").transform

	local var_1_1 = gohelper.onceAddComponent(arg_1_0._card_obj, gohelper.Type_CanvasGroup)

	var_1_1.interactable = false
	var_1_1.blocksRaycasts = false

	arg_1_0._card_transform:SetParent(arg_1_0.playcardTransform, true)

	arg_1_0._card_transform.anchorMin = var_0_4
	arg_1_0._card_transform.anchorMax = var_0_4

	local var_1_2 = recthelper.getWidth(arg_1_0.playcardTransform) / 2

	recthelper.setAnchorX(arg_1_0._card_transform, recthelper.getAnchorX(arg_1_0._card_transform) + var_1_2)
end

function var_0_0._delayDone(arg_2_0)
	logError("出牌的飞行流程超过了10秒,可能卡住了,先强制结束")
	arg_2_0:_onPlayFlyCardDone()
end

function var_0_0._startFly(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 10 / FightModel.instance:getUISpeed())

	arg_3_0._main_flow = arg_3_0:_buildAniFlow_2_1()

	arg_3_0._main_flow:registerDoneListener(arg_3_0._onFlowDone, arg_3_0)
	arg_3_0._main_flow:start()
end

function var_0_0._onFlowDone(arg_4_0)
	arg_4_0:_onPlayFlyCardDone()
end

function var_0_0._onPlayFlyCardDone(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, arg_5_0._fightBeginRoundOp)
	arg_5_0:releaseSelf()
	arg_5_0._parent_view:onFlyDone(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.PlayCardFlayFinish, arg_5_0._fightBeginRoundOp)
end

function var_0_0._buildAniFlow_2_1(arg_6_0)
	local var_6_0 = FlowSequence.New()
	local var_6_1, var_6_2 = recthelper.getAnchor(arg_6_0._card_transform)
	local var_6_3, var_6_4 = arg_6_0:_getPlayTargetPos()
	local var_6_5 = Vector3.New(var_6_3 - var_6_1, var_6_4 - var_6_2, 0)
	local var_6_6 = Quaternion.FromToRotation(Vector3.up, var_6_5).eulerAngles.z

	if var_6_6 > 180 then
		var_6_6 = var_6_6 - 360
	end

	local var_6_7 = Mathf.Clamp(var_6_6, -25, 25)
	local var_6_8 = 2

	var_6_0:addWork(TweenWork.New({
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = arg_6_0._card_transform,
		toz = var_6_7,
		t = arg_6_0._dt * var_6_8,
		ease = EaseType.linear
	}))

	local var_6_9 = FlowParallel.New()
	local var_6_10 = Mathf.Sqrt(Mathf.Pow(var_6_1 - var_6_3, 2) + Mathf.Pow(var_6_2 - var_6_4, 2)) / 2500 / arg_6_0._fly_speed
	local var_6_11 = 0
	local var_6_12 = 21

	var_6_9:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tr = arg_6_0._card_transform,
		tox = var_6_3 + var_6_11,
		toy = var_6_4 + var_6_12,
		t = var_6_10,
		ease = EaseType.OutQuart
	}))

	local var_6_13 = 1.14
	local var_6_14 = 0.72

	var_6_9:addWork(TweenWork.New({
		type = "DOScale",
		tr = arg_6_0._card_transform,
		from = var_6_13,
		to = var_6_14,
		t = var_6_10,
		ease = EaseType.Linear
	}))

	local var_6_15 = FlowSequence.New()

	var_6_15:addWork(WorkWaitSeconds.New(var_6_10 / 2))
	var_6_15:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = arg_6_0._card_transform,
		t = var_6_10 / 2,
		ease = EaseType.OutCubic
	}))
	var_6_9:addWork(var_6_15)
	var_6_0:addWork(var_6_9)

	local var_6_16 = FlowParallel.New()
	local var_6_17 = FlowSequence.New()
	local var_6_18 = 0.5
	local var_6_19 = 3

	var_6_17:addWork(TweenWork.New({
		type = "DOScale",
		tr = arg_6_0._card_transform,
		to = var_6_18,
		t = var_6_19 * arg_6_0._dt,
		ease = EaseType.Linear
	}))

	local var_6_20 = 0.623
	local var_6_21 = 3

	var_6_17:addWork(TweenWork.New({
		type = "DOScale",
		tr = arg_6_0._card_transform,
		to = var_6_20,
		t = var_6_21 * arg_6_0._dt,
		ease = EaseType.Linear
	}))
	var_6_16:addWork(var_6_17)

	local var_6_22 = FlowSequence.New()

	var_6_22:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.OnPlayHandCard, arg_6_0._card_mo, arg_6_0._waitRemoveCard)

		if GMFightShowState.cards then
			local var_7_0 = FightDataHelper.entityMgr:getById(arg_6_0._card_mo.uid)
			local var_7_1 = FightCardDataHelper.isBigSkill(arg_6_0._card_mo.skillId)
			local var_7_2 = FightConfig.instance:getSkillLv(arg_6_0._card_mo.skillId)
			local var_7_3 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_01)
			local var_7_4 = FightHelper.getPreloadAssetItem(var_7_3)

			gohelper.clone(var_7_4:GetResource(var_7_3), arg_6_0._card_transform.gameObject)

			if var_7_2 < FightEnum.UniqueSkillCardLv then
				local var_7_5 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02)
				local var_7_6 = FightHelper.getPreloadAssetItem(var_7_5)

				gohelper.clone(var_7_6:GetResource(var_7_5), arg_6_0._card_transform.gameObject)
			else
				local var_7_7 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03)
				local var_7_8 = FightHelper.getPreloadAssetItem(var_7_7)

				gohelper.clone(var_7_8:GetResource(var_7_7), arg_6_0._card_transform.gameObject)
			end

			FightController.instance:dispatchEvent(FightEvent.ShowPlayCardEffect, arg_6_0._card_mo, arg_6_0._show_index)
		end
	end))
	var_6_16:addWork(var_6_22)
	var_6_0:addWork(var_6_16)
	var_6_0:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getUISpeed()))

	return var_6_0
end

function var_0_0._getPlayTargetPos(arg_8_0)
	local var_8_0 = FightViewPlayCard.getMaxItemCount()
	local var_8_1 = arg_8_0._parent_view._playCardItemTransform
	local var_8_2 = recthelper.getAnchorX(var_8_1)
	local var_8_3 = FightViewPlayCard.calContentPosX(arg_8_0._show_index, var_8_0, recthelper.getAnchorX(arg_8_0._parent_view._playCardItemTransform))
	local var_8_4, var_8_5 = FightViewPlayCard.calcCardPosX(arg_8_0._show_index, var_8_0)
	local var_8_6 = var_8_4 + var_8_3
	local var_8_7 = var_8_5 + recthelper.getAnchorY(var_8_1) - 21

	return var_8_6, var_8_7
end

function var_0_0._destroyCloneCard(arg_9_0)
	gohelper.destroy(arg_9_0._card_obj)
end

function var_0_0.releaseSelf(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayDone, arg_10_0)

	if arg_10_0._main_flow then
		arg_10_0._main_flow:unregisterDoneListener(arg_10_0._onFlowDone, arg_10_0)
		arg_10_0._main_flow:stop()

		arg_10_0._main_flow = nil
	end

	arg_10_0:_destroyCloneCard()
	arg_10_0:__onDispose()
end

return var_0_0
