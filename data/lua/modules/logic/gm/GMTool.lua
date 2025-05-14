local var_0_0 = "Partial_GMTool"
local var_0_1 = _G.debug.getupvalue
local var_0_2 = _G.tostring
local var_0_3 = _G.tonumber
local var_0_4 = _G.assert
local var_0_5 = _G.string.find
local var_0_6 = _G.type
local var_0_7 = table.concat
local var_0_8 = "#00FF00"
local var_0_9 = "#FFFFFF"
local var_0_10 = "#FFFF00"

local function var_0_11(arg_1_0)
	UpdateBeat:Remove(arg_1_0._update, arg_1_0)

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if var_0_6(iter_1_1) == "table" and iter_1_1.onClear then
			iter_1_1:onClear()
			logNormal(iter_1_0 .. "<color=#00FF00> clear finished </color>")
		end
	end
end

local function var_0_12(arg_2_0, arg_2_1)
	if arg_2_0 ~= nil and var_0_6(arg_2_0) ~= "string" then
		arg_2_0 = var_0_2(arg_2_0)
	end

	if string.nilorempty(arg_2_0) then
		arg_2_0 = "[None]"
	end

	return gohelper.getRichColorText(arg_2_0, arg_2_1 or var_0_9)
end

local function var_0_13(arg_3_0)
	return arg_3_0 and var_0_12("true", var_0_8) or var_0_12("false", var_0_10)
end

local function var_0_14(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_4(arg_4_1)

	if arg_4_3 then
		var_0_4(var_0_3(arg_4_2) ~= nil)
	end

	for iter_4_0 = arg_4_2 or 1, arg_4_3 or math.huge do
		local var_4_0, var_4_1 = var_0_1(arg_4_0, iter_4_0)

		if not var_4_0 then
			break
		end

		if var_4_0 == arg_4_1 then
			return var_4_1
		end
	end
end

local function var_0_15(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_0) or string.nilorempty(arg_5_1) then
		return false
	end

	local var_5_0, var_5_1 = var_0_5(arg_5_0, arg_5_1)

	return var_5_0 == 1
end

local function var_0_16(arg_6_0, arg_6_1)
	if string.nilorempty(arg_6_0) or string.nilorempty(arg_6_1) then
		return false
	end

	local var_6_0 = #arg_6_0 - #arg_6_1 + 1

	if var_6_0 < 1 then
		return false
	end

	return arg_6_0:sub(var_6_0) == arg_6_1
end

local function var_0_17(arg_7_0)
	ZProj.UGUIHelper.CopyText(arg_7_0)
end

local function var_0_18()
	local var_8_0 = {}

	local function var_8_1(arg_9_0, arg_9_1)
		if not arg_9_1 then
			table.insert(var_8_0, arg_9_0)
		else
			table.insert(var_8_0, var_0_12(arg_9_0, var_0_8) .. ": " .. var_0_12(arg_9_1, var_0_10))
		end
	end

	var_8_1("================= (海外GM) 使用方式 =================")
	var_8_1("LCtrl(x2)", "                             可打印玩家信息")
	var_8_1("Ctrl + 鼠标左键 + 点击UI", "可查看UI最顶层点击到的节点路径")
	var_8_1("Ctrl + Alt + 4", "                            通关所有关卡")
	var_8_1("F12", "                                       退出登录")
	var_8_1("Ctrl + Alt + 3", "                      开/关资源加载耗时Log")
	var_8_1("Ctrl + Alt + 2", "                      查看正在打开的ViewNames")
	var_8_1("Ctrl + Alt + 1", "                      显示/隐藏LangKey")

	return var_0_7(var_8_0, "\n")
end

local var_0_19 = getGlobal(var_0_0)

if var_0_19 then
	logNormal("<color=#00FF00> hotfix finished </color>")
	var_0_11(var_0_19)
else
	logNormal("<color=#00FF00>Hello World!</color>\n" .. var_0_18())
end

local var_0_20 = var_0_19 or {}

setGlobal(var_0_0, var_0_20)

function var_0_20._update()
	var_0_20._accountDummper:onUpdate()
	var_0_20._input:onUpdate()
end

var_0_20.util = {
	setColorDesc = var_0_12,
	getUpvalue = var_0_14,
	startsWith = var_0_15,
	endsWith = var_0_16,
	colorBoolStr = var_0_13,
	saveClipboard = var_0_17
}

require("modules/logic/gm/GMTool__Input")
require("modules/logic/gm/GMTool__AccountDummper")
require("modules/logic/gm/GMTool__ViewHooker")
UpdateBeat:Add(var_0_20._update, var_0_20)

return {}
