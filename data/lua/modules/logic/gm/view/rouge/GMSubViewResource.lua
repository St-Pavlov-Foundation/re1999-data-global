module("modules.logic.gm.view.rouge.GMSubViewResource", package.seeall)

local var_0_0 = class("GMSubViewResource", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "资源"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.addFilterVerticalGroup(arg_4_0, arg_4_1)
	arg_4_0.verticalId = arg_4_0.verticalId or 0
	arg_4_0.verticalId = arg_4_0.verticalId + 1

	local var_4_0 = arg_4_0:addVerticalGroup(arg_4_0:getLineGroup(), arg_4_0.verticalId, var_0_0.FilterItemSize.Width, arg_4_0.filterGroupHeight)
	local var_4_1 = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, arg_4_1 do
		table.insert(var_4_1, arg_4_0:addVerticalInput(var_4_0, "", "正则表达式"))
	end

	return var_4_1
end

var_0_0.FilterItemSize = {
	Height = 80,
	Width = 500
}

function var_0_0.addVerticalInput(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = gohelper.clone(arg_5_0._goInputTextTemplate, arg_5_1, "InputText")

	gohelper.setActive(var_5_0, true)

	local var_5_1 = gohelper.findChildText(var_5_0, "Text")
	local var_5_2 = gohelper.findChildText(var_5_0, "Placeholder")

	arg_5_0._setFontSize(var_5_1, nil, 30)
	arg_5_0._setRectTransSize(var_5_0, nil, var_0_0.FilterItemSize.Width, var_0_0.FilterItemSize.Height)

	local var_5_3 = SLFramework.UGUI.InputFieldWrap.Get(var_5_0)
	local var_5_4 = tolua.findtype("UnityEngine.UI.InputField+LineType")
	local var_5_5 = System.Enum.Parse(var_5_4, "MultiLineSubmit")

	var_5_3.inputField.lineType = var_5_5
	var_5_2.text = arg_5_3 or ""

	var_5_3:SetText(arg_5_2 or "")
	var_5_3:AddOnValueChanged(arg_5_0.onInputFilterValueChange, arg_5_0)

	arg_5_0._inputTexts[#arg_5_0._inputTexts + 1] = var_5_3

	return var_5_3
end

function var_0_0.initViewContent(arg_6_0)
	if arg_6_0._inited then
		return
	end

	arg_6_0.lineIndex = 1
	arg_6_0.startToggle = arg_6_0:addToggle(arg_6_0:getLineGroup(), "开启资源慢加载", arg_6_0.onStartToggleChange, arg_6_0)
	arg_6_0.strategyList = {
		DelayLoadResMgr.DelayStrategyEnum.Multiple,
		DelayLoadResMgr.DelayStrategyEnum.Fixed
	}
	arg_6_0.strategyNameList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.strategyList) do
		table.insert(arg_6_0.strategyNameList, DelayLoadResMgr.DelayStrategyName[iter_6_1])
	end

	arg_6_0.strategyDrop = arg_6_0:addDropDown(arg_6_0:getLineGroup(), "延时策略", arg_6_0.strategyNameList, arg_6_0.onStrategyDropValueChange, arg_6_0)
	arg_6_0.strategyInput = arg_6_0:addInputText(arg_6_0:getLineGroup(), "", "延迟数值", arg_6_0.onStrategyInputValueChange, arg_6_0)

	arg_6_0:addLineIndex()
	arg_6_0:addLabel(arg_6_0:getLineGroup(), "默认全部文件都会开开启慢加载，如果设置了任意'启用慢加载'， 那么只有匹配的文件才会启用慢加载。'禁用慢加载文件'优先级最高", {
		w = 1200,
		fsize = 25,
		h = 160
	})
	arg_6_0:addLineIndex()

	arg_6_0.filterGroupHeight = 500
	arg_6_0.filterGroupHeight = 500

	local var_6_0 = {
		w = 50,
		h = arg_6_0.filterGroupHeight,
		align = TMPro.TextAlignmentOptions.Top
	}

	arg_6_0:addHorizontalGroup(arg_6_0:getLineGroup(), nil, arg_6_0.filterGroupHeight)
	arg_6_0:addLabel(arg_6_0:getLineGroup(), "启用慢加载文件", var_6_0)

	arg_6_0.enablePatternInputList = arg_6_0:addFilterVerticalGroup(5)

	arg_6_0:addLabel(arg_6_0:getLineGroup(), "禁用慢加载文件", var_6_0)

	arg_6_0.disablePatternInputList = arg_6_0:addFilterVerticalGroup(5)

	arg_6_0:initUIValue()
	var_0_0.super.initViewContent(arg_6_0)
end

function var_0_0.initUIValue(arg_7_0)
	arg_7_0.startToggle.isOn = DelayLoadResMgr.instance:isStartDelayLoad()

	local var_7_0 = DelayLoadResMgr.instance:getDelayStrategy()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.strategyList) do
		if var_7_0 == iter_7_1 then
			arg_7_0.strategyDrop:SetValue(iter_7_0 - 1)
		end
	end

	local var_7_1 = DelayLoadResMgr.instance:getDelayStrategyValue()

	arg_7_0.strategyInput:SetText(var_7_1)

	arg_7_0.enablePatternList = tabletool.copy(DelayLoadResMgr.instance:getEnablePatternList())
	arg_7_0.disablePatternList = tabletool.copy(DelayLoadResMgr.instance:getDisablePatternList())

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.enablePatternList) do
		arg_7_0.enablePatternInputList[iter_7_2]:SetText(iter_7_3)
	end

	for iter_7_4, iter_7_5 in ipairs(arg_7_0.disablePatternList) do
		arg_7_0.disablePatternInputList[iter_7_4]:SetText(iter_7_5)
	end
end

function var_0_0.onInputFilterValueChange(arg_8_0)
	if not arg_8_0._inited then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.enablePatternInputList) do
		arg_8_0.enablePatternList[iter_8_0] = iter_8_1:GetText()
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.disablePatternInputList) do
		arg_8_0.disablePatternList[iter_8_2] = iter_8_3:GetText()
	end

	DelayLoadResMgr.instance:setEnablePatternList(arg_8_0.enablePatternList)
	DelayLoadResMgr.instance:setDisablePatternList(arg_8_0.disablePatternList)
end

function var_0_0.onStartToggleChange(arg_9_0)
	if not arg_9_0._inited then
		return
	end

	if arg_9_0.startToggle.isOn then
		DelayLoadResMgr.instance:startDelayLoad()
	else
		DelayLoadResMgr.instance:stopDelayLoad()
	end
end

function var_0_0.onStrategyDropValueChange(arg_10_0, arg_10_1)
	if not arg_10_0._inited then
		return
	end

	DelayLoadResMgr.instance:setDelayStrategy(arg_10_0.strategyList[arg_10_1 + 1])
end

function var_0_0.onStrategyInputValueChange(arg_11_0)
	if not arg_11_0._inited then
		return
	end

	local var_11_0 = arg_11_0.strategyInput:GetText()
	local var_11_1 = tonumber(var_11_0)

	if not var_11_1 then
		return
	end

	DelayLoadResMgr.instance:setDelayStrategyValue(var_11_1)
end

return var_0_0
