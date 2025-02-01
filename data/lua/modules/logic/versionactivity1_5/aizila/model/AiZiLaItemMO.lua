module("modules.logic.versionactivity1_5.aizila.model.AiZiLaItemMO", package.seeall)

slot0 = pureTable("AiZiLaItemMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.uid = slot1
	slot0.itemId = slot2 or 0
	slot0.quantity = slot3 or 0
end

function slot0.getConfig(slot0)
	if not slot0._config then
		slot0._config = AiZiLaConfig.instance:getItemCo(slot0.itemId)
	end

	return slot0._config
end

function slot0.updateInfo(slot0, slot1)
	slot0.itemId = slot1.itemId
	slot0.quantity = slot1.quantity
end

function slot0.addInfo(slot0, slot1)
	if slot0.itemId == slot1.itemId then
		slot0.quantity = slot0.quantity + slot1.quantity
	end
end

function slot0.getQuantity(slot0)
	return slot0.quantity
end

return slot0
