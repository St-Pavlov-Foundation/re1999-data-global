module("modules.logic.gm.view.Checker_Base", package.seeall)

local var_0_0 = class("Checker_Base")

var_0_0.Color = {
	Blue = "#0000FF",
	Green = "#00FF00",
	Red = "#FF0000",
	Yellow = "#FFFF00",
	White = "#FFFFFF"
}

function var_0_0.makeColorStr(arg_1_0, arg_1_1, arg_1_2)
	return gohelper.getRichColorText(tostring(arg_1_1), arg_1_2 or "#FFFFFF")
end

function var_0_0.ctor(arg_2_0)
	arg_2_0:clearAll()
end

function var_0_0.clearAll(arg_3_0)
	arg_3_0._strBuilder = {}
	arg_3_0._indentCount = 0
	arg_3_0._stackIndent = {}
	arg_3_0._stackMarkLineIndex = {}
end

function var_0_0.lineCount(arg_4_0)
	return #arg_4_0._strBuilder
end

function var_0_0.addIndent(arg_5_0)
	arg_5_0._indentCount = arg_5_0._indentCount + 1
end

function var_0_0.subIndent(arg_6_0)
	arg_6_0._indentCount = arg_6_0._indentCount - 1
end

function var_0_0.pushIndent(arg_7_0)
	table.insert(arg_7_0._stackIndent, arg_7_0._indentCount)

	arg_7_0._indentCount = 0
end

function var_0_0.popIndent(arg_8_0)
	assert(#arg_8_0._stackIndent > 0, "[popIndent] invalid stack balance!")

	arg_8_0._indentCount = table.remove(arg_8_0._stackIndent)
end

function var_0_0.pushMarkLine(arg_9_0)
	table.insert(arg_9_0._stackMarkLineIndex, arg_9_0:lineCount())
end

function var_0_0.popMarkLine(arg_10_0)
	assert(#arg_10_0._stackMarkLineIndex > 0, "[popMarkLine]invalid stack balance!")

	return table.remove(arg_10_0._stackMarkLineIndex)
end

function var_0_0.appendWithIndex(arg_11_0, arg_11_1, arg_11_2)
	assert(tonumber(arg_11_2) ~= nil)

	local var_11_0 = arg_11_0:lineCount()
	local var_11_1

	if arg_11_2 <= 0 or var_11_0 < arg_11_2 then
		var_11_1 = arg_11_0:_validateValue(arg_11_1)
	else
		var_11_1 = arg_11_0._strBuilder[arg_11_2] .. arg_11_0:_validateValue(arg_11_1)
	end

	arg_11_0._strBuilder[arg_11_2] = var_11_1
end

function var_0_0.append(arg_12_0, arg_12_1)
	local var_12_0 = math.max(1, arg_12_0:lineCount())

	arg_12_0:appendWithIndex(arg_12_1, var_12_0)
end

function var_0_0.appendLine(arg_13_0, arg_13_1)
	table.insert(arg_13_0._strBuilder, arg_13_0:_validateValue(arg_13_1))
end

function var_0_0.insertLine(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = GameUtil.clamp(arg_14_1, 1, arg_14_0:lineCount())

	table.insert(arg_14_0._strBuilder, arg_14_0:_validateValue(arg_14_2), arg_14_1)
end

function var_0_0.appendRange(arg_15_0, arg_15_1)
	if not arg_15_1 or #arg_15_1 == 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		arg_15_0:appendLine(iter_15_1)
	end
end

function var_0_0.move(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_1._strBuilder

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		arg_16_0:appendLine(iter_16_1)
	end

	arg_16_1._strBuilder = {}
end

function var_0_0.tostring(arg_17_0)
	return table.concat(arg_17_0._strBuilder, "\n")
end

function var_0_0._indentStr(arg_18_0)
	if arg_18_0._indentCount <= 0 then
		return ""
	end

	return string.rep("\t", arg_18_0._indentCount)
end

function var_0_0._validateValue(arg_19_0, arg_19_1)
	return arg_19_0:_indentStr() .. tostring(arg_19_1)
end

function var_0_0.log(arg_20_0)
	logNormal(arg_20_0:tostring())
end

return var_0_0
