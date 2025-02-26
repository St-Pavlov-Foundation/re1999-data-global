module("modules.logic.gm.view.GMSubViewCode", package.seeall)

slot0 = class("GMSubViewCode", GMSubViewBase)

function slot0.onOpen(slot0)
	slot0:addSubViewGo("代码")
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

slot2 = System.Enum.Parse(tolua.findtype("UnityEngine.UI.InputField+LineType"), "MultiLineNewline")
slot3 = "GMSubViewCode_Save"

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)
	slot0:addTitleSplitLine("输入代码")

	slot0._input = slot0:addInputText("L1", "", "输入代码", nil, , {
		w = 1400,
		h = 700
	})
	slot0._input.inputField.lineType = uv0

	slot0._input:SetText(PlayerPrefsHelper.getString(uv1, ""))

	slot0._btnExecute = slot0:addButton("L2", "执行", slot0.executeCode, slot0)
	slot0._toggleIsAutoClose = slot0:addToggle("L2", "是否执行完关闭GM面板")

	slot0:addTitleSplitLine("Tab 开关")

	slot0._tabNames = {}
	slot0._tabToggles = slot0:getUserDataTb_()

	for slot6, slot7 in pairs(slot0.viewContainer._views or {}) do
		if type(slot7.tabName) == "string" then
			table.insert(slot2, slot7.tabName)
		end
	end

	slot4 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString("GMHideTabNames", "")) then
		slot4 = string.split(slot3, "#")
	end

	for slot8 = 1, math.ceil(#slot2 / 6) do
		for slot12 = 1, 6 do
			if slot2[(slot8 - 1) * 6 + slot12] then
				slot14 = slot0:addToggle("Line" .. slot8, slot2[slot13], slot0.tabChange, slot0)

				table.insert(slot0._tabToggles, slot14)

				slot14.isOn = not tabletool.indexOf(slot4, slot2[slot13])
			else
				break
			end
		end
	end
end

function slot0.tabChange(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._tabToggles) do
		if not slot6.isOn then
			table.insert(slot1, slot0._tabNames[slot5])
		end
	end

	PlayerPrefsHelper.setString("GMHideTabNames", table.concat(slot1, "#"))
end

function slot0.executeCode(slot0)
	slot1 = slot0._input:GetText()

	PlayerPrefsHelper.setString(uv0, slot1)

	if loadstring(slot1) then
		slot2()
	end

	if slot0._toggleIsAutoClose.isOn then
		slot0:closeThis()
	end
end

return slot0
