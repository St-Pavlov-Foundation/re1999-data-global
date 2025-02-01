module("modules.logic.weekwalk.model.WeekWalkCharacterModel", package.seeall)

slot0 = class("WeekWalkCharacterModel", CharacterModel)

function slot0._setCharacterCardList(slot0, slot1)
	WeekWalkCardListModel.instance:setCharacterList(slot1)
end

slot0.instance = slot0.New()

return slot0
