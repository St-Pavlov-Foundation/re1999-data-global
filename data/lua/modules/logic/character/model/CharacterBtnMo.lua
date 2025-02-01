module("modules.logic.character.model.CharacterBtnMo", package.seeall)

slot0 = pureTable("CharacterBtnMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.name = ""
	slot0.icon = ""
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.name = slot1.name
	slot0.icon = slot1.iconres
end

return slot0
