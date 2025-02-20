module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamPreviewPrepareListModel", package.seeall)

slot0 = class("V1a6_CachotTeamPreviewPrepareListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initList(slot0)
	slot3 = V1a6_CachotModel.instance:getRogueInfo().teamInfo:getSupportHeros()
	slot8 = 1

	for slot8 = #slot3 + 1, math.max(math.ceil(#slot3 / 4), slot8) * 4 do
		table.insert(slot3, HeroSingleGroupMO.New())
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
