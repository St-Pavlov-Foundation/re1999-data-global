module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyBehaviorData", package.seeall)

local var_0_0 = class("EnemyBehaviorData")

function var_0_0.ctor(arg_1_0)
	arg_1_0._cd = 0
	arg_1_0._skillList = {}
	arg_1_0._skillProbability = {}
	arg_1_0._needReGenerate = false
end

function var_0_0.cd(arg_2_0)
	return arg_2_0._cd
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._cd = arg_3_1.round or 0

	for iter_3_0 = 1, 3 do
		local var_3_0 = arg_3_1["list" .. iter_3_0]

		if var_3_0 ~= "" then
			local var_3_1 = string.splitToNumber(var_3_0, "#")

			if var_3_1 ~= nil then
				table.insert(arg_3_0._skillList, var_3_1)
			end
		end

		local var_3_2 = arg_3_1["prob" .. iter_3_0]

		if var_3_2 ~= "" then
			local var_3_3 = string.splitToNumber(var_3_2, "#")

			if var_3_3 ~= nil then
				table.insert(arg_3_0._skillProbability, var_3_3)
			end
		end
	end
end

function var_0_0.getSkillList(arg_4_0, arg_4_1)
	arg_4_0:_generateUseSkillList()

	if arg_4_1 then
		arg_4_0._needReGenerate = true
	end

	return arg_4_0._needReleaseSkillList
end

function var_0_0._generateUseSkillList(arg_5_0)
	local var_5_0 = arg_5_0._needReleaseSkillList == nil or arg_5_0._needReGenerate

	if arg_5_0._needReleaseSkillList == nil then
		arg_5_0._needReleaseSkillList = {}
	end

	if arg_5_0._needReGenerate then
		tabletool.clear(arg_5_0._needReleaseSkillList)

		arg_5_0._needReGenerate = false
	end

	if var_5_0 then
		for iter_5_0 = 1, #arg_5_0._skillList do
			local var_5_1 = arg_5_0._skillList[iter_5_0]
			local var_5_2 = var_5_1[1]

			if #var_5_1 > 1 then
				local var_5_3 = arg_5_0._skillProbability[iter_5_0]

				var_5_2 = var_5_1[EliminateModelUtils.getRandomNumberByWeight(var_5_3)]
			end

			if var_5_2 ~= nil then
				local var_5_4 = LengZhou6SkillUtils.instance.createSkill(var_5_2)

				table.insert(arg_5_0._needReleaseSkillList, var_5_4)
			end
		end
	end
end

return var_0_0
