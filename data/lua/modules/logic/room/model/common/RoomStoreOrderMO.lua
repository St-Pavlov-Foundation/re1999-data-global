module("modules.logic.room.model.common.RoomStoreOrderMO", package.seeall)

local var_0_0 = pureTable("RoomStoreOrderMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0._materialDateMOList = {}
	arg_1_0._poolList = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.goodsId = arg_2_1
	arg_2_0.themeId = arg_2_2

	arg_2_0:clear()
end

function var_0_0.addValue(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0:getMaterialDateMO(arg_3_1, arg_3_2)

	if not var_3_0 then
		var_3_0 = arg_3_0:_popMaterialDateMO() or MaterialDataMO.New()

		var_3_0:initValue(arg_3_1, arg_3_2, arg_3_3)

		var_3_0.tempCount = 0

		table.insert(arg_3_0._materialDateMOList, var_3_0)
	else
		var_3_0.quantity = var_3_0.quantity + arg_3_3
	end
end

function var_0_0.getMaterialDateMO(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._materialDateMOList

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = var_4_0[iter_4_0]

		if var_4_1.materilId == arg_4_2 and var_4_1.materilType == arg_4_1 then
			return var_4_1
		end
	end

	return nil
end

function var_0_0.isSameValue(arg_5_0, arg_5_1)
	arg_5_0:_resetListTempCountValue()

	local var_5_0 = true

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_1 = arg_5_1[iter_5_0]
		local var_5_2 = arg_5_0:getMaterialDateMO(var_5_1.materilType, var_5_1.materilId)

		if var_5_2 then
			var_5_2.tempCount = var_5_2.tempCount + var_5_1.quantity
		else
			var_5_0 = false

			break
		end
	end

	if var_5_0 then
		local var_5_3 = arg_5_0._materialDateMOList

		for iter_5_1 = 1, #var_5_3 do
			local var_5_4 = var_5_3[iter_5_1]

			if var_5_4.quantity ~= var_5_4.tempCount then
				var_5_0 = false

				break
			end
		end
	end

	arg_5_0:_resetListTempCountValue()

	return var_5_0
end

function var_0_0._resetListTempCountValue(arg_6_0)
	local var_6_0 = arg_6_0._materialDateMOList

	for iter_6_0 = 1, #var_6_0 do
		var_6_0[iter_6_0].tempCount = 0
	end
end

function var_0_0._popMaterialDateMO(arg_7_0)
	local var_7_0 = #arg_7_0._poolList

	if var_7_0 > 0 then
		local var_7_1 = arg_7_0._poolList[var_7_0]

		var_7_1.quantity = 0
		var_7_1.tempCount = 0

		table.remove(arg_7_0._poolList, var_7_0)

		return var_7_1
	end
end

function var_0_0.clear(arg_8_0)
	if #arg_8_0._materialDateMOList > 0 then
		tabletool.addArray(arg_8_0._poolList, arg_8_0._materialDateMOList)

		arg_8_0._materialDateMOList = {}
	end
end

return var_0_0
