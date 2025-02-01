module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRevivalPrepareListModel", package.seeall)

slot0 = class("V1a6_CachotRoleRevivalPrepareListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(V1a6_CachotModel.instance:getTeamInfo().lifes) do
		if slot7.life <= 0 then
			slot9 = HeroSingleGroupMO.New()
			slot9.heroUid = HeroModel.instance:getByHeroId(slot7.heroId).uid

			table.insert(slot1, slot9)
		end
	end

	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
