module("modules.common.utils.GameUtil", package.seeall)

slot0 = {
	getBriefName = function (slot0, slot1, slot2)
		if LuaUtil.isEmptyStr(slot0) then
			return ""
		end

		if LuaUtil.getStrLen(slot0) <= slot1 then
			return slot0
		end

		if LuaUtil.getUCharArr(slot0) == nil or #slot4 <= 0 then
			return LuaUtil.emptyStr
		end

		slot2 = slot2 or "..."
		slot5 = LuaUtil.emptyStr

		for slot10 = 1, #slot4 do
			if string.byte(slot4[slot10]) > 0 and slot11 <= 127 then
				slot6 = 0 + 1
			elseif slot11 >= 192 and slot11 <= 239 then
				slot6 = slot6 + 2
			end

			if slot1 >= slot6 then
				slot5 = slot5 .. slot4[slot10]
			end
		end

		return slot5 .. slot2
	end,
	getUCharArrWithoutRichTxt = function (slot0)
		slot2 = LuaUtil.getUCharArr(string.gsub(slot0, "(<[^>]+>)", function (slot0)
			table.insert(uv0, slot0)

			return "▩"
		end)) or {}

		for slot6 = #slot2, 1, -1 do
			if slot2[slot6] == "▩" then
				if slot2[slot6 + 1] then
					slot2[slot6 + 1] = (table.remove({}) or "") .. slot2[slot6 + 1]

					table.remove(slot2, slot6)
				else
					slot2[slot6] = slot7
				end
			end
		end

		return slot2
	end,
	removeJsonNull = function (slot0)
		for slot4, slot5 in pairs(slot0) do
			if slot5 == cjson.null then
				slot0[slot4] = nil
			elseif type(slot5) == "table" then
				uv0.removeJsonNull(slot5)
			end
		end
	end,
	getBriefNameByWidth = function (slot0, slot1, slot2, slot3)
		if LuaUtil.isEmptyStr(slot0) then
			return ""
		end

		if LuaUtil.getStrLen(slot0) <= 0 then
			return slot0
		end

		if SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot1, slot0) < slot1.transform.sizeDelta.x - (slot2 or 15) then
			return slot0
		end

		slot3 = slot3 or "..."

		for slot10 = slot4 - 1, 1, -1 do
			if SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot1, uv0.getBriefName(slot0, slot10, "")) < slot5 then
				return slot11 .. slot3
			end
		end

		return slot0 .. slot3
	end,
	trimInput = function (slot0)
		return string.gsub(string.gsub(slot0, "　", ""), "[ \t\n\r]+", "")
	end,
	trimInput1 = function (slot0)
		return string.gsub(string.gsub(slot0, "　", ""), "[ \t\r]+", "")
	end,
	filterSpecChars = function (slot0)
		slot1 = {}
		slot2 = 1

		while true do
			if slot2 > #slot0 then
				break
			end

			if not string.byte(slot0, slot2) then
				break
			end

			if slot3 < 192 then
				if slot3 >= 48 and slot3 <= 57 or slot3 >= 65 and slot3 <= 90 or slot3 >= 97 and slot3 <= 122 then
					table.insert(slot1, string.char(slot3))
				end

				slot2 = slot2 + 1
			elseif slot3 < 224 then
				slot2 = slot2 + 2
			elseif slot3 < 240 then
				if slot3 >= 228 and slot3 <= 233 then
					slot5 = string.byte(slot0, slot2 + 2)

					if string.byte(slot0, slot2 + 1) and slot5 then
						slot6 = 128
						slot7 = 191
						slot8 = 128
						slot9 = 191

						if slot3 == 228 then
							slot6 = 184
						elseif slot3 == 233 then
							slot9 = slot4 ~= 190 and 191 or 165
							slot7 = 190
						end

						if slot6 <= slot4 and slot4 <= slot7 and slot8 <= slot5 and slot5 <= slot9 then
							table.insert(slot1, string.char(slot3, slot4, slot5))
						end
					end
				end

				slot2 = slot2 + 3
			elseif slot3 < 248 then
				slot2 = slot2 + 4
			elseif slot3 < 252 then
				slot2 = slot2 + 5
			elseif slot3 < 254 then
				slot2 = slot2 + 6
			end
		end

		return table.concat(slot1)
	end,
	containsPunctuation = function (slot0)
		if LuaUtil.isEmptyStr(slot0) then
			return false
		end

		slot2 = 1

		for slot6 = 1, #slot0 do
			if string.byte(slot0, slot2) then
				if slot7 >= 48 and slot7 <= 57 or slot7 >= 65 and slot7 <= 90 or slot7 >= 97 and slot7 <= 122 then
					slot2 = slot2 + 1
				elseif slot7 >= 228 and slot7 <= 233 then
					slot2 = slot2 + 3
				else
					return true
				end
			end
		end

		return false
	end,
	test = function ()
		slot0 = "233不顺利的！"

		logNormal("a length = " .. LuaUtil.getStrLen(slot0) .. " a ch = " .. LuaUtil.getChineseLen(slot0))
		logNormal("LuaUtil.getBriefName = " .. uv0.getBriefName(slot0, 6, ".prefab"))

		slot1 = "地饭 大发      大\ndd哈哈\t哈哈"

		logNormal("trimInput = " .. uv0.trimInput(slot1))
		logNormal("trimInput1 = " .. uv0.trimInput1(slot1))

		slot1 = "地饭大 发大\ndd哈哈\t哈哈"

		logNormal("trimInput1 = " .. uv0.trimInput1(slot1))
		logNormal("GameUtil.containsPunctuation = " .. tostring(uv0.containsPunctuation(slot1)))
	end,
	parseColor = function (slot0)
		return SLFramework.UGUI.GuiHelper.ParseColor(slot0)
	end,
	colorToHex = function (slot0)
		return SLFramework.UGUI.GuiHelper.ColorToHex(slot0)
	end,
	splitString2 = function (slot0, slot1, slot2, slot3)
		if uv0.needLogInFightSceneUseStringFunc() then
			logError("战斗中不要用`GameUtil.splitString2`, 用`FightStrUtil.getSplitString2Cache`代替")
		end

		if string.nilorempty(slot0) then
			return
		end

		for slot8, slot9 in ipairs(string.split(slot0, slot2 or "|")) do
			if slot1 then
				slot4[slot8] = string.splitToNumber(slot9, slot3 or "#")
			else
				slot4[slot8] = string.split(slot9, slot3)
			end
		end

		return slot4
	end,
	RichTextTags = {
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
	},
	filterRichText = function (slot0)
		for slot5, slot6 in ipairs(uv0.RichTextTags) do
			slot1 = string.gsub(slot0, slot6, "")
		end

		return slot1
	end,
	numberDisplay = function (slot0)
		if tonumber(slot0) <= 99999 then
			return slot1
		elseif slot1 <= 99999999 and slot1 > 99999 then
			return math.floor(slot1 / 1000) .. "K"
		else
			return math.floor(slot1 / 1000000) .. "M"
		end
	end,
	getRomanNums = function (slot0)
		return uv0[slot0]
	end,
	getNum2Chinese = function (slot0)
		if GameConfig:GetCurLangType() ~= LangSettings.zh then
			return slot0
		end

		if slot0 < 10 then
			return uv0[slot0]
		else
			slot1 = uv0
			slot2 = uv1
			slot5 = {}

			for slot10 = 1, string.len(tostring(slot0)) do
				slot12 = slot4 - slot10 + 1

				if tonumber(string.sub(slot3, slot10, slot10)) > 0 and false == true then
					slot5[#slot5 + 1] = uv0[0]
					slot6 = false
				end

				if slot12 % 4 == 2 and slot11 == 1 then
					if slot12 < slot4 then
						slot5[#slot5 + 1] = slot1[slot11]
					end

					slot5[#slot5 + 1] = slot2[slot12 - 1] or ""
				elseif slot11 > 0 then
					slot5[#slot5 + 1] = slot1[slot11]
					slot5[#slot5 + 1] = slot2[slot12 - 1] or ""
				elseif slot11 == 0 then
					if slot12 % 4 == 1 then
						slot5[#slot5 + 1] = slot2[slot12 - 1] or ""
					else
						slot6 = true
					end
				end
			end

			return table.concat(slot5, "")
		end
	end,
	englishOrderNumber = {}
}
slot1 = {
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
	"XII"
}
slot2 = {
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
slot3 = {
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
slot0.englishOrderNumber[1] = "FIRST"
slot0.englishOrderNumber[2] = "SECOND"
slot0.englishOrderNumber[3] = "THIRD"
slot0.englishOrderNumber[4] = "FOURTH"
slot0.englishOrderNumber[5] = "FIFTH"
slot0.englishOrderNumber[6] = "SIXTH"
slot0.englishOrderNumber[7] = "SEVENTH"
slot0.englishOrderNumber[8] = "EIGHTH"
slot0.englishOrderNumber[9] = "NINTH"
slot0.englishOrderNumber[10] = "TENTH"

function slot0.getEnglishOrderNumber(slot0)
	return uv0.englishOrderNumber[slot0] or string.format("%dth", slot0)
end

slot4 = {
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

function slot0.getEnglishNumber(slot0)
	return uv0[slot0]
end

function slot0.charsize(slot0)
	if not slot0 then
		return 0
	elseif slot0 >= 252 then
		return 6
	elseif slot0 >= 248 and slot0 < 252 then
		return 5
	elseif slot0 >= 240 and slot0 < 248 then
		return 4
	elseif slot0 >= 224 and slot0 < 240 then
		return 3
	elseif slot0 >= 192 and slot0 < 224 then
		return 2
	elseif slot0 < 192 then
		return 1
	end
end

function slot0.utf8len(slot0)
	if string.nilorempty(slot0) then
		return 0
	end

	slot1 = 0
	slot2 = 0
	slot3 = 0
	slot4 = 1

	while slot4 <= #slot0 do
		slot6 = uv0.charsize(string.byte(slot0, slot4))
		slot4 = slot4 + slot6
		slot1 = slot1 + 1

		if slot6 == 1 then
			slot2 = slot2 + 1
		elseif slot6 >= 2 then
			slot3 = slot3 + 1
		end
	end

	return slot1, slot2, slot3
end

function slot0.utf8sub(slot0, slot1, slot2)
	slot3 = 1

	while slot1 > 1 do
		slot3 = slot3 + uv0.charsize(string.byte(slot0, slot3))
		slot1 = slot1 - 1
	end

	slot4 = slot3

	while slot2 > 0 and slot4 <= #slot0 do
		slot4 = slot4 + uv0.charsize(string.byte(slot0, slot4))
		slot2 = slot2 - 1
	end

	return string.sub(slot0, slot3, slot4 - 1)
end

function slot0.utf8isnum(slot0)
	if string.nilorempty(slot0) then
		return false
	end

	slot4 = slot0

	for slot4 = 1, string.len(slot4) do
		if not string.byte(slot0, slot4) then
			return false
		end

		if slot5 < 48 or slot5 > 57 then
			return false
		end
	end

	return true
end

function slot0.getPreferredWidth(slot0, slot1)
	return SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0, slot1)
end

function slot0.getPreferredHeight(slot0, slot1)
	return SLFramework.UGUI.GuiHelper.GetPreferredHeight(slot0, slot1)
end

function slot0.getTextHeightByLine(slot0, slot1, slot2, slot3)
	slot4 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(slot0, " ")
	slot5 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(slot0, slot1)

	return slot4 > 0 and slot5 / slot4 * slot2 + (slot5 / slot4 - 1) * (slot3 or 0) or 0
end

function slot0.getTextWidthByLine(slot0, slot1, slot2)
	return SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0, "啊") > 0 and SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0, slot1) / slot3 * slot2 or 0
end

function slot0.getSubPlaceholderLuaLang(slot0, slot1)
	if slot1 and #slot1 > 0 then
		slot0 = string.gsub(slot0, "▩([0-9]+)%%([sd])", function (slot0, slot1)
			if not uv0[tonumber(slot0)] then
				if isDebugBuild then
					logError(table.concat({
						"[getSubPlaceholderLuaLang] =========== begin",
						"text: " .. uv1,
						"index: " .. slot0,
						"format: " .. slot1,
						"fillParams[index]: 不存在",
						"[getSubPlaceholderLuaLang] =========== end"
					}, "\n"))
				end

				return ""
			end

			if type(uv0[slot0]) == "number" and slot1 == "d" then
				return string.format("%d", uv0[slot0])
			end

			if isDebugBuild and string.find(uv0[slot0], "%%", 1, true) then
				logError(table.concat({
					[1.0] = "[getSubPlaceholderLuaLang] =========== begin",
					[6.0] = "[getSubPlaceholderLuaLang] =========== end",
					[2] = "text: " .. uv1,
					[3] = "index: " .. slot0,
					[4] = "format: " .. slot1,
					[5] = "fillParams[index]:" .. uv0[slot0]
				}, "\n"))
			end

			return uv0[slot0]
		end)
	end

	return slot0
end

function slot0.getSubPlaceholderLuaLangOneParam(slot0, slot1)
	return string.gsub(slot0, "▩1%%s", slot1)
end

function slot0.getSubPlaceholderLuaLangTwoParam(slot0, slot1, slot2)
	return string.gsub(string.gsub(slot0, "▩1%%s", slot1), "▩2%%s", slot2)
end

function slot0.getSubPlaceholderLuaLangThreeParam(slot0, slot1, slot2, slot3)
	return string.gsub(string.gsub(string.gsub(slot0, "▩1%%s", slot1), "▩2%%s", slot2), "▩3%%s", slot3)
end

function slot0.getMarkIndexList(slot0)
	slot1 = "<em>"
	slot2 = "</em>"

	if string.nilorempty(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(slot0, slot1, "▩1"), slot2, "▩2"), "<[^<>][^<>]->", ""), "▩1", slot1), "▩2", slot2)) or string.nilorempty(slot1) or string.nilorempty(slot2) then
		return {}
	end

	slot4 = {}
	slot6 = 1

	for slot10, slot11 in ipairs(string.split(slot0, slot1)) do
		if slot10 == #slot5 then
			break
		end

		table.insert(slot4, slot6 + uv0.utf8len(slot11) + (slot10 == 1 and 0 or 1) * uv0.utf8len(slot1))
	end

	slot7 = {}
	slot9 = 1

	for slot13, slot14 in ipairs(string.split(slot0, slot2)) do
		if slot13 == #slot8 then
			break
		end

		table.insert(slot7, slot9 + uv0.utf8len(slot14) + (slot13 == 1 and 0 or 1) * uv0.utf8len(slot2))
	end

	slot10 = false
	slot11 = 0
	slot12 = 0

	while slot11 <= uv0.utf8len(slot0) do
		if LuaUtil.tableContains(slot4, slot11) then
			slot10 = true
			slot11 = slot11 + uv0.utf8len(slot1)
			slot12 = slot12 + uv0.utf8len(slot1)
		elseif LuaUtil.tableContains(slot7, slot11) then
			slot10 = false
			slot11 = slot11 + uv0.utf8len(slot2)
			slot12 = slot12 + uv0.utf8len(slot2)
		else
			if slot10 then
				table.insert(slot3, slot11 - slot12 - 1)
			end

			slot11 = slot11 + 1
		end
	end

	return slot3
end

function slot0.getMarkText(slot0)
	if string.nilorempty(slot0) then
		return ""
	end

	return string.gsub(string.gsub(slot0, "<em>", ""), "</em>", "")
end

function slot0.getTimeFromString(slot0)
	if string.nilorempty(slot0) then
		return 9999999999.0
	end

	slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8 = string.find(slot0, "(%d-)%-(%d-)%-(%d-)%s-(%d-):(%d-):(%d+)")

	return os.time({
		year = tonumber(slot3),
		month = tonumber(slot4),
		day = tonumber(slot5),
		hour = tonumber(slot6),
		min = tonumber(slot7),
		sec = tonumber(slot8)
	})
end

function slot0.getTabLen(slot0)
	slot1 = 0

	if slot0 then
		for slot5, slot6 in pairs(slot0) do
			if slot0[slot5] ~= nil then
				slot1 = slot1 + 1
			end
		end
	end

	return slot1
end

function slot0.getAdapterScale()
	slot0 = Time.time

	if uv0._adapterScale and uv0._scaleCalcTime and slot0 - uv0._scaleCalcTime < 0.01 then
		return uv0._adapterScale
	end

	uv0._scaleCalcTime = slot0
	slot1 = UnityEngine.Screen.width
	slot2 = UnityEngine.Screen.height

	if BootNativeUtil.isWindows() then
		slot1, slot2 = SettingsModel.instance:getCurrentScreenSize()
	end

	if 1.7777777777777777 - slot1 / slot2 > 0.01 then
		uv0._adapterScale = slot4 / slot3
	else
		uv0._adapterScale = 1
	end

	return uv0._adapterScale
end

function slot0.fillZeroInLeft(slot0, slot1)
	slot2 = tostring(slot0)

	return string.rep("0", slot1 - #slot2) .. slot2
end

function slot0.randomTable(slot0)
	for slot5 = 1, #slot0 do
		slot6 = math.random(slot5, slot1)
		slot0[slot6] = slot0[slot5]
		slot0[slot5] = slot0[slot6]
	end

	return slot0
end

function slot0.artTextNumReplace(slot0)
	if string.nilorempty(slot0) then
		return slot0
	end

	slot2 = string.len(slot0)
	slot3 = {}

	while slot1 > 0 do
		table.insert(slot3, 1, slot1 % 10)

		slot1 = math.floor(slot1 / 10)
	end

	for slot8 = 1, slot2 do
		slot4 = "" .. string.format("<sprite=%s>", slot3[slot8])
	end

	return slot4
end

function slot0.tabletool_fastRemoveValueByValue(slot0, slot1)
	for slot5, slot6 in ipairs(slot0) do
		if slot6 == slot1 then
			return uv0.tabletool_fastRemoveValueByPos(slot0, slot5)
		end
	end
end

function slot0.tabletool_fastRemoveValueByPos(slot0, slot1)
	slot0[slot1] = slot0[#slot0]

	table.remove(slot0)

	return slot0, slot0[slot1]
end

function slot0.tabletool_dictIsEmpty(slot0)
	if not slot0 then
		return true
	end

	for slot4, slot5 in pairs(slot0) do
		return false
	end

	return true
end

function slot0.checkPointInRectangle(slot0, slot1, slot2, slot3, slot4)
	slot10 = Vector2.Dot(slot3 - slot2, slot0 - slot2)

	return Vector2.Dot(slot2 - slot1, slot0 - slot1) >= 0 and slot9 <= Vector2.Dot(slot5, slot5) and slot10 >= 0 and slot10 <= Vector2.Dot(slot7, slot7)
end

function slot0.noMoreThanOneDecimalPlace(slot0)
	return math.fmod(slot0, 1) > 0 and string.format("%.1f", slot0) or string.format("%d", slot0)
end

function slot0.isMobilePlayerAndNotEmulator()
	return BootNativeUtil.isMobilePlayer() and not SDKMgr.instance:isEmulator()
end

function slot0.openDeepLink(slot0, slot1)
	if string.nilorempty(slot1) or string.nilorempty(slot0) then
		return
	end

	if SLFramework.FrameworkSettings.IsEditor then
		UnityEngine.Application.OpenURL(slot0)

		return
	end

	slot3 = cjson.encode({
		deepLink = slot1,
		url = slot0
	})

	logNormal("openDeepLink:" .. tostring(slot3))
	ZProj.SDKManager.Instance:CallVoidFuncWithParams("openDeepLink", slot3)

	return true
end

function slot0.getMotionDuration(slot0, slot1)
	if slot0 then
		for slot6 = 0, slot0.runtimeAnimatorController.animationClips.Length - 1 do
			if slot2[slot6].name == slot1 then
				return slot7.length
			end
		end
	end

	return 0
end

function slot0.onDestroyViewMemberList(slot0, slot1)
	if slot0[slot1] then
		for slot6, slot7 in ipairs(slot0[slot1]) do
			slot7:onDestroyView()
		end

		slot0[slot1] = nil
	end
end

function slot0.onDestroyViewMember(slot0, slot1)
	if slot0[slot1] then
		slot0[slot1]:onDestroyView()

		slot0[slot1] = nil
	end
end

slot5 = ZProj.TweenHelper

function slot0.onDestroyViewMember_TweenId(slot0, slot1)
	if slot0[slot1] then
		uv0.KillById(slot0[slot1])

		slot0[slot1] = nil
	end
end

function slot0.onDestroyViewMemberList_SImage(slot0, slot1)
	if slot0[slot1] then
		for slot6, slot7 in ipairs(slot0[slot1]) do
			slot7:UnLoadImage()
		end

		slot0[slot1] = nil
	end
end

function slot0.onDestroyViewMember_SImage(slot0, slot1)
	if slot0[slot1] then
		slot0[slot1]:UnLoadImage()

		slot0[slot1] = nil
	end
end

function slot0.onDestroyViewMember_ClickListener(slot0, slot1)
	if slot0[slot1] then
		slot0[slot1]:RemoveClickListener()

		slot0[slot1] = nil
	end
end

function slot0.setActive01(slot0, slot1)
	if slot1 then
		transformhelper.setLocalScale(slot0, 1, 1, 1)
	else
		transformhelper.setLocalScale(slot0, 0, 0, 0)
	end
end

function slot0.clamp(slot0, slot1, slot2)
	return math.min(slot2, math.max(slot0, slot1))
end

function slot0.saturate(slot0)
	return uv0.clamp(slot0, 0, 1)
end

function slot0.remap(slot0, slot1, slot2, slot3, slot4)
	return slot3 + (uv0.clamp(slot0, slot1, slot2) - slot1) * (slot4 - slot3) / (slot2 - slot1)
end

function slot0.remap01(slot0, slot1, slot2)
	return uv0.remap(slot0, slot1, slot2, 0, 1)
end

function slot0.setFirstStrSize(slot0, slot1)
	if string.nilorempty(slot0) then
		return
	end

	slot2 = uv0.utf8sub(slot0, 1, 1)
	slot3 = ""

	if uv0.utf8len(slot0) >= 2 then
		slot3 = uv0.utf8sub(slot0, 2, slot4 - 1)
	end

	return string.format("<size=%s>%s</size>%s", slot1, slot2, slot3)
end

function slot0.playerPrefsGetNumberByUserId(slot0, slot1)
	if not PlayerModel.instance:getMyUserId() or slot2 == 0 then
		return slot1
	end

	return PlayerPrefsHelper.getNumber(slot0 .. "#" .. tostring(slot2), slot1)
end

function slot0.playerPrefsSetNumberByUserId(slot0, slot1)
	if not PlayerModel.instance:getMyUserId() or slot2 == 0 then
		return
	end

	PlayerPrefsHelper.setNumber(slot0 .. "#" .. tostring(slot2), slot1)
end

function slot0.playerPrefsGetStringByUserId(slot0, slot1)
	if not PlayerModel.instance:getMyUserId() or slot2 == 0 then
		return slot1
	end

	return PlayerPrefsHelper.getString(slot0 .. "#" .. tostring(slot2), slot1)
end

function slot0.playerPrefsSetStringByUserId(slot0, slot1)
	if not PlayerModel.instance:getMyUserId() or slot2 == 0 then
		return
	end

	PlayerPrefsHelper.setString(slot0 .. "#" .. tostring(slot2), slot1)
end

slot6 = {
	__call = function (slot0)
		slot0.count = slot0.count + 1

		return slot0.count
	end
}

function slot0.getUniqueTb(slot0)
	slot1 = {
		count = slot0 or 1
	}

	setmetatable(slot1, uv0)

	return slot1
end

slot7 = slot0.getUniqueTb()

function slot0.getEventId()
	return uv0()
end

function slot0.setDefaultValue(slot0, slot1)
	setmetatable(slot0, {
		__index = function ()
			return uv0
		end
	})
end

function slot0.rpcInfosToList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0) do
		slot8 = slot1.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0.rpcInfosToMap(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0) do
		slot1.New():init(slot8)
	end

	return {
		[slot9[slot2 or "id"]] = slot9
	}
end

function slot0.rpcInfosToListAndMap(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in ipairs(slot0) do
		slot10 = slot1.New()

		slot10:init(slot9)
		table.insert(slot4, slot10)
	end

	return slot4, {
		[slot10[slot2 or "id"]] = slot10
	}
end

function slot0.setActiveUIBlock(slot0, slot1, slot2)
	UIBlockMgrExtend.setNeedCircleMv(slot2 ~= false and true or false)

	if slot1 then
		UIBlockMgr.instance:startBlock(slot0)
	else
		UIBlockMgr.instance:endBlock(slot0)
	end
end

function slot0.loadSImage(slot0, slot1)
	if string.nilorempty(slot1) then
		slot0:UnLoadImage()
	else
		slot0:LoadImage(slot1)
	end
end

function slot0.logTab(slot0, slot1)
	if not slot0 or type(slot0) ~= "table" then
		return tostring(slot0)
	end

	if (slot1 or 0) > 100 then
		logError("stack overflow ...")

		return tostring(slot0)
	end

	slot3 = string.rep("\t", slot1)
	slot9 = " {"

	table.insert({}, string.format(slot9))

	for slot8, slot9 in pairs(slot0) do
		if type(slot9) == "table" then
			table.insert(slot2, string.format("%s %s = %s,", string.rep("\t", slot1 + 1), slot8, uv0.logTab(slot9, slot1 + 1)))
		else
			table.insert(slot2, string.format("%s %s = %s,", slot4, slot8, slot9))
		end
	end

	table.insert(slot2, string.format("%s }", slot3))

	return table.concat(slot2, "\n")
end

function slot0.getViewSize()
	slot1 = ViewMgr.instance:getUILayer("HUD").transform

	return recthelper.getWidth(slot1), recthelper.getHeight(slot1)
end

function slot0.checkClickPositionInRight(slot0)
	slot3, slot4 = recthelper.screenPosToAnchorPos2(slot0, ViewMgr.instance:getUILayer("HUD"):GetComponent(gohelper.Type_RectTransform))

	return slot3 >= 0
end

function slot0.needLogInFightSceneUseStringFunc()
	return false and GameSceneMgr.instance:isFightScene()
end

function slot0.needLogInOtherSceneUseFightStrUtilFunc()
	return false
end

slot0.enumId = 0

function slot0.getEnumId()
	uv0.enumId = uv0.enumId + 1

	return uv0.enumId
end

slot0.instanceId = 0

function slot0.getInstanceId()
	uv0.instanceId = uv0.instanceId + 1

	return uv0.instanceId
end

slot0.msgId = 0

function slot0.getMsgId()
	uv0.msgId = uv0.msgId + 1

	return uv0.msgId
end

function slot0.endsWith(slot0, slot1)
	if string.nilorempty(slot0) or string.nilorempty(slot1) then
		return false
	end

	return string.sub(slot0, -string.len(slot1)) == slot1
end

function slot0.isBaseOf(slot0, slot1)
	if type(slot0) ~= type(slot1) then
		return false
	end

	if type(slot0) ~= "table" or type(slot1) ~= "table" then
		return false
	end

	slot2 = slot1

	while slot2 ~= nil do
		if slot2 == slot0 then
			return true
		end

		slot2 = slot2.super
	end

	return false
end

return slot0
