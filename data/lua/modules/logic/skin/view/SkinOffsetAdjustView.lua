module("modules.logic.skin.view.SkinOffsetAdjustView", package.seeall)

slot0 = class("SkinOffsetAdjustView", BaseView)
slot1 = 5

function slot0.onInitView(slot0)
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_block")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._gotrigger = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger")
	slot0._gotrigger34 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger3_4")
	slot0._gotrigger33 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger3_3")
	slot0._gotrigger32 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger3_2")
	slot0._gotrigger31 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger3_1")
	slot0._gotrigger14 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger1_4")
	slot0._gotrigger13 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger1_3")
	slot0._gotrigger12 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger1_2")
	slot0._gotrigger11 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger1_1")
	slot0._gotrigger24 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger2_4")
	slot0._gotrigger23 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger2_3")
	slot0._gotrigger22 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger2_2")
	slot0._gotrigger21 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger2_1")
	slot0._gotrigger44 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger4_4")
	slot0._gotrigger43 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger4_3")
	slot0._gotrigger42 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger4_2")
	slot0._gotrigger41 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger4_1")
	slot0._gotrigger54 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger5_4")
	slot0._gotrigger53 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger5_3")
	slot0._gotrigger52 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger5_2")
	slot0._gotrigger51 = gohelper.findChild(slot0.viewGO, "#go_container/#go_trigger/#go_trigger5_1")
	slot0._btnsaveTrigger = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_trigger/#btn_saveTrigger")
	slot0._gooffset = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset")
	slot0._txtoffsetkey = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_offset/#txt_offsetkey")
	slot0._txtoffsetParentKey = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_offset/#txt_offsetParentKey")
	slot0._txtoffsetValue = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_offset/#txt_offsetValue")
	slot0._slideroffsetx = gohelper.findChildSlider(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset1/#slider_offsetx")
	slot0._txtoffsetx = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset1/#txt_offsetx")
	slot0._slideroffsety = gohelper.findChildSlider(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset2/#slider_offsety")
	slot0._txtoffsety = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset2/#txt_offsety")
	slot0._slideroffsetscale = gohelper.findChildSlider(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset3/#slider_offsetscale")
	slot0._txtoffsetscale = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset3/#txt_offsetscale")
	slot0._btnsaveOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_offset/#btn_saveOffset")
	slot0._btnresetOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_offset/#btn_resetOffset")
	slot0._btnswitchOffset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_offset/#btn_switchOffset")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#btn_close")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_switch")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "#btn_switch/#txt_switch")

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
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblock:RemoveClickListener()
	slot0._btnsaveTrigger:RemoveClickListener()
	slot0._btnsaveOffset:RemoveClickListener()
	slot0._btnresetOffset:RemoveClickListener()
	slot0._btnswitchOffset:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
end

slot0.key2ParentKeyConstIdDict = {
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

function slot0._btnswitchOffsetOnClick(slot0)
	if slot0._curOffsetKey == "haloOffset" then
		slot0:_onCharacterViewUpdate()
	else
		slot0:_onCharacterHoloUpdate()
	end
end

function slot0._btnswitchOnClick(slot0)
	gohelper.setActive(slot0._gocontainer, not slot0._gocontainer.activeSelf)

	if slot0._gocontainer.activeSelf then
		slot0._txtswitch.text = "点击隐藏"
	else
		slot0._txtswitch.text = "点击显示"
	end
end

function slot0._btnresetOffsetOnClick(slot0)
	SkinOffsetAdjustModel.instance:resetTempOffset(slot0._curSkinInfo, slot0._curOffsetKey)

	slot1, slot2, slot3 = SkinOffsetAdjustModel.instance:getOffset(slot0._curSkinInfo, slot0._curOffsetKey)

	slot0:initSliderValue(slot1, slot2, slot3)
	slot0._changeOffsetCallback(slot1, slot2, slot3)
end

function slot0._btnsaveTriggerOnClick(slot0)
	for slot4 = 1, uv0 do
		slot0:saveTrigger(slot4)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsaveOffsetOnClick(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot1 = string.format(slot0:_getXPrecision(), slot0._slideroffsetx:GetValue())
	slot2 = string.format(slot0:_getYPrecision(), slot0._slideroffsety:GetValue())
	slot3 = string.format(slot0:_getSPrecision(), slot0._slideroffsetscale:GetValue())

	if slot0._curOffsetKey == "decorateskinOffset" or slot0._curOffsetKey == "decorateskinl2dOffset" or slot0._curOffsetKey == "decorateskinl2dBgOffset" then
		logError(string.format("%s#%s#%s", slot1, slot2, slot3))

		return
	end

	SkinOffsetAdjustModel.instance:setOffset(slot0._curSkinInfo, slot0._curOffsetKey, slot1, slot2, slot3)
end

function slot0._btnblockOnClick(slot0)
	slot0.isShowSkinContainer = false
	slot0.isShowViewContainer = false

	gohelper.setActive(slot0._goskinscroll, false)
	gohelper.setActive(slot0._goviewcroll, false)
end

function slot0.onSkinContainerClick(slot0)
	gohelper.setActive(slot0._goskinscroll, true)

	slot0.isShowSkinContainer = true

	SkinOffsetSkinListModel.instance:initSkinList()
end

function slot0.onViewContainerClick(slot0)
	if slot0.isShowViewContainer then
		slot0:_btnblockOnClick()

		return
	end

	gohelper.setActive(slot0._goviewcroll, true)

	slot0.isShowViewContainer = true
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0.startDragPosX = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if math.abs(slot2.position.x - slot0.startDragPosX) > 30 then
		if slot3 < slot0.startDragPosX then
			SkinOffsetSkinListModel.instance:slideNext()
		else
			SkinOffsetSkinListModel.instance:slidePre()
		end
	end
end

function slot0._editableInitView(slot0)
	SkinOffsetSkinListModel.instance:initOriginSkinList()
	SkinOffsetSkinListModel.instance:setScrollView(slot0)

	slot0.drag = SLFramework.UGUI.UIDragListener.Get(slot0._btnblock.gameObject)

	slot0.drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0.drag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._simageList = slot0:getUserDataTb_()

	gohelper.setLayer(slot0.viewGO, UnityLayer.UITop, true)

	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_skincontainer")
	slot0._goskinscroll = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_skincontainer/#scroll_skin")
	slot0._goskinscrollrect = SLFramework.UGUI.ScrollRectWrap.Get(slot0._goskinscroll)
	slot0._inputSkinLabel = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_container/component/#go_skincontainer/input_label")

	slot0._inputSkinLabel:AddOnValueChanged(slot0.onSkinInputValueChanged, slot0)

	slot0.goFullSkinContainer = gohelper.findChild(slot0.viewGO, "fullSkinContainer")
	slot0._inputCameraSize = gohelper.findChildTextMeshInputField(slot0.viewGO, "fullSkinContainer/camera_input")

	slot0._inputCameraSize:AddOnValueChanged(slot0.onCameraSizeInput, slot0)

	slot0._txtScale = gohelper.findChildText(slot0.viewGO, "fullSkinContainer/txt_scale")
	slot0._btnSearch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/component/#go_skincontainer/input_label/#btn_search")

	slot0._btnSearch:AddClickListener(slot0.onClickSearch, slot0)

	slot0._goviewcontainer = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_viewcontainer")
	slot0._goviewcroll = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_viewcontainer/#scroll_view")
	slot0._txtviewlabel = gohelper.findChildText(slot0.viewGO, "#go_container/component/#go_viewcontainer/#txt_label")
	slot0._goviewitem = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_viewcontainer/#scroll_view/Viewport/Content/item")

	gohelper.setActive(slot0._goviewitem, false)

	slot0._goskincontainerclick = gohelper.getClick(slot0._inputSkinLabel.gameObject)

	slot0._goskincontainerclick:AddClickListener(slot0.onSkinContainerClick, slot0)

	slot0._goviewcontainerclick = gohelper.getClick(slot0._goviewcontainer)

	slot0._goviewcontainerclick:AddClickListener(slot0.onViewContainerClick, slot0)
	slot0:_initViewList()
	slot0:_initSkinList()
	slot0:initSlider(slot0._slideroffsetx, 2000, -2000, slot0._onOffsetXChange)
	slot0:initSlider(slot0._slideroffsety, 2000, -2000, slot0._onOffsetYChange)
	slot0:initSlider(slot0._slideroffsetscale, 3, 0, slot0._onOffsetScaleChange)

	slot0._goOffset1 = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset1")
	slot0._goOffset2 = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset2")
	slot0._goOffset3 = gohelper.findChild(slot0.viewGO, "#go_container/component/#go_offset/offsets/offset3")
	slot0._btnList = {}

	slot0:initOffsetItem(slot0._goOffset1, slot0._slideroffsetx, "x")
	slot0:initOffsetItem(slot0._goOffset2, slot0._slideroffsety, "y")
	slot0:initOffsetItem(slot0._goOffset3, slot0._slideroffsetscale, "s")
	gohelper.setActive(slot0._gooffset, false)
	gohelper.setActive(slot0._btnswitchOffset.gameObject, false)

	slot0._txtoffsetParentKey.text = ""
	slot0._txtoffsetValue.text = ""
end

function slot0.setSkinScrollRectVertical(slot0, slot1)
	slot0._goskinscrollrect.verticalNormalizedPosition = slot1
end

function slot0.initSlider(slot0, slot1, slot2, slot3, slot4)
	if slot4 then
		slot1:AddOnValueChanged(slot4, slot0)

		slot5 = SLFramework.UGUI.UIDragListener.Get(slot1.gameObject)

		slot5:AddDragBeginListener(function (slot0, slot1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				uv0.slider.enabled = false
			end
		end, nil)
		slot5:AddDragEndListener(function (slot0, slot1)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				uv0.slider.enabled = true
			end
		end, nil)
		slot5:AddDragListener(function (slot0, slot1)
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

	slot1.slider.maxValue = slot2
	slot1.slider.minValue = slot3
end

function slot0.initOffsetItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildButtonWithAudio(slot1, "AddBtn")
	slot5 = gohelper.findChildButtonWithAudio(slot1, "ReduceBtn")
	slot6 = gohelper.findChildTextMeshInputField(slot1, "IntervalField")

	slot6:SetText(1)
	slot4:AddClickListener(slot0.addBtnClick, slot0, {
		intervalField = slot6,
		slider = slot2,
		propName = slot3
	})
	slot5:AddClickListener(slot0.reduceBtnClick, slot0, {
		intervalField = slot6,
		slider = slot2,
		propName = slot3
	})
	table.insert(slot0._btnList, slot4)
	table.insert(slot0._btnList, slot5)
end

function slot0.addBtnClick(slot0, slot1)
	slot1.slider:SetValue(tonumber(slot1.slider:GetValue()) + tonumber(slot1.intervalField:GetText()))
end

function slot0.reduceBtnClick(slot0, slot1)
	slot1.slider:SetValue(tonumber(slot1.slider:GetValue()) - tonumber(slot1.intervalField:GetText()))
end

function slot0._onOffsetXChange(slot0, slot1, slot2)
	slot0._txtoffsetx.text = string.format("x:" .. slot0:_getXPrecision(), slot2)

	slot0:_onOffsetChange()
end

function slot0._onOffsetYChange(slot0, slot1, slot2)
	slot0._txtoffsety.text = string.format("y:" .. slot0:_getYPrecision(), slot2)

	slot0:_onOffsetChange()
end

function slot0._onOffsetScaleChange(slot0, slot1, slot2)
	slot0._txtoffsetscale.text = string.format("s:" .. slot0:_getSPrecision(), slot2)

	slot0:_onOffsetChange()
end

function slot0._onOffsetChange(slot0)
	if slot0._changeOffsetCallback then
		slot1 = string.format(slot0:_getXPrecision(), slot0._slideroffsetx:GetValue())
		slot2 = string.format(slot0:_getYPrecision(), slot0._slideroffsety:GetValue())
		slot3 = string.format(slot0:_getSPrecision(), slot0._slideroffsetscale:GetValue())

		SkinOffsetAdjustModel.instance:setTempOffset(slot0._curSkinInfo, slot0._curOffsetKey, tonumber(slot1), tonumber(slot2), tonumber(slot3))
		slot0._changeOffsetCallback(tonumber(slot1), tonumber(slot2), tonumber(slot3))
	end
end

function slot0.initSliderValue(slot0, slot1, slot2, slot3)
	slot0._slideroffsetx:SetValue(slot1)
	slot0._slideroffsety:SetValue(slot2)
	slot0._slideroffsetscale:SetValue(slot3)

	slot0._txtoffsetx.text = string.format("x:" .. slot0:_getXPrecision(), slot1)
	slot0._txtoffsety.text = string.format("y:" .. slot0:_getYPrecision(), slot2)
	slot0._txtoffsetscale.text = string.format("s:" .. slot0:_getSPrecision(), slot3)
end

function slot0._getXPrecision(slot0)
	return "%." .. (slot0._precisionDefine and slot0._precisionDefine.x or 1) .. "f"
end

function slot0._getYPrecision(slot0)
	return "%." .. (slot0._precisionDefine and slot0._precisionDefine.y or 1) .. "f"
end

function slot0._getSPrecision(slot0)
	return "%." .. (slot0._precisionDefine and slot0._precisionDefine.s or 2) .. "f"
end

function slot0._initSkinList(slot0)
	SkinOffsetSkinListModel.instance:initSkinList()
	slot0:_btnblockOnClick()
end

function slot0._initViewList(slot0)
	slot0._viewList = {}
	slot0._viewNameList = {}

	table.insert(slot0._viewNameList, "0#动态立绘(常量表的501~505设置相对偏移)")
	slot0:_addView("主界面", ViewName.MainView, slot0._onMainViewOpen, slot0._onMainViewUpdate, "UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine", "mainViewOffset")
	slot0:_addView("相框", ViewName.MainView, slot0._onMainViewFrameOpen, slot0._onMainViewFrameUpdate, "UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine", "mainViewFrameOffset")
	slot0:_addView("主界面缩略图界面", ViewName.MainThumbnailView, slot0.onMainThumbnailViewOpen, slot0.onMainThumbnailViewUpdate, "UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine/#go_lightspine", "mainThumbnailViewOffset", "mainViewOffset")
	slot0:_addView("角色切换界面 -> 复用主界面, 不能特殊设置", ViewName.CharacterSwitchView, slot0._onCommonCharacterViewOpen, slot0._onCharacterSwitchUpdate, "UIRoot/POPUP_TOP/CharacterSwitchView/#go_spine_scale/lightspine/#go_lightspine", "mainViewOffset")
	slot0:_addView("角色界面", ViewName.CharacterView, slot0._onCharacterViewOpen, slot0._onCharacterViewUpdate, "UIRoot/POPUP_TOP/CharacterView/anim/#go_herocontainer/dynamiccontainer/#go_spine", "characterViewOffset")
	slot0:_addView("洞悉界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterRankUpView, slot0._onCommonCharacterViewOpen, slot0._onCharacterRankUpViewUpdate, "UIRoot/POPUP_TOP/CharacterRankUpView/spineContainer/#go_spine", "characterRankUpViewOffset", "characterViewOffset")
	slot0:_addView("结算界面 -> 复用角色界面, 可以特殊设置", ViewName.FightSuccView, slot0._onCommonCharacterViewOpen, slot0._onCharacterRankUpViewUpdate, "UIRoot/POPUP_TOP/FightSuccView/spineContainer/spine", "fightSuccViewOffset", "characterViewOffset")
	slot0:_addView("角色获得界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterGetView, slot0._onCharacterGetViewOpen, slot0._onCharacterRankUpViewUpdate, "UIRoot/POPUP_TOP/CharacterGetView/charactercontainer/#go_spine", "characterGetViewOffset", "characterViewOffset")
	slot0:_addView("角色封面界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterDataView, slot0._onCharacterDataViewOpen, slot0._onCharacterSkinViewUpdate, "UIRoot/POPUP_SECOND/CharacterDataView/content/characterdatatitleview(Clone)/content/character/charactericoncontainer/#go_spine", "characterDataTitleViewOffset", "characterViewOffset")
	slot0:_addView("语音界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterDataView, slot0._onCharacterDataViewOpen, slot0._onCharacterDataVoiceViewUpdate, "UIRoot/POPUP_SECOND/CharacterDataView/content/characterdatavoiceview(Clone)/content/#simage_characterbg/charactercontainer/#go_spine", "characterDataVoiceViewOffset", "characterViewOffset")
	slot0:_addView("个人名片 -> 复用角色界面, 可以特殊设置", ViewName.PlayerCardView, slot0._onPlayerCardViewOpen, slot0._onPlayerCardViewUpdate, "UIRoot/POPUP_TOP/NewPlayerCardContentView/view", "playercardViewLive2dOffset", "characterViewOffset")
	slot0:_addView("装饰商店", ViewName.StoreView, slot0._onDecorateStoreViewOpen, slot0._onDecorateStoreViewUpdate, "UIRoot/POPUP_TOP/StoreView/#go_store/decoratestoreview(Clone)/Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer", "decorateskinl2dOffset")
	table.insert(slot0._viewNameList, "0#静态立绘")
	slot0:_addView("角色封面界面静态立绘偏移", ViewName.CharacterDataView, slot0._onCharacterDataViewOpenFromHandbook, slot0._onCharacterStaticSkinViewUpdate, "UIRoot/POPUP_SECOND/CharacterDataView/content/characterdatatitleview(Clone)/content/character/#simage_characterstaticskin", "characterTitleViewStaticOffset")
	slot0:_addView("皮肤界面静态立绘", ViewName.CharacterSkinView, slot0._onCharacterSkinSwitchViewOpen, slot0._onCharacterSkinStaticDrawingViewUpdate1, "UIRoot/POPUP_TOP/CharacterSkinView/characterSpine/#go_skincontainer/#simage_skin", "skinViewImgOffset")
	slot0:_addView("皮肤获得界面静态立绘", ViewName.CharacterSkinGainView, slot0._onCharacterSkinGainViewOpen, slot0._onCharacterSkinStaticDrawingViewUpdate, "UIRoot/POPUP_TOP/CharacterSkinGainView/root/bgroot/#go_skincontainer/#simage_icon", "skinGainViewImgOffset")
	slot0:_addView("角色界面静态立绘", ViewName.CharacterView, slot0._onCharacterViewChangeStaticDrawingOpen, slot0._onCharacterViewSkinStaticDrawingViewUpdate, "UIRoot/POPUP_TOP/CharacterView/anim/#go_herocontainer/staticcontainer/#simage_static", "characterViewImgOffset")
	slot0:_addView("招募界面静态立绘", ViewName.SummonHeroDetailView, slot0._onCharacterGetViewOpen, slot0._onCharacterSkinStaticDrawingViewUpdate, "UIRoot/POPUP_TOP/SummonHeroDetailView/charactercontainer/#simage_character", "summonHeroViewOffset")
	slot0:_addView("个人名片", ViewName.PlayerCardView, slot0._onPlayerCardViewOpen, slot0._onPlayerCardViewStaticDrawingUpdate, "UIRoot/POPUP_TOP/NewPlayerCardContentView/view", "playercardViewImgOffset", "characterViewImgOffset")
	slot0:_addView("装饰商店静态立绘", ViewName.StoreView, slot0._onDecorateStoreStaticViewOpen, slot0._onDecorateStoreStaticViewUpdate, "UIRoot/POPUP_TOP/StoreView/#go_store/decoratestoreview(Clone)/Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer", "decorateskinOffset")
	slot0:_addView("6选3Up", ViewName.SummonThreeCustomPickView, slot0._onSummonCustomThreePickOpen, slot0._onSummonCustomThreePickDataUpdate, "UIRoot/POPUP_TOP/SummonThreeCustomPickView/#go_ui/current/#go_selected/#go_role%s/#simage_role%s", "summonPickUpImgOffset")
	table.insert(slot0._viewNameList, "0#spine小人")
	slot0:_addView("皮肤界面小人Spine", ViewName.CharacterSkinView, slot0._onCharacterSkinSwitchViewOpen, slot0._onCharacterSkinSwitchViewUpdate, "UIRoot/POPUP_TOP/CharacterSkinView/smalldynamiccontainer/#go_smallspine", "skinSpineOffset")
	table.insert(slot0._viewNameList, "0#皮肤放大缩小界面")
	slot0:_addView("皮肤放大缩小界面live2d", ViewName.CharacterSkinFullScreenView, slot0._onCharacterSkinFullViewOpen, slot0._onCharacterSkinFullViewUpdate, "UIRoot/POPUP_TOP/CharacterSkinFullScreenView/#go_scroll/dynamicContainer/#go_spinecontainer/#go_spine", "fullScreenLive2dOffset", "characterViewOffset", slot0.beforeOpenSkinFullView, slot0.beforeCloseSkinFullView)
	slot0:initViewItem()
end

function slot0._addView(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	table.insert(slot0._viewList, {
		viewInfo = {
			slot1,
			slot2,
			slot3,
			slot4,
			slot5,
			slot6,
			slot7
		},
		beforeOpenView = slot8,
		beforeCloseView = slot9
	})
	table.insert(slot0._viewNameList, slot1)
end

function slot0.initViewItem(slot0)
	slot1 = 0
	slot2 = nil
	slot0.viewItemList = {}

	for slot6, slot7 in ipairs(slot0._viewNameList) do
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goviewitem, slot6)
		slot2.goSelect = gohelper.findChild(slot2.go, "#go_select")

		gohelper.setActive(slot2.go, true)
		gohelper.setActive(slot2.goSelect, false)

		if slot0:isHeaderView(slot7) then
			slot7 = string.gsub(slot7, "^0#", "")
		else
			slot2.click = gohelper.getClick(slot2.go)

			slot2.click:AddClickListener(slot0._onViewValueClick, slot0, slot2)

			slot7 = "    " .. slot1 + 1 .. "." .. slot7

			table.insert(slot0.viewItemList, slot2)
		end

		slot2.viewName = slot7
		slot2.index = slot1
		gohelper.findChildText(slot2.go, "#txt_skinname").text = slot7
	end
end

function slot0.isHeaderView(slot0, slot1)
	return string.match(slot1, "^0#.*")
end

function slot0._onMainViewOpen(slot0, slot1)
	slot0:_onMainViewUpdate()
end

function slot0._onMainViewFrameOpen(slot0, slot1)
	slot0:_onMainViewFrameUpdate()
end

function slot0.showTrigger(slot0)
	gohelper.setActive(slot0._gotrigger, true)

	for slot4 = 1, uv0 do
		slot0:updateTrigger(slot4)
	end
end

function slot0.updateTrigger(slot0, slot1)
	slot6 = slot1

	for slot6 = 1, 4 do
		slot7 = slot0["_gotrigger" .. slot1 .. slot6]

		if SkinOffsetAdjustModel.instance:getTrigger(slot0._curSkinInfo, "triggerArea" .. slot6)[slot6] then
			gohelper.setActive(slot7, true)

			slot9, slot10, slot11, slot12 = unpack(slot8)

			recthelper.setAnchor(slot7.transform, slot9, slot10)
			recthelper.setSize(slot7.transform, slot11 - slot9, slot10 - slot12)
		else
			gohelper.setActive(slot7, false)
		end
	end
end

function slot0.saveTrigger(slot0, slot1)
	slot2 = {}

	for slot6 = 1, 4 do
		if slot0:getOneTrigger(slot1, slot6) then
			table.insert(slot2, slot7)
		end
	end

	if #slot2 == 0 then
		return
	end

	SkinOffsetAdjustModel.instance:setTrigger(slot0._curSkinInfo, "triggerArea" .. slot1, slot2)
end

function slot0.getOneTrigger(slot0, slot1, slot2)
	if not slot0["_gotrigger" .. slot1 .. slot2].activeSelf then
		return
	end

	slot4, slot5 = recthelper.getAnchor(slot3.transform)

	return {
		string.format("%.1f", slot4),
		string.format("%.1f", slot5),
		string.format("%.1f", recthelper.getWidth(slot3.transform) + slot4),
		string.format("%.1f", slot5 - recthelper.getHeight(slot3.transform))
	}
end

function slot0.setOffset(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	gohelper.setActive(slot0._gooffset, true)

	slot7 = -1
	slot0._txtoffsetkey.text = "currentKey : " .. slot2

	if string.nilorempty(slot5) then
		slot0._txtoffsetParentKey.text = ""
		slot0._txtoffsetValue.text = ""
	else
		slot0._txtoffsetParentKey.text = "parentKey : " .. slot5

		if not uv0.key2ParentKeyConstIdDict[slot2] then
			logError(string.format("'%s' -> '%s' not config const id", slot2, slot5))
		end

		slot0._txtoffsetValue.text = "offsetValue  : " .. CommonConfig.instance:getConstStr(slot7)
	end

	slot0._curOffsetKey = slot2

	if slot2 == "decorateskinOffset" or slot2 == "decorateskinl2dOffset" then
		slot10 = slot4[1]
		slot11 = slot4[2]
		slot12 = slot4[3]

		if #string.splitToNumber(DecorateStoreConfig.instance:getDecorateConfig(700005)[slot2], "#") == 3 then
			slot10 = slot9[1]
			slot11 = slot9[2]
			slot12 = slot9[3]
		end

		slot3(slot10, slot11, slot12)

		slot0._changeOffsetCallback = slot3
		slot0._precisionDefine = slot6

		slot0:initSliderValue(slot10, slot11, slot12)
	else
		slot8, slot9, slot10, slot11 = SkinOffsetAdjustModel.instance:getOffset(slot0._curSkinInfo, slot2, slot5, slot7)

		if slot11 and slot4 then
			slot8 = slot4[1]
			slot9 = slot4[2]
			slot10 = slot4[3]
		end

		slot3(slot8, slot9, slot10)

		slot0._changeOffsetCallback = slot3
		slot0._precisionDefine = slot6

		slot0:initSliderValue(slot8, slot9, slot10)
	end
end

function slot0._onMainViewFrameUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot3 = gohelper.find(slot0._curViewInfo[5])

	slot0:setOffset(slot0._curSkinInfo, "mainViewOffset", function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, slot0._curSkinInfo, true)
	TaskDispatcher.runDelay(function ()
		MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, uv0._curSkinInfo, false)

		slot1 = gohelper.find(string.format("cameraroot/SceneRoot/MainScene/%s_p(Clone)/s01_obj_a/Anim/Drawing/spine", MainSceneSwitchModel.instance:getCurSceneResName()))

		uv0:setOffset(uv0._curSkinInfo, uv0._curViewInfo[6], function (slot0, slot1, slot2)
			slot3 = uv0.transform

			transformhelper.setLocalPosXY(slot3, slot0, slot1)

			slot3.localScale = Vector3.one * slot2
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

function slot0._onMainViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot0:_onMainViewSwitchHeroUpdate()
	slot0:showTrigger()
end

function slot0._onMainViewSwitchHeroUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot3 = gohelper.find(slot0._curViewInfo[5])

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, slot0._curSkinInfo, true)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterSwitchUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, slot0._curSkinInfo, true)

	slot0._lightSpine = LightModelAgent.Create(gohelper.find(slot0._curViewInfo[5]), true)

	slot0._lightSpine:setResPath(slot0._curSkinInfo)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterViewUpdate(slot0, slot1)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	if slot1 then
		slot0:_onCharacterHoloUpdate()
	end

	slot0._uiSpine = GuiModelAgent.Create(gohelper.find(slot0._curViewInfo[5]), true)

	slot0._uiSpine:setResPath(slot0._curSkinInfo)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterHoloUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot2 = gohelper.find("UIRoot/POPUP_TOP/CharacterView/anim/bgcanvas/bg/#simage_playerbg")

	slot0:setOffset(slot0._curSkinInfo, "haloOffset", function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterRankUpViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot0._uiSpine = GuiModelAgent.Create(gohelper.find(slot0._curViewInfo[5]), true)

	slot0._uiSpine:setResPath(slot0._curSkinInfo)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end, {
		0,
		0,
		1
	}, slot0._curViewInfo[7])
end

function slot0._onCharacterSkinViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot0._uiSpine = GuiModelAgent.Create(gohelper.find(slot0._curViewInfo[5]), true)

	slot0._uiSpine:setResPath(slot0._curSkinInfo)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end, {
		0,
		0,
		1
	}, slot0._curViewInfo[7])
end

function slot0._onCharacterStaticSkinViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	gohelper.getSingleImage(gohelper.find(slot0._curViewInfo[5])):LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
	end, nil)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end, {
		-400,
		500,
		0.68
	})
end

function slot0._onCharacterSkinSwitchViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot0._uiSpine = GuiSpine.Create(gohelper.find(slot0._curViewInfo[5]), false)

	slot0._uiSpine:setResPath(ResUrl.getSpineUIPrefab(slot0._curSkinInfo.spine))
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onPlayerCardViewStaticDrawingUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	gohelper.getSingleImage(gohelper.findChild(gohelper.find(slot0._curViewInfo[5]).transform:GetChild(0).gameObject, "root/main/top/role/skinnode/#simage_role")):LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
	end, nil)

	slot0.playCardViewStaticDrawingDefaultOffset = slot0.playCardViewStaticDrawingDefaultOffset or {
		-150,
		-150,
		0.6
	}

	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end, slot0.playCardViewStaticDrawingDefaultOffset, slot0._curViewInfo[7])
end

function slot0._onDecorateStoreStaticViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	gohelper.findChildSingleImage(gohelper.find(slot0._curViewInfo[5]), "#simage_skin"):LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)

		if not string.nilorempty(uv1._curSkinInfo.skinViewImgOffset) then
			slot1 = string.splitToNumber(slot0, "#")

			recthelper.setAnchor(uv0.transform, tonumber(slot1[1]), tonumber(slot1[2]))
			transformhelper.setLocalScale(uv0.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
		else
			recthelper.setAnchor(uv0.transform, -150, -150)
			transformhelper.setLocalScale(uv0.transform, 0.6, 0.6, 0.6)
		end
	end, nil)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end, {
		0,
		0,
		1
	})
end

function slot0._onCharacterSkinStaticDrawingViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	gohelper.getSingleImage(gohelper.find(slot0._curViewInfo[5])):LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
	end, nil)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform.parent

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterSkinStaticDrawingViewUpdate1(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	gohelper.getSingleImage(gohelper.find(slot0._curViewInfo[5])):LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
	end, nil)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		recthelper.setAnchor(uv0.transform, slot0, slot1)

		uv0.transform.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterViewSkinStaticDrawingViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	gohelper.getSingleImage(gohelper.find(slot0._curViewInfo[5])):LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
	end, nil)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterSkinGetDetailViewBaseUpdate(slot0, slot1)
	gohelper.getSingleImage(gohelper.find(slot0._curViewInfo[5])):LoadImage(slot1, function ()
	end, nil)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterDataTitleViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot0:_onCharacterSkinGetDetailViewBaseUpdate(ResUrl.getHeadIconImg(slot0._curSkinInfo.id))
end

function slot0._onPlayerClothViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot4 = gohelper.getSingleImage(gohelper.find(slot0._curViewInfo[5]))

	slot4:LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
		ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
	end)

	slot0._simageList[slot4] = true

	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end)
end

function slot0._onCharacterDataVoiceViewUpdate(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.SelectPage, 2)

	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot1 = slot0._curViewInfo[6]
	slot2 = slot0._curViewInfo[7]

	TaskDispatcher.runDelay(function ()
		uv0._uiSpine = GuiModelAgent.Create(gohelper.find(uv0._curViewInfo[5]), true)

		uv0._uiSpine:setResPath(uv0._curSkinInfo)
		uv0:setOffset(uv0._curSkinInfo, uv1, function (slot0, slot1, slot2)
			slot3 = uv0.transform

			recthelper.setAnchor(slot3, slot0, slot1)

			slot3.localScale = Vector3.one * slot2
		end, {
			0,
			0,
			1
		}, uv2)
	end, nil, 0.5)
end

function slot0._onPlayerCardViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot3 = gohelper.find(slot0._curViewInfo[5]).transform:GetChild(0)
	slot4 = gohelper.findChild(slot3, "main/top/role/skinnode/")

	gohelper.setActive(gohelper.findChild(slot3, "main/top/role/skinnode/#simage_role"), false)

	slot6 = slot0._curViewInfo[6]
	slot7 = slot0._curViewInfo[7]

	TaskDispatcher.runDelay(function ()
		uv0._uiSpine = GuiModelAgent.Create(uv1, true)

		uv0._uiSpine:setResPath(uv0._curSkinInfo)
		uv0:setOffset(uv0._curSkinInfo, uv2, function (slot0, slot1, slot2)
			slot3 = uv0.transform

			recthelper.setAnchor(slot3, slot0, slot1)

			slot3.localScale = Vector3.one * slot2
		end, {
			0,
			0,
			1
		}, uv3)
	end, nil, 0.5)
end

function slot0._onDecorateStoreViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot2 = gohelper.find(slot0._curViewInfo[5])
	slot3 = gohelper.findChild(slot2, "#go_spinecontainer/#go_spine")
	slot4 = gohelper.findChildSingleImage(slot2, "#go_spinecontainer/#simage_l2d")
	slot5 = slot0._curViewInfo[6]

	TaskDispatcher.runDelay(function ()
		if not string.nilorempty(uv0._curSkinInfo.live2dbg) then
			gohelper.setActive(uv1.gameObject, true)
			uv1:LoadImage(ResUrl.getCharacterSkinLive2dBg(uv0._curSkinInfo.live2dbg))
		else
			gohelper.setActive(uv1.gameObject, false)
		end

		uv0._uiSpine = GuiModelAgent.Create(uv2, true)

		uv0._uiSpine:setResPath(uv0._curSkinInfo, function ()
			if string.nilorempty(uv0._curSkinInfo.skinViewLive2dOffset) then
				slot0 = uv0._curSkinInfo.characterViewOffset
			end

			slot1 = SkinConfig.instance:getSkinOffset(slot0)

			recthelper.setAnchor(uv1.transform, tonumber(slot1[1]), tonumber(slot1[2]))
			transformhelper.setLocalScale(uv1.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
		end)

		if not string.nilorempty(uv0._curSkinInfo.live2d) then
			uv0._uiSpine:setLive2dCameraLoadedCallback(function ()
				gohelper.setAsFirstSibling(uv0.gameObject)
			end)
		end

		uv0:setOffset(uv0._curSkinInfo, uv3, function (slot0, slot1, slot2)
			slot3 = uv0.transform

			recthelper.setAnchor(slot3, slot0, slot1)

			slot3.localScale = Vector3.one * slot2
		end, {
			0,
			0,
			1
		})
	end, nil, 0.5)
end

function slot0._onCharacterViewOpen(slot0)
	slot0:_onCommonCharacterViewOpen()
	gohelper.setActive(slot0._btnswitchOffset.gameObject, true)
end

function slot0._onCharacterViewChangeStaticDrawingOpen(slot0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	slot1 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(slot1.heroId)

	slot1.isSettingSkinOffset = true

	ViewMgr.instance:openView(slot0._curViewInfo[2], slot1)
end

function slot0._onCommonCharacterViewOpen(slot0)
	FightResultModel.instance.episodeId = 10101
	DungeonModel.instance.curSendEpisodeId = 10101
	DungeonModel.instance.curSendChapterId = 101

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	slot1 = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(slot1.heroId)
	ViewMgr.instance:openView(slot0._curViewInfo[2], slot1)
end

function slot0._onCharacterSkinSwitchViewOpen(slot0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)
	CharacterDataModel.instance:setCurHeroId(CharacterBackpackCardListModel.instance:getCharacterCardList()[1].heroId)

	if slot0._curViewInfo[2] == ViewName.CharacterSkinView then
		slot3 = CharacterSkinLeftView._editableInitView

		function CharacterSkinLeftView._editableInitView(slot0)
			uv0(slot0)

			slot0.showDynamicVertical = false
		end
	end

	ViewMgr.instance:openView(slot2, slot1)
end

function slot0._onCharacterSkinGainViewOpen(slot0)
	ViewMgr.instance:openView(slot0._curViewInfo[2], {
		skinId = 302503
	})
end

function slot0._onCharacterGetViewOpen(slot0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)
	ViewMgr.instance:openView(slot0._curViewInfo[2], {
		heroId = CharacterBackpackCardListModel.instance:getCharacterCardList()[1].heroId
	})
end

function slot0._onCharacterDataViewOpen(slot0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)
	CharacterDataModel.instance:setCurHeroId(CharacterBackpackCardListModel.instance:getCharacterCardList()[1].heroId)

	slot2 = slot0._curViewInfo[2]

	TaskDispatcher.runDelay(function ()
		ViewMgr.instance:openView(uv0, uv1.heroId)
	end, nil, 0.5)
end

function slot0._onPlayerCardViewOpen(slot0)
	PlayerCardController.instance:openPlayerCardView()
end

function slot0._onDecorateStoreViewOpen(slot0)
	DecorateStoreModel.instance:setCurGood(700005)

	if slot0._curViewInfo[2] == ViewName.StoreView then
		slot2 = DecorateStoreView._editableInitView

		function DecorateStoreView._editableInitView(slot0)
			uv0(slot0)

			slot0._showLive2d = true
			slot0._adjust = true
		end
	end

	GameFacade.jump(JumpEnum.JumpId.DecorateStorePay)
end

function slot0._onDecorateStoreStaticViewOpen(slot0)
	DecorateStoreModel.instance:setCurGood(700005)

	if slot0._curViewInfo[2] == ViewName.StoreView then
		slot2 = DecorateStoreView._editableInitView

		function DecorateStoreView._editableInitView(slot0)
			uv0(slot0)

			slot0._showLive2d = false
			slot0._adjust = true
		end
	end

	GameFacade.jump(JumpEnum.JumpId.DecorateStorePay)
end

function slot0._onSummonCustomThreePickOpen(slot0)
	SummonMainModel.instance:trySetSelectPoolId(22161)
	ViewMgr.instance:openView(slot0._curViewInfo[2])
	TaskDispatcher.runDelay(function ()
		SummonCustomPickChoiceListModel.instance:initDatas(uv0)
		SummonCustomPickChoiceController.instance:setSelect(3071)
		SummonCustomPickChoiceController.instance:setSelect(3072)
		SummonCustomPickChoiceController.instance:setSelect(3073)

		slot0 = SummonCustomPickChoiceListModel.instance:getSelectIds()

		if SummonMainModel.instance:getPoolServerMO(SummonMainModel.instance:getCurPool().id) and slot2.customPickMO then
			slot3 = {}

			for slot7, slot8 in ipairs(slot0) do
				table.insert(slot3, slot8)
			end

			slot2.customPickMO.pickHeroIds = slot3
		end

		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		SummonController.instance:dispatchEvent(SummonEvent.onSummonInfoGot)
	end, nil, 0.1)
end

function slot0._onSummonCustomThreePickDataUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot3 = slot0._curViewInfo[6]

	for slot10 = 1, SummonCustomPickChoiceListModel.instance:getMaxSelectCount() do
		slot11 = tostring(slot10)
		slot14 = gohelper.getSingleImage(gohelper.find(string.format(slot0._curViewInfo[5], slot11, slot11)))

		slot14:LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
			ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
		end, nil)

		slot17 = gohelper.getSingleImage(gohelper.find(string.format("UIRoot/POPUP_TOP/SummonThreeCustomPickView/#go_ui/current/#go_selected/#go_role%s/#simage_role%s_outline", slot11, slot11)))

		slot17:LoadImage(ResUrl.getHeadIconImg(slot0._curSkinInfo.id), function ()
			ZProj.UGUIHelper.SetImageSize(uv0.gameObject)
		end, nil)
		table.insert({}, slot14)
		table.insert({}, slot17)
	end

	slot0:setOffset(slot0._curSkinInfo, slot3, function (slot0, slot1, slot2)
		for slot7 = 1, #uv0 do
			slot8 = uv0[slot7].transform
			slot9 = uv1[slot7].transform

			recthelper.setAnchor(slot8, slot0, slot1)

			slot8.localScale = Vector3.one * slot2

			recthelper.setAnchor(slot9, slot0 - 5, slot1 + 2)

			slot9.localScale = Vector3.one * slot2
		end
	end)
end

function slot0._onCharacterDataViewOpenFromHandbook(slot0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)
	CharacterDataModel.instance:setCurHeroId(CharacterBackpackCardListModel.instance:getCharacterCardList()[1].heroId)

	slot2 = slot0._curViewInfo[2]

	TaskDispatcher.runDelay(function ()
		ViewMgr.instance:openView(uv0, {
			adjustStaticOffset = true,
			fromHandbookView = true,
			heroId = uv1.heroId
		})
	end, nil, 0.5)
end

function slot0.onMainThumbnailViewOpen(slot0)
	MainController.instance:openMainThumbnailView()
end

function slot0.onMainThumbnailViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	slot6 = gohelper.find(slot0._curViewInfo[5])

	slot6.transform:SetParent(UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine").transform, false)
	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, slot0._curSkinInfo, true, false)
	slot6.transform:SetParent(UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine").transform, false)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		recthelper.setAnchor(uv0.transform, slot0, slot1)
	end, {
		0,
		0,
		1
	}, slot0._curViewInfo[7])
end

function slot0._onViewValueClick(slot0, slot1)
	if slot1.index == slot0.selectIndex then
		return
	end

	if slot0.selectIndex and slot0._viewList[slot0.selectIndex] and slot0._viewList[slot0.selectIndex].beforeCloseView then
		slot2(slot0)
	end

	slot0.selectIndex = slot1.index

	gohelper.setActive(slot0._btnswitchOffset.gameObject, false)
	gohelper.setActive(slot0._gotrigger, false)

	slot0._changeOffsetCallback = nil
	slot3 = slot0._viewList[slot1.index].viewInfo
	slot4 = slot3[3]
	slot0._curViewInfo = slot3

	if slot0.lastSelectViewItem then
		gohelper.setActive(slot0.lastSelectViewItem.goSelect, false)
	end

	gohelper.setActive(slot1.goSelect, true)

	slot0.lastSelectViewItem = slot1
	slot0._txtviewlabel.text = slot1.viewName

	slot0:_btnblockOnClick()
	slot0:backToHome()

	if slot2.beforeOpenView then
		slot5(slot0)
	end

	if slot4 then
		slot4(slot0)
	end
end

function slot0.backToHome(slot0)
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()
end

function slot0.refreshSkin(slot0, slot1)
	slot0.selectMo = slot1

	slot0._inputSkinLabel:SetText(slot1.skinId .. "#" .. slot1.skinName)
	slot0:_btnblockOnClick()

	slot0._curSkinInfo = SkinConfig.instance:getSkinCo(slot1.skinId)

	slot0:updateSkin()
end

function slot0.updateSkin(slot0)
	if not slot0._curViewInfo then
		return
	end

	if slot0._curViewInfo[4] then
		slot1(slot0, true)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0)

	module_views.FightSuccView.viewType = ViewType.Full
	module_views.CharacterGetView.viewType = ViewType.Full
end

function slot0._onOpenView(slot0, slot1)
	if not slot0._curViewInfo then
		return
	end

	if slot1 == slot0._curViewInfo[2] and slot0._curViewInfo[4] then
		slot3(slot0, true)
	end
end

function slot0.onClickSearch(slot0)
	if string.nilorempty(slot0._inputSkinLabel:GetText()) then
		SkinOffsetSkinListModel.instance:initSkinList()
	elseif string.match(slot1, "^%d+") then
		SkinOffsetSkinListModel.instance:filterById(slot1)
	else
		SkinOffsetSkinListModel.instance:filterByName(slot1)
	end
end

function slot0.onSkinInputValueChanged(slot0, slot1)
end

function slot0.beforeOpenSkinFullView(slot0)
	slot0.isOpenSkinFullView = true
	slot0.skinViewOldFunc = CharacterSkinFullScreenView.setLocalScale

	function CharacterSkinFullScreenView.setLocalScale(slot0)
		uv0.skinViewOldFunc(slot0)

		uv0._txtScale.text = "Scale : " .. slot0.curScaleX
	end

	gohelper.setActive(slot0.goFullSkinContainer, true)
	SkinOffsetSkinListModel.instance:setInitFilterFunc(slot0.filterLive2dFunc)
	SkinOffsetSkinListModel.instance:initSkinList()
end

function slot0.beforeCloseSkinFullView(slot0)
	slot0.isOpenSkinFullView = false
	slot0.live2dCamera = nil
	CharacterSkinFullScreenView.setLocalScale = slot0.skinViewOldFunc

	gohelper.setActive(slot0.goFullSkinContainer, false)
	SkinOffsetSkinListModel.instance:setInitFilterFunc(nil)
end

function slot0._onCharacterSkinFullViewOpen(slot0)
	SkinOffsetSkinListModel.instance:initSkinList()

	slot2 = SkinConfig.instance:getSkinCo(SkinOffsetSkinListModel.instance:getFirst().skinId)
	slot0._curSkinInfo = slot2

	ViewMgr.instance:openView(ViewName.CharacterSkinFullScreenView, {
		skinCo = slot2,
		showEnum = CharacterEnum.ShowSkinEnum.Dynamic
	})
end

function slot0._onCharacterSkinFullViewUpdate(slot0)
	if not slot0._curViewInfo or not slot0._curSkinInfo then
		return
	end

	if not SkinOffsetAdjustModel.instance:getCameraSize(slot0._curSkinInfo.id) and slot0._curSkinInfo.fullScreenCameraSize <= 0 then
		slot1 = CharacterSkinFullScreenView.DefaultLive2dCameraSize
	end

	slot0._inputCameraSize:SetText(slot1)

	slot0._uiSpine = GuiModelAgent.Create(gohelper.find(slot0._curViewInfo[5]), true)

	slot0._uiSpine:setLive2dCameraLoadedCallback(slot0.onLive2dCameraLoadedCallback, slot0)
	slot0._uiSpine:setResPath(slot0._curSkinInfo, nil, , slot1)
	slot0:setOffset(slot0._curSkinInfo, slot0._curViewInfo[6], function (slot0, slot1, slot2)
		slot3 = uv0.transform

		recthelper.setAnchor(slot3, slot0, slot1)

		slot3.localScale = Vector3.one * slot2
	end, {
		0,
		0,
		1
	}, slot0._curViewInfo[7])
end

function slot0.onLive2dCameraLoadedCallback(slot0, slot1)
	gohelper.addChild(gohelper.find("UIRoot/POPUP_TOP/CharacterSkinFullScreenView/#go_scroll/dynamicContainer"), slot1._rawImageGo)

	slot4 = slot1._rawImageGo:GetComponent(gohelper.Type_RawImage)
	slot0.live2dCamera = slot1._camera
	slot0.live2dRwaImageTexture = slot4.texture

	recthelper.setAnchor(slot1._rawImageGo.transform, 0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)
	recthelper.setAnchor(gohelper.find("UIRoot/POPUP_TOP/CharacterSkinFullScreenView/#go_scroll/dynamicContainer/#go_spinecontainer").transform, 0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)

	slot0:getPreviewImage().texture = slot4.texture
end

function slot0.getPreviewImage(slot0)
	if not slot0.previewImage then
		slot1 = gohelper.create2d(slot0.goFullSkinContainer, "previewImageBg")
		slot2 = slot1.transform
		slot2.anchorMin = RectTransformDefine.Anchor.RightMiddle
		slot2.anchorMax = RectTransformDefine.Anchor.RightMiddle

		recthelper.setSize(slot2, 200, 200)
		recthelper.setAnchor(slot2, -100, -150)
		gohelper.onceAddComponent(slot1, gohelper.Type_RawImage)

		slot3 = gohelper.create2d(slot0.goFullSkinContainer, "previewImage")
		slot2 = slot3.transform
		slot2.anchorMin = RectTransformDefine.Anchor.RightMiddle
		slot2.anchorMax = RectTransformDefine.Anchor.RightMiddle

		recthelper.setSize(slot2, 200, 200)
		recthelper.setAnchor(slot2, -100, -150)

		slot0.previewImage = gohelper.onceAddComponent(slot3, gohelper.Type_RawImage)
	end

	return slot0.previewImage
end

function slot0.onCameraSizeInput(slot0, slot1)
	if not tonumber(slot1) or slot1 <= 0 then
		slot1 = 14
	end

	if slot0.live2dCamera then
		slot0.live2dCamera.orthographicSize = slot1

		SkinOffsetAdjustModel.instance:saveCameraSize(slot0._curSkinInfo, slot1)
	end
end

function slot0.filterLive2dFunc(slot0)
	return slot0 and not string.nilorempty(slot0.live2d)
end

function slot0.onClose(slot0)
	slot0._slideroffsetx:RemoveOnValueChanged()
	slot0._slideroffsety:RemoveOnValueChanged()
	slot0._slideroffsetscale:RemoveOnValueChanged()
	slot0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(slot0._slideroffsetx.gameObject))
	slot0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(slot0._slideroffsety.gameObject))

	slot4 = slot0._slideroffsetscale.gameObject

	slot0:removeDragListener(SLFramework.UGUI.UIDragListener.Get(slot4))

	for slot4, slot5 in ipairs(slot0._btnList) do
		slot5:RemoveClickListener()
	end

	slot0._btnSearch:RemoveClickListener()
	slot0._goviewcontainerclick:RemoveClickListener()
	slot0._inputSkinLabel:RemoveOnValueChanged()
	slot0._inputCameraSize:RemoveOnValueChanged()

	for slot4, slot5 in ipairs(slot0.viewItemList) do
		if slot5.click then
			slot5.click:RemoveClickListener()
		end
	end

	slot0.drag:RemoveDragBeginListener()
	slot0.drag:RemoveDragEndListener()
	slot0._goskincontainerclick:RemoveClickListener()

	module_views.FightSuccView.viewType = ViewType.Modal
	module_views.CharacterGetView.viewType = ViewType.Normal

	logError("偏移编辑器修改了部分界面的参数，关闭偏移编辑器后应重开游戏再体验！！！")
end

function slot0.removeDragListener(slot0, slot1)
	slot1:RemoveDragBeginListener()
	slot1:RemoveDragListener()
	slot1:RemoveDragEndListener()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._simageList) do
		slot4:UnLoadImage()
	end
end

return slot0
