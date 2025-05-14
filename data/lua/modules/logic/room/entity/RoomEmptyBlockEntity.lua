module("modules.logic.room.entity.RoomEmptyBlockEntity", package.seeall)

local var_0_0 = class("RoomEmptyBlockEntity", RoomBaseBlockEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._nearWaveList = {}
	arg_1_0._nearRiverList = {}

	for iter_1_0 = 1, 6 do
		table.insert(arg_1_0._nearWaveList, false)
		table.insert(arg_1_0._nearRiverList, false)
	end
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.RoomEmptyBlock
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, arg_3_1)
end

function var_0_0.initComponents(arg_4_0)
	var_0_0.super.initComponents(arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
end

function var_0_0.refreshLand(arg_6_0)
	arg_6_0:refreshWater()
	arg_6_0:refreshWaveEffect()
end

function var_0_0.refreshWater(arg_7_0)
	return
end

function var_0_0.refreshBlock(arg_8_0)
	var_0_0.super.refreshBlock(arg_8_0)
end

function var_0_0.refreshWaveEffect(arg_9_0)
	local var_9_0 = arg_9_0:getMO().hexPoint
	local var_9_1 = arg_9_0._nearWaveList
	local var_9_2 = arg_9_0._nearRiverList
	local var_9_3 = RoomMapBlockModel.instance

	for iter_9_0 = 1, 6 do
		local var_9_4 = HexPoint.directions[iter_9_0]
		local var_9_5 = false
		local var_9_6 = false
		local var_9_7 = var_9_3:getBlockMO(var_9_0.x + var_9_4.x, var_9_0.y + var_9_4.y)

		if var_9_7 and var_9_7:isInMapBlock() then
			var_9_5 = true
			var_9_6 = var_9_7:hasRiver(true)
		end

		var_9_1[iter_9_0] = var_9_5
		var_9_2[iter_9_0] = var_9_6
	end

	local var_9_8, var_9_9, var_9_10 = RoomWaveHelper.getWaveList(var_9_1, var_9_2)
	local var_9_11 = false
	local var_9_12 = RoomEnum.EffectKey.BlockWaveEffectKeys

	for iter_9_1 = 1, #var_9_8 do
		local var_9_13 = var_9_8[iter_9_1]
		local var_9_14 = var_9_10[iter_9_1]
		local var_9_15 = var_9_9[iter_9_1]

		if not arg_9_0.effect:isSameResByKey(var_9_12[iter_9_1], var_9_13) then
			arg_9_0.effect:addParams({
				[var_9_12[iter_9_1]] = {
					res = var_9_13,
					ab = var_9_14,
					localRotation = Vector3(0, (var_9_15 - 1) * 60, 0)
				}
			})

			var_9_11 = true
		end
	end

	for iter_9_2 = #var_9_8 + 1, 6 do
		if arg_9_0.effect:getEffectRes(var_9_12[iter_9_2]) then
			arg_9_0.effect:removeParams({
				var_9_12[iter_9_2]
			})

			var_9_11 = true
		end
	end

	if var_9_11 then
		arg_9_0.effect:refreshEffect()
	end
end

function var_0_0.beforeDestroy(arg_10_0)
	var_0_0.super.beforeDestroy(arg_10_0)
end

function var_0_0.getMO(arg_11_0)
	return RoomMapBlockModel.instance:getEmptyBlockMOById(arg_11_0.id)
end

return var_0_0
