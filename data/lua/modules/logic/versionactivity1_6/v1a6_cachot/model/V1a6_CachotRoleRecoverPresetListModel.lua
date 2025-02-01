module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRecoverPresetListModel", package.seeall)

slot0 = class("V1a6_CachotRoleRecoverPresetListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getEquip(slot0, slot1)
	return slot0._equipMap[slot1]
end

function slot0.initList(slot0)
	V1a6_CachotTeamModel.instance:clearSeatInfos()

	slot2 = V1a6_CachotModel.instance:getRogueInfo().teamInfo
	slot0._equipMap = {}
	slot5 = {}

	for slot9 = 1, V1a6_CachotEnum.HeroCountInGroup do
		slot10 = slot2:getGroupLiveHeros()[slot9]

		table.insert(slot5, slot10)

		slot0._equipMap[slot10] = slot2:getGroupEquips()[slot9]

		V1a6_CachotTeamModel.instance:setSeatInfo(slot9, V1a6_CachotTeamModel.instance:getSeatLevel(slot9), slot10)
	end

	slot0:setList(slot5)
end

slot0.instance = slot0.New()

return slot0
