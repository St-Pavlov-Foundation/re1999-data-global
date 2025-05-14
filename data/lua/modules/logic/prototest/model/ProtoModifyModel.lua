module("modules.logic.prototest.model.ProtoModifyModel", package.seeall)

local var_0_0 = class("ProtoModifyModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._protoMO = nil
	arg_1_0._depthParamMOs = {}
end

function var_0_0.getProtoMO(arg_2_0)
	return arg_2_0._protoMO
end

function var_0_0.getDepthParamMOs(arg_3_0)
	return arg_3_0._depthParamMOs
end

function var_0_0.getLastMO(arg_4_0)
	local var_4_0 = #arg_4_0._depthParamMOs

	if var_4_0 > 0 then
		return arg_4_0._depthParamMOs[var_4_0]
	else
		return arg_4_0._protoMO
	end
end

function var_0_0.enterProto(arg_5_0, arg_5_1)
	arg_5_0._protoMO = arg_5_1

	arg_5_0:setList(arg_5_1.value)
end

function var_0_0.enterParam(arg_6_0, arg_6_1)
	local var_6_0

	if #arg_6_0._depthParamMOs > 0 then
		var_6_0 = arg_6_0._depthParamMOs[#arg_6_0._depthParamMOs].value[arg_6_1]
	else
		var_6_0 = arg_6_0._protoMO.value[arg_6_1]
	end

	table.insert(arg_6_0._depthParamMOs, var_6_0)

	if var_6_0:isRepeated() or var_6_0:isProtoType() then
		arg_6_0:setList(var_6_0.value)

		if var_6_0:isRepeated() then
			arg_6_0:addAtLast({
				id = -99999
			})
		end
	end
end

function var_0_0.exitParam(arg_7_0)
	local var_7_0 = #arg_7_0._depthParamMOs

	table.remove(arg_7_0._depthParamMOs, var_7_0)

	if var_7_0 > 1 then
		local var_7_1 = arg_7_0._depthParamMOs[var_7_0 - 1]

		arg_7_0:setList(var_7_1.value)

		if var_7_1:isRepeated() then
			arg_7_0:addAtLast({
				id = -99999
			})
		end
	else
		arg_7_0:setList(arg_7_0._protoMO.value)
	end
end

function var_0_0.addRepeatedParam(arg_8_0)
	local var_8_0 = #arg_8_0._depthParamMOs

	if var_8_0 > 0 then
		local var_8_1 = arg_8_0._depthParamMOs[var_8_0]

		if var_8_1:isRepeated() then
			local var_8_2 = ProtoTestCaseParamMO.New()

			var_8_2.id = #var_8_1.value + 1
			var_8_2.key = #var_8_1.value + 1
			var_8_2.pType = var_8_1.pType
			var_8_2.pLabel = ProtoEnum.LabelType.optional
			var_8_2.repeated = true
			var_8_2.struct = var_8_1.struct

			if var_8_2.struct then
				var_8_2.value = ProtoParamHelper.buildValueMOsByStructName(var_8_2.struct)
			end

			table.insert(var_8_1.value, var_8_2)
			arg_8_0:addAt(var_8_2, var_8_2.id)
		else
			logError("can't remove param, not repeated")
		end
	else
		logError("cant't remove param, not at root")
	end
end

function var_0_0.removeRepeatedParam(arg_9_0, arg_9_1)
	local var_9_0 = #arg_9_0._depthParamMOs

	if var_9_0 > 0 then
		local var_9_1 = arg_9_0._depthParamMOs[var_9_0]

		if var_9_1:isRepeated() then
			table.remove(var_9_1.value, arg_9_1)
			arg_9_0:removeAt(arg_9_1)

			for iter_9_0, iter_9_1 in ipairs(var_9_1.value) do
				iter_9_1.id = iter_9_0
				iter_9_1.key = iter_9_0
			end
		else
			logError("can't remove param, not repeated")
		end
	else
		logError("cant't remove param, not at root")
	end
end

function var_0_0.isRoot(arg_10_0)
	return #arg_10_0._depthParamMOs == 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
