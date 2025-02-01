module("modules.logic.weekwalk.model.WeekWalkTarotListModel", package.seeall)

slot0 = class("WeekWalkTarotListModel", ListScrollModel)

function slot0.setTarotList(slot0, slot1)
	slot0:clear()
	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
