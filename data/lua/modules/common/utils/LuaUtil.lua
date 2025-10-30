module("modules.common.utils.LuaUtil", package.seeall)

local var_0_0 = {}

var_0_0.emptyStr = ""

function var_0_0.isFunction(arg_1_0)
	return type(arg_1_0) == "function"
end

function var_0_0.isTable(arg_2_0)
	return type(arg_2_0) == "table"
end

function var_0_0.isNumber(arg_3_0)
	return type(arg_3_0) == "number"
end

function var_0_0.isString(arg_4_0)
	return type(arg_4_0) == "string"
end

function var_0_0.isBoolean(arg_5_0)
	return type(arg_5_0) == "boolean"
end

function var_0_0.numToBoolean(arg_6_0)
	if not arg_6_0 or type(arg_6_0) ~= "number" then
		logError("请输入正确的数字！")

		return
	end

	return arg_6_0 ~= 0 and true or false
end

function var_0_0.isEmptyStr(arg_7_0)
	if arg_7_0 == nil then
		return true
	end

	return var_0_0.isString(arg_7_0) and string.gsub(arg_7_0, "^%s*(.-)%s*$", "%1") == var_0_0.emptyStr
end

function var_0_0.isLineFeedStr(arg_8_0)
	if arg_8_0 == nil then
		return false
	end

	return var_0_0.isString(arg_8_0) and (arg_8_0 == "\n" or arg_8_0 == "\r\n")
end

function var_0_0.getStrLen(arg_9_0)
	if var_0_0.isEmptyStr(arg_9_0) then
		return 0
	end

	local var_9_0 = #arg_9_0
	local var_9_1 = 0

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = string.byte(arg_9_0, iter_9_0)

		if var_9_2 > 0 and var_9_2 <= 127 then
			var_9_1 = var_9_1 + 1
		elseif var_9_2 >= 192 and var_9_2 <= 239 then
			var_9_1 = var_9_1 + 2
			iter_9_0 = iter_9_0 + 2
		end
	end

	return var_9_1
end

function var_0_0.getChineseLen(arg_10_0)
	if var_0_0.isEmptyStr(arg_10_0) then
		return 0
	end

	local var_10_0 = #arg_10_0
	local var_10_1 = 0

	for iter_10_0 = 1, var_10_0 do
		local var_10_2 = string.byte(arg_10_0, iter_10_0)

		if var_10_2 >= 192 and var_10_2 <= 239 then
			var_10_1 = var_10_1 + 1
			iter_10_0 = iter_10_0 + 2
		end
	end

	return var_10_1
end

function var_0_0.containChinese(arg_11_0)
	if var_0_0.isEmptyStr(arg_11_0) then
		return false
	end

	for iter_11_0 = 1, #arg_11_0 do
		local var_11_0 = string.byte(arg_11_0, iter_11_0)

		if var_11_0 >= 228 and var_11_0 <= 233 then
			local var_11_1 = string.byte(arg_11_0, iter_11_0 + 1) or 0
			local var_11_2 = string.byte(arg_11_0, iter_11_0 + 2) or 0

			if var_11_1 >= 128 and var_11_1 <= 191 and var_11_2 >= 128 and var_11_2 <= 191 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getCharNum(arg_12_0)
	if var_0_0.isEmptyStr(arg_12_0) then
		return 0
	end

	local var_12_0 = #arg_12_0
	local var_12_1 = 0

	for iter_12_0 = 1, var_12_0 do
		local var_12_2 = string.byte(arg_12_0, iter_12_0)

		if var_12_2 > 0 and var_12_2 <= 127 then
			var_12_1 = var_12_1 + 1
		elseif var_12_2 >= 192 and var_12_2 <= 239 then
			var_12_1 = var_12_1 + 1
			iter_12_0 = iter_12_0 + 2
		end
	end

	return var_12_1
end

function var_0_0.getUCharArr(arg_13_0)
	if var_0_0.isEmptyStr(arg_13_0) then
		return
	end

	local var_13_0 = {}

	for iter_13_0 in string.gmatch(arg_13_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF \n]*") do
		if not var_0_0.isEmptyStr(iter_13_0) then
			table.insert(var_13_0, iter_13_0)
		end
	end

	return var_13_0
end

function var_0_0.getUCharArrWithLineFeed(arg_14_0)
	if var_0_0.isEmptyStr(arg_14_0) then
		return
	end

	local var_14_0 = {}

	for iter_14_0 in string.gmatch(arg_14_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF ]*") do
		if not var_0_0.isEmptyStr(iter_14_0) or var_0_0.isLineFeedStr(iter_14_0) then
			table.insert(var_14_0, iter_14_0)
		end
	end

	return var_14_0
end

function var_0_0.strEndswith(arg_15_0, arg_15_1)
	if arg_15_0 == nil or arg_15_1 == nil then
		return nil, "the string or the sub-string parameter is nil"
	end

	local var_15_0 = string.reverse(arg_15_0)
	local var_15_1 = string.reverse(arg_15_1)

	if string.find(var_15_0, var_15_1) ~= 1 then
		return false
	else
		return true
	end
end

function var_0_0.getReverseArrTab(arg_16_0)
	if not arg_16_0 or not var_0_0.isTable(arg_16_0) then
		return arg_16_0
	end

	local var_16_0 = {}

	for iter_16_0 = #arg_16_0, 1, -1 do
		table.insert(var_16_0, arg_16_0[iter_16_0])
	end

	return var_16_0
end

function var_0_0.stringToVector3(arg_17_0)
	local var_17_0 = string.split(string.gsub(string.gsub(arg_17_0, "%[", ""), "%]", ""), ",")
	local var_17_1 = {}

	for iter_17_0 = 1, #var_17_0 do
		table.insert(var_17_1, tonumber(var_17_0[iter_17_0]))
	end

	return var_17_1
end

function var_0_0.pairsByKeys(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		var_18_0[#var_18_0 + 1] = iter_18_0
	end

	table.sort(var_18_0)

	local var_18_1 = 0

	return function()
		var_18_1 = var_18_1 + 1

		return var_18_0[var_18_1], arg_18_0[var_18_0[var_18_1]]
	end
end

function var_0_0.deepCopy(arg_20_0)
	local var_20_0 = {}

	local function var_20_1(arg_21_0)
		if type(arg_21_0) ~= "table" then
			return arg_21_0
		end

		local var_21_0 = {}

		var_20_0[arg_21_0] = var_21_0

		for iter_21_0, iter_21_1 in pairs(arg_21_0) do
			var_21_0[var_20_1(iter_21_0)] = var_20_1(iter_21_1)
		end

		return setmetatable(var_21_0, getmetatable(arg_21_0))
	end

	return var_20_1(arg_20_0)
end

function var_0_0.deepCopyNoMeta(arg_22_0)
	local var_22_0 = {}

	local function var_22_1(arg_23_0)
		if type(arg_23_0) ~= "table" then
			return arg_23_0
		end

		local var_23_0 = {}

		var_22_0[arg_23_0] = var_23_0

		for iter_23_0, iter_23_1 in pairs(arg_23_0) do
			var_23_0[var_22_1(iter_23_0)] = var_22_1(iter_23_1)
		end

		return var_23_0
	end

	return var_22_1(arg_22_0)
end

function var_0_0.deepCopySimple(arg_24_0)
	if type(arg_24_0) ~= "table" then
		return arg_24_0
	else
		local var_24_0 = {}

		for iter_24_0, iter_24_1 in pairs(arg_24_0) do
			var_24_0[iter_24_0] = var_0_0.deepCopySimple(iter_24_1)
		end

		return var_24_0
	end
end

function var_0_0.luaHotUpdate(arg_25_0)
	local var_25_0 = moduleNameToTables[arg_25_0]

	moduleNameToTables[arg_25_0] = nil
	package.loaded[moduleNameToPath[arg_25_0]] = nil

	setGlobal(arg_25_0, nil)

	if var_25_0 and var_25_0.instance then
		local var_25_1 = _G[arg_25_0]

		for iter_25_0, iter_25_1 in pairs(var_25_0.instance) do
			if type(iter_25_1) ~= "function" or not var_25_1.instance[iter_25_0] then
				var_25_1.instance[iter_25_0] = iter_25_1
			end
		end
	end

	print(arg_25_0, "======hot update finish!")
end

function var_0_0.replaceSpace(arg_26_0, arg_26_1)
	if string.nilorempty(arg_26_0) or not arg_26_1 and LangSettings.instance:isEn() then
		return arg_26_0
	end

	return string.gsub(arg_26_0, " ", " ")
end

function var_0_0.updateTMPRectHeight_LayoutElement(arg_27_0)
	local var_27_0 = gohelper.onceAddComponent(arg_27_0.gameObject, typeof(UnityEngine.UI.LayoutElement))

	arg_27_0:ForceMeshUpdate(true, true)

	var_27_0.preferredHeight = arg_27_0:GetRenderedValues().y
end

function var_0_0.updateTMPRectHeight(arg_28_0)
	arg_28_0:ForceMeshUpdate(true, true)

	local var_28_0 = arg_28_0:GetRenderedValues()

	recthelper.setHeight(arg_28_0.rectTransform, var_28_0.y)
end

function var_0_0.mergeTable(arg_29_0, ...)
	local var_29_0 = {
		...
	}

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		if iter_29_1 then
			for iter_29_2, iter_29_3 in pairs(iter_29_1) do
				table.insert(arg_29_0, iter_29_3)
			end
		end
	end

	return arg_29_0
end

function var_0_0.insertDict(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		table.insert(arg_30_0, iter_30_1)
	end
end

function var_0_0.tableContains(arg_31_0, arg_31_1)
	if not arg_31_0 then
		return false
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0) do
		if iter_31_1 == arg_31_1 then
			return true
		end
	end

	return false
end

function var_0_0.indexOfElement(arg_32_0, arg_32_1)
	if not arg_32_0 then
		return -1
	end

	for iter_32_0, iter_32_1 in pairs(arg_32_0) do
		if iter_32_1 == arg_32_1 then
			return iter_32_0
		end
	end

	return -1
end

function var_0_0.tableToDictionary(arg_33_0)
	local var_33_0 = System.Collections.Generic.Dictionary_string_object.New()

	if arg_33_0 then
		for iter_33_0, iter_33_1 in pairs(arg_33_0) do
			var_33_0:Add(iter_33_0, iter_33_1)
		end
	end

	return var_33_0
end

function var_0_0.subString(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0
	local var_34_1 = 1
	local var_34_2 = -1
	local var_34_3 = 0
	local var_34_4 = 0

	arg_34_1 = math.max(arg_34_1, 1)
	arg_34_2 = arg_34_2 or -1

	while string.len(var_34_0) > 0 do
		if var_34_3 == arg_34_1 - 1 then
			var_34_1 = var_34_4 + 1
		elseif var_34_3 == arg_34_2 then
			var_34_2 = var_34_4

			break
		end

		var_34_4 = var_34_4 + var_0_0.GetBytes(var_34_0)
		var_34_0 = string.sub(arg_34_0, var_34_4 + 1)
		var_34_3 = var_34_3 + 1
	end

	return string.sub(arg_34_0, var_34_1, var_34_2)
end

function var_0_0.GetBytes(arg_35_0)
	if not arg_35_0 then
		return 0
	end

	local var_35_0 = string.byte(arg_35_0)

	if var_35_0 < 127 then
		return 1
	elseif var_35_0 <= 223 then
		return 2
	elseif var_35_0 <= 239 then
		return 3
	elseif var_35_0 <= 247 then
		return 4
	else
		return 0
	end
end

function var_0_0.tableNotEmpty(arg_36_0)
	if not arg_36_0 then
		return false
	end

	if not var_0_0.isTable(arg_36_0) then
		return false
	end

	return next(arg_36_0) ~= nil
end

function var_0_0.fractionAddition(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_1

	if arg_37_1 ~= arg_37_3 then
		var_37_0 = arg_37_1 * arg_37_3
		arg_37_0 = arg_37_0 * arg_37_3
		arg_37_2 = arg_37_2 * arg_37_1
	end

	return arg_37_0 + arg_37_2, var_37_0
end

function var_0_0.divisionOperation2Fraction(arg_38_0, arg_38_1)
	local var_38_0, var_38_1 = var_0_0.float2Fraction(arg_38_0)
	local var_38_2, var_38_3 = var_0_0.float2Fraction(arg_38_1)

	return var_38_0 * var_38_3, var_38_1 * var_38_2
end

function var_0_0.float2Fraction(arg_39_0)
	local var_39_0, var_39_1 = math.modf(arg_39_0)
	local var_39_2 = var_39_0
	local var_39_3 = 1

	if var_39_1 ~= 0 then
		local var_39_4 = #tostring(var_39_1) - 2

		var_39_2, var_39_3 = var_0_0.fractionAddition(var_39_2, var_39_3, math.abs(var_39_1 * 10 * var_39_4), var_39_4 * 10)
	end

	return var_39_2, var_39_3
end

function var_0_0.full2HalfWidth(arg_40_0)
	local var_40_0 = {}

	for iter_40_0 in arg_40_0:gmatch("[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if iter_40_0:byte(3) then
			local var_40_1 = iter_40_0:byte(2) * 64 + iter_40_0:byte(3) - 12193 + 65

			if var_40_1 > 32 and var_40_1 < 126 then
				table.insert(var_40_0, string.char(var_40_1))
			else
				table.insert(var_40_0, iter_40_0)
			end
		else
			table.insert(var_40_0, iter_40_0)
		end
	end

	return table.concat(var_40_0)
end

function var_0_0.class(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if isDebugBuild and arg_41_1 then
		if arg_41_3 then
			assert(_G.isTypeOf(arg_41_3, arg_41_1), arg_41_3.__cname .. " is not type of " .. arg_41_1.__cname)
		end

		if arg_41_2 then
			assert(_G.isTypeOf(arg_41_2, arg_41_1), arg_41_2.__cname .. " is not type of " .. arg_41_1.__cname)
		end
	end

	if SettingsModel.instance:isOverseas() then
		return _G.class(arg_41_0, arg_41_2 or arg_41_1)
	else
		return _G.class(arg_41_0, arg_41_3 or arg_41_1)
	end
end

return var_0_0
