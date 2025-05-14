module("modules.logic.explore.map.node.ExploreNode", package.seeall)

local var_0_0 = class("ExploreNode")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.open = true
	arg_1_0.pos = Vector3.zero
	arg_1_0.openKeyDic = {}
	arg_1_0.keyOpen = true

	local var_1_0 = ExploreHelper.getKeyXY(arg_1_1[1], arg_1_1[2])

	arg_1_0.height = arg_1_1[3] or 0
	arg_1_0.areaId = arg_1_1[4] or 0
	arg_1_0.cameraId = arg_1_1[5] or 0
	arg_1_0.nodeType = ExploreEnum.NodeType.Normal
	arg_1_0.rawHeight = arg_1_0.height
	arg_1_0._canPassItem = true

	arg_1_0:setWalkableKey(var_1_0)
end

function var_0_0.setNodeType(arg_2_0, arg_2_1)
	arg_2_0.nodeType = arg_2_1
end

function var_0_0.isWalkable(arg_3_0, arg_3_1, arg_3_2)
	if not ExploreModel.instance:isAreaShow(arg_3_0.areaId) then
		return false
	end

	if not arg_3_2 and not arg_3_0._canPassItem and arg_3_0:isRoleUseItem() then
		return false
	end

	arg_3_1 = arg_3_1 or arg_3_0.height

	return arg_3_1 == arg_3_0.height and arg_3_0.open and arg_3_0.keyOpen
end

function var_0_0.isRoleUseItem(arg_4_0)
	local var_4_0 = ExploreController.instance:getMap()

	if var_4_0:getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		return true
	end

	local var_4_1 = ExploreModel.instance:getUseItemUid()
	local var_4_2 = ExploreBackpackModel.instance:getById(var_4_1)

	if var_4_2 and var_4_2.itemEffect == ExploreEnum.ItemEffect.Active then
		return true
	end

	local var_4_3 = var_4_0:getUnit(tonumber(var_4_1), true)

	if var_4_3 and var_4_3:getUnitType() == ExploreEnum.ItemType.PipePot then
		return true
	end

	return false
end

function var_0_0.setWalkableKey(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = ExploreHelper.getXYByKey(arg_5_1)

	arg_5_0.walkableKey = arg_5_1
	arg_5_0.pos.x = var_5_0
	arg_5_0.pos.y = var_5_1
end

function var_0_0.setCanPassItem(arg_6_0, arg_6_1)
	arg_6_0._canPassItem = arg_6_1
end

function var_0_0.updateOpenKey(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 then
		arg_7_0.openKeyDic[arg_7_1] = nil
	else
		arg_7_0.openKeyDic[arg_7_1] = arg_7_2
	end

	arg_7_0.keyOpen = true

	for iter_7_0, iter_7_1 in pairs(arg_7_0.openKeyDic) do
		arg_7_0.keyOpen = false

		break
	end
end

return var_0_0
