module("modules.logic.critter.model.CritterModel", package.seeall)

slot0 = class("CritterModel", BaseModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._sortAttrIdKeyMap = {}
	slot0._trainPreveiewMODict = {}
end

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
end

function slot0.isCritterUnlock(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Critter) and GuideModel.instance:isGuideFinish(CritterEnum.OppenFuncGuide.Critter) then
		slot2 = true
	end

	if not slot2 and slot1 then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Critter))
	end

	return slot2
end

function slot0.initCritter(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot0:getById(slot7.uid) or CritterMO.New()

			slot8:init(slot7)
			table.insert(slot2, slot8)
		end
	end

	slot0:setList(slot2)
end

function slot0.addCritter(slot0, slot1)
	if not slot0:getById(slot1.uid) then
		slot2 = CritterMO.New()

		slot2:init(slot1)
		slot0:addAtLast(slot2)
	else
		slot2:init(slot1)
	end

	return slot2
end

function slot0.setLockCritter(slot0, slot1, slot2)
	if slot0:getById(slot1) then
		slot3.lock = slot2 == true
	end
end

function slot0.setSortAttIdByKey(slot0, slot1, slot2)
	slot0._sortAttrIdKeyMap[slot1] = slot2
end

function slot0.getSortAttIdByKey(slot0, slot1)
	return slot0._sortAttrIdKeyMap[slot1]
end

function slot0.onStartTrainCritterReply(slot0, slot1)
end

function slot0.onSelectEventOptionReply(slot0, slot1)
end

function slot0.onFastForwardTrainReply(slot0, slot1)
end

function slot0.removeCritters(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:removeCritter(slot6)
	end
end

function slot0.removeCritter(slot0, slot1)
	if slot0:getById(slot1) then
		slot0:remove(slot2)
	end
end

function slot0.getCritterMOByUid(slot0, slot1)
	return slot0:getById(slot1)
end

function slot0.getAllCritters(slot0)
	return slot0:getList()
end

function slot0.getMaturityCritters(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isMaturity() then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getCultivatingCritters(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isCultivating() then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getCritterSkinId(slot0, slot1)
	slot2 = nil

	if slot0:getCritterMOByUid(slot1) then
		slot2 = slot3:getSkinId()
	end

	return slot2
end

function slot0.getCanIncubateCritters(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isMaturity() then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.checkGotCritter(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.defineId == slot1 then
			return true
		end
	end

	return false
end

function slot0.getMoodCritters(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8:getMoodValue() <= slot1 then
			table.insert(slot2, slot8.id)
		end
	end

	return slot2
end

function slot0.getTrainPreviewMO(slot0, slot1, slot2)
	return RoomHelper.get2KeyValue(slot0._trainPreveiewMODict, slot1, slot2)
end

function slot0.addTrainPreviewMO(slot0, slot1)
	return RoomHelper.add2KeyValue(slot0._trainPreveiewMODict, slot1.id, slot1.trainInfo.heroId, slot1)
end

function slot0.getCritterCntById(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8.defineId == slot1 then
			slot2 = 0 + 1
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
