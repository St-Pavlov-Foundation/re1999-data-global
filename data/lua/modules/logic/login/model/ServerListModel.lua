module("modules.logic.login.model.ServerListModel", package.seeall)

slot0 = class("ServerListModel", ListScrollModel)

function slot0.setServerList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = ServerMO.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
