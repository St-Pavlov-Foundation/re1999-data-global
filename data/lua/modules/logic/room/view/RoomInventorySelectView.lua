module("modules.logic.room.view.RoomInventorySelectView", package.seeall)

local var_0_0 = class("RoomInventorySelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonoblurmask = gohelper.findChild(arg_1_0.viewGO, "#go_noblurmask")
	arg_1_0._goblurmask = gohelper.findChild(arg_1_0.viewGO, "#go_blurmask")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_item")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_finished")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "go_content/go_count/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_content/go_count/#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "go_content/go_count/#txt_name")
	arg_1_0._btnpackage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/go_count/#btn_package")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "go_content/go_count/#btn_package/#go_reddot")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "go_content/go_count/#txt_num")
	arg_1_0._txtdegree = gohelper.findChildText(arg_1_0.viewGO, "go_content/go_count/#txt_degree")
	arg_1_0._goreclaimtips = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_reclaimtips")
	arg_1_0._gototalitem = gohelper.findChild(arg_1_0.viewGO, "go_content/filterswitch/rescontent/#go_totalitem")
	arg_1_0._btntheme = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#btn_theme")
	arg_1_0._gounfold = gohelper.findChild(arg_1_0.viewGO, "#go_unfold")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unfold/#btn_back")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unfold/#btn_reset")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unfold/#btn_store")
	arg_1_0._btnreform = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unfold/#btn_reform")
	arg_1_0._btntransportPath = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unfold/#btn_transportPath")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "#go_switch")
	arg_1_0._btnbuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switch/#btn_building")
	arg_1_0._gobuildingreddot = gohelper.findChild(arg_1_0.viewGO, "#go_switch/#btn_building/#go_buildingreddot")
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switch/#btn_block")
	arg_1_0._goblockreddot = gohelper.findChild(arg_1_0.viewGO, "#go_switch/#btn_block/#go_blockreddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpackage:AddClickListener(arg_2_0._btnpackageOnClick, arg_2_0)
	arg_2_0._btntheme:AddClickListener(arg_2_0._btnthemeOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnreform:AddClickListener(arg_2_0._btnreformOnClick, arg_2_0)
	arg_2_0._btntransportPath:AddClickListener(arg_2_0._btntransportPathOnClick, arg_2_0)
	arg_2_0._btnbuilding:AddClickListener(arg_2_0._btnbuildingOnClick, arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpackage:RemoveClickListener()
	arg_3_0._btntheme:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnreform:RemoveClickListener()
	arg_3_0._btntransportPath:RemoveClickListener()
	arg_3_0._btnbuilding:RemoveClickListener()
	arg_3_0._btnblock:RemoveClickListener()
end

function var_0_0._btntransportPathOnClick(arg_4_0)
	arg_4_0:_openTransportPathView()
end

function var_0_0._btnthemeOnClick(arg_5_0)
	RoomController.instance:openThemeFilterView(true)
end

function var_0_0._btnbuildingOnClick(arg_6_0, arg_6_1)
	if not RoomBuildingController.instance:isBuildingListShow() and not arg_6_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	end

	RoomBuildingController.instance:setBuildingListShow(true)
	arg_6_0:_setSwithBtnSelectId(2)

	if arg_6_0._firstObtainBuilding == RoomEnum.ObtainReadState.FristObtain then
		arg_6_0:_setFristStateByKey(PlayerPrefsKey.RoomFirstObtainBuildingShow, RoomEnum.ObtainReadState.ClickToView)
		arg_6_0:_refreshFristEffect()
	end

	RoomController.instance:dispatchEvent(RoomEvent.GuideRoomInventoryBuilding)
end

function var_0_0._btnblockOnClick(arg_7_0)
	if RoomBuildingController.instance:isBuildingListShow() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	end

	RoomBuildingController.instance:setBuildingListShow(false)
	arg_7_0:_setSwithBtnSelectId(1)
end

function var_0_0._guideSwitchBlockTab(arg_8_0)
	RoomBuildingController.instance:setBuildingListShow(false)
	arg_8_0:_setSwithBtnSelectId(1)
end

function var_0_0._btnresetOnClick(arg_9_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, var_0_0._resetYesCallback)
	end
end

function var_0_0._btnmoreOnClick(arg_10_0)
	arg_10_0._isShowMoreBtn = arg_10_0._isShowMoreBtn == false

	gohelper.setActive(arg_10_0._gounfold, arg_10_0._isShowMoreBtn)
end

function var_0_0._btnconfirmOnClick(arg_11_0)
	var_0_0.confirmYesCallback()
end

function var_0_0._btnpackageOnClick(arg_12_0)
	ViewMgr.instance:openView(ViewName.RoomBlockPackageView)

	if arg_12_0._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain then
		arg_12_0:_setFristStateByKey(PlayerPrefsKey.RoomFirstObtainBlockPackageShow, RoomEnum.ObtainReadState.ClickToView)
		arg_12_0:_refreshFristEffect()
	end
end

function var_0_0._btnbackOnClick(arg_13_0)
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		arg_13_0:_setSwithBtnSelectId(1)
	end

	RoomMapController.instance:switchBackBlock(true)
end

function var_0_0._btnstoreOnClick(arg_14_0)
	var_0_0.tryConfirmAndToStore()
end

function var_0_0.tryConfirmAndToStore()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	elseif RoomMapController.instance:isResetEdit() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomConfirm, MsgBoxEnum.BoxType.Yes_No, var_0_0._confirmYesCallback)
	else
		var_0_0._confirmYesCallback()
	end
end

function var_0_0._confirmYesCallback()
	if RoomMapController.instance:isNeedConfirmRoom() then
		RoomMapController.instance:confirmRoom(var_0_0._confirmCallback)
	else
		var_0_0._confirmCallback()
	end
end

function var_0_0._confirmCallback()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.RoomStore)
end

function var_0_0._btnreformOnClick(arg_18_0)
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		arg_18_0:_setSwithBtnSelectId(1)
	end

	RoomMapController.instance:switchWaterReform(true)
end

function var_0_0._editableInitView(arg_19_0)
	arg_19_0.showAnimName = nil
	arg_19_0._gocontent = gohelper.findChild(arg_19_0.viewGO, "go_content")
	arg_19_0._gobtns = gohelper.findChild(arg_19_0.viewGO, "btns")
	arg_19_0._itemParentGO = gohelper.findChild(arg_19_0.viewGO, "go_content/#hand_inventory")
	arg_19_0._scrollblock = gohelper.findChildScrollRect(arg_19_0.viewGO, "go_content/scroll_block")
	arg_19_0._simagedegree = gohelper.findChildImage(arg_19_0.viewGO, "go_content/go_count/#txt_degree/coin")
	arg_19_0._animator = arg_19_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_19_0._scrollblockTrs = arg_19_0._scrollblock.transform
	arg_19_0._gocontentTrs = arg_19_0._gocontent.transform
	arg_19_0._gocount = gohelper.findChild(arg_19_0.viewGO, "go_content/go_count")
	arg_19_0._govxchickdown = gohelper.findChild(arg_19_0.viewGO, "go_content/go_count/vx_click_down")
	arg_19_0._govxchilckup = gohelper.findChild(arg_19_0.viewGO, "go_content/go_count/vx_click_up")
	arg_19_0._animbuilding = gohelper.findChild(arg_19_0.viewGO, "#go_switch/#btn_building/go_normal"):GetComponent(typeof(UnityEngine.Animator))

	if arg_19_0._btntheme then
		local var_19_0 = arg_19_0._btntheme.gameObject

		arg_19_0._gothemeSelect = gohelper.findChild(var_19_0, "go_select")
		arg_19_0._gothemeUnSelect = gohelper.findChild(var_19_0, "go_unselect")
	end

	arg_19_0._scrollLeft = 191
	arg_19_0._scrollRight = 41
	arg_19_0._scrollRight2 = 335
	arg_19_0._blockBuildDegree = 0

	if RoomController.instance:isEditMode() then
		arg_19_0._initRT = true

		OrthCameraRTMgr.instance:initRT()
	end

	arg_19_0:_createSwithBtnUserDataTb_(arg_19_0._btnblock.gameObject, 1)
	arg_19_0:_createSwithBtnUserDataTb_(arg_19_0._btnbuilding.gameObject, 2)
	gohelper.setActive(arg_19_0._goitem, false)
	UISpriteSetMgr.instance:setRoomSprite(arg_19_0._simagedegree, "jianshezhi")
	RedDotController.instance:addRedDot(arg_19_0._goreddot, RedDotEnum.DotNode.RoomBlockPackageBtn)
	gohelper.setActive(arg_19_0._btnstore.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank))
	arg_19_0:_setSwithBtnSelectId(1)
	gohelper.removeUIClickAudio(arg_19_0._btnblock.gameObject)
	gohelper.removeUIClickAudio(arg_19_0._btnbuilding.gameObject)
	arg_19_0:_initResList()
end

function var_0_0._createSwithBtnUserDataTb_(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getUserDataTb_()

	var_20_0._go = arg_20_1
	var_20_0._id = arg_20_2
	var_20_0._goselect = gohelper.findChild(arg_20_1, "go_select")
	var_20_0._gonormal = gohelper.findChild(arg_20_1, "go_normal")
	arg_20_0._switchBtnUserDataTbs = arg_20_0._switchBtnUserDataTbs or {}

	table.insert(arg_20_0._switchBtnUserDataTbs, var_20_0)

	return var_20_0
end

function var_0_0._setSwithBtnSelectId(arg_21_0, arg_21_1)
	for iter_21_0 = 1, #arg_21_0._switchBtnUserDataTbs do
		local var_21_0 = arg_21_0._switchBtnUserDataTbs[iter_21_0]

		gohelper.setActive(var_21_0._goselect, arg_21_1 == var_21_0._id)
		gohelper.setActive(var_21_0._gonormal, arg_21_1 ~= var_21_0._id)
	end
end

function var_0_0._initResList(arg_22_0)
	if not arg_22_0._resDataList then
		local var_22_0 = {
			RoomResourceEnum.ResourceId.River
		}

		tabletool.addValues(var_22_0, RoomResourceEnum.ResourceRoadList)

		arg_22_0._resDataList = {
			{
				isPackage = true,
				nameLanguage = "room_block_type_name_package_txt"
			},
			{
				nameLanguage = "room_block_type_name_land_txt",
				excludes = var_22_0
			},
			{
				nameLanguage = "room_block_type_name_river_txt",
				includes = {
					RoomResourceEnum.ResourceId.River
				}
			},
			{
				nameLanguage = "room_block_type_name_road_txt",
				includes = RoomResourceEnum.ResourceRoadList
			}
		}
	end

	arg_22_0._resItemList = arg_22_0._resItemList or {}

	for iter_22_0 = #arg_22_0._resItemList + 1, #arg_22_0._resDataList do
		local var_22_1 = arg_22_0._gototalitem
		local var_22_2 = gohelper.cloneInPlace(var_22_1, "btn_resItem" .. iter_22_0)

		gohelper.setActive(var_22_2, true)
		gohelper.addUIClickAudio(var_22_2, AudioEnum.UI.play_ui_role_open)

		local var_22_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_2, RoomViewBuildingResItem, arg_22_0)

		var_22_3:setCallback(arg_22_0._onResItemOnClick, arg_22_0)
		table.insert(arg_22_0._resItemList, var_22_3)
	end

	for iter_22_1 = 1, #arg_22_0._resDataList do
		local var_22_4 = arg_22_0._resItemList[iter_22_1]

		gohelper.setActive(var_22_4:getGO(), true)
		var_22_4:setData(arg_22_0._resDataList[iter_22_1])
		var_22_4:setSelect(arg_22_0._curSelectResData == arg_22_0._resDataList[iter_22_1])
		var_22_4:setLineActive(iter_22_1 > 1)
	end

	for iter_22_2 = #arg_22_0._resDataList + 1, #arg_22_0._resItemList do
		gohelper.setActive(arg_22_0._resItemList[iter_22_2]:getGO(), false)
	end

	gohelper.setActive(arg_22_0._gototalitem, false)
	arg_22_0:_setSelectResData(arg_22_0._resDataList[1])
end

function var_0_0._onResItemOnClick(arg_23_0, arg_23_1)
	if arg_23_0._curSelectResData == arg_23_1 then
		return
	end

	arg_23_0:_setSelectResData(arg_23_1)
end

function var_0_0._setSelectResData(arg_24_0, arg_24_1)
	if arg_24_0._curSelectResData ~= arg_24_1 then
		GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	arg_24_0._curSelectResData = arg_24_1

	for iter_24_0 = 1, #arg_24_0._resItemList do
		local var_24_0 = arg_24_0._resItemList[iter_24_0]

		var_24_0:setSelect(arg_24_1 == var_24_0:getData())
	end

	if arg_24_1 then
		RoomShowBlockListModel.instance:setFilterResType(arg_24_1.includes, arg_24_1.excludes)
		RoomShowBlockListModel.instance:setIsPackage(arg_24_1.isPackage)
	else
		RoomShowBlockListModel.instance:setFilterResType(nil, nil)
		RoomShowBlockListModel.instance:setIsPackage(true)
	end

	local var_24_1 = RoomShowBlockListModel.instance:getIsPackage()

	gohelper.setActive(arg_24_0._gocount, var_24_1)
	gohelper.setActive(arg_24_0._btntheme, not var_24_1)

	local var_24_2 = recthelper.getWidth(arg_24_0._gocontentTrs)
	local var_24_3 = var_24_1 and arg_24_0._scrollRight2 or arg_24_0._scrollRight
	local var_24_4 = var_24_2 - arg_24_0._scrollLeft - var_24_3

	recthelper.setWidth(arg_24_0._scrollblockTrs, var_24_4)
	recthelper.setAnchorX(arg_24_0._scrollblockTrs, (var_24_4 - var_24_2) * 0.5 + arg_24_0._scrollLeft)
	RoomMapController.instance:setRoomShowBlockList()
	arg_24_0:_refresFinishUI()
end

function var_0_0._themeFilterChanged(arg_25_0)
	RoomMapController.instance:setRoomShowBlockList()
	arg_25_0:_refreshFilterState()
	arg_25_0:_refresFinishUI()
end

function var_0_0._refreshFilterState(arg_26_0)
	local var_26_0 = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if arg_26_0._isLastThemeOpen ~= var_26_0 then
		arg_26_0._isLastThemeOpen = var_26_0

		gohelper.setActive(arg_26_0._gothemeUnSelect, not var_26_0)
		gohelper.setActive(arg_26_0._gothemeSelect, var_26_0)
	end
end

function var_0_0.onUpdateParam(arg_27_0)
	return
end

function var_0_0.onOpen(arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateInventoryCount, arg_28_0._refreshCountHandler, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmSelectBlockPackage, arg_28_0._refreshBlockPackageHandler, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, arg_28_0._onBackBlockEventHandler, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, arg_28_0._onBackBlockEventHandler, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, arg_28_0._onBackBlockEventHandler, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_28_0._onBackBlockShowChanged, arg_28_0)
	arg_28_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_28_0._onCheckShowView, arg_28_0)
	arg_28_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_28_0._onWaterReformShowChanged, arg_28_0)
	arg_28_0:addEventCb(RoomController.instance, RoomEvent.GuideRoomInventoryBlock, arg_28_0._guideSwitchBlockTab, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, arg_28_0._onNewBuildingPush, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.NewBlockPackagePush, arg_28_0._onNewBlockPackagePush, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_28_0._themeFilterChanged, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, arg_28_0._onTransportPathShowChanged, arg_28_0)
	arg_28_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_28_0._tradeLevelUp, arg_28_0)
	NavigateMgr.instance:addEscape(ViewName.RoomInventorySelectView, arg_28_0._onEscBtnClick, arg_28_0)
	RoomShowBlockListModel.instance:initShowBlock()
	arg_28_0:_refreshUI()
	arg_28_0:_onCheckShowView()
	arg_28_0:_refreshFristEffect()
	arg_28_0:_refreshFilterState()

	local var_28_0, var_28_1 = arg_28_0:_isOpenTransporPath()

	if not var_28_0 or var_28_1 then
		gohelper.setActive(arg_28_0._btntransportPath, false)
	end

	if var_28_1 then
		TaskDispatcher.runDelay(arg_28_0._tradeLevelUp, arg_28_0, 2)
	end

	if arg_28_0.viewParam and arg_28_0.viewParam.isJumpTransportSite then
		arg_28_0:_openTransportPathView()
	end
end

function var_0_0.onClose(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._tradeLevelUp, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._delayOpenOrClose, arg_29_0)
end

function var_0_0._onBackBlockEventHandler(arg_30_0)
	return
end

function var_0_0._onNewBuildingPush(arg_31_0)
	if arg_31_0._firstObtainBuilding == RoomEnum.ObtainReadState.None then
		arg_31_0:_refreshFristEffect()
	end
end

function var_0_0._onNewBlockPackagePush(arg_32_0)
	if arg_32_0._firstObtainPackage == RoomEnum.ObtainReadState.None then
		arg_32_0:_refreshFristEffect()
	end
end

function var_0_0._onBackBlockShowChanged(arg_33_0)
	local var_33_0 = RoomMapBlockModel.instance:isBackMore()

	arg_33_0:_onRemodeOpenAnimShowChanged(not var_33_0)
end

function var_0_0._onWaterReformShowChanged(arg_34_0)
	local var_34_0 = RoomWaterReformModel.instance:isWaterReform()

	arg_34_0:_onRemodeOpenAnimShowChanged(not var_34_0)
end

function var_0_0._onTransportPathShowChanged(arg_35_0)
	local var_35_0 = RoomTransportController.instance:isTransportPathShow()

	arg_35_0:_onRemodeOpenAnimShowChanged(not var_35_0)
end

function var_0_0._tradeLevelUp(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0:_isOpenTransporPath()

	gohelper.setActive(arg_36_0._btntransportPath, var_36_0)

	if var_36_0 and var_36_1 then
		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockTransportPath, 1)

		local var_36_2 = arg_36_0._btntransportPath.gameObject:GetComponent(RoomEnum.ComponentType.Animator)

		if var_36_2 then
			var_36_2:Play(RoomTradeEnum.TradeAnim.Unlock, 0, 0)
		end
	end
end

function var_0_0._isOpenTransporPath(arg_37_0)
	local var_37_0 = ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)
	local var_37_1 = false

	if var_37_0 and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockTransportPath) ~= 1 then
		var_37_1 = true
	end

	return var_37_0, var_37_1
end

function var_0_0._onRemodeOpenAnimShowChanged(arg_38_0, arg_38_1)
	if arg_38_1 then
		arg_38_0.showAnimName = "remodel_open"
	end

	arg_38_0:_onCheckShowView()
end

function var_0_0._onCheckShowView(arg_39_0)
	local var_39_0 = RoomMapBlockModel.instance:isBackMore()
	local var_39_1 = RoomBuildingController.instance:isBuildingListShow()
	local var_39_2 = RoomWaterReformModel.instance:isWaterReform()
	local var_39_3 = RoomTransportController.instance:isTransportPathShow()
	local var_39_4 = true

	if var_39_0 or var_39_1 or var_39_2 or var_39_3 then
		var_39_4 = false
	end

	if arg_39_0._isViewShowing ~= var_39_4 then
		arg_39_0._isViewShowing = var_39_4

		TaskDispatcher.cancelTask(arg_39_0._delayOpenOrClose, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0._delayOpenOrClose, arg_39_0, 0.13333333333333333)

		if not var_39_4 then
			local var_39_5 = "roominventoryselectview_out"

			if var_39_2 or var_39_0 or var_39_3 then
				var_39_5 = "remodel_close"
			end

			arg_39_0._animator:Play(var_39_5, 0, 0)
		end
	end
end

function var_0_0._refreshCountHandler(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:_refreshUI()
end

function var_0_0._refreshBlockPackageHandler(arg_41_0)
	local var_41_0 = GameSceneMgr.instance:getCurScene()

	var_41_0.inventorymgr:moveForward()
	var_41_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	RoomShowBlockListModel.instance:initShowBlock()
	arg_41_0:_refreshUI()
end

function var_0_0._refreshUI(arg_42_0)
	local var_42_0 = RoomInventoryBlockModel.instance:getCurPackageMO()
	local var_42_1 = var_42_0 and var_42_0.id or nil

	if arg_42_0._lastPacageId ~= var_42_1 then
		arg_42_0._lastPacageId = var_42_1

		local var_42_2 = RoomConfig.instance:getBlockPackageConfig(var_42_1)

		arg_42_0._blockBuildDegree = var_42_2 and var_42_2.blockBuildDegree or 0

		arg_42_0:_refresPackageUI(var_42_2)
	end

	local var_42_3 = var_42_0 and var_42_0:getUnUseCount() or 0
	local var_42_4 = var_42_3 < 1 and true or false

	arg_42_0:_refresFinishUI()

	arg_42_0._txtnum.text = var_42_4 and 0 or var_42_3
	arg_42_0._txtdegree.text = var_42_4 and 0 or arg_42_0._blockBuildDegree * var_42_3

	if arg_42_0._lastIsEmpty ~= var_42_4 then
		arg_42_0._lastIsEmpty = var_42_4

		local var_42_5 = var_42_4 and "#D97373" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(arg_42_0._txtnum, var_42_5)
		SLFramework.UGUI.GuiHelper.SetColor(arg_42_0._txtdegree, var_42_5)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
end

function var_0_0._refresFinishUI(arg_43_0)
	gohelper.setActive(arg_43_0._gofinished, RoomShowBlockListModel.instance:getCount() < 1)
end

function var_0_0._refresPackageUI(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 and true or false

	gohelper.setActive(arg_44_0._simageicon.gameObject, var_44_0)

	arg_44_0._txtname.text = arg_44_1 and arg_44_1.name or ""

	if var_44_0 then
		arg_44_0._simageicon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. arg_44_1.icon))

		local var_44_1 = RoomBlockPackageEnum.RareBigIcon[arg_44_1.rare] or RoomBlockPackageEnum.RareBigIcon[1]

		UISpriteSetMgr.instance:setRoomSprite(arg_44_0._imagerare, var_44_1)
	end
end

function var_0_0._refreshFristEffect(arg_45_0)
	arg_45_0._firstObtainPackage = arg_45_0:_getFristPackageObtainState()
	arg_45_0._firstObtainBuilding = arg_45_0:_getFristBuildingObtainState()

	gohelper.setActive(arg_45_0._govxchickdown, arg_45_0._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain)
	gohelper.setActive(arg_45_0._govxchilckup, arg_45_0._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain)

	if arg_45_0._lastbuilingObtainState ~= arg_45_0._firstObtainBuilding then
		arg_45_0._lastbuilingObtainState = arg_45_0._firstObtainBuilding

		local var_45_0 = arg_45_0._firstObtainBuilding == RoomEnum.ObtainReadState.FristObtain and "loop" or "idle"

		arg_45_0._animbuilding:Play(var_45_0, 0, 0)
	end
end

function var_0_0._delayOpenOrClose(arg_46_0)
	local var_46_0 = RoomMapBlockModel.instance:isBackMore()
	local var_46_1 = RoomWaterReformModel.instance:isWaterReform()
	local var_46_2 = RoomBuildingController.instance:isBuildingListShow()
	local var_46_3 = RoomTransportController.instance:isTransportPathShow()

	gohelper.setActive(arg_46_0._gocontent, arg_46_0._isViewShowing)
	gohelper.setActive(arg_46_0._gobtns, arg_46_0._isViewShowing)
	gohelper.setActive(arg_46_0._goblurmask, arg_46_0._isViewShowing)

	local var_46_4 = not var_46_0 and not var_46_1 and not var_46_3

	gohelper.setActive(arg_46_0._gounfold, var_46_4)
	gohelper.setActive(arg_46_0._goswitch, var_46_4)
	gohelper.setActive(arg_46_0._gonoblurmask, (var_46_1 or var_46_0) and not var_46_2)

	if arg_46_0._isViewShowing then
		local var_46_5 = "roominventoryselectview_in"

		if not string.nilorempty(arg_46_0.showAnimName) then
			var_46_5 = arg_46_0.showAnimName
			arg_46_0.showAnimName = nil
		end

		arg_46_0._animator:Play(var_46_5, 0, 0)
	end
end

function var_0_0.onDestroyView(arg_47_0)
	if arg_47_0._initRT == true then
		arg_47_0._initRT = false

		OrthCameraRTMgr.instance:destroyRT()
	end

	arg_47_0._simageicon:UnLoadImage()

	arg_47_0.showAnimName = nil
end

function var_0_0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function var_0_0.confirmYesCallback()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	elseif RoomMapController.instance:isResetEdit() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomConfirm, MsgBoxEnum.BoxType.Yes_No, RoomView._confirmYesCallback)
	else
		RoomView._confirmYesCallback()
	end
end

function var_0_0._revertYesCallback(arg_50_0)
	RoomMapController.instance:revertRoom()
end

function var_0_0._onEscBtnClick(arg_51_0)
	if RoomMapBlockModel.instance:isBackMore() then
		RoomMapController.instance:switchBackBlock(false)

		return
	end

	if RoomWaterReformModel.instance:isWaterReform() then
		RoomWaterReformController.instance:saveReform()

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	if GameSceneMgr.instance:getCurScene().camera:isTweening() then
		return
	end

	RoomController.instance:exitRoom()
end

function var_0_0._getFristBuildingObtainState(arg_52_0)
	local var_52_0 = arg_52_0:_getFristStateByKey(PlayerPrefsKey.RoomFirstObtainBuildingShow)

	if var_52_0 == RoomEnum.ObtainReadState.None then
		local var_52_1 = RoomModel.instance:getBuildingInfoList()

		if var_52_1 and #var_52_1 > 0 then
			var_52_0 = RoomEnum.ObtainReadState.FristObtain
		end
	end

	return var_52_0
end

function var_0_0._getFristPackageObtainState(arg_53_0)
	local var_53_0 = arg_53_0:_getFristStateByKey(PlayerPrefsKey.RoomFirstObtainBlockPackageShow)

	if var_53_0 == RoomEnum.ObtainReadState.None then
		local var_53_1 = RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()

		if var_53_1 and #var_53_1 > 1 then
			var_53_0 = RoomEnum.ObtainReadState.FristObtain
		end
	end

	return var_53_0
end

function var_0_0._getFristStateByKey(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.getNumber(var_54_0, RoomEnum.ObtainReadState.None)
end

function var_0_0._setFristStateByKey(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_1 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.setNumber(var_55_0, arg_55_2)
end

function var_0_0._openTransportPathView(arg_56_0)
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		arg_56_0:_setSwithBtnSelectId(1)
	else
		local var_56_0 = GameSceneMgr.instance:getCurScene()

		var_56_0.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		var_56_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	RoomTransportController.instance:openTransportPathView()
	arg_56_0:_onCheckShowView()
end

return var_0_0
