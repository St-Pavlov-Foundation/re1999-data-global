module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameSkillEffectMo", package.seeall)

local var_0_0 = pureTable("YaXianGameSkillEffectMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.effectType = arg_2_1.effectType
	arg_2_0.effectUid = arg_2_1.effectUid
	arg_2_0.remainRound = arg_2_1.remainRound
	arg_2_0.skillId = arg_2_1.skillId
	arg_2_0.skillMo = YaXianGameModel.instance:getSkillMo(arg_2_0.skillId)
end

return var_0_0
