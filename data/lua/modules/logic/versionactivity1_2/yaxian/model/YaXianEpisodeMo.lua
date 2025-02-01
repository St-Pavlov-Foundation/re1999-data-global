module("modules.logic.versionactivity1_2.yaxian.model.YaXianEpisodeMo", package.seeall)

slot0 = pureTable("YaXianEpisodeMo")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.id = slot1.id
	slot0.star = slot1.star
	slot0.totalCount = slot1.totalCount
	slot0.config = YaXianConfig.instance:getEpisodeConfig(YaXianEnum.ActivityId, slot0.id)
end

function slot0.updateData(slot0, slot1)
	slot0.star = slot1.star
	slot0.totalCount = slot1.totalCount
end

return slot0
