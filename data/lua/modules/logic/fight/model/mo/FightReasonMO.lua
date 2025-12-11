module("modules.logic.fight.model.mo.FightReasonMO", package.seeall)

local var_0_0 = pureTable("FightReasonMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type
	arg_1_0.content = arg_1_1.content
	arg_1_0.episodeId = tonumber(arg_1_0.content)
	arg_1_0.battleId = arg_1_1.battleId
	arg_1_0.multiplication = arg_1_1.multiplication
	arg_1_0.data = arg_1_1.data

	arg_1_0:_parseData()
end

function var_0_0._parseData(arg_2_0)
	if not arg_2_0.episodeId then
		return
	end

	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_0.episodeId)

	if var_2_0.type == DungeonEnum.EpisodeType.WeekWalk or var_2_0.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		local var_2_1 = string.splitToNumber(arg_2_0.data, "#")

		arg_2_0.layerId = var_2_1[2]
		arg_2_0.elementId = var_2_1[3]
	elseif var_2_0.type == DungeonEnum.EpisodeType.Meilanni then
		local var_2_2 = string.splitToNumber(arg_2_0.data, "#")

		arg_2_0.battleId = var_2_2[#var_2_2]
		arg_2_0.eventEpisodeId = var_2_2[3]
	elseif var_2_0.type == DungeonEnum.EpisodeType.Dog then
		local var_2_3 = string.splitToNumber(arg_2_0.data, "#")

		arg_2_0.fromChessGame = true
		arg_2_0.actId = var_2_3[1]
		arg_2_0.actElementId = var_2_3[2]
		arg_2_0.battleId = var_2_3[3]
		arg_2_0.actEpisodeId = var_2_3[4]
	elseif var_2_0.type == DungeonEnum.EpisodeType.TowerPermanent or var_2_0.type == DungeonEnum.EpisodeType.TowerBoss or var_2_0.type == DungeonEnum.EpisodeType.TowerLimited or var_2_0.type == DungeonEnum.EpisodeType.TowerBossTeach then
		local var_2_4 = string.splitToNumber(arg_2_0.data, "#")

		TowerModel.instance:setRecordFightParam(var_2_4[1], var_2_4[2], var_2_4[3], var_2_4[4], var_2_4[5])
	elseif var_2_0.type == DungeonEnum.EpisodeType.TowerDeep then
		TowerDeepRpc.instance:sendTowerDeepGetInfoRequest()
		TowerModel.instance:setRecordFightParam(nil, nil, nil, nil, arg_2_0.episodeId)
	elseif var_2_0.type == DungeonEnum.EpisodeType.Season166Base or var_2_0.type == DungeonEnum.EpisodeType.Season166Train then
		Season166Model.instance:unpackFightReconnectData(arg_2_0.data)
	elseif var_2_0.type == DungeonEnum.EpisodeType.Act183 then
		Act183Controller.instance:onReconnectFight(arg_2_0.episodeId)
	end
end

return var_0_0
