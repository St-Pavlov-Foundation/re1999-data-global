module("modules.logic.fight.view.cardeffect.FightCardResetEffect", package.seeall)

slot0 = class("FightCardResetEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()

	FightController.instance:dispatchEvent(FightEvent.CorrectPlayCardVisible)

	slot0._flow = FlowParallel.New()
	slot2 = FlowSequence.New()

	slot2:addWork(slot0:_buildPlayCardFadeOut())
	slot2:addWork(slot0:_buildPlayCardMove())
	slot0._flow:addWork(slot2)
	slot0._flow:addWork(slot0:_buildHandCardMove())
	slot0._flow:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._flow:start()
end

function slot0._buildPlayCardFadeOut(slot0)
	slot1 = FlowParallel.New()

	for slot5, slot6 in ipairs(slot0.context.playCardItemList) do
		slot7 = slot6.go

		gohelper.setActive(gohelper.findChild(slot7, "lock"), false)
		slot1:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = gohelper.findChild(slot7, "card"),
			t = slot0._dt * 3
		}))
		slot1:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = gohelper.findChild(slot7, "imgMove"),
			t = slot0._dt * 3
		}))

		if slot6.fightBeginRoundOp and slot12:isAssistBossPlayCard() then
			gohelper.setActive(gohelper.findChild(slot7, "imgEmpty"), false)
		elseif slot12 and slot12:isPlayerFinisherSkill() then
			gohelper.setActive(slot8, false)
		elseif slot12 then
			gohelper.setActive(slot8, not slot12:isPlayCard() or slot12.costActPoint >= 1)
		else
			gohelper.setActive(slot8, true)
		end

		slot6:playASFDCloseAnim()
	end

	return slot1
end

function slot0._buildPlayCardMove(slot0)
	slot1 = FightCardModel.instance:getCardMO().actPoint

	if FightCardModel.instance:getCardMO().extraMoveAct == -1 then
		slot2 = 0
	end

	slot3 = 1
	slot4 = FlowParallel.New()

	for slot8, slot9 in ipairs(slot0.context.playCardItemList) do
		slot10 = slot9.go

		if slot9.fightBeginRoundOp and slot11:isPlayCard() and slot11.costActPoint == 0 then
			-- Nothing
		elseif slot11 and slot11:isAssistBossPlayCard() then
			-- Nothing
		elseif not slot11 or not slot11:isPlayerFinisherSkill() then
			slot12, slot13 = FightViewPlayCard.calcCardPosX(slot3, slot1 + slot2)

			slot4:addWork(TweenWork.New({
				type = "DOAnchorPos",
				tr = slot10.transform,
				tox = slot12,
				toy = slot13,
				t = slot0._dt * 3
			}))

			slot3 = slot3 + 1
		end
	end

	return slot4
end

function slot0._buildHandCardMove(slot0)
	slot1 = slot0:_buildCardRelation()
	slot2 = {
		[slot11] = true
	}

	FlowSequence.New():addWork(FlowParallel.New())

	for slot9 = 1, #slot0.context.view.viewContainer.fightViewHandCard._handCardItemList do
		if slot1[slot9] and slot1[slot9].origin then
			slot5:addWork(TweenWork.New({
				type = "DOAnchorPos",
				toy = 0,
				tr = slot4[slot9].tr,
				tox = FightViewHandCard.calcCardPosX(slot11),
				t = slot0._dt * 4
			}))
		end
	end

	slot3:addWork(FunctionWork.New(function ()
		slot3 = FightCardModel.instance
		slot4 = slot3
		slot3 = slot3.getHandCards

		FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, slot3(slot4))

		for slot3, slot4 in ipairs(uv0) do
			if not uv1[slot3] then
				TweenWork.New({
					from = 0,
					type = "DOFadeCanvasGroup",
					to = 1,
					go = slot4.go,
					t = uv2._dt * 4
				}):onStart()
			end
		end
	end))
	slot3:addWork(WorkWaitSeconds.New(slot0._dt * 5))

	return slot3
end

function slot0._buildCardRelation(slot0)
	for slot5, slot6 in ipairs(FightCardModel.instance:getHandCards()) do
		slot1[slot5] = slot6:clone()
		slot1[slot5].origin = slot5
	end

	for slot5, slot6 in ipairs(slot0.context.oldCardOps) do
		if slot6:isPlayCard() then
			table.remove(slot1, slot6.param1)
			slot0:_dealCombineRelation(slot1)
		elseif slot6:isMoveCard() then
			FightCardModel.moveOnly(slot1, slot6.param1, slot6.param2)
			slot0:_dealCombineRelation(slot1)
		elseif slot6:isMoveUniversal() then
			slot8 = slot1[slot6.param2]
			slot8.skillId = FightCardModel.getCombineSkillId(slot1[slot6.param1], slot8, slot8)

			table.remove(slot1, slot6.param1)
			slot0:_dealCombineRelation(slot1)
		end
	end

	return slot1
end

function slot0._dealCombineRelation(slot0, slot1)
	slot2 = FightCardModel.getCombineIndexOnce(slot1)

	while #slot1 >= 2 and slot2 do
		slot1[slot2].skillId = FightCardModel.getCombineSkillId(slot1[slot2], slot1[slot2 + 1])

		table.remove(slot1, slot2 + 1)

		slot2 = FightCardModel.getCombineIndexOnce(slot1)
	end
end

function slot0._matchSkill(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return false
	end

	if slot1.uid ~= slot2.uid then
		return false
	end

	if slot1.skillId == slot2.skillId then
		return true
	end

	if FightCardModel.instance:getSkillPrevLvId(slot1.uid, slot1.skillId) then
		if slot3 == slot2.skillId then
			return true
		elseif FightCardModel.instance:getSkillPrevLvId(slot1.uid, slot3) and slot4 == slot2.skillId then
			return true
		end
	end

	return false
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:stop()
		slot0._flow:unregisterDoneListener(slot0._onWorkDone, slot0)

		slot0._flow = nil
	end
end

function slot0._onWorkDone(slot0)
	for slot4, slot5 in ipairs(slot0.context.playCardItemList) do
		slot6 = slot5.go
		gohelper.onceAddComponent(gohelper.findChild(slot6, "card"), typeof(UnityEngine.CanvasGroup)).alpha = 1
		gohelper.onceAddComponent(gohelper.findChild(slot6, "imgMove"), typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(gohelper.findChild(slot6, "imgEmpty"), true)
	end

	slot0:onDone(true)
end

return slot0
