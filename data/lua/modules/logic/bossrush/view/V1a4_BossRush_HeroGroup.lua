module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroup", package.seeall)

local var_0_0 = class("V1a4_BossRush_HeroGroup", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentViewContainer = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.transform
	local var_2_1 = var_2_0.childCount

	arg_2_0._groupList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, var_2_1 - 1 do
		local var_2_2 = var_2_0:GetChild(iter_2_0)
		local var_2_3 = arg_2_0:getUserDataTb_()

		for iter_2_1 = 0, iter_2_0 do
			local var_2_4 = var_2_2:GetChild(iter_2_1).gameObject

			table.insert(var_2_3, var_2_4)
		end

		table.insert(arg_2_0._groupList, var_2_3)
	end
end

function var_0_0._createHeroItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0
	local var_3_1

	if arg_3_3 then
		var_3_0 = V1a4_BossRush_HeroGroupItem1
		var_3_1 = BossRushEnum.ResPath.v1a4_bossrush_herogroupitem1
	else
		var_3_0 = V1a4_BossRush_HeroGroupItem2
		var_3_1 = BossRushEnum.ResPath.v1a4_bossrush_herogroupitem2
	end

	local var_3_2 = arg_3_0._parentViewContainer:getResInst(var_3_1, arg_3_1, var_3_0.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_3_2, var_3_0)
end

function var_0_0.setDataByFightParam(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getHeroEquipMoList()
	local var_4_1 = math.min(4, #var_4_0)
	local var_4_2 = arg_4_0._groupList[var_4_1]

	arg_4_0._heroList = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_3 = var_4_2[iter_4_0]
		local var_4_4 = iter_4_1.heroMo
		local var_4_5 = iter_4_1.equipMo
		local var_4_6 = arg_4_0:_createHeroItem(var_4_3, var_4_4, var_4_5)

		var_4_6:setData(var_4_4, var_4_5)

		arg_4_0._heroList[iter_4_0] = var_4_6
	end
end

function var_0_0.setDataByCurFightParam(arg_5_0)
	arg_5_0:setDataByFightParam(FightModel.instance:getFightParam())
end

function var_0_0.onDestroyView(arg_6_0)
	GameUtil.onDestroyViewMemberList(arg_6_0, "_heroList")
end

return var_0_0
