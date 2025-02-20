module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRecoverPrepareListModel", package.seeall)

slot0 = class("V1a6_CachotRoleRecoverPrepareListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initList(slot0)
	slot3 = V1a6_CachotModel.instance:getRogueInfo().teamInfo:getSupportLiveHeros()

	table.sort(slot3, uv0.sort)

	slot8 = 1

	for slot8 = #slot3 + 1, math.max(math.ceil(#slot3 / 4), slot8) * 4 do
		table.insert(slot3, HeroSingleGroupMO.New())
	end

	slot0:setList(slot3)
end

function slot0.sort(slot0, slot1)
	if slot0.hp ~= slot1.hp then
		return slot1.hp < slot0.hp
	end

	if slot0._heroMO.config.rare ~= slot1._heroMO.config.rare then
		return slot1.config.rare < slot0.config.rare
	elseif slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	elseif slot0.heroId ~= slot1.heroId then
		return slot1.heroId < slot0.heroId
	end
end

slot0.instance = slot0.New()

return slot0
