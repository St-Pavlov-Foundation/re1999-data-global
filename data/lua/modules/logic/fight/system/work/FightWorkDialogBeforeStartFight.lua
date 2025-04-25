module("modules.logic.fight.system.work.FightWorkDialogBeforeStartFight", package.seeall)

slot0 = class("FightWorkDialogBeforeStartFight", BaseWork)

function slot0.onStart(slot0)
	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(FunctionWork.New(slot0._setHudState, slot0))
	slot0._flow:addWork(FunctionWork.New(slot0._setFightViewState, slot0, true))
	slot0._flow:addWork(FunctionWork.New(slot0._setEntityState, slot0, false))
	slot0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.BeforeStartFight))
	slot0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.BeforeStartFightAndXXTimesEnterBattleId))
	slot0._flow:addWork(FunctionWork.New(slot0._setFightViewState, slot0, false))
	slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0._flow:start()
end

function slot0._setHudState(slot0)
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function slot0._setFightViewState(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.SetStateForDialogBeforeStartFight, slot1)
end

function slot0._setEntityState(slot0, slot1)
	FightViewPartVisible.set()

	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		if slot7.nameUI then
			slot7.nameUI:setActive(slot1)
		end

		if slot7.setAlpha then
			slot7:setAlpha(slot1 and 1 or 0, 0)
		end
	end
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0.revertState(slot0)
	if not slot0._reverStateDone then
		slot0._reverStateDone = true

		slot0:_setFightViewState(false)
		slot0:_setEntityState(true)
	end
end

function slot0.clearWork(slot0)
	slot0:revertState()

	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
