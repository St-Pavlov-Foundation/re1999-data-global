module("modules.logic.versionactivity2_5.liangyue.model.LiangYueInfoMo", package.seeall)

slot0 = pureTable("LiangYueInfoMo")

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.actId = slot1
	slot0.episodeId = slot2
	slot0.isFinish = slot3
	slot0.puzzle = slot4

	if LiangYueConfig.instance:getEpisodeConfigByActAndId(slot1, slot2) == nil then
		logError("config is nil" .. slot2)

		return
	end

	slot0.config = slot5
	slot0.preEpisodeId = slot5.preEpisodeId
end

function slot0.updateMO(slot0, slot1, slot2)
	slot0.isFinish = slot1
	slot0.puzzle = slot2
end

return slot0
