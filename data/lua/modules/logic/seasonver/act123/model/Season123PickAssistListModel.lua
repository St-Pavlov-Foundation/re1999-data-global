module("modules.logic.seasonver.act123.model.Season123PickAssistListModel", package.seeall)

slot0 = class("Season123PickAssistListModel", ListScrollModel)
slot1 = CharacterEnum.CareerType.Yan

function slot0.onInit(slot0)
	slot0:setCareer()
end

function slot0.reInit(slot0)
	slot0:setCareer()
end

function slot0.release(slot0)
	slot0:clear()

	slot0.activityId = nil

	slot0:setHeroSelect()
end

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1

	if not slot0.career then
		slot0:setCareer(uv0)
	end

	slot0:initSelectedMO(slot2)
	slot0:updateDatas()
end

function slot0.initSelectedMO(slot0, slot1)
	slot0:setHeroSelect()

	if DungeonAssistModel.instance:getAssistList(DungeonEnum.AssistType.Season123) then
		for slot6, slot7 in ipairs(slot2) do
			if slot7:getHeroUid() == slot1 then
				slot0:setHeroSelect(Season123HeroUtils.createSeasonPickAssistMO(slot7), true)
			end
		end
	end
end

function slot0.updateDatas(slot0)
	if not slot0.activityId or not slot0.career then
		return
	end

	slot0:setListByCareer()
end

function slot0.setListByCareer(slot0)
	slot1 = {}
	slot2 = slot0:getSelectedMO()

	slot0:setHeroSelect()

	if DungeonAssistModel.instance:getAssistList(DungeonEnum.AssistType.Season123, slot0.career) then
		for slot7, slot8 in ipairs(slot3) do
			if Season123HeroUtils.createSeasonPickAssistMO(slot8) and slot9.heroMO and slot9.heroMO.config and slot9.heroMO.config.career == slot0.career then
				table.insert(slot1, slot9)

				if slot2 and slot2:isSameHero(slot9) then
					slot0:setHeroSelect(slot9, true)
				end
			end
		end
	end

	slot0:setList(slot1)
	Season123Controller.instance:dispatchEvent(Season123Event.SetCareer)
end

function slot0.getCareer(slot0)
	return slot0.career
end

function slot0.getSelectedMO(slot0)
	return slot0.selectMO
end

function slot0.isHeroSelected(slot0, slot1)
	slot2 = false

	if slot0:getSelectedMO() then
		slot2 = slot3:isSameHero(slot1)
	end

	return slot2
end

function slot0.isHasAssistList(slot0)
	slot1 = false

	if slot0:getList() then
		slot1 = #slot2 > 0
	end

	return slot1
end

function slot0.setCareer(slot0, slot1)
	if slot0.career ~= slot1 then
		slot0.career = slot1

		slot0:updateDatas()
	end
end

function slot0.setHeroSelect(slot0, slot1, slot2)
	if slot2 then
		slot0.selectMO = slot1
	else
		slot0.selectMO = nil
	end

	Season123Controller.instance:dispatchEvent(Season123Event.RefreshSelectAssistHero)
end

slot0.instance = slot0.New()

return slot0
