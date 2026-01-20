-- chunkname: @modules/logic/gm/view/GMSubViewCode.lua

module("modules.logic.gm.view.GMSubViewCode", package.seeall)

local GMSubViewCode = class("GMSubViewCode", GMSubViewBase)

function GMSubViewCode:onOpen()
	self:addSubViewGo("代码")
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")
local MultiLineNewline = System.Enum.Parse(type_linetype, "MultiLineNewline")
local saveKey = "GMSubViewCode_Save"

function GMSubViewCode:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self:addTitleSplitLine("输入代码")

	self._input = self:addInputText("L1", "", "输入代码", nil, nil, {
		w = 1400,
		h = 700
	})
	self._input.inputField.lineType = MultiLineNewline

	self._input:SetText(PlayerPrefsHelper.getString(saveKey, ""))

	self._btnExecute = self:addButton("L2", "执行", self.executeCode, self)
	self._toggleIsAutoClose = self:addToggle("L2", "是否执行完关闭GM面板")

	self:addTitleSplitLine("Tab 开关")

	local allViews = self.viewContainer._views or {}
	local allTabNames = {}

	self._tabNames = allTabNames
	self._tabToggles = self:getUserDataTb_()

	for _, view in pairs(allViews) do
		if type(view.tabName) == "string" then
			table.insert(allTabNames, view.tabName)
		end
	end

	local str = PlayerPrefsHelper.getString("GMHideTabNames", "")
	local ignoreNames = {}

	if not string.nilorempty(str) then
		ignoreNames = string.split(str, "#")
	end

	for i = 1, math.ceil(#allTabNames / 6) do
		for j = 1, 6 do
			local index = (i - 1) * 6 + j

			if allTabNames[index] then
				local toggle = self:addToggle("Line" .. i, allTabNames[index], self.tabChange, self)

				table.insert(self._tabToggles, toggle)

				toggle.isOn = not tabletool.indexOf(ignoreNames, allTabNames[index])
			else
				break
			end
		end
	end
end

function GMSubViewCode:tabChange()
	local ignoreNames = {}

	for k, v in pairs(self._tabToggles) do
		if not v.isOn then
			table.insert(ignoreNames, self._tabNames[k])
		end
	end

	PlayerPrefsHelper.setString("GMHideTabNames", table.concat(ignoreNames, "#"))
end

function GMSubViewCode:executeCode()
	local txt = self._input:GetText()

	PlayerPrefsHelper.setString(saveKey, txt)

	local func = loadstring(txt)

	if func then
		func()
	end

	if self._toggleIsAutoClose.isOn then
		self:closeThis()
	end
end

return GMSubViewCode
