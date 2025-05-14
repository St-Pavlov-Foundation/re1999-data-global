module("framework.mvc.BaseModel", package.seeall)

local var_0_0 = class("BaseModel")

function var_0_0.ctor(arg_1_0)
	arg_1_0._idCounter = 1
	arg_1_0._list = {}
	arg_1_0._dict = {}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.reInitInternal(arg_4_0)
	arg_4_0:clear()
	arg_4_0:reInit()
end

function var_0_0.clear(arg_5_0)
	arg_5_0._idCounter = 1
	arg_5_0._list = {}
	arg_5_0._dict = {}
end

function var_0_0.getList(arg_6_0)
	return arg_6_0._list
end

function var_0_0.getDict(arg_7_0)
	return arg_7_0._dict
end

function var_0_0.getCount(arg_8_0)
	return #arg_8_0._list
end

function var_0_0.getById(arg_9_0, arg_9_1)
	return arg_9_0._dict[arg_9_1]
end

function var_0_0.getByIndex(arg_10_0, arg_10_1)
	return arg_10_0._list[arg_10_1]
end

function var_0_0.getIndex(arg_11_0, arg_11_1)
	return tabletool.indexOf(arg_11_0._list, arg_11_1)
end

function var_0_0.sort(arg_12_0, arg_12_1)
	table.sort(arg_12_0._list, arg_12_1)
end

function var_0_0.addList(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0:_fillMOId(iter_13_1)

		if arg_13_0._dict[iter_13_1.id] then
			local var_13_0 = tabletool.indexOf(arg_13_0._list, iter_13_1)

			if var_13_0 then
				arg_13_0._list[var_13_0] = iter_13_1
			else
				for iter_13_2, iter_13_3 in ipairs(arg_13_0._list) do
					if iter_13_3.id == iter_13_1.id then
						arg_13_0._list[iter_13_2] = iter_13_1

						break
					end
				end

				logError("mo.id duplicated, type = " .. (iter_13_1.__cname or "nil") .. ", id = " .. iter_13_1.id)
			end
		else
			table.insert(arg_13_0._list, iter_13_1)
		end

		arg_13_0._dict[iter_13_1.id] = iter_13_1
	end
end

function var_0_0.setList(arg_14_0, arg_14_1)
	arg_14_0._list = {}
	arg_14_0._dict = {}

	arg_14_0:addList(arg_14_1)
end

function var_0_0.addAt(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:_fillMOId(arg_15_1)

	if arg_15_0._dict[arg_15_1.id] then
		local var_15_0 = tabletool.indexOf(arg_15_0._list, arg_15_1)

		if var_15_0 then
			arg_15_0._list[var_15_0] = arg_15_1
		else
			logError("mo in dict, but not in list: " .. cjson.encode(arg_15_1))
		end

		logWarn(string.format("%s:addAt(mo, %d) fail, mo.id = %d has exist, cover origin data", arg_15_0.__cname, arg_15_2, arg_15_1.id))
	else
		table.insert(arg_15_0._list, arg_15_2, arg_15_1)
	end

	arg_15_0._dict[arg_15_1.id] = arg_15_1
end

function var_0_0.addAtFirst(arg_16_0, arg_16_1)
	arg_16_0:addAt(arg_16_1, 1)
end

function var_0_0.addAtLast(arg_17_0, arg_17_1)
	arg_17_0:addAt(arg_17_1, #arg_17_0._list + 1)
end

function var_0_0.removeAt(arg_18_0, arg_18_1)
	if arg_18_1 > #arg_18_0._list then
		return nil
	end

	local var_18_0 = table.remove(arg_18_0._list, arg_18_1)

	if var_18_0 then
		arg_18_0._dict[var_18_0.id] = nil
	end

	return var_18_0
end

function var_0_0.removeFirst(arg_19_0)
	return arg_19_0:removeAt(1)
end

function var_0_0.removeLast(arg_20_0)
	return arg_20_0:removeAt(#arg_20_0._list)
end

function var_0_0.remove(arg_21_0, arg_21_1)
	local var_21_0 = tabletool.indexOf(arg_21_0._list, arg_21_1)

	if var_21_0 then
		return arg_21_0:removeAt(var_21_0)
	end
end

function var_0_0._fillMOId(arg_22_0, arg_22_1)
	if not arg_22_1.id then
		while arg_22_0._dict[arg_22_0._idCounter] do
			arg_22_0._idCounter = arg_22_0._idCounter + 1
		end

		arg_22_1.id = arg_22_0._idCounter
		arg_22_0._idCounter = arg_22_0._idCounter + 1
	end
end

return var_0_0
