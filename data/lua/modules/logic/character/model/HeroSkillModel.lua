module("modules.logic.character.model.HeroSkillModel", package.seeall)

local var_0_0 = class("HeroSkillModel", BaseModel)

function var_0_0.formatDescWithColor_overseas(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_2 = arg_1_2 or "#d7a270"
	arg_1_3 = arg_1_3 or "#5f7197"

	local var_1_0 = arg_1_1

	if arg_1_4 ~= true then
		local var_1_1 = {}
		local var_1_2 = 0

		var_1_0 = string.gsub(var_1_0, "(%[.-%])", function(arg_2_0)
			var_1_2 = var_1_2 + 1
			var_1_1[var_1_2] = arg_2_0

			return "{" .. var_1_2 .. "}"
		end)
		var_1_0 = string.gsub(var_1_0, "(【.-】)", function(arg_3_0)
			var_1_2 = var_1_2 + 1
			var_1_1[var_1_2] = arg_3_0

			return "{" .. var_1_2 .. "}"
		end)
		var_1_0 = string.gsub(var_1_0, "%b<>", function(arg_4_0)
			var_1_2 = var_1_2 + 1
			var_1_1[var_1_2] = arg_4_0

			return "{" .. var_1_2 .. "}"
		end)

		if LangSettings.instance:isEn() then
			var_1_0 = string.gsub(var_1_0, "%w+%-%w+", function(arg_5_0)
				var_1_2 = var_1_2 + 1
				var_1_1[var_1_2] = arg_5_0

				return "{" .. var_1_2 .. "}"
			end)
		end

		var_1_0 = string.gsub(var_1_0, "([%d%-%+%%%./]+)", string.format("<color=%s>%%1</color>", arg_1_2))
		var_1_0 = string.gsub(var_1_0, "%b{}", function(arg_6_0)
			arg_6_0 = string.gsub(arg_6_0, "%b<>", "")

			local var_6_0 = tonumber(string.sub(arg_6_0, 2, -2))

			return var_1_1[var_6_0] or ""
		end)
	end

	local var_1_3 = string.gsub(var_1_0, "(%[.-%])", string.format("<color=%s>%%1</color>", arg_1_3))

	return (string.gsub(var_1_3, "(【.-】)", string.format("<color=%s>%%1</color>", arg_1_3)))
end

function var_0_0.onInit(arg_7_0)
	arg_7_0._skillTagInfos = {}
end

function var_0_0._initSkillTagInfos(arg_8_0)
	arg_8_0._skillTagInfos = {}

	local var_8_0 = SkillConfig.instance:getSkillEffectDescsCo()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		arg_8_0._skillTagInfos[iter_8_1.name] = iter_8_1
	end
end

function var_0_0.isTagSkillInfo(arg_9_0, arg_9_1)
	return arg_9_0._skillTagInfos[arg_9_1]
end

function var_0_0.getSkillTagInfoColorType(arg_10_0, arg_10_1)
	return arg_10_0._skillTagInfos[arg_10_1].color
end

function var_0_0.getSkillTagInfoDesc(arg_11_0, arg_11_1)
	return arg_11_0._skillTagInfos[arg_11_1].desc
end

function var_0_0.getEffectTagIDsFromDescNotRecursion(arg_12_0, arg_12_1)
	arg_12_0:_initSkillTagInfos()

	local var_12_0 = {}

	arg_12_1 = not arg_12_1 and "" or arg_12_1
	arg_12_1 = string.gsub(arg_12_1, "【", "[")
	arg_12_1 = string.gsub(arg_12_1, "】", "]")

	for iter_12_0 in string.gmatch(arg_12_1, "%[(.-)%]") do
		if string.nilorempty(iter_12_0) or arg_12_0._skillTagInfos[iter_12_0] == nil then
			logError(string.format("技能描述中 '%s' tag 不存在", iter_12_0))
		else
			table.insert(var_12_0, arg_12_0._skillTagInfos[iter_12_0].id)
		end
	end

	return var_12_0
end

function var_0_0.getEffectTagIDsFromDescRecursion(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getEffectTagIDsFromDescNotRecursion(arg_13_1)

	return arg_13_0:treeLevelTraversal(var_13_0, {}, {})
end

function var_0_0.getEffectTagDescFromDescRecursion(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_0.instance:getEffectTagIDsFromDescRecursion(arg_14_1)
	local var_14_1 = ""
	local var_14_2 = {}

	for iter_14_0 = 1, #var_14_0 do
		local var_14_3 = SkillConfig.instance:getSkillEffectDescCo(var_14_0[iter_14_0])

		if var_14_3 then
			local var_14_4 = var_14_3.name

			if var_0_0.instance:canShowSkillTag(var_14_4) and not var_14_2[var_14_4] then
				var_14_2[var_14_4] = true

				if LangSettings.instance:isZh() or LangSettings.instance:isTw() then
					var_14_1 = var_14_1 .. string.format("<color=%s>[%s]</color>：%s\n", arg_14_2, var_14_4, var_14_3.desc)
				else
					var_14_1 = var_14_1 .. string.format("<color=%s>[%s]</color>: %s\n", arg_14_2, var_14_4, var_14_3.desc)
				end
			end
		end
	end

	return var_14_1
end

function var_0_0.getEffectTagDescIdList(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.instance:getEffectTagIDsFromDescRecursion(arg_15_1)
	local var_15_1 = {}
	local var_15_2 = {}

	for iter_15_0 = 1, #var_15_0 do
		local var_15_3 = SkillConfig.instance:getSkillEffectDescCo(var_15_0[iter_15_0])

		if var_15_3 then
			local var_15_4 = var_15_3.name

			if var_0_0.instance:canShowSkillTag(var_15_4) and not var_15_2[var_15_4] then
				var_15_2[var_15_4] = true

				table.insert(var_15_1, var_15_3.id)
			end
		end
	end

	return var_15_1
end

function var_0_0.canShowSkillTag(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_16_1)

	return SkillHelper.canShowTag(var_16_0)
end

function var_0_0.getSkillEffectTagIdsFormDescTabRecursion(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		local var_17_3 = arg_17_0:getEffectTagIDsFromDescNotRecursion(iter_17_1)

		var_17_2[iter_17_0] = arg_17_0:treeLevelTraversal(var_17_3, {}, var_17_0)
	end

	return var_17_2
end

function var_0_0.treeLevelTraversal(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if #arg_18_1 == 0 then
		return arg_18_2
	end

	for iter_18_0 = 1, #arg_18_1 do
		local var_18_0 = table.remove(arg_18_1, 1)

		if not arg_18_3[var_18_0] then
			arg_18_3[var_18_0] = true

			table.insert(arg_18_2, var_18_0)

			local var_18_1 = arg_18_0:getEffectTagIDsFromDescNotRecursion(SkillConfig.instance:getSkillEffectDescCo(var_18_0).desc)

			for iter_18_1, iter_18_2 in ipairs(var_18_1) do
				if not arg_18_3[iter_18_2] then
					table.insert(arg_18_1, iter_18_2)
				end
			end
		end
	end

	return arg_18_0:treeLevelTraversal(arg_18_1, arg_18_2, arg_18_3)
end

function var_0_0.skillDesToSpot(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if string.nilorempty(arg_19_2) then
		arg_19_2 = "#C66030"
	end

	if string.nilorempty(arg_19_3) then
		arg_19_3 = "#4e6698"
	end

	local var_19_0 = string.gsub(arg_19_1, "(%-%d+%%)", "{%1}")
	local var_19_1 = string.gsub(var_19_0, "(%+%d+%%)", "{%1}")
	local var_19_2 = string.gsub(var_19_1, "(%-%d+%.*%d*%%)", "{%1}")
	local var_19_3 = string.gsub(var_19_2, "(%d+%.*%d*%%)", "{%1}")
	local var_19_4 = string.gsub(var_19_3, "%[", string.format("<color=%s>[", arg_19_3))
	local var_19_5 = string.gsub(var_19_4, "%【", string.format("<color=%s>[", arg_19_3))
	local var_19_6 = string.gsub(var_19_5, "%]", "]</color>")
	local var_19_7 = string.gsub(var_19_6, "%】", "]</color>")
	local var_19_8 = string.gsub(var_19_7, "%{", string.format("<color=%s>", arg_19_2))
	local var_19_9 = string.gsub(var_19_8, "%}", "</color>")
	local var_19_10 = arg_19_0:spotSkillAttribute(var_19_9, arg_19_4)

	return (SkillConfig.instance:processSkillDesKeyWords(var_19_10))
end

function var_0_0.spotSkillAttribute(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1
	local var_20_1 = HeroConfig.instance:getHeroAttributesCO()

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		if iter_20_1.showcolor == 1 and not arg_20_2 then
			var_20_0 = string.gsub(var_20_0, iter_20_1.name, string.format("<u>%s</u>", iter_20_1.name))
		end
	end

	return var_20_0
end

function var_0_0.formatDescWithColor_local(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_2 = arg_21_2 or "#d7a270"
	arg_21_3 = arg_21_3 or "#5f7197"

	local var_21_0 = arg_21_1

	if arg_21_4 ~= true then
		local var_21_1 = {}
		local var_21_2 = 0

		var_21_0 = string.gsub(var_21_0, "(%[.-%])", function(arg_22_0)
			var_21_2 = var_21_2 + 1
			var_21_1[var_21_2] = arg_22_0

			return "▩replace▩"
		end)
		var_21_0 = string.gsub(var_21_0, "(【.-】)", function(arg_23_0)
			var_21_2 = var_21_2 + 1
			var_21_1[var_21_2] = arg_23_0

			return "▩replace▩"
		end)
		var_21_0 = string.gsub(var_21_0, "([%d%-%+%%%./]+)", string.format("<color=%s>%%1</color>", arg_21_2))

		local var_21_3 = 0

		var_21_0 = string.gsub(var_21_0, "▩replace▩", function()
			var_21_3 = var_21_3 + 1

			return var_21_1[var_21_3]
		end)
	end

	local var_21_4 = string.gsub(var_21_0, "(%[.-%])", string.format("<color=%s>%%1</color>", arg_21_3))

	return (string.gsub(var_21_4, "(【.-】)", string.format("<color=%s>%%1</color>", arg_21_3)))
end

function var_0_0.formatDescWithColor(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	return arg_25_0:formatDescWithColor_overseas(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
end

var_0_0.instance = var_0_0.New()

return var_0_0
