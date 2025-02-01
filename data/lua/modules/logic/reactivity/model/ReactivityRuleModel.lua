module("modules.logic.reactivity.model.ReactivityRuleModel", package.seeall)

slot0 = class("ReactivityRuleModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.refreshList(slot0)
	slot0:clear()

	slot5 = {}

	for slot9, slot10 in ipairs(ReactivityConfig.instance:getItemConvertList()) do
		if slot10.version == (ReactivityEnum.ActivityDefine[ReactivityController.instance:getCurReactivityId()] and slot2.storeActId) then
			table.insert(slot5, {
				id = slot9,
				typeId = slot10.typeId,
				itemId = slot10.itemId,
				limit = slot10.limit,
				price = slot10.price
			})
		end
	end

	if #slot5 > 1 then
		table.sort(slot5, SortUtil.tableKeyLower({
			"typeId",
			"itemId"
		}))
	end

	slot0:setList(slot5)
end

slot0.instance = slot0.New()

return slot0
