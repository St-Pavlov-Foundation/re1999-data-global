module("modules.logic.versionactivity1_2.yaxian.model.YaXianEpisodeMo", package.seeall)

local var_0_0 = pureTable("YaXianEpisodeMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.star = arg_2_1.star
	arg_2_0.totalCount = arg_2_1.totalCount
	arg_2_0.config = YaXianConfig.instance:getEpisodeConfig(YaXianEnum.ActivityId, arg_2_0.id)
end

function var_0_0.updateData(arg_3_0, arg_3_1)
	arg_3_0.star = arg_3_1.star
	arg_3_0.totalCount = arg_3_1.totalCount
end

return var_0_0
