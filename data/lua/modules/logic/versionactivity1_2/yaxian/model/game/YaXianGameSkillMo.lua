module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameSkillMo", package.seeall)

local var_0_0 = pureTable("YaXianGameSkillMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.skillId
	arg_2_0.canUseCount = arg_2_1.canUseCount
	arg_2_0.config = YaXianConfig.instance:getSkillConfig(arg_2_0.actId, arg_2_0.id)
end

return var_0_0
