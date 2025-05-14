module("modules.logic.prototest.core.ProtoTestMgr", package.seeall)

local var_0_0 = class("ProtoTestMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0.isShowFiles = false
	arg_1_0._isRecording = false
	arg_1_0._preSender = ProtoTestPreSender.New()

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.startRecord(arg_2_0)
	arg_2_0._isRecording = true

	LuaSocketMgr.instance:registerPreSender(arg_2_0._preSender)
end

function var_0_0.endRecord(arg_3_0)
	arg_3_0._isRecording = false

	LuaSocketMgr.instance:unregisterPreSender(arg_3_0._preSender)
end

function var_0_0.isRecording(arg_4_0)
	return arg_4_0._isRecording
end

function var_0_0.readFromFile(arg_5_0, arg_5_1)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	local var_5_0 = ProtoFileHelper.getFullPathByFileName(arg_5_1)
	local var_5_1 = SLFramework.FileHelper.ReadText(var_5_0)
	local var_5_2 = cjson.decode(var_5_1)
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		local var_5_4 = ProtoTestCaseMO.New()

		var_5_4:deserialize(iter_5_1)
		table.insert(var_5_3, var_5_4)
	end

	return var_5_3
end

function var_0_0.saveToFile(arg_6_0, arg_6_1, arg_6_2)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	local var_6_0 = ProtoFileHelper.getFullPathByFileName(arg_6_1)
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		table.insert(var_6_1, iter_6_1:serialize())
	end

	local var_6_2 = cjson.encode(var_6_1)

	SLFramework.FileHelper.WriteTextToPath(var_6_0, var_6_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
