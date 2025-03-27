module("modules.logic.fight.model.mo.FightReasonMO", package.seeall)

slot0 = pureTable("FightReasonMO")

function slot0.init(slot0, slot1)
	slot0.type = slot1.type
	slot0.content = slot1.content
	slot0.episodeId = tonumber(slot0.content)
	slot0.battleId = slot1.battleId
	slot0.multiplication = slot1.multiplication
	slot0.data = slot1.data

	slot0:_parseData()
end

function slot0._parseData(slot0)
	if not slot0.episodeId then
		return
	end

	if DungeonConfig.instance:getEpisodeCO(slot0.episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		slot2 = string.splitToNumber(slot0.data, "#")
		slot0.layerId = slot2[2]
		slot0.elementId = slot2[3]
	elseif slot1.type == DungeonEnum.EpisodeType.Meilanni then
		slot2 = string.splitToNumber(slot0.data, "#")
		slot0.battleId = slot2[#slot2]
		slot0.eventEpisodeId = slot2[3]
	elseif slot1.type == DungeonEnum.EpisodeType.Dog then
		slot2 = string.splitToNumber(slot0.data, "#")
		slot0.fromChessGame = true
		slot0.actId = slot2[1]
		slot0.actElementId = slot2[2]
		slot0.battleId = slot2[3]
		slot0.actEpisodeId = slot2[4]
	elseif slot1.type == DungeonEnum.EpisodeType.TowerPermanent or slot1.type == DungeonEnum.EpisodeType.TowerBoss or slot1.type == DungeonEnum.EpisodeType.TowerLimited then
		slot2 = string.splitToNumber(slot0.data, "#")

		TowerModel.instance:setRecordFightParam(slot2[1], slot2[2], slot2[3], slot2[4], slot2[5])
	elseif slot1.type == DungeonEnum.EpisodeType.Season166Base or slot1.type == DungeonEnum.EpisodeType.Season166Train then
		Season166Model.instance:unpackFightReconnectData(slot0.data)
	end
end

return slot0
