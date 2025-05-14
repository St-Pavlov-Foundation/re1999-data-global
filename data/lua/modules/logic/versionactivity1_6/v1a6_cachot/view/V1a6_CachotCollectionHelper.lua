module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionHelper", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionHelper")

function var_0_0.refreshSkillDesc(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0, var_1_1 = V1a6_CachotCollectionConfig.instance:getCollectionSkillsInfo(arg_1_0)
	local var_1_2 = var_1_0 and #var_1_0 or 0

	tabletool.addValues(var_1_0, var_1_1)

	local var_1_3 = arg_1_3 or var_0_0._refreshSingleSkillDesc
	local var_1_4 = arg_1_4 or var_0_0._refreshSingleEffectDesc
	local var_1_5 = arg_1_5 or var_0_0

	gohelper.CreateObjList(var_1_5, var_1_3, var_1_0, arg_1_1, arg_1_2, nil, 1, var_1_2)
	gohelper.CreateObjList(var_1_5, var_1_4, var_1_0, arg_1_1, arg_1_2, nil, var_1_2 + 1)
end

function var_0_0.refreshSkillDescWithoutEffectDesc(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = V1a6_CachotCollectionConfig.instance:getCollectionSkillsByConfig(arg_2_0)
	local var_2_1 = var_2_0 and #var_2_0 or 0
	local var_2_2 = arg_2_3 or var_0_0._refreshSingleSkillDesc
	local var_2_3 = arg_2_4 or var_0_0

	gohelper.CreateObjList(var_2_3, var_2_2, var_2_0, arg_2_1, arg_2_2, nil, 1, var_2_1)
end

function var_0_0._refreshSingleSkillDesc(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = lua_rule.configDict[arg_3_2]
	local var_3_1 = var_3_0 and var_3_0.desc or ""

	gohelper.findChildText(arg_3_1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(var_3_1)
end

function var_0_0._refreshSingleEffectDesc(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = SkillConfig.instance:getSkillEffectDescCo(arg_4_2)

	if var_4_0 then
		local var_4_1 = gohelper.findChildText(arg_4_1, "txt_desc")
		local var_4_2 = string.format("[%s]: %s", var_4_0.name, var_4_0.desc)

		var_4_1.text = HeroSkillModel.instance:skillDesToSpot(var_4_2)
	end
end

function var_0_0.refreshEnchantDesc(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = V1a6_CachotCollectionConfig.instance:getCollectionSpDescsByConfig(arg_5_0)
	local var_5_1 = arg_5_3 or var_0_0._refreshSingleEnchantDesc
	local var_5_2 = arg_5_4 or var_0_0

	gohelper.CreateObjList(var_5_2, var_5_1, var_5_0, arg_5_1, arg_5_2)
end

function var_0_0._refreshSingleEnchantDesc(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	gohelper.findChildText(arg_6_1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(arg_6_2)
end

function var_0_0.isCollectionBagCanEnchant()
	local var_7_0 = false
	local var_7_1 = false
	local var_7_2 = V1a6_CachotModel.instance:getRogueInfo()

	if var_7_2 then
		local var_7_3 = var_7_2.collections
		local var_7_4 = var_7_2.enchants
		local var_7_5 = var_7_4 and #var_7_4 or 0
		local var_7_6 = var_7_3 and #var_7_3 or 0

		if var_7_5 <= 0 or var_7_6 <= 0 then
			return false
		end

		for iter_7_0 = 1, var_7_6 do
			local var_7_7 = var_7_3[iter_7_0]

			var_7_0, var_7_1 = var_0_0.isCollectionHoleEmptyOrUnEnchant(var_7_7, var_7_0, var_7_1)

			if var_7_0 and var_7_1 then
				break
			end
		end
	end

	return var_7_0 and var_7_1
end

function var_0_0.isCollectionHoleEmptyOrUnEnchant(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_8_0.cfgId)
	local var_8_1 = var_8_0.type

	if var_8_1 ~= V1a6_CachotEnum.CollectionType.Enchant and not arg_8_1 then
		local var_8_2 = var_8_0.holeNum
		local var_8_3 = arg_8_0:getEnchantCount()

		arg_8_1 = arg_8_1 or var_8_3 < var_8_2
	elseif var_8_1 == V1a6_CachotEnum.CollectionType.Enchant and not arg_8_2 then
		local var_8_4 = arg_8_0:isEnchant()

		arg_8_2 = arg_8_2 or not var_8_4
	end

	return arg_8_1, arg_8_2
end

function var_0_0.createCollectionHoles(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0 and arg_9_0.holeNum or 0

	gohelper.CreateNumObjList(arg_9_1, arg_9_2, var_9_0)
end

function var_0_0.refreshCollectionUniqueTip(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0 and arg_10_0.unique == 1

	if var_10_0 then
		local var_10_1 = ""

		if arg_10_0.showRare == V1a6_CachotEnum.CollectionShowRare.Boss then
			var_10_1 = luaLang("v1a6_cachotcollection_bossunique")
		else
			var_10_1 = luaLang("p_v1a6_cachot_collectionbagview_txt_uniquetips")
		end

		if arg_10_1 then
			arg_10_1.text = var_10_1
		end
	end

	if arg_10_2 then
		gohelper.setActive(arg_10_2, var_10_0)
	end
end

return var_0_0
