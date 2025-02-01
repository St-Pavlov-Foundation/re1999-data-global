module("modules.logic.versionactivity1_5.aizila.model.AiZiLaHandbookMO", package.seeall)

slot0 = pureTable("AiZiLaHandbookMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.itemId = slot1 or 0
	slot0._redPointKey = AiZiLaHelper.getRedKey(RedDotEnum.DotNode.V1a5AiZiLaHandbookNew, slot0.itemId)
end

function slot0.getConfig(slot0)
	if not slot0._config then
		slot0._config = AiZiLaConfig.instance:getItemCo(slot0.itemId)
	end

	return slot0._config
end

function slot0.getQuantity(slot0)
	return AiZiLaModel.instance:getItemQuantity(slot0.itemId)
end

function slot0.isHasRed(slot0)
	if AiZiLaModel.instance:isCollectItemId(slot0.itemId) and not AiZiLaHelper.isFinishRed(slot0._redPointKey) then
		return true
	end

	return false
end

function slot0.finishRed(slot0)
	AiZiLaHelper.finishRed(slot0._redPointKey)
end

function slot0.getRedUid(slot0)
	return slot0.itemId
end

return slot0
