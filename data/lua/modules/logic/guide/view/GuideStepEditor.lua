module("modules.logic.guide.view.GuideStepEditor", package.seeall)

local var_0_0 = class("GuideStepEditor", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_block")
	arg_1_0._gotrigger = gohelper.findChild(arg_1_0.viewGO, "1/#go_trigger")
	arg_1_0._gotrigger1 = gohelper.findChild(arg_1_0.viewGO, "1/#go_trigger/#go_trigger1")
	arg_1_0._gotrigger2 = gohelper.findChild(arg_1_0.viewGO, "1/#go_trigger/#go_trigger2")
	arg_1_0._gotrigger3 = gohelper.findChild(arg_1_0.viewGO, "1/#go_trigger/#go_trigger3")
	arg_1_0._btnsaveTrigger = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "1/#go_trigger/#btn_saveTrigger")
	arg_1_0._gooffset = gohelper.findChild(arg_1_0.viewGO, "1/component/#go_offset")
	arg_1_0._txtoffsetkey = gohelper.findChildText(arg_1_0.viewGO, "1/component/#go_offset/#txt_offsetkey")
	arg_1_0._btnsaveOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "1/component/#go_offset/#btn_saveOffset")
	arg_1_0._btnresetOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "1/component/#go_offset/#btn_resetOffset")
	arg_1_0._btnswitchOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "1/component/#go_offset/#btn_switchOffset")
	arg_1_0._goedit = gohelper.findChild(arg_1_0.viewGO, "#go_edit")
	arg_1_0._goallmodules = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container")
	arg_1_0._txttemp = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/#txt_temp")
	arg_1_0._btnusego = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/#btn_usego")
	arg_1_0._btncopyuiInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/#btn_copyuiInfo")
	arg_1_0._txtuse = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/#txt_use")
	arg_1_0._slideroffsetx = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#slider_offsetx")
	arg_1_0._txtoffsetx = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#txt_offsetx")
	arg_1_0._slideroffsety = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#slider_offsety")
	arg_1_0._txtoffsety = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#txt_offsety")
	arg_1_0._gowidthoffset = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset")
	arg_1_0._slideroffsetw = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset/#slider_offsetw")
	arg_1_0._txtoffsetw = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset/#txt_offsetw")
	arg_1_0._goheightoffset = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset")
	arg_1_0._slideroffseth = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset/#slider_offseth")
	arg_1_0._txtoffseth = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset/#txt_offseth")
	arg_1_0._goarrowxoffset = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset")
	arg_1_0._slideroffsetarrowx = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset/#slider_offsetarrowx")
	arg_1_0._txtoffsetarrowx = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset/#txt_offsetarrowx")
	arg_1_0._goarrowyoffset = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset")
	arg_1_0._slideroffsetarrowy = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset/#slider_offsetarrowy")
	arg_1_0._txtoffsetarrowy = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset/#txt_offsetarrowy")
	arg_1_0._togglemask = gohelper.findChildToggle(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/toggles/#toggle_mask")
	arg_1_0._toggleshape = gohelper.findChildToggle(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_container/toggles/#toggle_shape")
	arg_1_0._gotextContainer = gohelper.findChild(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer")
	arg_1_0._slidertipsoffsetx = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#slider_tipsoffsetx")
	arg_1_0._txttipsoffsetx = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#txt_tipsoffsetx")
	arg_1_0._slidertipsoffsety = gohelper.findChildSlider(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#slider_tipsoffsety")
	arg_1_0._txttipsoffsety = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#txt_tipsoffsety")
	arg_1_0._btnresettextoffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_resettextoffset")
	arg_1_0._btnclearGoPath = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_clearGoPath")
	arg_1_0._btncopytextinfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_copytextinfo")
	arg_1_0._toggletip = gohelper.findChildToggle(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/toggles/#toggle_tip")
	arg_1_0._toggledialogue = gohelper.findChildToggle(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/toggles/#toggle_dialogue")
	arg_1_0._inputtext = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#input_text")
	arg_1_0._btnpaseuipath = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#go_allmodules/#btn_paseuipath")
	arg_1_0._inputuse = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_edit/#go_allmodules/#input_use")
	arg_1_0._inputoffset = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_edit/#go_allmodules/#input_offset")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#btn_switch")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "#go_edit/#btn_switch/#txt_switch")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#btn_close")
	arg_1_0._btnswitchclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#btn_switchclick")
	arg_1_0._btnswitchtext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#btn_switchtext")
	arg_1_0._btnswitchpos = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_edit/#btn_switchpos")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "#go_type4")
	arg_1_0._gotipsmask = gohelper.findChild(arg_1_0.viewGO, "#go_tipsmask")
	arg_1_0._godialogue = gohelper.findChild(arg_1_0.viewGO, "#go_dialogue")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_dialogue/#txt_content")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_dialogue/#txt_name")
	arg_1_0._simageleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_dialogue/left/#simage_left")
	arg_1_0._simageright = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_dialogue/right/#simage_right")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
	arg_2_0._btnsaveTrigger:AddClickListener(arg_2_0._btnsaveTriggerOnClick, arg_2_0)
	arg_2_0._btnsaveOffset:AddClickListener(arg_2_0._btnsaveOffsetOnClick, arg_2_0)
	arg_2_0._btnresetOffset:AddClickListener(arg_2_0._btnresetOffsetOnClick, arg_2_0)
	arg_2_0._btnswitchOffset:AddClickListener(arg_2_0._btnswitchOffsetOnClick, arg_2_0)
	arg_2_0._btnusego:AddClickListener(arg_2_0._btnusegoOnClick, arg_2_0)
	arg_2_0._btncopyuiInfo:AddClickListener(arg_2_0._btncopyuiInfoOnClick, arg_2_0)
	arg_2_0._btnresettextoffset:AddClickListener(arg_2_0._btnresettextoffsetOnClick, arg_2_0)
	arg_2_0._btnclearGoPath:AddClickListener(arg_2_0._btnclearGoPathOnClick, arg_2_0)
	arg_2_0._btncopytextinfo:AddClickListener(arg_2_0._btncopytextinfoOnClick, arg_2_0)
	arg_2_0._btnpaseuipath:AddClickListener(arg_2_0._btnpaseuipathOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnswitchclick:AddClickListener(arg_2_0._btnswitchclickOnClick, arg_2_0)
	arg_2_0._btnswitchtext:AddClickListener(arg_2_0._btnswitchtextOnClick, arg_2_0)
	arg_2_0._btnswitchpos:AddClickListener(arg_2_0._btnswitchposOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnsaveTrigger:RemoveClickListener()
	arg_3_0._btnsaveOffset:RemoveClickListener()
	arg_3_0._btnresetOffset:RemoveClickListener()
	arg_3_0._btnswitchOffset:RemoveClickListener()
	arg_3_0._btnusego:RemoveClickListener()
	arg_3_0._btncopyuiInfo:RemoveClickListener()
	arg_3_0._btnresettextoffset:RemoveClickListener()
	arg_3_0._btnclearGoPath:RemoveClickListener()
	arg_3_0._btncopytextinfo:RemoveClickListener()
	arg_3_0._btnpaseuipath:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnswitchclick:RemoveClickListener()
	arg_3_0._btnswitchtext:RemoveClickListener()
	arg_3_0._btnswitchpos:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtoffsetx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtoffsety.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtoffsetw.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtoffseth.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtoffsetarrowx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txtoffsetarrowy.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txttipsoffsetx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._txttipsoffsety.gameObject):RemoveClickListener()
	arg_3_0._inputtext:RemoveOnValueChanged()
	arg_3_0._inputoffset:RemoveOnValueChanged()
	arg_3_0._inputoffset:RemoveOnEndEdit()
end

function var_0_0._btnswitchposOnClick(arg_4_0)
	arg_4_0._changePos = not arg_4_0._changePos

	if arg_4_0._changePos then
		recthelper.setAnchor(arg_4_0._goedit.transform, -634, -590)
	else
		recthelper.setAnchor(arg_4_0._goedit.transform, 0, 0)
	end
end

function var_0_0._btnclearGoPathOnClick(arg_5_0)
	arg_5_0._selectedGo = nil
	arg_5_0._useGo = arg_5_0._selectedGo
	arg_5_0._useGoPath = ""

	arg_5_0._inputuse:SetText(arg_5_0._useGoPath)

	if arg_5_0._showText then
		arg_5_0:updateText()
	end
end

function var_0_0._btnresettextoffsetOnClick(arg_6_0)
	arg_6_0._slidertipsoffsetx.slider.value = 0
	arg_6_0._slidertipsoffsety.slider.value = 0
end

function var_0_0._btncopytextinfoOnClick(arg_7_0)
	local var_7_0 = arg_7_0._tipPos

	ZProj.UGUIHelper.CopyText(var_7_0)
	print("请粘贴提示框信息：", var_7_0)
end

function var_0_0._btnswitchclickOnClick(arg_8_0)
	arg_8_0:_showModule(true)
	arg_8_0:updateGuide()
end

function var_0_0._btnswitchtextOnClick(arg_9_0)
	arg_9_0:_showModule(false)
	arg_9_0:updateText()
end

function var_0_0._showModule(arg_10_0, arg_10_1)
	arg_10_0._showClick = arg_10_1
	arg_10_0._showText = not arg_10_1

	gohelper.setActive(arg_10_0._gocontainer, arg_10_0._showClick)
	gohelper.setActive(arg_10_0._gotextContainer, arg_10_0._showText)
	gohelper.setActive(arg_10_0._btnswitchtext.gameObject, arg_10_0._showClick)
	gohelper.setActive(arg_10_0._btnswitchclick.gameObject, arg_10_0._showText)
end

function var_0_0._btnpaseuipathOnClick(arg_11_0)
	local var_11_0 = ZProj.UGUIHelper.GetSystemCopyBuffer()

	if string.nilorempty(var_11_0) then
		logError("路径为空")

		return
	end

	local var_11_1 = gohelper.find(var_11_0)

	if gohelper.isNil(var_11_1) then
		logError("找不到路径对应的GameObject：" .. var_11_0)

		return
	end

	arg_11_0._selectedGo = var_11_1

	arg_11_0:_btnusegoOnClick()

	if arg_11_0._showClick then
		arg_11_0:updateGuide()
	end

	if arg_11_0._showText then
		arg_11_0:updateText()
	end
end

function var_0_0._btncopyuiInfoOnClick(arg_12_0)
	local var_12_0 = string.format("%s\t%s\t%s", arg_12_0._uiOffset, arg_12_0._uiInfo, arg_12_0._useGoPath)

	ZProj.UGUIHelper.CopyText(var_12_0)
	print("请粘贴指示框信息：", var_12_0)
end

function var_0_0._btnusegoOnClick(arg_13_0)
	if gohelper.isNil(arg_13_0._selectedGo) then
		return
	end

	local var_13_0
	local var_13_1 = arg_13_0._selectedGo.transform

	while var_13_1 ~= nil do
		if not var_13_0 then
			var_13_0 = var_13_1.name
		else
			var_13_0 = var_13_1.name .. "/" .. var_13_0
		end

		var_13_1 = var_13_1.parent
	end

	arg_13_0._useGo = arg_13_0._selectedGo
	arg_13_0._useGoPath = var_13_0

	arg_13_0._inputuse:SetText(arg_13_0._useGoPath)
end

function var_0_0._btnblockOnClick(arg_14_0)
	return
end

function var_0_0._btnsaveTriggerOnClick(arg_15_0)
	return
end

function var_0_0._btnsaveOffsetOnClick(arg_16_0)
	return
end

function var_0_0._btnresetOffsetOnClick(arg_17_0)
	return
end

function var_0_0._btnswitchOffsetOnClick(arg_18_0)
	return
end

function var_0_0._btncloseOnClick(arg_19_0)
	arg_19_0:closeThis()
end

function var_0_0._btnswitchOnClick(arg_20_0)
	gohelper.setActive(arg_20_0._goallmodules, not arg_20_0._goallmodules.activeSelf)

	if arg_20_0._goallmodules.activeSelf then
		arg_20_0._txtswitch.text = "点击隐藏"
	else
		arg_20_0._txtswitch.text = "点击显示"
	end
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0:initDropUiInfo()
	arg_21_0._goarrowxoffset:SetActive(false)
	arg_21_0._goarrowyoffset:SetActive(false)
	arg_21_0:initSlider(arg_21_0._slideroffsetx, 1500, -1500, arg_21_0._onOffsetXChange)
	arg_21_0:initSlider(arg_21_0._slideroffsety, 1500, -1500, arg_21_0._onOffsetYChange)
	arg_21_0:initSlider(arg_21_0._slideroffsetarrowx, 1500, -1500, arg_21_0._onOffsetArrowXChange)
	arg_21_0:initSlider(arg_21_0._slideroffsetarrowy, 1500, -1500, arg_21_0._onOffsetArrowYChange)
	arg_21_0:initSlider(arg_21_0._slideroffsetw, 3000, -1, arg_21_0._onOffsetWChange, 200)
	arg_21_0:initSlider(arg_21_0._slideroffseth, 1500, -1, arg_21_0._onOffsetHChange, 200)
	arg_21_0:initSlider(arg_21_0._slidertipsoffsetx, 1500, -1500, arg_21_0._onTipsOffsetXChange)
	arg_21_0:initSlider(arg_21_0._slidertipsoffsety, 1500, -1500, arg_21_0._onTipsOffsetYChange)
	arg_21_0._togglemask:AddOnValueChanged(arg_21_0._onParamValueChange, arg_21_0)
	arg_21_0._toggleshape:AddOnValueChanged(arg_21_0._onParamValueChange, arg_21_0)
	arg_21_0._toggledialogue:AddOnValueChanged(arg_21_0._onTipsParamValueChange, arg_21_0)
	arg_21_0._toggletip:AddOnValueChanged(arg_21_0._onTipsParamValueChange, arg_21_0)
	arg_21_0._inputtext:AddOnValueChanged(arg_21_0._inputValueChanged, arg_21_0)
	arg_21_0._inputtext:SetText("这是测试文本！这是测试文本！这是测试文本！")
	arg_21_0:_showModule(true)

	arg_21_0._showContainer = true

	arg_21_0:_cancelRaycastTarget()
	gohelper.setActive(arg_21_0._inputoffset.gameObject, false)
	arg_21_0:initTxtOffset(arg_21_0._txtoffsetx, arg_21_0._slideroffsetx)
	arg_21_0:initTxtOffset(arg_21_0._txtoffsety, arg_21_0._slideroffsety)
	arg_21_0:initTxtOffset(arg_21_0._txtoffsetw, arg_21_0._slideroffsetw)
	arg_21_0:initTxtOffset(arg_21_0._txtoffseth, arg_21_0._slideroffseth)
	arg_21_0:initTxtOffset(arg_21_0._txtoffsetarrowx, arg_21_0._slideroffsetarrowx)
	arg_21_0:initTxtOffset(arg_21_0._txtoffsetarrowy, arg_21_0._slideroffsetarrowy)
	arg_21_0:initTxtOffset(arg_21_0._txttipsoffsetx, arg_21_0._slidertipsoffsetx)
	arg_21_0:initTxtOffset(arg_21_0._txttipsoffsety, arg_21_0._slidertipsoffsety)
end

function var_0_0._inputValueChanged(arg_22_0)
	if arg_22_0._showText then
		arg_22_0:updateText()
	end
end

function var_0_0._cancelRaycastTarget(arg_23_0)
	arg_23_0._simageleft:GetComponent(gohelper.Type_Image).raycastTarget = false
	arg_23_0._simageright:GetComponent(gohelper.Type_Image).raycastTarget = false

	local var_23_0 = arg_23_0.viewGO:GetComponentsInChildren(typeof(ZProj.GuideMaskHole), true):GetEnumerator()

	while var_23_0:MoveNext() do
		var_23_0.Current.raycastTarget = false
	end
end

function var_0_0.initSlider(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	if arg_24_4 then
		arg_24_1.slider.maxValue = arg_24_2
		arg_24_1.slider.minValue = arg_24_3
		arg_24_1.slider.value = arg_24_5 or 0

		arg_24_1:AddOnValueChanged(arg_24_4, arg_24_0)

		local var_24_0 = SLFramework.UGUI.UIDragListener.Get(arg_24_1.gameObject)

		var_24_0:AddDragBeginListener(function(arg_25_0, arg_25_1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				arg_24_1.slider.enabled = false
			end
		end, nil)
		var_24_0:AddDragEndListener(function(arg_26_0, arg_26_1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				arg_24_1.slider.enabled = true
			end
		end, nil)
		var_24_0:AddDragListener(function(arg_27_0, arg_27_1)
			local var_27_0 = arg_27_1.delta.x

			if arg_24_1 == arg_24_0._slideroffsetscale then
				var_27_0 = arg_27_1.delta.x < 0 and -0.1 or 0.1

				if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
					var_27_0 = var_27_0 * 0.1
				end
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				var_27_0 = arg_27_1.delta.x < 0 and -0.1 or 0.1
			end

			arg_24_1:SetValue(arg_24_1:GetValue() + var_27_0)
		end, nil)
	end
end

function var_0_0.initTxtOffset(arg_28_0, arg_28_1, arg_28_2)
	SLFramework.UGUI.UIClickListener.Get(arg_28_1.gameObject):AddClickListener(arg_28_0._onClickTextOffset, arg_28_0, {
		arg_28_1,
		arg_28_2
	})
end

function var_0_0._onClickTextOffset(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1[1]
	local var_29_1 = arg_29_1[2]

	if var_29_0.text == "" then
		return
	end

	arg_29_0._inputoffset:AddOnValueChanged(function(arg_30_0)
		local var_30_0 = tonumber(arg_30_0)

		if var_30_0 then
			var_29_1:SetValue(var_30_0)
		end
	end, nil)
	arg_29_0._inputoffset:AddOnEndEdit(function(arg_31_0)
		gohelper.setActive(arg_29_0._inputoffset.gameObject, false)
	end, nil)
	gohelper.setActive(arg_29_0._inputoffset.gameObject, true)
	arg_29_0._inputoffset:SetText(math.ceil(var_29_1:GetValue()))

	local var_29_2 = recthelper.rectToRelativeAnchorPos(var_29_1.transform.position, arg_29_0._inputoffset.transform.parent)

	recthelper.setAnchorY(arg_29_0._inputoffset.transform, var_29_2.y)
end

function var_0_0._onTipsOffsetXChange(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._txttipsoffsetx.text = string.format("x:%s", math.ceil(arg_32_2))

	arg_32_0:_onTipsParamValueChange()
end

function var_0_0._onTipsOffsetYChange(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._txttipsoffsety.text = string.format("y:%s", math.ceil(arg_33_2))

	arg_33_0:_onTipsParamValueChange()
end

function var_0_0._onTipsParamValueChange(arg_34_0)
	arg_34_0:updateText()
end

function var_0_0._onOffsetXChange(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._txtoffsetx.text = string.format("x:%s", math.ceil(arg_35_2))

	arg_35_0:_onParamValueChange()
end

function var_0_0._onOffsetYChange(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._txtoffsety.text = string.format("y:%s", math.ceil(arg_36_2))

	arg_36_0:_onParamValueChange()
end

function var_0_0._onOffsetArrowXChange(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._txtoffsetarrowx.text = string.format("x:%s", math.ceil(arg_37_2))

	arg_37_0:_onParamValueChange()
end

function var_0_0._onOffsetArrowYChange(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0._txtoffsetarrowy.text = string.format("y:%s", math.ceil(arg_38_2))

	arg_38_0:_onParamValueChange()
end

function var_0_0._onOffsetWChange(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0._txtoffsetw.text = string.format("w:%s", math.ceil(arg_39_2))

	arg_39_0:_onParamValueChange()
end

function var_0_0._onOffsetHChange(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0._txtoffseth.text = string.format("h:%s", math.ceil(arg_40_2))

	arg_40_0:_onParamValueChange()
end

function var_0_0._getCorrectValue(arg_41_0, arg_41_1)
	return tonumber(arg_41_1) == 0 and 0 or tonumber(arg_41_1)
end

function var_0_0._onParamValueChange(arg_42_0)
	arg_42_0:updateGuide()
end

function var_0_0.initDropUiInfo(arg_43_0)
	arg_43_0._dropUiInfo = gohelper.findChildDropdown(arg_43_0._gocontainer, "#drop_uiInfo")

	arg_43_0._dropUiInfo:AddOnValueChanged(arg_43_0._onUiInfoValueChanged, arg_43_0)

	arg_43_0._uiInfoList = {
		"请选择类型",
		"圆形",
		"矩形",
		"无挖空遮罩",
		"战斗移牌动画",
		"箭头指示动画",
		"长按指示动画",
		"战斗移牌动画2"
	}

	arg_43_0._dropUiInfo:AddOptions(arg_43_0._uiInfoList)
end

function var_0_0._isArrowType(arg_44_0)
	return arg_44_0._index == GuideEnum.uiTypeArrow or arg_44_0._index == GuideEnum.uiTypePressArrow
end

function var_0_0._getTargetWidthAndHeight(arg_45_0)
	if arg_45_0._index == GuideEnum.uiTypeArrow and arg_45_0._selectedGo then
		if arg_45_0._selectedGo:GetComponent("RectTransform") then
			local var_45_0 = recthelper.getWidth(arg_45_0._selectedGo.transform)
			local var_45_1 = recthelper.getHeight(arg_45_0._selectedGo.transform)

			arg_45_0._slideroffsetw:SetValue(var_45_0)
			arg_45_0._slideroffseth:SetValue(var_45_1)
		end

		arg_45_0:updateGuide()
	end
end

function var_0_0._onUiInfoValueChanged(arg_46_0, arg_46_1)
	arg_46_0._index = arg_46_1

	arg_46_0:_getTargetWidthAndHeight()
	arg_46_0._goarrowxoffset:SetActive(arg_46_0:_isArrowType())
	arg_46_0._goarrowyoffset:SetActive(arg_46_0:_isArrowType())
	arg_46_0:updateGuide()
end

function var_0_0.updateGuide(arg_47_0)
	if not arg_47_0._index or arg_47_0._index == 0 then
		local var_47_0 = arg_47_0:_createGuideViewParam()

		var_47_0:initUiType(string.format("%s#%s", GuideEnum.uiTypeNoHole, 0))
		var_47_0:setUiOffset(string.format("%s#%s", 0, 0))
		ViewMgr.instance:openView(ViewName.GuideStepEditor, var_47_0)

		return
	end

	local var_47_1 = arg_47_0:_getCorrectValue(math.ceil(arg_47_0._slideroffsetx:GetValue()))
	local var_47_2 = arg_47_0:_getCorrectValue(math.ceil(arg_47_0._slideroffsety:GetValue()))
	local var_47_3 = arg_47_0._togglemask.isOn and 1 or 0
	local var_47_4 = arg_47_0:_createGuideViewParam()

	var_47_4:setGoPath(arg_47_0._useGoPath)

	arg_47_0._uiOffset = string.format("%s#%s", var_47_1, var_47_2)

	var_47_4:setUiOffset(arg_47_0._uiOffset)

	var_47_4._isStepEditor = true

	if var_47_3 == 1 then
		arg_47_0:_setUIType(var_47_4, 0)
		ViewMgr.instance:openView(ViewName.GuideStepEditor, var_47_4)
	end

	arg_47_0:_setUIType(var_47_4, var_47_3)
	ViewMgr.instance:openView(ViewName.GuideStepEditor, var_47_4)
end

function var_0_0._setUIType(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:_getCorrectValue(math.ceil(arg_48_0._slideroffsetarrowx:GetValue()))
	local var_48_1 = arg_48_0:_getCorrectValue(math.ceil(arg_48_0._slideroffsetarrowy:GetValue()))
	local var_48_2 = arg_48_0:_getCorrectValue(math.ceil(arg_48_0._slideroffsetw:GetValue()))
	local var_48_3 = arg_48_0:_getCorrectValue(math.ceil(arg_48_0._slideroffseth:GetValue()))
	local var_48_4 = arg_48_0._toggleshape.isOn and 1 or 0

	if arg_48_0._index == GuideEnum.uiTypeCircle then
		arg_48_0._uiInfo = string.format("%s#%s#%s#%s", arg_48_0._index, var_48_2, arg_48_2, var_48_4)
	elseif arg_48_0._index == GuideEnum.uiTypeRectangle then
		arg_48_0._uiInfo = string.format("%s#%s#%s#%s#%s", arg_48_0._index, var_48_2, var_48_3, arg_48_2, var_48_4)
	elseif arg_48_0._index == GuideEnum.uiTypeNoHole then
		arg_48_0._uiInfo = string.format("%s#%s", arg_48_0._index, arg_48_2)
	elseif arg_48_0._index == GuideEnum.uiTypeDragCard or arg_48_0._index == GuideEnum.uiTypeDragCard2 then
		arg_48_0._uiInfo = string.format("%s#%s", arg_48_0._index, arg_48_2)
	elseif arg_48_0:_isArrowType() then
		arg_48_0._uiInfo = string.format("%s#%s#%s#%s#%s#%s#%s#%s", arg_48_0._index, 2, var_48_2, var_48_3, var_48_0, var_48_1, arg_48_2, var_48_4)
	end

	arg_48_1:initUiType(arg_48_0._uiInfo)
end

function var_0_0.updateText(arg_49_0)
	local var_49_0 = arg_49_0:_getCorrectValue(math.ceil(arg_49_0._slidertipsoffsetx:GetValue()))
	local var_49_1 = arg_49_0:_getCorrectValue(math.ceil(arg_49_0._slidertipsoffsety:GetValue()))
	local var_49_2 = arg_49_0._toggledialogue.isOn
	local var_49_3 = arg_49_0._toggletip.isOn
	local var_49_4 = arg_49_0:_createGuideViewParam()

	var_49_4.tipsPos = {
		var_49_0,
		var_49_1
	}
	arg_49_0._tipPos = string.format("%s#%s", var_49_0, var_49_1)

	var_49_4:initUiType(string.format("%s#%s", GuideEnum.uiTypeNoHole, 0))
	var_49_4:setUiOffset(string.format("%s#%s", 0, 0))

	if var_49_2 then
		var_49_4.tipsHead = 302301
		var_49_4.tipsTalker = "测试名字"
		var_49_4.hasTips = true
	elseif var_49_3 then
		var_49_4.hasTips = true

		var_49_4:setGoPath(arg_49_0._useGoPath)
	end

	var_49_4.tipsContent = arg_49_0._inputtext:GetText()

	ViewMgr.instance:openView(ViewName.GuideStepEditor, var_49_4)
end

function var_0_0._createGuideViewParam(arg_50_0)
	local var_50_0 = GuideViewParam.New()

	var_50_0.hasAnyTouchAction = true

	return var_50_0
end

function var_0_0.onUpdateParam(arg_51_0)
	return
end

function var_0_0.onOpen(arg_52_0)
	TaskDispatcher.runRepeat(arg_52_0._frameUpdate, arg_52_0, 0.01)
end

function var_0_0._frameUpdate(arg_53_0)
	if not UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		return
	end

	local var_53_0 = ZProj.GameHelper.GetLastPointerPress()

	if not gohelper.isNil(var_53_0) and var_53_0.name ~= "#btn_usego" then
		arg_53_0._selectedGo = var_53_0

		arg_53_0:_getTargetWidthAndHeight()
	end

	arg_53_0._txttemp.text = gohelper.isNil(arg_53_0._selectedGo) and "请选择对象" or arg_53_0._selectedGo.name

	arg_53_0:_btnusegoOnClick()

	if arg_53_0._showClick then
		arg_53_0:updateGuide()
	end

	if arg_53_0._showText then
		arg_53_0:updateText()
	end
end

function var_0_0.onClose(arg_54_0)
	TaskDispatcher.cancelTask(arg_54_0._frameUpdate, arg_54_0)
	arg_54_0._dropUiInfo:RemoveOnValueChanged()
	arg_54_0:clearSlider(arg_54_0._slideroffsetx)
	arg_54_0:clearSlider(arg_54_0._slideroffsety)
	arg_54_0:clearSlider(arg_54_0._slideroffsetarrowx)
	arg_54_0:clearSlider(arg_54_0._slideroffsetarrowy)
	arg_54_0:clearSlider(arg_54_0._slideroffsetw)
	arg_54_0:clearSlider(arg_54_0._slideroffseth)
	arg_54_0:clearSlider(arg_54_0._slidertipsoffsetx)
	arg_54_0:clearSlider(arg_54_0._slidertipsoffsety)
	arg_54_0._togglemask:RemoveOnValueChanged()
	arg_54_0._toggleshape:RemoveOnValueChanged()
	arg_54_0._toggledialogue:RemoveOnValueChanged()
	arg_54_0._toggletip:RemoveOnValueChanged()
end

function var_0_0.clearSlider(arg_55_0, arg_55_1)
	arg_55_1:RemoveOnValueChanged()
	arg_55_0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(arg_55_1.gameObject))
end

function var_0_0.removeDragListener(arg_56_0, arg_56_1)
	arg_56_1:RemoveDragBeginListener()
	arg_56_1:RemoveDragListener()
	arg_56_1:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_57_0)
	return
end

return var_0_0
