module("modules.logic.tower.model.TowerSubEpisodeMo", package.seeall)

slot0 = pureTable("TowerSubEpisodeMo")

function slot0.updateInfo(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.status = slot1.status
	slot0.heroIds = slot1.heroIds
	slot0.assistBossId = slot1.assistBossId
end

function slot0.getHeros(slot0, slot1)
	if slot0.status == 1 and slot0.heroIds then
		for slot5 = 1, #slot0.heroIds do
			slot1[slot0.heroIds[slot5]] = 1
		end
	end
end

function slot0.getAssistBossId(slot0, slot1)
	if slot0.status == 1 and slot0.assistBossId then
		slot1[slot0.assistBossId] = 1
	end
end

return slot0
