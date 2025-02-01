module("modules.logic.explore.controller.steps.ExploreUpdateUnitStep", package.seeall)

slot0 = class("ExploreUpdateUnitStep", ExploreStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data.interact

	ExploreModel.instance:updateInteractInfo(slot1, nil, true)

	if ExploreHelper.getBit(slot1.status, ExploreEnum.InteractIndex.IsEnter) <= 0 then
		ExploreStepController.instance:insertClientStep({
			stepType = ExploreEnum.StepType.DelUnit,
			interact = slot0._data.interact
		}, 1)
		slot0:onDone()

		return
	end

	if ExploreController.instance:getMap():getUnit(slot1.id, true) then
		slot3:checkShowIcon()

		if (not slot3.nodePos or slot3.nodePos.x ~= slot1.posx or slot3.nodePos.y ~= slot1.posy) and slot2:getNowStatus() == ExploreEnum.MapStatus.Normal then
			slot3:setPosByNode({
				x = slot1.posx,
				y = slot1.posy
			})
		end

		if ExploreHeroResetFlow.instance:isReseting() then
			slot3.mo.unitDir = slot1.dir

			slot3:updateRotationRoot()
		end
	else
		ExploreController.instance:updateUnit(slot1)

		slot4 = slot2:getUnit(slot1.id)

		slot2:checkUnitNear(slot4.nodePos, slot4)
	end

	slot0:onDone()
end

return slot0
