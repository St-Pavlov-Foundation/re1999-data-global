module("modules.logic.versionactivity1_4.act136.model.Activity136ChoiceViewListModel", package.seeall)

slot0 = class("Activity136ChoiceViewListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot1(slot0, slot1)
	if (HeroModel.instance:getByHeroId(slot0.id) and true or false) ~= (HeroModel.instance:getByHeroId(slot1.id) and true or false) then
		return slot5
	end

	if (slot2 and slot2.exSkillLevel or -1) ~= (slot3 and slot3.exSkillLevel or -1) then
		return slot6 < slot7
	end

	return slot0.id < slot1.id
end

function slot0.setSelfSelectedCharacterList(slot0)
	slot3 = {}

	for slot7, slot8 in ipairs(Activity136Config.instance:getSelfSelectCharacterIdList(Activity136Model.instance:getCurActivity136Id())) do
		table.insert(slot3, {
			id = slot8
		})
	end

	table.sort(slot3, uv0)
	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
