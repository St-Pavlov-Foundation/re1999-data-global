module("modules.common.utils.LuaUtil", package.seeall)

return {
	emptyStr = "",
	isFunction = function (slot0)
		return type(slot0) == "function"
	end,
	isTable = function (slot0)
		return type(slot0) == "table"
	end,
	isNumber = function (slot0)
		return type(slot0) == "number"
	end,
	isString = function (slot0)
		return type(slot0) == "string"
	end,
	isBoolean = function (slot0)
		return type(slot0) == "boolean"
	end,
	numToBoolean = function (slot0)
		if not slot0 or type(slot0) ~= "number" then
			logError("请输入正确的数字！")

			return
		end

		return slot0 ~= 0 and true or false
	end,
	isEmptyStr = function (slot0)
		if slot0 == nil then
			return true
		end

		return uv0.isString(slot0) and string.gsub(slot0, "^%s*(.-)%s*$", "%1") == uv0.emptyStr
	end,
	getStrLen = function (slot0)
		if uv0.isEmptyStr(slot0) then
			return 0
		end

		for slot6 = 1, #slot0 do
			if string.byte(slot0, slot6) > 0 and slot7 <= 127 then
				slot2 = 0 + 1
			elseif slot7 >= 192 and slot7 <= 239 then
				slot2 = slot2 + 2
				slot6 = slot6 + 2
			end
		end

		return slot2
	end,
	getChineseLen = function (slot0)
		if uv0.isEmptyStr(slot0) then
			return 0
		end

		for slot6 = 1, #slot0 do
			if string.byte(slot0, slot6) >= 192 and slot7 <= 239 then
				slot2 = 0 + 1
				slot6 = slot6 + 2
			end
		end

		return slot2
	end,
	getCharNum = function (slot0)
		if uv0.isEmptyStr(slot0) then
			return 0
		end

		for slot6 = 1, #slot0 do
			if string.byte(slot0, slot6) > 0 and slot7 <= 127 then
				slot2 = 0 + 1
			elseif slot7 >= 192 and slot7 <= 239 then
				slot2 = slot2 + 1
				slot6 = slot6 + 2
			end
		end

		return slot2
	end,
	getUCharArr = function (slot0)
		if uv0.isEmptyStr(slot0) then
			return
		end

		slot1 = {}

		for slot5 in string.gmatch(slot0, "[%z-\\xc2-\\xf4][\\x80-\\xbf ]*") do
			if not uv0.isEmptyStr(slot5) then
				table.insert(slot1, slot5)
			end
		end

		return slot1
	end,
	strEndswith = function (slot0, slot1)
		if slot0 == nil or slot1 == nil then
			return nil, "the string or the sub-string parameter is nil"
		end

		if string.find(string.reverse(slot0), string.reverse(slot1)) ~= 1 then
			return false
		else
			return true
		end
	end,
	getReverseArrTab = function (slot0)
		if not slot0 or not uv0.isTable(slot0) then
			return slot0
		end

		slot1 = {}

		for slot5 = #slot0, 1, -1 do
			table.insert(slot1, slot0[slot5])
		end

		return slot1
	end,
	stringToVector3 = function (slot0)
		slot6 = ""
		slot2 = {}

		for slot6 = 1, #string.split(string.gsub(string.gsub(slot0, "%[", slot6), "%]", ""), ",") do
			table.insert(slot2, tonumber(slot1[slot6]))
		end

		return slot2
	end,
	pairsByKeys = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[#slot1 + 1] = slot5
		end

		table.sort(slot1)

		slot2 = 0

		return function ()
			uv0 = uv0 + 1

			return uv1[uv0], uv2[uv1[uv0]]
		end
	end,
	deepCopy = function (slot0)
		slot1 = {}

		return function (slot0)
			if type(slot0) ~= "table" then
				return slot0
			end

			uv0[slot0] = {}

			for slot5, slot6 in pairs(slot0) do
				slot1[uv1(slot5)] = uv1(slot6)
			end

			return setmetatable(slot1, getmetatable(slot0))
		end(slot0)
	end,
	deepCopyNoMeta = function (slot0)
		slot1 = {}

		return function (slot0)
			if type(slot0) ~= "table" then
				return slot0
			end

			uv0[slot0] = {}

			for slot5, slot6 in pairs(slot0) do
				slot1[uv1(slot5)] = uv1(slot6)
			end

			return slot1
		end(slot0)
	end,
	deepCopySimple = function (slot0)
		if type(slot0) ~= "table" then
			return slot0
		else
			for slot5, slot6 in pairs(slot0) do
				-- Nothing
			end

			return {
				[slot5] = uv0.deepCopySimple(slot6)
			}
		end
	end,
	luaHotUpdate = function (slot0)
		moduleNameToTables[slot0] = nil
		package.loaded[moduleNameToPath[slot0]] = nil

		setGlobal(slot0, nil)

		if moduleNameToTables[slot0] and slot1.instance then
			slot2 = _G[slot0]

			for slot6, slot7 in pairs(slot1.instance) do
				if type(slot7) ~= "function" or not slot2.instance[slot6] then
					slot2.instance[slot6] = slot7
				end
			end
		end

		print(slot0, "======hot update finish!")
	end,
	replaceSpace = function (slot0)
		if string.nilorempty(slot0) then
			return slot0
		end

		return string.gsub(slot0, " ", " ")
	end,
	mergeTable = function (slot0, ...)
		for slot5, slot6 in pairs({
			...
		}) do
			if slot6 then
				for slot10, slot11 in pairs(slot6) do
					table.insert(slot0, slot11)
				end
			end
		end

		return slot0
	end,
	insertDict = function (slot0, slot1)
		if not slot1 then
			return
		end

		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0, slot6)
		end
	end,
	tableContains = function (slot0, slot1)
		if not slot0 then
			return false
		end

		for slot5, slot6 in pairs(slot0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end,
	indexOfElement = function (slot0, slot1)
		if not slot0 then
			return -1
		end

		for slot5, slot6 in pairs(slot0) do
			if slot6 == slot1 then
				return slot5
			end
		end

		return -1
	end,
	tableToDictionary = function (slot0)
		slot1 = System.Collections.Generic.Dictionary_string_object.New()

		if slot0 then
			for slot5, slot6 in pairs(slot0) do
				slot1:Add(slot5, slot6)
			end
		end

		return slot1
	end,
	subString = function (slot0, slot1, slot2)
		slot3 = slot0
		slot4 = 1
		slot5 = -1
		slot6 = 0
		slot7 = 0
		slot1 = math.max(slot1, 1)
		slot2 = slot2 or -1

		while string.len(slot3) > 0 do
			if slot6 == slot1 - 1 then
				slot4 = slot7 + 1
			elseif slot6 == slot2 then
				slot5 = slot7

				break
			end

			slot3 = string.sub(slot0, slot7 + uv0.GetBytes(slot3) + 1)
			slot6 = slot6 + 1
		end

		return string.sub(slot0, slot4, slot5)
	end,
	GetBytes = function (slot0)
		if not slot0 then
			return 0
		end

		if string.byte(slot0) < 127 then
			return 1
		elseif slot1 <= 223 then
			return 2
		elseif slot1 <= 239 then
			return 3
		elseif slot1 <= 247 then
			return 4
		else
			return 0
		end
	end,
	tableNotEmpty = function (slot0)
		if not slot0 then
			return false
		end

		if not uv0.isTable(slot0) then
			return false
		end

		return next(slot0) ~= nil
	end,
	fractionAddition = function (slot0, slot1, slot2, slot3)
		slot4 = slot1

		if slot1 ~= slot3 then
			slot4 = slot1 * slot3
			slot0 = slot0 * slot3
			slot2 = slot2 * slot1
		end

		return slot0 + slot2, slot4
	end,
	divisionOperation2Fraction = function (slot0, slot1)
		slot2, slot3 = uv0.float2Fraction(slot0)
		slot4, slot5 = uv0.float2Fraction(slot1)

		return slot2 * slot5, slot3 * slot4
	end,
	float2Fraction = function (slot0)
		slot3, slot2 = math.modf(slot0)

		if slot2 ~= 0 then
			slot5 = #tostring(slot2) - 2
			slot3, slot4 = uv0.fractionAddition(slot3, 1, math.abs(slot2 * 10 * slot5), slot5 * 10)
		end

		return slot3, slot4
	end,
	full2HalfWidth = function (slot0)
		slot1 = {}

		for slot5 in slot0:gmatch("[%z-\\xc2-\\xf4][\\x80-\\xbf]*") do
			if slot5:byte(3) then
				if slot5:byte(2) * 64 + slot5:byte(3) - 12193 + 65 > 32 and slot6 < 126 then
					table.insert(slot1, string.char(slot6))
				else
					table.insert(slot1, slot5)
				end
			else
				table.insert(slot1, slot5)
			end
		end

		return table.concat(slot1)
	end
}
