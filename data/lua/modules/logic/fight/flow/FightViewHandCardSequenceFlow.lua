module("modules.logic.fight.flow.FightViewHandCardSequenceFlow", package.seeall)

slot0 = class("FlowSequence", FlowSequence)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowCreate, slot0)
end

function slot0.start(slot0, slot1)
	uv0.super.start(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowStart, slot0)
end

function slot0.onDone(slot0, slot1)
	uv0.super.onDone(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, slot0)
end

function slot0.stop(slot0)
	uv0.super.stop(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, slot0)
end

return slot0
