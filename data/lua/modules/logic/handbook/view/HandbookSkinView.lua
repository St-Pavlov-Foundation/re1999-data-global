module("modules.logic.handbook.view.HandbookSkinView", package.seeall)

local var_0_0 = class("HandbookSkinView", BaseView)
local var_0_1 = 150
local var_0_2 = "up_start"
local var_0_3 = "donw_start"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._skinItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_scroll/#go_storyStages")
	arg_1_0._imageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._imageSkinSuitGroupIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_Icon")
	arg_1_0._imageSkinSuitGroupEnIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_TitleEn")
	arg_1_0._textPlayerName = gohelper.findChildText(arg_1_0.viewGO, "title/#title_name")
	arg_1_0._textName = gohelper.findChildText(arg_1_0.viewGO, "title/#name")
	arg_1_0._txtFloorName = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Name")
	arg_1_0._txtFloorThemeDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Descr")
	arg_1_0._goFloorItemRoot = gohelper.findChild(arg_1_0.viewGO, "Right/Scroll View/Viewport/Content")
	arg_1_0._goFloorItem = gohelper.findChild(arg_1_0.viewGO, "Right/Scroll View/Viewport/Content/Buttnitem")
	arg_1_0._goSwitch = gohelper.findChild(arg_1_0.viewGO, "switch")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "#point")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "scroll")
	arg_1_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_1_0._goscroll)

	arg_1_0._scroll:AddDragBeginListener(arg_1_0._onScrollDragBegin, arg_1_0)
	arg_1_0._scroll:AddDragEndListener(arg_1_0._onScrollDragEnd, arg_1_0)

	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._viewAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._onScrollDragBegin(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.scrollStartPos = arg_2_2.position
end

function var_0_0._onScrollDragEnd(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.position - arg_3_0.scrollStartPos
	local var_3_1 = Mathf.Abs(var_3_0.y) - var_0_1 >= 0

	if var_3_0.y > 0 and var_3_1 then
		arg_3_0:slideToPre()
	elseif var_3_0.y < 0 and var_3_1 then
		arg_3_0:slideToNext()
	end

	arg_3_0.scrollStartPos = nil
end

function var_0_0.slideToPre(arg_4_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToPre)
end

function var_0_0.slideToNext(arg_5_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SkinBookSlideToNext)
end

function var_0_0.addEvents(arg_6_0)
	arg_6_0:addEventCb(HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, arg_6_0.onClickFloorItem, arg_6_0)
end

function var_0_0.removeEvents(arg_7_0)
	return
end

function var_0_0.customAddEvent(arg_8_0)
	return
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._gopointItem = gohelper.findChild(arg_9_0.viewGO, "#point/point_item")
	arg_9_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_9_0.viewGO)

	gohelper.setActive(arg_9_0._goFloorItem, false)
	gohelper.setActive(arg_9_0._goSwitch, false)

	arg_9_0._pointItemTbList = {
		arg_9_0:_createPointTB(arg_9_0._gopointItem)
	}
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(arg_10_0.viewContainer, HandbookEvent.SkinPointChanged, arg_10_0._refresPoint, arg_10_0)

	local var_10_0 = arg_10_0.viewParam

	arg_10_0._defaultSelectedIdx = var_10_0 and var_10_0.defaultSelectedIdx or 1
	arg_10_0._curSelectedIdx = arg_10_0._defaultSelectedIdx

	arg_10_0:_createFloorItems()
	arg_10_0:_refreshDesc()

	local var_10_1 = PlayerModel.instance:getPlayinfo().name

	var_10_1 = var_10_1 and var_10_1 or ""

	local var_10_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("handbookskinview_playername"), var_10_1)

	arg_10_0._textPlayerName.text = var_10_2
	arg_10_0._textName.text = ""
end

function var_0_0.refreshBtnStatus(arg_11_0)
	return
end

function var_0_0._refreshDesc(arg_12_0)
	arg_12_0._txtFloorThemeDescr.text = arg_12_0._skinThemeCfg.des
	arg_12_0._txtFloorName.text = arg_12_0._skinThemeCfg.name

	UISpriteSetMgr.instance:setSkinHandbook(arg_12_0._imageSkinSuitGroupEnIcon, arg_12_0._skinThemeCfg.nameRes, true)
	UISpriteSetMgr.instance:setSkinHandbook(arg_12_0._imageSkinSuitGroupIcon, arg_12_0._skinThemeCfg.iconRes, true)
end

function var_0_0._createFloorItems(arg_13_0)
	arg_13_0._skinSuitFloorItems = {}
	arg_13_0._skinSuitFloorCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)

	gohelper.CreateObjList(arg_13_0, arg_13_0._createFloorItem, arg_13_0._skinSuitFloorCfgList, arg_13_0._goFloorItemRoot, arg_13_0._goFloorItem, HandbookSkinFloorItem)
end

function var_0_0._createFloorItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:onUpdateData(arg_14_2, arg_14_3)
	arg_14_1:refreshSelectState(arg_14_3 == arg_14_0._curSelectedIdx)
	arg_14_1:refreshFloorView()
	arg_14_1:setClickAction(var_0_0.clickFloorItemAction)
	arg_14_1:refreshCurSuitIdx()

	if arg_14_0._curSelectedIdx == arg_14_3 then
		local var_14_0 = arg_14_0._skinSuitFloorCfgList[arg_14_3]

		arg_14_0._skinThemeCfg = var_14_0

		HandbookController.instance:statSkinTab(var_14_0 and var_14_0.id or arg_14_3)
	end

	arg_14_0._skinSuitFloorItems[arg_14_3] = arg_14_1
end

function var_0_0.clickFloorItemAction(arg_15_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.OnClickSkinSuitFloorItem, arg_15_0:getIdx())
end

function var_0_0.onClickFloorItem(arg_16_0, arg_16_1)
	if arg_16_0._curSelectedIdx == arg_16_1 then
		return
	end

	if arg_16_1 > arg_16_0._curSelectedIdx then
		arg_16_0._isUp = true

		arg_16_0._viewAnimatorPlayer:Play(var_0_3, arg_16_0.onClickFloorAniDone, arg_16_0)
	else
		arg_16_0._isUp = false

		arg_16_0._viewAnimatorPlayer:Play(var_0_2, arg_16_0.onClickFloorAniDone, arg_16_0)
	end

	arg_16_0._curSelectedIdx = arg_16_1
end

function var_0_0.onClickFloorAniDone(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._skinSuitFloorItems) do
		iter_17_1:refreshSelectState(iter_17_0 == arg_17_0._curSelectedIdx)
	end

	local var_17_0 = arg_17_0._skinSuitFloorCfgList[arg_17_0._curSelectedIdx]

	arg_17_0._skinThemeCfg = var_17_0

	HandbookController.instance:statSkinTab(var_17_0 and var_17_0.id or arg_17_0._curSelectedIdx)
	arg_17_0:_refreshDesc()
	TaskDispatcher.runDelay(arg_17_0.onSwitchFloorDone, arg_17_0, 0.1)
end

function var_0_0.onSwitchFloorDone(arg_18_0)
	local var_18_0 = arg_18_0._isUp and "donw_end" or "up_end"

	arg_18_0._viewAnimatorPlayer:Play(var_18_0)
	HandbookController.instance:dispatchEvent(HandbookEvent.SwitchSkinSuitFloorDone)
end

function var_0_0._refresPoint(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or 1
	arg_19_2 = arg_19_2 or 0

	for iter_19_0 = #arg_19_0._pointItemTbList + 1, arg_19_2 do
		local var_19_0 = gohelper.cloneInPlace(arg_19_0._gopointItem)
		local var_19_1 = arg_19_0:_createPointTB(var_19_0)

		table.insert(arg_19_0._pointItemTbList, var_19_1)
	end

	for iter_19_1 = 1, #arg_19_0._pointItemTbList do
		local var_19_2 = arg_19_0._pointItemTbList[iter_19_1]

		gohelper.setActive(var_19_2.golight, iter_19_1 == arg_19_1)
		gohelper.setActive(var_19_2.go, iter_19_1 <= arg_19_2 and arg_19_2 > 1)
	end
end

function var_0_0._createPointTB(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getUserDataTb_()

	var_20_0.go = arg_20_1
	var_20_0.golight = gohelper.findChild(arg_20_1, "light")

	return var_20_0
end

function var_0_0.onClose(arg_21_0)
	arg_21_0._scroll:RemoveDragBeginListener()
	arg_21_0._scroll:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
