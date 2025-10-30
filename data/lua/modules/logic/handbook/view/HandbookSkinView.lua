local var_0_0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinView", package.seeall)

local var_0_1 = class("HandbookSkinView", BaseView)
local var_0_2 = typeof(TMPro.TMP_Text)

function var_0_1._delaySelectOption(arg_1_0)
	if not arg_1_0._needRefreshDropDownList then
		return
	end

	arg_1_0._needRefreshDropDownList = false

	arg_1_0:_destroy_frameTimer()

	arg_1_0._frameTimer = FrameTimerController.instance:register(function()
		if not gohelper.isNil(arg_1_0._goDrop) then
			local var_2_0 = arg_1_0._goDrop:GetComponentsInChildren(var_0_2, true):GetEnumerator()

			while var_2_0:MoveNext() do
				var_2_0.Current:SetAllDirty()
			end

			local var_2_1
		end
	end, 6, 2)

	arg_1_0._frameTimer:Start()
end

function var_0_1._destroy_frameTimer(arg_3_0)
	FrameTimerController.onDestroyViewMember(arg_3_0, "_frameTimer")
end

local var_0_3 = 120
local var_0_4 = 170
local var_0_5 = 5
local var_0_6 = "up_start"
local var_0_7 = "donw_start"

function var_0_1.onInitView(arg_4_0)
	arg_4_0._skinItemRoot = gohelper.findChild(arg_4_0.viewGO, "#go_scroll/#go_storyStages")
	arg_4_0._imageBg = gohelper.findChildSingleImage(arg_4_0.viewGO, "#simage_FullBG")
	arg_4_0._imageSkinSuitGroupIcon = gohelper.findChildImage(arg_4_0.viewGO, "Left/#image_Icon")
	arg_4_0._imageSkinSuitGroupEnIcon = gohelper.findChildImage(arg_4_0.viewGO, "Left/#image_TitleEn")
	arg_4_0._textPlayerName = gohelper.findChildText(arg_4_0.viewGO, "title/#title_name")
	arg_4_0._textName = gohelper.findChildText(arg_4_0.viewGO, "title/#name")
	arg_4_0._txtFloorName = gohelper.findChildText(arg_4_0.viewGO, "Left/#txt_Name")
	arg_4_0._txtFloorThemeDescr = gohelper.findChildText(arg_4_0.viewGO, "Left/#txt_Descr")
	arg_4_0._goFloorItemRoot = gohelper.findChild(arg_4_0.viewGO, "Right/Scroll View/Viewport/Content")
	arg_4_0._goFloorItem = gohelper.findChild(arg_4_0.viewGO, "Right/Scroll View/Viewport/Content/Buttnitem")
	arg_4_0._goSwitch = gohelper.findChild(arg_4_0.viewGO, "switch")
	arg_4_0._gopoint = gohelper.findChild(arg_4_0.viewGO, "#point")
	arg_4_0._goscroll = gohelper.findChild(arg_4_0.viewGO, "scroll")
	arg_4_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_4_0._goscroll)
	arg_4_0._itemScrollRect = gohelper.findChildScrollRect(arg_4_0.viewGO, "Right/Scroll View")
	arg_4_0._goContent = gohelper.findChild(arg_4_0.viewGO, "Right/Scroll View/Viewport/Content")
	arg_4_0._goScrollListArrow = gohelper.findChild(arg_4_0.viewGO, "Right/arrow")
	arg_4_0._arrowAnimator = arg_4_0._goScrollListArrow:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._scrollHeight = recthelper.getHeight(arg_4_0._itemScrollRect.transform)
	arg_4_0._viewAnimator = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0._viewAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)

	if arg_4_0._editableInitView then
		arg_4_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_5_0)
	arg_5_0:addEventCb(arg_5_0.viewContainer, HandbookEvent.SkinPointChanged, arg_5_0._refresPoint, arg_5_0)
	arg_5_0:addEventCb(arg_5_0.viewContainer, HandbookEvent.OnClickTarotSkinSuit, arg_5_0._onEnterTarotMode, arg_5_0)
	arg_5_0:addEventCb(arg_5_0.viewContainer, HandbookEvent.OnExitTarotSkinSuit, arg_5_0._onExitTarotMode, arg_5_0)
	arg_5_0:addEventCb(HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, arg_5_0.onClickFloorItem, arg_5_0)

	if HandbookController.instance:hasAnyHandBookSkinGroupRedDot() then
		arg_5_0._itemScrollRect:AddOnValueChanged(arg_5_0._onScrollChange, arg_5_0)
	end

	arg_5_0._scroll:AddDragBeginListener(arg_5_0._onScrollDragBegin, arg_5_0)
	arg_5_0._scroll:AddDragEndListener(arg_5_0._onScrollDragEnd, arg_5_0)
	arg_5_0._scroll:AddDragListener(arg_5_0._onScrollDragging, arg_5_0)
end

function var_0_1.removeEvents(arg_6_0)
	arg_6_0._itemScrollRect:RemoveOnValueChanged()
	arg_6_0._scroll:RemoveDragBeginListener()
	arg_6_0._scroll:RemoveDragEndListener()
	arg_6_0._scroll:RemoveDragListener()
	arg_6_0.dropClick:RemoveClickListener()
	arg_6_0._dropFilter:RemoveOnValueChanged()

	if arg_6_0.dropExtend then
		arg_6_0.dropExtend:dispose()
	end
end

function var_0_1._onScrollChange(arg_7_0, arg_7_1)
	arg_7_0:refreshTabListArrow()
end

function var_0_1._onScrollDragBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.scrollDragPos = arg_8_2.position
	arg_8_0._scrollDragOffsetX = 0
	arg_8_0._scrollDragOffsetY = 0
end

function var_0_1._onScrollDragging(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.scrollDragPos then
		arg_9_0.scrollDragPos = arg_9_2.position
	end

	local var_9_0 = arg_9_2.position - arg_9_0.scrollDragPos

	arg_9_0.scrollDragPos = arg_9_2.position

	local var_9_1 = arg_9_0._skinSuitFloorCfgList[arg_9_0._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[var_9_1] == HandbookEnum.SkinSuitSceneType.Tarot then
		HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlide, var_9_0.x)
	else
		arg_9_0._scrollDragOffsetX = arg_9_0._scrollDragOffsetX + var_9_0.x
		arg_9_0._scrollDragOffsetY = arg_9_0._scrollDragOffsetY + var_9_0.y

		HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlide, -var_9_0.x, -var_9_0.y)
	end
end

function var_0_1._onScrollDragEnd(arg_10_0, arg_10_1, arg_10_2)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideEnd)

	arg_10_0._slideToOtherSuit = false
end

function var_0_1.slideToPre(arg_11_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToPre)
end

function var_0_1.slideToNext(arg_12_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToNext)
end

function var_0_1._editableInitView(arg_13_0)
	arg_13_0._gopointItem = gohelper.findChild(arg_13_0.viewGO, "#point/point_item")
	arg_13_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_13_0.viewGO)

	gohelper.setActive(arg_13_0._goFloorItem, false)
	gohelper.setActive(arg_13_0._goSwitch, false)

	arg_13_0._pointItemTbList = {
		arg_13_0:_createPointTB(arg_13_0._gopointItem)
	}
end

function var_0_1.onOpen(arg_14_0)
	local var_14_0 = arg_14_0.viewParam

	arg_14_0._defaultSelectedIdx = var_14_0 and var_14_0.defaultSelectedIdx or 1
	arg_14_0._curSelectedIdx = arg_14_0._defaultSelectedIdx

	arg_14_0:_createFloorItems()
	arg_14_0:_refreshDesc()

	local var_14_1 = PlayerModel.instance:getPlayinfo().name

	var_14_1 = var_14_1 and var_14_1 or ""

	local var_14_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("handbookskinview_playername"), var_14_1)

	arg_14_0._textPlayerName.text = var_14_2
	arg_14_0._textName.text = ""

	arg_14_0:updateFilterDrop()
end

function var_0_1.onOpenFinish(arg_15_0)
	arg_15_0:refreshTabListArrow()
end

function var_0_1.refreshTabListArrow(arg_16_0)
	arg_16_0._contentHeight = recthelper.getHeight(arg_16_0._goContent.transform)

	if arg_16_0._floorNum <= var_0_5 then
		gohelper.setActive(arg_16_0._goScrollListArrow, false)
	else
		local var_16_0 = 0

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._skinSuitFloorItems) do
			if iter_16_1:hasRedDot() then
				local var_16_1 = iter_16_1.viewGO.transform.localPosition.y

				var_16_0 = math.min(var_16_1, var_16_0)
			end
		end

		local var_16_2 = math.abs(var_16_0)
		local var_16_3 = arg_16_0._goContent.transform.localPosition.y
		local var_16_4 = var_16_2 - arg_16_0._scrollHeight - var_16_3 > var_0_4 / 2

		if var_16_4 then
			arg_16_0._arrowAnimator:Play(var_0_0.Loop)
		else
			arg_16_0._arrowAnimator:Play(var_0_0.Idle)
		end

		gohelper.setActive(arg_16_0._goScrollListArrow, var_16_4)
	end
end

function var_0_1._refreshDesc(arg_17_0)
	if HandbookEnum.SkinSuitId2SceneType[arg_17_0._skinThemeCfg.id] == HandbookEnum.SkinSuitSceneType.Tarot then
		gohelper.setActive(arg_17_0._txtFloorThemeDescr.gameObject, false)
		gohelper.setActive(arg_17_0._txtFloorName.gameObject, false)
		gohelper.setActive(arg_17_0._imageSkinSuitGroupEnIcon.gameObject, false)
		gohelper.setActive(arg_17_0._imageSkinSuitGroupIcon.gameObject, false)
	else
		gohelper.setActive(arg_17_0._txtFloorThemeDescr.gameObject, true)
		gohelper.setActive(arg_17_0._txtFloorName.gameObject, true)
		gohelper.setActive(arg_17_0._imageSkinSuitGroupEnIcon.gameObject, not LangSettings.instance:isEn())
		gohelper.setActive(arg_17_0._imageSkinSuitGroupIcon.gameObject, true)

		arg_17_0._txtFloorThemeDescr.text = arg_17_0._skinThemeCfg.des
		arg_17_0._txtFloorName.text = arg_17_0._skinThemeCfg.name

		UISpriteSetMgr.instance:setSkinHandbook(arg_17_0._imageSkinSuitGroupEnIcon, arg_17_0._skinThemeCfg.nameRes, true)
		UISpriteSetMgr.instance:setSkinHandbook(arg_17_0._imageSkinSuitGroupIcon, arg_17_0._skinThemeCfg.iconRes, true)
	end
end

function var_0_1._createFloorItems(arg_18_0)
	arg_18_0._skinSuitFloorItems = {}
	arg_18_0._skinSuitFloorCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)
	arg_18_0._floorNum = #arg_18_0._skinSuitFloorCfgList

	gohelper.CreateObjList(arg_18_0, arg_18_0._createFloorItem, arg_18_0._skinSuitFloorCfgList, arg_18_0._goFloorItemRoot, arg_18_0._goFloorItem, HandbookSkinFloorItem)
end

function var_0_1._createFloorItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_1:onUpdateData(arg_19_2, arg_19_3)
	arg_19_1:refreshRedDot()
	arg_19_1:refreshSelectState(arg_19_3 == arg_19_0._curSelectedIdx)
	arg_19_1:refreshFloorView()
	arg_19_1:setClickAction(arg_19_0.clickFloorItemAction, arg_19_0)
	arg_19_1:refreshCurSuitIdx()

	if arg_19_0._curSelectedIdx == arg_19_3 then
		local var_19_0 = arg_19_0._skinSuitFloorCfgList[arg_19_3]

		arg_19_0._skinThemeCfg = var_19_0

		HandbookController.instance:statSkinTab(var_19_0 and var_19_0.id or arg_19_3)
	end

	arg_19_0._skinSuitFloorItems[arg_19_3] = arg_19_1
end

function var_0_1.clickFloorItemAction(arg_20_0, arg_20_1)
	if arg_20_0._tarotMode then
		return
	end

	HandbookController.instance:dispatchEvent(HandbookEvent.OnClickSkinSuitFloorItem, arg_20_1:getIdx())
end

function var_0_1.onClickFloorItem(arg_21_0, arg_21_1)
	if arg_21_0._curSelectedIdx == arg_21_1 then
		return
	end

	if arg_21_1 > arg_21_0._curSelectedIdx then
		arg_21_0._isUp = true

		arg_21_0._viewAnimatorPlayer:Play(var_0_7, arg_21_0.onClickFloorAniDone, arg_21_0)
	else
		arg_21_0._isUp = false

		arg_21_0._viewAnimatorPlayer:Play(var_0_6, arg_21_0.onClickFloorAniDone, arg_21_0)
	end

	arg_21_0._curSelectedIdx = arg_21_1
end

function var_0_1.onClickFloorAniDone(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._skinSuitFloorItems) do
		iter_22_1:refreshSelectState(iter_22_0 == arg_22_0._curSelectedIdx)
	end

	local var_22_0 = arg_22_0._skinSuitFloorCfgList[arg_22_0._curSelectedIdx]

	arg_22_0._skinThemeCfg = var_22_0

	HandbookController.instance:statSkinTab(var_22_0 and var_22_0.id or arg_22_0._curSelectedIdx)
	arg_22_0:_refreshDesc()
	TaskDispatcher.runDelay(arg_22_0.onSwitchFloorDone, arg_22_0, 0.1)
	arg_22_0:updateFilterDrop()
end

function var_0_1.onSwitchFloorDone(arg_23_0)
	local var_23_0 = arg_23_0._isUp and "donw_end" or "up_end"

	arg_23_0._viewAnimatorPlayer:Play(var_23_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SwitchSkinSuitFloorDone)
end

function var_0_1._refresPoint(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1 = arg_24_1 or 1
	arg_24_2 = arg_24_2 or 0

	for iter_24_0 = #arg_24_0._pointItemTbList + 1, arg_24_2 do
		local var_24_0 = gohelper.cloneInPlace(arg_24_0._gopointItem)
		local var_24_1 = arg_24_0:_createPointTB(var_24_0, iter_24_0)

		table.insert(arg_24_0._pointItemTbList, var_24_1)
	end

	for iter_24_1 = 1, #arg_24_0._pointItemTbList do
		local var_24_2 = arg_24_0._pointItemTbList[iter_24_1]

		gohelper.setActive(var_24_2.golight, iter_24_1 == arg_24_1)
		gohelper.setActive(var_24_2.go, iter_24_1 <= arg_24_2 and arg_24_2 > 1)
	end

	if arg_24_0._dropFilter then
		arg_24_0._dropFilter:SetValue(#arg_24_0._suitCfgList - arg_24_1)
	end
end

function var_0_1._createPointTB(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.go = arg_25_1
	var_25_0.golight = gohelper.findChild(arg_25_1, "light")

	return var_25_0
end

function var_0_1._clickToSuit(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 and arg_26_1 or 1

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideByClick, arg_26_1)
end

function var_0_1._onEnterTarotMode(arg_27_0)
	arg_27_0._tarotMode = true

	arg_27_0._viewAnimatorPlayer:Play(var_0_0.Close)
end

function var_0_1._onExitTarotMode(arg_28_0)
	arg_28_0._tarotMode = false

	arg_28_0._viewAnimatorPlayer:Play(var_0_0.Back)
end

function var_0_1.updateFilterDrop(arg_29_0)
	if not arg_29_0._dropFilter then
		arg_29_0._dropFilter = gohelper.findChildDropdown(arg_29_0.viewGO, "Left/#drop_filter")
		arg_29_0._goDrop = arg_29_0._dropFilter.gameObject
		arg_29_0.dropArrowTr = gohelper.findChildComponent(arg_29_0._goDrop, "Arrow", gohelper.Type_Transform)
		arg_29_0.dropClick = gohelper.getClick(arg_29_0._goDrop)
		arg_29_0.dropExtend = DropDownExtend.Get(arg_29_0._goDrop)

		arg_29_0.dropExtend:init(arg_29_0.onDropShow, arg_29_0.onDropHide, arg_29_0)
		arg_29_0._dropFilter:AddOnValueChanged(arg_29_0.onDropValueChanged, arg_29_0)
		arg_29_0.dropClick:AddClickListener(function()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, arg_29_0)
	end

	arg_29_0._curskinSuitGroupCfg = arg_29_0._skinSuitFloorCfgList[arg_29_0._curSelectedIdx]
	arg_29_0._curSuitGroupId = arg_29_0._curskinSuitGroupCfg.id
	arg_29_0._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_29_0._curskinSuitGroupCfg.id)

	table.sort(arg_29_0._suitCfgList, function(arg_31_0, arg_31_1)
		if arg_31_0.show == 1 and arg_31_1.show == 0 then
			return false
		elseif arg_31_0.show == 0 and arg_31_1.show == 1 then
			return true
		else
			return arg_31_0.id < arg_31_1.id
		end
	end)
	gohelper.setActive(arg_29_0._goDrop, #arg_29_0._suitCfgList > 1)

	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._suitCfgList) do
		local var_29_1 = iter_29_1.show == 1 and arg_29_0._suitCfgList[iter_29_0].name or luaLang("skinhandbook_lock_suit")

		table.insert(var_29_0, var_29_1)
	end

	arg_29_0._dropFilter:ClearOptions()
	arg_29_0._dropFilter:AddOptions(var_29_0)
	arg_29_0._dropFilter:SetValue(#arg_29_0._suitCfgList - 1)
end

function var_0_1.onDropHide(arg_32_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookDropListOpen, false)
end

function var_0_1.onDropShow(arg_33_0)
	arg_33_0._needRefreshDropDownList = true

	arg_33_0:_delaySelectOption()
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookDropListOpen, true)
end

function var_0_1.onDropValueChanged(arg_34_0, arg_34_1)
	arg_34_1 = #arg_34_0._suitCfgList - arg_34_1

	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideByClick, arg_34_1)
end

function var_0_1.onClose(arg_35_0)
	arg_35_0:_destroy_frameTimer()
end

function var_0_1.onDestroyView(arg_36_0)
	arg_36_0:_destroy_frameTimer()
end

return var_0_1
