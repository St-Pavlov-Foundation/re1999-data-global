module("modules.common.utils.NumberCompressUtil", package.seeall)

local var_0_0 = {}
local var_0_1 = require("bit")
local var_0_2 = {
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"-",
	"/"
}
local var_0_3 = {}

for iter_0_0, iter_0_1 in pairs(var_0_2) do
	var_0_3[iter_0_1] = iter_0_0
end

function var_0_0.compress(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		var_1_0[iter_1_0] = var_0_0.numToStr(iter_1_1)
	end

	return table.concat(var_1_0, "#")
end

function var_0_0.decompress(arg_2_0)
	local var_2_0 = string.split(arg_2_0, "#")
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = var_0_0.strToNum(iter_2_1)

		if var_2_2 ~= 0 then
			table.insert(var_2_1, var_2_2)
		end
	end

	return var_2_1
end

function var_0_0.numToStr(arg_3_0)
	if type(arg_3_0) ~= "number" then
		return ""
	end

	local var_3_0 = ""

	while arg_3_0 > 0 do
		local var_3_1 = var_0_1.band(arg_3_0, 63)

		if not var_0_2[var_3_1 + 1] then
			logError("NumberCompressUtil.numToStr Error:" .. tostring(var_3_1))

			return ""
		end

		var_3_0 = var_0_2[var_3_1 + 1] .. var_3_0
		arg_3_0 = var_0_1.rshift(arg_3_0, 6)
	end

	return var_3_0
end

function var_0_0.strToNum(arg_4_0)
	if string.nilorempty(arg_4_0) then
		return 0
	end

	local var_4_0 = #arg_4_0
	local var_4_1 = 0

	for iter_4_0 = 1, var_4_0 do
		local var_4_2 = string.sub(arg_4_0, iter_4_0, iter_4_0)

		if not var_0_3[var_4_2] then
			logError("NumberCompressUtil.strToNum Error：" .. tostring(arg_4_0))

			return 0
		end

		var_4_1 = var_4_1 + var_0_1.lshift(var_0_3[var_4_2] - 1, (var_4_0 - iter_4_0) * 6)
	end

	return var_4_1
end

return var_0_0
