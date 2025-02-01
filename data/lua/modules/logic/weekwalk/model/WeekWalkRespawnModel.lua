module("modules.logic.weekwalk.model.WeekWalkRespawnModel", package.seeall)

slot0 = class("WeekWalkRespawnModel", ListScrollModel)

function slot0.setRespawnList(slot0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.WeekWalk)

	slot3 = {}

	for slot7, slot8 in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
		if WeekWalkModel.instance:getInfo():getHeroHp(slot8.heroId) and slot9 <= 0 then
			table.insert(slot3, slot8)
		end
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
