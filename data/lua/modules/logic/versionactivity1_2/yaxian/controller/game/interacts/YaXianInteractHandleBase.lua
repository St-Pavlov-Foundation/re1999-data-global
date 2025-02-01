module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractHandleBase", package.seeall)

slot0 = class("YaXianInteractHandleBase")

function slot0.init(slot0, slot1)
	slot0._interactObject = slot1
end

function slot0.onSelectCall(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onSelectPos(slot0, slot1, slot2)
end

function slot0.onAvatarLoaded(slot0)
	slot0:faceTo(slot0._interactObject.interactMo.direction)
end

function slot0.faceTo(slot0, slot1)
	slot0._interactObject.interactMo:setDirection(slot1)

	if slot0._interactObject:isDelete() then
		return
	end

	if not slot0._interactObject.directionAvatarDict then
		return
	end

	for slot5, slot6 in pairs(slot0._interactObject.directionAvatarDict) do
		gohelper.setActive(slot6, slot5 == slot1)
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	if slot1 == slot0._interactObject.interactMo.posX and slot2 == slot0._interactObject.interactMo.posY then
		if slot0.stepData then
			slot0:faceTo(slot0.stepData.direction)
		end

		if slot3 then
			return slot3(slot4)
		end

		return
	end

	if slot0._interactObject:isDelete() then
		if slot3 then
			slot0._interactObject.interactMo:setXY(slot1, slot2)

			if slot0.stepData then
				slot0:faceTo(slot0.stepData.direction)
			end

			return slot3(slot4)
		end

		return
	end

	slot0._moveCallback = slot3
	slot0._moveCallbackObj = slot4
	slot5 = slot0._interactObject.interactMo

	slot0:faceTo(YaXianGameHelper.getDirection(slot5.posX, slot5.posY, slot1, slot2))
	slot5:setXY(slot1, slot2)

	if slot0.stepData and slot0.stepData.assassinateSourceStep then
		slot0:handleAssassinate()

		return
	end

	slot7, slot8, slot9 = YaXianGameHelper.calcTilePosInScene(slot1, slot2)

	slot0:killMoveTween()

	slot0.moveWork = YaXianInteractMoveWork.New({
		transform = slot0._interactObject.interactItemContainerTr,
		targetX = slot7,
		targetY = slot8,
		targetZ = slot9,
		isPlayer = slot0._interactObject:isPlayer(),
		interactMo = slot5
	})

	slot0.moveWork:registerDoneListener(slot0.onMoveCompleted, slot0)
	slot0.moveWork:onStart()
end

function slot0.handleAssassinate(slot0)
	slot0:stopFlow()

	slot0.flow = FlowSequence.New()
	slot9 = slot0._interactObject.interactMo.prePosX
	slot10 = slot0._interactObject.interactMo.prePosY

	if YaXianGameController.instance:getInteractItem(YaXianGameController.instance.stepMgr:getStepData(slot0.stepData.deleteStepIndex) and slot2.id or 0).interactMo.posX ~= YaXianGameController.instance:getInteractItem(slot2 and slot2.sourceId or 0).interactMo.posX or slot4.interactMo.posY ~= slot6.interactMo.posY then
		slot11, slot12, slot13 = YaXianGameHelper.calcTilePosInScene(slot0._interactObject.interactMo.posX, slot0._interactObject.interactMo.posY)

		slot0.flow:addWork(YaXianInteractMoveWork.New({
			transform = slot0._interactObject.interactItemContainerTr,
			targetX = slot11,
			targetY = slot12,
			targetZ = slot13,
			isPlayer = slot0._interactObject:isPlayer(),
			interactMo = slot0._interactObject.interactMo
		}))
		slot0.flow:addWork(YaXianInteractEffectWork.New(slot3, YaXianGameEnum.EffectType.Assassinate))
		slot0.flow:addWork(YaXianInteractEffectWork.New(slot3, YaXianGameEnum.EffectType.Die))
		slot0.flow:addWork(YaXianInteractEffectWork.New(slot5, YaXianGameEnum.EffectType.FightSuccess))
	else
		slot13, slot14, slot15 = YaXianGameHelper.calBafflePosInScene(slot7, slot8, YaXianGameEnum.OppositeDirection[YaXianGameHelper.getDirection(slot9, slot10, slot7, slot8)])

		slot0.flow:addWork(YaXianInteractMoveWork.New({
			transform = slot0._interactObject.interactItemContainerTr,
			targetX = slot13,
			targetY = slot14,
			targetZ = slot15,
			isPlayer = slot0._interactObject:isPlayer(),
			interactMo = slot0._interactObject.interactMo
		}))

		slot16 = nil
		slot17, slot18, slot19 = YaXianGameHelper.calBafflePosInScene(slot7, slot8, slot11)

		slot0.flow:addWork(YaXianInteractMoveWork.New({
			transform = (slot3 == slot0._interactObject.id and slot6 or slot4).interactItemContainerTr,
			targetX = slot17,
			targetY = slot18,
			targetZ = slot19
		}))
		slot0.flow:addWork(YaXianInteractEffectWork.New(slot3, YaXianGameEnum.EffectType.Assassinate))

		slot17 = FlowParallel.New()

		slot17:addWork(YaXianInteractEffectWork.New(slot3, YaXianGameEnum.EffectType.Die))

		slot18, slot19, slot20 = YaXianGameHelper.calcTilePosInScene(slot7, slot8)

		slot17:addWork(YaXianInteractMoveWork.New({
			transform = slot6.interactItemContainerTr,
			targetX = slot18,
			targetY = slot19,
			targetZ = slot20
		}))
		slot0.flow:addWork(slot17)
		slot0.flow:addWork(YaXianInteractEffectWork.New(slot5, YaXianGameEnum.EffectType.FightSuccess))
	end

	slot0.flow:registerDoneListener(slot0.onMoveCompleted, slot0)
	slot0.flow:start()
end

function slot0.onMoveCompleted(slot0)
	slot0:killMoveTween()
	slot0:stopFlow()

	if slot0.stepData and slot0._interactObject.interactMo.direction ~= slot0.stepData.direction then
		TaskDispatcher.runDelay(slot0.doMoveCallback, slot0, YaXianGameEnum.SwitchDirectionDelay)

		return
	end

	slot0:doMoveCallback()
end

function slot0.doMoveCallback(slot0)
	if slot0.stepData then
		slot0:faceTo(slot0.stepData.direction)

		slot0.stepData = nil
	end

	if slot0._interactObject:isPlayer() and slot0._interactObject.interactMo.posX == YaXianGameModel.instance:getExitInteractMo().posX and slot0._interactObject.interactMo.posY == slot1.posY then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	end

	if slot0._moveCallback then
		slot0._moveCallback = nil
		slot0._moveCallbackObj = nil

		return slot0._moveCallback(slot0._moveCallbackObj)
	end
end

function slot0.killMoveTween(slot0)
	if slot0.moveWork then
		slot0.moveWork:onDestroy()

		slot0.moveWork = nil
	end
end

function slot0.moveToFromMoveStep(slot0, slot1, slot2, slot3)
	slot0.stepData = slot1

	slot0:moveTo(slot0.stepData.x, slot0.stepData.y, slot2, slot3)
end

function slot0.stopFlow(slot0)
	if slot0.flow then
		slot0.flow:destroy()

		slot0.flow = nil
	end
end

function slot0.stopAllAction(slot0)
	slot0:stopFlow()
	slot0:killMoveTween()
	TaskDispatcher.cancelTask(slot0.doMoveCallback, slot0)
end

function slot0.dispose(slot0)
	slot0:stopAllAction()
end

return slot0
