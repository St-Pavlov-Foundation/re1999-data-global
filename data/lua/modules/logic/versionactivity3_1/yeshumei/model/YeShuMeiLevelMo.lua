module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiLevelMo", package.seeall)

local var_0_0 = class("YeShuMeiLevelMo", YeShuMeiLevelMo)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.points = {}
	arg_1_0.lines = {}
	arg_1_0.orders = {}
	arg_1_0._curOrderIndex = 1
end

function var_0_0.init(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return
	end

	arg_2_0.id = arg_2_1.id
	arg_2_0.orderstr = arg_2_1.orderstr

	if arg_2_0.orderstr ~= nil then
		arg_2_0.orders = string.split(arg_2_0.orderstr, "|")
	end

	arg_2_0:_initPoint(arg_2_1)
	arg_2_0:_initLine(arg_2_1)
end

function var_0_0._initPoint(arg_3_0, arg_3_1)
	if arg_3_1.points ~= nil then
		for iter_3_0, iter_3_1 in pairs(arg_3_1.points) do
			local var_3_0 = YeShuMeiPointMo.New(iter_3_1)

			var_3_0:updatePos(iter_3_1.posX, iter_3_1.posY)
			table.insert(arg_3_0.points, var_3_0)
		end
	end
end

function var_0_0._initLine(arg_4_0, arg_4_1)
	if arg_4_1.lines ~= nil then
		for iter_4_0, iter_4_1 in pairs(arg_4_1.lines) do
			local var_4_0 = YeShuMeiLineMo.New(iter_4_1.id)

			var_4_0:updatePos(iter_4_1.beginPosX, iter_4_1.beginPosY, iter_4_1.endPosX, iter_4_1.endPosY)
			var_4_0:updatePoint(iter_4_1.beginPointId, iter_4_1.endPointId)
			table.insert(arg_4_0.lines, var_4_0)
		end
	end
end

function var_0_0.getStr(arg_5_0)
	local var_5_0 = string.format("id = %d ,", arg_5_0.id)

	if arg_5_0.points ~= nil then
		var_5_0 = var_5_0 .. "points = { "

		for iter_5_0, iter_5_1 in pairs(arg_5_0.points) do
			var_5_0 = var_5_0 .. "{ " .. iter_5_1:getStr() .. " }, "
		end

		var_5_0 = var_5_0 .. "}, "
	end

	if arg_5_0.lines ~= nil then
		var_5_0 = var_5_0 .. "lines = { "

		for iter_5_2, iter_5_3 in pairs(arg_5_0.lines) do
			var_5_0 = var_5_0 .. "{ " .. iter_5_3:getStr() .. " }, "
		end

		var_5_0 = var_5_0 .. "}, "
	end

	if arg_5_0.orders ~= nil and #arg_5_0.orders > 0 then
		local var_5_1 = ""
		local var_5_2 = #arg_5_0.orders

		if var_5_2 > 1 then
			for iter_5_4 = 1, var_5_2 - 1 do
				var_5_1 = arg_5_0.orders[iter_5_4] .. "|" .. arg_5_0.orders[iter_5_4 + 1]
			end
		else
			var_5_1 = arg_5_0.orders[1]
		end

		var_5_0 = var_5_0 .. string.format("orderstr = '%s' ,", var_5_1)
	end

	return var_5_0
end

return var_0_0
