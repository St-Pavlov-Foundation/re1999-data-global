module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillAddDiamondMO", package.seeall)

slot0 = class("CharacterSkillAddDiamondMO", CharacterSkillMOBase)

function slot0.getEffectRound(slot0)
	return EliminateEnum.RoundType.TeamChess
end

return slot0
