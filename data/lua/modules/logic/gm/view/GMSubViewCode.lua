module("modules.logic.gm.view.GMSubViewCode", package.seeall)

local var_0_0 = class("GMSubViewCode", GMSubViewBase)

function var_0_0.onOpen(arg_1_0)
	arg_1_0:addSubViewGo("代码")
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local var_0_1 = tolua.findtype("UnityEngine.UI.InputField+LineType")
local var_0_2 = System.Enum.Parse(var_0_1, "MultiLineNewline")
local var_0_3 = "GMSubViewCode_Save"

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_2_0)
	arg_2_0:addTitleSplitLine("输入代码")

	arg_2_0._input = arg_2_0:addInputText("L1", "", "输入代码", nil, nil, {
		w = 1400,
		h = 700
	})
	arg_2_0._input.inputField.lineType = var_0_2

	arg_2_0._input:SetText(PlayerPrefsHelper.getString(var_0_3, ""))

	arg_2_0._btnExecute = arg_2_0:addButton("L2", "执行", arg_2_0.executeCode, arg_2_0)
	arg_2_0._toggleIsAutoClose = arg_2_0:addToggle("L2", "是否执行完关闭GM面板")

	arg_2_0:addTitleSplitLine("Tab 开关")

	local var_2_0 = arg_2_0.viewContainer._views or {}
	local var_2_1 = {}

	arg_2_0._tabNames = var_2_1
	arg_2_0._tabToggles = arg_2_0:getUserDataTb_()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		if type(iter_2_1.tabName) == "string" then
			table.insert(var_2_1, iter_2_1.tabName)
		end
	end

	local var_2_2 = PlayerPrefsHelper.getString("GMHideTabNames", "")
	local var_2_3 = {}

	if not string.nilorempty(var_2_2) then
		var_2_3 = string.split(var_2_2, "#")
	end

	for iter_2_2 = 1, math.ceil(#var_2_1 / 6) do
		for iter_2_3 = 1, 6 do
			local var_2_4 = (iter_2_2 - 1) * 6 + iter_2_3

			if var_2_1[var_2_4] then
				local var_2_5 = arg_2_0:addToggle("Line" .. iter_2_2, var_2_1[var_2_4], arg_2_0.tabChange, arg_2_0)

				table.insert(arg_2_0._tabToggles, var_2_5)

				var_2_5.isOn = not tabletool.indexOf(var_2_3, var_2_1[var_2_4])
			else
				break
			end
		end
	end
end

function var_0_0.tabChange(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0._tabToggles) do
		if not iter_3_1.isOn then
			table.insert(var_3_0, arg_3_0._tabNames[iter_3_0])
		end
	end

	PlayerPrefsHelper.setString("GMHideTabNames", table.concat(var_3_0, "#"))
end

function var_0_0.executeCode(arg_4_0)
	local var_4_0 = arg_4_0._input:GetText()

	PlayerPrefsHelper.setString(var_0_3, var_4_0)

	local var_4_1 = loadstring(var_4_0)

	if var_4_1 then
		var_4_1()
	end

	if arg_4_0._toggleIsAutoClose.isOn then
		arg_4_0:closeThis()
	end
end

return var_0_0
