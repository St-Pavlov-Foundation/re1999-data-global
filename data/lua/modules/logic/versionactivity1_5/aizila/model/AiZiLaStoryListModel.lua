module("modules.logic.versionactivity1_5.aizila.model.AiZiLaStoryListModel", package.seeall)

local var_0_0 = class("AiZiLaStoryListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = AiZiLaConfig.instance:getStoryList(arg_1_1)
	local var_1_1 = {}

	arg_1_0._episodeId = arg_1_2

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			if AiZiLaEnum.AllStoryEpisodeId == arg_1_2 or iter_1_1.episodeId == arg_1_2 then
				local var_1_2 = AiZiLaStoryMO.New()

				var_1_2:init(iter_1_0, iter_1_1)
				table.insert(var_1_1, var_1_2)
			end
		end
	end

	if #var_1_1 > 1 then
		table.sort(var_1_1, var_0_0.sortMO)
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		iter_1_3.index = iter_1_2
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0.sortMO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.config.order
	local var_2_1 = arg_2_1.config.order

	if var_2_0 ~= var_2_1 then
		return var_2_0 < var_2_1
	end
end

function var_0_0.getEpisodeId(arg_3_0)
	return arg_3_0._episodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
