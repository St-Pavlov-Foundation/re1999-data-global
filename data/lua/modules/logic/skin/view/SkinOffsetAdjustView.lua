module("modules.logic.skin.view.SkinOffsetAdjustView", package.seeall)

local var_0_0 = class("SkinOffsetAdjustView", BaseView)
local var_0_1 = 5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_block")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gotrigger = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger")
	arg_1_0._gotrigger34 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger3_4")
	arg_1_0._gotrigger33 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger3_3")
	arg_1_0._gotrigger32 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger3_2")
	arg_1_0._gotrigger31 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger3_1")
	arg_1_0._gotrigger14 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger1_4")
	arg_1_0._gotrigger13 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger1_3")
	arg_1_0._gotrigger12 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger1_2")
	arg_1_0._gotrigger11 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger1_1")
	arg_1_0._gotrigger24 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger2_4")
	arg_1_0._gotrigger23 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger2_3")
	arg_1_0._gotrigger22 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger2_2")
	arg_1_0._gotrigger21 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger2_1")
	arg_1_0._gotrigger44 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger4_4")
	arg_1_0._gotrigger43 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger4_3")
	arg_1_0._gotrigger42 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger4_2")
	arg_1_0._gotrigger41 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger4_1")
	arg_1_0._gotrigger54 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger5_4")
	arg_1_0._gotrigger53 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger5_3")
	arg_1_0._gotrigger52 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger5_2")
	arg_1_0._gotrigger51 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_trigger/#go_trigger5_1")
	arg_1_0._btnsaveTrigger = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_trigger/#btn_saveTrigger")
	arg_1_0._gooffset = gohelper.findChild(arg_1_0.viewGO, "#go_container/component/#go_offset")
	arg_1_0._txtoffsetkey = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/#go_offset/#txt_offsetkey")
	arg_1_0._txtoffsetParentKey = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/#go_offset/#txt_offsetParentKey")
	arg_1_0._txtoffsetValue = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/#go_offset/#txt_offsetValue")
	arg_1_0._slideroffsetx = gohelper.findChildSlider(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/offset1/#slider_offsetx")
	arg_1_0._txtoffsetx = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/offset1/#txt_offsetx")
	arg_1_0._slideroffsety = gohelper.findChildSlider(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/offset2/#slider_offsety")
	arg_1_0._txtoffsety = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/offset2/#txt_offsety")
	arg_1_0._slideroffsetscale = gohelper.findChildSlider(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/offset3/#slider_offsetscale")
	arg_1_0._txtoffsetscale = gohelper.findChildText(arg_1_0.viewGO, "#go_container/component/#go_offset/offsets/offset3/#txt_offsetscale")
	arg_1_0._btnsaveOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#go_offset/#btn_saveOffset")
	arg_1_0._btnresetOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#go_offset/#btn_resetOffset")
	arg_1_0._btnswitchOffset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#go_offset/#btn_switchOffset")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/component/#btn_close")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "#btn_switch/#txt_switch")

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
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnsaveTrigger:RemoveClickListener()
	arg_3_0._btnsaveOffset:RemoveClickListener()
	arg_3_0._btnresetOffset:RemoveClickListener()
	arg_3_0._btnswitchOffset:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
end

var_0_0.key2ParentKeyConstIdDict = {
	mainThumbnailViewOffset = 506,
	playercardViewImgOffset = 507,
	fightSuccViewOffset = 504,
	fullScreenLive2dOffset = 507,
	playercardViewLive2dOffset = 507,
	characterRankUpViewOffset = 503,
	characterGetViewOffset = 505,
	characterDataTitleViewOffset = 501,
	characterDataVoiceViewOffset = 502
}

function var_0_0._btnswitchOffsetOnClick(arg_4_0)
	if arg_4_0._curOffsetKey == "haloOffset" then
		arg_4_0:_onCharacterViewUpdate()
	else
		arg_4_0:_onCharacterHoloUpdate()
	end
end

function var_0_0._btnswitchOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gocontainer, not arg_5_0._gocontainer.activeSelf)

	if arg_5_0._gocontainer.activeSelf then
		arg_5_0._txtswitch.text = "点击隐藏"
	else
		arg_5_0._txtswitch.text = "点击显示"
	end
end

function var_0_0._btnresetOffsetOnClick(arg_6_0)
	SkinOffsetAdjustModel.instance:resetTempOffset(arg_6_0._curSkinInfo, arg_6_0._curOffsetKey)

	local var_6_0, var_6_1, var_6_2 = SkinOffsetAdjustModel.instance:getOffset(arg_6_0._curSkinInfo, arg_6_0._curOffsetKey)

	arg_6_0:initSliderValue(var_6_0, var_6_1, var_6_2)
	arg_6_0._changeOffsetCallback(var_6_0, var_6_1, var_6_2)
end

function var_0_0._btnsaveTriggerOnClick(arg_7_0)
	for iter_7_0 = 1, var_0_1 do
		arg_7_0:saveTrigger(iter_7_0)
	end
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btnsaveOffsetOnClick(arg_9_0)
	if not arg_9_0._curViewInfo or not arg_9_0._curSkinInfo then
		return
	end

	local var_9_0 = string.format(arg_9_0:_getXPrecision(), arg_9_0._slideroffsetx:GetValue())
	local var_9_1 = string.format(arg_9_0:_getYPrecision(), arg_9_0._slideroffsety:GetValue())
	local var_9_2 = string.format(arg_9_0:_getSPrecision(), arg_9_0._slideroffsetscale:GetValue())

	if arg_9_0._curOffsetKey == "decorateskinOffset" or arg_9_0._curOffsetKey == "decorateskinl2dOffset" or arg_9_0._curOffsetKey == "decorateskinl2dBgOffset" then
		logError(string.format("%s#%s#%s", var_9_0, var_9_1, var_9_2))

		return
	end

	SkinOffsetAdjustModel.instance:setOffset(arg_9_0._curSkinInfo, arg_9_0._curOffsetKey, var_9_0, var_9_1, var_9_2)
end

function var_0_0._btnblockOnClick(arg_10_0)
	arg_10_0.isShowSkinContainer = false
	arg_10_0.isShowViewContainer = false

	gohelper.setActive(arg_10_0._goskinscroll, false)
	gohelper.setActive(arg_10_0._goviewcroll, false)
end

function var_0_0.onSkinContainerClick(arg_11_0)
	gohelper.setActive(arg_11_0._goskinscroll, true)

	arg_11_0.isShowSkinContainer = true

	SkinOffsetSkinListModel.instance:initSkinList()
end

function var_0_0.onViewContainerClick(arg_12_0)
	if arg_12_0.isShowViewContainer then
		arg_12_0:_btnblockOnClick()

		return
	end

	gohelper.setActive(arg_12_0._goviewcroll, true)

	arg_12_0.isShowViewContainer = true
end

function var_0_0._onDragBegin(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.startDragPosX = arg_13_2.position.x
end

function var_0_0._onDragEnd(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2.position.x

	if math.abs(var_14_0 - arg_14_0.startDragPosX) > 30 then
		if var_14_0 < arg_14_0.startDragPosX then
			SkinOffsetSkinListModel.instance:slideNext()
		else
			SkinOffsetSkinListModel.instance:slidePre()
		end
	end
end

function var_0_0._editableInitView(arg_15_0)
	SkinOffsetSkinListModel.instance:initOriginSkinList()
	SkinOffsetSkinListModel.instance:setScrollView(arg_15_0)

	arg_15_0.drag = SLFramework.UGUI.UIDragListener.Get(arg_15_0._btnblock.gameObject)

	arg_15_0.drag:AddDragBeginListener(arg_15_0._onDragBegin, arg_15_0)
	arg_15_0.drag:AddDragEndListener(arg_15_0._onDragEnd, arg_15_0)

	arg_15_0._simageList = arg_15_0:getUserDataTb_()

	gohelper.setLayer(arg_15_0.viewGO, UnityLayer.UITop, true)

	arg_15_0._goskincontainer = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_skincontainer")
	arg_15_0._goskinscroll = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_skincontainer/#scroll_skin")
	arg_15_0._goskinscrollrect = SLFramework.UGUI.ScrollRectWrap.Get(arg_15_0._goskinscroll)
	arg_15_0._inputSkinLabel = gohelper.findChildTextMeshInputField(arg_15_0.viewGO, "#go_container/component/#go_skincontainer/input_label")

	arg_15_0._inputSkinLabel:AddOnValueChanged(arg_15_0.onSkinInputValueChanged, arg_15_0)

	arg_15_0.goFullSkinContainer = gohelper.findChild(arg_15_0.viewGO, "fullSkinContainer")
	arg_15_0._inputCameraSize = gohelper.findChildTextMeshInputField(arg_15_0.viewGO, "fullSkinContainer/camera_input")

	arg_15_0._inputCameraSize:AddOnValueChanged(arg_15_0.onCameraSizeInput, arg_15_0)

	arg_15_0._txtScale = gohelper.findChildText(arg_15_0.viewGO, "fullSkinContainer/txt_scale")
	arg_15_0._btnSearch = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "#go_container/component/#go_skincontainer/input_label/#btn_search")

	arg_15_0._btnSearch:AddClickListener(arg_15_0.onClickSearch, arg_15_0)

	arg_15_0._goviewcontainer = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_viewcontainer")
	arg_15_0._goviewcroll = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_viewcontainer/#scroll_view")
	arg_15_0._txtviewlabel = gohelper.findChildText(arg_15_0.viewGO, "#go_container/component/#go_viewcontainer/#txt_label")
	arg_15_0._goviewitem = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_viewcontainer/#scroll_view/Viewport/Content/item")

	gohelper.setActive(arg_15_0._goviewitem, false)

	arg_15_0._goskincontainerclick = gohelper.getClick(arg_15_0._inputSkinLabel.gameObject)

	arg_15_0._goskincontainerclick:AddClickListener(arg_15_0.onSkinContainerClick, arg_15_0)

	arg_15_0._goviewcontainerclick = gohelper.getClick(arg_15_0._goviewcontainer)

	arg_15_0._goviewcontainerclick:AddClickListener(arg_15_0.onViewContainerClick, arg_15_0)
	arg_15_0:_initViewList()
	arg_15_0:_initSkinList()
	arg_15_0:initSlider(arg_15_0._slideroffsetx, 2000, -2000, arg_15_0._onOffsetXChange)
	arg_15_0:initSlider(arg_15_0._slideroffsety, 2000, -2000, arg_15_0._onOffsetYChange)
	arg_15_0:initSlider(arg_15_0._slideroffsetscale, 3, 0, arg_15_0._onOffsetScaleChange)

	arg_15_0._goOffset1 = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_offset/offsets/offset1")
	arg_15_0._goOffset2 = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_offset/offsets/offset2")
	arg_15_0._goOffset3 = gohelper.findChild(arg_15_0.viewGO, "#go_container/component/#go_offset/offsets/offset3")
	arg_15_0._btnList = {}

	arg_15_0:initOffsetItem(arg_15_0._goOffset1, arg_15_0._slideroffsetx, "x")
	arg_15_0:initOffsetItem(arg_15_0._goOffset2, arg_15_0._slideroffsety, "y")
	arg_15_0:initOffsetItem(arg_15_0._goOffset3, arg_15_0._slideroffsetscale, "s")
	gohelper.setActive(arg_15_0._gooffset, false)
	gohelper.setActive(arg_15_0._btnswitchOffset.gameObject, false)

	arg_15_0._txtoffsetParentKey.text = ""
	arg_15_0._txtoffsetValue.text = ""
end

function var_0_0.setSkinScrollRectVertical(arg_16_0, arg_16_1)
	arg_16_0._goskinscrollrect.verticalNormalizedPosition = arg_16_1
end

function var_0_0.initSlider(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4 then
		arg_17_1:AddOnValueChanged(arg_17_4, arg_17_0)

		local var_17_0 = SLFramework.UGUI.UIDragListener.Get(arg_17_1.gameObject)

		var_17_0:AddDragBeginListener(function(arg_18_0, arg_18_1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				arg_17_1.slider.enabled = false
			end
		end, nil)
		var_17_0:AddDragEndListener(function(arg_19_0, arg_19_1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				arg_17_1.slider.enabled = true
			end
		end, nil)
		var_17_0:AddDragListener(function(arg_20_0, arg_20_1)
			local var_20_0 = arg_20_1.delta.x

			if arg_17_1 == arg_17_0._slideroffsetscale then
				var_20_0 = arg_20_1.delta.x < 0 and -0.1 or 0.1

				if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
					var_20_0 = var_20_0 * 0.1
				end
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				var_20_0 = arg_20_1.delta.x < 0 and -0.1 or 0.1
			end

			arg_17_1:SetValue(arg_17_1:GetValue() + var_20_0)
		end, nil)
	end

	arg_17_1.slider.maxValue = arg_17_2
	arg_17_1.slider.minValue = arg_17_3
end

function var_0_0.initOffsetItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = gohelper.findChildButtonWithAudio(arg_21_1, "AddBtn")
	local var_21_1 = gohelper.findChildButtonWithAudio(arg_21_1, "ReduceBtn")
	local var_21_2 = gohelper.findChildTextMeshInputField(arg_21_1, "IntervalField")

	var_21_2:SetText(1)
	var_21_0:AddClickListener(arg_21_0.addBtnClick, arg_21_0, {
		intervalField = var_21_2,
		slider = arg_21_2,
		propName = arg_21_3
	})
	var_21_1:AddClickListener(arg_21_0.reduceBtnClick, arg_21_0, {
		intervalField = var_21_2,
		slider = arg_21_2,
		propName = arg_21_3
	})
	table.insert(arg_21_0._btnList, var_21_0)
	table.insert(arg_21_0._btnList, var_21_1)
end

function var_0_0.addBtnClick(arg_22_0, arg_22_1)
	local var_22_0 = tonumber(arg_22_1.intervalField:GetText())
	local var_22_1 = tonumber(arg_22_1.slider:GetValue())

	arg_22_1.slider:SetValue(var_22_1 + var_22_0)
end

function var_0_0.reduceBtnClick(arg_23_0, arg_23_1)
	local var_23_0 = tonumber(arg_23_1.intervalField:GetText())
	local var_23_1 = tonumber(arg_23_1.slider:GetValue())

	arg_23_1.slider:SetValue(var_23_1 - var_23_0)
end

function var_0_0._onOffsetXChange(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._txtoffsetx.text = string.format("x:" .. arg_24_0:_getXPrecision(), arg_24_2)

	arg_24_0:_onOffsetChange()
end

function var_0_0._onOffsetYChange(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._txtoffsety.text = string.format("y:" .. arg_25_0:_getYPrecision(), arg_25_2)

	arg_25_0:_onOffsetChange()
end

function var_0_0._onOffsetScaleChange(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._txtoffsetscale.text = string.format("s:" .. arg_26_0:_getSPrecision(), arg_26_2)

	arg_26_0:_onOffsetChange()
end

function var_0_0._onOffsetChange(arg_27_0)
	if arg_27_0._changeOffsetCallback then
		local var_27_0 = string.format(arg_27_0:_getXPrecision(), arg_27_0._slideroffsetx:GetValue())
		local var_27_1 = string.format(arg_27_0:_getYPrecision(), arg_27_0._slideroffsety:GetValue())
		local var_27_2 = string.format(arg_27_0:_getSPrecision(), arg_27_0._slideroffsetscale:GetValue())

		SkinOffsetAdjustModel.instance:setTempOffset(arg_27_0._curSkinInfo, arg_27_0._curOffsetKey, tonumber(var_27_0), tonumber(var_27_1), tonumber(var_27_2))
		arg_27_0._changeOffsetCallback(tonumber(var_27_0), tonumber(var_27_1), tonumber(var_27_2))
	end
end

function var_0_0.initSliderValue(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._slideroffsetx:SetValue(arg_28_1)
	arg_28_0._slideroffsety:SetValue(arg_28_2)
	arg_28_0._slideroffsetscale:SetValue(arg_28_3)

	arg_28_0._txtoffsetx.text = string.format("x:" .. arg_28_0:_getXPrecision(), arg_28_1)
	arg_28_0._txtoffsety.text = string.format("y:" .. arg_28_0:_getYPrecision(), arg_28_2)
	arg_28_0._txtoffsetscale.text = string.format("s:" .. arg_28_0:_getSPrecision(), arg_28_3)
end

function var_0_0._getXPrecision(arg_29_0)
	return "%." .. (arg_29_0._precisionDefine and arg_29_0._precisionDefine.x or 1) .. "f"
end

function var_0_0._getYPrecision(arg_30_0)
	return "%." .. (arg_30_0._precisionDefine and arg_30_0._precisionDefine.y or 1) .. "f"
end

function var_0_0._getSPrecision(arg_31_0)
	return "%." .. (arg_31_0._precisionDefine and arg_31_0._precisionDefine.s or 2) .. "f"
end

function var_0_0._initSkinList(arg_32_0)
	SkinOffsetSkinListModel.instance:initSkinList()
	arg_32_0:_btnblockOnClick()
end

function var_0_0._initViewList(arg_33_0)
	arg_33_0._viewList = {}
	arg_33_0._viewNameList = {}

	table.insert(arg_33_0._viewNameList, "0#动态立绘(常量表的501~505设置相对偏移)")
	arg_33_0:_addView("主界面", ViewName.MainView, arg_33_0._onMainViewOpen, arg_33_0._onMainViewUpdate, "UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine", "mainViewOffset")
	arg_33_0:_addView("相框", ViewName.MainView, arg_33_0._onMainViewFrameOpen, arg_33_0._onMainViewFrameUpdate, "UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine", "mainViewFrameOffset")
	arg_33_0:_addView("主界面缩略图界面", ViewName.MainThumbnailView, arg_33_0.onMainThumbnailViewOpen, arg_33_0.onMainThumbnailViewUpdate, "UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine/#go_lightspine", "mainThumbnailViewOffset", "mainViewOffset")
	arg_33_0:_addView("角色切换界面 -> 复用主界面, 不能特殊设置", ViewName.CharacterSwitchView, arg_33_0._onCommonCharacterViewOpen, arg_33_0._onCharacterSwitchUpdate, "UIRoot/POPUP_TOP/CharacterSwitchView/#go_spine_scale/lightspine/#go_lightspine", "mainViewOffset")
	arg_33_0:_addView("角色界面", ViewName.CharacterView, arg_33_0._onCharacterViewOpen, arg_33_0._onCharacterViewUpdate, "UIRoot/POPUP_TOP/CharacterView/anim/#go_herocontainer/dynamiccontainer/#go_spine", "characterViewOffset")
	arg_33_0:_addView("洞悉界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterRankUpView, arg_33_0._onCommonCharacterViewOpen, arg_33_0._onCharacterRankUpViewUpdate, "UIRoot/POPUP_TOP/CharacterRankUpView/spineContainer/#go_spine", "characterRankUpViewOffset", "characterViewOffset")
	arg_33_0:_addView("结算界面 -> 复用角色界面, 可以特殊设置", ViewName.FightSuccView, arg_33_0._onCommonCharacterViewOpen, arg_33_0._onCharacterRankUpViewUpdate, "UIRoot/POPUP_TOP/FightSuccView/spineContainer/spine", "fightSuccViewOffset", "characterViewOffset")
	arg_33_0:_addView("角色获得界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterGetView, arg_33_0._onCharacterGetViewOpen, arg_33_0._onCharacterRankUpViewUpdate, "UIRoot/POPUP_TOP/CharacterGetView/charactercontainer/#go_spine", "characterGetViewOffset", "characterViewOffset")
	arg_33_0:_addView("角色封面界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterDataView, arg_33_0._onCharacterDataViewOpen, arg_33_0._onCharacterSkinViewUpdate, "UIRoot/POPUP_SECOND/CharacterDataView/content/characterdatatitleview(Clone)/content/character/charactericoncontainer/#go_spine", "characterDataTitleViewOffset", "characterViewOffset")
	arg_33_0:_addView("语音界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterDataView, arg_33_0._onCharacterDataViewOpen, arg_33_0._onCharacterDataVoiceViewUpdate, "UIRoot/POPUP_SECOND/CharacterDataView/content/characterdatavoiceview(Clone)/content/#simage_characterbg/charactercontainer/#go_spine", "characterDataVoiceViewOffset", "characterViewOffset")
	arg_33_0:_addView("个人名片 -> 复用角色界面, 可以特殊设置", ViewName.PlayerCardView, arg_33_0._onPlayerCardViewOpen, arg_33_0._onPlayerCardViewUpdate, "UIRoot/POPUP_TOP/NewPlayerCardContentView/view", "playercardViewLive2dOffset", "characterViewOffset")
	arg_33_0:_addView("装饰商店", ViewName.StoreView, arg_33_0._onDecorateStoreViewOpen, arg_33_0._onDecorateStoreViewUpdate, "UIRoot/POPUP_TOP/StoreView/#go_store/decoratestoreview(Clone)/Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer", "decorateskinl2dOffset")
	table.insert(arg_33_0._viewNameList, "0#静态立绘")
	arg_33_0:_addView("角色封面界面静态立绘偏移", ViewName.CharacterDataView, arg_33_0._onCharacterDataViewOpenFromHandbook, arg_33_0._onCharacterStaticSkinViewUpdate, "UIRoot/POPUP_SECOND/CharacterDataView/content/characterdatatitleview(Clone)/content/character/#simage_characterstaticskin", "characterTitleViewStaticOffset")
	arg_33_0:_addView("皮肤界面静态立绘", ViewName.CharacterSkinView, arg_33_0._onCharacterSkinSwitchViewOpen, arg_33_0._onCharacterSkinStaticDrawingViewUpdate1, "UIRoot/POPUP_TOP/CharacterSkinView/characterSpine/#go_skincontainer/#simage_skin", "skinViewImgOffset")
	arg_33_0:_addView("皮肤获得界面静态立绘", ViewName.CharacterSkinGainView, arg_33_0._onCharacterSkinGainViewOpen, arg_33_0._onCharacterSkinStaticDrawingViewUpdate, "UIRoot/POPUP_TOP/CharacterSkinGainView/root/bgroot/#go_skincontainer/#simage_icon", "skinGainViewImgOffset")
	arg_33_0:_addView("角色界面静态立绘", ViewName.CharacterView, arg_33_0._onCharacterViewChangeStaticDrawingOpen, arg_33_0._onCharacterViewSkinStaticDrawingViewUpdate, "UIRoot/POPUP_TOP/CharacterView/anim/#go_herocontainer/staticcontainer/#simage_static", "characterViewImgOffset")
	arg_33_0:_addView("招募界面静态立绘", ViewName.SummonHeroDetailView, arg_33_0._onCharacterGetViewOpen, arg_33_0._onCharacterSkinStaticDrawingViewUpdate, "UIRoot/POPUP_TOP/SummonHeroDetailView/charactercontainer/#simage_character", "summonHeroViewOffset")
	arg_33_0:_addView("个人名片", ViewName.PlayerCardView, arg_33_0._onPlayerCardViewOpen, arg_33_0._onPlayerCardViewStaticDrawingUpdate, "UIRoot/POPUP_TOP/NewPlayerCardContentView/view", "playercardViewImgOffset", "characterViewImgOffset")
	arg_33_0:_addView("装饰商店静态立绘", ViewName.StoreView, arg_33_0._onDecorateStoreStaticViewOpen, arg_33_0._onDecorateStoreStaticViewUpdate, "UIRoot/POPUP_TOP/StoreView/#go_store/decoratestoreview(Clone)/Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer", "decorateskinOffset")
	arg_33_0:_addView("6选3Up", ViewName.SummonThreeCustomPickView, arg_33_0._onSummonCustomThreePickOpen, arg_33_0._onSummonCustomThreePickDataUpdate, "UIRoot/POPUP_TOP/SummonThreeCustomPickView/#go_ui/current/#go_selected/#go_role%s/#simage_role%s", "summonPickUpImgOffset")
	table.insert(arg_33_0._viewNameList, "0#spine小人")
	arg_33_0:_addView("皮肤界面小人Spine", ViewName.CharacterSkinView, arg_33_0._onCharacterSkinSwitchViewOpen, arg_33_0._onCharacterSkinSwitchViewUpdate, "UIRoot/POPUP_TOP/CharacterSkinView/smalldynamiccontainer/#go_smallspine", "skinSpineOffset")
	table.insert(arg_33_0._viewNameList, "0#皮肤放大缩小界面")
	arg_33_0:_addView("皮肤放大缩小界面live2d", ViewName.CharacterSkinFullScreenView, arg_33_0._onCharacterSkinFullViewOpen, arg_33_0._onCharacterSkinFullViewUpdate, "UIRoot/POPUP_TOP/CharacterSkinFullScreenView/#go_scroll/dynamicContainer/#go_spinecontainer/#go_spine", "fullScreenLive2dOffset", "characterViewOffset", arg_33_0.beforeOpenSkinFullView, arg_33_0.beforeCloseSkinFullView)
	arg_33_0:initViewItem()
end

function var_0_0._addView(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6, arg_34_7, arg_34_8, arg_34_9)
	local var_34_0 = {
		viewInfo = {
			arg_34_1,
			arg_34_2,
			arg_34_3,
			arg_34_4,
			arg_34_5,
			arg_34_6,
			arg_34_7
		},
		beforeOpenView = arg_34_8,
		beforeCloseView = arg_34_9
	}

	table.insert(arg_34_0._viewList, var_34_0)
	table.insert(arg_34_0._viewNameList, arg_34_1)
end

function var_0_0.initViewItem(arg_35_0)
	local var_35_0 = 0
	local var_35_1

	arg_35_0.viewItemList = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0._viewNameList) do
		local var_35_2 = arg_35_0:getUserDataTb_()

		var_35_2.go = gohelper.cloneInPlace(arg_35_0._goviewitem, iter_35_0)
		var_35_2.goSelect = gohelper.findChild(var_35_2.go, "#go_select")

		gohelper.setActive(var_35_2.go, true)
		gohelper.setActive(var_35_2.goSelect, false)

		if arg_35_0:isHeaderView(iter_35_1) then
			iter_35_1 = string.gsub(iter_35_1, "^0#", "")
		else
			var_35_0 = var_35_0 + 1
			var_35_2.click = gohelper.getClick(var_35_2.go)

			var_35_2.click:AddClickListener(arg_35_0._onViewValueClick, arg_35_0, var_35_2)

			iter_35_1 = "    " .. var_35_0 .. "." .. iter_35_1

			table.insert(arg_35_0.viewItemList, var_35_2)
		end

		var_35_2.viewName = iter_35_1
		var_35_2.index = var_35_0
		gohelper.findChildText(var_35_2.go, "#txt_skinname").text = iter_35_1
	end
end

function var_0_0.isHeaderView(arg_36_0, arg_36_1)
	return string.match(arg_36_1, "^0#.*")
end

function var_0_0._onMainViewOpen(arg_37_0, arg_37_1)
	arg_37_0:_onMainViewUpdate()
end

function var_0_0._onMainViewFrameOpen(arg_38_0, arg_38_1)
	arg_38_0:_onMainViewFrameUpdate()
end

function var_0_0.showTrigger(arg_39_0)
	gohelper.setActive(arg_39_0._gotrigger, true)

	for iter_39_0 = 1, var_0_1 do
		arg_39_0:updateTrigger(iter_39_0)
	end
end

function var_0_0.updateTrigger(arg_40_0, arg_40_1)
	local var_40_0 = SkinOffsetAdjustModel.instance:getTrigger(arg_40_0._curSkinInfo, "triggerArea" .. arg_40_1)

	for iter_40_0 = 1, 4 do
		local var_40_1 = arg_40_0["_gotrigger" .. arg_40_1 .. iter_40_0]
		local var_40_2 = var_40_0[iter_40_0]

		if var_40_2 then
			gohelper.setActive(var_40_1, true)

			local var_40_3, var_40_4, var_40_5, var_40_6 = unpack(var_40_2)

			recthelper.setAnchor(var_40_1.transform, var_40_3, var_40_4)
			recthelper.setSize(var_40_1.transform, var_40_5 - var_40_3, var_40_4 - var_40_6)
		else
			gohelper.setActive(var_40_1, false)
		end
	end
end

function var_0_0.saveTrigger(arg_41_0, arg_41_1)
	local var_41_0 = {}

	for iter_41_0 = 1, 4 do
		local var_41_1 = arg_41_0:getOneTrigger(arg_41_1, iter_41_0)

		if var_41_1 then
			table.insert(var_41_0, var_41_1)
		end
	end

	if #var_41_0 == 0 then
		return
	end

	SkinOffsetAdjustModel.instance:setTrigger(arg_41_0._curSkinInfo, "triggerArea" .. arg_41_1, var_41_0)
end

function var_0_0.getOneTrigger(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0["_gotrigger" .. arg_42_1 .. arg_42_2]

	if not var_42_0.activeSelf then
		return
	end

	local var_42_1, var_42_2 = recthelper.getAnchor(var_42_0.transform)
	local var_42_3 = recthelper.getWidth(var_42_0.transform)
	local var_42_4 = recthelper.getHeight(var_42_0.transform)
	local var_42_5 = var_42_3 + var_42_1
	local var_42_6 = var_42_2 - var_42_4
	local var_42_7 = string.format("%.1f", var_42_1)
	local var_42_8 = string.format("%.1f", var_42_2)
	local var_42_9 = string.format("%.1f", var_42_5)
	local var_42_10 = string.format("%.1f", var_42_6)

	return {
		var_42_7,
		var_42_8,
		var_42_9,
		var_42_10
	}
end

function var_0_0.setOffset(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6)
	gohelper.setActive(arg_43_0._gooffset, true)

	local var_43_0 = -1

	arg_43_0._txtoffsetkey.text = "currentKey : " .. arg_43_2

	if string.nilorempty(arg_43_5) then
		arg_43_0._txtoffsetParentKey.text = ""
		arg_43_0._txtoffsetValue.text = ""
	else
		arg_43_0._txtoffsetParentKey.text = "parentKey : " .. arg_43_5
		var_43_0 = var_0_0.key2ParentKeyConstIdDict[arg_43_2]

		if not var_43_0 then
			logError(string.format("'%s' -> '%s' not config const id", arg_43_2, arg_43_5))
		end

		arg_43_0._txtoffsetValue.text = "offsetValue  : " .. CommonConfig.instance:getConstStr(var_43_0)
	end

	arg_43_0._curOffsetKey = arg_43_2

	if arg_43_2 == "decorateskinOffset" or arg_43_2 == "decorateskinl2dOffset" then
		local var_43_1 = DecorateStoreConfig.instance:getDecorateConfig(700005)
		local var_43_2 = string.splitToNumber(var_43_1[arg_43_2], "#")
		local var_43_3 = arg_43_4[1]
		local var_43_4 = arg_43_4[2]
		local var_43_5 = arg_43_4[3]

		if #var_43_2 == 3 then
			var_43_3 = var_43_2[1]
			var_43_4 = var_43_2[2]
			var_43_5 = var_43_2[3]
		end

		arg_43_3(var_43_3, var_43_4, var_43_5)

		arg_43_0._changeOffsetCallback = arg_43_3
		arg_43_0._precisionDefine = arg_43_6

		arg_43_0:initSliderValue(var_43_3, var_43_4, var_43_5)
	else
		local var_43_6, var_43_7, var_43_8, var_43_9 = SkinOffsetAdjustModel.instance:getOffset(arg_43_0._curSkinInfo, arg_43_2, arg_43_5, var_43_0)

		if var_43_9 and arg_43_4 then
			var_43_6 = arg_43_4[1]
			var_43_7 = arg_43_4[2]
			var_43_8 = arg_43_4[3]
		end

		arg_43_3(var_43_6, var_43_7, var_43_8)

		arg_43_0._changeOffsetCallback = arg_43_3
		arg_43_0._precisionDefine = arg_43_6

		arg_43_0:initSliderValue(var_43_6, var_43_7, var_43_8)
	end
end

function var_0_0._onMainViewFrameUpdate(arg_44_0)
	if not arg_44_0._curViewInfo or not arg_44_0._curSkinInfo then
		return
	end

	local var_44_0 = "mainViewOffset"
	local var_44_1 = arg_44_0._curViewInfo[5]
	local var_44_2 = gohelper.find(var_44_1)

	arg_44_0:setOffset(arg_44_0._curSkinInfo, var_44_0, function(arg_45_0, arg_45_1, arg_45_2)
		local var_45_0 = var_44_2.transform

		recthelper.setAnchor(var_45_0, arg_45_0, arg_45_1)

		var_45_0.localScale = Vector3.one * arg_45_2
	end)
	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, arg_44_0._curSkinInfo, true)
	TaskDispatcher.runDelay(function()
		MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, arg_44_0._curSkinInfo, false)

		local var_46_0 = arg_44_0._curViewInfo[6]
		local var_46_1 = gohelper.find(string.format("cameraroot/SceneRoot/MainScene/%s_p(Clone)/s01_obj_a/Anim/Drawing/spine", MainSceneSwitchModel.instance:getCurSceneResName()))

		arg_44_0:setOffset(arg_44_0._curSkinInfo, var_46_0, function(arg_47_0, arg_47_1, arg_47_2)
			local var_47_0 = var_46_1.transform

			transformhelper.setLocalPosXY(var_47_0, arg_47_0, arg_47_1)

			var_47_0.localScale = Vector3.one * arg_47_2
		end, {
			3.11,
			0.51,
			0.39
		}, nil, {
			s = 2,
			x = 2,
			y = 2
		})
	end, nil, 0.5)
end

function var_0_0._onMainViewUpdate(arg_48_0)
	if not arg_48_0._curViewInfo or not arg_48_0._curSkinInfo then
		return
	end

	arg_48_0:_onMainViewSwitchHeroUpdate()
	arg_48_0:showTrigger()
end

function var_0_0._onMainViewSwitchHeroUpdate(arg_49_0)
	if not arg_49_0._curViewInfo or not arg_49_0._curSkinInfo then
		return
	end

	local var_49_0 = arg_49_0._curViewInfo[6]
	local var_49_1 = arg_49_0._curViewInfo[5]
	local var_49_2 = gohelper.find(var_49_1)

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, arg_49_0._curSkinInfo, true)
	arg_49_0:setOffset(arg_49_0._curSkinInfo, var_49_0, function(arg_50_0, arg_50_1, arg_50_2)
		local var_50_0 = var_49_2.transform

		recthelper.setAnchor(var_50_0, arg_50_0, arg_50_1)

		var_50_0.localScale = Vector3.one * arg_50_2
	end)
end

function var_0_0._onCharacterSwitchUpdate(arg_51_0)
	if not arg_51_0._curViewInfo or not arg_51_0._curSkinInfo then
		return
	end

	local var_51_0 = arg_51_0._curViewInfo[6]
	local var_51_1 = arg_51_0._curViewInfo[5]
	local var_51_2 = gohelper.find(var_51_1)

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, arg_51_0._curSkinInfo, true)

	arg_51_0._lightSpine = LightModelAgent.Create(var_51_2, true)

	arg_51_0._lightSpine:setResPath(arg_51_0._curSkinInfo)
	arg_51_0:setOffset(arg_51_0._curSkinInfo, var_51_0, function(arg_52_0, arg_52_1, arg_52_2)
		local var_52_0 = var_51_2.transform

		recthelper.setAnchor(var_52_0, arg_52_0, arg_52_1)

		var_52_0.localScale = Vector3.one * arg_52_2
	end)
end

function var_0_0._onCharacterViewUpdate(arg_53_0, arg_53_1)
	if not arg_53_0._curViewInfo or not arg_53_0._curSkinInfo then
		return
	end

	if arg_53_1 then
		arg_53_0:_onCharacterHoloUpdate()
	end

	local var_53_0 = arg_53_0._curViewInfo[6]
	local var_53_1 = arg_53_0._curViewInfo[5]
	local var_53_2 = gohelper.find(var_53_1)

	arg_53_0._uiSpine = GuiModelAgent.Create(var_53_2, true)

	arg_53_0._uiSpine:setResPath(arg_53_0._curSkinInfo)
	arg_53_0:setOffset(arg_53_0._curSkinInfo, var_53_0, function(arg_54_0, arg_54_1, arg_54_2)
		local var_54_0 = var_53_2.transform

		recthelper.setAnchor(var_54_0, arg_54_0, arg_54_1)

		var_54_0.localScale = Vector3.one * arg_54_2
	end)
end

function var_0_0._onCharacterHoloUpdate(arg_55_0)
	if not arg_55_0._curViewInfo or not arg_55_0._curSkinInfo then
		return
	end

	local var_55_0 = "UIRoot/POPUP_TOP/CharacterView/anim/bgcanvas/bg/#simage_playerbg"
	local var_55_1 = gohelper.find(var_55_0)

	arg_55_0:setOffset(arg_55_0._curSkinInfo, "haloOffset", function(arg_56_0, arg_56_1, arg_56_2)
		local var_56_0 = var_55_1.transform

		recthelper.setAnchor(var_56_0, arg_56_0, arg_56_1)

		var_56_0.localScale = Vector3.one * arg_56_2
	end)
end

function var_0_0._onCharacterRankUpViewUpdate(arg_57_0)
	if not arg_57_0._curViewInfo or not arg_57_0._curSkinInfo then
		return
	end

	local var_57_0 = arg_57_0._curViewInfo[6]
	local var_57_1 = arg_57_0._curViewInfo[7]
	local var_57_2 = arg_57_0._curViewInfo[5]
	local var_57_3 = gohelper.find(var_57_2)

	arg_57_0._uiSpine = GuiModelAgent.Create(var_57_3, true)

	arg_57_0._uiSpine:setResPath(arg_57_0._curSkinInfo)
	arg_57_0:setOffset(arg_57_0._curSkinInfo, var_57_0, function(arg_58_0, arg_58_1, arg_58_2)
		local var_58_0 = var_57_3.transform

		recthelper.setAnchor(var_58_0, arg_58_0, arg_58_1)

		var_58_0.localScale = Vector3.one * arg_58_2
	end, {
		0,
		0,
		1
	}, var_57_1)
end

function var_0_0._onCharacterSkinViewUpdate(arg_59_0)
	if not arg_59_0._curViewInfo or not arg_59_0._curSkinInfo then
		return
	end

	local var_59_0 = arg_59_0._curViewInfo[6]
	local var_59_1 = arg_59_0._curViewInfo[7]
	local var_59_2 = arg_59_0._curViewInfo[5]
	local var_59_3 = gohelper.find(var_59_2)

	arg_59_0._uiSpine = GuiModelAgent.Create(var_59_3, true)

	arg_59_0._uiSpine:setResPath(arg_59_0._curSkinInfo)
	arg_59_0:setOffset(arg_59_0._curSkinInfo, var_59_0, function(arg_60_0, arg_60_1, arg_60_2)
		local var_60_0 = var_59_3.transform

		recthelper.setAnchor(var_60_0, arg_60_0, arg_60_1)

		var_60_0.localScale = Vector3.one * arg_60_2
	end, {
		0,
		0,
		1
	}, var_59_1)
end

function var_0_0._onCharacterStaticSkinViewUpdate(arg_61_0)
	if not arg_61_0._curViewInfo or not arg_61_0._curSkinInfo then
		return
	end

	local var_61_0 = arg_61_0._curViewInfo[6]
	local var_61_1 = arg_61_0._curViewInfo[5]
	local var_61_2 = gohelper.find(var_61_1)
	local var_61_3 = gohelper.getSingleImage(var_61_2)

	var_61_3:LoadImage(ResUrl.getHeadIconImg(arg_61_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_61_3.gameObject)
	end, nil)
	arg_61_0:setOffset(arg_61_0._curSkinInfo, var_61_0, function(arg_63_0, arg_63_1, arg_63_2)
		local var_63_0 = var_61_3.transform

		recthelper.setAnchor(var_63_0, arg_63_0, arg_63_1)

		var_63_0.localScale = Vector3.one * arg_63_2
	end, {
		-400,
		500,
		0.68
	})
end

function var_0_0._onCharacterSkinSwitchViewUpdate(arg_64_0)
	if not arg_64_0._curViewInfo or not arg_64_0._curSkinInfo then
		return
	end

	local var_64_0 = arg_64_0._curViewInfo[6]
	local var_64_1 = arg_64_0._curViewInfo[5]
	local var_64_2 = gohelper.find(var_64_1)

	arg_64_0._uiSpine = GuiSpine.Create(var_64_2, false)

	arg_64_0._uiSpine:setResPath(ResUrl.getSpineUIPrefab(arg_64_0._curSkinInfo.spine))
	arg_64_0:setOffset(arg_64_0._curSkinInfo, var_64_0, function(arg_65_0, arg_65_1, arg_65_2)
		local var_65_0 = var_64_2.transform

		recthelper.setAnchor(var_65_0, arg_65_0, arg_65_1)

		var_65_0.localScale = Vector3.one * arg_65_2
	end)
end

function var_0_0._onPlayerCardViewStaticDrawingUpdate(arg_66_0)
	if not arg_66_0._curViewInfo or not arg_66_0._curSkinInfo then
		return
	end

	local var_66_0 = arg_66_0._curViewInfo[5]
	local var_66_1 = gohelper.find(var_66_0).transform:GetChild(0).gameObject
	local var_66_2 = gohelper.findChild(var_66_1, "root/main/top/role/skinnode/#simage_role")
	local var_66_3 = arg_66_0._curViewInfo[6]
	local var_66_4 = arg_66_0._curViewInfo[7]
	local var_66_5 = var_66_2
	local var_66_6 = gohelper.getSingleImage(var_66_5)

	var_66_6:LoadImage(ResUrl.getHeadIconImg(arg_66_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_66_6.gameObject)
	end, nil)

	arg_66_0.playCardViewStaticDrawingDefaultOffset = arg_66_0.playCardViewStaticDrawingDefaultOffset or {
		-150,
		-150,
		0.6
	}

	arg_66_0:setOffset(arg_66_0._curSkinInfo, var_66_3, function(arg_68_0, arg_68_1, arg_68_2)
		local var_68_0 = var_66_6.transform

		recthelper.setAnchor(var_68_0, arg_68_0, arg_68_1)

		var_68_0.localScale = Vector3.one * arg_68_2
	end, arg_66_0.playCardViewStaticDrawingDefaultOffset, var_66_4)
end

function var_0_0._onDecorateStoreStaticViewUpdate(arg_69_0)
	if not arg_69_0._curViewInfo or not arg_69_0._curSkinInfo then
		return
	end

	local var_69_0 = arg_69_0._curViewInfo[5]
	local var_69_1 = gohelper.find(var_69_0)
	local var_69_2 = gohelper.findChildSingleImage(var_69_1, "#simage_skin")
	local var_69_3 = arg_69_0._curViewInfo[6]

	var_69_2:LoadImage(ResUrl.getHeadIconImg(arg_69_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_69_2.gameObject)

		local var_70_0 = arg_69_0._curSkinInfo.skinViewImgOffset

		if not string.nilorempty(var_70_0) then
			local var_70_1 = string.splitToNumber(var_70_0, "#")

			recthelper.setAnchor(var_69_2.transform, tonumber(var_70_1[1]), tonumber(var_70_1[2]))
			transformhelper.setLocalScale(var_69_2.transform, tonumber(var_70_1[3]), tonumber(var_70_1[3]), tonumber(var_70_1[3]))
		else
			recthelper.setAnchor(var_69_2.transform, -150, -150)
			transformhelper.setLocalScale(var_69_2.transform, 0.6, 0.6, 0.6)
		end
	end, nil)

	local var_69_4 = {
		0,
		0,
		1
	}

	arg_69_0:setOffset(arg_69_0._curSkinInfo, var_69_3, function(arg_71_0, arg_71_1, arg_71_2)
		local var_71_0 = var_69_1.transform

		recthelper.setAnchor(var_71_0, arg_71_0, arg_71_1)

		var_71_0.localScale = Vector3.one * arg_71_2
	end, var_69_4)
end

function var_0_0._onCharacterSkinStaticDrawingViewUpdate(arg_72_0)
	if not arg_72_0._curViewInfo or not arg_72_0._curSkinInfo then
		return
	end

	local var_72_0 = arg_72_0._curViewInfo[6]
	local var_72_1 = arg_72_0._curViewInfo[5]
	local var_72_2 = gohelper.find(var_72_1)
	local var_72_3 = gohelper.getSingleImage(var_72_2)

	var_72_3:LoadImage(ResUrl.getHeadIconImg(arg_72_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_72_3.gameObject)
	end, nil)
	arg_72_0:setOffset(arg_72_0._curSkinInfo, var_72_0, function(arg_74_0, arg_74_1, arg_74_2)
		local var_74_0 = var_72_3.transform.parent

		recthelper.setAnchor(var_74_0, arg_74_0, arg_74_1)

		var_74_0.localScale = Vector3.one * arg_74_2
	end)
end

function var_0_0._onCharacterSkinStaticDrawingViewUpdate1(arg_75_0)
	if not arg_75_0._curViewInfo or not arg_75_0._curSkinInfo then
		return
	end

	local var_75_0 = arg_75_0._curViewInfo[6]
	local var_75_1 = arg_75_0._curViewInfo[5]
	local var_75_2 = gohelper.find(var_75_1)
	local var_75_3 = gohelper.getSingleImage(var_75_2)

	var_75_3:LoadImage(ResUrl.getHeadIconImg(arg_75_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_75_3.gameObject)
	end, nil)
	arg_75_0:setOffset(arg_75_0._curSkinInfo, var_75_0, function(arg_77_0, arg_77_1, arg_77_2)
		recthelper.setAnchor(var_75_3.transform, arg_77_0, arg_77_1)

		var_75_3.transform.localScale = Vector3.one * arg_77_2
	end)
end

function var_0_0._onCharacterViewSkinStaticDrawingViewUpdate(arg_78_0)
	if not arg_78_0._curViewInfo or not arg_78_0._curSkinInfo then
		return
	end

	local var_78_0 = arg_78_0._curViewInfo[6]
	local var_78_1 = arg_78_0._curViewInfo[5]
	local var_78_2 = gohelper.find(var_78_1)
	local var_78_3 = gohelper.getSingleImage(var_78_2)

	var_78_3:LoadImage(ResUrl.getHeadIconImg(arg_78_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_78_3.gameObject)
	end, nil)
	arg_78_0:setOffset(arg_78_0._curSkinInfo, var_78_0, function(arg_80_0, arg_80_1, arg_80_2)
		local var_80_0 = var_78_3.transform

		recthelper.setAnchor(var_80_0, arg_80_0, arg_80_1)

		var_80_0.localScale = Vector3.one * arg_80_2
	end)
end

function var_0_0._onCharacterSkinGetDetailViewBaseUpdate(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0._curViewInfo[6]
	local var_81_1 = arg_81_0._curViewInfo[5]
	local var_81_2 = gohelper.find(var_81_1)
	local var_81_3 = gohelper.getSingleImage(var_81_2)

	var_81_3:LoadImage(arg_81_1, function()
		return
	end, nil)
	arg_81_0:setOffset(arg_81_0._curSkinInfo, var_81_0, function(arg_83_0, arg_83_1, arg_83_2)
		local var_83_0 = var_81_3.transform

		recthelper.setAnchor(var_83_0, arg_83_0, arg_83_1)

		var_83_0.localScale = Vector3.one * arg_83_2
	end)
end

function var_0_0._onCharacterDataTitleViewUpdate(arg_84_0)
	if not arg_84_0._curViewInfo or not arg_84_0._curSkinInfo then
		return
	end

	arg_84_0:_onCharacterSkinGetDetailViewBaseUpdate(ResUrl.getHeadIconImg(arg_84_0._curSkinInfo.id))
end

function var_0_0._onPlayerClothViewUpdate(arg_85_0)
	if not arg_85_0._curViewInfo or not arg_85_0._curSkinInfo then
		return
	end

	local var_85_0 = arg_85_0._curViewInfo[6]
	local var_85_1 = arg_85_0._curViewInfo[5]
	local var_85_2 = gohelper.find(var_85_1)
	local var_85_3 = gohelper.getSingleImage(var_85_2)

	var_85_3.LoadImage(var_85_3, ResUrl.getHeadIconImg(arg_85_0._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(var_85_3.gameObject)
	end)

	arg_85_0._simageList[var_85_3] = true

	arg_85_0:setOffset(arg_85_0._curSkinInfo, var_85_0, function(arg_87_0, arg_87_1, arg_87_2)
		local var_87_0 = var_85_3.transform

		recthelper.setAnchor(var_87_0, arg_87_0, arg_87_1)

		var_87_0.localScale = Vector3.one * arg_87_2
	end)
end

function var_0_0._onCharacterDataVoiceViewUpdate(arg_88_0)
	CharacterController.instance:dispatchEvent(CharacterEvent.SelectPage, 2)

	if not arg_88_0._curViewInfo or not arg_88_0._curSkinInfo then
		return
	end

	local var_88_0 = arg_88_0._curViewInfo[6]
	local var_88_1 = arg_88_0._curViewInfo[7]

	TaskDispatcher.runDelay(function()
		local var_89_0 = arg_88_0._curViewInfo[5]
		local var_89_1 = gohelper.find(var_89_0)

		arg_88_0._uiSpine = GuiModelAgent.Create(var_89_1, true)

		arg_88_0._uiSpine:setResPath(arg_88_0._curSkinInfo)
		arg_88_0:setOffset(arg_88_0._curSkinInfo, var_88_0, function(arg_90_0, arg_90_1, arg_90_2)
			local var_90_0 = var_89_1.transform

			recthelper.setAnchor(var_90_0, arg_90_0, arg_90_1)

			var_90_0.localScale = Vector3.one * arg_90_2
		end, {
			0,
			0,
			1
		}, var_88_1)
	end, nil, 0.5)
end

function var_0_0._onPlayerCardViewUpdate(arg_91_0)
	if not arg_91_0._curViewInfo or not arg_91_0._curSkinInfo then
		return
	end

	local var_91_0 = arg_91_0._curViewInfo[5]
	local var_91_1 = gohelper.find(var_91_0).transform:GetChild(0)
	local var_91_2 = gohelper.findChild(var_91_1, "main/top/role/skinnode/")
	local var_91_3 = gohelper.findChild(var_91_1, "main/top/role/skinnode/#simage_role")

	gohelper.setActive(var_91_3, false)

	local var_91_4 = arg_91_0._curViewInfo[6]
	local var_91_5 = arg_91_0._curViewInfo[7]

	TaskDispatcher.runDelay(function()
		arg_91_0._uiSpine = GuiModelAgent.Create(var_91_2, true)

		arg_91_0._uiSpine:setResPath(arg_91_0._curSkinInfo)
		arg_91_0:setOffset(arg_91_0._curSkinInfo, var_91_4, function(arg_93_0, arg_93_1, arg_93_2)
			local var_93_0 = var_91_2.transform

			recthelper.setAnchor(var_93_0, arg_93_0, arg_93_1)

			var_93_0.localScale = Vector3.one * arg_93_2
		end, {
			0,
			0,
			1
		}, var_91_5)
	end, nil, 0.5)
end

function var_0_0._onDecorateStoreViewUpdate(arg_94_0)
	if not arg_94_0._curViewInfo or not arg_94_0._curSkinInfo then
		return
	end

	local var_94_0 = arg_94_0._curViewInfo[5]
	local var_94_1 = gohelper.find(var_94_0)
	local var_94_2 = gohelper.findChild(var_94_1, "#go_spinecontainer/#go_spine")
	local var_94_3 = gohelper.findChildSingleImage(var_94_1, "#go_spinecontainer/#simage_l2d")
	local var_94_4 = arg_94_0._curViewInfo[6]

	TaskDispatcher.runDelay(function()
		if not string.nilorempty(arg_94_0._curSkinInfo.live2dbg) then
			gohelper.setActive(var_94_3.gameObject, true)
			var_94_3:LoadImage(ResUrl.getCharacterSkinLive2dBg(arg_94_0._curSkinInfo.live2dbg))
		else
			gohelper.setActive(var_94_3.gameObject, false)
		end

		arg_94_0._uiSpine = GuiModelAgent.Create(var_94_2, true)

		arg_94_0._uiSpine:setResPath(arg_94_0._curSkinInfo, function()
			local var_96_0 = arg_94_0._curSkinInfo.skinViewLive2dOffset

			if string.nilorempty(var_96_0) then
				var_96_0 = arg_94_0._curSkinInfo.characterViewOffset
			end

			local var_96_1 = SkinConfig.instance:getSkinOffset(var_96_0)

			recthelper.setAnchor(var_94_2.transform, tonumber(var_96_1[1]), tonumber(var_96_1[2]))
			transformhelper.setLocalScale(var_94_2.transform, tonumber(var_96_1[3]), tonumber(var_96_1[3]), tonumber(var_96_1[3]))
		end)

		if not string.nilorempty(arg_94_0._curSkinInfo.live2d) then
			arg_94_0._uiSpine:setLive2dCameraLoadedCallback(function()
				gohelper.setAsFirstSibling(var_94_3.gameObject)
			end)
		end

		arg_94_0:setOffset(arg_94_0._curSkinInfo, var_94_4, function(arg_98_0, arg_98_1, arg_98_2)
			local var_98_0 = var_94_1.transform

			recthelper.setAnchor(var_98_0, arg_98_0, arg_98_1)

			var_98_0.localScale = Vector3.one * arg_98_2
		end, {
			0,
			0,
			1
		})
	end, nil, 0.5)
end

function var_0_0._onCharacterViewOpen(arg_99_0)
	arg_99_0:_onCommonCharacterViewOpen()
	gohelper.setActive(arg_99_0._btnswitchOffset.gameObject, true)
end

function var_0_0._onCharacterViewChangeStaticDrawingOpen(arg_100_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local var_100_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(var_100_0.heroId)

	var_100_0.isSettingSkinOffset = true

	local var_100_1 = arg_100_0._curViewInfo[2]

	ViewMgr.instance:openView(var_100_1, var_100_0)
end

function var_0_0._onCommonCharacterViewOpen(arg_101_0)
	FightResultModel.instance.episodeId = 10101
	DungeonModel.instance.curSendEpisodeId = 10101
	DungeonModel.instance.curSendChapterId = 101

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local var_101_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(var_101_0.heroId)

	local var_101_1 = arg_101_0._curViewInfo[2]

	ViewMgr.instance:openView(var_101_1, var_101_0)
end

function var_0_0._onCharacterSkinSwitchViewOpen(arg_102_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local var_102_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(var_102_0.heroId)

	local var_102_1 = arg_102_0._curViewInfo[2]

	if var_102_1 == ViewName.CharacterSkinView then
		local var_102_2 = CharacterSkinLeftView._editableInitView

		function CharacterSkinLeftView._editableInitView(arg_103_0)
			var_102_2(arg_103_0)

			arg_103_0.showDynamicVertical = false
		end
	end

	ViewMgr.instance:openView(var_102_1, var_102_0)
end

function var_0_0._onCharacterSkinGainViewOpen(arg_104_0)
	local var_104_0 = arg_104_0._curViewInfo[2]

	ViewMgr.instance:openView(var_104_0, {
		skinId = 302503
	})
end

function var_0_0._onCharacterGetViewOpen(arg_105_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local var_105_0 = arg_105_0._curViewInfo[2]
	local var_105_1 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	ViewMgr.instance:openView(var_105_0, {
		heroId = var_105_1.heroId
	})
end

function var_0_0._onCharacterDataViewOpen(arg_106_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local var_106_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(var_106_0.heroId)

	local var_106_1 = arg_106_0._curViewInfo[2]

	TaskDispatcher.runDelay(function()
		ViewMgr.instance:openView(var_106_1, var_106_0.heroId)
	end, nil, 0.5)
end

function var_0_0._onPlayerCardViewOpen(arg_108_0)
	PlayerCardController.instance:openPlayerCardView()
end

function var_0_0._onDecorateStoreViewOpen(arg_109_0)
	DecorateStoreModel.instance:setCurGood(700005)

	if arg_109_0._curViewInfo[2] == ViewName.StoreView then
		local var_109_0 = DecorateStoreView._editableInitView

		function DecorateStoreView._editableInitView(arg_110_0)
			var_109_0(arg_110_0)

			arg_110_0._showLive2d = true
			arg_110_0._adjust = true
		end
	end

	GameFacade.jump(JumpEnum.JumpId.DecorateStorePay)
end

function var_0_0._onDecorateStoreStaticViewOpen(arg_111_0)
	DecorateStoreModel.instance:setCurGood(700005)

	if arg_111_0._curViewInfo[2] == ViewName.StoreView then
		local var_111_0 = DecorateStoreView._editableInitView

		function DecorateStoreView._editableInitView(arg_112_0)
			var_111_0(arg_112_0)

			arg_112_0._showLive2d = false
			arg_112_0._adjust = true
		end
	end

	GameFacade.jump(JumpEnum.JumpId.DecorateStorePay)
end

function var_0_0._onSummonCustomThreePickOpen(arg_113_0)
	local var_113_0 = arg_113_0._curViewInfo[2]
	local var_113_1 = 22161

	SummonMainModel.instance:trySetSelectPoolId(var_113_1)
	ViewMgr.instance:openView(var_113_0)
	TaskDispatcher.runDelay(function()
		SummonCustomPickChoiceListModel.instance:initDatas(var_113_1)
		SummonCustomPickChoiceController.instance:setSelect(3071)
		SummonCustomPickChoiceController.instance:setSelect(3072)
		SummonCustomPickChoiceController.instance:setSelect(3073)

		local var_114_0 = SummonCustomPickChoiceListModel.instance:getSelectIds()
		local var_114_1 = SummonMainModel.instance:getCurPool()
		local var_114_2 = SummonMainModel.instance:getPoolServerMO(var_114_1.id)

		if var_114_2 and var_114_2.customPickMO then
			local var_114_3 = {}

			for iter_114_0, iter_114_1 in ipairs(var_114_0) do
				table.insert(var_114_3, iter_114_1)
			end

			var_114_2.customPickMO.pickHeroIds = var_114_3
		end

		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		SummonController.instance:dispatchEvent(SummonEvent.onSummonInfoGot)
	end, nil, 0.1)
end

function var_0_0._onSummonCustomThreePickDataUpdate(arg_115_0)
	if not arg_115_0._curViewInfo or not arg_115_0._curSkinInfo then
		return
	end

	local var_115_0 = arg_115_0._curViewInfo[5]
	local var_115_1 = "UIRoot/POPUP_TOP/SummonThreeCustomPickView/#go_ui/current/#go_selected/#go_role%s/#simage_role%s_outline"
	local var_115_2 = arg_115_0._curViewInfo[6]
	local var_115_3 = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()
	local var_115_4 = {}
	local var_115_5 = {}

	for iter_115_0 = 1, var_115_3 do
		local var_115_6 = tostring(iter_115_0)
		local var_115_7 = string.format(var_115_0, var_115_6, var_115_6)
		local var_115_8 = gohelper.find(var_115_7)
		local var_115_9 = gohelper.getSingleImage(var_115_8)

		var_115_9:LoadImage(ResUrl.getHeadIconImg(arg_115_0._curSkinInfo.id), function()
			ZProj.UGUIHelper.SetImageSize(var_115_9.gameObject)
		end, nil)

		local var_115_10 = string.format(var_115_1, var_115_6, var_115_6)
		local var_115_11 = gohelper.find(var_115_10)
		local var_115_12 = gohelper.getSingleImage(var_115_11)

		var_115_12:LoadImage(ResUrl.getHeadIconImg(arg_115_0._curSkinInfo.id), function()
			ZProj.UGUIHelper.SetImageSize(var_115_12.gameObject)
		end, nil)
		table.insert(var_115_4, var_115_9)
		table.insert(var_115_5, var_115_12)
	end

	arg_115_0:setOffset(arg_115_0._curSkinInfo, var_115_2, function(arg_118_0, arg_118_1, arg_118_2)
		local var_118_0 = #var_115_4

		for iter_118_0 = 1, var_118_0 do
			local var_118_1 = var_115_4[iter_118_0].transform
			local var_118_2 = var_115_5[iter_118_0].transform

			recthelper.setAnchor(var_118_1, arg_118_0, arg_118_1)

			var_118_1.localScale = Vector3.one * arg_118_2

			recthelper.setAnchor(var_118_2, arg_118_0 - 5, arg_118_1 + 2)

			var_118_2.localScale = Vector3.one * arg_118_2
		end
	end)
end

function var_0_0._onCharacterDataViewOpenFromHandbook(arg_119_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local var_119_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(var_119_0.heroId)

	local var_119_1 = arg_119_0._curViewInfo[2]

	TaskDispatcher.runDelay(function()
		ViewMgr.instance:openView(var_119_1, {
			adjustStaticOffset = true,
			fromHandbookView = true,
			heroId = var_119_0.heroId
		})
	end, nil, 0.5)
end

function var_0_0.onMainThumbnailViewOpen(arg_121_0)
	MainController.instance:openMainThumbnailView()
end

function var_0_0.onMainThumbnailViewUpdate(arg_122_0)
	if not arg_122_0._curViewInfo or not arg_122_0._curSkinInfo then
		return
	end

	local var_122_0 = UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine")
	local var_122_1 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine")
	local var_122_2 = arg_122_0._curViewInfo[6]
	local var_122_3 = arg_122_0._curViewInfo[5]
	local var_122_4 = arg_122_0._curViewInfo[7]
	local var_122_5 = gohelper.find(var_122_3)

	var_122_5.transform:SetParent(var_122_0.transform, false)
	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, arg_122_0._curSkinInfo, true, false)
	var_122_5.transform:SetParent(var_122_1.transform, false)
	arg_122_0:setOffset(arg_122_0._curSkinInfo, var_122_2, function(arg_123_0, arg_123_1, arg_123_2)
		local var_123_0 = var_122_5.transform

		recthelper.setAnchor(var_123_0, arg_123_0, arg_123_1)
	end, {
		0,
		0,
		1
	}, var_122_4)
end

function var_0_0._onViewValueClick(arg_124_0, arg_124_1)
	if arg_124_1.index == arg_124_0.selectIndex then
		return
	end

	if arg_124_0.selectIndex then
		local var_124_0 = arg_124_0._viewList[arg_124_0.selectIndex] and arg_124_0._viewList[arg_124_0.selectIndex].beforeCloseView

		if var_124_0 then
			var_124_0(arg_124_0)
		end
	end

	arg_124_0.selectIndex = arg_124_1.index

	gohelper.setActive(arg_124_0._btnswitchOffset.gameObject, false)
	gohelper.setActive(arg_124_0._gotrigger, false)

	arg_124_0._changeOffsetCallback = nil

	local var_124_1 = arg_124_0._viewList[arg_124_1.index]
	local var_124_2 = var_124_1.viewInfo
	local var_124_3 = var_124_2[3]

	arg_124_0._curViewInfo = var_124_2

	if arg_124_0.lastSelectViewItem then
		gohelper.setActive(arg_124_0.lastSelectViewItem.goSelect, false)
	end

	gohelper.setActive(arg_124_1.goSelect, true)

	arg_124_0.lastSelectViewItem = arg_124_1
	arg_124_0._txtviewlabel.text = arg_124_1.viewName

	arg_124_0:_btnblockOnClick()
	arg_124_0:backToHome()

	local var_124_4 = var_124_1.beforeOpenView

	if var_124_4 then
		var_124_4(arg_124_0)
	end

	if var_124_3 then
		var_124_3(arg_124_0)
	end
end

function var_0_0.backToHome(arg_125_0)
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()
end

function var_0_0.refreshSkin(arg_126_0, arg_126_1)
	arg_126_0.selectMo = arg_126_1

	arg_126_0._inputSkinLabel:SetText(arg_126_1.skinId .. "#" .. arg_126_1.skinName)
	arg_126_0:_btnblockOnClick()

	arg_126_0._curSkinInfo = SkinConfig.instance:getSkinCo(arg_126_1.skinId)

	arg_126_0:updateSkin()
end

function var_0_0.updateSkin(arg_127_0)
	if not arg_127_0._curViewInfo then
		return
	end

	local var_127_0 = arg_127_0._curViewInfo[4]

	if var_127_0 then
		var_127_0(arg_127_0, true)
	end
end

function var_0_0.onUpdateParam(arg_128_0)
	return
end

function var_0_0.onOpen(arg_129_0)
	arg_129_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_129_0._onOpenView, arg_129_0)

	module_views.FightSuccView.viewType = ViewType.Full
	module_views.CharacterGetView.viewType = ViewType.Full
end

function var_0_0._onOpenView(arg_130_0, arg_130_1)
	if not arg_130_0._curViewInfo then
		return
	end

	if arg_130_1 == arg_130_0._curViewInfo[2] then
		local var_130_0 = arg_130_0._curViewInfo[4]

		if var_130_0 then
			var_130_0(arg_130_0, true)
		end
	end
end

function var_0_0.onClickSearch(arg_131_0)
	local var_131_0 = arg_131_0._inputSkinLabel:GetText()

	if string.nilorempty(var_131_0) then
		SkinOffsetSkinListModel.instance:initSkinList()
	elseif string.match(var_131_0, "^%d+") then
		SkinOffsetSkinListModel.instance:filterById(var_131_0)
	else
		SkinOffsetSkinListModel.instance:filterByName(var_131_0)
	end
end

function var_0_0.onSkinInputValueChanged(arg_132_0, arg_132_1)
	return
end

function var_0_0.beforeOpenSkinFullView(arg_133_0)
	arg_133_0.isOpenSkinFullView = true
	arg_133_0.skinViewOldFunc = CharacterSkinFullScreenView.setLocalScale

	function CharacterSkinFullScreenView.setLocalScale(arg_134_0)
		arg_133_0.skinViewOldFunc(arg_134_0)

		arg_133_0._txtScale.text = "Scale : " .. arg_134_0.curScaleX
	end

	gohelper.setActive(arg_133_0.goFullSkinContainer, true)
	SkinOffsetSkinListModel.instance:setInitFilterFunc(arg_133_0.filterLive2dFunc)
	SkinOffsetSkinListModel.instance:initSkinList()
end

function var_0_0.beforeCloseSkinFullView(arg_135_0)
	arg_135_0.isOpenSkinFullView = false
	arg_135_0.live2dCamera = nil
	CharacterSkinFullScreenView.setLocalScale = arg_135_0.skinViewOldFunc

	gohelper.setActive(arg_135_0.goFullSkinContainer, false)
	SkinOffsetSkinListModel.instance:setInitFilterFunc(nil)
end

function var_0_0._onCharacterSkinFullViewOpen(arg_136_0)
	SkinOffsetSkinListModel.instance:initSkinList()

	local var_136_0 = SkinOffsetSkinListModel.instance:getFirst()
	local var_136_1 = SkinConfig.instance:getSkinCo(var_136_0.skinId)
	local var_136_2 = {
		skinCo = var_136_1,
		showEnum = CharacterEnum.ShowSkinEnum.Dynamic
	}

	arg_136_0._curSkinInfo = var_136_1

	ViewMgr.instance:openView(ViewName.CharacterSkinFullScreenView, var_136_2)
end

function var_0_0._onCharacterSkinFullViewUpdate(arg_137_0)
	if not arg_137_0._curViewInfo or not arg_137_0._curSkinInfo then
		return
	end

	local var_137_0 = SkinOffsetAdjustModel.instance:getCameraSize(arg_137_0._curSkinInfo.id)

	if not var_137_0 then
		var_137_0 = arg_137_0._curSkinInfo.fullScreenCameraSize

		if var_137_0 <= 0 then
			var_137_0 = CharacterSkinFullScreenView.DefaultLive2dCameraSize
		end
	end

	arg_137_0._inputCameraSize:SetText(var_137_0)

	local var_137_1 = arg_137_0._curViewInfo[6]
	local var_137_2 = arg_137_0._curViewInfo[5]
	local var_137_3 = gohelper.find(var_137_2)

	arg_137_0._uiSpine = GuiModelAgent.Create(var_137_3, true)

	arg_137_0._uiSpine:setLive2dCameraLoadedCallback(arg_137_0.onLive2dCameraLoadedCallback, arg_137_0)
	arg_137_0._uiSpine:setResPath(arg_137_0._curSkinInfo, nil, nil, var_137_0)

	local var_137_4 = arg_137_0._curViewInfo[7]

	arg_137_0:setOffset(arg_137_0._curSkinInfo, var_137_1, function(arg_138_0, arg_138_1, arg_138_2)
		local var_138_0 = var_137_3.transform

		recthelper.setAnchor(var_138_0, arg_138_0, arg_138_1)

		var_138_0.localScale = Vector3.one * arg_138_2
	end, {
		0,
		0,
		1
	}, var_137_4)
end

function var_0_0.onLive2dCameraLoadedCallback(arg_139_0, arg_139_1)
	local var_139_0 = gohelper.find("UIRoot/POPUP_TOP/CharacterSkinFullScreenView/#go_scroll/dynamicContainer")

	gohelper.addChild(var_139_0, arg_139_1._rawImageGo)

	local var_139_1 = gohelper.find("UIRoot/POPUP_TOP/CharacterSkinFullScreenView/#go_scroll/dynamicContainer/#go_spinecontainer")
	local var_139_2 = arg_139_1._rawImageGo:GetComponent(gohelper.Type_RawImage)

	arg_139_0.live2dCamera = arg_139_1._camera
	arg_139_0.live2dRwaImageTexture = var_139_2.texture

	recthelper.setAnchor(arg_139_1._rawImageGo.transform, 0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)
	recthelper.setAnchor(var_139_1.transform, 0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)

	arg_139_0:getPreviewImage().texture = var_139_2.texture
end

function var_0_0.getPreviewImage(arg_140_0)
	if not arg_140_0.previewImage then
		local var_140_0 = gohelper.create2d(arg_140_0.goFullSkinContainer, "previewImageBg")
		local var_140_1 = var_140_0.transform

		var_140_1.anchorMin = RectTransformDefine.Anchor.RightMiddle
		var_140_1.anchorMax = RectTransformDefine.Anchor.RightMiddle

		recthelper.setSize(var_140_1, 200, 200)
		recthelper.setAnchor(var_140_1, -100, -150)
		gohelper.onceAddComponent(var_140_0, gohelper.Type_RawImage)

		local var_140_2 = gohelper.create2d(arg_140_0.goFullSkinContainer, "previewImage")
		local var_140_3 = var_140_2.transform

		var_140_3.anchorMin = RectTransformDefine.Anchor.RightMiddle
		var_140_3.anchorMax = RectTransformDefine.Anchor.RightMiddle

		recthelper.setSize(var_140_3, 200, 200)
		recthelper.setAnchor(var_140_3, -100, -150)

		arg_140_0.previewImage = gohelper.onceAddComponent(var_140_2, gohelper.Type_RawImage)
	end

	return arg_140_0.previewImage
end

function var_0_0.onCameraSizeInput(arg_141_0, arg_141_1)
	arg_141_1 = tonumber(arg_141_1)

	if not arg_141_1 or arg_141_1 <= 0 then
		arg_141_1 = 14
	end

	if arg_141_0.live2dCamera then
		arg_141_0.live2dCamera.orthographicSize = arg_141_1

		SkinOffsetAdjustModel.instance:saveCameraSize(arg_141_0._curSkinInfo, arg_141_1)
	end
end

function var_0_0.filterLive2dFunc(arg_142_0)
	return arg_142_0 and not string.nilorempty(arg_142_0.live2d)
end

function var_0_0.onClose(arg_143_0)
	arg_143_0._slideroffsetx:RemoveOnValueChanged()
	arg_143_0._slideroffsety:RemoveOnValueChanged()
	arg_143_0._slideroffsetscale:RemoveOnValueChanged()
	arg_143_0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(arg_143_0._slideroffsetx.gameObject))
	arg_143_0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(arg_143_0._slideroffsety.gameObject))
	arg_143_0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(arg_143_0._slideroffsetscale.gameObject))

	for iter_143_0, iter_143_1 in ipairs(arg_143_0._btnList) do
		iter_143_1:RemoveClickListener()
	end

	arg_143_0._btnSearch:RemoveClickListener()
	arg_143_0._goviewcontainerclick:RemoveClickListener()
	arg_143_0._inputSkinLabel:RemoveOnValueChanged()
	arg_143_0._inputCameraSize:RemoveOnValueChanged()

	for iter_143_2, iter_143_3 in ipairs(arg_143_0.viewItemList) do
		if iter_143_3.click then
			iter_143_3.click:RemoveClickListener()
		end
	end

	arg_143_0.drag:RemoveDragBeginListener()
	arg_143_0.drag:RemoveDragEndListener()
	arg_143_0._goskincontainerclick:RemoveClickListener()

	module_views.FightSuccView.viewType = ViewType.Modal
	module_views.CharacterGetView.viewType = ViewType.Normal

	logError("偏移编辑器修改了部分界面的参数，关闭偏移编辑器后应重开游戏再体验！！！")
end

function var_0_0.removeDragListener(arg_144_0, arg_144_1)
	arg_144_1:RemoveDragBeginListener()
	arg_144_1:RemoveDragListener()
	arg_144_1:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_145_0)
	for iter_145_0, iter_145_1 in pairs(arg_145_0._simageList) do
		iter_145_0:UnLoadImage()
	end
end

return var_0_0
