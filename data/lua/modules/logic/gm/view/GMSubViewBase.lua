module("modules.logic.gm.view.GMSubViewBase", package.seeall)

local var_0_0 = class("GMSubViewBase", BaseView)
local var_0_1 = Color.New(1, 1, 1, 0.2)
local var_0_2 = Color.New(0.88, 0.84, 0.5, 1)
local var_0_3 = Color.New(0.75, 0.75, 0.75, 0.75)
local var_0_4 = Color.New(0, 0, 0, 0.5)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._mainViewBg = gohelper.findChild(arg_1_0.viewGO, "imgBg")
	arg_1_0._mainViewPort = gohelper.findChild(arg_1_0.viewGO, "viewport")
	arg_1_0._mainViewScrollBar = gohelper.findChild(arg_1_0.viewGO, "Scrollbar")
	arg_1_0._goSubViews = gohelper.findChild(arg_1_0.viewGO, "SubViews")
	arg_1_0._goSubViewTabs = gohelper.findChild(arg_1_0._goSubViews, "tabRect/Viewport/SubViewTabs")
	arg_1_0._goTabTemplate = gohelper.findChild(arg_1_0._goSubViewTabs, "template")
	arg_1_0._goSubViewTemplate = gohelper.findChild(arg_1_0._goSubViews, "SubViewTemplate")
	arg_1_0._goButtonTemplate = gohelper.findChild(arg_1_0._goSubViews, "ButtonTemplate")
	arg_1_0._goWikiButtonTemplate = gohelper.findChild(arg_1_0._goSubViews, "WikiButtonTemplate")
	arg_1_0._goLabelTemplate = gohelper.findChild(arg_1_0._goSubViews, "LabelTemplate")
	arg_1_0._goInputTextTemplate = gohelper.findChild(arg_1_0._goSubViews, "InputTextTemplate")
	arg_1_0._goToggleTemplate = gohelper.findChild(arg_1_0._goSubViews, "ToggleTemplate")
	arg_1_0._goSliderTemplate = gohelper.findChild(arg_1_0._goSubViews, "SliderTemplate")
	arg_1_0._goDropDownTemplate = gohelper.findChild(arg_1_0._goSubViews, "DropDownTemplate")
	arg_1_0._goTitleSplitLine = gohelper.findChild(arg_1_0._goSubViews, "TitleSplitLineTemplate")
	arg_1_0._subViewToggleGroup = arg_1_0._goSubViewTabs:GetComponent(typeof(UnityEngine.UI.ToggleGroup))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._horizontalGroups = arg_2_0:getUserDataTb_()
	arg_2_0._buttons = arg_2_0:getUserDataTb_()
	arg_2_0._inputTexts = arg_2_0:getUserDataTb_()
	arg_2_0._toggles = arg_2_0:getUserDataTb_()
	arg_2_0._sliders = arg_2_0:getUserDataTb_()
	arg_2_0._dropDowns = arg_2_0:getUserDataTb_()
	arg_2_0._verticalGroupDict = arg_2_0:getUserDataTb_()
	arg_2_0._wikiURLs = {}
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = PlayerPrefsHelper.getString("GMHideTabNames", "")
	local var_5_1 = {}

	if not string.nilorempty(var_5_0) then
		var_5_1 = string.split(var_5_0, "#")
	end

	if arg_5_0.tabName and not tabletool.indexOf(var_5_1, arg_5_0.tabName) then
		arg_5_0:addSubViewGo(arg_5_0.tabName)
	end
end

function var_0_0.onClose(arg_6_0)
	if arg_6_0._toggleWrap then
		arg_6_0._toggleWrap:RemoveOnValueChanged()
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._buttons) do
		iter_6_1:RemoveClickListener()
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._inputTexts) do
		iter_6_3:RemoveOnValueChanged()
	end

	for iter_6_4, iter_6_5 in ipairs(arg_6_0._toggles) do
		iter_6_5:RemoveOnValueChanged()
	end

	for iter_6_6, iter_6_7 in ipairs(arg_6_0._sliders) do
		iter_6_7:RemoveOnValueChanged()
	end

	for iter_6_8, iter_6_9 in ipairs(arg_6_0._dropDowns) do
		iter_6_9:RemoveOnValueChanged()
	end
end

function var_0_0.addSubViewGo(arg_7_0, arg_7_1)
	local var_7_0 = gohelper.clone(arg_7_0._goTabTemplate, arg_7_0._goSubViewTabs, arg_7_1 .. "Tab")

	gohelper.setActive(var_7_0, true)

	local var_7_1 = gohelper.onceAddComponent(var_7_0, typeof(UnityEngine.UI.Toggle))

	arg_7_0._toggleImage = gohelper.onceAddComponent(var_7_0, typeof(UnityEngine.UI.Image))
	var_7_1.group = arg_7_0._subViewToggleGroup
	arg_7_0._tabText = gohelper.findChildText(var_7_0, "Text")
	arg_7_0._tabText.text = arg_7_1
	arg_7_0._toggleWrap = gohelper.onceAddComponent(var_7_0, typeof(SLFramework.UGUI.ToggleWrap))

	arg_7_0._toggleWrap:AddOnValueChanged(arg_7_0._onToggleValueChanged, arg_7_0)

	arg_7_0._subViewGo = gohelper.clone(arg_7_0._goSubViewTemplate, arg_7_0._goSubViews, arg_7_1)
	arg_7_0._content = gohelper.findChild(arg_7_0._subViewGo, "viewport/content")

	gohelper.setActive(arg_7_0._subViewGo, false)
	arg_7_0.viewContainer:addSubViewToggle(arg_7_0._toggleWrap)
end

function var_0_0.initViewContent(arg_8_0)
	arg_8_0._inited = true
end

function var_0_0._onToggleValueChanged(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		if not arg_9_0._subViewContent then
			arg_9_0:initViewContent()
		end

		arg_9_0.viewContainer:selectToggle(arg_9_0._toggleWrap)
	end

	local var_9_0 = arg_9_0._subViewToggleGroup:AnyTogglesOn()

	gohelper.setActive(arg_9_0._mainViewBg, not arg_9_2 and not var_9_0)
	gohelper.setActive(arg_9_0._mainViewPort, not arg_9_2 and not var_9_0)

	arg_9_0._toggleImage.color = arg_9_2 and var_0_2 or var_0_3

	gohelper.setActive(arg_9_0._subViewGo, arg_9_2)
end

function var_0_0.addHorizontalGroup(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = UnityEngine.GameObject.New()

	gohelper.addChild(arg_10_0._content, var_10_0)

	var_10_0.name = "horizontal" .. arg_10_1

	local var_10_1 = gohelper.onceAddComponent(var_10_0, gohelper.Type_HorizontalLayoutGroup)
	local var_10_2 = var_10_1.padding

	var_10_2.left = 10
	var_10_2.right = 10
	var_10_1.spacing = 20
	var_10_1.childForceExpandWidth = false
	var_10_1.childControlWidth = false
	var_10_1.childControlHeight = false
	var_10_1.childAlignment = UnityEngine.TextAnchor.MiddleLeft

	local var_10_3 = gohelper.onceAddComponent(var_10_0, gohelper.Type_Image)

	var_10_3.raycastTarget = false
	var_10_3.color = var_0_1

	local var_10_4 = var_10_0:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(var_10_4, arg_10_2 or 1400, arg_10_3 or 100)

	arg_10_0._horizontalGroups[arg_10_1] = var_10_0

	return var_10_1
end

function var_0_0.addVerticalGroup(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_0._horizontalGroups[arg_11_1] then
		arg_11_0:addHorizontalGroup(arg_11_1)
	end

	local var_11_0 = arg_11_0._horizontalGroups[arg_11_1]
	local var_11_1 = UnityEngine.GameObject.New()

	gohelper.addChild(var_11_0, var_11_1)

	var_11_1.name = "vertical" .. arg_11_2

	local var_11_2 = gohelper.onceAddComponent(var_11_1, gohelper.Type_VerticalLayoutGroup)
	local var_11_3 = var_11_2.padding

	var_11_3.left = 10
	var_11_3.right = 10
	var_11_2.spacing = 20
	var_11_2.childForceExpandWidth = false
	var_11_2.childControlWidth = false
	var_11_2.childControlHeight = false
	var_11_2.childAlignment = UnityEngine.TextAnchor.MiddleLeft

	local var_11_4 = var_11_1:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(var_11_4, arg_11_3, arg_11_4)

	arg_11_0._verticalGroupDict[arg_11_2] = var_11_1

	return var_11_1
end

function var_0_0.addButton(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if not arg_12_0._horizontalGroups[arg_12_1] then
		arg_12_0:addHorizontalGroup(arg_12_1)
	end

	local var_12_0 = arg_12_0._horizontalGroups[arg_12_1]
	local var_12_1 = gohelper.clone(arg_12_0._goButtonTemplate, var_12_0, "button")

	gohelper.setActive(var_12_1, true)

	local var_12_2 = gohelper.findChildText(var_12_1, "Text")
	local var_12_3 = var_12_1:GetComponent(gohelper.Type_Image)

	var_12_2.text = arg_12_2

	arg_12_0._setFontSize(var_12_2, arg_12_5, 36)
	arg_12_0._setGraphicsColor(var_12_3, arg_12_5)
	arg_12_0._setRectTransSize(var_12_1, arg_12_5, var_12_2.preferredWidth + 20, 80)
	arg_12_0._adjustGroupWidthHeight(var_12_1, var_12_0)

	local var_12_4 = gohelper.getClickWithDefaultAudio(var_12_1)

	var_12_4:AddClickListener(arg_12_3, arg_12_4)

	arg_12_0._buttons[#arg_12_0._buttons + 1] = var_12_4

	return {
		var_12_4,
		var_12_2
	}
end

function var_0_0.addWikiButton(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._horizontalGroups[arg_13_1] then
		arg_13_0:addHorizontalGroup(arg_13_1)
	end

	local var_13_0 = arg_13_0._horizontalGroups[arg_13_1]
	local var_13_1 = gohelper.clone(arg_13_0._goWikiButtonTemplate, var_13_0, "wiki")

	gohelper.setActive(var_13_1, true)

	local var_13_2 = gohelper.findChildButtonWithAudio(var_13_1, "Button")

	arg_13_0._wikiURLs[#arg_13_0._wikiURLs + 1] = arg_13_2

	var_13_2:AddClickListener(arg_13_0._openWikiURL, arg_13_0, #arg_13_0._wikiURLs)

	arg_13_0._buttons[#arg_13_0._buttons + 1] = var_13_2
end

function var_0_0.addInputText(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	if not arg_14_0._horizontalGroups[arg_14_1] then
		arg_14_0:addHorizontalGroup(arg_14_1)
	end

	local var_14_0 = arg_14_0._horizontalGroups[arg_14_1]
	local var_14_1 = gohelper.clone(arg_14_0._goInputTextTemplate, var_14_0, "InputText")

	gohelper.setActive(var_14_1, true)

	local var_14_2 = gohelper.findChildText(var_14_1, "Text")
	local var_14_3 = gohelper.findChildText(var_14_1, "Placeholder")

	arg_14_0._setFontSize(var_14_2, arg_14_6, 36)
	arg_14_0._setFontSize(var_14_3, arg_14_6, 36)
	arg_14_0._setRectTransSize(var_14_1, arg_14_6, 300, 80)
	arg_14_0._adjustGroupWidthHeight(var_14_1, var_14_0)
	arg_14_0._setTextAlign(var_14_2, arg_14_6)

	local var_14_4 = SLFramework.UGUI.InputFieldWrap.Get(var_14_1)
	local var_14_5 = tolua.findtype("UnityEngine.UI.InputField+LineType")
	local var_14_6 = System.Enum.Parse(var_14_5, "MultiLineSubmit")

	var_14_4.inputField.lineType = var_14_6
	var_14_3.text = arg_14_3 or ""

	local var_14_7 = string.format("GM_%s_%s_%s", arg_14_0.__cname, arg_14_1, arg_14_3)

	if string.nilorempty(arg_14_2) then
		var_14_4:SetText(PlayerPrefsHelper.getString(var_14_7))
	else
		var_14_4:SetText(arg_14_2)
	end

	local function var_14_8(arg_15_0, arg_15_1)
		if arg_14_4 and arg_14_5 then
			arg_14_4(arg_14_5, arg_15_1)
		end

		local var_15_0 = var_14_4:GetText()

		PlayerPrefsHelper.setString(var_14_7, var_15_0)
	end

	var_14_4:AddOnValueChanged(var_14_8, arg_14_0)

	arg_14_0._inputTexts[#arg_14_0._inputTexts + 1] = var_14_4

	return var_14_4
end

function var_0_0.addLabel(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0._horizontalGroups[arg_16_1] then
		arg_16_0:addHorizontalGroup(arg_16_1)
	end

	local var_16_0 = arg_16_0._horizontalGroups[arg_16_1]
	local var_16_1 = var_16_0.transform.childCount
	local var_16_2 = arg_16_2 or var_16_1 + 1
	local var_16_3 = gohelper.clone(arg_16_0._goLabelTemplate, var_16_0, var_16_2)

	gohelper.setActive(var_16_3, true)

	local var_16_4 = gohelper.findChildText(var_16_3, "Text")

	var_16_4.text = var_16_2

	arg_16_0._setFontSize(var_16_4, arg_16_3, 36)
	arg_16_0._setGraphicsColor(var_16_4, arg_16_3)
	arg_16_0._setRectTransSize(var_16_3, arg_16_3, var_16_4.preferredWidth + 20, 80)
	arg_16_0._setTextAlign(var_16_4, arg_16_3)

	return var_16_4
end

function var_0_0.addToggle(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if not arg_17_0._horizontalGroups[arg_17_1] then
		arg_17_0:addHorizontalGroup(arg_17_1)
	end

	local var_17_0 = arg_17_0._horizontalGroups[arg_17_1]
	local var_17_1 = var_17_0.transform.childCount
	local var_17_2 = arg_17_2 or var_17_1 + 1
	local var_17_3 = gohelper.clone(arg_17_0._goToggleTemplate, var_17_0, var_17_2)

	gohelper.setActive(var_17_3, true)

	local var_17_4 = gohelper.findChildText(var_17_3, "Label")

	var_17_4.text = var_17_2

	arg_17_0._setFontSize(var_17_4, arg_17_5, 36)
	arg_17_0._setGraphicsColor(var_17_4, arg_17_5)
	arg_17_0._setRectTransSize(var_17_3, arg_17_5, var_17_4.preferredWidth + 100, 80)

	local var_17_5 = SLFramework.UGUI.ToggleWrap.Get(var_17_3)

	if arg_17_3 and arg_17_4 then
		var_17_5:AddOnValueChanged(arg_17_3, arg_17_4)
	end

	arg_17_0._toggles[#arg_17_0._toggles + 1] = var_17_5

	return var_17_5
end

function var_0_0.addSlider(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	if not arg_18_0._horizontalGroups[arg_18_1] then
		arg_18_0:addHorizontalGroup(arg_18_1)
	end

	local var_18_0 = arg_18_0._horizontalGroups[arg_18_1]
	local var_18_1 = gohelper.clone(arg_18_0._goSliderTemplate, var_18_0, "Slider")

	gohelper.setActive(var_18_1, true)

	local var_18_2 = gohelper.findChildText(var_18_1, "Text")

	var_18_2.text = arg_18_2

	arg_18_0._setGraphicsColor(var_18_2, arg_18_5)
	arg_18_0._setRectTransSize(var_18_1, arg_18_5, 600, 80)

	local var_18_3 = gohelper.findChildText(var_18_1, "Slider/ValueTxt")
	local var_18_4 = SLFramework.UGUI.SliderWrap.GetWithPath(var_18_1, "Slider")

	if arg_18_3 and arg_18_4 then
		var_18_4:AddOnValueChanged(arg_18_3, arg_18_4)
	end

	arg_18_0._sliders[#arg_18_0._sliders + 1] = var_18_4

	return {
		var_18_4,
		var_18_2,
		var_18_3
	}
end

function var_0_0.addDropDown(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	if not arg_19_0._horizontalGroups[arg_19_1] then
		arg_19_0:addHorizontalGroup(arg_19_1)
	end

	local var_19_0 = arg_19_0._horizontalGroups[arg_19_1]
	local var_19_1 = gohelper.clone(arg_19_0._goDropDownTemplate, var_19_0, "Dropdown")

	gohelper.setActive(var_19_1, true)

	local var_19_2 = gohelper.findChildText(var_19_1, "Text")
	local var_19_3 = gohelper.findChild(var_19_1, "Dropdown")

	var_19_2.text = arg_19_2

	arg_19_0._setFontSize(var_19_2, arg_19_6, 36)
	arg_19_0._setGraphicsColor(var_19_2, arg_19_6)
	arg_19_0._setRectTransSize(var_19_1, arg_19_6, arg_19_6 and arg_19_6.total_w or var_19_2.preferredWidth + 300, 90)
	arg_19_0._setRectTransSize(var_19_2, arg_19_6, arg_19_6 and arg_19_6.label_w or var_19_2.preferredWidth + 300, 90)
	arg_19_0._setRectTransSize(var_19_3, arg_19_6, arg_19_6 and arg_19_6.drop_w or var_19_2.preferredWidth + 150, 90)

	local var_19_4 = gohelper.findChildComponent(var_19_1, "Dropdown/Template", gohelper.Type_RectTransform)

	if arg_19_6 and arg_19_6.tempH then
		recthelper.setHeight(var_19_4, arg_19_6.tempH)
	end

	arg_19_0._setOffset(var_19_4, arg_19_6)

	local var_19_5 = gohelper.findChildDropdown(var_19_1, "Dropdown")

	if arg_19_4 and arg_19_5 then
		var_19_5:AddOnValueChanged(arg_19_4, arg_19_5)
	end

	var_19_5:ClearOptions()

	if arg_19_3 then
		var_19_5:AddOptions(arg_19_3)
	end

	arg_19_0._dropDowns[#arg_19_0._dropDowns + 1] = var_19_5

	return var_19_5
end

function var_0_0.addSplitLine(arg_20_0)
	local var_20_0 = UnityEngine.GameObject.New()

	gohelper.addChild(arg_20_0._content, var_20_0)

	gohelper.onceAddComponent(var_20_0, gohelper.Type_Image).color = var_0_4

	local var_20_1 = var_20_0:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(var_20_1, 1400, 3)

	return var_20_0
end

function var_0_0.addTitleSplitLine(arg_21_0, arg_21_1)
	local var_21_0 = gohelper.clone(arg_21_0._goTitleSplitLine, arg_21_0._content, "titleSplitLine")

	gohelper.setActive(var_21_0, true)

	local var_21_1 = gohelper.findChildText(var_21_0, "Text")

	var_21_1.text = arg_21_1

	gohelper.setActive(var_21_1.gameObject, not string.nilorempty(arg_21_1))
end

function var_0_0._setGraphicsColor(arg_22_0, arg_22_1)
	if not arg_22_1 or not arg_22_1.c then
		return
	end

	arg_22_0.color = SLFramework.UGUI.GuiHelper.ParseColor(arg_22_1.c)
end

function var_0_0._setRectTransSize(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:GetComponent(gohelper.Type_RectTransform)
	local var_23_1 = arg_23_1 and arg_23_1.w
	local var_23_2 = arg_23_1 and arg_23_1.h

	recthelper.setSize(var_23_0, var_23_1 and var_23_1 or arg_23_2, var_23_2 and var_23_2 or arg_23_3)
end

function var_0_0._setFontSize(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1 and arg_24_1.fsize

	arg_24_0.fontSize = var_24_0 and var_24_0 or arg_24_2
end

function var_0_0._setTMPTextAlign(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1 and arg_25_1.align

	if var_25_0 then
		arg_25_0.alignment = var_25_0
	end
end

function var_0_0._setTextAlign(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1 and arg_26_1.align

	if var_26_0 then
		arg_26_0.alignment = var_26_0
	end
end

function var_0_0._setOffset(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_2 and arg_27_2.offsetMin then
		arg_27_1.offsetMin = arg_27_2.offsetMin
	end

	if arg_27_2 and arg_27_2.offsetMax then
		arg_27_1.offsetMax = arg_27_2.offsetMax
	end
end

function var_0_0._openWikiURL(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._wikiURLs[arg_28_1]

	if SLFramework.FrameworkSettings.IsEditor then
		UnityEngine.Application.OpenURL(var_28_0)
	end
end

function var_0_0._adjustGroupWidthHeight(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetComponent(gohelper.Type_RectTransform)
	local var_29_1 = arg_29_1:GetComponent(gohelper.Type_RectTransform)
	local var_29_2 = recthelper.getHeight(var_29_0)
	local var_29_3 = recthelper.getHeight(var_29_1)
	local var_29_4 = recthelper.getWidth(var_29_0)
	local var_29_5 = recthelper.getWidth(var_29_1)

	if var_29_3 < var_29_2 then
		recthelper.setHeight(var_29_1, var_29_2)
	end

	if var_29_5 < var_29_4 then
		recthelper.setWidth(var_29_1, var_29_4)
	end
end

return var_0_0
