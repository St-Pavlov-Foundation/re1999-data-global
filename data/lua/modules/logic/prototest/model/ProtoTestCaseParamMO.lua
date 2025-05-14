module("modules.logic.prototest.model.ProtoTestCaseParamMO", package.seeall)

local var_0_0 = pureTable("ProtoTestCaseParamMO")

function var_0_0.initProto(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.key = arg_1_2.name
	arg_1_0.value = arg_1_3
	arg_1_0.id = arg_1_2.number
	arg_1_0.pType = arg_1_2.type
	arg_1_0.pLabel = arg_1_2.label
	arg_1_0.repeated = false

	if arg_1_0:isRepeated() then
		arg_1_0.value = ProtoParamHelper.buildRepeatedParamsByProto(arg_1_3 or {}, arg_1_0)

		if arg_1_2.message_type then
			arg_1_0.struct = arg_1_2.message_type.name
		end
	elseif arg_1_0:isProtoType() then
		if arg_1_3 then
			arg_1_0.struct = getmetatable(arg_1_3)._descriptor.name
			arg_1_0.value = ProtoParamHelper.buildProtoParamsByProto(arg_1_3, arg_1_0)
		else
			arg_1_0.struct = arg_1_2.message_type.name

			local var_1_0 = ProtoParamHelper.buildProtoByStructName(arg_1_0.struct)

			arg_1_0.value = ProtoParamHelper.buildProtoParamsByProto(var_1_0, arg_1_0)
		end
	end
end

function var_0_0.initProtoRepeated(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.key = arg_2_2
	arg_2_0.value = arg_2_3
	arg_2_0.id = arg_2_2
	arg_2_0.pType = arg_2_1.pType
	arg_2_0.pLabel = ProtoEnum.LabelType.optional
	arg_2_0.repeated = true

	if arg_2_0:isProtoType() then
		arg_2_0.struct = getmetatable(arg_2_3)._descriptor.name
		arg_2_0.value = ProtoParamHelper.buildProtoParamsByProto(arg_2_3, arg_2_0)
	end
end

function var_0_0.isProtoType(arg_3_0)
	return arg_3_0.pType == ProtoEnum.ParamType.proto
end

function var_0_0.isOptional(arg_4_0)
	return arg_4_0.pLabel == ProtoEnum.LabelType.optional
end

function var_0_0.isRepeated(arg_5_0)
	return arg_5_0.pLabel == ProtoEnum.LabelType.repeated
end

function var_0_0.getParamDescLine(arg_6_0)
	if arg_6_0:isRepeated() then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_0.value) do
			table.insert(var_6_0, iter_6_1:getParamDescLine())
		end

		return string.format("%s:{%s}", arg_6_0.key, table.concat(var_6_0, ","))
	elseif arg_6_0:isProtoType() then
		local var_6_1 = {}

		if arg_6_0.value then
			for iter_6_2, iter_6_3 in ipairs(arg_6_0.value) do
				table.insert(var_6_1, iter_6_3:getParamDescLine())
			end
		end

		if arg_6_0.repeated then
			return string.format("{%s}", table.concat(var_6_1, ","))
		else
			return string.format("%s:{%s}", arg_6_0.key, table.concat(var_6_1, ","))
		end
	elseif arg_6_0.repeated then
		return cjson.encode(arg_6_0.value)
	else
		return string.format("%s:%s", arg_6_0.key, arg_6_0.value)
	end
end

function var_0_0.clone(arg_7_0)
	local var_7_0 = var_0_0.New()

	var_7_0.key = arg_7_0.key
	var_7_0.value = arg_7_0.value
	var_7_0.id = arg_7_0.id
	var_7_0.pType = arg_7_0.pType
	var_7_0.pLabel = arg_7_0.pLabel
	var_7_0.struct = arg_7_0.struct
	var_7_0.repeated = arg_7_0.repeated

	if arg_7_0:isRepeated() then
		var_7_0.value = {}

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.value) do
			table.insert(var_7_0.value, iter_7_1:clone())
		end
	elseif arg_7_0:isProtoType() then
		var_7_0.value = {}

		for iter_7_2, iter_7_3 in ipairs(arg_7_0.value) do
			local var_7_1 = iter_7_3:clone()

			table.insert(var_7_0.value, var_7_1)
		end
	end

	return var_7_0
end

function var_0_0.fillProtoMsg(arg_8_0, arg_8_1)
	if not arg_8_0.value then
		return
	end

	if arg_8_0:isRepeated() then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.value) do
			iter_8_1:fillProtoMsg(arg_8_1[arg_8_0.key])
		end
	elseif arg_8_0:isProtoType() then
		if arg_8_0.repeated then
			local var_8_0 = ProtoParamHelper.buildProtoByStructName(arg_8_0.struct)

			for iter_8_2, iter_8_3 in ipairs(arg_8_0.value) do
				iter_8_3:fillProtoMsg(var_8_0)
			end

			table.insert(arg_8_1, var_8_0)
		else
			for iter_8_4, iter_8_5 in ipairs(arg_8_0.value) do
				iter_8_5:fillProtoMsg(arg_8_1[arg_8_0.key])
			end
		end
	elseif arg_8_0.repeated then
		table.insert(arg_8_1, arg_8_0.value)
	else
		if not arg_8_1 then
			logError(arg_8_0.key)
		end

		arg_8_1[arg_8_0.key] = arg_8_0.value
	end
end

function var_0_0.serialize(arg_9_0)
	local var_9_0 = {
		key = arg_9_0.key,
		value = arg_9_0.value,
		id = arg_9_0.id,
		pType = arg_9_0.pType,
		pLabel = arg_9_0.pLabel,
		repeated = arg_9_0.repeated,
		struct = arg_9_0.struct
	}

	if arg_9_0:isRepeated() or arg_9_0:isProtoType() then
		var_9_0.value = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.value) do
			table.insert(var_9_0.value, iter_9_1:serialize())
		end
	end

	return var_9_0
end

function var_0_0.deserialize(arg_10_0, arg_10_1)
	arg_10_0.key = arg_10_1.key
	arg_10_0.value = arg_10_1.value
	arg_10_0.id = arg_10_1.id
	arg_10_0.pType = arg_10_1.pType
	arg_10_0.pLabel = arg_10_1.pLabel
	arg_10_0.repeated = arg_10_1.repeated
	arg_10_0.struct = arg_10_1.struct

	if arg_10_0:isRepeated() or arg_10_0:isProtoType() then
		arg_10_0.value = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1.value) do
			local var_10_0 = var_0_0.New()

			var_10_0:deserialize(iter_10_1)
			table.insert(arg_10_0.value, var_10_0)
		end
	end
end

return var_0_0
