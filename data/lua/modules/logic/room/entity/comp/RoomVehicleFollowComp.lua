module("modules.logic.room.entity.comp.RoomVehicleFollowComp", package.seeall)

slot0 = class("RoomVehicleFollowComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._followerList = {}
	slot0._forwardList = {}
	slot0._backwardList = {}
	slot0._initPosList = {}
	slot0._isForward = true
	slot0._pathData = RoomVehicleFollowPathData.New()
	slot0._isNight = RoomWeatherModel.instance:getIsNight()
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.targetTrs = slot0.go.transform

	slot0:_initPathList()
end

function slot0._initPathList(slot0)
	slot0._initPosList = {}
	slot0._lookAtPos = nil

	if not slot0.entity:getVehicleMO() then
		return
	end

	slot2 = {}

	tabletool.addValues(slot2, slot1:getInitAreaNode())

	if #slot2 < 2 then
		return
	end

	slot6 = slot0

	table.insert(slot0._initPosList, slot0._getPostionByNode(slot6, slot2[1], 0))

	for slot6 = 2, #slot2 do
		slot7 = slot2[slot6 - 1]
		slot9, slot10 = slot0:_findConnectDirection(slot7, slot2[slot6])

		if slot7 then
			if slot6 == 2 and slot10 then
				slot0._lookAtPos = slot0:_getPostionByNode(slot7, slot10)
			end

			table.insert(slot0._initPosList, slot0:_getPostionByNode(slot7, slot9 or 0))
		end

		if slot8 then
			table.insert(slot0._initPosList, slot0:_getPostionByNode(slot8, slot10 or 0))

			if slot6 == #slot2 and slot9 then
				table.insert(slot0._initPosList, slot0:_getPostionByNode(slot8, slot9 or 0))
			end
		end
	end
end

function slot0._findConnectDirection(slot0, slot1, slot2)
	for slot8 = 1, 6 do
		if HexPoint.directions[slot8].x == slot2.hexPoint.x - slot1.hexPoint.x and slot9.y == slot2.hexPoint.y - slot1.hexPoint.y then
			return slot8, slot1:getConnectDirection(slot8)
		end
	end
end

function slot0._getPostionByNode(slot0, slot1, slot2, slot3)
	slot4 = nil
	slot4 = (slot2 and slot2 ~= 0 or HexMath.hexToPosition(slot1.hexPoint, RoomBlockEnum.BlockSize)) and HexMath.resourcePointToPosition(ResourcePoint.New(slot1.hexPoint, slot2), RoomBlockEnum.BlockSize, slot3 or 0.4)

	return Vector3(slot4.x, RoomBuildingEnum.VehicleInitOffestY, slot4.y)
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.MapEntityNightLight, slot0._onNightLight, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.MapEntityNightLight, slot0._onNightLight, slot0)
end

function slot0.stop(slot0)
end

function slot0._onNightLight(slot0, slot1)
	if slot1 ~= nil and slot0._isNight ~= slot1 then
		slot0._isNight = slot1

		slot0:updateNight(slot1)
	end
end

function slot0.updateNight(slot0, slot1)
	for slot5 = 1, #slot0._followerList do
		slot0._followerList[slot5]:nightLight(slot1)
	end
end

function slot0.restart(slot0)
	if #slot0._followerList < 2 then
		return
	end

	slot0._pathData:clear()

	if slot0._lookAtPos then
		slot0.targetTrs:LookAt(slot0._lookAtPos)
	end

	for slot4 = #slot0._initPosList, 1, -1 do
		slot0._pathData:addPathPos(slot0._initPosList[slot4])
	end

	for slot4 = 1, #slot0._followerList do
		slot0._followerList[slot4]:moveByPathData()
	end
end

function slot0.getVehicleMO(slot0)
	return slot0.entity:getVehicleMO()
end

function slot0.getSeeker(slot0)
	return slot0._seeker
end

function slot0.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._followerRebuild, slot0)

	if #slot0._followerList > 0 then
		for slot4 = 1, #slot0._followerList do
			gohelper.destroy(slot0._followerList[slot4].go)
			slot0._followerList[slot4]:dispose()
		end

		slot0._followerList = {}
	end
end

function slot0._initFollower(slot0, slot1, slot2)
	if not slot1 or string.nilorempty(slot1.followNodePathStr) or gohelper.isNil(slot2) then
		return
	end

	slot4 = string.splitToNumber(slot1.followRadiusStr, "#")
	slot5 = string.splitToNumber(slot1.followRotateStr, "#")

	if not string.split(slot1.followNodePathStr, "#") or #slot3 < 2 then
		return
	end

	for slot10, slot11 in ipairs(slot3) do
		if not gohelper.isNil(gohelper.findChild(slot2, slot11)) then
			slot13 = RoomVehicleFollower.New(slot0)

			slot13:init(gohelper.create3d(slot0.go, slot11), slot4[slot10], 0, slot11, slot5[slot10])
			table.insert(slot0._followerList, slot13)
		end
	end

	slot0:_refreshFollowDistance()
	tabletool.addValues(slot0._forwardList, slot0._followerList)

	for slot10, slot11 in ipairs(slot0._followerList) do
		table.insert(slot0._backwardList, 1, slot11)
	end

	slot0:restart()
end

function slot0.addFollerPathPos(slot0, slot1, slot2, slot3)
	if #slot0._followerList > 0 then
		slot0._pathData:addPathPos(Vector3(slot1, slot2, slot3))
	end
end

function slot0._addFollerPathPos(slot0, slot1, slot2, slot3)
	if #slot0._followerList > 0 then
		for slot8 = 2, #slot0._followerList do
			slot0._followerList[slot8]:addPathPos(Vector3(slot1, slot2, slot3))
		end
	end
end

function slot0.updateFollower(slot0)
	if #slot0._followerList > 0 then
		for slot4 = 2, #slot0._followerList do
			slot0._followerList[slot4]:moveByPathData()
		end

		if slot0._isNeedUpdateForward then
			slot0._isNeedUpdateForward = false

			for slot4 = 1, #slot0._followerList do
				slot0._followerList[slot4]:setVehiceForward(slot0._isForward)
			end
		end
	end
end

function slot0.getPathData(slot0)
	return slot0._pathData
end

function slot0._followerRebuild(slot0)
	if not slot0._initCloneFollowerFinish and slot0.entity.effect:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) then
		slot0._initCloneFollowerFinish = true

		slot0:_initFollower(slot0:getVehicleMO() and slot1:getReplaceDefideCfg(), slot0.entity.effect:getEffectGO(RoomEnum.EffectKey.VehicleGOKey))

		for slot7, slot8 in ipairs(slot0._followerList) do
			slot8:onEffectRebuild()
		end

		slot0.entity.effect:setActiveByKey(RoomEnum.EffectKey.VehicleGOKey, #slot0._followerList < 1)
		slot0:updateNight(slot0._isNight)
	end
end

function slot0.setShow(slot0, slot1)
	if #slot0._followerList > 0 then
		for slot5 = 1, #slot0._followerList do
			gohelper.setActive(slot0._followerList[slot5].go, slot1)
		end
	end
end

function slot0.turnAround(slot0)
	if #slot0._followerList < 2 then
		return
	end

	slot0._isForward = slot0._isForward ~= true
	slot0._isNeedUpdateForward = true

	if slot0.entity:getVehicleMO() then
		tabletool.addValues({}, slot1:getAreaNode())

		slot3, slot4, slot5 = transformhelper.getPos(slot0._followerList[#slot0._followerList].goTrs)
		slot6, slot7 = HexMath.positionToRoundHex(Vector2(slot3, slot5), RoomBlockEnum.BlockSize)

		if slot1.pathPlanMO:getNode(slot6) and not tabletool.indexOf(slot2, slot8) then
			table.insert(slot2, slot8)
		end

		if #slot2 > 1 then
			for slot12 = 2, #slot2 do
				slot14 = slot2[slot12]

				for slot18 = 1, 6 do
					if slot14:getConnctNode(slot18) == slot2[slot12 - 1] then
						slot1:moveToNode(slot14, slot18)

						break
					end
				end
			end
		end
	end

	slot0._pathData:clear()

	for slot7 = 1, #slot0._followerList do
		slot8 = slot0._followerList[slot7]
		slot9, slot10, slot11 = transformhelper.getPos(slot8.goTrs)

		slot0._pathData:addPathPos(Vector3(slot9, slot10, slot11))
		slot8.goTrs:SetParent(slot0.targetTrs.parent)

		if slot7 == slot2 then
			transformhelper.setPos(slot0.targetTrs, slot9, slot10, slot11)

			slot0.targetTrs.rotation = slot8.goTrs.rotation

			slot8.goTrs:SetParent(slot0.targetTrs)
		end
	end

	slot0._followerList = slot0._isForward and slot0._forwardList or slot0._backwardList

	slot0:_refreshFollowDistance()

	return true
end

function slot0._refreshFollowDistance(slot0)
	for slot5 = 1, #slot0._followerList do
		slot6 = slot0._followerList[slot5]

		if slot5 > 1 then
			slot1 = 0 + slot0._followerList[slot5 - 1].radius + slot6.radius
		end

		slot6.followDistance = slot1
	end
end

function slot0.onEffectRebuild(slot0)
	if not slot0._initCloneFollowerFinish then
		TaskDispatcher.cancelTask(slot0._followerRebuild, slot0)
		TaskDispatcher.runDelay(slot0._followerRebuild, slot0, 0.1)
	end
end

return slot0
