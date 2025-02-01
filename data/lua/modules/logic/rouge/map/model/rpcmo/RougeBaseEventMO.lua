module("modules.logic.rouge.map.model.rpcmo.RougeBaseEventMO", package.seeall)

slot0 = pureTable("RougeBaseEventMO")

function slot0.init(slot0, slot1, slot2)
	slot0.eventCo = slot1
	slot0.jsonData = cjson.decode(slot2)
	slot0.state = slot0.jsonData.state
	slot0.eventId = slot0.jsonData.eventId
	slot0.type = slot0.jsonData.type
	slot0.fightFail = slot0.jsonData.fightFail
end

function slot0.update(slot0, slot1, slot2)
	slot0.eventCo = slot1
	slot0.jsonData = cjson.decode(slot2)
	slot0.eventId = slot0.jsonData.eventId
	slot0.type = slot0.jsonData.type
	slot0.fightFail = slot0.jsonData.fightFail

	if slot0.state ~= slot0.jsonData.state then
		slot0.state = slot0.jsonData.state

		RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeEventStatusChange, slot0.eventId, slot0.state)
	end
end

function slot0.__tostring(slot0)
	return string.format("eventId : %s, jsonData : %s, state : %s, type : %s, fightFail : %s", slot0.eventId, cjson.encode(slot0.jsonData), slot0.state, slot0.type, slot0.fightFail)
end

return slot0
