module("modules.logic.guide.view.GuideStepEditor", package.seeall)

slot0 = class("GuideStepEditor", BaseView)

function slot0.onInitView(slot0)
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_block")
	slot0._gotrigger = gohelper.findChild(slot0.viewGO, "1/#go_trigger")
	slot0._gotrigger1 = gohelper.findChild(slot0.viewGO, "1/#go_trigger/#go_trigger1")
	slot0._gotrigger2 = gohelper.findChild(slot0.viewGO, "1/#go_trigger/#go_trigger2")
	slot0._gotrigger3 = gohelper.findChild(slot0.viewGO, "1/#go_trigger/#go_trigger3")
	slot0._btnsaveTrigger = gohelper.findChildButtonWithAudio(slot0.viewGO, "1/#go_trigger/#btn_saveTrigger")
	slot0._gooffset = gohelper.findChild(slot0.viewGO, "1/component/#go_offset")
	slot0._txtoffsetkey = gohelper.findChildText(slot0.viewGO, "1/component/#go_offset/#txt_offsetkey")
	slot0._btnsaveOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "1/component/#go_offset/#btn_saveOffset")
	slot0._btnresetOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "1/component/#go_offset/#btn_resetOffset")
	slot0._btnswitchOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "1/component/#go_offset/#btn_switchOffset")
	slot0._goedit = gohelper.findChild(slot0.viewGO, "#go_edit")
	slot0._goallmodules = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules/#go_container")
	slot0._txttemp = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/#txt_temp")
	slot0._btnusego = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/#btn_usego")
	slot0._btncopyuiInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/#btn_copyuiInfo")
	slot0._txtuse = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/#txt_use")
	slot0._slideroffsetx = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#slider_offsetx")
	slot0._txtoffsetx = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#txt_offsetx")
	slot0._slideroffsety = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#slider_offsety")
	slot0._txtoffsety = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#txt_offsety")
	slot0._gowidthoffset = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset")
	slot0._slideroffsetw = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset/#slider_offsetw")
	slot0._txtoffsetw = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset/#txt_offsetw")
	slot0._goheightoffset = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset")
	slot0._slideroffseth = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset/#slider_offseth")
	slot0._txtoffseth = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset/#txt_offseth")
	slot0._goarrowxoffset = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset")
	slot0._slideroffsetarrowx = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset/#slider_offsetarrowx")
	slot0._txtoffsetarrowx = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset/#txt_offsetarrowx")
	slot0._goarrowyoffset = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset")
	slot0._slideroffsetarrowy = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset/#slider_offsetarrowy")
	slot0._txtoffsetarrowy = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset/#txt_offsetarrowy")
	slot0._togglemask = gohelper.findChildToggle(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/toggles/#toggle_mask")
	slot0._toggleshape = gohelper.findChildToggle(slot0.viewGO, "#go_edit/#go_allmodules/#go_container/toggles/#toggle_shape")
	slot0._gotextContainer = gohelper.findChild(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer")
	slot0._slidertipsoffsetx = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#slider_tipsoffsetx")
	slot0._txttipsoffsetx = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#txt_tipsoffsetx")
	slot0._slidertipsoffsety = gohelper.findChildSlider(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#slider_tipsoffsety")
	slot0._txttipsoffsety = gohelper.findChildText(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#txt_tipsoffsety")
	slot0._btnresettextoffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_resettextoffset")
	slot0._btnclearGoPath = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_clearGoPath")
	slot0._btncopytextinfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_copytextinfo")
	slot0._toggletip = gohelper.findChildToggle(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/toggles/#toggle_tip")
	slot0._toggledialogue = gohelper.findChildToggle(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/toggles/#toggle_dialogue")
	slot0._inputtext = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#input_text")
	slot0._btnpaseuipath = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#go_allmodules/#btn_paseuipath")
	slot0._inputuse = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_edit/#go_allmodules/#input_use")
	slot0._inputoffset = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_edit/#go_allmodules/#input_offset")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#btn_switch")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "#go_edit/#btn_switch/#txt_switch")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#btn_close")
	slot0._btnswitchclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#btn_switchclick")
	slot0._btnswitchtext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#btn_switchtext")
	slot0._btnswitchpos = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_edit/#btn_switchpos")
	slot0._gotype4 = gohelper.findChild(slot0.viewGO, "#go_type4")
	slot0._gotipsmask = gohelper.findChild(slot0.viewGO, "#go_tipsmask")
	slot0._godialogue = gohelper.findChild(slot0.viewGO, "#go_dialogue")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_dialogue/#txt_content")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_dialogue/#txt_name")
	slot0._simageleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_dialogue/left/#simage_left")
	slot0._simageright = gohelper.findChildSingleImage(slot0.viewGO, "#go_dialogue/right/#simage_right")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
	slot0._btnsaveTrigger:AddClickListener(slot0._btnsaveTriggerOnClick, slot0)
	slot0._btnsaveOffset:AddClickListener(slot0._btnsaveOffsetOnClick, slot0)
	slot0._btnresetOffset:AddClickListener(slot0._btnresetOffsetOnClick, slot0)
	slot0._btnswitchOffset:AddClickListener(slot0._btnswitchOffsetOnClick, slot0)
	slot0._btnusego:AddClickListener(slot0._btnusegoOnClick, slot0)
	slot0._btncopyuiInfo:AddClickListener(slot0._btncopyuiInfoOnClick, slot0)
	slot0._btnresettextoffset:AddClickListener(slot0._btnresettextoffsetOnClick, slot0)
	slot0._btnclearGoPath:AddClickListener(slot0._btnclearGoPathOnClick, slot0)
	slot0._btncopytextinfo:AddClickListener(slot0._btncopytextinfoOnClick, slot0)
	slot0._btnpaseuipath:AddClickListener(slot0._btnpaseuipathOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnswitchclick:AddClickListener(slot0._btnswitchclickOnClick, slot0)
	slot0._btnswitchtext:AddClickListener(slot0._btnswitchtextOnClick, slot0)
	slot0._btnswitchpos:AddClickListener(slot0._btnswitchposOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
	slot0._btnsaveTrigger:RemoveClickListener()
	slot0._btnsaveOffset:RemoveClickListener()
	slot0._btnresetOffset:RemoveClickListener()
	slot0._btnswitchOffset:RemoveClickListener()
	slot0._btnusego:RemoveClickListener()
	slot0._btncopyuiInfo:RemoveClickListener()
	slot0._btnresettextoffset:RemoveClickListener()
	slot0._btnclearGoPath:RemoveClickListener()
	slot0._btncopytextinfo:RemoveClickListener()
	slot0._btnpaseuipath:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnswitchclick:RemoveClickListener()
	slot0._btnswitchtext:RemoveClickListener()
	slot0._btnswitchpos:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtoffsetx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtoffsety.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtoffsetw.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtoffseth.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtoffsetarrowx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtoffsetarrowy.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txttipsoffsetx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txttipsoffsety.gameObject):RemoveClickListener()
	slot0._inputtext:RemoveOnValueChanged()
	slot0._inputoffset:RemoveOnValueChanged()
	slot0._inputoffset:RemoveOnEndEdit()
end

function slot0._btnswitchposOnClick(slot0)
	slot0._changePos = not slot0._changePos

	if slot0._changePos then
		recthelper.setAnchor(slot0._goedit.transform, -634, -590)
	else
		recthelper.setAnchor(slot0._goedit.transform, 0, 0)
	end
end

function slot0._btnclearGoPathOnClick(slot0)
	slot0._selectedGo = nil
	slot0._useGo = slot0._selectedGo
	slot0._useGoPath = ""

	slot0._inputuse:SetText(slot0._useGoPath)

	if slot0._showText then
		slot0:updateText()
	end
end

function slot0._btnresettextoffsetOnClick(slot0)
	slot0._slidertipsoffsetx.slider.value = 0
	slot0._slidertipsoffsety.slider.value = 0
end

function slot0._btncopytextinfoOnClick(slot0)
	slot1 = slot0._tipPos

	ZProj.UGUIHelper.CopyText(slot1)
	print("请粘贴提示框信息：", slot1)
end

function slot0._btnswitchclickOnClick(slot0)
	slot0:_showModule(true)
	slot0:updateGuide()
end

function slot0._btnswitchtextOnClick(slot0)
	slot0:_showModule(false)
	slot0:updateText()
end

function slot0._showModule(slot0, slot1)
	slot0._showClick = slot1
	slot0._showText = not slot1

	gohelper.setActive(slot0._gocontainer, slot0._showClick)
	gohelper.setActive(slot0._gotextContainer, slot0._showText)
	gohelper.setActive(slot0._btnswitchtext.gameObject, slot0._showClick)
	gohelper.setActive(slot0._btnswitchclick.gameObject, slot0._showText)
end

function slot0._btnpaseuipathOnClick(slot0)
	if string.nilorempty(ZProj.UGUIHelper.GetSystemCopyBuffer()) then
		logError("路径为空")

		return
	end

	if gohelper.isNil(gohelper.find(slot1)) then
		logError("找不到路径对应的GameObject：" .. slot1)

		return
	end

	slot0._selectedGo = slot2

	slot0:_btnusegoOnClick()

	if slot0._showClick then
		slot0:updateGuide()
	end

	if slot0._showText then
		slot0:updateText()
	end
end

function slot0._btncopyuiInfoOnClick(slot0)
	slot1 = string.format("%s\t%s\t%s", slot0._uiOffset, slot0._uiInfo, slot0._useGoPath)

	ZProj.UGUIHelper.CopyText(slot1)
	print("请粘贴指示框信息：", slot1)
end

function slot0._btnusegoOnClick(slot0)
	if gohelper.isNil(slot0._selectedGo) then
		return
	end

	slot1 = nil
	slot2 = slot0._selectedGo.transform

	while slot2 ~= nil do
		slot1 = (slot1 or slot2.name) and slot2.name .. "/" .. slot1
		slot2 = slot2.parent
	end

	slot0._useGo = slot0._selectedGo
	slot0._useGoPath = slot1

	slot0._inputuse:SetText(slot0._useGoPath)
end

function slot0._btnblockOnClick(slot0)
end

function slot0._btnsaveTriggerOnClick(slot0)
end

function slot0._btnsaveOffsetOnClick(slot0)
end

function slot0._btnresetOffsetOnClick(slot0)
end

function slot0._btnswitchOffsetOnClick(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnswitchOnClick(slot0)
	gohelper.setActive(slot0._goallmodules, not slot0._goallmodules.activeSelf)

	if slot0._goallmodules.activeSelf then
		slot0._txtswitch.text = "点击隐藏"
	else
		slot0._txtswitch.text = "点击显示"
	end
end

function slot0._editableInitView(slot0)
	slot0:initDropUiInfo()
	slot0._goarrowxoffset:SetActive(false)
	slot0._goarrowyoffset:SetActive(false)
	slot0:initSlider(slot0._slideroffsetx, 1500, -1500, slot0._onOffsetXChange)
	slot0:initSlider(slot0._slideroffsety, 1500, -1500, slot0._onOffsetYChange)
	slot0:initSlider(slot0._slideroffsetarrowx, 1500, -1500, slot0._onOffsetArrowXChange)
	slot0:initSlider(slot0._slideroffsetarrowy, 1500, -1500, slot0._onOffsetArrowYChange)
	slot0:initSlider(slot0._slideroffsetw, 3000, -1, slot0._onOffsetWChange, 200)
	slot0:initSlider(slot0._slideroffseth, 1500, -1, slot0._onOffsetHChange, 200)
	slot0:initSlider(slot0._slidertipsoffsetx, 1500, -1500, slot0._onTipsOffsetXChange)
	slot0:initSlider(slot0._slidertipsoffsety, 1500, -1500, slot0._onTipsOffsetYChange)
	slot0._togglemask:AddOnValueChanged(slot0._onParamValueChange, slot0)
	slot0._toggleshape:AddOnValueChanged(slot0._onParamValueChange, slot0)
	slot0._toggledialogue:AddOnValueChanged(slot0._onTipsParamValueChange, slot0)
	slot0._toggletip:AddOnValueChanged(slot0._onTipsParamValueChange, slot0)
	slot0._inputtext:AddOnValueChanged(slot0._inputValueChanged, slot0)
	slot0._inputtext:SetText("这是测试文本！这是测试文本！这是测试文本！")
	slot0:_showModule(true)

	slot0._showContainer = true

	slot0:_cancelRaycastTarget()
	gohelper.setActive(slot0._inputoffset.gameObject, false)
	slot0:initTxtOffset(slot0._txtoffsetx, slot0._slideroffsetx)
	slot0:initTxtOffset(slot0._txtoffsety, slot0._slideroffsety)
	slot0:initTxtOffset(slot0._txtoffsetw, slot0._slideroffsetw)
	slot0:initTxtOffset(slot0._txtoffseth, slot0._slideroffseth)
	slot0:initTxtOffset(slot0._txtoffsetarrowx, slot0._slideroffsetarrowx)
	slot0:initTxtOffset(slot0._txtoffsetarrowy, slot0._slideroffsetarrowy)
	slot0:initTxtOffset(slot0._txttipsoffsetx, slot0._slidertipsoffsetx)
	slot0:initTxtOffset(slot0._txttipsoffsety, slot0._slidertipsoffsety)
end

function slot0._inputValueChanged(slot0)
	if slot0._showText then
		slot0:updateText()
	end
end

function slot0._cancelRaycastTarget(slot0)
	slot0._simageleft:GetComponent(gohelper.Type_Image).raycastTarget = false
	slot0._simageright:GetComponent(gohelper.Type_Image).raycastTarget = false
	slot4 = slot0.viewGO:GetComponentsInChildren(typeof(ZProj.GuideMaskHole), true):GetEnumerator()

	while slot4:MoveNext() do
		slot4.Current.raycastTarget = false
	end
end

function slot0.initSlider(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot4 then
		slot1.slider.maxValue = slot2
		slot1.slider.minValue = slot3
		slot1.slider.value = slot5 or 0

		slot1:AddOnValueChanged(slot4, slot0)

		slot6 = SLFramework.UGUI.UIDragListener.Get(slot1.gameObject)

		slot6:AddDragBeginListener(function (slot0, slot1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				uv0.slider.enabled = false
			end
		end, nil)
		slot6:AddDragEndListener(function (slot0, slot1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				uv0.slider.enabled = true
			end
		end, nil)
		slot6:AddDragListener(function (slot0, slot1)
			slot2 = slot1.delta.x

			if uv0 == uv1._slideroffsetscale then
				if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
					slot2 = (slot1.delta.x < 0 and -0.1 or 0.1) * 0.1
				end
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				slot2 = slot1.delta.x < 0 and -0.1 or 0.1
			end

			uv0:SetValue(uv0:GetValue() + slot2)
		end, nil)
	end
end

function slot0.initTxtOffset(slot0, slot1, slot2)
	SLFramework.UGUI.UIClickListener.Get(slot1.gameObject):AddClickListener(slot0._onClickTextOffset, slot0, {
		slot1,
		slot2
	})
end

function slot0._onClickTextOffset(slot0, slot1)
	slot3 = slot1[2]

	if slot1[1].text == "" then
		return
	end

	slot0._inputoffset:AddOnValueChanged(function (slot0)
		if tonumber(slot0) then
			uv0:SetValue(slot1)
		end
	end, nil)
	slot0._inputoffset:AddOnEndEdit(function (slot0)
		gohelper.setActive(uv0._inputoffset.gameObject, false)
	end, nil)
	gohelper.setActive(slot0._inputoffset.gameObject, true)
	slot0._inputoffset:SetText(math.ceil(slot3:GetValue()))
	recthelper.setAnchorY(slot0._inputoffset.transform, recthelper.rectToRelativeAnchorPos(slot3.transform.position, slot0._inputoffset.transform.parent).y)
end

function slot0._onTipsOffsetXChange(slot0, slot1, slot2)
	slot0._txttipsoffsetx.text = string.format("x:%s", math.ceil(slot2))

	slot0:_onTipsParamValueChange()
end

function slot0._onTipsOffsetYChange(slot0, slot1, slot2)
	slot0._txttipsoffsety.text = string.format("y:%s", math.ceil(slot2))

	slot0:_onTipsParamValueChange()
end

function slot0._onTipsParamValueChange(slot0)
	slot0:updateText()
end

function slot0._onOffsetXChange(slot0, slot1, slot2)
	slot0._txtoffsetx.text = string.format("x:%s", math.ceil(slot2))

	slot0:_onParamValueChange()
end

function slot0._onOffsetYChange(slot0, slot1, slot2)
	slot0._txtoffsety.text = string.format("y:%s", math.ceil(slot2))

	slot0:_onParamValueChange()
end

function slot0._onOffsetArrowXChange(slot0, slot1, slot2)
	slot0._txtoffsetarrowx.text = string.format("x:%s", math.ceil(slot2))

	slot0:_onParamValueChange()
end

function slot0._onOffsetArrowYChange(slot0, slot1, slot2)
	slot0._txtoffsetarrowy.text = string.format("y:%s", math.ceil(slot2))

	slot0:_onParamValueChange()
end

function slot0._onOffsetWChange(slot0, slot1, slot2)
	slot0._txtoffsetw.text = string.format("w:%s", math.ceil(slot2))

	slot0:_onParamValueChange()
end

function slot0._onOffsetHChange(slot0, slot1, slot2)
	slot0._txtoffseth.text = string.format("h:%s", math.ceil(slot2))

	slot0:_onParamValueChange()
end

function slot0._getCorrectValue(slot0, slot1)
	return tonumber(slot1) == 0 and 0 or tonumber(slot1)
end

function slot0._onParamValueChange(slot0)
	slot0:updateGuide()
end

function slot0.initDropUiInfo(slot0)
	slot0._dropUiInfo = gohelper.findChildDropdown(slot0._gocontainer, "#drop_uiInfo")

	slot0._dropUiInfo:AddOnValueChanged(slot0._onUiInfoValueChanged, slot0)

	slot0._uiInfoList = {
		"请选择类型",
		"圆形",
		"矩形",
		"无挖空遮罩",
		"战斗移牌动画",
		"箭头指示动画",
		"长按指示动画",
		"战斗移牌动画2"
	}

	slot0._dropUiInfo:AddOptions(slot0._uiInfoList)
end

function slot0._isArrowType(slot0)
	return slot0._index == GuideEnum.uiTypeArrow or slot0._index == GuideEnum.uiTypePressArrow
end

function slot0._getTargetWidthAndHeight(slot0)
	if slot0._index == GuideEnum.uiTypeArrow and slot0._selectedGo then
		if slot0._selectedGo:GetComponent("RectTransform") then
			slot0._slideroffsetw:SetValue(recthelper.getWidth(slot0._selectedGo.transform))
			slot0._slideroffseth:SetValue(recthelper.getHeight(slot0._selectedGo.transform))
		end

		slot0:updateGuide()
	end
end

function slot0._onUiInfoValueChanged(slot0, slot1)
	slot0._index = slot1

	slot0:_getTargetWidthAndHeight()
	slot0._goarrowxoffset:SetActive(slot0:_isArrowType())
	slot0._goarrowyoffset:SetActive(slot0:_isArrowType())
	slot0:updateGuide()
end

function slot0.updateGuide(slot0)
	if not slot0._index or slot0._index == 0 then
		slot1 = slot0:_createGuideViewParam()

		slot1:initUiType(string.format("%s#%s", GuideEnum.uiTypeNoHole, 0))
		slot1:setUiOffset(string.format("%s#%s", 0, 0))
		ViewMgr.instance:openView(ViewName.GuideStepEditor, slot1)

		return
	end

	slot4 = slot0:_createGuideViewParam()

	slot4:setGoPath(slot0._useGoPath)

	slot0._uiOffset = string.format("%s#%s", slot0:_getCorrectValue(math.ceil(slot0._slideroffsetx:GetValue())), slot0:_getCorrectValue(math.ceil(slot0._slideroffsety:GetValue())))

	slot4:setUiOffset(slot0._uiOffset)

	slot4._isStepEditor = true

	if (slot0._togglemask.isOn and 1 or 0) == 1 then
		slot0:_setUIType(slot4, 0)
		ViewMgr.instance:openView(ViewName.GuideStepEditor, slot4)
	end

	slot0:_setUIType(slot4, slot3)
	ViewMgr.instance:openView(ViewName.GuideStepEditor, slot4)
end

function slot0._setUIType(slot0, slot1, slot2)
	slot3 = slot0:_getCorrectValue(math.ceil(slot0._slideroffsetarrowx:GetValue()))
	slot4 = slot0:_getCorrectValue(math.ceil(slot0._slideroffsetarrowy:GetValue()))
	slot6 = slot0:_getCorrectValue(math.ceil(slot0._slideroffseth:GetValue()))

	if slot0._index == GuideEnum.uiTypeCircle then
		slot0._uiInfo = string.format("%s#%s#%s#%s", slot0._index, slot0:_getCorrectValue(math.ceil(slot0._slideroffsetw:GetValue())), slot2, slot0._toggleshape.isOn and 1 or 0)
	elseif slot0._index == GuideEnum.uiTypeRectangle then
		slot0._uiInfo = string.format("%s#%s#%s#%s#%s", slot0._index, slot5, slot6, slot2, slot7)
	elseif slot0._index == GuideEnum.uiTypeNoHole then
		slot0._uiInfo = string.format("%s#%s", slot0._index, slot2)
	elseif slot0._index == GuideEnum.uiTypeDragCard or slot0._index == GuideEnum.uiTypeDragCard2 then
		slot0._uiInfo = string.format("%s#%s", slot0._index, slot2)
	elseif slot0:_isArrowType() then
		slot0._uiInfo = string.format("%s#%s#%s#%s#%s#%s#%s#%s", slot0._index, 2, slot5, slot6, slot3, slot4, slot2, slot7)
	end

	slot1:initUiType(slot0._uiInfo)
end

function slot0.updateText(slot0)
	slot1 = slot0:_getCorrectValue(math.ceil(slot0._slidertipsoffsetx:GetValue()))
	slot2 = slot0:_getCorrectValue(math.ceil(slot0._slidertipsoffsety:GetValue()))
	slot4 = slot0._toggletip.isOn
	slot5 = slot0:_createGuideViewParam()
	slot5.tipsPos = {
		slot1,
		slot2
	}
	slot0._tipPos = string.format("%s#%s", slot1, slot2)

	slot5:initUiType(string.format("%s#%s", GuideEnum.uiTypeNoHole, 0))
	slot5:setUiOffset(string.format("%s#%s", 0, 0))

	if slot0._toggledialogue.isOn then
		slot5.tipsHead = 302301
		slot5.tipsTalker = "测试名字"
		slot5.hasTips = true
	elseif slot4 then
		slot5.hasTips = true

		slot5:setGoPath(slot0._useGoPath)
	end

	slot5.tipsContent = slot0._inputtext:GetText()

	ViewMgr.instance:openView(ViewName.GuideStepEditor, slot5)
end

function slot0._createGuideViewParam(slot0)
	slot1 = GuideViewParam.New()
	slot1.hasAnyTouchAction = true

	return slot1
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	TaskDispatcher.runRepeat(slot0._frameUpdate, slot0, 0.01)
end

function slot0._frameUpdate(slot0)
	if not UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		return
	end

	if not gohelper.isNil(ZProj.GameHelper.GetLastPointerPress()) and slot1.name ~= "#btn_usego" then
		slot0._selectedGo = slot1

		slot0:_getTargetWidthAndHeight()
	end

	slot0._txttemp.text = gohelper.isNil(slot0._selectedGo) and "请选择对象" or slot0._selectedGo.name

	slot0:_btnusegoOnClick()

	if slot0._showClick then
		slot0:updateGuide()
	end

	if slot0._showText then
		slot0:updateText()
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._frameUpdate, slot0)
	slot0._dropUiInfo:RemoveOnValueChanged()
	slot0:clearSlider(slot0._slideroffsetx)
	slot0:clearSlider(slot0._slideroffsety)
	slot0:clearSlider(slot0._slideroffsetarrowx)
	slot0:clearSlider(slot0._slideroffsetarrowy)
	slot0:clearSlider(slot0._slideroffsetw)
	slot0:clearSlider(slot0._slideroffseth)
	slot0:clearSlider(slot0._slidertipsoffsetx)
	slot0:clearSlider(slot0._slidertipsoffsety)
	slot0._togglemask:RemoveOnValueChanged()
	slot0._toggleshape:RemoveOnValueChanged()
	slot0._toggledialogue:RemoveOnValueChanged()
	slot0._toggletip:RemoveOnValueChanged()
end

function slot0.clearSlider(slot0, slot1)
	slot1:RemoveOnValueChanged()
	slot0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(slot1.gameObject))
end

function slot0.removeDragListener(slot0, slot1)
	slot1:RemoveDragBeginListener()
	slot1:RemoveDragListener()
	slot1:RemoveDragEndListener()
end

function slot0.onDestroyView(slot0)
end

return slot0
