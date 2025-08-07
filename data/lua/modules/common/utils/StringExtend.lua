﻿module("modules.common.utils.StringExtend", package.seeall)

local var_0_0 = StringExtend

function var_0_0.activateExtend()
	return
end

if isDebugBuild then
	local var_0_1 = string.split

	function string.split(arg_2_0, arg_2_1)
		if GameUtil.needLogInFightSceneUseStringFunc() then
			logError("战斗场景中不要用`string.split`, 用`FightStrUtil.getSplitCache`代替")
		end

		return var_0_1(arg_2_0, arg_2_1)
	end

	local var_0_2 = string.splitToNumber

	function string.splitToNumber(arg_3_0, arg_3_1)
		if GameUtil.needLogInFightSceneUseStringFunc() then
			logError("战斗场景中不要用`string.splitToNumber`, 用`FightStrUtil.getSplitToNumberCache`代替")
		end

		return var_0_2(arg_3_0, arg_3_1)
	end
end

function string.replaceSpace(arg_4_0)
	if LangSettings.instance:isKr() or LangSettings.instance:isEn() then
		return arg_4_0
	end

	return string.gsub(arg_4_0, " ", " ")
end

function string.delBracketContent(arg_5_0)
	arg_5_0 = string.gsub(arg_5_0, "%b()", "")
	arg_5_0 = string.gsub(arg_5_0, "（.-）", "")

	return arg_5_0
end

return var_0_0
