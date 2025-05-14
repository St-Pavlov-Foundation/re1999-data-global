module("modules.logic.room.controller.RoomCrossLoadController", package.seeall)

local var_0_0 = class("RoomCrossLoadController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._lastUpdatePathGraphicTimeDic = {}

	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.findDirectionPathList(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._directionPathDic then
		arg_4_0._directionPathDic = {}
	end

	if not arg_4_0._directionPathDic[arg_4_1] then
		arg_4_0._directionPathDic[arg_4_1] = {}
	end

	if not arg_4_0._directionPathDic[arg_4_1][arg_4_2] then
		local var_4_0 = {
			arg_4_1
		}

		arg_4_0._directionPathDic[arg_4_1][arg_4_2] = var_4_0

		if arg_4_1 ~= arg_4_2 then
			table.insert(var_4_0, arg_4_2)
		end

		if math.abs(arg_4_1 - arg_4_2) > 1 and not tabletool.indexOf(var_4_0, 0) then
			table.insert(var_4_0, 0)
		end
	end

	return arg_4_0._directionPathDic[arg_4_1][arg_4_2]
end

function var_0_0.isEnterBuilingCrossLoad(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = RoomMapBuildingModel.instance:getBuildingParam(arg_5_1, arg_5_2)

	if var_5_0 and var_5_0.isCrossload and var_5_0.replacResPoins then
		local var_5_1 = var_5_0.replacResPoins
		local var_5_2 = arg_5_0:findDirectionPathList(arg_5_3, arg_5_4)

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			for iter_5_2, iter_5_3 in ipairs(var_5_2) do
				if iter_5_1[RoomRotateHelper.rotateDirection(iter_5_3, -var_5_0.blockRotate)] then
					return true, var_5_0.buildingUid
				end
			end
		end
	end

	return false
end

function var_0_0.crossload(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = GameSceneMgr.instance:getCurScene()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.buildingmgr:getBuildingEntity(arg_6_1, SceneTag.RoomBuilding)

	if var_6_1 and var_6_1.crossloadComp then
		var_6_1.crossloadComp:playAnim(arg_6_2)

		return var_6_1.crossloadComp:getCurResId(), var_6_1.crossloadComp:getCanMove()
	end

	return arg_6_2
end

function var_0_0.getUpateGraphicTime(arg_7_0, arg_7_1)
	return arg_7_0._lastUpdatePathGraphicTimeDic[arg_7_1] or 0
end

function var_0_0.updatePathGraphic(arg_8_0, arg_8_1)
	local var_8_0 = GameSceneMgr.instance:getCurScene()

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.buildingmgr:getBuildingEntity(arg_8_1, SceneTag.RoomBuilding)

	if not var_8_1 then
		return
	end

	local var_8_2 = var_8_1:getMO()

	if not var_8_2 then
		return
	end

	arg_8_0._lastUpdatePathGraphicTimeDic[arg_8_1] = Time.time

	local var_8_3 = RoomBuildingHelper.getOccupyDict(var_8_2.buildingId, var_8_2.hexPoint, var_8_2.rotate, var_8_2.buildingUid)

	for iter_8_0, iter_8_1 in pairs(var_8_3) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			local var_8_4 = RoomMapBlockModel.instance:getBlockMO(iter_8_0, iter_8_2)
			local var_8_5 = var_8_0.mapmgr:getBlockEntity(var_8_4.id, SceneTag.RoomMapBlock)

			if var_8_5 then
				var_8_0.path:updatePathGraphic(var_8_5.go)
			end
		end
	end

	var_8_0.path:updatePathGraphic(var_8_1:getBuildingGO())
end

function var_0_0._closeGraphic(arg_9_0, arg_9_1)
	if not gohelper.isNil(arg_9_1) then
		local var_9_0 = ZProj.AStarPathBridge.FindChildrenByName(arg_9_1, "#collider")
		local var_9_1 = {}

		ZProj.AStarPathBridge.ArrayToLuaTable(var_9_0, var_9_1)

		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			gohelper.setActive(iter_9_1, false)
		end
	end
end

function var_0_0.isLock(arg_10_0)
	return ViewMgr.instance:hasOpenFullView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
