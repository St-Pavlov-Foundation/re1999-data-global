module("modules.logic.activity.model.ActivityNoviceSignItemListModel", package.seeall)

slot0 = class("ActivityNoviceSignItemListModel", ListScrollModel)

function slot0.setDayList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	slot0:setList(slot0._moList)
end

slot0.instance = slot0.New()

return slot0
