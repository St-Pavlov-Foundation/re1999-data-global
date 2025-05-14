module("modules.logic.versionactivity2_2.eliminate.model.mo.WarEpisodeInfo", package.seeall)

local var_0_0 = pureTable("WarEpisodeInfo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:initFromParam(arg_1_1.id, arg_1_1.star)
end

function var_0_0.initFromParam(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.star = arg_2_2
	arg_2_0.config = lua_eliminate_episode.configDict[arg_2_0.id]
end

return var_0_0
