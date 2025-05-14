module("modules.logic.versionactivity1_4.act131.model.Activity131LevelInfoMo", package.seeall)

local var_0_0 = pureTable("Activity131LevelInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = 0
	arg_1_0.state = 0
	arg_1_0.progress = 0
	arg_1_0.act131Elements = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1.episodeId
	arg_2_0.state = arg_2_1.state
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.act131Elements = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.act131Elements) do
		local var_2_0 = Activity131ElementMo.New()

		var_2_0:init(iter_2_1)
		table.insert(arg_2_0.act131Elements, var_2_0)
	end

	table.sort(arg_2_0.act131Elements, var_0_0.sortById)
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	if arg_3_0.state ~= arg_3_1.state then
		arg_3_0.state = arg_3_1.state

		Activity131Controller.instance:dispatchEvent(Activity131Event.FirstFinish, arg_3_1.episodeId)
	end

	arg_3_0.progress = arg_3_1.progress
	arg_3_0.act131Elements = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.act131Elements) do
		local var_3_0 = Activity131ElementMo.New()

		var_3_0:init(iter_3_1)
		table.insert(arg_3_0.act131Elements, var_3_0)
	end

	table.sort(arg_3_0.act131Elements, var_0_0.sortById)
end

function var_0_0.sortById(arg_4_0, arg_4_1)
	return arg_4_0.elementId < arg_4_1.elementId
end

return var_0_0
