module("modules.logic.critter.model.info.CritterSkillInfoMO", package.seeall)

local var_0_0 = pureTable("CritterSkillInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if not arg_1_0.tags or #arg_1_0.tags > 0 then
		arg_1_0.tags = {}
	end

	if arg_1_1 and arg_1_1.tags then
		tabletool.addValues(arg_1_0.tags, arg_1_1.tags)
	end
end

function var_0_0.getTags(arg_2_0)
	return arg_2_0.tags
end

return var_0_0
