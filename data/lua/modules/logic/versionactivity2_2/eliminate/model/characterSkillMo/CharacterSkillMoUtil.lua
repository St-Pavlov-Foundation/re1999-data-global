module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillMoUtil", package.seeall)

slot0 = class("CharacterSkillMoUtil")

function slot0.createMO(slot0)
	slot1 = nil

	if slot0 == "AddDiamond" then
		slot1 = CharacterSkillAddDiamondMO.New()
	end

	if slot0 == "EliminationCross" then
		slot1 = CharacterSkillEliminationCrossMO.New()
	end

	if slot0 == "EliminationRange" then
		slot1 = CharacterSkillEliminationRangeMO.New()
	end

	if slot0 == "EliminationSpecificColor" then
		slot1 = CharacterSkillEliminationSpecificColorMO.New()
	end

	if slot0 == "EliminationSwap" then
		slot1 = CharacterSkillEliminationSwapMO.New()
	end

	if slot1 == nil then
		logError("CharacterSkillMoUtil:createMO" .. slot0 .. " is not exist!")

		slot1 = CharacterSkillMOBase.New()
	end

	return slot1
end

return slot0
