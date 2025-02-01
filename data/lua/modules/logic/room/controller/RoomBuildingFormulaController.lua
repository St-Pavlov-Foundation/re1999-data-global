module("modules.logic.room.controller.RoomBuildingFormulaController", package.seeall)

slot0 = class("RoomBuildingFormulaController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.resetSelectFormulaStrId(slot0)
	RoomFormulaListModel.instance:resetSelectFormulaStrId()
end

function slot0.setSelectFormulaStrId(slot0, slot1, slot2, slot3)
	if slot0._waitingSelectFormulaParam then
		return
	end

	if not RoomFormulaModel.instance:getFormulaMo(slot1) then
		return
	end

	slot5 = false
	slot6 = slot1

	if slot1 == RoomFormulaListModel.instance:getSelectFormulaStrId() and not slot2 then
		slot6 = slot4:getParentStrId()
		slot5 = true
	end

	slot0._waitingSelectFormulaParam = {
		formulaStrId = slot6,
		isCollapse = slot5,
		treeLevel = slot3
	}

	if slot3 and slot0:_checkTreeLevel(slot3) then
		RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelHideAnim, slot3)
		TaskDispatcher.runDelay(slot0._onDelaySelectFormulaStrId, slot0, RoomProductLineEnum.AnimTime.TreeAnim)
	else
		slot0:_onDelaySelectFormulaStrId()
	end
end

function slot0._onDelaySelectFormulaStrId(slot0)
	if slot0._waitingSelectFormulaParam then
		slot1 = RoomFormulaListModel.instance:getSelectFormulaStrId()
		slot2 = slot0._waitingSelectFormulaParam.formulaStrId
		slot3 = slot0._waitingSelectFormulaParam.isCollapse
		slot0._waitingSelectFormulaParam = nil

		RoomFormulaListModel.instance:refreshRankDiff()

		if slot0._waitingSelectFormulaParam.treeLevel and not slot0:_checkTreeLevel(slot4) then
			RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelShowAnim, slot4)
		end

		RoomMapController.instance:dispatchEvent(RoomEvent.UIFormulaIdTreeLevelMoveAnim)
		RoomFormulaListModel.instance:setSelectFormulaStrId(slot2)
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectFormulaIdChanged, slot1, slot3)
	end
end

function slot0._checkTreeLevel(slot0, slot1)
	for slot6, slot7 in ipairs(RoomFormulaListModel.instance:getList()) do
		if slot7:getFormulaTreeLevel() and slot1 < slot8 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
