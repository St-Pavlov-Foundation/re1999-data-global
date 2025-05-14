module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroupItemBase", package.seeall)

local var_0_0 = class("V1a4_BossRush_HeroGroupItemBase", LuaCompBase)

function var_0_0._initGoList(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getUserDataTb_()
	local var_1_1 = 1
	local var_1_2 = arg_1_0[arg_1_1 .. tostring(var_1_1)]

	while not gohelper.isNil(var_1_2) do
		var_1_0[var_1_1] = var_1_2
		var_1_1 = var_1_1 + 1
		var_1_2 = arg_1_0[arg_1_1 .. tostring(var_1_1)]
	end

	return var_1_0
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._heroMo = arg_2_1
	arg_2_0._equipMo = arg_2_2

	arg_2_0:onSetData()
end

function var_0_0.refreshShowLevel(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_0._heroMo
	local var_3_1 = var_3_0 and var_3_0.level or 0
	local var_3_2, var_3_3 = HeroConfig.instance:getShowLevel(var_3_1)

	arg_3_1.text = tostring(var_3_2)
end

function var_0_0.refreshLevelList(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0._heroMo
	local var_4_1 = var_4_0 and var_4_0.level or 0
	local var_4_2, var_4_3 = HeroConfig.instance:getShowLevel(var_4_1)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		gohelper.setActive(iter_4_1, iter_4_0 == var_4_3 - 1)
	end
end

function var_0_0.refreshStarList(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0._heroMo
	local var_5_1 = var_5_0 and var_5_0.config
	local var_5_2 = var_5_0 and var_5_1.rare or -1

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		gohelper.setActive(iter_5_1, iter_5_0 <= var_5_2 + 1)
	end
end

function var_0_0.getHeadIconMiddleResUrl(arg_6_0)
	local var_6_0 = arg_6_0._heroMo

	if not var_6_0 then
		return
	end

	local var_6_1 = FightConfig.instance:getSkinCO(var_6_0.skin)

	return ResUrl.getHeadIconMiddle(var_6_1.retangleIcon)
end

function var_0_0.getCareerSpriteName(arg_7_0)
	local var_7_0 = arg_7_0._heroMo

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.config

	return "lssx_" .. tostring(var_7_1.career)
end

function var_0_0.getEquipIconSpriteName(arg_8_0)
	local var_8_0 = arg_8_0._equipMo

	if not var_8_0 then
		return
	end

	return var_8_0.config.icon
end

function var_0_0.getEquipRareSprite(arg_9_0)
	local var_9_0 = arg_9_0._equipMo

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0.config

	return "bianduixingxian_" .. tostring(var_9_1.rare)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:onDestroy()
end

function var_0_0._refreshHeroByDefault(arg_11_0)
	if not arg_11_0._heroMo then
		gohelper.setActive(arg_11_0._gohero, false)

		return
	end

	local var_11_0 = arg_11_0:getHeadIconMiddleResUrl()

	arg_11_0._simageheroicon:LoadImage(var_11_0)

	local var_11_1 = arg_11_0:getCareerSpriteName()

	UISpriteSetMgr.instance:setCommonSprite(arg_11_0._imagecareer, var_11_1)
end

function var_0_0.onSetData(arg_12_0)
	assert(false, "please override this function")
end

function var_0_0.onDestroy(arg_13_0)
	return
end

return var_0_0
