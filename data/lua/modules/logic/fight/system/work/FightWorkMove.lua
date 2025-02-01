module("modules.logic.fight.system.work.FightWorkMove", package.seeall)

slot0 = class("FightWorkMove", FightEffectBase)

function slot0.ctor(slot0, slot1, slot2)
	if slot1 then
		slot1.custom_ingoreParallelSkill = true
	end

	uv0.super.ctor(slot0, slot1, slot2)
end

function slot0.onStart(slot0)
	slot0._performanceTime = 0.6 / FightModel.instance:getSpeed()

	slot0:com_registTimer(slot0._delayDone, 5)

	slot0._flow = FlowParallel.New()
	slot0._cacheEntityIds = {}

	if #string.split(slot0._actEffectMO.reserveStr, "|") > 0 then
		AudioMgr.instance:trigger(410000090)

		for slot5, slot6 in ipairs(slot1) do
			slot7 = string.split(slot6, "#")

			if FightEntityModel.instance:getById(slot7[1]) then
				slot10.position = tonumber(slot7[2]) or 1

				if FightHelper.getEntity(slot8) and slot11.mover then
					slot12, slot13, slot14, slot15 = FightHelper.getEntityStandPos(slot10)
					slot16 = FlowParallel.New()

					slot16:addWork(FunctionWork.New(slot0._playEffect, slot0, slot11))
					slot16:addWork(TweenWork.New({
						type = "DOScale",
						tr = slot11.go.transform,
						to = slot15,
						t = slot0._performanceTime,
						ease = EaseType.InOutQuad
					}))
					slot16:addWork(TweenWork.New({
						from = 0,
						type = "DOTweenFloat",
						to = 1,
						t = slot0._performanceTime,
						frameCb = slot0._onFloat,
						cbObj = slot0,
						param = slot11,
						ease = EaseType.InOutQuad
					}))
					slot16:addWork(TweenWork.New({
						type = "DOMove",
						tr = slot11.go.transform,
						tox = slot12,
						toy = slot13,
						toz = slot14,
						t = slot0._performanceTime,
						ease = EaseType.InOutQuad
					}))
					slot0._flow:addWork(slot16)
					table.insert(slot0._cacheEntityIds, slot10.id)
				end
			end
		end
	end

	slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0._flow:start()
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._playEffect(slot0, slot1)
	if slot1 and slot1.effect then
		slot2 = slot1.effect:addHangEffect("buff/buff_huanwei_jiantou", "mountbody", nil, slot0._performanceTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot2)
		slot2:setLocalPos(0, 0, 0)

		slot2 = slot1.effect:addHangEffect("buff/buff_huanwei_faguang", "mountroot", nil, slot0._performanceTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot2)
		slot2:setLocalPos(0, 0, 0)
	end
end

function slot0._onFloat(slot0, slot1, slot2)
	if slot2.go then
		FightController.instance:dispatchEvent(FightEvent.UpdateUIFollower, slot2.id)
	end
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end

	if slot0._cacheEntityIds then
		for slot4, slot5 in ipairs(slot0._cacheEntityIds) do
			if FightHelper.getEntity(slot5) and slot6.effect then
				slot6.effect:refreshAllEffectLabel1()
			end
		end
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

return slot0
