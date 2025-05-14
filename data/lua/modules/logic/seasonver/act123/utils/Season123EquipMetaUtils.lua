module("modules.logic.seasonver.act123.utils.Season123EquipMetaUtils", package.seeall)

local var_0_0 = class("Season123EquipMetaUtils")

var_0_0.attrKey = {
	atk = "attack",
	def = "defense",
	dropDmg = "dropDmg",
	cri = "cri",
	revive = "revive",
	recri = "recri",
	mdef = "mdefense",
	defenseIgnore = "defenseIgnore",
	addDmg = "addDmg",
	absorb = "absorb",
	hp = "hp",
	criDmg = "criDmg",
	heal = "heal",
	criDef = "criDef",
	normalSkillRate = "normalSkillRate",
	clutch = "clutch"
}

function var_0_0.getEquipPropsDescStr(arg_1_0)
	local var_1_0 = ""
	local var_1_1 = Season123Config.instance:getSeasonEquipCo(arg_1_0)

	if var_1_1 then
		local var_1_2 = var_0_0.getEquipPropsStrList(var_1_1.attrId)

		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			if string.nilorempty(var_1_0) then
				var_1_0 = var_1_0 .. iter_1_1
			else
				var_1_0 = var_1_0 .. "\n" .. iter_1_1
			end
		end

		local var_1_3 = var_0_0.getSkillEffectStrList(var_1_1)

		for iter_1_2, iter_1_3 in ipairs(var_1_3) do
			local var_1_4 = string.format(luaLang("season_effect_desc_template"), iter_1_3)

			if string.nilorempty(var_1_0) then
				var_1_0 = var_1_0 .. var_1_4
			else
				var_1_0 = var_1_0 .. "\n" .. var_1_4
			end
		end

		if string.nilorempty(var_1_0) then
			var_1_0 = var_1_0 .. "\n"
		end

		return var_1_0
	else
		logError(string.format("can't find season equip config, id = [%s]", arg_1_0))
	end

	return var_1_0
end

var_0_0.PropValueColorPattern = "<color=#d2c197>"

function var_0_0.getEquipPropsStrList(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1

	if arg_2_0 then
		var_2_1 = Season123Config.instance:getSeasonEquipAttrCo(arg_2_0)
	end

	if not var_2_1 then
		return var_2_0
	end

	for iter_2_0, iter_2_1 in pairs(var_0_0.attrKey) do
		local var_2_2 = var_2_1[iter_2_0]

		if var_2_2 and var_2_2 ~= 0 then
			local var_2_3 = HeroConfig.instance:getIDByAttrType(iter_2_1)
			local var_2_4 = HeroConfig.instance:getHeroAttributeCO(var_2_3)

			if var_2_4 then
				local var_2_5 = var_2_4.name
				local var_2_6 = var_2_4.showType == 1 and "%%" or ""
				local var_2_7 = var_2_4.showType == 1 and 10 or 1
				local var_2_8 = var_0_0.PropValueColorPattern

				if arg_2_1 then
					var_2_8 = ""
				end

				if var_2_2 > 0 then
					var_2_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_attr_up"), {
						var_2_5,
						var_2_8,
						tostring(var_2_2 / var_2_7),
						var_2_6
					})
				else
					var_2_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_attr_down"), {
						var_2_5,
						var_2_8,
						tostring(-var_2_2 / var_2_7),
						var_2_6
					})
				end

				table.insert(var_2_0, var_2_5)
			end
		end
	end

	return var_2_0
end

function var_0_0.getSkillEffectStrList(arg_3_0)
	local var_3_0 = arg_3_0.skillId
	local var_3_1 = {}

	if var_3_0 then
		local var_3_2

		if arg_3_0.isMain == Activity123Enum.isMainRole then
			local var_3_3 = string.split(var_3_0, "|")

			var_3_2 = {}

			for iter_3_0, iter_3_1 in ipairs(var_3_3) do
				local var_3_4 = string.splitToNumber(iter_3_1, "#")

				if #var_3_4 >= 2 and var_3_4[2] ~= nil then
					table.insert(var_3_2, var_3_4[2])
				end
			end
		else
			var_3_2 = string.splitToNumber(var_3_0, "#")
		end

		for iter_3_2, iter_3_3 in ipairs(var_3_2) do
			local var_3_5 = FightConfig.instance:getSkillEffectCO(iter_3_3)

			if var_3_5 then
				table.insert(var_3_1, FightConfig.instance:getSkillEffectDesc(nil, var_3_5))
			else
				logError(string.format("can't find skill config ID = [%s]", iter_3_3))
			end
		end
	end

	return var_3_1
end

function var_0_0.isMainRoleCard(arg_4_0)
	return arg_4_0.isMain == Activity123Enum.isMainRole
end

function var_0_0.getCurSeasonEquipCount(arg_5_0)
	local var_5_0 = Season123Model.instance:getCurSeasonId()

	if Season123Model.instance:getActInfo(var_5_0) ~= nil then
		return var_0_0.getEquipCount(var_5_0, arg_5_0)
	end

	return 0
end

var_0_0.Text_Career_Color_Bright_Bg = {
	["0"] = "#252525",
	["1"] = "#ac5320",
	["2"] = "#324bb6",
	["5"] = "#804885",
	["3"] = "#27682e",
	["4"] = "#9f342c"
}

function var_0_0.getCareerColorBrightBg(arg_6_0)
	local var_6_0 = Season123Config.instance:getSeasonEquipCo(arg_6_0)

	if var_6_0 and var_6_0.career then
		return var_0_0.Text_Career_Color_Bright_Bg[var_6_0.career] or var_0_0.Text_Career_Color_Bright_Bg["0"]
	end

	return var_0_0.Text_Career_Color_Bright_Bg["0"]
end

var_0_0.No_Effect_Alpha = "66"
var_0_0.Text_Career_Color_Dark_Bg = {
	["0"] = "#cac8c5",
	["1"] = "#e99b56",
	["2"] = "#6384e5",
	["5"] = "#804885",
	["3"] = "#65b96f",
	["4"] = "#d97373"
}

function var_0_0.getCareerColorDarkBg(arg_7_0)
	local var_7_0 = Season123Config.instance:getSeasonEquipCo(arg_7_0)

	if var_7_0 and var_7_0.career then
		return var_0_0.Text_Career_Color_Dark_Bg[var_7_0.career] or var_0_0.Text_Career_Color_Dark_Bg["0"]
	end

	return var_0_0.Text_Career_Color_Dark_Bg["0"]
end

function var_0_0.getEquipCount(arg_8_0, arg_8_1)
	local var_8_0 = Season123Model.instance:getAllItemMo(arg_8_0)

	if var_8_0 then
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if iter_8_1.itemId == arg_8_1 then
				var_8_1 = var_8_1 + 1
			end

			return var_8_1
		end
	end

	return 0
end

function var_0_0.applyIconOffset(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Season123Config.instance:getSeasonEquipCo(arg_9_0)

	if var_9_0 then
		local var_9_1 = 0
		local var_9_2 = 0
		local var_9_3 = 1
		local var_9_4 = 26
		local var_9_5 = -180
		local var_9_6 = 0.76

		if not string.nilorempty(var_9_0.iconOffset) then
			local var_9_7 = string.splitToNumber(var_9_0.iconOffset, "#")

			var_9_1, var_9_2, var_9_3 = var_9_7[1], var_9_7[2], var_9_7[3]
		end

		if not string.nilorempty(var_9_0.signOffset) then
			local var_9_8 = string.splitToNumber(var_9_0.signOffset, "#")

			var_9_4, var_9_5, var_9_6 = var_9_8[1], var_9_8[2], var_9_8[3]
		end

		if arg_9_1 then
			transformhelper.setLocalScale(arg_9_1.transform, var_9_3, var_9_3, 1)
			recthelper.setAnchor(arg_9_1.transform, var_9_1, var_9_2)
		end

		if arg_9_2 then
			transformhelper.setLocalScale(arg_9_2.transform, var_9_6, var_9_6, 1)
			recthelper.setAnchor(arg_9_2.transform, var_9_4, var_9_5)
		end
	end
end

function var_0_0.isBanActivity(arg_10_0, arg_10_1)
	return arg_10_0.activityId ~= arg_10_1
end

return var_0_0
