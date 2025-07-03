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

function var_0_0.getStrLen(arg_8_0)
	if var_0_0.isEmptyStr(arg_8_0) then
		return 0
	end

	local var_8_0 = #arg_8_0
	local var_8_1 = 0

	for iter_8_0 = 1, var_8_0 do
		local var_8_2 = string.byte(arg_8_0, iter_8_0)

		if var_8_2 > 0 and var_8_2 <= 127 then
			var_8_1 = var_8_1 + 1
		elseif var_8_2 >= 192 and var_8_2 <= 239 then
			var_8_1 = var_8_1 + 2
			iter_8_0 = iter_8_0 + 2
		end
	end

	return var_8_1
end

function var_0_0.getChineseLen(arg_9_0)
	if var_0_0.isEmptyStr(arg_9_0) then
		return 0
	end

	local var_9_0 = #arg_9_0
	local var_9_1 = 0

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = string.byte(arg_9_0, iter_9_0)

		if var_9_2 >= 192 and var_9_2 <= 239 then
			var_9_1 = var_9_1 + 1
			iter_9_0 = iter_9_0 + 2
		end
	end

	return var_9_1
end

function var_0_0.containChinese(arg_10_0)
	if var_0_0.isEmptyStr(arg_10_0) then
		return false
	end

	for iter_10_0 = 1, #arg_10_0 do
		local var_10_0 = string.byte(arg_10_0, iter_10_0)

		if var_10_0 >= 228 and var_10_0 <= 233 then
			local var_10_1 = string.byte(arg_10_0, iter_10_0 + 1) or 0
			local var_10_2 = string.byte(arg_10_0, iter_10_0 + 2) or 0

			if var_10_1 >= 128 and var_10_1 <= 191 and var_10_2 >= 128 and var_10_2 <= 191 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getCharNum(arg_11_0)
	if var_0_0.isEmptyStr(arg_11_0) then
		return 0
	end

	local var_11_0 = #arg_11_0
	local var_11_1 = 0

	for iter_11_0 = 1, var_11_0 do
		local var_11_2 = string.byte(arg_11_0, iter_11_0)

		if var_11_2 > 0 and var_11_2 <= 127 then
			var_11_1 = var_11_1 + 1
		elseif var_11_2 >= 192 and var_11_2 <= 239 then
			var_11_1 = var_11_1 + 1
			iter_11_0 = iter_11_0 + 2
		end
	end

	return var_11_1
end

function var_0_0.getUCharArr(arg_12_0)
	if var_0_0.isEmptyStr(arg_12_0) then
		return
	end

	local var_12_0 = {}

	for iter_12_0 in string.gmatch(arg_12_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF ]*") do
		if not var_0_0.isEmptyStr(iter_12_0) then
			table.insert(var_12_0, iter_12_0)
		end
	end

	return var_12_0
end

function var_0_0.strEndswith(arg_13_0, arg_13_1)
	if arg_13_0 == nil or arg_13_1 == nil then
		return nil, "the string or the sub-string parameter is nil"
	end

	local var_13_0 = string.reverse(arg_13_0)
	local var_13_1 = string.reverse(arg_13_1)

	if string.find(var_13_0, var_13_1) ~= 1 then
		return false
	else
		return true
	end
end

function var_0_0.getReverseArrTab(arg_14_0)
	if not arg_14_0 or not var_0_0.isTable(arg_14_0) then
		return arg_14_0
	end

	local var_14_0 = {}

	for iter_14_0 = #arg_14_0, 1, -1 do
		table.insert(var_14_0, arg_14_0[iter_14_0])
	end

	return var_14_0
end

function var_0_0.stringToVector3(arg_15_0)
	local var_15_0 = string.split(string.gsub(string.gsub(arg_15_0, "%[", ""), "%]", ""), ",")
	local var_15_1 = {}

	for iter_15_0 = 1, #var_15_0 do
		table.insert(var_15_1, tonumber(var_15_0[iter_15_0]))
	end

	return var_15_1
end

function var_0_0.pairsByKeys(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		var_16_0[#var_16_0 + 1] = iter_16_0
	end

	table.sort(var_16_0)

	local var_16_1 = 0

	return function()
		var_16_1 = var_16_1 + 1

		return var_16_0[var_16_1], arg_16_0[var_16_0[var_16_1]]
	end
end

function var_0_0.deepCopy(arg_18_0)
	local var_18_0 = {}

	local function var_18_1(arg_19_0)
		if type(arg_19_0) ~= "table" then
			return arg_19_0
		end

		local var_19_0 = {}

		var_18_0[arg_19_0] = var_19_0

		for iter_19_0, iter_19_1 in pairs(arg_19_0) do
			var_19_0[var_18_1(iter_19_0)] = var_18_1(iter_19_1)
		end

		return setmetatable(var_19_0, getmetatable(arg_19_0))
	end

	return var_18_1(arg_18_0)
end

function var_0_0.deepCopyNoMeta(arg_20_0)
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

		return var_21_0
	end

	return var_20_1(arg_20_0)
end

function var_0_0.deepCopySimple(arg_22_0)
	if type(arg_22_0) ~= "table" then
		return arg_22_0
	else
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in pairs(arg_22_0) do
			var_22_0[iter_22_0] = var_0_0.deepCopySimple(iter_22_1)
		end

		return var_22_0
	end
end

function var_0_0.luaHotUpdate(arg_23_0)
	local var_23_0 = moduleNameToTables[arg_23_0]

	moduleNameToTables[arg_23_0] = nil
	package.loaded[moduleNameToPath[arg_23_0]] = nil

	setGlobal(arg_23_0, nil)

	if var_23_0 and var_23_0.instance then
		local var_23_1 = _G[arg_23_0]

		for iter_23_0, iter_23_1 in pairs(var_23_0.instance) do
			if type(iter_23_1) ~= "function" or not var_23_1.instance[iter_23_0] then
				var_23_1.instance[iter_23_0] = iter_23_1
			end
		end
	end

	print(arg_23_0, "======hot update finish!")
end

function var_0_0.replaceSpace(arg_24_0, arg_24_1)
	if string.nilorempty(arg_24_0) or not arg_24_1 and LangSettings.instance:isEn() then
		return arg_24_0
	end

	return string.gsub(arg_24_0, " ", " ")
end

function var_0_0.updateTMPRectHeight_LayoutElement(arg_25_0)
	local var_25_0 = gohelper.onceAddComponent(arg_25_0.gameObject, typeof(UnityEngine.UI.LayoutElement))

	arg_25_0:ForceMeshUpdate(true, true)

	var_25_0.preferredHeight = arg_25_0:GetRenderedValues().y
end

function var_0_0.updateTMPRectHeight(arg_26_0)
	arg_26_0:ForceMeshUpdate(true, true)

	local var_26_0 = arg_26_0:GetRenderedValues()

	recthelper.setHeight(arg_26_0.rectTransform, var_26_0.y)
end

function var_0_0.mergeTable(arg_27_0, ...)
	local var_27_0 = {
		...
	}

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1 then
			for iter_27_2, iter_27_3 in pairs(iter_27_1) do
				table.insert(arg_27_0, iter_27_3)
			end
		end
	end

	return arg_27_0
end

function var_0_0.insertDict(arg_28_0, arg_28_1)
	if not arg_28_1 then
		return
	end

	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		table.insert(arg_28_0, iter_28_1)
	end
end

function var_0_0.tableContains(arg_29_0, arg_29_1)
	if not arg_29_0 then
		return false
	end

	for iter_29_0, iter_29_1 in pairs(arg_29_0) do
		if iter_29_1 == arg_29_1 then
			return true
		end
	end

	return false
end

function var_0_0.indexOfElement(arg_30_0, arg_30_1)
	if not arg_30_0 then
		return -1
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0) do
		if iter_30_1 == arg_30_1 then
			return iter_30_0
		end
	end

	return -1
end

function var_0_0.tableToDictionary(arg_31_0)
	local var_31_0 = System.Collections.Generic.Dictionary_string_object.New()

	if arg_31_0 then
		for iter_31_0, iter_31_1 in pairs(arg_31_0) do
			var_31_0:Add(iter_31_0, iter_31_1)
		end
	end

	return var_31_0
end

function var_0_0.subString(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0
	local var_32_1 = 1
	local var_32_2 = -1
	local var_32_3 = 0
	local var_32_4 = 0

	arg_32_1 = math.max(arg_32_1, 1)
	arg_32_2 = arg_32_2 or -1

	while string.len(var_32_0) > 0 do
		if var_32_3 == arg_32_1 - 1 then
			var_32_1 = var_32_4 + 1
		elseif var_32_3 == arg_32_2 then
			var_32_2 = var_32_4

			break
		end

		var_32_4 = var_32_4 + var_0_0.GetBytes(var_32_0)
		var_32_0 = string.sub(arg_32_0, var_32_4 + 1)
		var_32_3 = var_32_3 + 1
	end

	return string.sub(arg_32_0, var_32_1, var_32_2)
end

function var_0_0.GetBytes(arg_33_0)
	if not arg_33_0 then
		return 0
	end

	local var_33_0 = string.byte(arg_33_0)

	if var_33_0 < 127 then
		return 1
	elseif var_33_0 <= 223 then
		return 2
	elseif var_33_0 <= 239 then
		return 3
	elseif var_33_0 <= 247 then
		return 4
	else
		return 0
	end
end

function var_0_0.tableNotEmpty(arg_34_0)
	if not arg_34_0 then
		return false
	end

	if not var_0_0.isTable(arg_34_0) then
		return false
	end

	return next(arg_34_0) ~= nil
end

function var_0_0.fractionAddition(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_1

	if arg_35_1 ~= arg_35_3 then
		var_35_0 = arg_35_1 * arg_35_3
		arg_35_0 = arg_35_0 * arg_35_3
		arg_35_2 = arg_35_2 * arg_35_1
	end

	return arg_35_0 + arg_35_2, var_35_0
end

function var_0_0.divisionOperation2Fraction(arg_36_0, arg_36_1)
	local var_36_0, var_36_1 = var_0_0.float2Fraction(arg_36_0)
	local var_36_2, var_36_3 = var_0_0.float2Fraction(arg_36_1)

	return var_36_0 * var_36_3, var_36_1 * var_36_2
end

function var_0_0.float2Fraction(arg_37_0)
	local var_37_0, var_37_1 = math.modf(arg_37_0)
	local var_37_2 = var_37_0
	local var_37_3 = 1

	if var_37_1 ~= 0 then
		local var_37_4 = #tostring(var_37_1) - 2

		var_37_2, var_37_3 = var_0_0.fractionAddition(var_37_2, var_37_3, math.abs(var_37_1 * 10 * var_37_4), var_37_4 * 10)
	end

	return var_37_2, var_37_3
end

function var_0_0.full2HalfWidth(arg_38_0)
	local var_38_0 = {}

	for iter_38_0 in arg_38_0:gmatch("[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if iter_38_0:byte(3) then
			local var_38_1 = iter_38_0:byte(2) * 64 + iter_38_0:byte(3) - 12193 + 65

			if var_38_1 > 32 and var_38_1 < 126 then
				table.insert(var_38_0, string.char(var_38_1))
			else
				table.insert(var_38_0, iter_38_0)
			end
		else
			table.insert(var_38_0, iter_38_0)
		end
	end

	return table.concat(var_38_0)
end

return var_0_0
