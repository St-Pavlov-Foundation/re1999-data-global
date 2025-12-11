module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiGameMo", package.seeall)

local var_0_0 = class("YeShuMeiGameMo", YeShuMeiLevelMo)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0.id = arg_1_0

	return var_1_0
end

function var_0_0._initPoint(arg_2_0, arg_2_1)
	if arg_2_1.points ~= nil then
		for iter_2_0, iter_2_1 in pairs(arg_2_1.points) do
			local var_2_0 = YeShuMeiPointMo.New(iter_2_1)

			arg_2_0.points[iter_2_1.id] = var_2_0
		end
	end
end

function var_0_0.getAllPoint(arg_3_0)
	return arg_3_0.points
end

function var_0_0.getAllLine(arg_4_0)
	return arg_4_0.lines
end

function var_0_0.getPointById(arg_5_0, arg_5_1)
	if arg_5_0.points == nil then
		return nil
	end

	return arg_5_0.points[arg_5_1]
end

function var_0_0.getPointByConfigId(arg_6_0, arg_6_1)
	if arg_6_0.points == nil then
		return nil
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.points) do
		if iter_6_1.configId == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.haveLine(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.lines == nil then
		return false
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.lines) do
		if iter_7_1:havePoint(arg_7_1, arg_7_2) then
			return true
		end
	end

	return false
end

function var_0_0.checkLineExist(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.lines == nil then
		return false
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.lines) do
		if iter_8_1:havePoint(arg_8_1, arg_8_2) then
			return true
		end
	end

	return false
end

function var_0_0.setOrderIndex(arg_9_0)
	arg_9_0:_initOrder()

	arg_9_0._curOrderIndex = 1

	local var_9_0 = arg_9_0.orders[arg_9_0._curOrderIndex]

	arg_9_0:_initCurrentOrder(var_9_0)
end

function var_0_0._initCurrentOrder(arg_10_0, arg_10_1)
	arg_10_0._sequenceOrder = string.splitToNumber(arg_10_1, "#")
	arg_10_0._reverseOrder = arg_10_0:_getReverseOrder(arg_10_0._sequenceOrder)
end

function var_0_0._initOrder(arg_11_0)
	if arg_11_0.orderstr ~= nil then
		arg_11_0.orders = string.split(arg_11_0.orderstr, "|")
	end
end

function var_0_0._getReverseOrder(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = #arg_12_1, 1, -1 do
		var_12_0[#var_12_0 + 1] = arg_12_1[iter_12_0]
	end

	return var_12_0
end

function var_0_0.getStartPointIds(arg_13_0)
	if not arg_13_0._sequenceOrder or #arg_13_0._sequenceOrder < 0 then
		return
	end

	return {
		arg_13_0._sequenceOrder[1],
		arg_13_0._reverseOrder[1]
	}
end

function var_0_0.getCurrentStartOrder(arg_14_0, arg_14_1)
	if not arg_14_0._sequenceOrder or #arg_14_0._sequenceOrder < 0 then
		return
	end

	if arg_14_1 == arg_14_0._sequenceOrder[1] then
		return arg_14_0._sequenceOrder
	elseif arg_14_1 == arg_14_0._reverseOrder[1] then
		return arg_14_0._reverseOrder
	end
end

function var_0_0.destroy(arg_15_0)
	if arg_15_0.points ~= nil then
		for iter_15_0, iter_15_1 in pairs(arg_15_0.points) do
			if iter_15_1 then
				iter_15_1:destroy()
			end
		end

		arg_15_0.points = nil
	end
end

return var_0_0
