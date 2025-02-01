module("modules.logic.permanent.model.PermanentActivityListModel", package.seeall)

slot0 = class("PermanentActivityListModel", ListScrollModel)

function slot0.refreshList(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in pairs(PermanentModel.instance:getActivityDic()) do
		if slot8.online then
			if slot8.permanentUnlock then
				table.insert(slot2, slot8)
			else
				table.insert(slot3, slot8)
			end
		end
	end

	table.sort(slot2, SortUtil.keyLower("id"))
	table.sort(slot3, SortUtil.keyLower("id"))
	tabletool.addValues(slot2, slot3)
	table.insert(slot2, {
		id = -999
	})
	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
