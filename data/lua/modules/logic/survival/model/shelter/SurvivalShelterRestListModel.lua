module("modules.logic.survival.model.shelter.SurvivalShelterRestListModel", package.seeall)

local var_0_0 = class("SurvivalShelterRestListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if arg_1_1 then
		local var_1_1 = arg_1_1:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)
		local var_1_2 = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_1.heros) do
			var_1_2[iter_1_1] = iter_1_0
		end

		for iter_1_2 = 1, var_1_1 do
			local var_1_3 = {
				pos = iter_1_2 - 1
			}

			var_1_3.heroId = var_1_2[var_1_3.pos] or 0
			var_1_3.buildingId = arg_1_1.id

			table.insert(var_1_0, var_1_3)
		end

		local var_1_4 = SurvivalConfig.instance:getBuildingConfig(arg_1_1.buildingId, arg_1_1.level + 1, true)

		if var_1_4 then
			local var_1_5 = GameUtil.splitString2(var_1_4.effect)

			for iter_1_3, iter_1_4 in ipairs(var_1_5) do
				if iter_1_4[1] == "buildPermAttrAdd" and tonumber(iter_1_4[2]) == SurvivalEnum.AttrType.LoungeRoleNum then
					for iter_1_5 = 1, tonumber(iter_1_4[3]) do
						local var_1_6 = {}

						table.insert(var_1_0, var_1_6)
					end
				end
			end
		end
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.dropHealthHero(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_2_1 = arg_2_1:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)
	local var_2_2 = var_2_0:getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	local var_2_3 = false
	local var_2_4 = {}

	for iter_2_0 = 1, var_2_1 do
		table.insert(var_2_4, 0)
	end

	for iter_2_1, iter_2_2 in pairs(arg_2_1.heros) do
		if var_2_2 == var_2_0:getHeroMo(iter_2_1).health then
			var_2_3 = true
		else
			var_2_4[iter_2_2 + 1] = iter_2_1
		end
	end

	if not var_2_3 then
		return
	end

	SurvivalWeekRpc.instance:sendSurvivalBatchHeroChangePositionRequest(var_2_4, arg_2_1.id)
end

var_0_0.instance = var_0_0.New()

return var_0_0
