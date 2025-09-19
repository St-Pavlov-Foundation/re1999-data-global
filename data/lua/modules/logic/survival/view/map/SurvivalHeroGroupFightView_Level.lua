module("modules.logic.survival.view.map.SurvivalHeroGroupFightView_Level", package.seeall)

local var_0_0 = class("SurvivalHeroGroupFightView_Level", HeroGroupFightViewLevel)

function var_0_0._btnenemyOnClick(arg_1_0)
	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_1_0 then
		return
	end

	local var_1_1 = 0
	local var_1_2 = 0
	local var_1_3 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.SurvivalHpFixRate_WorldLv)
	local var_1_4 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.SurvivalHpFixRate_Hard)
	local var_1_5 = var_1_0:getAttr(SurvivalEnum.AttrType.WorldLevel)

	if not string.nilorempty(var_1_3) then
		for iter_1_0, iter_1_1 in ipairs(GameUtil.splitString2(var_1_3, true)) do
			if var_1_5 == iter_1_1[1] then
				var_1_2 = iter_1_1[2]

				break
			end
		end
	end

	if not string.nilorempty(var_1_4) then
		for iter_1_2, iter_1_3 in ipairs(GameUtil.splitString2(var_1_4, true)) do
			if var_1_0.difficulty == iter_1_3[1] then
				var_1_1 = iter_1_3[2]

				break
			end
		end
	end

	EnemyInfoController.instance:openSurvivalEnemyInfoView(arg_1_0._battleId, var_1_1 + var_1_2)
end

return var_0_0
