module("modules.logic.player.model.PlayerClothListViewModel", package.seeall)

slot0 = class("PlayerClothListViewModel", ListScrollModel)

function slot0.setGroupModel(slot0, slot1)
	slot0._groupModel = slot1
end

function slot0.getGroupModel(slot0)
	return slot0._groupModel
end

function slot0.update(slot0)
	slot1 = PlayerClothModel.instance:getList()

	if PlayerClothModel.instance:getSpEpisodeClothID() then
		table.insert({}, PlayerClothModel.instance:getById(slot3))
	else
		for slot7, slot8 in ipairs(slot1) do
			if PlayerClothModel.instance:hasCloth(slot8.id) then
				table.insert(slot2, slot8)
			end
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
