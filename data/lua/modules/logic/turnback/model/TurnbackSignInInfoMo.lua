module("modules.logic.turnback.model.TurnbackSignInInfoMo", package.seeall)

slot0 = pureTable("TurnbackSignInInfoMo")

function slot0.ctor(slot0)
	slot0.turnbackId = 0
	slot0.id = 0
	slot0.state = 0
	slot0.config = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.turnbackId = slot2
	slot0.id = slot1.id
	slot0.state = slot1.state
	slot0.config = TurnbackConfig.instance:getTurnbackSignInDayCo(slot0.turnbackId, slot0.id)
end

function slot0.updateState(slot0, slot1)
	slot0.state = slot1
end

return slot0
