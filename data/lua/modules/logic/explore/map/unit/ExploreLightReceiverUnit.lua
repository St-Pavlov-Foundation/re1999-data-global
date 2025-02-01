module("modules.logic.explore.map.unit.ExploreLightReceiverUnit", package.seeall)

slot0 = class("ExploreLightReceiverUnit", ExploreBaseLightUnit)

function slot0.getLightRecvDirs(slot0)
	if slot0.mo.isPhoticDir then
		-- Nothing
	end

	return {
		[ExploreHelper.getDir(slot0.mo.unitDir)] = true,
		[ExploreHelper.getDir(slot0.mo.unitDir + 180)] = true
	}
end

function slot0.onLightEnter(slot0, slot1)
	slot2 = ExploreController.instance:getMapLight()

	slot2:beginCheckStatusChange(slot0.id, false)
	slot2:endCheckStatus()
end

function slot0.haveLight(slot0)
	return ExploreController.instance:getMapLight():haveLight(slot0)
end

function slot0.onLightChange(slot0, slot1, slot2)
	if not slot0.mo.isPhoticDir then
		return
	end

	if slot2 then
		slot0.lightComp:addLight(slot1.dir)
	else
		slot0.lightComp:removeLightByDir(slot1.dir)
	end
end

function slot0.onLightExit(slot0, slot1)
	if slot1 and not slot0:getLightRecvDirs()[ExploreHelper.getDir(slot1.dir - 180)] then
		return
	end

	slot2 = ExploreController.instance:getMapLight()

	slot2:beginCheckStatusChange(slot0.id, true)
	slot2:endCheckStatus()
end

return slot0
