module("modules.logic.room.view.RoomInventorySelectView", package.seeall)

slot0 = class("RoomInventorySelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._gonoblurmask = gohelper.findChild(slot0.viewGO, "#go_noblurmask")
	slot0._goblurmask = gohelper.findChild(slot0.viewGO, "#go_blurmask")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "go_content/#go_item")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "go_content/#go_finished")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "go_content/go_count/#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "go_content/go_count/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "go_content/go_count/#txt_name")
	slot0._btnpackage = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/go_count/#btn_package")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "go_content/go_count/#btn_package/#go_reddot")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "go_content/go_count/#txt_num")
	slot0._txtdegree = gohelper.findChildText(slot0.viewGO, "go_content/go_count/#txt_degree")
	slot0._goreclaimtips = gohelper.findChild(slot0.viewGO, "go_content/#go_reclaimtips")
	slot0._gototalitem = gohelper.findChild(slot0.viewGO, "go_content/filterswitch/rescontent/#go_totalitem")
	slot0._btntheme = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#btn_theme")
	slot0._gounfold = gohelper.findChild(slot0.viewGO, "#go_unfold")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unfold/#btn_back")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unfold/#btn_reset")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unfold/#btn_store")
	slot0._btnreform = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unfold/#btn_reform")
	slot0._btntransportPath = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unfold/#btn_transportPath")
	slot0._goswitch = gohelper.findChild(slot0.viewGO, "#go_switch")
	slot0._btnbuilding = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_switch/#btn_building")
	slot0._gobuildingreddot = gohelper.findChild(slot0.viewGO, "#go_switch/#btn_building/#go_buildingreddot")
	slot0._btnblock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_switch/#btn_block")
	slot0._goblockreddot = gohelper.findChild(slot0.viewGO, "#go_switch/#btn_block/#go_blockreddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnpackage:AddClickListener(slot0._btnpackageOnClick, slot0)
	slot0._btntheme:AddClickListener(slot0._btnthemeOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
	slot0._btnreform:AddClickListener(slot0._btnreformOnClick, slot0)
	slot0._btntransportPath:AddClickListener(slot0._btntransportPathOnClick, slot0)
	slot0._btnbuilding:AddClickListener(slot0._btnbuildingOnClick, slot0)
	slot0._btnblock:AddClickListener(slot0._btnblockOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnpackage:RemoveClickListener()
	slot0._btntheme:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnreform:RemoveClickListener()
	slot0._btntransportPath:RemoveClickListener()
	slot0._btnbuilding:RemoveClickListener()
	slot0._btnblock:RemoveClickListener()
end

function slot0._btntransportPathOnClick(slot0)
	slot0:_openTransportPathView()
end

function slot0._btnthemeOnClick(slot0)
	RoomController.instance:openThemeFilterView(true)
end

function slot0._btnbuildingOnClick(slot0, slot1)
	if not RoomBuildingController.instance:isBuildingListShow() and not slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	end

	RoomBuildingController.instance:setBuildingListShow(true)
	slot0:_setSwithBtnSelectId(2)

	if slot0._firstObtainBuilding == RoomEnum.ObtainReadState.FristObtain then
		slot0:_setFristStateByKey(PlayerPrefsKey.RoomFirstObtainBuildingShow, RoomEnum.ObtainReadState.ClickToView)
		slot0:_refreshFristEffect()
	end

	RoomController.instance:dispatchEvent(RoomEvent.GuideRoomInventoryBuilding)
end

function slot0._btnblockOnClick(slot0)
	if RoomBuildingController.instance:isBuildingListShow() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	end

	RoomBuildingController.instance:setBuildingListShow(false)
	slot0:_setSwithBtnSelectId(1)
end

function slot0._guideSwitchBlockTab(slot0)
	RoomBuildingController.instance:setBuildingListShow(false)
	slot0:_setSwithBtnSelectId(1)
end

function slot0._btnresetOnClick(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, uv0._resetYesCallback)
	end
end

function slot0._btnmoreOnClick(slot0)
	slot0._isShowMoreBtn = slot0._isShowMoreBtn == false

	gohelper.setActive(slot0._gounfold, slot0._isShowMoreBtn)
end

function slot0._btnconfirmOnClick(slot0)
	uv0.confirmYesCallback()
end

function slot0._btnpackageOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomBlockPackageView)

	if slot0._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain then
		slot0:_setFristStateByKey(PlayerPrefsKey.RoomFirstObtainBlockPackageShow, RoomEnum.ObtainReadState.ClickToView)
		slot0:_refreshFristEffect()
	end
end

function slot0._btnbackOnClick(slot0)
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		slot0:_setSwithBtnSelectId(1)
	end

	RoomMapController.instance:switchBackBlock(true)
end

function slot0._btnstoreOnClick(slot0)
	uv0.tryConfirmAndToStore()
end

function slot0.tryConfirmAndToStore()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	elseif RoomMapController.instance:isResetEdit() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomConfirm, MsgBoxEnum.BoxType.Yes_No, uv0._confirmYesCallback)
	else
		uv0._confirmYesCallback()
	end
end

function slot0._confirmYesCallback()
	if RoomMapController.instance:isNeedConfirmRoom() then
		RoomMapController.instance:confirmRoom(uv0._confirmCallback)
	else
		uv0._confirmCallback()
	end
end

function slot0._confirmCallback()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.Room)
end

function slot0._btnreformOnClick(slot0)
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		slot0:_setSwithBtnSelectId(1)
	end

	RoomMapController.instance:switchWaterReform(true)
end

function slot0._editableInitView(slot0)
	slot0.showAnimName = nil
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "go_content")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "btns")
	slot0._itemParentGO = gohelper.findChild(slot0.viewGO, "go_content/#hand_inventory")
	slot0._scrollblock = gohelper.findChildScrollRect(slot0.viewGO, "go_content/scroll_block")
	slot0._simagedegree = gohelper.findChildImage(slot0.viewGO, "go_content/go_count/#txt_degree/coin")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._scrollblockTrs = slot0._scrollblock.transform
	slot0._gocontentTrs = slot0._gocontent.transform
	slot0._gocount = gohelper.findChild(slot0.viewGO, "go_content/go_count")
	slot0._govxchickdown = gohelper.findChild(slot0.viewGO, "go_content/go_count/vx_click_down")
	slot0._govxchilckup = gohelper.findChild(slot0.viewGO, "go_content/go_count/vx_click_up")
	slot0._animbuilding = gohelper.findChild(slot0.viewGO, "#go_switch/#btn_building/go_normal"):GetComponent(typeof(UnityEngine.Animator))

	if slot0._btntheme then
		slot2 = slot0._btntheme.gameObject
		slot0._gothemeSelect = gohelper.findChild(slot2, "go_select")
		slot0._gothemeUnSelect = gohelper.findChild(slot2, "go_unselect")
	end

	slot0._scrollLeft = 191
	slot0._scrollRight = 41
	slot0._scrollRight2 = 335
	slot0._blockBuildDegree = 0

	if RoomController.instance:isEditMode() then
		slot0._initRT = true

		OrthCameraRTMgr.instance:initRT()
	end

	slot0:_createSwithBtnUserDataTb_(slot0._btnblock.gameObject, 1)
	slot0:_createSwithBtnUserDataTb_(slot0._btnbuilding.gameObject, 2)
	gohelper.setActive(slot0._goitem, false)
	UISpriteSetMgr.instance:setRoomSprite(slot0._simagedegree, "jianshezhi")
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomBlockPackageBtn)
	gohelper.setActive(slot0._btnstore.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank))
	slot0:_setSwithBtnSelectId(1)
	gohelper.removeUIClickAudio(slot0._btnblock.gameObject)
	gohelper.removeUIClickAudio(slot0._btnbuilding.gameObject)
	slot0:_initResList()
end

function slot0._createSwithBtnUserDataTb_(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3._go = slot1
	slot3._id = slot2
	slot3._goselect = gohelper.findChild(slot1, "go_select")
	slot3._gonormal = gohelper.findChild(slot1, "go_normal")
	slot0._switchBtnUserDataTbs = slot0._switchBtnUserDataTbs or {}

	table.insert(slot0._switchBtnUserDataTbs, slot3)

	return slot3
end

function slot0._setSwithBtnSelectId(slot0, slot1)
	for slot5 = 1, #slot0._switchBtnUserDataTbs do
		slot6 = slot0._switchBtnUserDataTbs[slot5]

		gohelper.setActive(slot6._goselect, slot1 == slot6._id)
		gohelper.setActive(slot6._gonormal, slot1 ~= slot6._id)
	end
end

function slot0._initResList(slot0)
	if not slot0._resDataList then
		slot1 = {
			RoomResourceEnum.ResourceId.River
		}

		tabletool.addValues(slot1, RoomResourceEnum.ResourceRoadList)

		slot0._resDataList = {
			{
				isPackage = true,
				nameLanguage = "room_block_type_name_package_txt"
			},
			{
				nameLanguage = "room_block_type_name_land_txt",
				excludes = slot1
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

	slot0._resItemList = slot0._resItemList or {}

	for slot4 = #slot0._resItemList + 1, #slot0._resDataList do
		slot6 = gohelper.cloneInPlace(slot0._gototalitem, "btn_resItem" .. slot4)

		gohelper.setActive(slot6, true)
		gohelper.addUIClickAudio(slot6, AudioEnum.UI.play_ui_role_open)

		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot6, RoomViewBuildingResItem, slot0)

		slot7:setCallback(slot0._onResItemOnClick, slot0)
		table.insert(slot0._resItemList, slot7)
	end

	for slot4 = 1, #slot0._resDataList do
		slot5 = slot0._resItemList[slot4]

		gohelper.setActive(slot5:getGO(), true)
		slot5:setData(slot0._resDataList[slot4])
		slot5:setSelect(slot0._curSelectResData == slot0._resDataList[slot4])
		slot5:setLineActive(slot4 > 1)
	end

	for slot4 = #slot0._resDataList + 1, #slot0._resItemList do
		gohelper.setActive(slot0._resItemList[slot4]:getGO(), false)
	end

	gohelper.setActive(slot0._gototalitem, false)
	slot0:_setSelectResData(slot0._resDataList[1])
end

function slot0._onResItemOnClick(slot0, slot1)
	if slot0._curSelectResData == slot1 then
		return
	end

	slot0:_setSelectResData(slot1)
end

function slot0._setSelectResData(slot0, slot1)
	slot0._curSelectResData = slot1

	for slot5 = 1, #slot0._resItemList do
		slot6 = slot0._resItemList[slot5]

		slot6:setSelect(slot1 == slot6:getData())
	end

	if slot1 then
		RoomShowBlockListModel.instance:setFilterResType(slot1.includes, slot1.excludes)
		RoomShowBlockListModel.instance:setIsPackage(slot1.isPackage)
	else
		RoomShowBlockListModel.instance:setFilterResType(nil, )
		RoomShowBlockListModel.instance:setIsPackage(true)
	end

	slot2 = RoomShowBlockListModel.instance:getIsPackage()

	gohelper.setActive(slot0._gocount, slot2)
	gohelper.setActive(slot0._btntheme, not slot2)

	slot3 = recthelper.getWidth(slot0._gocontentTrs)
	slot5 = slot3 - slot0._scrollLeft - (slot2 and slot0._scrollRight2 or slot0._scrollRight)

	recthelper.setWidth(slot0._scrollblockTrs, slot5)
	recthelper.setAnchorX(slot0._scrollblockTrs, (slot5 - slot3) * 0.5 + slot0._scrollLeft)
	RoomShowBlockListModel.instance:setShowBlockList()
	slot0:_refresFinishUI()
end

function slot0._themeFilterChanged(slot0)
	RoomShowBlockListModel.instance:setShowBlockList()
	slot0:_refreshFilterState()
	slot0:_refresFinishUI()
end

function slot0._refreshFilterState(slot0)
	if slot0._isLastThemeOpen ~= (RoomThemeFilterListModel.instance:getSelectCount() > 0) then
		slot0._isLastThemeOpen = slot1

		gohelper.setActive(slot0._gothemeUnSelect, not slot1)
		gohelper.setActive(slot0._gothemeSelect, slot1)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateInventoryCount, slot0._refreshCountHandler, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmSelectBlockPackage, slot0._refreshBlockPackageHandler, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, slot0._onBackBlockEventHandler, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, slot0._onBackBlockEventHandler, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, slot0._onBackBlockEventHandler, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, slot0._onBackBlockShowChanged, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, slot0._onCheckShowView, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._onWaterReformShowChanged, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.GuideRoomInventoryBlock, slot0._guideSwitchBlockTab, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, slot0._onNewBuildingPush, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.NewBlockPackagePush, slot0._onNewBlockPackagePush, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, slot0._themeFilterChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, slot0._onTransportPathShowChanged, slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, slot0._tradeLevelUp, slot0)
	NavigateMgr.instance:addEscape(ViewName.RoomInventorySelectView, slot0._onEscBtnClick, slot0)
	RoomShowBlockListModel.instance:initShowBlock()
	slot0:_refreshUI()
	slot0:_onCheckShowView()
	slot0:_refreshFristEffect()
	slot0:_refreshFilterState()

	slot1, slot2 = slot0:_isOpenTransporPath()

	if not slot1 or slot2 then
		gohelper.setActive(slot0._btntransportPath, false)
	end

	if slot2 then
		TaskDispatcher.runDelay(slot0._tradeLevelUp, slot0, 2)
	end

	if slot0.viewParam and slot0.viewParam.isJumpTransportSite then
		slot0:_openTransportPathView()
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._tradeLevelUp, slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenOrClose, slot0)
end

function slot0._onBackBlockEventHandler(slot0)
end

function slot0._onNewBuildingPush(slot0)
	if slot0._firstObtainBuilding == RoomEnum.ObtainReadState.None then
		slot0:_refreshFristEffect()
	end
end

function slot0._onNewBlockPackagePush(slot0)
	if slot0._firstObtainPackage == RoomEnum.ObtainReadState.None then
		slot0:_refreshFristEffect()
	end
end

function slot0._onBackBlockShowChanged(slot0)
	slot0:_onRemodeOpenAnimShowChanged(not RoomMapBlockModel.instance:isBackMore())
end

function slot0._onWaterReformShowChanged(slot0)
	slot0:_onRemodeOpenAnimShowChanged(not RoomWaterReformModel.instance:isWaterReform())
end

function slot0._onTransportPathShowChanged(slot0)
	slot0:_onRemodeOpenAnimShowChanged(not RoomTransportController.instance:isTransportPathShow())
end

function slot0._tradeLevelUp(slot0)
	slot1, slot2 = slot0:_isOpenTransporPath()

	gohelper.setActive(slot0._btntransportPath, slot1)

	if slot1 and slot2 then
		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockTransportPath, 1)

		if slot0._btntransportPath.gameObject:GetComponent(RoomEnum.ComponentType.Animator) then
			slot3:Play(RoomTradeEnum.TradeAnim.Unlock, 0, 0)
		end
	end
end

function slot0._isOpenTransporPath(slot0)
	slot2 = false

	if ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen) <= ManufactureModel.instance:getTradeLevel() and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockTransportPath) ~= 1 then
		slot2 = true
	end

	return slot1, slot2
end

function slot0._onRemodeOpenAnimShowChanged(slot0, slot1)
	if slot1 then
		slot0.showAnimName = "remodel_open"
	end

	slot0:_onCheckShowView()
end

function slot0._onCheckShowView(slot0)
	slot5 = true

	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() or RoomWaterReformModel.instance:isWaterReform() or RoomTransportController.instance:isTransportPathShow() then
		slot5 = false
	end

	if slot0._isViewShowing ~= slot5 then
		slot0._isViewShowing = slot5

		TaskDispatcher.cancelTask(slot0._delayOpenOrClose, slot0)
		TaskDispatcher.runDelay(slot0._delayOpenOrClose, slot0, 0.13333333333333333)

		if not slot5 then
			slot6 = "roominventoryselectview_out"

			if slot3 or slot1 or slot4 then
				slot6 = "remodel_close"
			end

			slot0._animator:Play(slot6, 0, 0)
		end
	end
end

function slot0._refreshCountHandler(slot0, slot1, slot2)
	slot0:_refreshUI()
end

function slot0._refreshBlockPackageHandler(slot0)
	slot1 = GameSceneMgr.instance:getCurScene()

	slot1.inventorymgr:moveForward()
	slot1.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	RoomShowBlockListModel.instance:initShowBlock()
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if slot0._lastPacageId ~= (RoomInventoryBlockModel.instance:getCurPackageMO() and slot1.id or nil) then
		slot0._lastPacageId = slot2
		slot0._blockBuildDegree = RoomConfig.instance:getBlockPackageConfig(slot2) and slot3.blockBuildDegree or 0

		slot0:_refresPackageUI(slot3)
	end

	slot3 = slot1 and slot1:getUnUseCount() or 0
	slot4 = slot3 < 1 and true or false

	slot0:_refresFinishUI()

	slot0._txtnum.text = slot4 and 0 or slot3
	slot0._txtdegree.text = slot4 and 0 or slot0._blockBuildDegree * slot3

	if slot0._lastIsEmpty ~= slot4 then
		slot0._lastIsEmpty = slot4
		slot5 = slot4 and "#D97373" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtnum, slot5)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtdegree, slot5)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
end

function slot0._refresFinishUI(slot0)
	gohelper.setActive(slot0._gofinished, RoomShowBlockListModel.instance:getCount() < 1)
end

function slot0._refresPackageUI(slot0, slot1)
	slot2 = slot1 and true or false

	gohelper.setActive(slot0._simageicon.gameObject, slot2)

	slot0._txtname.text = slot1 and slot1.name or ""

	if slot2 then
		slot0._simageicon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. slot1.icon))
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBlockPackageEnum.RareBigIcon[slot1.rare] or RoomBlockPackageEnum.RareBigIcon[1])
	end
end

function slot0._refreshFristEffect(slot0)
	slot0._firstObtainPackage = slot0:_getFristPackageObtainState()
	slot0._firstObtainBuilding = slot0:_getFristBuildingObtainState()

	gohelper.setActive(slot0._govxchickdown, slot0._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain)
	gohelper.setActive(slot0._govxchilckup, slot0._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain)

	if slot0._lastbuilingObtainState ~= slot0._firstObtainBuilding then
		slot0._lastbuilingObtainState = slot0._firstObtainBuilding

		slot0._animbuilding:Play(slot0._firstObtainBuilding == RoomEnum.ObtainReadState.FristObtain and "loop" or "idle", 0, 0)
	end
end

function slot0._delayOpenOrClose(slot0)
	slot2 = RoomWaterReformModel.instance:isWaterReform()

	gohelper.setActive(slot0._gocontent, slot0._isViewShowing)
	gohelper.setActive(slot0._gobtns, slot0._isViewShowing)
	gohelper.setActive(slot0._goblurmask, slot0._isViewShowing)

	slot5 = not RoomMapBlockModel.instance:isBackMore() and not slot2 and not RoomTransportController.instance:isTransportPathShow()

	gohelper.setActive(slot0._gounfold, slot5)
	gohelper.setActive(slot0._goswitch, slot5)
	gohelper.setActive(slot0._gonoblurmask, (slot2 or slot1) and not RoomBuildingController.instance:isBuildingListShow())

	if slot0._isViewShowing then
		slot6 = "roominventoryselectview_in"

		if not string.nilorempty(slot0.showAnimName) then
			slot6 = slot0.showAnimName
			slot0.showAnimName = nil
		end

		slot0._animator:Play(slot6, 0, 0)
	end
end

function slot0.onDestroyView(slot0)
	if slot0._initRT == true then
		slot0._initRT = false

		OrthCameraRTMgr.instance:destroyRT()
	end

	slot0._simageicon:UnLoadImage()

	slot0.showAnimName = nil
end

function slot0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function slot0.confirmYesCallback()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	elseif RoomMapController.instance:isResetEdit() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomConfirm, MsgBoxEnum.BoxType.Yes_No, RoomView._confirmYesCallback)
	else
		RoomView._confirmYesCallback()
	end
end

function slot0._revertYesCallback(slot0)
	RoomMapController.instance:revertRoom()
end

function slot0._onEscBtnClick(slot0)
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

function slot0._getFristBuildingObtainState(slot0)
	if slot0:_getFristStateByKey(PlayerPrefsKey.RoomFirstObtainBuildingShow) == RoomEnum.ObtainReadState.None and RoomModel.instance:getBuildingInfoList() and #slot2 > 0 then
		slot1 = RoomEnum.ObtainReadState.FristObtain
	end

	return slot1
end

function slot0._getFristPackageObtainState(slot0)
	if slot0:_getFristStateByKey(PlayerPrefsKey.RoomFirstObtainBlockPackageShow) == RoomEnum.ObtainReadState.None and RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList() and #slot2 > 1 then
		slot1 = RoomEnum.ObtainReadState.FristObtain
	end

	return slot1
end

function slot0._getFristStateByKey(slot0, slot1)
	return PlayerPrefsHelper.getNumber(slot1 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), RoomEnum.ObtainReadState.None)
end

function slot0._setFristStateByKey(slot0, slot1, slot2)
	return PlayerPrefsHelper.setNumber(slot1 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), slot2)
end

function slot0._openTransportPathView(slot0)
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		slot0:_setSwithBtnSelectId(1)
	else
		slot1 = GameSceneMgr.instance:getCurScene()

		slot1.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		slot1.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	RoomTransportController.instance:openTransportPathView()
	slot0:_onCheckShowView()
end

return slot0
