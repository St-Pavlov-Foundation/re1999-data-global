module("booter.base.string", package.seeall)

local var_0_0 = {
	_htmlspecialchars_set = {}
}

var_0_0._htmlspecialchars_set["&"] = "&amp;"
var_0_0._htmlspecialchars_set["\""] = "&quot;"
var_0_0._htmlspecialchars_set["'"] = "&#039;"
var_0_0._htmlspecialchars_set["<"] = "&lt;"
var_0_0._htmlspecialchars_set[">"] = "&gt;"

function var_0_0.nilorempty(arg_1_0)
	return arg_1_0 == nil or var_0_0.len(arg_1_0) == 0
end

function var_0_0.htmlspecialchars(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(var_0_0._htmlspecialchars_set) do
		arg_2_0 = var_0_0.gsub(arg_2_0, iter_2_0, iter_2_1)
	end

	return arg_2_0
end

function var_0_0.restorehtmlspecialchars(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(var_0_0._htmlspecialchars_set) do
		arg_3_0 = var_0_0.gsub(arg_3_0, iter_3_1, iter_3_0)
	end

	return arg_3_0
end

function var_0_0.nl2br(arg_4_0)
	return var_0_0.gsub(arg_4_0, "\n", "<br />")
end

function var_0_0.text2html(arg_5_0)
	arg_5_0 = var_0_0.gsub(arg_5_0, "\t", "    ")
	arg_5_0 = var_0_0.htmlspecialchars(arg_5_0)
	arg_5_0 = var_0_0.gsub(arg_5_0, " ", "&nbsp;")
	arg_5_0 = var_0_0.nl2br(arg_5_0)

	return arg_5_0
end

function var_0_0.split(arg_6_0, arg_6_1)
	arg_6_0 = tostring(arg_6_0)
	arg_6_1 = tostring(arg_6_1)

	if arg_6_1 == "" then
		return false
	end

	local var_6_0 = 0
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in function()
		return var_0_0.find(arg_6_0, arg_6_1, var_6_0, true)
	end do
		table.insert(var_6_1, var_0_0.sub(arg_6_0, var_6_0, iter_6_0 - 1))

		var_6_0 = iter_6_1 + 1
	end

	table.insert(var_6_1, var_0_0.sub(arg_6_0, var_6_0))

	return var_6_1
end

function var_0_0.splitToNumber(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(var_0_0.split(arg_8_0, arg_8_1)) do
		var_8_0[iter_8_0] = tonumber(iter_8_1)
	end

	return var_8_0
end

function var_0_0.splitToVector2(arg_9_0, arg_9_1)
	if arg_9_0 == nil or arg_9_1 == nil then
		return nil
	end

	local var_9_0 = var_0_0.split(arg_9_0, arg_9_1)

	if #var_9_0 == 2 then
		return Vector2.New(var_9_0[1], var_9_0[2])
	end

	return nil
end

function var_0_0.splitToVector3(arg_10_0, arg_10_1)
	if arg_10_0 == nil or arg_10_1 == nil then
		return nil
	end

	local var_10_0 = var_0_0.split(arg_10_0, arg_10_1)

	if #var_10_0 == 3 then
		return Vector3.New(var_10_0[1], var_10_0[2], var_10_0[3])
	end

	return nil
end

function var_0_0.trim(arg_11_0)
	return (var_0_0.gsub(arg_11_0, "^%s*(.-)%s*$", "%1"))
end

function var_0_0.ucfirst(arg_12_0)
	return var_0_0.upper(var_0_0.sub(arg_12_0, 1, 1)) .. var_0_0.sub(arg_12_0, 2)
end

local function var_0_1(arg_13_0)
	return "%" .. var_0_0.format("%02X", var_0_0.byte(arg_13_0))
end

function var_0_0.urlencode(arg_14_0)
	arg_14_0 = var_0_0.gsub(tostring(arg_14_0), "\n", "\r\n")
	arg_14_0 = var_0_0.gsub(arg_14_0, "([^%w%.%- ])", var_0_1)

	return var_0_0.gsub(arg_14_0, " ", "+")
end

function var_0_0.urldecode(arg_15_0)
	arg_15_0 = var_0_0.gsub(arg_15_0, "+", " ")
	arg_15_0 = var_0_0.gsub(arg_15_0, "%%(%x%x)", function(arg_16_0)
		return var_0_0.char(checknumber(arg_16_0, 16))
	end)
	arg_15_0 = var_0_0.gsub(arg_15_0, "\r\n", "\n")

	return arg_15_0
end

function var_0_0.utf8len(arg_17_0)
	local var_17_0 = var_0_0.len(arg_17_0)
	local var_17_1 = 0
	local var_17_2 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while var_17_0 ~= 0 do
		local var_17_3 = var_0_0.byte(arg_17_0, -var_17_0)
		local var_17_4 = #var_17_2

		while var_17_2[var_17_4] do
			if var_17_3 >= var_17_2[var_17_4] then
				var_17_0 = var_17_0 - var_17_4

				break
			end

			var_17_4 = var_17_4 - 1
		end

		var_17_1 = var_17_1 + 1
	end

	return var_17_1
end

function var_0_0.formatnumberthousands(arg_18_0)
	local var_18_0 = tostring(checknumber(arg_18_0))
	local var_18_1

	repeat
		local var_18_2

		var_18_0, var_18_2 = var_0_0.gsub(var_18_0, "^(-?%d+)(%d%d%d)", "%1,%2")
	until var_18_2 == 0

	return var_18_0
end

function var_0_0.getValueByType(arg_19_0, arg_19_1)
	if arg_19_1 == "string" then
		return arg_19_0
	elseif arg_19_1 == "number" then
		return tonumber(arg_19_0)
	elseif arg_19_1 == "boolean" then
		return arg_19_0 == "1" or var_0_0.lower(arg_19_0) == "true"
	end
end

function var_0_0.getFirstNum(arg_20_0)
	local var_20_0 = var_0_0.len(arg_20_0)
	local var_20_1
	local var_20_2

	for iter_20_0 = 1, var_20_0 do
		local var_20_3 = var_0_0.sub(arg_20_0, iter_20_0, iter_20_0)
		local var_20_4 = tonumber(var_20_3)

		if var_20_4 then
			if var_20_1 then
				var_20_1 = var_20_1 * 10 + var_20_4
			else
				var_20_1 = var_20_4
			end
		elseif var_20_1 then
			break
		end
	end

	return var_20_1
end

function var_0_0.getLastNum(arg_21_0)
	local var_21_0 = var_0_0.len(arg_21_0)
	local var_21_1
	local var_21_2
	local var_21_3 = 1

	for iter_21_0 = var_21_0, 1, -1 do
		local var_21_4 = var_0_0.sub(arg_21_0, iter_21_0, iter_21_0)
		local var_21_5 = tonumber(var_21_4)

		if var_21_5 then
			if var_21_1 then
				var_21_1 = var_21_5 * var_21_3 + var_21_1
			else
				var_21_1 = var_21_5
			end

			var_21_3 = var_21_3 * 10
		elseif var_21_1 then
			break
		end
	end

	return var_21_1
end

setmetatable(var_0_0, {
	__index = _G.string
})
setGlobal("string", var_0_0)

return var_0_0
