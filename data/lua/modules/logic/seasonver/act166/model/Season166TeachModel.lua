module("modules.logic.seasonver.act166.model.Season166TeachModel", package.seeall)

local var_0_0 = class("Season166TeachModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:cleanData()
end

function var_0_0.cleanData(arg_3_0)
	arg_3_0.curTeachId = 0
	arg_3_0.curTeachConfig = nil
	arg_3_0.curEpisodeId = nil
end

function var_0_0.initTeachData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.actId = arg_4_1
	arg_4_0.curTeachId = arg_4_2
	arg_4_0.curTeachConfig = Season166Config.instance:getSeasonTeachCos(arg_4_2)
	arg_4_0.curEpisodeId = arg_4_0.curBaseSpotConfig and arg_4_0.curBaseSpotConfig.episodeId
end

function var_0_0.checkIsAllTeachFinish(arg_5_0, arg_5_1)
	local var_5_0 = Season166Model.instance:getActInfo(arg_5_1)
	local var_5_1 = Season166Config.instance:getAllSeasonTeachCos()
	local var_5_2 = true

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_3 = var_5_0.teachInfoMap[iter_5_1.teachId]

		if not var_5_3 or var_5_3.passCount == 0 then
			var_5_2 = false

			break
		end
	end

	return var_5_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
