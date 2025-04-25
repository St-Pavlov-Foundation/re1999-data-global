module("modules.logic.settings.model.SettingsKeyTopListModel", package.seeall)

slot0 = class("SettingsKeyTopListModel", ListScrollModel)
slot1 = {
	{
		id = PCInputModel.Activity.MainActivity
	},
	{
		id = PCInputModel.Activity.thrityDoor
	},
	{
		id = PCInputModel.Activity.battle
	},
	{
		id = PCInputModel.Activity.room
	}
}

function slot0.InitList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(uv0) do
		if pcInputConfig.instance:getKeyBlock()[slot7.id] then
			table.insert(slot1, {
				id = slot7.id,
				name = slot8.name
			})
		end
	end

	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
