module("modules.logic.pickassist.model.PickAssistListModel", package.seeall)

slot0 = class("PickAssistListModel", ListScrollModel)
slot1 = CharacterEnum.CareerType.Yan
slot2 = {}
slot3 = {
	[PickAssistEnum.Type.Rouge] = "RougePickAssistView"
}

function slot4(slot0)
	if not slot0 then
		return
	end

	slot2 = PickAssistHeroMO.New()

	slot2:init(slot0:getHeroInfo())

	return slot2
end

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.clearData(slot0)
	slot0.activityId = nil
	slot0.career = nil
	slot0.selectMO = nil
end

function slot0.onCloseView(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.activityId = slot1
	slot0._assistType = slot2

	if not slot0.career then
		slot0:setCareer(uv0)
	end

	slot0:initSelectedMO(slot3)
	slot0:updateDatas()
end

function slot0.initSelectedMO(slot0, slot1)
	slot0:setHeroSelect()

	if not DungeonAssistModel.instance:getAssistList(slot0:getAssistType()) then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8:getHeroUid() == slot1 then
			slot0:setHeroSelect(uv0(slot8), true)

			break
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

	if DungeonAssistModel.instance:getAssistList(slot0:getAssistType(), slot0.career) then
		for slot8, slot9 in ipairs(slot4) do
			if slot10 and (uv0(slot9) and slot10:getCareer()) == slot0.career then
				table.insert(slot1, slot10)

				if slot2 and slot2:isSameHero(slot10) then
					slot0:setHeroSelect(slot10, true)
				end
			end
		end
	end

	slot0:setList(slot1)
	PickAssistController.instance:dispatchEvent(PickAssistEvent.SetCareer)
end

function slot0.getPickAssistViewName(slot0)
	if slot0.activityId then
		slot1 = uv0[slot0.activityId] or ViewName.PickAssistView
	end

	if slot0._assistType then
		slot1 = uv1[slot0._assistType] or slot1
	end

	return slot1
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

function slot0.getAssistType(slot0)
	if not slot0._assistType then
		logError("PickAssistListModel:getAssistType error, not set assistType")
	end

	return slot0._assistType
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

	PickAssistController.instance:dispatchEvent(PickAssistEvent.RefreshSelectAssistHero)
end

slot0.instance = slot0.New()

return slot0
