module("modules.logic.character.model.HeroTalentCubeInfosMO", package.seeall)

local var_0_0 = pureTable("HeroTalentCubeInfosMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.data_list = {}

	for iter_1_0 = 1, #arg_1_1 do
		arg_1_0.data_list[iter_1_0] = {}
		arg_1_0.data_list[iter_1_0].cubeId = arg_1_1[iter_1_0].cubeId
		arg_1_0.data_list[iter_1_0].direction = arg_1_1[iter_1_0].direction
		arg_1_0.data_list[iter_1_0].posX = arg_1_1[iter_1_0].posX
		arg_1_0.data_list[iter_1_0].posY = arg_1_1[iter_1_0].posY
	end
end

function var_0_0.clearData(arg_2_0)
	arg_2_0.data_list = {}
end

function var_0_0.setOwnData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.own_cube_dic = {}
	arg_3_0.own_cube_list = {}

	local var_3_0 = HeroResonanceConfig.instance:getTalentConfig(arg_3_1, arg_3_2)

	if var_3_0 then
		arg_3_0.own_cube_list = {}

		if var_3_0 then
			arg_3_0.own_cube_dic = {}

			local var_3_1 = string.splitToNumber(var_3_0.exclusive, "#")

			if var_3_1 and #var_3_1 > 0 then
				arg_3_0.own_cube_dic[var_3_1[1]] = {
					own = 1,
					use = 0,
					id = var_3_1[1],
					level = var_3_1[2]
				}
				arg_3_0.own_main_cube_id = var_3_1[1]
			end
		end

		local var_3_2 = HeroResonanceConfig.instance:getTalentModelConfig(arg_3_1, arg_3_2)

		for iter_3_0 = 10, 20 do
			local var_3_3 = string.splitToNumber(var_3_2["type" .. iter_3_0], "#")

			if var_3_3 and #var_3_3 > 0 then
				if not arg_3_0.own_cube_dic[iter_3_0] then
					arg_3_0.own_cube_dic[iter_3_0] = {}
				end

				arg_3_0.own_cube_dic[iter_3_0].id = iter_3_0
				arg_3_0.own_cube_dic[iter_3_0].own = var_3_3[1]
				arg_3_0.own_cube_dic[iter_3_0].level = var_3_3[2]
				arg_3_0.own_cube_dic[iter_3_0].use = 0
			end
		end

		for iter_3_1 = #arg_3_0.data_list, 1, -1 do
			local var_3_4 = arg_3_0.data_list[iter_3_1]

			if arg_3_0.own_cube_dic[var_3_4.cubeId] then
				arg_3_0.own_cube_dic[var_3_4.cubeId].own = arg_3_0.own_cube_dic[var_3_4.cubeId].own - 1
				arg_3_0.own_cube_dic[var_3_4.cubeId].use = arg_3_0.own_cube_dic[var_3_4.cubeId].use + 1
			else
				table.remove(arg_3_0.data_list, iter_3_1)
			end
		end

		for iter_3_2, iter_3_3 in pairs(arg_3_0.own_cube_dic) do
			if iter_3_3.own > 0 then
				table.insert(arg_3_0.own_cube_list, iter_3_3)
			end
		end
	end

	return arg_3_0.own_cube_dic, arg_3_0.own_cube_list
end

function var_0_0.getMainCubeMo(arg_4_0)
	return arg_4_0.own_cube_dic[arg_4_0.own_main_cube_id]
end

return var_0_0
