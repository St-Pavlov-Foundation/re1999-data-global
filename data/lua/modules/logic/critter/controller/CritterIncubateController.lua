module("modules.logic.critter.controller.CritterIncubateController", package.seeall)

slot0 = class("CritterIncubateController", BaseController)

function slot0.onInit(slot0)
	slot0._incubateCritterList = nil
	slot0._incubateCritterList = 1
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._incubateCritterList = nil
	slot0._incubateCritterList = 1
end

function slot0.getIncubateCritterIds(slot0)
	return CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(1), CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(2)
end

function slot0.onIncubateCritterPreview(slot0)
	slot1, slot2 = slot0:getIncubateCritterIds()

	CritterRpc.instance:sendIncubateCritterPreviewRequest(slot1, slot2)
end

function slot0.openRoomCritterDetailView(slot0)
	CritterController.instance:openRoomCritterDetailView(true, nil, true, CritterIncubateModel.instance:getChildMOList())
end

function slot0.onIncubateCritterPreviewReply(slot0, slot1)
	CritterIncubateModel.instance:setCritterPreviewInfo(slot1.childes)
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onIncubateCritterPreviewReply)
end

function slot0.onIncubateCritter(slot0)
	slot1, slot2 = slot0:getIncubateCritterIds()

	CritterRpc.instance:sendIncubateCritterRequest(slot1, slot2)
end

function slot0.incubateCritterReply(slot0, slot1)
	slot0._incubateCritterList = slot1.childes
	slot0._showCritterIndex = 1

	if not LuaUtil.tableNotEmpty(slot0._incubateCritterList) then
		return
	end

	if LuaUtil.tableNotEmpty(slot0._incubateCritterList[slot0._showCritterIndex]) then
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onStartSummon, {
			mode = RoomSummonEnum.SummonType.Incubate,
			parent1 = slot1.parent1,
			parent2 = slot1.parent2,
			critterMo = CritterModel.instance:addCritter(slot2)
		})
	end
end

function slot0.checkHasChildCritter(slot0)
	if not LuaUtil.tableNotEmpty(slot0._incubateCritterList) then
		return
	end

	if not slot0._showCritterIndex then
		return
	end

	if slot0._showCritterIndex >= #slot0._incubateCritterList then
		return
	end

	slot0._showCritterIndex = slot0._showCritterIndex + 1

	if LuaUtil.tableNotEmpty(slot0._incubateCritterList[slot0._showCritterIndex]) then
		return CritterModel.instance:addCritter(slot1)
	end
end

slot0.instance = slot0.New()

return slot0
