module("booter.base.tabletool", package.seeall)

local var_0_0 = {
	copy = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			var_1_0[iter_1_0] = iter_1_1
		end

		return var_1_0
	end,
	indexOf = function(arg_2_0, arg_2_1, arg_2_2)
		for iter_2_0 = arg_2_2 or 1, #arg_2_0 do
			if arg_2_0[iter_2_0] == arg_2_1 then
				return iter_2_0
			end
		end
	end,
	removeValue = function(arg_3_0, arg_3_1)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1 == arg_3_1 then
				table.remove(arg_3_0, iter_3_0)

				return
			end
		end
	end,
	addValues = function(arg_4_0, arg_4_1)
		if arg_4_0 and arg_4_1 then
			for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
				table.insert(arg_4_0, iter_4_1)
			end
		end
	end,
	clear = function(arg_5_0)
		for iter_5_0, iter_5_1 in pairs(arg_5_0) do
			arg_5_0[iter_5_0] = nil
		end
	end,
	revert = function(arg_6_0)
		if not arg_6_0 then
			return
		end

		local var_6_0 = 1
		local var_6_1 = #arg_6_0

		while var_6_0 < var_6_1 do
			arg_6_0[var_6_1], arg_6_0[var_6_0] = arg_6_0[var_6_0], arg_6_0[var_6_1]
			var_6_0 = var_6_0 + 1
			var_6_1 = var_6_1 - 1
		end
	end,
	len = function(arg_7_0)
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in pairs(arg_7_0) do
			if arg_7_0[iter_7_0] ~= nil then
				var_7_0 = var_7_0 + 1
			end
		end

		return var_7_0
	end,
	pureTable = function(arg_8_0, arg_8_1)
		local var_8_0 = {
			__cname = arg_8_0
		}

		var_8_0.__index = var_8_0

		if arg_8_1 then
			var_8_0.__newindex = arg_8_1.__newindex
		else
			function var_8_0.__newindex(arg_9_0, arg_9_1, arg_9_2)
				if type(arg_9_2) == "userdata" or type(arg_9_2) == "function" then
					error("pureTable instance object field not support userdata or function,key=" .. arg_9_1)
				else
					rawset(arg_9_0, arg_9_1, arg_9_2)
				end
			end
		end

		function var_8_0.ctor(arg_10_0)
			return
		end

		function var_8_0.New()
			local var_11_0 = {
				__cname = arg_8_0
			}

			var_8_0.ctor(var_11_0)
			setmetatable(var_11_0, var_8_0)

			return var_11_0
		end

		setmetatable(var_8_0, {
			__index = arg_8_1,
			__newindex = function(arg_12_0, arg_12_1, arg_12_2)
				if type(arg_12_2) ~= "function" then
					error("pureTable table only support function!key=" .. arg_12_1)
				else
					rawset(arg_12_0, arg_12_1, arg_12_2)
				end
			end
		})

		return var_8_0
	end,
	getDictJsonStr = function(arg_13_0)
		local var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs(arg_13_0) do
			table.insert(var_13_0, cjson.encode(iter_13_0) .. ":" .. cjson.encode(iter_13_1))
		end

		return string.format("{%s}", table.concat(var_13_0, ","))
	end
}

setGlobal("pureTable", var_0_0.pureTable)
setGlobal("tabletool", var_0_0)
