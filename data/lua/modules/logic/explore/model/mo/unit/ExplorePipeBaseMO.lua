module("modules.logic.explore.model.mo.unit.ExplorePipeBaseMO", package.seeall)

slot0 = class("ExplorePipeBaseMO", ExploreBaseUnitMO)

function slot0.getColor(slot0, slot1)
	if not ExploreController.instance:getMapPipe() or not slot2:isInitDone() then
		return ExploreEnum.PipeColor.None
	end

	if slot1 == -1 then
		return slot2:getCenterColor(slot0.id)
	end

	return slot2:getDirColor(slot0.id, ExploreHelper.getDir(slot1 + slot0.unitDir))
end

function slot0.getDirType(slot0, slot1)
end

function slot0.canRotate(slot0)
	if not slot0._canRotate then
		for slot4, slot5 in ipairs(slot0.triggerEffects) do
			if slot5[1] == ExploreEnum.TriggerEvent.Rotate then
				slot0._canRotate = true
			end
		end
	end

	return slot0._canRotate
end

function slot0.isDivisive(slot0)
	return false
end

function slot0.getPipeOutDir(slot0)
	return nil
end

function slot0.isOutDir(slot0, slot1)
	return false
end

return slot0
