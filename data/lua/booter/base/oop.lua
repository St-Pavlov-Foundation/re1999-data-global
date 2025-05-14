module("booter.base.oop", package.seeall)

function class(arg_1_0, arg_1_1)
	local var_1_0 = type(arg_1_1)
	local var_1_1

	if var_1_0 ~= "function" and var_1_0 ~= "table" then
		var_1_0 = nil
		arg_1_1 = nil
	end

	if var_1_0 == "function" or arg_1_1 and arg_1_1.__ctype == 1 then
		var_1_1 = {}

		if var_1_0 == "table" then
			for iter_1_0, iter_1_1 in pairs(arg_1_1) do
				var_1_1[iter_1_0] = iter_1_1
			end

			var_1_1.__create = arg_1_1.__create
			var_1_1.super = arg_1_1
		else
			var_1_1.__create = arg_1_1

			function var_1_1.ctor()
				return
			end
		end

		var_1_1.__cname = arg_1_0
		var_1_1.__ctype = 1

		function var_1_1.New(...)
			local var_3_0 = var_1_1.__create(...)

			for iter_3_0, iter_3_1 in pairs(var_1_1) do
				var_3_0[iter_3_0] = iter_3_1
			end

			var_3_0.class = var_1_1

			var_3_0:ctor(...)

			return var_3_0
		end
	else
		if arg_1_1 then
			var_1_1 = {}

			setmetatable(var_1_1, {
				__index = arg_1_1
			})

			var_1_1.super = arg_1_1
		else
			var_1_1 = {
				ctor = function()
					return
				end
			}
		end

		var_1_1.__cname = arg_1_0
		var_1_1.__ctype = 2
		var_1_1.__index = var_1_1

		function var_1_1.New(...)
			local var_5_0 = setmetatable({}, var_1_1)

			var_5_0.class = var_1_1

			var_5_0:ctor(...)

			return var_5_0
		end
	end

	return var_1_1
end

function isTypeOf(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		error("istypeof clsDefine can not be nil! ")
	end

	if arg_6_0 == nil then
		return false
	end

	local var_6_0 = arg_6_1.__cname
	local var_6_1 = arg_6_0

	while var_6_1 ~= nil do
		if var_6_1.__cname == var_6_0 then
			return true
		end

		var_6_1 = var_6_1.super
	end

	return false
end

setGlobal("class", class)
setGlobal("isTypeOf", isTypeOf)
