module("modules.logic.meilanni.model.EpisodeInfoMO", package.seeall)

local var_0_0 = pureTable("EpisodeInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.leftActPoint = arg_1_1.leftActPoint
	arg_1_0.confirm = arg_1_1.confirm

	arg_1_0:_initEvents(arg_1_1)
	arg_1_0:_initHistorylist(arg_1_1)

	arg_1_0.episodeConfig = lua_activity108_episode.configDict[arg_1_0.episodeId]
end

function var_0_0._initEvents(arg_2_0, arg_2_1)
	arg_2_0.events = {}
	arg_2_0.eventMap = {}
	arg_2_0.specialEventNum = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.events) do
		local var_2_0 = EpisodeEventMO.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0.events, var_2_0)

		arg_2_0.eventMap[var_2_0.eventId] = var_2_0

		if not var_2_0.isFinish and var_2_0.config.type == 1 then
			arg_2_0.specialEventNum = arg_2_0.specialEventNum + 1
		end
	end
end

function var_0_0._initHistorylist(arg_3_0, arg_3_1)
	arg_3_0.historylist = {}

	local var_3_0
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.historylist) do
		local var_3_2 = EpisodeHistoryMO.New()

		var_3_2:init(iter_3_1)
		table.insert(arg_3_0.historylist, var_3_2)

		if iter_3_1.eventId ~= var_3_0 then
			var_3_0 = iter_3_1.eventId
			var_3_1 = var_3_1 + 1
		end
	end

	arg_3_0.historyLen = var_3_1
end

function var_0_0.getEventInfo(arg_4_0, arg_4_1)
	return arg_4_0.eventMap[arg_4_1]
end

function var_0_0.getEventByBattleId(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.events) do
		if iter_5_1:getConfigBattleId() == arg_5_1 then
			return iter_5_1
		end
	end
end

return var_0_0
