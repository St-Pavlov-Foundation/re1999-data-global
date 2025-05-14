module("modules.logic.scene.room.comp.entitymgr.RoomSceneTransportSiteEntityMgr", package.seeall)

local var_0_0 = class("RoomSceneTransportSiteEntityMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_addEvents()

	arg_2_0._scene = arg_2_0:getCurScene()

	arg_2_0:refreshAllSiteEntity()
end

function var_0_0.onSwitchMode(arg_3_0)
	arg_3_0:refreshAllSiteEntity()
end

function var_0_0._addEvents(arg_4_0)
	if arg_4_0._isInitAddEvent then
		return
	end

	arg_4_0._isInitAddEvent = true

	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, arg_4_0.refreshAllSiteEntity, arg_4_0)
end

function var_0_0._removeEvents(arg_5_0)
	if not arg_5_0._isInitAddEvent then
		return
	end

	arg_5_0._isInitAddEvent = false

	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, arg_5_0.refreshAllSiteEntity, arg_5_0)
end

function var_0_0.refreshAllSiteEntity(arg_6_0)
	local var_6_0 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = var_6_0[iter_6_0]
		local var_6_2 = RoomMapTransportPathModel.instance:getSiteHexPointByType(var_6_1)
		local var_6_3 = arg_6_0:getSiteEntity(var_6_1)

		if var_6_2 then
			if var_6_3 then
				arg_6_0:moveToHexPoint(var_6_3, var_6_2)
			else
				var_6_3 = arg_6_0:spawnRoomTransportSite(var_6_1, var_6_2)
			end

			var_6_3:refreshBuilding()
		elseif var_6_3 then
			arg_6_0:destroySiteEntity(var_6_3)
		end
	end
end

function var_0_0.spawnRoomTransportSite(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._scene.go.buildingRoot
	local var_7_1 = gohelper.create3d(var_7_0, string.format("site_%s", arg_7_1))
	local var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, RoomTransportSiteEntity, arg_7_1)

	arg_7_0:addUnit(var_7_2)
	gohelper.addChild(var_7_0, var_7_1)
	arg_7_0:moveToHexPoint(var_7_2, arg_7_2)

	return var_7_2
end

function var_0_0.moveToHexPoint(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 and arg_8_2 then
		local var_8_0, var_8_1 = HexMath.hexXYToPosXY(arg_8_2.x, arg_8_2.y, RoomBlockEnum.BlockSize)

		arg_8_1:setLocalPos(var_8_0, 0, var_8_1)
	end
end

function var_0_0.moveTo(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:setLocalPos(arg_9_2.x, arg_9_2.y, arg_9_2.z)
end

function var_0_0.destroySiteEntity(arg_10_0, arg_10_1)
	arg_10_0:removeUnit(arg_10_1:getTag(), arg_10_1.id)
end

function var_0_0.getSiteEntity(arg_11_0, arg_11_1)
	return arg_11_0:getUnit(RoomTransportSiteEntity:getTag(), arg_11_1)
end

function var_0_0.getRoomSiteEntityDict(arg_12_0)
	return arg_12_0._tagUnitDict[RoomTransportSiteEntity:getTag()] or {}
end

function var_0_0._onUpdate(arg_13_0)
	return
end

function var_0_0.onSceneClose(arg_14_0)
	var_0_0.super.onSceneClose(arg_14_0)
	arg_14_0:_removeEvents()
end

return var_0_0
