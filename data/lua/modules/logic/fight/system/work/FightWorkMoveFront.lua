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

	if FightEntityModel.instance:getById(slot0._actEffectMO.targetId) then
		slot2.position = slot0._actEffectMO.effectNum

		if FightHelper.getEntity(slot1) then
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
	end

	if #string.split(slot0._actEffectMO.reserveStr, "|") > 0 then
		for slot7, slot8 in ipairs(slot3) do
			slot9 = string.split(slot8, "#")

			if FightEntityModel.instance:getById(slot9[1]) then
				slot12.position = tonumber(slot9[2]) or 1

				if FightHelper.getEntity(slot10) then
					slot14 = FlowSequence.New()

					slot14:addWork(WorkWaitSeconds.New(0.15 / FightModel.instance:getSpeed()))

					slot15 = FlowParallel.New()
					slot16, slot17, slot18, slot19 = FightHelper.getEntityStandPos(slot12)
					slot20 = 0.6 / FightModel.instance:getSpeed()

					slot15:addWork(TweenWork.New({
						type = "DOScale",
						tr = slot13.go.transform,
						to = slot19,
						t = slot20,
						ease = EaseType.InOutQuad
					}))
					slot15:addWork(TweenWork.New({
						from = 0,
						type = "DOTweenFloat",
						to = 1,
						t = slot20,
						frameCb = slot0._onFloat,
						cbObj = slot0,
						param = slot13,
						ease = EaseType.InOutQuad
					}))
					slot15:addWork(TweenWork.New({
						type = "DOMove",
						tr = slot13.go.transform,
						tox = slot16,
						toy = slot17,
						toz = slot18,
						t = slot20,
						ease = EaseType.InOutQuad
					}))
					slot14:addWork(slot15)
					slot0._flow:addWork(slot14)
					table.insert(slot0._cacheEntityIds, slot12.id)
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
