module("modules.logic.versionactivity3_1.gaosiniao.config.GaoSiNiaoConfig", package.seeall)

local var_0_0 = class("GaoSiNiaoConfig", Activity210Config)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.episodeId
	local var_1_1 = arg_1_1.episodeId
	local var_1_2 = arg_1_0.preEpisodeId
	local var_1_3 = arg_1_1.preEpisodeId

	if var_1_2 ~= var_1_3 then
		return var_1_2 < var_1_3
	end

	return var_1_0 < var_1_1
end

function var_0_0.getConstAsNum(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:getConstWithActId(arg_2_0:actId(), arg_2_1)

	return tonumber(var_2_0) or arg_2_2
end

function var_0_0.getPathSpriteName(arg_3_0, arg_3_1)
	return "v3a1_gaosiniao_game_piece" .. arg_3_1
end

function var_0_0.getBloodSpriteName(arg_4_0, arg_4_1)
	return "v3a1_gaosiniao_game_blood" .. arg_4_1
end

function var_0_0.getGridSpriteName(arg_5_0, arg_5_1)
	return "v3a1_gaosiniao_game_grid" .. arg_5_1
end

function var_0_0.getEpisodeCOList(arg_6_0)
	local var_6_0 = arg_6_0:getEpisodeCOs(arg_6_0)
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1.type == GaoSiNiaoEnum.EpisodeType.SP then
			table.insert(var_6_2, iter_6_1)
		else
			table.insert(var_6_1, iter_6_1)
		end
	end

	table.sort(var_6_1, var_0_1)
	table.sort(var_6_2, var_0_1)

	return var_6_1, var_6_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
