module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardOpInEffect", package.seeall)

slot0 = class("FightEnemyPlayCardOpInEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	slot0._dt = uv0 / FightModel.instance:getUISpeed()

	uv1.super.onStart(slot0, slot1)

	if not FightModel.instance:getCurRoundMO() then
		slot0:onDone(true)

		return
	end

	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(FlowParallel.New())

	for slot8, slot9 in ipairs(slot2:getAIUseCardMOList()) do
		slot11 = FightHelper.getEntity(slot9.uid) and slot10.nameUI
		slot12 = slot11 and slot11:getOpCtrl():getSkillOpGO(slot9)
		slot13 = FlowSequence.New()

		slot13:addWork(WorkWaitSeconds.New((#slot4 - slot8 + 1) * slot0._dt * 4))
		slot13:addWork(FunctionWork.New(function ()
			gohelper.setActive(uv0, true)

			if uv1 and not gohelper.isNil(uv0) then
				uv1:getOpCtrl():checkLockFirst()
				uv1:getOpCtrl():onFlyEnd(MonoHelper.getLuaComFromGo(uv0, FightOpItem))
			end
		end))
		slot3:addWork(slot13)
	end

	slot0._flow:registerDoneListener(slot0._onDone, slot0)
	slot0._flow:start()
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3 / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._flow then
		slot0._flow:destroy()

		slot0._flow = nil
	end
end

function slot0._onDone(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

return slot0
