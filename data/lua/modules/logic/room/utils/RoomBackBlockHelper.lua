module("modules.logic.room.utils.RoomBackBlockHelper", package.seeall)

local var_0_0 = {
	State = {
		Near = 2,
		Back = 0,
		Map = 1
	}
}

function var_0_0.isCanBack(arg_1_0, arg_1_1)
	if var_0_0.isHasInitBlock(arg_1_1) then
		return false
	end

	local var_1_0 = var_0_0._createMapDic(arg_1_0)

	return var_0_0._isCanBackBlocks(var_1_0, arg_1_1, true)
end

function var_0_0.resfreshInitBlockEntityEffect()
	local var_2_0 = RoomMapBlockModel.instance:isBackMore()
	local var_2_1 = RoomConfig.instance:getInitBlockList()
	local var_2_2 = RoomMapBlockModel.instance:getBackBlockModel()
	local var_2_3 = GameSceneMgr.instance:getCurScene()

	for iter_2_0 = 1, #var_2_1 do
		local var_2_4 = var_2_1[iter_2_0]
		local var_2_5 = RoomMapBlockModel.instance:getFullBlockMOById(var_2_4.blockId)

		if var_2_5 then
			if var_2_0 then
				var_2_2:remove(var_2_5)
				var_2_5:setOpState(RoomBlockEnum.OpState.Back, false)
			else
				var_2_5:setOpState(RoomBlockEnum.OpState.Normal)
			end

			local var_2_6 = var_2_3.mapmgr:getBlockEntity(var_2_5.id, SceneTag.RoomMapBlock)

			if var_2_6 then
				var_2_6:refreshBlock()
			end
		end
	end
end

function var_0_0.sortBackBlockMOList(arg_3_0, arg_3_1)
	if not arg_3_1 or not arg_3_0 or var_0_0.isHasInitBlock(arg_3_1) then
		return arg_3_1
	end

	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = #arg_3_1

	tabletool.addValues(var_3_0, arg_3_1)

	local var_3_3 = var_0_0._createMapDic(arg_3_0)

	for iter_3_0 = 1, var_3_2 do
		for iter_3_1 = 1, #var_3_0 do
			table.insert(var_3_1, var_3_0[iter_3_1])

			if var_0_0._isCanBackBlocks(var_3_3, var_3_1) then
				table.remove(var_3_0, iter_3_1)

				break
			else
				table.remove(var_3_1, #var_3_1)
			end
		end

		if iter_3_0 > #var_3_1 then
			break
		end
	end

	tabletool.addValues(var_3_1, var_3_0)

	for iter_3_2 = 1, #var_3_1 do
		arg_3_1[iter_3_2] = var_3_1[iter_3_2]
	end

	return arg_3_1
end

function var_0_0.isHasInitBlock(arg_4_0)
	local var_4_0 = RoomConfig.instance

	for iter_4_0 = 1, #arg_4_0 do
		if var_4_0:getInitBlock(arg_4_0[iter_4_0].id) then
			return true
		end
	end

	return false
end

function var_0_0._isCanBackBlocks(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == true then
		var_0_0._restMapDic(arg_5_0)
	end

	var_0_0._setBackBlockMOList(arg_5_0, arg_5_1)
	var_0_0._findNearCount(arg_5_0, 0, 0)

	return var_0_0._sumCountByState(arg_5_0, var_0_0.State.Map) == 0
end

function var_0_0._setBackBlockMOList(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.State.Back

	for iter_6_0 = 1, #arg_6_1 do
		local var_6_1 = arg_6_1[iter_6_0].hexPoint
		local var_6_2 = var_6_1 and arg_6_0[var_6_1.x]

		if var_6_2 then
			local var_6_3 = var_6_2[var_6_1.y]

			if var_6_3 and var_6_3 ~= var_6_0 then
				var_6_2[var_6_1.y] = var_6_0
			end
		end
	end
end

function var_0_0._sumCountByState(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			if iter_7_3 == arg_7_1 then
				var_7_0 = var_7_0 + 1
			end
		end
	end

	return var_7_0
end

function var_0_0._restMapDic(arg_8_0)
	local var_8_0 = var_0_0.State.Map

	for iter_8_0, iter_8_1 in pairs(arg_8_0) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			iter_8_1[iter_8_2] = var_8_0
		end
	end
end

function var_0_0._createMapDic(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = var_0_0.State.Map

	for iter_9_0 = 1, #arg_9_0 do
		local var_9_2 = arg_9_0[iter_9_0].hexPoint
		local var_9_3 = var_9_0[var_9_2.x]

		if not var_9_3 then
			var_9_3 = {}
			var_9_0[var_9_2.x] = var_9_3
		end

		var_9_3[var_9_2.y] = var_9_1
	end

	return var_9_0
end

function var_0_0._findNearCount(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_3 = arg_10_3 or 0

	if (arg_10_0[arg_10_1] and arg_10_0[arg_10_1][arg_10_2]) == var_0_0.State.Map then
		arg_10_3 = arg_10_3 + 1
		arg_10_0[arg_10_1][arg_10_2] = var_0_0.State.Near

		for iter_10_0 = 1, 6 do
			local var_10_0, var_10_1 = var_0_0._getNearXY(arg_10_1, arg_10_2, iter_10_0)

			arg_10_3 = var_0_0._findNearCount(arg_10_0, var_10_0, var_10_1, arg_10_3)
		end
	end

	return arg_10_3
end

function var_0_0._getNearXY(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == 1 then
		return arg_11_0 - 1, arg_11_1 + 1
	elseif arg_11_2 == 2 then
		return arg_11_0 - 1, arg_11_1
	elseif arg_11_2 == 3 then
		return arg_11_0, arg_11_1 - 1
	elseif arg_11_2 == 4 then
		return arg_11_0 + 1, arg_11_1 - 1
	elseif arg_11_2 == 5 then
		return arg_11_0 + 1, arg_11_1
	elseif arg_11_2 == 6 then
		return arg_11_0, arg_11_1 + 1
	end
end

return var_0_0
