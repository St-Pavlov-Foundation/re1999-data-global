module("modules.logic.fight.view.cardeffect.FightCardCombineEffect", package.seeall)

slot0 = class("FightCardCombineEffect", BaseWork)
slot1 = "ui/viewres/fight/ui_effect_dna_d.prefab"
slot3 = 0.033 * 1

function slot0.onStart(slot0, slot1)
	slot0._dt = uv0 / FightModel.instance:getUISpeed()
	slot2 = slot1.cards
	slot3 = slot1.combineIndex
	slot0._sequence = FlowSequence.New()
	slot4 = slot1.handCardItemList[slot3]

	slot4:setASFDActive(false)
	slot1.handCardItemList[slot3 + 1]:setASFDActive(false)

	slot0._universalCombineId = FightEnum.UniversalCard[slot4.cardInfoMO.skillId] or FightEnum.UniversalCard[slot5.cardInfoMO.skillId]
	slot6 = nil
	slot7 = gohelper.create2d(slot4.tr.parent.gameObject, "Combine")
	slot0._combineContainerGO = slot7
	slot8, slot9, slot10 = transformhelper.getPos(slot4.tr)
	slot11, slot12, slot13 = transformhelper.getPos(slot5.tr)

	transformhelper.setPos(slot7.transform, (slot8 + slot11) * 0.5, slot9, slot10)

	slot14 = gohelper.create2d(slot7, "CombineMask1")
	slot15 = gohelper.create2d(slot7, "CombineMask2")

	transformhelper.setPos(slot14.transform, transformhelper.getPos(slot4.tr))
	transformhelper.setPos(slot15.transform, transformhelper.getPos(slot5.tr))
	recthelper.setSize(slot14.transform, 185, 272)
	recthelper.setSize(slot15.transform, 185, 272)
	gohelper.onceAddComponent(slot14, gohelper.Type_Image)
	gohelper.onceAddComponent(slot15, gohelper.Type_Image)

	gohelper.onceAddComponent(slot14, typeof(UnityEngine.UI.Mask)).showMaskGraphic = false
	gohelper.onceAddComponent(slot15, typeof(UnityEngine.UI.Mask)).showMaskGraphic = false
	slot16 = gohelper.clone(slot4.go, slot14)
	slot17 = gohelper.clone(slot5.go, slot15)
	slot18 = slot16.transform
	slot19 = slot17.transform

	gohelper.setActive(slot4.go, false)
	gohelper.setActive(slot5.go, false)

	slot16.transform.anchorMin = Vector2.New(1, 0.5)
	slot16.transform.anchorMax = Vector2.New(1, 0.5)
	slot17.transform.anchorMin = Vector2.New(0, 0.5)
	slot17.transform.anchorMax = Vector2.New(0, 0.5)

	recthelper.setAnchorX(slot18, -92.5)
	recthelper.setAnchorX(slot19, 92.5)
	uv1._resetImages(slot16)
	uv1._resetImages(slot17)

	slot0:_createEffect(slot7, FightPreloadViewWork.ui_effect_dna_c).name = "CombineEffect"

	transformhelper.setPos(slot4.tr, (slot8 + slot11) * 0.5, slot9, slot10)
	gohelper.setActive(gohelper.findChild(slot16, "foranim/restrain"), false)
	gohelper.setActive(gohelper.findChild(slot17, "foranim/restrain"), false)
	gohelper.setActive(gohelper.findChild(slot16, "foranim/spEffect"), false)
	gohelper.setActive(gohelper.findChild(slot17, "foranim/spEffect"), false)
	gohelper.setActive(gohelper.findChild(slot16, "foranim/lock"), false)
	gohelper.setActive(gohelper.findChild(slot17, "foranim/lock"), false)

	slot21 = recthelper.getWidth(slot14.transform)
	slot6 = FlowParallel.New()

	slot6:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot18,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot19,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot18,
		to = -slot21 * 0.58,
		t = slot0._dt
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot19,
		to = slot21 * 0.58,
		t = slot0._dt
	}))
	slot0._sequence:addWork(slot6)

	slot6 = FlowParallel.New()

	slot6:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot18,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot19,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot18,
		to = -slot21 * 0.65,
		t = slot0._dt
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot19,
		to = slot21 * 0.65,
		t = slot0._dt
	}))
	slot0._sequence:addWork(slot6)

	slot6 = FlowParallel.New()

	slot6:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot18,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot19,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot18,
		to = -slot21 * 0.68,
		t = slot0._dt
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot19,
		to = slot21 * 0.68,
		t = slot0._dt
	}))
	slot0._sequence:addWork(slot6)

	slot6 = FlowParallel.New()

	slot6:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot18,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot19,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot18,
		to = -slot21 * 0.7,
		t = slot0._dt
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot19,
		to = slot21 * 0.7,
		t = slot0._dt
	}))
	slot0._sequence:addWork(slot6)

	slot6 = FlowParallel.New()

	slot6:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot18,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot19,
		t = slot0._dt * 2
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot18,
		to = -slot21 * 0.7,
		t = slot0._dt
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot19,
		to = slot21 * 0.7,
		t = slot0._dt
	}))
	slot0._sequence:addWork(slot6)
	slot0._sequence:addWork(FunctionWork.New(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FigthCombineCard)
	end))

	slot6 = FlowParallel.New()

	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot18,
		to = -slot21 * 1.5,
		t = slot0._dt * 5
	}))
	slot6:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = slot19,
		to = slot21 * 1.5,
		t = slot0._dt * 5
	}))
	slot6:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot18,
		t = slot0._dt * 5
	}))
	slot6:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = slot19,
		t = slot0._dt * 5
	}))
	slot0._sequence:addWork(slot6)

	slot2[slot3] = FightCardModel.combineTwoCard(slot2[slot3], slot2[slot3 + 1], FightCardModel.instance:getBeCombineCardMO())
	slot2[slot3].combineCanAddExpoint = FightCardDataHelper.combineCanAddExpoint(slot2, slot2[slot3], slot2[slot3 + 1])

	table.remove(slot2, slot3 + 1)
	slot0._sequence:addWork(FunctionWork.New(function ()
		slot4 = uv2

		FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, slot4)

		for slot4 = 1, #uv1.handCardItemList - 1 do
			recthelper.setAnchorX(uv1.handCardItemList[slot4].tr, uv0.getCardPosXList(uv1.handCardItemList)[slot4 <= uv3 and slot4 or slot4 + 1])
		end

		uv4.transform:SetParent(uv1.handCardItemList[uv3].tr.parent, true)
		gohelper.destroy(uv5)
		gohelper.setActive(gohelper.findChild(uv1.handCardItemList[uv3].go, "foranim/cardeffect"), true)
	end))

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Distribute and slot25 ~= FightEnum.Stage.FillCard or FightCardModel.getCombineIndexOnce(slot2) then
		slot0._sequence:addWork(uv1.buildCombineEndFlow(slot3, slot3, #slot2, slot1.handCardItemList))
	end

	slot0._sequence:registerDoneListener(slot0._onCombineCardDone, slot0)
	slot0._sequence:start(slot1)
end

function slot0._onCombineCardDone(slot0)
	slot0._sequence:unregisterDoneListener(slot0._onCombineCardDone, slot0)

	slot1 = slot0.context.combineIndex
	slot3 = slot0.context.handCardItemList[slot1 + 1]

	if slot0.context.handCardItemList[slot1] then
		slot2:setASFDActive(true)
	end

	if slot3 then
		slot3:setASFDActive(true)
	end

	if slot0._universalCombineId then
		slot0:_createUniversalCombineEffect()
	else
		slot0:onDone(true)
	end
end

function slot0.onStop(slot0)
	if slot0._sequence and slot0._sequence.status == WorkStatus.Running then
		slot0._sequence:stop()
	end

	uv0.super.onStop(slot0)
end

function slot0.getCardPosXList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		table.insert(slot1, recthelper.getAnchorX(slot6.tr))
	end

	return slot1
end

function slot0.buildCombineEndFlow(slot0, slot1, slot2, slot3)
	slot4 = uv0 / FightModel.instance:getUISpeed()

	if slot0 then
		if slot3[slot0] then
			slot7 = FlowSequence.New()

			slot7:addWork(FunctionWork.New(function ()
				transformhelper.setLocalRotation(uv0.tr, 0, -90, 0)
			end))
			slot7:addWork(TweenWork.New({
				toz = 0,
				type = "DORotate",
				tox = 0,
				toy = -45,
				tr = slot6.tr,
				t = 1 * slot4
			}))
			slot7:addWork(TweenWork.New({
				toz = 0,
				type = "DORotate",
				tox = 0,
				toy = 0,
				tr = slot6.tr,
				t = 1 * slot4
			}))
			slot7:addWork(TweenWork.New({
				type = "DOAnchorPos",
				toy = 0,
				tr = slot6.tr,
				tox = FightViewHandCard.calcCardPosX(slot0),
				t = slot4 * 4
			}))
			slot7:addWork(FunctionWork.New(function ()
				gohelper.setActive(gohelper.findChild(uv0.go, "foranim/cardeffect"), false)
				gohelper.destroy(gohelper.findChild(uv0.tr.parent.gameObject, "CombineEffect"))
			end))
			FlowParallel.New():addWork(slot7)
		else
			logError("合牌位置错误：" .. slot0)
		end
	end

	if slot1 > 0 then
		for slot9 = slot1, slot2 do
			if slot9 ~= slot0 then
				slot10 = slot3[slot9]
				slot11 = FlowSequence.New()

				if (3 + slot9 - slot1) * slot4 > 0 then
					slot11:addWork(WorkWaitSeconds.New(slot12))
				end

				slot11:addWork(TweenWork.New({
					type = "DOAnchorPos",
					toy = 0,
					tr = slot10.tr,
					tox = FightViewHandCard.calcCardPosX(slot9),
					t = slot4 * 4
				}))
				slot5:addWork(slot11)
			end
		end
	end

	return slot5
end

function slot0._createEffect(slot0, slot1, slot2)
	slot3 = gohelper.create2d(slot1, slot2)

	slot0:_load(slot3, slot2)

	return slot3
end

function slot0._load(slot0, slot1, slot2)
	PrefabInstantiate.Create(slot1):startLoad(slot2, function ()
		if uv0:getInstGO():GetComponent(typeof(ZProj.EffectOrderContainer)) then
			slot0:SetBaseOrder(2)
		end
	end)
end

function slot0._createUniversalCombineEffect(slot0)
	slot0._combineUpEffectLoader = PrefabInstantiate.Create(gohelper.findChild(slot0.context.handCardItemList[slot0.context.combineIndex].go, "combineUpEffect") or gohelper.create2d(slot1.go, "combineUpEffect"))

	slot0._combineUpEffectLoader:startLoad(uv0, function (slot0)
		slot2 = slot0:getInstGO()

		gohelper.onceAddComponent(slot2, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())
		gohelper.setActive(gohelper.findChild(slot2, "ani/star02"), FightCardModel.instance:getSkillLv(uv0.cardInfoMO.uid, uv0.cardInfoMO.skillId) >= 2)
		gohelper.setActive(gohelper.findChild(slot2, "ani/star03"), slot1 >= 3)
	end)
	TaskDispatcher.runDelay(slot0._combineUpEffectDone, slot0, 0.5 / FightModel.instance:getUISpeed())
end

function slot0._combineUpEffectDone(slot0)
	if slot0._combineUpEffectLoader then
		slot0._combineUpEffectLoader:dispose()
	end

	slot0._combineUpEffectLoader = nil

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._combineContainerGO then
		gohelper.destroy(slot0._combineContainerGO)

		slot0._combineContainerGO = nil
	end

	if slot0._combineUpEffectLoader then
		slot0._combineUpEffectLoader:dispose()
	end

	slot0._combineUpEffectLoader = nil

	TaskDispatcher.cancelTask(slot0._combineUpEffectDone, slot0)
end

function slot0._resetImages(slot0)
	if not gohelper.isNil(slot0) then
		for slot5 = 0, slot0:GetComponentsInChildren(gohelper.Type_Image).Length - 1 do
			slot1[slot5].maskable = true
		end
	end
end

return slot0
