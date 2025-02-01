module("modules.logic.fight.view.FightTechniqueSelectItem", package.seeall)

slot0 = class("FightTechniqueSelectItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._selectGos = slot0:getUserDataTb_()

	for slot5 = 1, 2 do
		table.insert(slot0._selectGos, gohelper.findChild(slot1, "item" .. slot5))
	end

	slot0._click = gohelper.getClickWithAudio(slot0.go)
end

function slot0.updateItem(slot0, slot1)
	slot0._index = slot1.index
	slot0._id = slot1.id

	transformhelper.setLocalPos(slot0.go.transform, slot1.pos, 0, 0)
end

function slot0.setView(slot0, slot1)
	slot0._view = slot1
end

function slot0.setSelect(slot0, slot1)
	slot2 = slot0._index == slot1

	gohelper.setActive(slot0._selectGos[1], slot2)
	gohelper.setActive(slot0._selectGos[2], not slot2)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onDestroy(slot0)
	slot0._view = nil
end

function slot0._onClickThis(slot0)
	slot0._view:setSelect(slot0._index)
end

return slot0
