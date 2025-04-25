module("modules.logic.gm.view.GMSubViewBase", package.seeall)

slot0 = class("GMSubViewBase", BaseView)
slot1 = Color.New(1, 1, 1, 0.2)
slot2 = Color.New(0.88, 0.84, 0.5, 1)
slot3 = Color.New(0.75, 0.75, 0.75, 0.75)
slot4 = Color.New(0, 0, 0, 0.5)

function slot0.onInitView(slot0)
	slot0._mainViewBg = gohelper.findChild(slot0.viewGO, "imgBg")
	slot0._mainViewPort = gohelper.findChild(slot0.viewGO, "viewport")
	slot0._mainViewScrollBar = gohelper.findChild(slot0.viewGO, "Scrollbar")
	slot0._goSubViews = gohelper.findChild(slot0.viewGO, "SubViews")
	slot0._goSubViewTabs = gohelper.findChild(slot0._goSubViews, "tabRect/Viewport/SubViewTabs")
	slot0._goTabTemplate = gohelper.findChild(slot0._goSubViewTabs, "template")
	slot0._goSubViewTemplate = gohelper.findChild(slot0._goSubViews, "SubViewTemplate")
	slot0._goButtonTemplate = gohelper.findChild(slot0._goSubViews, "ButtonTemplate")
	slot0._goWikiButtonTemplate = gohelper.findChild(slot0._goSubViews, "WikiButtonTemplate")
	slot0._goLabelTemplate = gohelper.findChild(slot0._goSubViews, "LabelTemplate")
	slot0._goInputTextTemplate = gohelper.findChild(slot0._goSubViews, "InputTextTemplate")
	slot0._goToggleTemplate = gohelper.findChild(slot0._goSubViews, "ToggleTemplate")
	slot0._goSliderTemplate = gohelper.findChild(slot0._goSubViews, "SliderTemplate")
	slot0._goDropDownTemplate = gohelper.findChild(slot0._goSubViews, "DropDownTemplate")
	slot0._goTitleSplitLine = gohelper.findChild(slot0._goSubViews, "TitleSplitLineTemplate")
	slot0._subViewToggleGroup = slot0._goSubViewTabs:GetComponent(typeof(UnityEngine.UI.ToggleGroup))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._horizontalGroups = slot0:getUserDataTb_()
	slot0._buttons = slot0:getUserDataTb_()
	slot0._inputTexts = slot0:getUserDataTb_()
	slot0._toggles = slot0:getUserDataTb_()
	slot0._sliders = slot0:getUserDataTb_()
	slot0._dropDowns = slot0:getUserDataTb_()
	slot0._verticalGroupDict = slot0:getUserDataTb_()
	slot0._wikiURLs = {}
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot2 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString("GMHideTabNames", "")) then
		slot2 = string.split(slot1, "#")
	end

	if slot0.tabName and not tabletool.indexOf(slot2, slot0.tabName) then
		slot0:addSubViewGo(slot0.tabName)
	end
end

function slot0.onClose(slot0)
	if slot0._toggleWrap then
		slot0._toggleWrap:RemoveOnValueChanged()
	end

	for slot4, slot5 in ipairs(slot0._buttons) do
		slot5:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._inputTexts) do
		slot5:RemoveOnValueChanged()
	end

	for slot4, slot5 in ipairs(slot0._toggles) do
		slot5:RemoveOnValueChanged()
	end

	for slot4, slot5 in ipairs(slot0._sliders) do
		slot5:RemoveOnValueChanged()
	end

	for slot4, slot5 in ipairs(slot0._dropDowns) do
		slot5:RemoveOnValueChanged()
	end
end

function slot0.addSubViewGo(slot0, slot1)
	slot2 = gohelper.clone(slot0._goTabTemplate, slot0._goSubViewTabs, slot1 .. "Tab")

	gohelper.setActive(slot2, true)

	slot0._toggleImage = gohelper.onceAddComponent(slot2, typeof(UnityEngine.UI.Image))
	gohelper.onceAddComponent(slot2, typeof(UnityEngine.UI.Toggle)).group = slot0._subViewToggleGroup
	slot0._tabText = gohelper.findChildText(slot2, "Text")
	slot0._tabText.text = slot1
	slot0._toggleWrap = gohelper.onceAddComponent(slot2, typeof(SLFramework.UGUI.ToggleWrap))

	slot0._toggleWrap:AddOnValueChanged(slot0._onToggleValueChanged, slot0)

	slot0._subViewGo = gohelper.clone(slot0._goSubViewTemplate, slot0._goSubViews, slot1)
	slot0._content = gohelper.findChild(slot0._subViewGo, "viewport/content")

	gohelper.setActive(slot0._subViewGo, false)
	slot0.viewContainer:addSubViewToggle(slot0._toggleWrap)
end

function slot0.initViewContent(slot0)
	slot0._inited = true
end

function slot0._onToggleValueChanged(slot0, slot1, slot2)
	if slot2 then
		if not slot0._subViewContent then
			slot0:initViewContent()
		end

		slot0.viewContainer:selectToggle(slot0._toggleWrap)
	end

	slot3 = slot0._subViewToggleGroup:AnyTogglesOn()

	gohelper.setActive(slot0._mainViewBg, not slot2 and not slot3)
	gohelper.setActive(slot0._mainViewPort, not slot2 and not slot3)

	slot0._toggleImage.color = slot2 and uv0 or uv1

	gohelper.setActive(slot0._subViewGo, slot2)
end

function slot0.addHorizontalGroup(slot0, slot1, slot2, slot3)
	slot4 = UnityEngine.GameObject.New()

	gohelper.addChild(slot0._content, slot4)

	slot4.name = "horizontal" .. slot1
	slot5 = gohelper.onceAddComponent(slot4, gohelper.Type_HorizontalLayoutGroup)
	slot6 = slot5.padding
	slot6.left = 10
	slot6.right = 10
	slot5.spacing = 20
	slot5.childForceExpandWidth = false
	slot5.childControlWidth = false
	slot5.childControlHeight = false
	slot5.childAlignment = UnityEngine.TextAnchor.MiddleLeft
	slot7 = gohelper.onceAddComponent(slot4, gohelper.Type_Image)
	slot7.raycastTarget = false
	slot7.color = uv0

	recthelper.setSize(slot4:GetComponent(gohelper.Type_RectTransform), slot2 or 1400, slot3 or 100)

	slot0._horizontalGroups[slot1] = slot4

	return slot5
end

function slot0.addVerticalGroup(slot0, slot1, slot2, slot3, slot4)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot6 = UnityEngine.GameObject.New()

	gohelper.addChild(slot0._horizontalGroups[slot1], slot6)

	slot6.name = "vertical" .. slot2
	slot7 = gohelper.onceAddComponent(slot6, gohelper.Type_VerticalLayoutGroup)
	slot8 = slot7.padding
	slot8.left = 10
	slot8.right = 10
	slot7.spacing = 20
	slot7.childForceExpandWidth = false
	slot7.childControlWidth = false
	slot7.childControlHeight = false
	slot7.childAlignment = UnityEngine.TextAnchor.MiddleLeft

	recthelper.setSize(slot6:GetComponent(gohelper.Type_RectTransform), slot3, slot4)

	slot0._verticalGroupDict[slot2] = slot6

	return slot6
end

function slot0.addButton(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot6 = slot0._horizontalGroups[slot1]
	slot7 = gohelper.clone(slot0._goButtonTemplate, slot6, "button")

	gohelper.setActive(slot7, true)

	slot8 = gohelper.findChildText(slot7, "Text")
	slot8.text = slot2

	slot0._setFontSize(slot8, slot5, 36)
	slot0._setGraphicsColor(slot7:GetComponent(gohelper.Type_Image), slot5)
	slot0._setRectTransSize(slot7, slot5, slot8.preferredWidth + 20, 80)
	slot0._adjustGroupWidthHeight(slot7, slot6)

	slot10 = gohelper.getClickWithDefaultAudio(slot7)

	slot10:AddClickListener(slot3, slot4)

	slot0._buttons[#slot0._buttons + 1] = slot10

	return {
		slot10,
		slot8
	}
end

function slot0.addWikiButton(slot0, slot1, slot2)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot4 = gohelper.clone(slot0._goWikiButtonTemplate, slot0._horizontalGroups[slot1], "wiki")

	gohelper.setActive(slot4, true)

	slot5 = gohelper.findChildButtonWithAudio(slot4, "Button")
	slot0._wikiURLs[#slot0._wikiURLs + 1] = slot2

	slot5:AddClickListener(slot0._openWikiURL, slot0, #slot0._wikiURLs)

	slot0._buttons[#slot0._buttons + 1] = slot5
end

function slot0.addInputText(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot7 = slot0._horizontalGroups[slot1]
	slot8 = gohelper.clone(slot0._goInputTextTemplate, slot7, "InputText")

	gohelper.setActive(slot8, true)

	slot9 = gohelper.findChildText(slot8, "Text")

	slot0._setFontSize(slot9, slot6, 36)
	slot0._setFontSize(gohelper.findChildText(slot8, "Placeholder"), slot6, 36)
	slot0._setRectTransSize(slot8, slot6, 300, 80)
	slot0._adjustGroupWidthHeight(slot8, slot7)
	slot0._setTextAlign(slot9, slot6)

	SLFramework.UGUI.InputFieldWrap.Get(slot8).inputField.lineType = System.Enum.Parse(tolua.findtype("UnityEngine.UI.InputField+LineType"), "MultiLineSubmit")
	slot10.text = slot3 or ""

	if string.nilorempty(slot2) then
		slot11:SetText(PlayerPrefsHelper.getString(string.format("GM_%s_%s_%s", slot0.__cname, slot1, slot3)))
	else
		slot11:SetText(slot2)
	end

	slot11:AddOnValueChanged(function (slot0, slot1)
		if uv0 and uv1 then
			uv0(uv1, slot1)
		end

		PlayerPrefsHelper.setString(uv3, uv2:GetText())
	end, slot0)

	slot0._inputTexts[#slot0._inputTexts + 1] = slot11

	return slot11
end

function slot0.addLabel(slot0, slot1, slot2, slot3)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot7 = slot2 or slot0._horizontalGroups[slot1].transform.childCount + 1
	slot8 = gohelper.clone(slot0._goLabelTemplate, slot4, slot7)

	gohelper.setActive(slot8, true)

	slot9 = gohelper.findChildText(slot8, "Text")
	slot9.text = slot7

	slot0._setFontSize(slot9, slot3, 36)
	slot0._setGraphicsColor(slot9, slot3)
	slot0._setRectTransSize(slot8, slot3, slot9.preferredWidth + 20, 80)
	slot0._setTextAlign(slot9, slot3)

	return slot9
end

function slot0.addToggle(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot9 = slot2 or slot0._horizontalGroups[slot1].transform.childCount + 1
	slot10 = gohelper.clone(slot0._goToggleTemplate, slot6, slot9)

	gohelper.setActive(slot10, true)

	slot11 = gohelper.findChildText(slot10, "Label")
	slot11.text = slot9

	slot0._setFontSize(slot11, slot5, 36)
	slot0._setGraphicsColor(slot11, slot5)
	slot0._setRectTransSize(slot10, slot5, slot11.preferredWidth + 100, 80)

	slot12 = SLFramework.UGUI.ToggleWrap.Get(slot10)

	if slot3 and slot4 then
		slot12:AddOnValueChanged(slot3, slot4)
	end

	slot0._toggles[#slot0._toggles + 1] = slot12

	return slot12
end

function slot0.addSlider(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot7 = gohelper.clone(slot0._goSliderTemplate, slot0._horizontalGroups[slot1], "Slider")

	gohelper.setActive(slot7, true)

	slot8 = gohelper.findChildText(slot7, "Text")
	slot8.text = slot2

	slot0._setGraphicsColor(slot8, slot5)
	slot0._setRectTransSize(slot7, slot5, 600, 80)

	slot9 = SLFramework.UGUI.SliderWrap.GetWithPath(slot7, "Slider")

	if slot3 and slot4 then
		slot9:AddOnValueChanged(slot3, slot4)
	end

	slot0._sliders[#slot0._sliders + 1] = slot9

	return {
		slot9,
		slot8
	}
end

function slot0.addDropDown(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0._horizontalGroups[slot1] then
		slot0:addHorizontalGroup(slot1)
	end

	slot8 = gohelper.clone(slot0._goDropDownTemplate, slot0._horizontalGroups[slot1], "Dropdown")

	gohelper.setActive(slot8, true)

	slot9 = gohelper.findChildText(slot8, "Text")
	slot9.text = slot2

	slot0._setFontSize(slot9, slot6, 36)
	slot0._setGraphicsColor(slot9, slot6)
	slot0._setRectTransSize(slot8, slot6, slot6 and slot6.total_w or slot9.preferredWidth + 300, 90)
	slot0._setRectTransSize(slot9, slot6, slot6 and slot6.label_w or slot9.preferredWidth + 300, 90)
	slot0._setRectTransSize(gohelper.findChild(slot8, "Dropdown"), slot6, slot6 and slot6.drop_w or slot9.preferredWidth + 150, 90)
	slot0._setOffset(gohelper.findChildComponent(slot8, "Dropdown/Template", gohelper.Type_RectTransform), slot6)

	slot12 = gohelper.findChildDropdown(slot8, "Dropdown")

	if slot4 and slot5 then
		slot12:AddOnValueChanged(slot4, slot5)
	end

	slot12:ClearOptions()

	if slot3 then
		slot12:AddOptions(slot3)
	end

	slot0._dropDowns[#slot0._dropDowns + 1] = slot12

	return slot12
end

function slot0.addSplitLine(slot0)
	slot1 = UnityEngine.GameObject.New()

	gohelper.addChild(slot0._content, slot1)

	gohelper.onceAddComponent(slot1, gohelper.Type_Image).color = uv0

	recthelper.setSize(slot1:GetComponent(gohelper.Type_RectTransform), 1400, 3)

	return slot1
end

function slot0.addTitleSplitLine(slot0, slot1)
	slot2 = gohelper.clone(slot0._goTitleSplitLine, slot0._content, "titleSplitLine")

	gohelper.setActive(slot2, true)

	slot3 = gohelper.findChildText(slot2, "Text")
	slot3.text = slot1

	gohelper.setActive(slot3.gameObject, not string.nilorempty(slot1))
end

function slot0._setGraphicsColor(slot0, slot1)
	if not slot1 or not slot1.c then
		return
	end

	slot0.color = SLFramework.UGUI.GuiHelper.ParseColor(slot1.c)
end

function slot0._setRectTransSize(slot0, slot1, slot2, slot3)
	slot5 = slot1 and slot1.w
	slot6 = slot1 and slot1.h

	recthelper.setSize(slot0:GetComponent(gohelper.Type_RectTransform), slot5 and slot5 or slot2, slot6 and slot6 or slot3)
end

function slot0._setFontSize(slot0, slot1, slot2)
	slot3 = slot1 and slot1.fsize
	slot0.fontSize = slot3 and slot3 or slot2
end

function slot0._setTMPTextAlign(slot0, slot1)
	if slot1 and slot1.align then
		slot0.alignment = slot2
	end
end

function slot0._setTextAlign(slot0, slot1)
	if slot1 and slot1.align then
		slot0.alignment = slot2
	end
end

function slot0._setOffset(slot0, slot1, slot2)
	if slot2 and slot2.offsetMin then
		slot1.offsetMin = slot2.offsetMin
	end

	if slot2 and slot2.offsetMax then
		slot1.offsetMax = slot2.offsetMax
	end
end

function slot0._openWikiURL(slot0, slot1)
	if SLFramework.FrameworkSettings.IsEditor then
		UnityEngine.Application.OpenURL(slot0._wikiURLs[slot1])
	end
end

function slot0._adjustGroupWidthHeight(slot0, slot1)
	slot2 = slot0:GetComponent(gohelper.Type_RectTransform)
	slot3 = slot1:GetComponent(gohelper.Type_RectTransform)
	slot6 = recthelper.getWidth(slot2)
	slot7 = recthelper.getWidth(slot3)

	if recthelper.getHeight(slot3) < recthelper.getHeight(slot2) then
		recthelper.setHeight(slot3, slot4)
	end

	if slot7 < slot6 then
		recthelper.setWidth(slot3, slot6)
	end
end

return slot0
