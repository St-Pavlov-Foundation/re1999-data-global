module("modules.logic.character.model.CharacterBtnListModel", package.seeall)

slot0 = class("CharacterBtnListModel", ListScrollModel)

function slot0.setCharacterBtnList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in LuaUtil.pairsByKeys(slot1) do
			slot8 = CharacterBtnMo.New()

			slot8:init(slot7)
			table.insert(slot2, slot8)
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
