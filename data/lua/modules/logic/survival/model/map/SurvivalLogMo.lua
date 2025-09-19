module("modules.logic.survival.model.map.SurvivalLogMo", package.seeall)

local var_0_0 = pureTable("SurvivalLogMo")
local var_0_1 = {
	TeamHealth = 4,
	HeroHealth = 5,
	Item = 1,
	TaskChange = 3,
	GetTalent = 6,
	Currency = 2
}

function var_0_0.ctor(arg_1_0)
	arg_1_0.isNpcRecr = false
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.logStr = ""

	local var_2_0 = string.splitToNumber(arg_2_1, "#") or {}

	if var_2_0[1] == var_0_1.Item then
		local var_2_1 = var_2_0[3] or 0
		local var_2_2 = var_2_0[4] or SurvivalEnum.ItemSource.Map
		local var_2_3 = lua_survival_item.configDict[var_2_0[2]]

		if var_2_3 then
			local var_2_4 = var_2_3.type

			if var_2_4 == SurvivalEnum.ItemType.NPC then
				if var_2_1 > 0 then
					arg_2_0.isNpcRecr = var_2_0[2]
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_addnpc"), var_2_3.name)
				else
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_removenpc"), var_2_3.name)
				end
			elseif var_2_4 == SurvivalEnum.ItemType.Currency then
				if var_2_3.id == SurvivalEnum.CurrencyType.Enthusiastic then
					if var_2_1 > 0 then
						arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_addheart"), var_2_1)
					else
						arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_removeheart"), -var_2_1)
					end
				elseif var_2_1 > 0 then
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_addcurrency"), var_2_3.name, var_2_1)
				elseif var_2_2 == SurvivalEnum.ItemSource.Map then
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removecurrency"), var_2_3.name, -var_2_1)
				else
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removecurrency_shelter"), var_2_3.name, -var_2_1)
				end
			else
				local var_2_5 = var_2_3.name

				arg_2_2 = arg_2_2 or SurvivalEnum.ItemRareColor

				if arg_2_2[var_2_3.rare] then
					var_2_5 = string.format("<color=%s>%s</color>", arg_2_2[var_2_3.rare], var_2_5)
				end

				if var_2_1 > 0 then
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_additem"), var_2_5, var_2_1)
				else
					arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removeitem"), var_2_5, -var_2_1)
				end
			end
		end
	elseif var_2_0[1] == var_0_1.TaskChange then
		local var_2_6 = var_2_0[2] or 0
		local var_2_7 = var_2_0[3] or 0
		local var_2_8 = var_2_0[4] or 1
		local var_2_9 = SurvivalConfig.instance:getTaskCo(var_2_6, var_2_7)

		if var_2_9 then
			if var_2_8 == 1 then
				arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_taskbegin"), var_2_9.desc)
			else
				arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_taskfail"), var_2_9.desc)
			end
		end
	elseif var_2_0[1] == var_0_1.TeamHealth then
		local var_2_10 = var_2_0[2] or 0

		if var_2_10 >= 0 then
			arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_teamhealthadd"), var_2_10)
		else
			SurvivalMapModel.instance.isHealthSub = true
			arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_teamhealthsub"), -var_2_10)
		end
	elseif var_2_0[1] == var_0_1.HeroHealth then
		local var_2_11 = lua_character.configDict[tonumber(var_2_0[2])]
		local var_2_12 = var_2_11 and var_2_11.name or ""
		local var_2_13 = var_2_0[3] or 0

		if var_2_13 >= 0 then
			arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_herohealthadd"), var_2_12, var_2_13)
		else
			SurvivalMapModel.instance.isHealthSub = true
			arg_2_0.logStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_heaohealthsub"), var_2_12, -var_2_13)
		end
	elseif var_2_0[1] == var_0_1.GetTalent then
		arg_2_0.logStr = luaLang("survival_log_gettalent")
	end
end

function var_0_0.getLogStr(arg_3_0)
	return arg_3_0.logStr
end

return var_0_0
