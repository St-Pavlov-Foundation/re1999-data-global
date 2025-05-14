module("modules.logic.ressplit.work.ResSplitSeasonWork", package.seeall)

local var_0_0 = class("ResSplitSeasonWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(ResSplitModel.instance.includeSeasonDic) do
		local var_1_0 = SeasonConfig.instance:getSeasonEpisodeCos(iter_1_0)
		local var_1_1 = SeasonConfig.instance:getSeasonRetailCos(iter_1_0)
		local var_1_2 = SeasonConfig.instance:getSeasonSpecialCos(iter_1_0)
		local var_1_3 = {}

		for iter_1_2, iter_1_3 in pairs(var_1_0) do
			var_1_3[iter_1_3.episodeId] = true

			ResSplitModel.instance:addIncludeStory(iter_1_3.afterStoryId)
		end

		for iter_1_4, iter_1_5 in pairs(var_1_1) do
			local var_1_4 = string.splitToNumber(iter_1_5.retailEpisodeIdPool, "#")

			for iter_1_6, iter_1_7 in pairs(var_1_4) do
				var_1_3[iter_1_7] = true
			end
		end

		for iter_1_8, iter_1_9 in pairs(var_1_2) do
			var_1_3[iter_1_9.episodeId] = true
		end

		for iter_1_10, iter_1_11 in pairs(var_1_3) do
			ResSplitHelper.addEpisodeRes(iter_1_10)
		end

		local var_1_5 = SeasonConfig.instance:getStoryIds(iter_1_0)

		for iter_1_12, iter_1_13 in ipairs(var_1_5) do
			ResSplitModel.instance:addIncludeStory(iter_1_13)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
