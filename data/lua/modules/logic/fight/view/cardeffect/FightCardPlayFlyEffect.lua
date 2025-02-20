module("modules.logic.fight.view.cardeffect.FightCardPlayFlyEffect", package.seeall)

slot0 = class("FightCardPlayFlyEffect", UserDataDispose)
slot1 = 1
slot2 = 0.9
slot3 = 0.9
slot4 = Vector2.New(0.5, 0.5)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fly_speed = 1 / uv1 * FightModel.instance:getUISpeed() * 2
	slot0._dt = 0.033 * uv0 * uv2 / FightModel.instance:getUISpeed()
	slot0._parent_view = slot1
	slot0._card_mo = slot2
	slot0._show_index = slot1:getShowIndex(slot4)
	slot0._card_obj = slot3
	slot0._fightBeginRoundOp = slot4
	slot0._card_transform = slot3.transform
	slot0._fight_view_obj = slot0._parent_view.viewGO
	slot0.playcardTransform = gohelper.findChild(slot0._fight_view_obj, "root/playcards").transform
	slot6 = gohelper.onceAddComponent(slot0._card_obj, gohelper.Type_CanvasGroup)
	slot6.interactable = false
	slot6.blocksRaycasts = false

	slot0._card_transform:SetParent(slot0.playcardTransform, true)

	slot0._card_transform.anchorMin = uv3
	slot0._card_transform.anchorMax = uv3

	recthelper.setAnchorX(slot0._card_transform, recthelper.getAnchorX(slot0._card_transform) + recthelper.getWidth(slot0.playcardTransform) / 2)
end

function slot0._delayDone(slot0)
	logError("出牌的飞行流程超过了10秒,可能卡住了,先强制结束")
	slot0:_onPlayFlyCardDone()
end

function slot0._startFly(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10 / FightModel.instance:getUISpeed())

	slot0._main_flow = slot0:_buildAniFlow_2_1()

	slot0._main_flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0._main_flow:start()
end

function slot0._onFlowDone(slot0)
	slot0:_onPlayFlyCardDone()
end

function slot0._onPlayFlyCardDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot0._fightBeginRoundOp)
	slot0:releaseSelf()
	slot0._parent_view:onFlyDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.PlayCardFlayFinish, slot0._fightBeginRoundOp)
end

function slot0._buildAniFlow_2_1(slot0)
	slot1 = FlowSequence.New()
	slot2, slot3 = recthelper.getAnchor(slot0._card_transform)
	slot4, slot5 = slot0:_getPlayTargetPos()

	if Quaternion.FromToRotation(Vector3.up, Vector3.New(slot4 - slot2, slot5 - slot3, 0)).eulerAngles.z > 180 then
		slot7 = slot7 - 360
	end

	slot1:addWork(TweenWork.New({
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot0._card_transform,
		toz = Mathf.Clamp(slot7, -25, 25),
		t = slot0._dt * 2,
		ease = EaseType.linear
	}))

	slot9 = FlowParallel.New()
	slot12 = Mathf.Sqrt(Mathf.Pow(slot2 - slot4, 2) + Mathf.Pow(slot3 - slot5, 2)) / 2500 / slot0._fly_speed

	slot9:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tr = slot0._card_transform,
		tox = slot4 + 0,
		toy = slot5 + 21,
		t = slot12,
		ease = EaseType.OutQuart
	}))
	slot9:addWork(TweenWork.New({
		type = "DOScale",
		tr = slot0._card_transform,
		from = 1.14,
		to = 0.72,
		t = slot12,
		ease = EaseType.Linear
	}))

	slot17 = FlowSequence.New()

	slot17:addWork(WorkWaitSeconds.New(slot12 / 2))
	slot17:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot0._card_transform,
		t = slot12 / 2,
		ease = EaseType.OutCubic
	}))
	slot9:addWork(slot17)
	slot1:addWork(slot9)

	slot18 = FlowParallel.New()
	slot19 = FlowSequence.New()

	slot19:addWork(TweenWork.New({
		type = "DOScale",
		tr = slot0._card_transform,
		to = 0.5,
		t = 3 * slot0._dt,
		ease = EaseType.Linear
	}))
	slot19:addWork(TweenWork.New({
		type = "DOScale",
		tr = slot0._card_transform,
		to = 0.623,
		t = 3 * slot0._dt,
		ease = EaseType.Linear
	}))
	slot18:addWork(slot19)

	slot24 = FlowSequence.New()

	slot24:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.OnPlayHandCard, uv0._card_mo, uv0._waitRemoveCard)

		if GMFightShowState.cards then
			slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_01)

			gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), uv0._card_transform.gameObject)

			if not (FightDataHelper.entityMgr:getById(uv0._card_mo.uid) and FightCardModel.instance:isUniqueSkill(slot0.id, uv0._card_mo.skillId)) then
				slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02)

				gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), uv0._card_transform.gameObject)
			else
				slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03)

				gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), uv0._card_transform.gameObject)
			end

			FightController.instance:dispatchEvent(FightEvent.ShowPlayCardEffect, uv0._card_mo, uv0._show_index)
		end
	end))
	slot18:addWork(slot24)
	slot1:addWork(slot18)
	slot1:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getUISpeed()))

	return slot1
end

function slot0._getPlayTargetPos(slot0)
	slot1 = FightViewPlayCard.getMaxItemCount()
	slot2 = slot0._parent_view._playCardItemTransform
	slot3 = recthelper.getAnchorX(slot2)
	slot5, slot6 = FightViewPlayCard.calcCardPosX(slot0._show_index, slot1)

	return slot5 + FightViewPlayCard.calContentPosX(slot0._show_index, slot1, recthelper.getAnchorX(slot0._parent_view._playCardItemTransform)), slot6 + recthelper.getAnchorY(slot2) - 21
end

function slot0._destroyCloneCard(slot0)
	gohelper.destroy(slot0._card_obj)
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._main_flow then
		slot0._main_flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._main_flow:stop()

		slot0._main_flow = nil
	end

	slot0:_destroyCloneCard()
	slot0:__onDispose()
end

return slot0
