module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueCollectionMO", package.seeall)

slot0 = pureTable("RogueCollectionMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.uid
	slot0.cfgId = slot1.id
	slot0.leftUid = slot1.leftUid
	slot0.rightUid = slot1.rightUid
	slot0.baseId = slot1.baseId
	slot0.enchantUid = slot1.enchantUid
end

function slot0.getEnchantId(slot0, slot1)
	return slot1 == V1a6_CachotEnum.CollectionHole.Left and slot0.leftUid or slot0.rightUid
end

function slot0.isEnchant(slot0)
	return slot0.enchantUid and slot0.enchantUid ~= 0
end

function slot0.getEnchantCount(slot0)
	if slot0.leftUid and slot0.leftUid ~= V1a6_CachotEnum.EmptyEnchantId then
		slot1 = 0 + 1
	end

	if slot0.rightUid and slot0.rightUid ~= V1a6_CachotEnum.EmptyEnchantId then
		slot1 = slot1 + 1
	end

	return slot1
end

return slot0
