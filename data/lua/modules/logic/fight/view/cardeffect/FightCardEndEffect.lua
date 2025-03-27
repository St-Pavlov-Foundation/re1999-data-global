module("modules.logic.fight.view.cardeffect.FightCardEndEffect", package.seeall)

slot0 = class("FightCardEndEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot0._playCardCount = 0

	for slot6, slot7 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot7:isPlayCard() or slot7:isAssistBossPlayCard() or slot7:isPlayerFinisherSkill() then
			slot0._playCardCount = slot0._playCardCount + 1
		end
	end

	FightViewPartVisible.set(true, true, true, false, false)

	slot0._flow = FlowParallel.New()

	slot0._flow:addWork(slot0:_handCardFlow())
	slot0._flow:addWork(slot0:_playCardFlow())
	slot0._flow:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._flow:start()
end

function slot0.onStop(slot0)
	if slot0._flow then
		slot0._flow:stop()

		if slot0._cloneItemGOs then
			for slot4, slot5 in ipairs(slot0._cloneItemGOs) do
				gohelper.destroy(slot5)
			end

			slot0._cloneItemGOs = nil
		end
	end

	uv0.super.onStop(slot0)
end

function slot0._handCardFlow(slot0)
	slot1 = FlowParallel.New()
	slot0._handCardItemGOs = {}

	if slot0._playCardCount > 0 then
		slot4 = 1

		for slot8 = slot0.context.handCardContainer.transform.childCount, 1, -1 do
			if gohelper.findChild(slot2, "cardItem" .. slot8) and slot9.activeInHierarchy then
				slot10 = FlowSequence.New()

				slot10:addWork(WorkWaitSeconds.New(slot0._dt * slot4 * 2))
				slot10:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 18,
					tr = slot9.transform,
					t = slot0._dt * 6,
					ease = EaseType.InOutSine
				}))
				slot10:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = -400,
					tr = slot9.transform,
					t = slot0._dt * 8,
					ease = EaseType.InOutSine
				}))
				slot1:addWork(slot10)

				slot4 = slot4 + 1

				table.insert(slot0._handCardItemGOs, slot9)
			end
		end
	else
		slot3 = FightWorkEffectDistributeCard.handCardScale

		ZProj.TweenHelper.DOScale(FightViewHandCard.handCardContainer.transform, slot3, slot3, slot3, FightWorkEffectDistributeCard.getHandCardScaleTime())
	end

	return slot1
end

function slot0._playCardFlow(slot0)
	slot1 = FlowSequence.New()

	if FightViewPlayCard.VisibleCount < FightViewPlayCard.getMaxItemCount() then
		slot1:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = slot0.context.playCardContainer,
			t = slot0._dt * 15
		}))

		return slot1
	end

	slot1:addWork(WorkWaitSeconds.New(0.2))

	slot3 = FlowParallel.New()
	slot6 = gohelper.findChild(slot0.context.playCardContainer, "#scroll_cards/Viewport/Content").transform.childCount
	slot0._playCardItemGOs = {}
	slot0._cloneItemGOs = {}
	slot7 = {}
	slot8 = FightCardModel.instance:getCardOps()

	if ViewMgr.instance:getContainer(ViewName.FightView) and slot9.fightViewPlayCard then
		for slot14, slot15 in ipairs(slot8) do
			if slot15:isPlayCard() or slot15:isAssistBossPlayCard() or slot15:isPlayerFinisherSkill() then
				if slot10:getShowIndex(slot15) then
					slot7[slot16] = true

					if slot15:needCopyCard() then
						slot7[slot16 + 1] = true
					end
				else
					slot17 = {}

					for slot21, slot22 in ipairs(slot8) do
						table.insert(slot17, string.format("{operType : %s, toId : %s, skillId : %s, belongToEntityId : %s, costActPoint: %s}", slot22.operType, slot22.toId, slot22.skillId, slot22.belongToEntityId, slot22.costActPoint))
					end

					slot18 = table.concat(slot17, "\n")

					tabletool.clear(slot17)

					for slot22, slot23 in ipairs(slot10._begin_round_ops) do
						table.insert(slot17, string.format("{operType : %s, toId : %s, skillId : %s, belongToEntityId : %s, costActPoint: %s}", slot23.operType, slot23.toId, slot23.skillId, slot23.belongToEntityId, slot23.costActPoint))
					end

					logError(string.format("get temp_index fail : %s, \n ops : {%s},\n begin_round_ops : {%s}", tostring(slot16), slot18, table.concat(slot17, "\n")))
				end
			end
		end
	end

	for slot13 = 1, slot6 do
		if slot7[slot13] and gohelper.findChild(slot4, "cardItem" .. slot13) then
			gohelper.setActive(gohelper.findChild(slot14, "#go_Grade"), false)
			table.insert(slot0._playCardItemGOs, gohelper.findChild(slot14, "card"))

			slot16 = gohelper.cloneInPlace(slot14)

			table.insert(slot0._cloneItemGOs, slot16)
			slot16.transform:SetParent(slot0.context.handCardContainer.transform, true)
			gohelper.setActive(gohelper.findChild(slot16, "effect1"), false)
			gohelper.setActive(gohelper.findChild(slot16, "effect2"), false)
			gohelper.setActive(gohelper.findChild(slot14, "lock"), false)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.FixWaitingAreaItemCount, #slot0._playCardItemGOs)

	for slot14, slot15 in ipairs(slot0._playCardItemGOs) do
		slot16 = slot0._cloneItemGOs[slot14].transform
		slot17 = gohelper.findChild(slot0.context.waitCardContainer, "cardItem" .. #slot0._playCardItemGOs - slot14 + 1)

		if FightModel.instance:getVersion() >= 1 then
			slot17 = gohelper.findChild(slot0.context.waitCardContainer, "cardItem" .. slot14)
		end

		slot18 = recthelper.rectToRelativeAnchorPos(slot17.transform.position, slot16.parent)
		slot19 = FlowSequence.New()

		slot19:addWork(WorkWaitSeconds.New(slot0._dt * 2 * slot14))
		slot19:addWork(FunctionWork.New(function ()
			gohelper.setActive(uv0, false)
		end))

		slot21 = FlowParallel.New()

		slot21:addWork(TweenWork.New({
			type = "DOScale",
			tr = slot16,
			to = 1.32,
			t = slot0._dt * 5,
			ease = EaseType.easeOutQuad
		}))
		slot21:addWork(TweenWork.New({
			type = "DORotate",
			tox = 0,
			toy = 0,
			tr = slot16,
			toz = 15,
			t = slot0._dt * 5,
			ease = EaseType.easeOutQuad
		}))
		slot19:addWork(slot21)

		slot24 = FlowParallel.New()

		slot24:addWork(TweenWork.New({
			type = "DOAnchorPos",
			tr = slot16,
			tox = slot18.x,
			toy = slot18.y + -107,
			t = slot0._dt * 10,
			ease = EaseType.OutCubic
		}))
		slot24:addWork(TweenWork.New({
			toz = 0,
			type = "DORotate",
			tox = 0,
			toy = 0,
			tr = slot16,
			t = slot0._dt * 10,
			ease = EaseType.OutCubic
		}))
		slot19:addWork(slot24)
		slot3:addWork(slot19)
	end

	if GMFightShowState.cards then
		slot3:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = slot0.context.playCardContainer,
			t = slot0._dt * 15
		}))
	end

	slot1:addWork(slot3)
	slot1:addWork(FightWork2Work.New(FightWorkDetectUseCardSkillId))

	return slot1
end

function slot0._onWorkDone(slot0)
	slot0._flow:unregisterDoneListener(slot0._onWorkDone, slot0)
	gohelper.setActive(slot0.context.playCardContainer, false)
	gohelper.setActive(slot0.context.waitCardContainer, true)

	if GMFightShowState.cards then
		gohelper.onceAddComponent(slot0.context.playCardContainer, typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	if slot0._playCardCount > 0 then
		FightViewPartVisible.set(false, false, false, false, true)
	end

	for slot4, slot5 in ipairs(slot0._handCardItemGOs) do
		recthelper.setAnchorY(slot5.transform, 0)
	end

	if slot0._playCardItemGOs then
		for slot4, slot5 in ipairs(slot0._playCardItemGOs) do
			recthelper.setAnchor(slot5.transform, 0, 0)
		end
	end

	if slot0._cloneItemGOs then
		for slot4, slot5 in ipairs(slot0._cloneItemGOs) do
			gohelper.destroy(slot5)
		end
	end

	slot0._playCardItemGOs = nil
	slot0._cloneItemGOs = nil

	slot0:onDone(true)
end

return slot0
