module("modules.logic.login.model.ServerMO", package.seeall)

slot0 = pureTable("ServerMO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.name = nil
	slot0.state = nil
	slot0.prefix = nil
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.name = slot1.name
	slot0.state = slot1.state
	slot0.prefix = slot1.prefix
end

return slot0
