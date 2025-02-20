module("modules.logic.character.model.DestinyStoneMO", package.seeall)

slot0 = class("DestinyStoneMO")

function slot0.initMo(slot0, slot1)
	slot0.stoneId = slot1
	slot0.facetCos = CharacterDestinyConfig.instance:getDestinyFacetCo(slot1)
	slot0.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(slot1)
end

function slot0.refresUnlock(slot0, slot1)
	slot0.isUnlock = slot1
end

function slot0.refreshUse(slot0, slot1)
	slot0.isUse = slot1
end

function slot0.getFacetCo(slot0, slot1)
	if slot1 then
		return slot0.facetCos[slot1]
	end

	return slot0.facetCos
end

function slot0.getNameAndIcon(slot0)
	return slot0.conusmeCo.name, ResUrl.getDestinyIcon(slot0.conusmeCo.icon), slot0.conusmeCo
end

return slot0
