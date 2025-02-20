module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardFlyEffect", package.seeall)

slot0 = class("FightEnemyPlayCardFlyEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if not FightModel.instance:getCurRoundMO() then
		slot0:onDone(true)

		return
	end

	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(FlowParallel.New())

	for slot8 = 1, slot1.enemyNowActPoint do
		slot11 = FightHelper.getEntity(slot2:getAIUseCardMOList()[slot8].uid) and slot10.nameUI
		slot13 = gohelper.findChild(slot1.viewGO, "root/enemycards/item" .. slot8)
		slot14 = gohelper.findChild(slot13, "op")
		slot15 = recthelper.rectToRelativeAnchorPos((slot11 and slot11:getOpCtrl():getSkillOpGO(slot9)).transform.position, slot13.transform)
		slot16 = FlowSequence.New()

		if slot8 > 1 then
			slot16:addWork(WorkWaitSeconds.New((slot8 - 1) * uv1 * 4))
		end

		slot16:addWork(TweenWork.New({
			type = "DOAnchorPos",
			tr = slot14.transform,
			tox = slot15.x,
			toy = slot15.y,
			t = uv1 * 8
		}))
		slot16:addWork(FunctionWork.New(function ()
			gohelper.setActive(uv0, true)
			gohelper.setActive(uv1, false)
			recthelper.setAnchor(uv1.transform, 0, 0)

			if not gohelper.isNil(uv0) and uv2 then
				uv2:getOpCtrl():onFlyEnd(MonoHelper.getLuaComFromGo(uv0, FightOpItem))
			end
		end))
		slot3:addWork(slot16)
	end

	slot0._flow:addWork(FunctionWork.New(function ()
		gohelper.setActive(gohelper.findChild(uv0.viewGO, "root/enemycards"), false)
	end))
	slot0._flow:registerDoneListener(slot0._onDone, slot0)
	slot0._flow:start()
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3)
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
