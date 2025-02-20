module("modules.logic.room.controller.RoomCrossLoadController", package.seeall)

slot0 = class("RoomCrossLoadController", BaseController)

function slot0.onInit(slot0)
	slot0._lastUpdatePathGraphicTimeDic = {}

	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
end

function slot0.findDirectionPathList(slot0, slot1, slot2)
	if not slot0._directionPathDic then
		slot0._directionPathDic = {}
	end

	if not slot0._directionPathDic[slot1] then
		slot0._directionPathDic[slot1] = {}
	end

	if not slot0._directionPathDic[slot1][slot2] then
		slot0._directionPathDic[slot1][slot2] = {
			slot1
		}

		if slot1 ~= slot2 then
			table.insert(slot3, slot2)
		end

		if math.abs(slot1 - slot2) > 1 and not tabletool.indexOf(slot3, 0) then
			table.insert(slot3, 0)
		end
	end

	return slot0._directionPathDic[slot1][slot2]
end

function slot0.isEnterBuilingCrossLoad(slot0, slot1, slot2, slot3, slot4)
	if RoomMapBuildingModel.instance:getBuildingParam(slot1, slot2) and slot5.isCrossload and slot5.replacResPoins then
		slot11 = slot4
		slot7 = slot0:findDirectionPathList(slot3, slot11)

		for slot11, slot12 in pairs(slot5.replacResPoins) do
			for slot16, slot17 in ipairs(slot7) do
				if slot12[RoomRotateHelper.rotateDirection(slot17, -slot5.blockRotate)] then
					return true, slot5.buildingUid
				end
			end
		end
	end

	return false
end

function slot0.crossload(slot0, slot1, slot2)
	if not GameSceneMgr.instance:getCurScene() then
		return
	end

	if slot3.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) and slot4.crossloadComp then
		slot4.crossloadComp:playAnim(slot2)

		return slot4.crossloadComp:getCurResId(), slot4.crossloadComp:getCanMove()
	end

	return slot2
end

function slot0.getUpateGraphicTime(slot0, slot1)
	return slot0._lastUpdatePathGraphicTimeDic[slot1] or 0
end

function slot0.updatePathGraphic(slot0, slot1)
	if not GameSceneMgr.instance:getCurScene() then
		return
	end

	if not slot2.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) then
		return
	end

	if not slot3:getMO() then
		return
	end

	slot0._lastUpdatePathGraphicTimeDic[slot1] = Time.time
	slot9 = slot4.rotate
	slot10 = slot4.buildingUid

	for slot9, slot10 in pairs(RoomBuildingHelper.getOccupyDict(slot4.buildingId, slot4.hexPoint, slot9, slot10)) do
		for slot14, slot15 in pairs(slot10) do
			if slot2.mapmgr:getBlockEntity(RoomMapBlockModel.instance:getBlockMO(slot9, slot14).id, SceneTag.RoomMapBlock) then
				slot2.path:updatePathGraphic(slot17.go)
			end
		end
	end

	slot2.path:updatePathGraphic(slot3:getBuildingGO())
end

function slot0._closeGraphic(slot0, slot1)
	if not gohelper.isNil(slot1) then
		slot3 = {}
		slot7 = slot3

		ZProj.AStarPathBridge.ArrayToLuaTable(ZProj.AStarPathBridge.FindChildrenByName(slot1, "#collider"), slot7)

		for slot7, slot8 in ipairs(slot3) do
			gohelper.setActive(slot8, false)
		end
	end
end

function slot0.isLock(slot0)
	return ViewMgr.instance:hasOpenFullView()
end

slot0.instance = slot0.New()

return slot0
