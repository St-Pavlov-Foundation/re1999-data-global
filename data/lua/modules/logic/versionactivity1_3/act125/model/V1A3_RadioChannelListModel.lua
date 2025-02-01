module("modules.logic.versionactivity1_3.act125.model.V1A3_RadioChannelListModel", package.seeall)

slot0 = class("V1A3_RadioChannelListModel", ListScrollModel)

function slot0.setCategoryList(slot0, slot1)
	slot0:setList(slot1 and slot1 or {})
end

slot0.instance = slot0.New()

return slot0
