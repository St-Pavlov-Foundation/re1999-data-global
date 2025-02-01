module("modules.logic.versionactivity1_2.yaxian.model.YaXianMapMo", package.seeall)

slot0 = pureTable("YaXianMapMo")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.episodeId = slot1.id
	slot0.currentRound = slot1.currentRound
	slot0.currentEvent = slot1.currentEvent

	slot0:updateInteractObjects(slot1.interactObjects)
	slot0:updateFinishInteracts(slot1.finishInteracts)

	slot0.episodeCo = YaXianConfig.instance:getEpisodeConfig(slot0.actId, slot0.episodeId)
	slot0.mapId = slot0.episodeCo.mapId
end

function slot0.updateInteractObjects(slot0, slot1)
	slot0.interactObjs = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = YaXianGameInteractMO.New()

		slot7:init(slot0.actId, slot6)
		table.insert(slot0.interactObjs, slot7)
	end
end

function slot0.updateFinishInteracts(slot0, slot1)
	slot0.finishInteracts = slot1
end

return slot0
