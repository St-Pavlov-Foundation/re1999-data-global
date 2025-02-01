module("modules.logic.fight.model.FightReplayModel", package.seeall)

slot0 = class("FightReplayModel", BaseModel)

function slot0.onInit(slot0)
	slot0._isReplay = false
end

function slot0.reInit(slot0)
	slot0._isReplay = false
end

function slot0.isReplay(slot0)
	if FightModel.instance:getVersion() >= 1 then
		return FightModel.instance:isRecord()
	end

	return slot0._isReplay
end

function slot0.setReconnectReplay(slot0, slot1)
	slot0._reconnectReplay = slot1
end

function slot0.isReconnectReplay(slot0)
	return slot0._reconnectReplay
end

function slot0.setReplay(slot0, slot1)
	slot0._isReplay = slot1
end

function slot0.onReceiveGetFightOperReply(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.operRecords) do
		slot8 = FightRoundOperRecordMO.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
