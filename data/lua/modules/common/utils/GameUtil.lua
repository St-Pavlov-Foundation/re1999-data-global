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
	end,
	getUCharArrWithLineFeedWithoutRichTxt = function(arg_4_0)
		local var_4_0 = {}

		arg_4_0 = string.gsub(arg_4_0, "(<[^>]+>)", function(arg_5_0)
			table.insert(var_4_0, arg_5_0)

			return "▩"
		end)

		local var_4_1 = LuaUtil.getUCharArrWithLineFeed(arg_4_0) or {}

		for iter_4_0 = #var_4_1, 1, -1 do
			if var_4_1[iter_4_0] == "▩" then
				local var_4_2 = table.remove(var_4_0) or ""

				if var_4_1[iter_4_0 + 1] then
					var_4_1[iter_4_0 + 1] = var_4_2 .. var_4_1[iter_4_0 + 1]

					table.remove(var_4_1, iter_4_0)
				else
					var_4_1[iter_4_0] = var_4_2
				end
			end
		end

		return var_4_1
	end
}

function var_0_0.removeJsonNull(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		if iter_6_1 == cjson.null then
			arg_6_0[iter_6_0] = nil
		elseif type(iter_6_1) == "table" then
			var_0_0.removeJsonNull(iter_6_1)
		end
	end
end

function var_0_0.getBriefNameByWidth(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if LuaUtil.isEmptyStr(arg_7_0) then
		return ""
	end

	local var_7_0 = LuaUtil.getStrLen(arg_7_0)

	if var_7_0 <= 0 then
		return arg_7_0
	end

	local var_7_1 = arg_7_1.transform.sizeDelta.x - (arg_7_2 or 15)

	if var_7_1 > SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_7_1, arg_7_0) then
		return arg_7_0
	end

	arg_7_3 = arg_7_3 or "..."

	for iter_7_0 = var_7_0 - 1, 1, -1 do
		local var_7_2 = var_0_0.getBriefName(arg_7_0, iter_7_0, "")

		if var_7_1 > SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_7_1, var_7_2) then
			return var_7_2 .. arg_7_3
		end
	end

	return arg_7_0 .. arg_7_3
end

function var_0_0.trimInput(arg_8_0)
	arg_8_0 = string.gsub(arg_8_0, "　", "")

	return string.gsub(arg_8_0, "[ \t\n\r]+", "")
end

function var_0_0.trimInput1(arg_9_0)
	arg_9_0 = string.gsub(arg_9_0, "　", "")

	return string.gsub(arg_9_0, "[ \t\r]+", "")
end

function var_0_0.filterSpecChars(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = 1

	while true do
		if var_10_1 > #arg_10_0 then
			break
		end

		local var_10_2 = string.byte(arg_10_0, var_10_1)

		if not var_10_2 then
			break
		end

		if var_10_2 < 192 then
			if var_10_2 >= 48 and var_10_2 <= 57 or var_10_2 >= 65 and var_10_2 <= 90 or var_10_2 >= 97 and var_10_2 <= 122 then
				table.insert(var_10_0, string.char(var_10_2))
			end

			var_10_1 = var_10_1 + 1
		elseif var_10_2 < 224 then
			var_10_1 = var_10_1 + 2
		elseif var_10_2 < 240 then
			if var_10_2 >= 228 and var_10_2 <= 233 then
				local var_10_3 = string.byte(arg_10_0, var_10_1 + 1)
				local var_10_4 = string.byte(arg_10_0, var_10_1 + 2)

				if var_10_3 and var_10_4 then
					local var_10_5 = 128
					local var_10_6 = 191
					local var_10_7 = 128
					local var_10_8 = 191

					if var_10_2 == 228 then
						var_10_5 = 184
					elseif var_10_2 == 233 then
						var_10_6, var_10_8 = 190, var_10_3 ~= 190 and 191 or 165
					end

					if var_10_5 <= var_10_3 and var_10_3 <= var_10_6 and var_10_7 <= var_10_4 and var_10_4 <= var_10_8 then
						table.insert(var_10_0, string.char(var_10_2, var_10_3, var_10_4))
					end
				end
			end

			var_10_1 = var_10_1 + 3
		elseif var_10_2 < 248 then
			var_10_1 = var_10_1 + 4
		elseif var_10_2 < 252 then
			var_10_1 = var_10_1 + 5
		elseif var_10_2 < 254 then
			var_10_1 = var_10_1 + 6
		end
	end

	return table.concat(var_10_0)
end

function var_0_0.containsPunctuation(arg_11_0)
	if LuaUtil.isEmptyStr(arg_11_0) then
		return false
	end

	local var_11_0 = #arg_11_0
	local var_11_1 = 1

	for iter_11_0 = 1, var_11_0 do
		local var_11_2 = string.byte(arg_11_0, var_11_1)

		if var_11_2 then
			if var_11_2 >= 48 and var_11_2 <= 57 or var_11_2 >= 65 and var_11_2 <= 90 or var_11_2 >= 97 and var_11_2 <= 122 then
				var_11_1 = var_11_1 + 1
			elseif var_11_2 >= 228 and var_11_2 <= 233 then
				var_11_1 = var_11_1 + 3
			else
				return true
			end
		end
	end

	return false
end

function var_0_0.test()
	local var_12_0 = "233不顺利的！"

	logNormal("a length = " .. LuaUtil.getStrLen(var_12_0) .. " a ch = " .. LuaUtil.getChineseLen(var_12_0))
	logNormal("LuaUtil.getBriefName = " .. var_0_0.getBriefName(var_12_0, 6, ".prefab"))

	local var_12_1 = "地饭 大发      大\ndd哈哈\t哈哈\b"

	logNormal("trimInput = " .. var_0_0.trimInput(var_12_1))
	logNormal("trimInput1 = " .. var_0_0.trimInput1(var_12_1))

	local var_12_2 = "地饭大 发大\ndd哈哈\t哈哈\b"

	logNormal("trimInput1 = " .. var_0_0.trimInput1(var_12_2))
	logNormal("GameUtil.containsPunctuation = " .. tostring(var_0_0.containsPunctuation(var_12_2)))
end

function var_0_0.parseColor(arg_13_0)
	return SLFramework.UGUI.GuiHelper.ParseColor(arg_13_0)
end

function var_0_0.colorToHex(arg_14_0)
	return SLFramework.UGUI.GuiHelper.ColorToHex(arg_14_0)
end

function var_0_0.splitString2(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if var_0_0.needLogInFightSceneUseStringFunc() then
		logError("战斗中不要用`GameUtil.splitString2`, 用`FightStrUtil.getSplitString2Cache`代替")
	end

	if string.nilorempty(arg_15_0) then
		return
	end

	arg_15_2 = arg_15_2 or "|"
	arg_15_3 = arg_15_3 or "#"

	local var_15_0 = string.split(arg_15_0, arg_15_2)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if arg_15_1 then
			var_15_0[iter_15_0] = string.splitToNumber(iter_15_1, arg_15_3)
		else
			var_15_0[iter_15_0] = string.split(iter_15_1, arg_15_3)
		end
	end

	return var_15_0
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

function var_0_0.filterRichText(arg_16_0)
	local var_16_0 = arg_16_0

	for iter_16_0, iter_16_1 in ipairs(var_0_0.RichTextTags) do
		var_16_0 = string.gsub(var_16_0, iter_16_1, "")
	end

	return var_16_0
end

function var_0_0.numberDisplay(arg_17_0)
	local var_17_0 = tonumber(arg_17_0)

	if var_17_0 <= 99999 then
		return var_17_0
	elseif var_17_0 <= 99999999 and var_17_0 > 99999 then
		return math.floor(var_17_0 / 1000) .. "K"
	else
		return math.floor(var_17_0 / 1000000) .. "M"
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

function var_0_0.getRomanNums(arg_18_0)
	return var_0_1[arg_18_0]
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

function var_0_0.getNum2Chinese(arg_19_0)
	if not LangSettings.instance:isZh() then
		return arg_19_0
	end

	if arg_19_0 < 10 then
		return var_0_2[arg_19_0] or arg_19_0
	else
		local var_19_0 = var_0_2
		local var_19_1 = var_0_3
		local var_19_2 = tostring(arg_19_0)
		local var_19_3 = string.len(var_19_2)
		local var_19_4 = {}
		local var_19_5 = false

		for iter_19_0 = 1, var_19_3 do
			local var_19_6 = tonumber(string.sub(var_19_2, iter_19_0, iter_19_0))
			local var_19_7 = var_19_3 - iter_19_0 + 1

			if var_19_6 > 0 and var_19_5 == true then
				var_19_4[#var_19_4 + 1] = var_0_2[0]
				var_19_5 = false
			end

			if var_19_7 % 4 == 2 and var_19_6 == 1 then
				if var_19_7 < var_19_3 then
					var_19_4[#var_19_4 + 1] = var_19_0[var_19_6]
				end

				var_19_4[#var_19_4 + 1] = var_19_1[var_19_7 - 1] or ""
			elseif var_19_6 > 0 then
				var_19_4[#var_19_4 + 1] = var_19_0[var_19_6]
				var_19_4[#var_19_4 + 1] = var_19_1[var_19_7 - 1] or ""
			elseif var_19_6 == 0 then
				if var_19_7 % 4 == 1 then
					var_19_4[#var_19_4 + 1] = var_19_1[var_19_7 - 1] or ""
				else
					var_19_5 = true
				end
			end
		end

		return table.concat(var_19_4, "")
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

function var_0_0.getEnglishOrderNumber(arg_20_0)
	return var_0_0.englishOrderNumber[arg_20_0] or string.format("%dth", arg_20_0)
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

function var_0_0.getEnglishNumber(arg_21_0)
	return var_0_4[arg_21_0]
end

function var_0_0.charsize(arg_22_0)
	if not arg_22_0 then
		return 0
	elseif arg_22_0 >= 252 then
		return 6
	elseif arg_22_0 >= 248 and arg_22_0 < 252 then
		return 5
	elseif arg_22_0 >= 240 and arg_22_0 < 248 then
		return 4
	elseif arg_22_0 >= 224 and arg_22_0 < 240 then
		return 3
	elseif arg_22_0 >= 192 and arg_22_0 < 224 then
		return 2
	elseif arg_22_0 < 192 then
		return 1
	end
end

function var_0_0.utf8len(arg_23_0)
	if string.nilorempty(arg_23_0) then
		return 0
	end

	local var_23_0 = 0
	local var_23_1 = 0
	local var_23_2 = 0
	local var_23_3 = 1

	while var_23_3 <= #arg_23_0 do
		local var_23_4 = string.byte(arg_23_0, var_23_3)
		local var_23_5 = var_0_0.charsize(var_23_4)

		var_23_3 = var_23_3 + var_23_5
		var_23_0 = var_23_0 + 1

		if var_23_5 == 1 then
			var_23_1 = var_23_1 + 1
		elseif var_23_5 >= 2 then
			var_23_2 = var_23_2 + 1
		end
	end

	return var_23_0, var_23_1, var_23_2
end

function var_0_0.utf8sub(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 1

	while arg_24_1 > 1 do
		local var_24_1 = string.byte(arg_24_0, var_24_0)

		var_24_0 = var_24_0 + var_0_0.charsize(var_24_1)
		arg_24_1 = arg_24_1 - 1
	end

	local var_24_2 = var_24_0

	while arg_24_2 > 0 and var_24_2 <= #arg_24_0 do
		local var_24_3 = string.byte(arg_24_0, var_24_2)

		var_24_2 = var_24_2 + var_0_0.charsize(var_24_3)
		arg_24_2 = arg_24_2 - 1
	end

	return string.sub(arg_24_0, var_24_0, var_24_2 - 1)
end

function var_0_0.utf8isnum(arg_25_0)
	if string.nilorempty(arg_25_0) then
		return false
	end

	for iter_25_0 = 1, string.len(arg_25_0) do
		local var_25_0 = string.byte(arg_25_0, iter_25_0)

		if not var_25_0 then
			return false
		end

		if var_25_0 < 48 or var_25_0 > 57 then
			return false
		end
	end

	return true
end

function var_0_0.getPreferredWidth(arg_26_0, arg_26_1)
	return SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_26_0, arg_26_1)
end

function var_0_0.getPreferredHeight(arg_27_0, arg_27_1)
	return SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_27_0, arg_27_1)
end

function var_0_0.getTextHeightByLine(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_28_0, " ")
	local var_28_1 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_28_0, arg_28_1)
	local var_28_2 = arg_28_3 or 0

	return var_28_0 > 0 and var_28_1 / var_28_0 * arg_28_2 + (var_28_1 / var_28_0 - 1) * var_28_2 or 0
end

function var_0_0.getTextWidthByLine(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_29_0, "啊")
	local var_29_1 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_29_0, arg_29_1)

	return var_29_0 > 0 and var_29_1 / var_29_0 * arg_29_2 or 0
end

function var_0_0.getSubPlaceholderLuaLang(arg_30_0, arg_30_1)
	if arg_30_1 and #arg_30_1 > 0 then
		arg_30_0 = string.gsub(arg_30_0, "▩([0-9]+)%%([sd])", function(arg_31_0, arg_31_1)
			arg_31_0 = tonumber(arg_31_0)

			if not arg_30_1[arg_31_0] then
				if isDebugBuild then
					local var_31_0 = {
						"[getSubPlaceholderLuaLang] =========== begin",
						"text: " .. arg_30_0,
						"index: " .. arg_31_0,
						"format: " .. arg_31_1,
						"fillParams[index]: 不存在",
						"[getSubPlaceholderLuaLang] =========== end"
					}

					logError(table.concat(var_31_0, "\n"))
				end

				return ""
			end

			if type(arg_30_1[arg_31_0]) == "number" and arg_31_1 == "d" then
				return string.format("%d", arg_30_1[arg_31_0])
			end

			if isDebugBuild and string.find(arg_30_1[arg_31_0], "%%", 1, true) then
				local var_31_1 = {
					[1] = "[getSubPlaceholderLuaLang] =========== begin",
					[6] = "[getSubPlaceholderLuaLang] =========== end",
					[2] = "text: " .. arg_30_0,
					[3] = "index: " .. arg_31_0,
					[4] = "format: " .. arg_31_1,
					[5] = "fillParams[index]:" .. arg_30_1[arg_31_0]
				}

				logError(table.concat(var_31_1, "\n"))
			end

			return arg_30_1[arg_31_0]
		end)
	end

	return arg_30_0
end

function var_0_0.getSubPlaceholderLuaLangOneParam(arg_32_0, arg_32_1)
	arg_32_0 = string.gsub(arg_32_0, "▩1%%s", arg_32_1)

	return arg_32_0
end

function var_0_0.getSubPlaceholderLuaLangTwoParam(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0 = string.gsub(arg_33_0, "▩1%%s", arg_33_1)
	arg_33_0 = string.gsub(arg_33_0, "▩2%%s", arg_33_2)

	return arg_33_0
end

function var_0_0.getSubPlaceholderLuaLangThreeParam(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0 = string.gsub(arg_34_0, "▩1%%s", arg_34_1)
	arg_34_0 = string.gsub(arg_34_0, "▩2%%s", arg_34_2)
	arg_34_0 = string.gsub(arg_34_0, "▩3%%s", arg_34_3)

	return arg_34_0
end

function var_0_0.getMarkIndexList(arg_35_0)
	local var_35_0 = "<em>"
	local var_35_1 = "</em>"

	arg_35_0 = string.gsub(arg_35_0, var_35_0, "▩1")
	arg_35_0 = string.gsub(arg_35_0, var_35_1, "▩2")
	arg_35_0 = string.gsub(arg_35_0, "<[^<>][^<>]->", "")
	arg_35_0 = string.gsub(arg_35_0, "▩1", var_35_0)
	arg_35_0 = string.gsub(arg_35_0, "▩2", var_35_1)

	local var_35_2 = {}

	if string.nilorempty(arg_35_0) or string.nilorempty(var_35_0) or string.nilorempty(var_35_1) then
		return var_35_2
	end

	local var_35_3 = {}
	local var_35_4 = string.split(arg_35_0, var_35_0)
	local var_35_5 = 1

	for iter_35_0, iter_35_1 in ipairs(var_35_4) do
		if iter_35_0 == #var_35_4 then
			break
		end

		var_35_5 = var_35_5 + var_0_0.utf8len(iter_35_1) + (iter_35_0 == 1 and 0 or 1) * var_0_0.utf8len(var_35_0)

		table.insert(var_35_3, var_35_5)
	end

	local var_35_6 = {}
	local var_35_7 = string.split(arg_35_0, var_35_1)
	local var_35_8 = 1

	for iter_35_2, iter_35_3 in ipairs(var_35_7) do
		if iter_35_2 == #var_35_7 then
			break
		end

		var_35_8 = var_35_8 + var_0_0.utf8len(iter_35_3) + (iter_35_2 == 1 and 0 or 1) * var_0_0.utf8len(var_35_1)

		table.insert(var_35_6, var_35_8)
	end

	local var_35_9 = false
	local var_35_10 = 0
	local var_35_11 = 0

	while var_35_10 <= var_0_0.utf8len(arg_35_0) do
		if LuaUtil.tableContains(var_35_3, var_35_10) then
			var_35_9 = true
			var_35_10 = var_35_10 + var_0_0.utf8len(var_35_0)
			var_35_11 = var_35_11 + var_0_0.utf8len(var_35_0)
		elseif LuaUtil.tableContains(var_35_6, var_35_10) then
			var_35_9 = false
			var_35_10 = var_35_10 + var_0_0.utf8len(var_35_1)
			var_35_11 = var_35_11 + var_0_0.utf8len(var_35_1)
		else
			if var_35_9 then
				table.insert(var_35_2, var_35_10 - var_35_11 - 1)
			end

			var_35_10 = var_35_10 + 1
		end
	end

	return var_35_2
end

function var_0_0.getMarkText(arg_36_0)
	if string.nilorempty(arg_36_0) then
		return ""
	end

	arg_36_0 = string.gsub(arg_36_0, "<em>", "")
	arg_36_0 = string.gsub(arg_36_0, "</em>", "")

	return arg_36_0
end

function var_0_0.getTimeFromString(arg_37_0)
	if string.nilorempty(arg_37_0) then
		return 9999999999
	end

	local var_37_0, var_37_1, var_37_2, var_37_3, var_37_4, var_37_5, var_37_6, var_37_7 = string.find(arg_37_0, "(%d-)%-(%d-)%-(%d-)%s-(%d-):(%d-):(%d+)")

	return os.time({
		year = tonumber(var_37_2),
		month = tonumber(var_37_3),
		day = tonumber(var_37_4),
		hour = tonumber(var_37_5),
		min = tonumber(var_37_6),
		sec = tonumber(var_37_7)
	})
end

function var_0_0.getTabLen(arg_38_0)
	local var_38_0 = 0

	if arg_38_0 then
		for iter_38_0, iter_38_1 in pairs(arg_38_0) do
			if arg_38_0[iter_38_0] ~= nil then
				var_38_0 = var_38_0 + 1
			end
		end
	end

	return var_38_0
end

function var_0_0.getAdapterScale()
	local var_39_0 = Time.time

	if var_0_0._adapterScale and var_0_0._scaleCalcTime and var_39_0 - var_0_0._scaleCalcTime < 0.01 then
		return var_0_0._adapterScale
	end

	var_0_0._scaleCalcTime = var_39_0

	local var_39_1 = UnityEngine.Screen.width
	local var_39_2 = UnityEngine.Screen.height

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		var_39_1, var_39_2 = SettingsModel.instance:getCurrentScreenSize()
	end

	local var_39_3 = var_39_1 / var_39_2
	local var_39_4 = 1.7777777777777777

	if var_39_4 - var_39_3 > 0.01 then
		local var_39_5 = var_39_4 / var_39_3

		var_0_0._adapterScale = var_39_5
	else
		var_0_0._adapterScale = 1
	end

	return var_0_0._adapterScale
end

function var_0_0.fillZeroInLeft(arg_40_0, arg_40_1)
	local var_40_0 = tostring(arg_40_0)

	return string.rep("0", arg_40_1 - #var_40_0) .. var_40_0
end

function var_0_0.randomTable(arg_41_0)
	local var_41_0 = #arg_41_0

	for iter_41_0 = 1, var_41_0 do
		local var_41_1 = math.random(iter_41_0, var_41_0)

		arg_41_0[iter_41_0], arg_41_0[var_41_1] = arg_41_0[var_41_1], arg_41_0[iter_41_0]
	end

	return arg_41_0
end

function var_0_0.artTextNumReplace(arg_42_0)
	if string.nilorempty(arg_42_0) then
		return arg_42_0
	end

	local var_42_0 = arg_42_0
	local var_42_1 = string.len(var_42_0)
	local var_42_2 = {}

	while var_42_0 > 0 do
		local var_42_3 = var_42_0 % 10

		table.insert(var_42_2, 1, var_42_3)

		var_42_0 = math.floor(var_42_0 / 10)
	end

	local var_42_4 = ""

	for iter_42_0 = 1, var_42_1 do
		var_42_4 = var_42_4 .. string.format("<sprite=%s>", var_42_2[iter_42_0])
	end

	return var_42_4
end

function var_0_0.tabletool_fastRemoveValueByValue(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0) do
		if iter_43_1 == arg_43_1 then
			return var_0_0.tabletool_fastRemoveValueByPos(arg_43_0, iter_43_0)
		end
	end
end

function var_0_0.tabletool_fastRemoveValueByPos(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0[arg_44_1]

	arg_44_0[arg_44_1] = arg_44_0[#arg_44_0]

	table.remove(arg_44_0)

	return arg_44_0, var_44_0
end

function var_0_0.tabletool_dictIsEmpty(arg_45_0)
	if not arg_45_0 then
		return true
	end

	for iter_45_0, iter_45_1 in pairs(arg_45_0) do
		return false
	end

	return true
end

function var_0_0.checkPointInRectangle(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_2 - arg_46_1
	local var_46_1 = arg_46_0 - arg_46_1
	local var_46_2 = arg_46_3 - arg_46_2
	local var_46_3 = arg_46_0 - arg_46_2
	local var_46_4 = Vector2.Dot(var_46_0, var_46_1)
	local var_46_5 = Vector2.Dot(var_46_2, var_46_3)

	return var_46_4 >= 0 and var_46_4 <= Vector2.Dot(var_46_0, var_46_0) and var_46_5 >= 0 and var_46_5 <= Vector2.Dot(var_46_2, var_46_2)
end

function var_0_0.noMoreThanOneDecimalPlace(arg_47_0)
	return math.fmod(arg_47_0, 1) > 0 and string.format("%.1f", arg_47_0) or string.format("%d", arg_47_0)
end

function var_0_0.isMobilePlayerAndNotEmulator()
	return BootNativeUtil.isMobilePlayer() and not SDKMgr.instance:isEmulator()
end

function var_0_0.openDeepLink(arg_49_0, arg_49_1)
	if string.nilorempty(arg_49_1) or string.nilorempty(arg_49_0) then
		return
	end

	if SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		UnityEngine.Application.OpenURL(arg_49_0)

		return true
	end

	local var_49_0 = {
		deepLink = arg_49_1,
		url = arg_49_0
	}
	local var_49_1 = cjson.encode(var_49_0)

	logNormal("openDeepLink:" .. tostring(var_49_1))
	ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", var_49_1)

	return true
end

function var_0_0.openURL(arg_50_0)
	if string.nilorempty(arg_50_0) then
		return
	end

	if not BootNativeUtil.isIOS() then
		UnityEngine.Application.OpenURL(arg_50_0)

		return true
	end

	local var_50_0 = {
		deepLink = "",
		url = arg_50_0
	}
	local var_50_1 = cjson.encode(var_50_0)

	logNormal("openDeepLink:" .. tostring(var_50_1))
	ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", var_50_1)

	return true
end

function var_0_0.getMotionDuration(arg_51_0, arg_51_1)
	if arg_51_0 then
		local var_51_0 = arg_51_0.runtimeAnimatorController.animationClips

		for iter_51_0 = 0, var_51_0.Length - 1 do
			local var_51_1 = var_51_0[iter_51_0]

			if var_51_1.name == arg_51_1 then
				return var_51_1.length
			end
		end
	end

	return 0
end

function var_0_0.onDestroyViewMemberList(arg_52_0, arg_52_1)
	if arg_52_0[arg_52_1] then
		local var_52_0 = arg_52_0[arg_52_1]

		for iter_52_0, iter_52_1 in ipairs(var_52_0) do
			iter_52_1:onDestroyView()
		end

		arg_52_0[arg_52_1] = nil
	end
end

function var_0_0.onDestroyViewMember(arg_53_0, arg_53_1)
	if arg_53_0[arg_53_1] then
		arg_53_0[arg_53_1]:onDestroyView()

		arg_53_0[arg_53_1] = nil
	end
end

local var_0_5 = ZProj.TweenHelper

function var_0_0.onDestroyViewMember_TweenId(arg_54_0, arg_54_1)
	if arg_54_0[arg_54_1] then
		local var_54_0 = arg_54_0[arg_54_1]

		var_0_5.KillById(var_54_0)

		arg_54_0[arg_54_1] = nil
	end
end

function var_0_0.onDestroyViewMemberList_SImage(arg_55_0, arg_55_1)
	if arg_55_0[arg_55_1] then
		local var_55_0 = arg_55_0[arg_55_1]

		for iter_55_0, iter_55_1 in ipairs(var_55_0) do
			iter_55_1:UnLoadImage()
		end

		arg_55_0[arg_55_1] = nil
	end
end

function var_0_0.onDestroyViewMember_SImage(arg_56_0, arg_56_1)
	if arg_56_0[arg_56_1] then
		arg_56_0[arg_56_1]:UnLoadImage()

		arg_56_0[arg_56_1] = nil
	end
end

function var_0_0.onDestroyViewMember_ClickListener(arg_57_0, arg_57_1)
	if arg_57_0[arg_57_1] then
		arg_57_0[arg_57_1]:RemoveClickListener()

		arg_57_0[arg_57_1] = nil
	end
end

function var_0_0.onDestroyViewMember_ClickDownListener(arg_58_0, arg_58_1)
	if arg_58_0[arg_58_1] then
		arg_58_0[arg_58_1]:RemoveClickDownListener()

		arg_58_0[arg_58_1] = nil
	end
end

function var_0_0.setActive01(arg_59_0, arg_59_1)
	if arg_59_1 then
		transformhelper.setLocalScale(arg_59_0, 1, 1, 1)
	else
		transformhelper.setLocalScale(arg_59_0, 0, 0, 0)
	end
end

function var_0_0.clamp(arg_60_0, arg_60_1, arg_60_2)
	return math.min(arg_60_2, math.max(arg_60_0, arg_60_1))
end

function var_0_0.saturate(arg_61_0)
	return var_0_0.clamp(arg_61_0, 0, 1)
end

function var_0_0.remap(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4)
	arg_62_0 = var_0_0.clamp(arg_62_0, arg_62_1, arg_62_2)

	return arg_62_3 + (arg_62_0 - arg_62_1) * (arg_62_4 - arg_62_3) / (arg_62_2 - arg_62_1)
end

function var_0_0.remap01(arg_63_0, arg_63_1, arg_63_2)
	return var_0_0.remap(arg_63_0, arg_63_1, arg_63_2, 0, 1)
end

function var_0_0.setFirstStrSize(arg_64_0, arg_64_1)
	if string.nilorempty(arg_64_0) then
		return
	end

	local var_64_0 = var_0_0.utf8sub(arg_64_0, 1, 1)
	local var_64_1 = ""
	local var_64_2 = var_0_0.utf8len(arg_64_0)

	if var_64_2 >= 2 then
		var_64_1 = var_0_0.utf8sub(arg_64_0, 2, var_64_2 - 1)
	end

	return string.format("<size=%s>%s</size>%s", arg_64_1, var_64_0, var_64_1)
end

function var_0_0.playerPrefsGetNumberByUserId(arg_65_0, arg_65_1)
	local var_65_0 = PlayerModel.instance:getMyUserId()

	if not var_65_0 or var_65_0 == 0 then
		return arg_65_1
	end

	local var_65_1 = arg_65_0 .. "#" .. tostring(var_65_0)

	return PlayerPrefsHelper.getNumber(var_65_1, arg_65_1)
end

function var_0_0.playerPrefsSetNumberByUserId(arg_66_0, arg_66_1)
	local var_66_0 = PlayerModel.instance:getMyUserId()

	if not var_66_0 or var_66_0 == 0 then
		return
	end

	local var_66_1 = arg_66_0 .. "#" .. tostring(var_66_0)

	PlayerPrefsHelper.setNumber(var_66_1, arg_66_1)
end

function var_0_0.playerPrefsGetStringByUserId(arg_67_0, arg_67_1)
	local var_67_0 = PlayerModel.instance:getMyUserId()

	if not var_67_0 or var_67_0 == 0 then
		return arg_67_1
	end

	local var_67_1 = arg_67_0 .. "#" .. tostring(var_67_0)

	return PlayerPrefsHelper.getString(var_67_1, arg_67_1)
end

function var_0_0.playerPrefsSetStringByUserId(arg_68_0, arg_68_1)
	local var_68_0 = PlayerModel.instance:getMyUserId()

	if not var_68_0 or var_68_0 == 0 then
		return
	end

	local var_68_1 = arg_68_0 .. "#" .. tostring(var_68_0)

	PlayerPrefsHelper.setString(var_68_1, arg_68_1)
end

local var_0_6 = {
	__call = function(arg_69_0)
		local var_69_0 = arg_69_0.count

		arg_69_0.count = arg_69_0.count + 1

		return var_69_0
	end
}

function var_0_0.getUniqueTb(arg_70_0)
	local var_70_0 = {
		count = arg_70_0 or 1
	}

	setmetatable(var_70_0, var_0_6)

	return var_70_0
end

local var_0_7 = var_0_0.getUniqueTb()

function var_0_0.getEventId()
	return var_0_7()
end

function var_0_0.setDefaultValue(arg_72_0, arg_72_1)
	setmetatable(arg_72_0, {
		__index = function()
			return arg_72_1
		end
	})
end

function var_0_0.rpcInfosToList(arg_74_0, arg_74_1)
	local var_74_0 = {}

	for iter_74_0, iter_74_1 in ipairs(arg_74_0) do
		local var_74_1 = arg_74_1.New()

		var_74_1:init(iter_74_1)
		table.insert(var_74_0, var_74_1)
	end

	return var_74_0
end

function var_0_0.rpcInfosToMap(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = {}

	arg_75_2 = arg_75_2 or "id"

	for iter_75_0, iter_75_1 in ipairs(arg_75_0) do
		local var_75_1 = arg_75_1.New()

		var_75_1:init(iter_75_1)

		var_75_0[var_75_1[arg_75_2]] = var_75_1
	end

	return var_75_0
end

function var_0_0.rpcInfosToListAndMap(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = {}

	arg_76_2 = arg_76_2 or "id"

	local var_76_1 = {}

	for iter_76_0, iter_76_1 in ipairs(arg_76_0) do
		local var_76_2 = arg_76_1.New()

		var_76_2:init(iter_76_1)
		table.insert(var_76_1, var_76_2)

		var_76_0[var_76_2[arg_76_2]] = var_76_2
	end

	return var_76_1, var_76_0
end

function var_0_0.setActiveUIBlock(arg_77_0, arg_77_1, arg_77_2)
	arg_77_2 = arg_77_2 ~= false and true or false

	UIBlockMgrExtend.setNeedCircleMv(arg_77_2)

	if arg_77_1 then
		UIBlockMgr.instance:startBlock(arg_77_0)
	else
		UIBlockMgr.instance:endBlock(arg_77_0)
	end
end

function var_0_0.loadSImage(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	if string.nilorempty(arg_78_1) then
		arg_78_0:UnLoadImage()
	else
		arg_78_0:LoadImage(arg_78_1, arg_78_2, arg_78_3)
	end
end

function var_0_0.logTab(arg_79_0, arg_79_1)
	if not arg_79_0 or type(arg_79_0) ~= "table" then
		return tostring(arg_79_0)
	end

	arg_79_1 = arg_79_1 or 0

	if arg_79_1 > 100 then
		logError("stack overflow ...")

		return tostring(arg_79_0)
	end

	local var_79_0 = {}
	local var_79_1 = string.rep("\t", arg_79_1)

	table.insert(var_79_0, string.format(" {"))

	local var_79_2 = string.rep("\t", arg_79_1 + 1)

	for iter_79_0, iter_79_1 in pairs(arg_79_0) do
		if type(iter_79_1) == "table" then
			table.insert(var_79_0, string.format("%s %s = %s,", var_79_2, iter_79_0, var_0_0.logTab(iter_79_1, arg_79_1 + 1)))
		else
			table.insert(var_79_0, string.format("%s %s = %s,", var_79_2, iter_79_0, iter_79_1))
		end
	end

	table.insert(var_79_0, string.format("%s }", var_79_1))

	return table.concat(var_79_0, "\n")
end

function var_0_0.getViewSize()
	local var_80_0 = ViewMgr.instance:getUILayer("HUD").transform

	return recthelper.getWidth(var_80_0), recthelper.getHeight(var_80_0)
end

function var_0_0.checkClickPositionInRight(arg_81_0)
	local var_81_0 = ViewMgr.instance:getUILayer("HUD"):GetComponent(gohelper.Type_RectTransform)
	local var_81_1, var_81_2 = recthelper.screenPosToAnchorPos2(arg_81_0, var_81_0)

	return var_81_1 >= 0
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

function var_0_0.endsWith(arg_87_0, arg_87_1)
	if string.nilorempty(arg_87_0) or string.nilorempty(arg_87_1) then
		return false
	end

	return string.sub(arg_87_0, -string.len(arg_87_1)) == arg_87_1
end

function var_0_0.isBaseOf(arg_88_0, arg_88_1)
	if type(arg_88_0) ~= type(arg_88_1) then
		return false
	end

	if type(arg_88_0) ~= "table" or type(arg_88_1) ~= "table" then
		return false
	end

	local var_88_0 = arg_88_1

	while var_88_0 ~= nil do
		if var_88_0 == arg_88_0 then
			return true
		end

		var_88_0 = var_88_0.super
	end

	return false
end

function var_0_0.getRandomPosInCircle(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0 = arg_89_2 * arg_89_2
	local var_89_1 = math.random(1, 1000) / 1000
	local var_89_2 = math.sqrt(LuaTween.linear(var_89_1, 0, var_89_0, 1))
	local var_89_3 = math.random(1, 1000) / 1000
	local var_89_4 = LuaTween.linear(var_89_3, 0, 2 * math.pi, 1)
	local var_89_5 = var_89_2 * math.cos(var_89_4)
	local var_89_6 = var_89_2 * math.sin(var_89_4)

	return var_89_5 + arg_89_0, var_89_6 + arg_89_1
end

function var_0_0.doClearMember(arg_90_0, arg_90_1)
	if arg_90_0[arg_90_1] then
		arg_90_0[arg_90_1]:doClear()

		arg_90_0[arg_90_1] = nil
	end
end

local var_0_8 = require("protobuf.descriptor").FieldDescriptor

function var_0_0.copyPbData(arg_91_0, arg_91_1)
	if not arg_91_0 then
		return
	end

	local var_91_0 = arg_91_0._fields

	if next(var_91_0) then
		local var_91_1 = {}

		for iter_91_0, iter_91_1 in pairs(var_91_0) do
			local var_91_2 = iter_91_0.name

			if iter_91_0.label == var_0_8.LABEL_REPEATED then
				if #iter_91_1 ~= 0 then
					local var_91_3 = {}

					for iter_91_2, iter_91_3 in ipairs(iter_91_1) do
						if iter_91_0.cpp_type == var_0_8.CPPTYPE_MESSAGE and arg_91_1 then
							var_91_3[#var_91_3 + 1] = var_0_0.copyPbData(iter_91_3, arg_91_1)
						elseif iter_91_0.cpp_type == var_0_8.CPPTYPE_INT64 or iter_91_0.cpp_type == var_0_8.CPPTYPE_UINT64 then
							var_91_3[#var_91_3 + 1] = tonumber(iter_91_3)
						else
							var_91_3[#var_91_3 + 1] = iter_91_3
						end
					end

					var_91_1[var_91_2] = var_91_3
				end
			elseif iter_91_0.cpp_type == var_0_8.CPPTYPE_MESSAGE and arg_91_1 then
				var_91_1[var_91_2] = var_0_0.copyPbData(iter_91_1, true)
			elseif iter_91_0.cpp_type == var_0_8.CPPTYPE_INT64 or iter_91_0.cpp_type == var_0_8.CPPTYPE_UINT64 then
				var_91_1[var_91_2] = tonumber(iter_91_1)
			else
				var_91_1[var_91_2] = iter_91_1
			end
		end

		return var_91_1
	end
end

function var_0_0.convertToPercentStr(arg_92_0)
	arg_92_0 = arg_92_0 or 0

	return tostring(math.floor(arg_92_0 / 10)) .. "%"
end

function var_0_0.calcByDeltaRate1000(arg_93_0, arg_93_1)
	arg_93_0 = arg_93_0 or 0

	return arg_93_0 * (1000 + (arg_93_1 or 0)) / 1000
end

function var_0_0.calcByDeltaRate1000AsInt(arg_94_0, arg_94_1)
	return math.floor(var_0_0.calcByDeltaRate1000(arg_94_0, arg_94_1))
end

return var_0_0
