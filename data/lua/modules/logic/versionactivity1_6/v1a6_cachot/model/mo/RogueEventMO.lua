module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueEventMO", package.seeall)

slot0 = pureTable("RogueEventMO")

function slot0.init(slot0, slot1)
	slot0.eventId = slot1.eventId
	slot0.status = slot1.status
	slot0.eventData = slot1.eventData
	slot0.option = slot1.option
	slot0._eventJsonData = nil
end

function slot0.getEventCo(slot0)
	if not slot0.co then
		slot0.co = lua_rogue_event.configDict[slot0.eventId]
	end

	return slot0.co
end

function slot0.getBattleData(slot0)
	if not slot0:getEventCo() or slot1.type ~= V1a6_CachotEnum.EventType.Battle then
		return
	end

	return slot0:_getJsonData()
end

function slot0._getJsonData(slot0)
	if not slot0._eventJsonData then
		if string.nilorempty(slot0.eventData) then
			slot0._eventJsonData = {}
		else
			slot0._eventJsonData = cjson.decode(slot0.eventData)
		end
	end

	return slot0._eventJsonData
end

function slot0.isBattleSuccess(slot0)
	if not slot0:getBattleData() then
		return false
	end

	return slot1.status == 1
end

function slot0.getRetries(slot0)
	if not slot0:getBattleData() then
		return 0
	end

	return slot1.retries or 0
end

function slot0.getDropList(slot0)
	if slot0.status == V1a6_CachotEnum.EventStatus.Finish then
		return
	end

	if not slot0:_getJsonData() then
		return
	end

	if slot1.status == 1 then
		if string.nilorempty(slot1.drop) then
			return {}
		end

		slot2 = {}

		for slot7, slot8 in ipairs(cjson.decode(slot1.drop)) do
			if slot8.status == 0 then
				slot9 = false

				if slot8.type == "EVENT" and lua_rogue_event.configDict[slot8.value] and slot10.type == V1a6_CachotEnum.EventType.ChoiceSelect then
					slot9 = true
				end

				if not slot9 then
					table.insert(slot2, slot8)
				end
			end
		end

		return slot2
	end
end

return slot0
