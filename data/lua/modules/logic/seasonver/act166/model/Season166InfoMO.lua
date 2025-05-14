module("modules.logic.seasonver.act166.model.Season166InfoMO", package.seeall)

local var_0_0 = pureTable("Season166InfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = 0
	arg_1_0.stage = 0
	arg_1_0.bonusStage = 0
	arg_1_0.activityId = arg_1_1
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.stage = arg_2_1.stage
	arg_2_0.bonusStage = arg_2_1.bonusStage
end

function var_0_0.hasAnaly(arg_3_0)
	return (Season166Config.instance:getSeasonInfoAnalys(arg_3_0.activityId, arg_3_0.id) or {})[arg_3_0.stage + 1] == nil
end

return var_0_0
