module("modules.logic.help.view.HelpSelectItem", package.seeall)

slot0 = class("HelpSelectItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
end

function slot0.init(slot0, slot1)
	slot0._go = slot1.go
	slot0._pageIndex = slot1.index
	slot0._config = slot1.config
	slot0._selectGos = {}

	for slot5 = 1, 2 do
		table.insert(slot0._selectGos, gohelper.findChild(slot0._go, "item" .. tostring(slot5)))
	end

	transformhelper.setLocalPos(slot0._go.transform, slot1.pos, 0, 0)
end

function slot0.updateItem(slot0)
	slot1 = slot0._pageIndex == HelpModel.instance:getTargetPageIndex()

	gohelper.setActive(slot0._selectGos[1], slot1)
	gohelper.setActive(slot0._selectGos[2], not slot1)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.destroy(slot0)
end

return slot0
