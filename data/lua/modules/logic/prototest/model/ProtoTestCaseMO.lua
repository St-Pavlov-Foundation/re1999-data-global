module("modules.logic.prototest.model.ProtoTestCaseMO", package.seeall)

local var_0_0 = pureTable("ProtoTestCaseMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.cmd = nil
	arg_1_0.time = nil
	arg_1_0.struct = nil
	arg_1_0.value = nil
end

function var_0_0.initFromProto(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.cmd = arg_2_1
	arg_2_0.time = ServerTime.now()
	arg_2_0.struct = arg_2_2.__cname
	arg_2_0.value = ProtoParamHelper.buildProtoParamsByProto(arg_2_2)
end

function var_0_0.initFromJson(arg_3_0, arg_3_1)
	return
end

function var_0_0.clone(arg_4_0)
	local var_4_0 = var_0_0.New()

	var_4_0.cmd = arg_4_0.cmd
	var_4_0.time = ServerTime.now()
	var_4_0.struct = arg_4_0.struct
	var_4_0.value = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.value) do
		table.insert(var_4_0.value, iter_4_1:clone())
	end

	return var_4_0
end

function var_0_0.buildProtoMsg(arg_5_0)
	local var_5_0 = LuaSocketMgr.instance:getCmdSetting(arg_5_0.cmd)

	if not var_5_0 then
		logError("module not exist, cmd = " .. arg_5_0.cmd)

		return
	end

	local var_5_1 = var_5_0[1] .. "Module_pb"
	local var_5_2 = getGlobal(var_5_1) or addGlobalModule("modules.proto." .. var_5_1, var_5_1)

	if not var_5_2 then
		logError(string.format("pb not exist: %s.%s", var_5_1, arg_5_0.struct))

		return
	end

	local var_5_3 = var_5_2[arg_5_0.struct]()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.value) do
		iter_5_1:fillProtoMsg(var_5_3)
	end

	return var_5_3
end

function var_0_0.serialize(arg_6_0)
	local var_6_0 = {
		cmd = arg_6_0.cmd,
		time = arg_6_0.time,
		struct = arg_6_0.struct,
		value = {}
	}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.value) do
		table.insert(var_6_0.value, iter_6_1:serialize())
	end

	return var_6_0
end

function var_0_0.deserialize(arg_7_0, arg_7_1)
	arg_7_0.cmd = arg_7_1.cmd
	arg_7_0.time = arg_7_1.time
	arg_7_0.struct = arg_7_1.struct
	arg_7_0.value = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.value) do
		local var_7_0 = ProtoTestCaseParamMO.New()

		var_7_0:deserialize(iter_7_1)
		table.insert(arg_7_0.value, var_7_0)
	end
end

return var_0_0
