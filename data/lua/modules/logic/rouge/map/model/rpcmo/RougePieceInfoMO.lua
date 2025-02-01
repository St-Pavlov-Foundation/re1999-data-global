module("modules.logic.rouge.map.model.rpcmo.RougePieceInfoMO", package.seeall)

slot0 = pureTable("RougePieceInfoMO")

function slot0.init(slot0, slot1)
	slot0.index = slot1.index
	slot0.id = slot1.id
	slot0.talkId = slot1.talkId
	slot0.finish = slot1.finish
	slot0.selectId = slot1.selectId

	slot0:updateTriggerStr(slot1.triggerStr)

	slot0.pieceCo = RougeMapConfig.instance:getPieceCo(slot0.id)
end

function slot0.update(slot0, slot1)
	slot0.finish = slot1.finish
	slot0.selectId = slot1.selectId

	slot0:updateTriggerStr(slot1.triggerStr)
end

function slot0.updateTriggerStr(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == "null" then
		slot0.triggerStr = nil
	else
		slot0.triggerStr = cjson.decode(slot1)
	end
end

function slot0.getPieceCo(slot0)
	return slot0.pieceCo
end

function slot0.isFinish(slot0)
	return slot0.finish
end

return slot0
