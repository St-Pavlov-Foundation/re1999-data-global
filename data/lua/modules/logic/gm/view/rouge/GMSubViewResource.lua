module("modules.logic.gm.view.rouge.GMSubViewResource", package.seeall)

slot0 = class("GMSubViewResource", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "资源"
end

function slot0.addLineIndex(slot0)
	slot0.lineIndex = slot0.lineIndex + 1
end

function slot0.getLineGroup(slot0)
	return "L" .. slot0.lineIndex
end

function slot0.addFilterVerticalGroup(slot0, slot1)
	slot0.verticalId = slot0.verticalId or 0
	slot0.verticalId = slot0.verticalId + 1
	slot3 = slot0:getUserDataTb_()

	for slot7 = 1, slot1 do
		table.insert(slot3, slot0:addVerticalInput(slot0:addVerticalGroup(slot0:getLineGroup(), slot0.verticalId, uv0.FilterItemSize.Width, slot0.filterGroupHeight), "", "正则表达式"))
	end

	return slot3
end

slot0.FilterItemSize = {
	Height = 80,
	Width = 500
}

function slot0.addVerticalInput(slot0, slot1, slot2, slot3)
	slot4 = gohelper.clone(slot0._goInputTextTemplate, slot1, "InputText")

	gohelper.setActive(slot4, true)
	slot0._setFontSize(gohelper.findChildText(slot4, "Text"), nil, 30)
	slot0._setRectTransSize(slot4, nil, uv0.FilterItemSize.Width, uv0.FilterItemSize.Height)

	SLFramework.UGUI.InputFieldWrap.Get(slot4).inputField.lineType = System.Enum.Parse(tolua.findtype("UnityEngine.UI.InputField+LineType"), "MultiLineSubmit")
	gohelper.findChildText(slot4, "Placeholder").text = slot3 or ""

	slot7:SetText(slot2 or "")
	slot7:AddOnValueChanged(slot0.onInputFilterValueChange, slot0)

	slot0._inputTexts[#slot0._inputTexts + 1] = slot7

	return slot7
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	slot0.lineIndex = 1
	slot4 = slot0:getLineGroup()
	slot5 = "开启资源慢加载"
	slot0.startToggle = slot0:addToggle(slot4, slot5, slot0.onStartToggleChange, slot0)
	slot0.strategyList = {
		DelayLoadResMgr.DelayStrategyEnum.Multiple,
		DelayLoadResMgr.DelayStrategyEnum.Fixed
	}
	slot0.strategyNameList = {}

	for slot4, slot5 in ipairs(slot0.strategyList) do
		table.insert(slot0.strategyNameList, DelayLoadResMgr.DelayStrategyName[slot5])
	end

	slot0.strategyDrop = slot0:addDropDown(slot0:getLineGroup(), "延时策略", slot0.strategyNameList, slot0.onStrategyDropValueChange, slot0)
	slot0.strategyInput = slot0:addInputText(slot0:getLineGroup(), "", "延迟数值", slot0.onStrategyInputValueChange, slot0)

	slot0:addLineIndex()
	slot0:addLabel(slot0:getLineGroup(), "默认全部文件都会开开启慢加载，如果设置了任意'启用慢加载'， 那么只有匹配的文件才会启用慢加载。'禁用慢加载文件'优先级最高", {
		w = 1200,
		fsize = 25,
		h = 160
	})
	slot0:addLineIndex()

	slot0.filterGroupHeight = 500
	slot0.filterGroupHeight = 500
	slot1 = {
		w = 50,
		h = slot0.filterGroupHeight,
		align = TMPro.TextAlignmentOptions.Top
	}

	slot0:addHorizontalGroup(slot0:getLineGroup(), nil, slot0.filterGroupHeight)
	slot0:addLabel(slot0:getLineGroup(), "启用慢加载文件", slot1)

	slot0.enablePatternInputList = slot0:addFilterVerticalGroup(5)

	slot0:addLabel(slot0:getLineGroup(), "禁用慢加载文件", slot1)

	slot0.disablePatternInputList = slot0:addFilterVerticalGroup(5)

	slot0:initUIValue()
	uv0.super.initViewContent(slot0)
end

function slot0.initUIValue(slot0)
	slot0.startToggle.isOn = DelayLoadResMgr.instance:isStartDelayLoad()

	for slot5, slot6 in ipairs(slot0.strategyList) do
		if DelayLoadResMgr.instance:getDelayStrategy() == slot6 then
			slot0.strategyDrop:SetValue(slot5 - 1)
		end
	end

	slot6 = DelayLoadResMgr.instance:getDelayStrategyValue()

	slot0.strategyInput:SetText(slot6)

	slot0.enablePatternList = tabletool.copy(DelayLoadResMgr.instance:getEnablePatternList())
	slot5 = DelayLoadResMgr.instance
	slot7 = slot5
	slot0.disablePatternList = tabletool.copy(slot5.getDisablePatternList(slot7))

	for slot6, slot7 in ipairs(slot0.enablePatternList) do
		slot0.enablePatternInputList[slot6]:SetText(slot7)
	end

	for slot6, slot7 in ipairs(slot0.disablePatternList) do
		slot0.disablePatternInputList[slot6]:SetText(slot7)
	end
end

function slot0.onInputFilterValueChange(slot0)
	if not slot0._inited then
		return
	end

	for slot4, slot5 in ipairs(slot0.enablePatternInputList) do
		slot0.enablePatternList[slot4] = slot5:GetText()
	end

	for slot4, slot5 in ipairs(slot0.disablePatternInputList) do
		slot0.disablePatternList[slot4] = slot5:GetText()
	end

	DelayLoadResMgr.instance:setEnablePatternList(slot0.enablePatternList)
	DelayLoadResMgr.instance:setDisablePatternList(slot0.disablePatternList)
end

function slot0.onStartToggleChange(slot0)
	if not slot0._inited then
		return
	end

	if slot0.startToggle.isOn then
		DelayLoadResMgr.instance:startDelayLoad()
	else
		DelayLoadResMgr.instance:stopDelayLoad()
	end
end

function slot0.onStrategyDropValueChange(slot0, slot1)
	if not slot0._inited then
		return
	end

	DelayLoadResMgr.instance:setDelayStrategy(slot0.strategyList[slot1 + 1])
end

function slot0.onStrategyInputValueChange(slot0)
	if not slot0._inited then
		return
	end

	if not tonumber(slot0.strategyInput:GetText()) then
		return
	end

	DelayLoadResMgr.instance:setDelayStrategyValue(slot1)
end

return slot0
