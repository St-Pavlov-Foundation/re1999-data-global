module("modules.logic.resonance.config.HeroResonanceConfig", package.seeall)

local var_0_0 = class("HeroResonanceConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.resonance_config = nil
	arg_1_0.resonance_cost_config = nil
	arg_1_0.resonance_cube_shape = nil
	arg_1_0.resonance_model_config = nil
	arg_1_0.resonance_style_config = nil
	arg_1_0.resonance_style_cost_config = nil
	arg_1_0.cube_rightful = {}
	arg_1_0.matrix_data = {}
	arg_1_0.cube_lastrowful = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"talent_cube_attr",
		"character_talent",
		"talent_cube_shape",
		"talent_mould",
		"talent_style",
		"talent_style_cost"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "talent_cube_attr" then
		arg_3_0.resonance_config = arg_3_2
	elseif arg_3_1 == "character_talent" then
		arg_3_0.resonance_cost_config = arg_3_2

		arg_3_0:_initCharacterTalent()
	elseif arg_3_1 == "talent_cube_shape" then
		arg_3_0.resonance_cube_shape = arg_3_2
	elseif arg_3_1 == "talent_mould" then
		arg_3_0.resonance_model_config = arg_3_2
	elseif arg_3_1 == "talent_style" then
		arg_3_0.resonance_style_config = arg_3_2

		arg_3_0:initParseTalentStyle()
	elseif arg_3_1 == "talent_style_cost" then
		arg_3_0.resonance_style_cost_config = arg_3_2
	end
end

function var_0_0._initCharacterTalent(arg_4_0)
	arg_4_0._talentMaxLvMap = {}

	for iter_4_0, iter_4_1 in ipairs(lua_character_talent.configList) do
		local var_4_0 = arg_4_0._talentMaxLvMap[iter_4_1.heroId] or 0
		local var_4_1 = math.max(iter_4_1.talentId, var_4_0)

		arg_4_0._talentMaxLvMap[iter_4_1.heroId] = var_4_1
	end
end

function var_0_0.getHeroMaxTalentLv(arg_5_0, arg_5_1)
	return arg_5_0._talentMaxLvMap[arg_5_1] or 1
end

function var_0_0.getCubeConfig(arg_6_0, arg_6_1)
	return arg_6_0.resonance_cube_shape.configDict[arg_6_1] or logError("共鸣形状表找不到id：", arg_6_1)
end

function var_0_0.getCubeConfigNotError(arg_7_0, arg_7_1)
	return arg_7_0.resonance_cube_shape.configDict[arg_7_1]
end

function var_0_0.getCubeRightful(arg_8_0, arg_8_1)
	if not arg_8_0.cube_rightful[arg_8_1] then
		local var_8_0 = arg_8_0:getCubeConfig(arg_8_1)
		local var_8_1 = 0
		local var_8_2 = string.split(var_8_0.shape, "#")

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			local var_8_3 = string.splitToNumber(iter_8_1, ",")

			for iter_8_2, iter_8_3 in ipairs(var_8_3) do
				if iter_8_3 == 1 then
					var_8_1 = var_8_1 + 1
				end
			end
		end

		arg_8_0.cube_rightful[arg_8_1] = var_8_1
	end

	return arg_8_0.cube_rightful[arg_8_1]
end

function var_0_0.getLastRowfulPos(arg_9_0, arg_9_1)
	if not arg_9_0.cube_lastrowful[arg_9_1] then
		local var_9_0 = arg_9_0:getCubeConfig(arg_9_1)
		local var_9_1 = 0
		local var_9_2 = string.split(var_9_0.shape, "#")
		local var_9_3 = string.splitToNumber(var_9_2[#var_9_2], ",")

		for iter_9_0 = #var_9_3, 1, -1 do
			if var_9_3[iter_9_0] ~= 1 then
				var_9_1 = var_9_1 + 1
			else
				arg_9_0.cube_lastrowful[arg_9_1] = var_9_1

				return arg_9_0.cube_lastrowful[arg_9_1]
			end
		end

		arg_9_0.cube_lastrowful[arg_9_1] = var_9_1
	end

	return arg_9_0.cube_lastrowful[arg_9_1]
end

function var_0_0.getCubeMatrix(arg_10_0, arg_10_1)
	if arg_10_0.matrix_data[arg_10_1] then
		return arg_10_0.matrix_data[arg_10_1]
	end

	local var_10_0 = arg_10_0:getCubeConfig(arg_10_1)
	local var_10_1 = {}
	local var_10_2 = string.split(var_10_0.shape, "#")

	for iter_10_0 = 0, #var_10_2 - 1 do
		var_10_1[iter_10_0] = {}

		for iter_10_1, iter_10_2 in ipairs(string.split(var_10_2[iter_10_0 + 1], ",")) do
			var_10_1[iter_10_0][iter_10_1 - 1] = tonumber(iter_10_2)
		end
	end

	arg_10_0.matrix_data[arg_10_1] = var_10_1

	return arg_10_0.matrix_data[arg_10_1]
end

function var_0_0.getTalentConfig(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.resonance_cost_config.configDict[arg_11_1]

	if not var_11_0 then
		logError("共鸣表找不到,英雄id：", arg_11_1, "共鸣等级：", arg_11_2)
	end

	return var_11_0 and var_11_0[arg_11_2]
end

function var_0_0.getTalentAllShape(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getTalentModelConfig(arg_12_1, arg_12_2)

	if not var_12_0 then
		logError("共鸣表找不到,英雄id：", arg_12_1, "共鸣等级：", arg_12_2)

		return
	end

	return var_12_0.allShape
end

function var_0_0.getTalentModelConfig(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0.resonance_model_config.configDict[arg_13_2] and arg_13_0:getTalentConfig(arg_13_1, arg_13_2) and arg_13_0.resonance_model_config.configDict[arg_13_2][arg_13_0:getTalentConfig(arg_13_1, arg_13_2).talentMould]
end

function var_0_0.getTalentModelShapeMaxLevel(arg_14_0, arg_14_1)
	if not arg_14_0.max_talent_model_shape_level then
		arg_14_0.max_talent_model_shape_level = {}
	end

	if arg_14_0.max_talent_model_shape_level[arg_14_1] then
		return arg_14_0.max_talent_model_shape_level[arg_14_1]
	end

	local var_14_0 = 0
	local var_14_1 = arg_14_0:getTalentConfig(arg_14_1, 1).talentMould
	local var_14_2
	local var_14_3 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.resonance_model_config.configDict) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			if iter_14_3.talentMould == var_14_1 then
				table.insert(var_14_3, {
					talentId = iter_14_3.talentId,
					allShape = iter_14_3.allShape
				})

				if iter_14_3.allShape ~= var_14_2 then
					var_14_2 = iter_14_3.allShape
					var_14_0 = var_14_0 + 1
				end
			end
		end
	end

	table.sort(var_14_3, function(arg_15_0, arg_15_1)
		return arg_15_0.talentId < arg_15_1.talentId
	end)

	if not arg_14_0.cur_talent_model_shape_level then
		arg_14_0.cur_talent_model_shape_level = {}
	end

	arg_14_0.cur_talent_model_shape_level[var_14_1] = var_14_3
	arg_14_0.max_talent_model_shape_level[arg_14_1] = var_14_0

	return var_14_0
end

function var_0_0.getCurTalentModelShapeLevel(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getTalentConfig(arg_16_1, 1).talentMould
	local var_16_1 = 0
	local var_16_2

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.cur_talent_model_shape_level[var_16_0]) do
		if iter_16_1.allShape ~= var_16_2 then
			var_16_1 = var_16_1 + 1
			var_16_2 = iter_16_1.allShape
		end

		if arg_16_2 <= iter_16_1.talentId then
			break
		end
	end

	return var_16_1
end

function var_0_0.initParseTalentStyle(arg_17_0)
	arg_17_0.talent_style_replace_cube_list = {}

	if arg_17_0.resonance_style_config then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.resonance_style_config.configList) do
			if iter_17_1 and not string.nilorempty(iter_17_1.replaceCube) then
				local var_17_0 = GameUtil.splitString2(iter_17_1.replaceCube)

				for iter_17_2, iter_17_3 in pairs(var_17_0) do
					local var_17_1 = TalentStyleMo.New()
					local var_17_2 = tonumber(iter_17_3[1])
					local var_17_3 = tonumber(iter_17_3[2])

					if var_17_2 and var_17_3 then
						var_17_1:setMo(iter_17_1, var_17_2, var_17_3)

						local var_17_4 = arg_17_0.talent_style_replace_cube_list[var_17_2] or {}

						var_17_4[iter_17_1.styleId] = var_17_1
						arg_17_0.talent_style_replace_cube_list[var_17_2] = var_17_4
					end
				end
			end
		end

		for iter_17_4, iter_17_5 in pairs(arg_17_0.talent_style_replace_cube_list) do
			local var_17_5 = TalentStyleMo.New()
			local var_17_6, var_17_7 = next(iter_17_5)
			local var_17_8 = arg_17_0.resonance_style_config.configDict[var_17_7._styleCo.talentMould][0]

			var_17_5:setMo(var_17_8, iter_17_4, iter_17_4)

			iter_17_5[0] = var_17_5
		end
	end
end

function var_0_0.getTalentStyle(arg_18_0, arg_18_1)
	return arg_18_0.talent_style_replace_cube_list and arg_18_0.talent_style_replace_cube_list[arg_18_1]
end

function var_0_0.getTalentStyleUnlockConsume(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getTalentStyleCostConfig(arg_19_1, arg_19_2)

	return var_19_0 and var_19_0.consume
end

function var_0_0.getTalentStyleCostConfig(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.resonance_style_cost_config and arg_20_0.resonance_style_cost_config.configDict[arg_20_1]

	if var_20_0 then
		return var_20_0[arg_20_2]
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
