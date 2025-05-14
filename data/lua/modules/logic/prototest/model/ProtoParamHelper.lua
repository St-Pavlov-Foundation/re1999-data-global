module("modules.logic.prototest.model.ProtoParamHelper", package.seeall)

local var_0_0 = _M

function var_0_0.buildProtoParamsByProto(arg_1_0, arg_1_1)
	local var_1_0 = getmetatable(arg_1_0)._descriptor.fields
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_2 = arg_1_0._fields[iter_1_1]
		local var_1_3 = ProtoTestCaseParamMO.New()

		var_1_3:initProto(arg_1_1, iter_1_1, var_1_2)
		table.insert(var_1_1, var_1_3)
	end

	table.sort(var_1_1, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)

	return var_1_1
end

function var_0_0.buildRepeatedParamsByProto(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		local var_3_1 = ProtoTestCaseParamMO.New()

		var_3_1:initProtoRepeated(arg_3_1, iter_3_0, iter_3_1)
		table.insert(var_3_0, var_3_1)
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0.id < arg_4_1.id
	end)

	return var_3_0
end

local var_0_1
local var_0_2 = {}

function var_0_0.buildProtoByStructName(arg_5_0)
	var_0_0._firstInitProtoDict()

	if var_0_2[arg_5_0] then
		return var_0_2[arg_5_0]()
	end

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		if iter_5_1[arg_5_0] then
			var_0_2[arg_5_0] = iter_5_1[arg_5_0]

			return var_0_2[arg_5_0]()
		end
	end
end

function var_0_0._firstInitProtoDict()
	if not var_0_1 then
		var_0_1 = {}

		for iter_6_0, iter_6_1 in pairs(moduleNameToPath) do
			if string.find(iter_6_0, "_pb") then
				if not moduleNameToTables[iter_6_0] then
					callWithCatch(function()
						local var_7_0 = _G[iter_6_0]
					end)
				end

				table.insert(var_0_1, moduleNameToTables[iter_6_0])
			end
		end
	end
end

function var_0_0.buildValueMOsByStructName(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = var_0_0.buildProtoByStructName(arg_8_0)
	local var_8_2 = getmetatable(var_8_1)._descriptor.fields

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = var_8_1._fields[iter_8_1]
		local var_8_4 = ProtoTestCaseParamMO.New()

		var_8_4:initProto(nil, iter_8_1, var_8_3)
		table.insert(var_8_0, var_8_4)
	end

	return var_8_0
end

return var_0_0
