module("modules.common.utils.GameUtil", package.seeall)

local var_0_0 = {
	getBriefName = function(arg_1_0, arg_1_1, arg_1_2)
		if LuaUtil.isEmptyStr(arg_1_0) then
			return ""
		end

		if arg_1_1 >= LuaUtil.getStrLen(arg_1_0) then
			return arg_1_0
		end

		local var_1_0 = LuaUtil.getUCharArr(arg_1_0)

		if var_1_0 == nil or #var_1_0 <= 0 then
			return LuaUtil.emptyStr
		end

		arg_1_2 = arg_1_2 or "..."

		local var_1_1 = LuaUtil.emptyStr
		local var_1_2 = 0

		for iter_1_0 = 1, #var_1_0 do
			local var_1_3 = string.byte(var_1_0[iter_1_0])

			if var_1_3 > 0 and var_1_3 <= 127 then
				var_1_2 = var_1_2 + 1
			elseif var_1_3 >= 192 and var_1_3 <= 239 then
				var_1_2 = var_1_2 + 2
			end

			if var_1_2 <= arg_1_1 then
				var_1_1 = var_1_1 .. var_1_0[iter_1_0]
			end
		end

		return var_1_1 .. arg_1_2
	end,
	getUCharArrWithoutRichTxt = function(arg_2_0)
		local var_2_0 = {}

		arg_2_0 = string.gsub(arg_2_0, "(<[^>]+>)", function(arg_3_0)
			table.insert(var_2_0, arg_3_0)

			return "▩"
		end)

		local var_2_1 = LuaUtil.getUCharArr(arg_2_0) or {}

		for iter_2_0 = #var_2_1, 1, -1 do
			if string.find(var_2_1[iter_2_0], "▩") then
				local var_2_2 = table.remove(var_2_0) or ""
				local var_2_3 = string.gsub(var_2_1[iter_2_0], "▩", var_2_2)

				if var_2_1[iter_2_0 + 1] then
					var_2_1[iter_2_0 + 1] = var_2_3 .. var_2_1[iter_2_0 + 1]

					table.remove(var_2_1, iter_2_0)
				else
					var_2_1[iter_2_0] = var_2_3
				end
			end
		end

		return var_2_1
	end
}

function var_0_0.removeJsonNull(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if iter_4_1 == cjson.null then
			arg_4_0[iter_4_0] = nil
		elseif type(iter_4_1) == "table" then
			var_0_0.removeJsonNull(iter_4_1)
		end
	end
end

function var_0_0.getBriefNameByWidth(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if LuaUtil.isEmptyStr(arg_5_0) then
		return ""
	end

	local var_5_0 = LuaUtil.getStrLen(arg_5_0)

	if var_5_0 <= 0 then
		return arg_5_0
	end

	local var_5_1 = arg_5_1.transform.sizeDelta.x - (arg_5_2 or 15)

	if var_5_1 > SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_5_1, arg_5_0) then
		return arg_5_0
	end

	arg_5_3 = arg_5_3 or "..."

	for iter_5_0 = var_5_0 - 1, 1, -1 do
		local var_5_2 = var_0_0.getBriefName(arg_5_0, iter_5_0, "")

		if var_5_1 > SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_5_1, var_5_2) then
			return var_5_2 .. arg_5_3
		end
	end

	return arg_5_0 .. arg_5_3
end

function var_0_0.trimInput(arg_6_0)
	arg_6_0 = string.gsub(arg_6_0, "　", "")

	return string.gsub(arg_6_0, "[ \t\n\r]+", "")
end

function var_0_0.trimInput1(arg_7_0)
	arg_7_0 = string.gsub(arg_7_0, "　", "")

	return string.gsub(arg_7_0, "[ \t\r]+", "")
end

function var_0_0.filterSpecChars(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = 1

	while true do
		if var_8_1 > #arg_8_0 then
			break
		end

		local var_8_2 = string.byte(arg_8_0, var_8_1)

		if not var_8_2 then
			break
		end

		if var_8_2 < 192 then
			if var_8_2 >= 48 and var_8_2 <= 57 or var_8_2 >= 65 and var_8_2 <= 90 or var_8_2 >= 97 and var_8_2 <= 122 then
				table.insert(var_8_0, string.char(var_8_2))
			end

			var_8_1 = var_8_1 + 1
		elseif var_8_2 < 224 then
			var_8_1 = var_8_1 + 2
		elseif var_8_2 < 240 then
			if var_8_2 >= 228 and var_8_2 <= 233 then
				local var_8_3 = string.byte(arg_8_0, var_8_1 + 1)
				local var_8_4 = string.byte(arg_8_0, var_8_1 + 2)

				if var_8_3 and var_8_4 then
					local var_8_5 = 128
					local var_8_6 = 191
					local var_8_7 = 128
					local var_8_8 = 191

					if var_8_2 == 228 then
						var_8_5 = 184
					elseif var_8_2 == 233 then
						var_8_6, var_8_8 = 190, var_8_3 ~= 190 and 191 or 165
					end

					if var_8_5 <= var_8_3 and var_8_3 <= var_8_6 and var_8_7 <= var_8_4 and var_8_4 <= var_8_8 then
						table.insert(var_8_0, string.char(var_8_2, var_8_3, var_8_4))
					end
				end
			end

			var_8_1 = var_8_1 + 3
		elseif var_8_2 < 248 then
			var_8_1 = var_8_1 + 4
		elseif var_8_2 < 252 then
			var_8_1 = var_8_1 + 5
		elseif var_8_2 < 254 then
			var_8_1 = var_8_1 + 6
		end
	end

	return table.concat(var_8_0)
end

function var_0_0.containsPunctuation(arg_9_0)
	if LuaUtil.isEmptyStr(arg_9_0) then
		return false
	end

	local var_9_0 = #arg_9_0
	local var_9_1 = 1

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = string.byte(arg_9_0, var_9_1)

		if var_9_2 then
			if var_9_2 >= 48 and var_9_2 <= 57 or var_9_2 >= 65 and var_9_2 <= 90 or var_9_2 >= 97 and var_9_2 <= 122 then
				var_9_1 = var_9_1 + 1
			elseif var_9_2 >= 228 and var_9_2 <= 233 then
				var_9_1 = var_9_1 + 3
			else
				return true
			end
		end
	end

	return false
end

function var_0_0.test()
	local var_10_0 = "233不顺利的！"

	logNormal("a length = " .. LuaUtil.getStrLen(var_10_0) .. " a ch = " .. LuaUtil.getChineseLen(var_10_0))
	logNormal("LuaUtil.getBriefName = " .. var_0_0.getBriefName(var_10_0, 6, ".prefab"))

	local var_10_1 = "地饭 大发      大\ndd哈哈\t哈哈\b"

	logNormal("trimInput = " .. var_0_0.trimInput(var_10_1))
	logNormal("trimInput1 = " .. var_0_0.trimInput1(var_10_1))

	local var_10_2 = "地饭大 发大\ndd哈哈\t哈哈\b"

	logNormal("trimInput1 = " .. var_0_0.trimInput1(var_10_2))
	logNormal("GameUtil.containsPunctuation = " .. tostring(var_0_0.containsPunctuation(var_10_2)))
end

function var_0_0.parseColor(arg_11_0)
	return SLFramework.UGUI.GuiHelper.ParseColor(arg_11_0)
end

function var_0_0.colorToHex(arg_12_0)
	return SLFramework.UGUI.GuiHelper.ColorToHex(arg_12_0)
end

function var_0_0.splitString2(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if var_0_0.needLogInFightSceneUseStringFunc() then
		logError("战斗中不要用`GameUtil.splitString2`, 用`FightStrUtil.getSplitString2Cache`代替")
	end

	if string.nilorempty(arg_13_0) then
		return
	end

	arg_13_2 = arg_13_2 or "|"
	arg_13_3 = arg_13_3 or "#"

	local var_13_0 = string.split(arg_13_0, arg_13_2)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if arg_13_1 then
			var_13_0[iter_13_0] = string.splitToNumber(iter_13_1, arg_13_3)
		else
			var_13_0[iter_13_0] = string.split(iter_13_1, arg_13_3)
		end
	end

	return var_13_0
end

var_0_0.RichTextTags = {
	"<b>",
	"</b>",
	"<i>",
	"</i>",
	"<size=.->",
	"</size>",
	"<color=.->",
	"</color>",
	"<material=.->",
	"</material>",
	"<quad.->",
	"</quad>",
	"<align=.->"
}

function var_0_0.filterRichText(arg_14_0)
	local var_14_0 = arg_14_0

	for iter_14_0, iter_14_1 in ipairs(var_0_0.RichTextTags) do
		var_14_0 = string.gsub(var_14_0, iter_14_1, "")
	end

	return var_14_0
end

function var_0_0.numberDisplay(arg_15_0)
	local var_15_0 = tonumber(arg_15_0)

	if var_15_0 <= 99999 then
		return var_15_0
	elseif var_15_0 <= 99999999 and var_15_0 > 99999 then
		return math.floor(var_15_0 / 1000) .. "K"
	else
		return math.floor(var_15_0 / 1000000) .. "M"
	end
end

local var_0_1 = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X",
	"XI",
	"XII",
	"XIII",
	"XIV",
	"XV",
	"XVI",
	"XVII",
	"XVIII",
	"XIX",
	"XX"
}

function var_0_0.getRomanNums(arg_16_0)
	return var_0_1[arg_16_0]
end

local var_0_2 = {
	[0] = "零",
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九"
}
local var_0_3 = {
	"十",
	"百",
	"千",
	"万",
	"十",
	"百",
	"千",
	"亿",
	"十",
	"百",
	"千",
	"兆"
}

function var_0_0.getNum2Chinese(arg_17_0)
	if not LangSettings.instance:isZh() then
		return arg_17_0
	end

	if arg_17_0 < 10 then
		return var_0_2[arg_17_0] or arg_17_0
	else
		local var_17_0 = var_0_2
		local var_17_1 = var_0_3
		local var_17_2 = tostring(arg_17_0)
		local var_17_3 = string.len(var_17_2)
		local var_17_4 = {}
		local var_17_5 = false

		for iter_17_0 = 1, var_17_3 do
			local var_17_6 = tonumber(string.sub(var_17_2, iter_17_0, iter_17_0))
			local var_17_7 = var_17_3 - iter_17_0 + 1

			if var_17_6 > 0 and var_17_5 == true then
				var_17_4[#var_17_4 + 1] = var_0_2[0]
				var_17_5 = false
			end

			if var_17_7 % 4 == 2 and var_17_6 == 1 then
				if var_17_7 < var_17_3 then
					var_17_4[#var_17_4 + 1] = var_17_0[var_17_6]
				end

				var_17_4[#var_17_4 + 1] = var_17_1[var_17_7 - 1] or ""
			elseif var_17_6 > 0 then
				var_17_4[#var_17_4 + 1] = var_17_0[var_17_6]
				var_17_4[#var_17_4 + 1] = var_17_1[var_17_7 - 1] or ""
			elseif var_17_6 == 0 then
				if var_17_7 % 4 == 1 then
					var_17_4[#var_17_4 + 1] = var_17_1[var_17_7 - 1] or ""
				else
					var_17_5 = true
				end
			end
		end

		return table.concat(var_17_4, "")
	end
end

var_0_0.englishOrderNumber = {}
var_0_0.englishOrderNumber[1] = "FIRST"
var_0_0.englishOrderNumber[2] = "SECOND"
var_0_0.englishOrderNumber[3] = "THIRD"
var_0_0.englishOrderNumber[4] = "FOURTH"
var_0_0.englishOrderNumber[5] = "FIFTH"
var_0_0.englishOrderNumber[6] = "SIXTH"
var_0_0.englishOrderNumber[7] = "SEVENTH"
var_0_0.englishOrderNumber[8] = "EIGHTH"
var_0_0.englishOrderNumber[9] = "NINTH"
var_0_0.englishOrderNumber[10] = "TENTH"

function var_0_0.getEnglishOrderNumber(arg_18_0)
	return var_0_0.englishOrderNumber[arg_18_0] or string.format("%dth", arg_18_0)
end

local var_0_4 = {
	"ONE",
	"TWO",
	"THREE",
	"FOUR",
	"FIVE",
	"SIX",
	"SEVEN",
	"EIGHT",
	"NINE",
	"TEN",
	"ELEVEN",
	"TWELVE",
	"THIRTEEN",
	"FOURTEEN",
	"FIFTEEN",
	"SIXTEEN",
	"SEVENTEEN",
	"EIGHTEEN",
	"NINETEEN",
	"TWENTY"
}

function var_0_0.getEnglishNumber(arg_19_0)
	return var_0_4[arg_19_0]
end

function var_0_0.charsize(arg_20_0)
	if not arg_20_0 then
		return 0
	elseif arg_20_0 >= 252 then
		return 6
	elseif arg_20_0 >= 248 and arg_20_0 < 252 then
		return 5
	elseif arg_20_0 >= 240 and arg_20_0 < 248 then
		return 4
	elseif arg_20_0 >= 224 and arg_20_0 < 240 then
		return 3
	elseif arg_20_0 >= 192 and arg_20_0 < 224 then
		return 2
	elseif arg_20_0 < 192 then
		return 1
	end
end

function var_0_0.utf8len(arg_21_0)
	if string.nilorempty(arg_21_0) then
		return 0
	end

	local var_21_0 = 0
	local var_21_1 = 0
	local var_21_2 = 0
	local var_21_3 = 1

	while var_21_3 <= #arg_21_0 do
		local var_21_4 = string.byte(arg_21_0, var_21_3)
		local var_21_5 = var_0_0.charsize(var_21_4)

		var_21_3 = var_21_3 + var_21_5
		var_21_0 = var_21_0 + 1

		if var_21_5 == 1 then
			var_21_1 = var_21_1 + 1
		elseif var_21_5 >= 2 then
			var_21_2 = var_21_2 + 1
		end
	end

	return var_21_0, var_21_1, var_21_2
end

function var_0_0.utf8sub(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = 1

	while arg_22_1 > 1 do
		local var_22_1 = string.byte(arg_22_0, var_22_0)

		var_22_0 = var_22_0 + var_0_0.charsize(var_22_1)
		arg_22_1 = arg_22_1 - 1
	end

	local var_22_2 = var_22_0

	while arg_22_2 > 0 and var_22_2 <= #arg_22_0 do
		local var_22_3 = string.byte(arg_22_0, var_22_2)

		var_22_2 = var_22_2 + var_0_0.charsize(var_22_3)
		arg_22_2 = arg_22_2 - 1
	end

	return string.sub(arg_22_0, var_22_0, var_22_2 - 1)
end

function var_0_0.utf8isnum(arg_23_0)
	if string.nilorempty(arg_23_0) then
		return false
	end

	for iter_23_0 = 1, string.len(arg_23_0) do
		local var_23_0 = string.byte(arg_23_0, iter_23_0)

		if not var_23_0 then
			return false
		end

		if var_23_0 < 48 or var_23_0 > 57 then
			return false
		end
	end

	return true
end

function var_0_0.getPreferredWidth(arg_24_0, arg_24_1)
	return SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_24_0, arg_24_1)
end

function var_0_0.getPreferredHeight(arg_25_0, arg_25_1)
	return SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_25_0, arg_25_1)
end

function var_0_0.getTextHeightByLine(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_26_0, " ")
	local var_26_1 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_26_0, arg_26_1)
	local var_26_2 = arg_26_3 or 0

	return var_26_0 > 0 and var_26_1 / var_26_0 * arg_26_2 + (var_26_1 / var_26_0 - 1) * var_26_2 or 0
end

function var_0_0.getTextWidthByLine(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_27_0, "啊")
	local var_27_1 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_27_0, arg_27_1)

	return var_27_0 > 0 and var_27_1 / var_27_0 * arg_27_2 or 0
end

function var_0_0.getSubPlaceholderLuaLang(arg_28_0, arg_28_1)
	if arg_28_1 and #arg_28_1 > 0 then
		arg_28_0 = string.gsub(arg_28_0, "▩([0-9]+)%%([sd])", function(arg_29_0, arg_29_1)
			arg_29_0 = tonumber(arg_29_0)

			if not arg_28_1[arg_29_0] then
				if isDebugBuild then
					local var_29_0 = {
						"[getSubPlaceholderLuaLang] =========== begin",
						"text: " .. arg_28_0,
						"index: " .. arg_29_0,
						"format: " .. arg_29_1,
						"fillParams[index]: 不存在",
						"[getSubPlaceholderLuaLang] =========== end"
					}

					logError(table.concat(var_29_0, "\n"))
				end

				return ""
			end

			if type(arg_28_1[arg_29_0]) == "number" and arg_29_1 == "d" then
				return string.format("%d", arg_28_1[arg_29_0])
			end

			if isDebugBuild and string.find(arg_28_1[arg_29_0], "%%", 1, true) then
				local var_29_1 = {
					[1] = "[getSubPlaceholderLuaLang] =========== begin",
					[6] = "[getSubPlaceholderLuaLang] =========== end",
					[2] = "text: " .. arg_28_0,
					[3] = "index: " .. arg_29_0,
					[4] = "format: " .. arg_29_1,
					[5] = "fillParams[index]:" .. arg_28_1[arg_29_0]
				}

				logError(table.concat(var_29_1, "\n"))
			end

			return arg_28_1[arg_29_0]
		end)
	end

	return arg_28_0
end

function var_0_0.getSubPlaceholderLuaLangOneParam(arg_30_0, arg_30_1)
	arg_30_0 = string.gsub(arg_30_0, "▩1%%s", arg_30_1)

	return arg_30_0
end

function var_0_0.getSubPlaceholderLuaLangTwoParam(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0 = string.gsub(arg_31_0, "▩1%%s", arg_31_1)
	arg_31_0 = string.gsub(arg_31_0, "▩2%%s", arg_31_2)

	return arg_31_0
end

function var_0_0.getSubPlaceholderLuaLangThreeParam(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0 = string.gsub(arg_32_0, "▩1%%s", arg_32_1)
	arg_32_0 = string.gsub(arg_32_0, "▩2%%s", arg_32_2)
	arg_32_0 = string.gsub(arg_32_0, "▩3%%s", arg_32_3)

	return arg_32_0
end

function var_0_0.getMarkIndexList(arg_33_0)
	local var_33_0 = "<em>"
	local var_33_1 = "</em>"

	arg_33_0 = string.gsub(arg_33_0, var_33_0, "▩1")
	arg_33_0 = string.gsub(arg_33_0, var_33_1, "▩2")
	arg_33_0 = string.gsub(arg_33_0, "<[^<>][^<>]->", "")
	arg_33_0 = string.gsub(arg_33_0, "▩1", var_33_0)
	arg_33_0 = string.gsub(arg_33_0, "▩2", var_33_1)

	local var_33_2 = {}

	if string.nilorempty(arg_33_0) or string.nilorempty(var_33_0) or string.nilorempty(var_33_1) then
		return var_33_2
	end

	local var_33_3 = {}
	local var_33_4 = string.split(arg_33_0, var_33_0)
	local var_33_5 = 1

	for iter_33_0, iter_33_1 in ipairs(var_33_4) do
		if iter_33_0 == #var_33_4 then
			break
		end

		var_33_5 = var_33_5 + var_0_0.utf8len(iter_33_1) + (iter_33_0 == 1 and 0 or 1) * var_0_0.utf8len(var_33_0)

		table.insert(var_33_3, var_33_5)
	end

	local var_33_6 = {}
	local var_33_7 = string.split(arg_33_0, var_33_1)
	local var_33_8 = 1

	for iter_33_2, iter_33_3 in ipairs(var_33_7) do
		if iter_33_2 == #var_33_7 then
			break
		end

		var_33_8 = var_33_8 + var_0_0.utf8len(iter_33_3) + (iter_33_2 == 1 and 0 or 1) * var_0_0.utf8len(var_33_1)

		table.insert(var_33_6, var_33_8)
	end

	local var_33_9 = false
	local var_33_10 = 0
	local var_33_11 = 0

	while var_33_10 <= var_0_0.utf8len(arg_33_0) do
		if LuaUtil.tableContains(var_33_3, var_33_10) then
			var_33_9 = true
			var_33_10 = var_33_10 + var_0_0.utf8len(var_33_0)
			var_33_11 = var_33_11 + var_0_0.utf8len(var_33_0)
		elseif LuaUtil.tableContains(var_33_6, var_33_10) then
			var_33_9 = false
			var_33_10 = var_33_10 + var_0_0.utf8len(var_33_1)
			var_33_11 = var_33_11 + var_0_0.utf8len(var_33_1)
		else
			if var_33_9 then
				table.insert(var_33_2, var_33_10 - var_33_11 - 1)
			end

			var_33_10 = var_33_10 + 1
		end
	end

	return var_33_2
end

function var_0_0.getMarkText(arg_34_0)
	if string.nilorempty(arg_34_0) then
		return ""
	end

	arg_34_0 = string.gsub(arg_34_0, "<em>", "")
	arg_34_0 = string.gsub(arg_34_0, "</em>", "")

	return arg_34_0
end

function var_0_0.getTimeFromString(arg_35_0)
	if string.nilorempty(arg_35_0) then
		return 9999999999
	end

	local var_35_0, var_35_1, var_35_2, var_35_3, var_35_4, var_35_5, var_35_6, var_35_7 = string.find(arg_35_0, "(%d-)%-(%d-)%-(%d-)%s-(%d-):(%d-):(%d+)")

	return os.time({
		year = tonumber(var_35_2),
		month = tonumber(var_35_3),
		day = tonumber(var_35_4),
		hour = tonumber(var_35_5),
		min = tonumber(var_35_6),
		sec = tonumber(var_35_7)
	})
end

function var_0_0.getTabLen(arg_36_0)
	local var_36_0 = 0

	if arg_36_0 then
		for iter_36_0, iter_36_1 in pairs(arg_36_0) do
			if arg_36_0[iter_36_0] ~= nil then
				var_36_0 = var_36_0 + 1
			end
		end
	end

	return var_36_0
end

function var_0_0.getAdapterScale()
	local var_37_0 = Time.time

	if var_0_0._adapterScale and var_0_0._scaleCalcTime and var_37_0 - var_0_0._scaleCalcTime < 0.01 then
		return var_0_0._adapterScale
	end

	var_0_0._scaleCalcTime = var_37_0

	local var_37_1 = UnityEngine.Screen.width
	local var_37_2 = UnityEngine.Screen.height

	if BootNativeUtil.isWindows() then
		var_37_1, var_37_2 = SettingsModel.instance:getCurrentScreenSize()
	end

	local var_37_3 = var_37_1 / var_37_2
	local var_37_4 = 1.7777777777777777

	if var_37_4 - var_37_3 > 0.01 then
		local var_37_5 = var_37_4 / var_37_3

		var_0_0._adapterScale = var_37_5
	else
		var_0_0._adapterScale = 1
	end

	return var_0_0._adapterScale
end

function var_0_0.fillZeroInLeft(arg_38_0, arg_38_1)
	local var_38_0 = tostring(arg_38_0)

	return string.rep("0", arg_38_1 - #var_38_0) .. var_38_0
end

function var_0_0.randomTable(arg_39_0)
	local var_39_0 = #arg_39_0

	for iter_39_0 = 1, var_39_0 do
		local var_39_1 = math.random(iter_39_0, var_39_0)

		arg_39_0[iter_39_0], arg_39_0[var_39_1] = arg_39_0[var_39_1], arg_39_0[iter_39_0]
	end

	return arg_39_0
end

function var_0_0.artTextNumReplace(arg_40_0)
	if string.nilorempty(arg_40_0) then
		return arg_40_0
	end

	local var_40_0 = arg_40_0
	local var_40_1 = string.len(var_40_0)
	local var_40_2 = {}

	while var_40_0 > 0 do
		local var_40_3 = var_40_0 % 10

		table.insert(var_40_2, 1, var_40_3)

		var_40_0 = math.floor(var_40_0 / 10)
	end

	local var_40_4 = ""

	for iter_40_0 = 1, var_40_1 do
		var_40_4 = var_40_4 .. string.format("<sprite=%s>", var_40_2[iter_40_0])
	end

	return var_40_4
end

function var_0_0.tabletool_fastRemoveValueByValue(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0) do
		if iter_41_1 == arg_41_1 then
			return var_0_0.tabletool_fastRemoveValueByPos(arg_41_0, iter_41_0)
		end
	end
end

function var_0_0.tabletool_fastRemoveValueByPos(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0[arg_42_1]

	arg_42_0[arg_42_1] = arg_42_0[#arg_42_0]

	table.remove(arg_42_0)

	return arg_42_0, var_42_0
end

function var_0_0.tabletool_dictIsEmpty(arg_43_0)
	if not arg_43_0 then
		return true
	end

	for iter_43_0, iter_43_1 in pairs(arg_43_0) do
		return false
	end

	return true
end

function var_0_0.checkPointInRectangle(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = arg_44_2 - arg_44_1
	local var_44_1 = arg_44_0 - arg_44_1
	local var_44_2 = arg_44_3 - arg_44_2
	local var_44_3 = arg_44_0 - arg_44_2
	local var_44_4 = Vector2.Dot(var_44_0, var_44_1)
	local var_44_5 = Vector2.Dot(var_44_2, var_44_3)

	return var_44_4 >= 0 and var_44_4 <= Vector2.Dot(var_44_0, var_44_0) and var_44_5 >= 0 and var_44_5 <= Vector2.Dot(var_44_2, var_44_2)
end

function var_0_0.noMoreThanOneDecimalPlace(arg_45_0)
	return math.fmod(arg_45_0, 1) > 0 and string.format("%.1f", arg_45_0) or string.format("%d", arg_45_0)
end

function var_0_0.isMobilePlayerAndNotEmulator()
	return BootNativeUtil.isMobilePlayer() and not SDKMgr.instance:isEmulator()
end

function var_0_0.openDeepLink(arg_47_0, arg_47_1)
	if string.nilorempty(arg_47_1) or string.nilorempty(arg_47_0) then
		return
	end

	if SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		UnityEngine.Application.OpenURL(arg_47_0)

		return true
	end

	local var_47_0 = {
		deepLink = arg_47_1,
		url = arg_47_0
	}
	local var_47_1 = cjson.encode(var_47_0)

	logNormal("openDeepLink:" .. tostring(var_47_1))
	ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", var_47_1)

	return true
end

function var_0_0.openURL(arg_48_0)
	if string.nilorempty(arg_48_0) then
		return
	end

	if not BootNativeUtil.isIOS() then
		UnityEngine.Application.OpenURL(arg_48_0)

		return true
	end

	local var_48_0 = {
		deepLink = deepLinkUrl,
		url = arg_48_0
	}
	local var_48_1 = cjson.encode(var_48_0)

	logNormal("openDeepLink:" .. tostring(var_48_1))
	ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", var_48_1)

	return true
end

function var_0_0.getMotionDuration(arg_49_0, arg_49_1)
	if arg_49_0 then
		local var_49_0 = arg_49_0.runtimeAnimatorController.animationClips

		for iter_49_0 = 0, var_49_0.Length - 1 do
			local var_49_1 = var_49_0[iter_49_0]

			if var_49_1.name == arg_49_1 then
				return var_49_1.length
			end
		end
	end

	return 0
end

function var_0_0.onDestroyViewMemberList(arg_50_0, arg_50_1)
	if arg_50_0[arg_50_1] then
		local var_50_0 = arg_50_0[arg_50_1]

		for iter_50_0, iter_50_1 in ipairs(var_50_0) do
			iter_50_1:onDestroyView()
		end

		arg_50_0[arg_50_1] = nil
	end
end

function var_0_0.onDestroyViewMember(arg_51_0, arg_51_1)
	if arg_51_0[arg_51_1] then
		arg_51_0[arg_51_1]:onDestroyView()

		arg_51_0[arg_51_1] = nil
	end
end

local var_0_5 = ZProj.TweenHelper

function var_0_0.onDestroyViewMember_TweenId(arg_52_0, arg_52_1)
	if arg_52_0[arg_52_1] then
		local var_52_0 = arg_52_0[arg_52_1]

		var_0_5.KillById(var_52_0)

		arg_52_0[arg_52_1] = nil
	end
end

function var_0_0.onDestroyViewMemberList_SImage(arg_53_0, arg_53_1)
	if arg_53_0[arg_53_1] then
		local var_53_0 = arg_53_0[arg_53_1]

		for iter_53_0, iter_53_1 in ipairs(var_53_0) do
			iter_53_1:UnLoadImage()
		end

		arg_53_0[arg_53_1] = nil
	end
end

function var_0_0.onDestroyViewMember_SImage(arg_54_0, arg_54_1)
	if arg_54_0[arg_54_1] then
		arg_54_0[arg_54_1]:UnLoadImage()

		arg_54_0[arg_54_1] = nil
	end
end

function var_0_0.onDestroyViewMember_ClickListener(arg_55_0, arg_55_1)
	if arg_55_0[arg_55_1] then
		arg_55_0[arg_55_1]:RemoveClickListener()

		arg_55_0[arg_55_1] = nil
	end
end

function var_0_0.onDestroyViewMember_ClickDownListener(arg_56_0, arg_56_1)
	if arg_56_0[arg_56_1] then
		arg_56_0[arg_56_1]:RemoveClickDownListener()

		arg_56_0[arg_56_1] = nil
	end
end

function var_0_0.setActive01(arg_57_0, arg_57_1)
	if arg_57_1 then
		transformhelper.setLocalScale(arg_57_0, 1, 1, 1)
	else
		transformhelper.setLocalScale(arg_57_0, 0, 0, 0)
	end
end

function var_0_0.clamp(arg_58_0, arg_58_1, arg_58_2)
	return math.min(arg_58_2, math.max(arg_58_0, arg_58_1))
end

function var_0_0.saturate(arg_59_0)
	return var_0_0.clamp(arg_59_0, 0, 1)
end

function var_0_0.remap(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	arg_60_0 = var_0_0.clamp(arg_60_0, arg_60_1, arg_60_2)

	return arg_60_3 + (arg_60_0 - arg_60_1) * (arg_60_4 - arg_60_3) / (arg_60_2 - arg_60_1)
end

function var_0_0.remap01(arg_61_0, arg_61_1, arg_61_2)
	return var_0_0.remap(arg_61_0, arg_61_1, arg_61_2, 0, 1)
end

function var_0_0.setFirstStrSize(arg_62_0, arg_62_1)
	if string.nilorempty(arg_62_0) then
		return
	end

	local var_62_0 = var_0_0.utf8sub(arg_62_0, 1, 1)
	local var_62_1 = ""
	local var_62_2 = var_0_0.utf8len(arg_62_0)

	if var_62_2 >= 2 then
		var_62_1 = var_0_0.utf8sub(arg_62_0, 2, var_62_2 - 1)
	end

	return string.format("<size=%s>%s</size>%s", arg_62_1, var_62_0, var_62_1)
end

function var_0_0.playerPrefsGetNumberByUserId(arg_63_0, arg_63_1)
	local var_63_0 = PlayerModel.instance:getMyUserId()

	if not var_63_0 or var_63_0 == 0 then
		return arg_63_1
	end

	local var_63_1 = arg_63_0 .. "#" .. tostring(var_63_0)

	return PlayerPrefsHelper.getNumber(var_63_1, arg_63_1)
end

function var_0_0.playerPrefsSetNumberByUserId(arg_64_0, arg_64_1)
	local var_64_0 = PlayerModel.instance:getMyUserId()

	if not var_64_0 or var_64_0 == 0 then
		return
	end

	local var_64_1 = arg_64_0 .. "#" .. tostring(var_64_0)

	PlayerPrefsHelper.setNumber(var_64_1, arg_64_1)
end

function var_0_0.playerPrefsGetStringByUserId(arg_65_0, arg_65_1)
	local var_65_0 = PlayerModel.instance:getMyUserId()

	if not var_65_0 or var_65_0 == 0 then
		return arg_65_1
	end

	local var_65_1 = arg_65_0 .. "#" .. tostring(var_65_0)

	return PlayerPrefsHelper.getString(var_65_1, arg_65_1)
end

function var_0_0.playerPrefsSetStringByUserId(arg_66_0, arg_66_1)
	local var_66_0 = PlayerModel.instance:getMyUserId()

	if not var_66_0 or var_66_0 == 0 then
		return
	end

	local var_66_1 = arg_66_0 .. "#" .. tostring(var_66_0)

	PlayerPrefsHelper.setString(var_66_1, arg_66_1)
end

local var_0_6 = {
	__call = function(arg_67_0)
		local var_67_0 = arg_67_0.count

		arg_67_0.count = arg_67_0.count + 1

		return var_67_0
	end
}

function var_0_0.getUniqueTb(arg_68_0)
	local var_68_0 = {
		count = arg_68_0 or 1
	}

	setmetatable(var_68_0, var_0_6)

	return var_68_0
end

local var_0_7 = var_0_0.getUniqueTb()

function var_0_0.getEventId()
	return var_0_7()
end

function var_0_0.setDefaultValue(arg_70_0, arg_70_1)
	setmetatable(arg_70_0, {
		__index = function()
			return arg_70_1
		end
	})
end

function var_0_0.rpcInfosToList(arg_72_0, arg_72_1)
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in ipairs(arg_72_0) do
		local var_72_1 = arg_72_1.New()

		var_72_1:init(iter_72_1)
		table.insert(var_72_0, var_72_1)
	end

	return var_72_0
end

function var_0_0.rpcInfosToMap(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = {}

	arg_73_2 = arg_73_2 or "id"

	for iter_73_0, iter_73_1 in ipairs(arg_73_0) do
		local var_73_1 = arg_73_1.New()

		var_73_1:init(iter_73_1)

		var_73_0[var_73_1[arg_73_2]] = var_73_1
	end

	return var_73_0
end

function var_0_0.rpcInfosToListAndMap(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = {}

	arg_74_2 = arg_74_2 or "id"

	local var_74_1 = {}

	for iter_74_0, iter_74_1 in ipairs(arg_74_0) do
		local var_74_2 = arg_74_1.New()

		var_74_2:init(iter_74_1)
		table.insert(var_74_1, var_74_2)

		var_74_0[var_74_2[arg_74_2]] = var_74_2
	end

	return var_74_1, var_74_0
end

function var_0_0.setActiveUIBlock(arg_75_0, arg_75_1, arg_75_2)
	arg_75_2 = arg_75_2 ~= false and true or false

	UIBlockMgrExtend.setNeedCircleMv(arg_75_2)

	if arg_75_1 then
		UIBlockMgr.instance:startBlock(arg_75_0)
	else
		UIBlockMgr.instance:endBlock(arg_75_0)
	end
end

function var_0_0.loadSImage(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	if string.nilorempty(arg_76_1) then
		arg_76_0:UnLoadImage()
	else
		arg_76_0:LoadImage(arg_76_1, arg_76_2, arg_76_3)
	end
end

function var_0_0.logTab(arg_77_0, arg_77_1)
	if not arg_77_0 or type(arg_77_0) ~= "table" then
		return tostring(arg_77_0)
	end

	arg_77_1 = arg_77_1 or 0

	if arg_77_1 > 100 then
		logError("stack overflow ...")

		return tostring(arg_77_0)
	end

	local var_77_0 = {}
	local var_77_1 = string.rep("\t", arg_77_1)

	table.insert(var_77_0, string.format(" {"))

	local var_77_2 = string.rep("\t", arg_77_1 + 1)

	for iter_77_0, iter_77_1 in pairs(arg_77_0) do
		if type(iter_77_1) == "table" then
			table.insert(var_77_0, string.format("%s %s = %s,", var_77_2, iter_77_0, var_0_0.logTab(iter_77_1, arg_77_1 + 1)))
		else
			table.insert(var_77_0, string.format("%s %s = %s,", var_77_2, iter_77_0, iter_77_1))
		end
	end

	table.insert(var_77_0, string.format("%s }", var_77_1))

	return table.concat(var_77_0, "\n")
end

function var_0_0.getViewSize()
	local var_78_0 = ViewMgr.instance:getUILayer("HUD").transform

	return recthelper.getWidth(var_78_0), recthelper.getHeight(var_78_0)
end

function var_0_0.checkClickPositionInRight(arg_79_0)
	local var_79_0 = ViewMgr.instance:getUILayer("HUD"):GetComponent(gohelper.Type_RectTransform)
	local var_79_1, var_79_2 = recthelper.screenPosToAnchorPos2(arg_79_0, var_79_0)

	return var_79_1 >= 0
end

function var_0_0.needLogInFightSceneUseStringFunc()
	return false and GameSceneMgr.instance:isFightScene()
end

function var_0_0.needLogInOtherSceneUseFightStrUtilFunc()
	return false
end

var_0_0.enumId = 0

function var_0_0.getEnumId()
	var_0_0.enumId = var_0_0.enumId + 1

	return var_0_0.enumId
end

var_0_0.instanceId = 0

function var_0_0.getInstanceId()
	var_0_0.instanceId = var_0_0.instanceId + 1

	return var_0_0.instanceId
end

var_0_0.msgId = 0

function var_0_0.getMsgId()
	var_0_0.msgId = var_0_0.msgId + 1

	return var_0_0.msgId
end

function var_0_0.endsWith(arg_85_0, arg_85_1)
	if string.nilorempty(arg_85_0) or string.nilorempty(arg_85_1) then
		return false
	end

	return string.sub(arg_85_0, -string.len(arg_85_1)) == arg_85_1
end

function var_0_0.isBaseOf(arg_86_0, arg_86_1)
	if type(arg_86_0) ~= type(arg_86_1) then
		return false
	end

	if type(arg_86_0) ~= "table" or type(arg_86_1) ~= "table" then
		return false
	end

	local var_86_0 = arg_86_1

	while var_86_0 ~= nil do
		if var_86_0 == arg_86_0 then
			return true
		end

		var_86_0 = var_86_0.super
	end

	return false
end

function var_0_0.getRandomPosInCircle(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = arg_87_2 * arg_87_2
	local var_87_1 = math.random(1, 1000) / 1000
	local var_87_2 = math.sqrt(LuaTween.linear(var_87_1, 0, var_87_0, 1))
	local var_87_3 = math.random(1, 1000) / 1000
	local var_87_4 = LuaTween.linear(var_87_3, 0, 2 * math.pi, 1)
	local var_87_5 = var_87_2 * math.cos(var_87_4)
	local var_87_6 = var_87_2 * math.sin(var_87_4)

	return var_87_5 + arg_87_0, var_87_6 + arg_87_1
end

function var_0_0.doClearMember(arg_88_0, arg_88_1)
	if arg_88_0[arg_88_1] then
		arg_88_0[arg_88_1]:doClear()

		arg_88_0[arg_88_1] = nil
	end
end

local var_0_8 = require("protobuf.descriptor").FieldDescriptor

function var_0_0.copyPbData(arg_89_0, arg_89_1)
	if not arg_89_0 then
		return
	end

	local var_89_0 = arg_89_0._fields

	if next(var_89_0) then
		local var_89_1 = {}

		for iter_89_0, iter_89_1 in pairs(var_89_0) do
			local var_89_2 = iter_89_0.name

			if iter_89_0.label == var_0_8.LABEL_REPEATED then
				if #iter_89_1 ~= 0 then
					local var_89_3 = {}

					for iter_89_2, iter_89_3 in ipairs(iter_89_1) do
						if iter_89_0.cpp_type == var_0_8.CPPTYPE_MESSAGE and arg_89_1 then
							var_89_3[#var_89_3 + 1] = var_0_0.copyPbData(iter_89_3, arg_89_1)
						elseif iter_89_0.cpp_type == var_0_8.CPPTYPE_INT64 or iter_89_0.cpp_type == var_0_8.CPPTYPE_UINT64 then
							var_89_3[#var_89_3 + 1] = tonumber(iter_89_3)
						else
							var_89_3[#var_89_3 + 1] = iter_89_3
						end
					end

					var_89_1[var_89_2] = var_89_3
				end
			elseif iter_89_0.cpp_type == var_0_8.CPPTYPE_MESSAGE and arg_89_1 then
				var_89_1[var_89_2] = var_0_0.copyPbData(iter_89_1, true)
			elseif iter_89_0.cpp_type == var_0_8.CPPTYPE_INT64 or iter_89_0.cpp_type == var_0_8.CPPTYPE_UINT64 then
				var_89_1[var_89_2] = tonumber(iter_89_1)
			else
				var_89_1[var_89_2] = iter_89_1
			end
		end

		return var_89_1
	end
end

function var_0_0.convertToPercentStr(arg_90_0)
	arg_90_0 = arg_90_0 or 0

	return tostring(math.floor(arg_90_0 / 10)) .. "%"
end

function var_0_0.calcByDeltaRate1000(arg_91_0, arg_91_1)
	arg_91_0 = arg_91_0 or 0

	return arg_91_0 * (1000 + (arg_91_1 or 0)) / 1000
end

function var_0_0.calcByDeltaRate1000AsInt(arg_92_0, arg_92_1)
	return math.floor(var_0_0.calcByDeltaRate1000(arg_92_0, arg_92_1))
end

return var_0_0
