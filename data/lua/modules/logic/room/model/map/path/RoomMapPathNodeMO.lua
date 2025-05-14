module("modules.logic.room.model.map.path.RoomMapPathNodeMO", package.seeall)

local var_0_0 = pureTable("RoomMapPathNodeMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.hexPoint = arg_1_2
	arg_1_0.resourceId = arg_1_3
	arg_1_0.resId = arg_1_3
	arg_1_0.directionDic = {}
	arg_1_0.connectNode = {}
	arg_1_0.directionList = {}
	arg_1_0.neighborNum = 0
	arg_1_0.connectNodeNum = 0
	arg_1_0.searchIndex = 0
	arg_1_0.hasBuilding = false
end

function var_0_0.addDirection(arg_2_0, arg_2_1)
	arg_2_0.directionDic[arg_2_1] = true

	if arg_2_1 >= 1 and arg_2_1 <= 6 and not tabletool.indexOf(arg_2_0.directionList) then
		table.insert(arg_2_0.directionList, arg_2_1)
	end
end

function var_0_0.getConnectDirection(arg_3_0, arg_3_1)
	return (arg_3_1 + 3 - 1) % 6 + 1
end

function var_0_0.isHasDirection(arg_4_0, arg_4_1)
	return arg_4_0.directionDic[arg_4_1] ~= nil
end

function var_0_0.setConnctNode(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.directionDic[arg_5_1] ~= nil then
		arg_5_0.connectNode[arg_5_1] = arg_5_2
	end
end

function var_0_0.getConnctNode(arg_6_0, arg_6_1)
	return arg_6_0.connectNode[arg_6_1]
end

function var_0_0.getDirectionNum(arg_7_0)
	return #arg_7_0.directionList
end

function var_0_0.isEndNode(arg_8_0)
	return arg_8_0.connectNodeNum <= 1
end

function var_0_0.isNotConnctDirection(arg_9_0)
	return #arg_9_0.directionList > arg_9_0.connectNodeNum
end

function var_0_0.isSideNode(arg_10_0)
	return arg_10_0.neighborNum <= 6
end

return var_0_0
