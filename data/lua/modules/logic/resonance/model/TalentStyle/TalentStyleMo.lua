module("modules.logic.resonance.model.TalentStyle.TalentStyleMo", package.seeall)

local var_0_0 = class("TalentStyleMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0._styleCo = nil
	arg_1_0._orginId = nil
	arg_1_0._replaceId = nil
	arg_1_0._styleId = nil
	arg_1_0._isUse = false
	arg_1_0._isSelect = false
	arg_1_0._isNew = false
	arg_1_0._isUnlock = false
	arg_1_0._unlockPercent = 0
	arg_1_0._hotUnlockStyle = nil
end

function var_0_0.setMo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._styleCo = arg_2_1
	arg_2_0._orginId = arg_2_2
	arg_2_0._replaceId = arg_2_3
	arg_2_0._styleId = arg_2_1.styleId
end

function var_0_0.isCanUnlock(arg_3_0, arg_3_1)
	return arg_3_1 >= (arg_3_0._styleCo and arg_3_0._styleCo.level and arg_3_0._styleCo.level or 0)
end

function var_0_0.onRefresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._isUse = arg_4_1 == arg_4_0._styleId
	arg_4_0._isSelect = arg_4_2 == arg_4_0._styleId
	arg_4_0._isUnlock = arg_4_3
end

function var_0_0.setShowInfo(arg_5_0)
	return
end

function var_0_0.getStyleTag(arg_6_0)
	local var_6_0 = LangSettings.instance:getCurLang()

	if arg_6_0._lastLangId ~= var_6_0 then
		arg_6_0._tagStr = nil
		arg_6_0._name = nil
		arg_6_0._lastLangId = var_6_0
	end

	if not arg_6_0._name then
		arg_6_0._name = arg_6_0._styleCo.name
	end

	if string.nilorempty(arg_6_0._tagStr) then
		local var_6_1 = arg_6_0._styleCo.tag

		arg_6_0._tagStr = ""

		if not string.nilorempty(var_6_1) then
			local var_6_2 = string.splitToNumber(var_6_1, "#")

			for iter_6_0, iter_6_1 in ipairs(var_6_2) do
				local var_6_3 = lua_character_attribute.configDict[iter_6_1]
				local var_6_4 = var_6_3 and var_6_3.name or luaLang("talent_style_special_tag_" .. iter_6_1)

				if string.nilorempty(arg_6_0._tagStr) then
					arg_6_0._tagStr = var_6_4
				else
					arg_6_0._tagStr = string.format("%s    %s", arg_6_0._tagStr, var_6_4)
				end
			end
		end
	end

	return arg_6_0._name, arg_6_0._tagStr
end

function var_0_0.getStyleTagIcon(arg_7_0)
	if not arg_7_0._growTagIcon or not arg_7_0._nomalTagIcon then
		local var_7_0 = arg_7_0._styleCo.tagicon

		if var_7_0 then
			local var_7_1 = tonumber(var_7_0)

			if var_7_1 and var_7_1 < 10 then
				var_7_0 = "0" .. var_7_1
			end

			arg_7_0._growTagIcon = "fg_" .. var_7_0
			arg_7_0._nomalTagIcon = "fz_" .. var_7_0
		end
	end

	return arg_7_0._growTagIcon, arg_7_0._nomalTagIcon
end

function var_0_0.setNew(arg_8_0, arg_8_1)
	arg_8_0._isNew = arg_8_1 and arg_8_0._styleId ~= 0
end

function var_0_0.setUnlockPercent(arg_9_0, arg_9_1)
	arg_9_0._unlockPercent = arg_9_1
end

function var_0_0.getUnlockPercent(arg_10_0)
	return arg_10_0._unlockPercent or 0
end

function var_0_0.setHotUnlockStyle(arg_11_0, arg_11_1)
	arg_11_0._hotUnlockStyle = arg_11_1
end

function var_0_0.isHotUnlock(arg_12_0)
	return arg_12_0._hotUnlockStyle
end

return var_0_0
