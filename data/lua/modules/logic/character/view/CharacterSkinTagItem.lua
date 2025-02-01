module("modules.logic.character.view.CharacterSkinTagItem", package.seeall)

slot0 = class("CharacterSkinTagItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._color2 = gohelper.findChild(slot0.viewGO, "color2")
	slot0._color3 = gohelper.findChild(slot0.viewGO, "color3")
	slot0._color4 = gohelper.findChild(slot0.viewGO, "color4")
	slot0._color5 = gohelper.findChild(slot0.viewGO, "color5")
	slot0._txt = gohelper.findChildText(slot0.viewGO, "text")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._txt.text = slot1.desc

	gohelper.setActive(slot0._color2, slot1.color == 2)
	gohelper.setActive(slot0._color3, slot1.color == 3)
	gohelper.setActive(slot0._color4, slot1.color == 4)
	gohelper.setActive(slot0._color5, slot1.color == 5)
end

return slot0
