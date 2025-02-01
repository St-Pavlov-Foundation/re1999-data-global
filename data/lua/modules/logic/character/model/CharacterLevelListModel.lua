module("modules.logic.character.model.CharacterLevelListModel", package.seeall)

slot0 = class("CharacterLevelListModel", ListScrollModel)

function slot0.setCharacterLevelList(slot0, slot1, slot2)
	slot3 = {}

	for slot11 = slot2 or slot1.level, CharacterModel.instance:getrankEffects(slot1.heroId, slot1.rank)[1] do
		slot3[#slot3 + 1] = {
			heroId = slot4,
			level = slot11
		}
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
