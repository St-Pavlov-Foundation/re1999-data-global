module("modules.logic.fight.system.work.FightWorkAppearPerformance", package.seeall)

slot0 = class("FightWorkAppearPerformance", BaseWork)

function slot0.onStart(slot0)
	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(FightWorkAppearTimeline.New())

	slot1, slot2 = FightWorkAppearTimeline.hasAppearTimeline()
	slot4 = FightHelper.getEntity(slot2) and slot3:getMO()

	if slot1 and slot4 then
		slot0._flow:addWork(FunctionWork.New(function ()
			for slot4, slot5 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
				if slot5.nameUI then
					slot5.nameUI:setActive(false)
				end

				if slot5.setAlpha then
					slot5:setAlpha(0, 0)
				end
			end
		end))
		slot0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterAppearTimeline, slot4.modelId))
	end

	slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0._flow:start()
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
