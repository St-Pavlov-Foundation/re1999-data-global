module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillMoUtil", package.seeall)

local var_0_0 = class("CharacterSkillMoUtil")

function var_0_0.createMO(arg_1_0)
	local var_1_0

	if arg_1_0 == "AddDiamond" then
		var_1_0 = CharacterSkillAddDiamondMO.New()
	end

	if arg_1_0 == "EliminationCross" then
		var_1_0 = CharacterSkillEliminationCrossMO.New()
	end

	if arg_1_0 == "EliminationRange" then
		var_1_0 = CharacterSkillEliminationRangeMO.New()
	end

	if arg_1_0 == "EliminationSpecificColor" then
		var_1_0 = CharacterSkillEliminationSpecificColorMO.New()
	end

	if arg_1_0 == "EliminationSwap" then
		var_1_0 = CharacterSkillEliminationSwapMO.New()
	end

	if var_1_0 == nil then
		logError("CharacterSkillMoUtil:createMO" .. arg_1_0 .. " is not exist!")

		var_1_0 = CharacterSkillMOBase.New()
	end

	return var_1_0
end

return var_0_0
