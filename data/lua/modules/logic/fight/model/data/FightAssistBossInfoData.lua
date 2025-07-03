module("modules.logic.fight.model.data.FightAssistBossInfoData", package.seeall)

local var_0_0 = FightDataClass("FightAssistBossInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.skills = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.skills) do
		table.insert(arg_1_0.skills, FightAssistBossSkillInfoData.New(iter_1_1))
	end

	arg_1_0.currCd = arg_1_1.currCd
	arg_1_0.cdCfg = arg_1_1.cdCfg
	arg_1_0.formId = arg_1_1.formId
	arg_1_0.roundUseLimit = arg_1_1.roundUseLimit
	arg_1_0.exceedUseFree = arg_1_1.exceedUseFree
	arg_1_0.params = arg_1_1.params
end

return var_0_0
