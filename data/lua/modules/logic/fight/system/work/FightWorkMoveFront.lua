module("modules.logic.fight.system.work.FightWorkMoveFront", package.seeall)

slot0 = class("FightWorkMoveFront", FightEffectBase)

function slot0.ctor(slot0, slot1, slot2)
	if slot1 then
		slot1.custom_ingoreParallelSkill = true
	end

	uv0.super.ctor(slot0, slot1, slot2)
end

function slot0.onStart(slot0)
	slot0._performanceTime = 0.75 / FightModel.instance:getSpeed()

	slot0:com_registTimer(slot0._delayDone, 5)

	slot0._flow = FlowParallel.New()
	slot0._cacheEntityIds = {}

	if FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) and FightHelper.getEntity(slot1) then
		slot4 = slot2

		if slot3.mover then
			AudioMgr.instance:trigger(410000088)

			slot5 = 0.5 / FightModel.instance:getSpeed()
			slot6, slot7, slot8, slot9 = FightHelper.getEntityStandPos(slot4)
			slot10 = FlowParallel.New()

			slot10:addWork(FunctionWork.New(slot0._playEffect, slot0, slot3))
			slot10:addWork(TweenWork.New({
				type = "DOScale",
				tr = slot3.go.transform,
				to = slot9,
				t = slot5,
				ease = EaseType.InOutQuad
			}))
			slot10:addWork(TweenWork.New({
				from = 0,
				type = "DOTweenFloat",
				to = 1,
				t = slot5,
				frameCb = slot0._onFloat,
				cbObj = slot0,
				param = slot3,
				ease = EaseType.InOutQuad
			}))
			slot10:addWork(TweenWork.New({
				type = "DOMove",
				tr = slot3.go.transform,
				tox = slot6,
				toy = slot7,
				toz = slot8,
				t = slot5,
				ease = EaseType.InOutQuad
			}))
			slot0._flow:addWork(slot10)
			table.insert(slot0._cacheEntityIds, slot4.id)
		end
	end

	if #string.split(slot0._actEffectMO.reserveStr, "|") > 0 then
		for slot7, slot8 in ipairs(slot3) do
			if FightDataHelper.entityMgr:getById(string.split(slot8, "#")[1]) and FightHelper.getEntity(slot10) then
				slot13 = FlowSequence.New()

				slot13:addWork(WorkWaitSeconds.New(0.15 / FightModel.instance:getSpeed()))

				slot14 = FlowParallel.New()
				slot15, slot16, slot17, slot18 = FightHelper.getEntityStandPos(slot11)
				slot19 = 0.6 / FightModel.instance:getSpeed()

				slot14:addWork(TweenWork.New({
					type = "DOScale",
					tr = slot12.go.transform,
					to = slot18,
					t = slot19,
					ease = EaseType.InOutQuad
				}))
				slot14:addWork(TweenWork.New({
					from = 0,
					type = "DOTweenFloat",
					to = 1,
					t = slot19,
					frameCb = slot0._onFloat,
					cbObj = slot0,
					param = slot12,
					ease = EaseType.InOutQuad
				}))
				slot14:addWork(TweenWork.New({
					type = "DOMove",
					tr = slot12.go.transform,
					tox = slot15,
					toy = slot16,
					toz = slot17,
					t = slot19,
					ease = EaseType.InOutQuad
				}))
				slot13:addWork(slot14)
				slot0._flow:addWork(slot13)
				table.insert(slot0._cacheEntityIds, slot11.id)
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
		slot2 = slot1.effect:addHangEffect("buff/buff_qianjin_jiantou", "mountbody", nil, slot0._performanceTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot2)
		slot2:setLocalPos(0, 0, 0)

		slot2 = slot1.effect:addHangEffect("buff/buff_qianjin_tuowei", "mountbody", nil, slot0._performanceTime)

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
