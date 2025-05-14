module("modules.logic.room.view.manufacture.RoomCritterBuildingView", package.seeall)

local var_0_0 = class("RoomCritterBuildingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._scrolltabbtn = gohelper.findChildScrollRect(arg_1_0.viewGO, "tabLayout/#scroll_tabbtn")
	arg_1_0._gotablayout = gohelper.findChild(arg_1_0.viewGO, "tabLayout")
	arg_1_0._gotabItem = gohelper.findChild(arg_1_0.viewGO, "tabLayout/#scroll_tabbtn/Viewport/Content/#go_tabItem")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "righttop")
	arg_1_0._btnrule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_BackBtns/#btn_rule")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrule:AddClickListener(arg_2_0._btnruleOnClick, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingHideView, arg_2_0.hideView, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingShowView, arg_2_0.showView, arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_2_0.hideView, arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_2_0.showView, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewRefreshCamera, arg_2_0.refreshCamera, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, arg_2_0._onChangeRestBuilding, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrule:RemoveClickListener()
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingHideView, arg_3_0.hideView, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingShowView, arg_3_0.showView, arg_3_0)
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_3_0.hideView, arg_3_0)
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_3_0.showView, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingViewRefreshCamera, arg_3_0.refreshCamera, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, arg_3_0._onChangeRestBuilding, arg_3_0)
end

function var_0_0._btnruleOnClick(arg_4_0)
	if arg_4_0._helpCallback then
		arg_4_0._helpCallback()
	end
end

function var_0_0._btnTabOnClick(arg_5_0, arg_5_1)
	if not arg_5_0.viewContainer:checkTabId(arg_5_1) then
		logError(string.format("RoomCritterBuildingView._btnTabOnClick error, no subview, tabId:%s", arg_5_1))

		return
	end

	if arg_5_0._curSelectTab == arg_5_1 then
		return
	end

	arg_5_0.viewContainer:switchTab(arg_5_1)

	arg_5_0._curSelectTab = arg_5_1

	arg_5_0:refreshTab()
	arg_5_0:refreshCamera()
	arg_5_0:refreshSeatSlotIcon()

	if arg_5_1 == RoomCritterBuildingViewContainer.SubViewTabId.Training and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainHas, 0) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoomCritterTrainHas
		})
	end
end

function var_0_0.hideView(arg_6_0, arg_6_1, arg_6_2)
	gohelper.setActive(arg_6_0._goBackBtns, arg_6_1)
	arg_6_0._animator:Play(UIAnimationName.Close, 0, 0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, arg_6_2)
end

function var_0_0.showView(arg_7_0)
	arg_7_0:refreshSeatSlotIcon()
	arg_7_0._animator:Play(UIAnimationName.Open, 0, 0)
	gohelper.setActive(arg_7_0._goBackBtns, true)
end

function var_0_0._onChangeRestBuilding(arg_8_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		return
	end

	gohelper.setActive(arg_8_0._goBackBtns, false)
	arg_8_0._animator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.cancelTask(arg_8_0._changeFinish, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._changeFinish, arg_8_0, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function var_0_0._changeFinish(arg_9_0)
	arg_9_0._animator:Play(UIAnimationName.Open, 0, 0)
	gohelper.setActive(arg_9_0._goBackBtns, true)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._animator = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._scene = RoomCameraController.instance:getRoomScene()

	gohelper.setActive(arg_10_0._gotabItem, false)

	arg_10_0._tabDict = {}
end

function var_0_0.onUpdateParam(arg_11_0)
	if not arg_11_0.viewParam then
		return
	end

	arg_11_0._curSelectTab = arg_11_0.viewContainer:getDefaultSelectedTab()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_12_0._tradeLevelUp, arg_12_0)
	arg_12_0:onUpdateParam()
	arg_12_0:setTabItem()
	arg_12_0:refreshTab()
	arg_12_0:refreshSeatSlotIcon()

	if not GuideModel.instance:isGuideFinish(RoomTradeEnum.GuideUnlock.Summon) then
		arg_12_0:addEventCb(GuideController.instance, GuideEvent.FinishStep, arg_12_0._onFinishSetep, arg_12_0)
		arg_12_0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.Summon, false)
	end

	local var_12_0, var_12_1 = arg_12_0:_isOpenIncubate()

	if not var_12_0 or var_12_1 then
		arg_12_0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.IncubatebId, false)
	end

	if var_12_1 then
		TaskDispatcher.runDelay(arg_12_0._tradeLevelUp, arg_12_0, 2)
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.SetBuildingColliderEnable, false)
end

function var_0_0.setTabItem(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(RoomCritterBuildingViewContainer.TabSettingList) do
		if not arg_13_0._tabDict[iter_13_0] then
			local var_13_0 = gohelper.cloneInPlace(arg_13_0._gotabItem, iter_13_0)

			if not gohelper.isNil(var_13_0) then
				local var_13_1 = arg_13_0:getUserDataTb_()

				var_13_1.go = var_13_0
				var_13_1.goselect = gohelper.findChild(var_13_0, "select")
				var_13_1.gonormal = gohelper.findChild(var_13_0, "normal")
				var_13_1.selecticon = gohelper.findChildImage(var_13_0, "select/#image_icon")
				var_13_1.normalicon = gohelper.findChildImage(var_13_0, "normal/#image_icon")
				var_13_1.btn = gohelper.findChildButtonWithAudio(var_13_0, "#btn_click")
				var_13_1.goreddot = gohelper.findChild(var_13_0, "#go_reddot")

				var_13_1.btn:AddClickListener(arg_13_0._btnTabOnClick, arg_13_0, iter_13_0)

				if iter_13_1.openBtnCallBack then
					gohelper.setActive(var_13_0, iter_13_1.openBtnCallBack())
				else
					gohelper.setActive(var_13_0, true)
				end

				UISpriteSetMgr.instance:setCritterSprite(var_13_1.selecticon, iter_13_1.icon)
				UISpriteSetMgr.instance:setCritterSprite(var_13_1.normalicon, iter_13_1.icon)

				arg_13_0._tabDict[iter_13_0] = var_13_1
			end
		end
	end

	local var_13_2 = arg_13_0._tabDict[RoomCritterBuildingViewContainer.SubViewTabId.Training]

	if var_13_2 then
		RedDotController.instance:addRedDot(var_13_2.goreddot, RedDotEnum.DotNode.RoomCritterTrainTab)
	end
end

function var_0_0.refreshTab(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._tabDict) do
		local var_14_0 = iter_14_0 == arg_14_0._curSelectTab

		gohelper.setActive(iter_14_1.goselect, var_14_0)
		gohelper.setActive(iter_14_1.gonormal, not var_14_0)
	end

	arg_14_0._helpCallback = RoomCritterBuildingViewContainer.TabSettingList[arg_14_0._curSelectTab].helpBtnCallBack

	gohelper.setActive(arg_14_0._btnrule.gameObject, arg_14_0._helpCallback ~= nil)
end

function var_0_0._setOpenByTabId(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0._tabDict[arg_15_1]

	if var_15_0 then
		gohelper.setActive(var_15_0.go, arg_15_2)

		if arg_15_2 and arg_15_3 then
			if not var_15_0.animator then
				var_15_0.animator = var_15_0.go:GetComponent(RoomEnum.ComponentType.Animator)
			end

			if var_15_0.animator then
				var_15_0.animator:Play(RoomTradeEnum.TradeAnim.Unlock, 0, 0)
			end
		end
	end

	return true
end

function var_0_0._tradeLevelUp(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0:_isOpenIncubate()

	if var_16_0 and var_16_1 then
		var_16_1 = true

		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockCritterIncubate, 1)
	end

	arg_16_0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.IncubatebId, var_16_0, var_16_1)
end

function var_0_0._isOpenIncubate(arg_17_0)
	local var_17_0 = ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.CritterIncubate)
	local var_17_1 = false

	if var_17_0 and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockCritterIncubate) ~= 1 then
		var_17_1 = true
	end

	return var_17_0, var_17_1
end

function var_0_0._onFinishSetep(arg_18_0, arg_18_1, arg_18_2)
	if RoomTradeEnum.GuideUnlock.Summon == arg_18_1 and arg_18_2 == 4 then
		arg_18_0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.Summon, true, true)
	end
end

function var_0_0.refreshCamera(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:getViewBuilding()

	if not var_19_1 then
		return
	end

	local var_19_2 = var_19_1.buildingId
	local var_19_3 = ManufactureConfig.instance:getBuildingCameraIdByIndex(var_19_2, arg_19_0._curSelectTab)

	if RoomCameraController.instance:getRoomCamera() and var_19_3 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(var_19_0, var_19_3, arg_19_0._cameraTweenFinish, arg_19_0)
	end
end

function var_0_0._cameraTweenFinish(arg_20_0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingCameraTweenFinish, arg_20_0._curSelectTab)
end

function var_0_0.refreshSeatSlotIcon(arg_21_0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, arg_21_0._curSelectTab == RoomCritterBuildingViewContainer.SubViewTabId.Rest)
end

function var_0_0.getViewBuilding(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0.viewContainer:getContainerViewBuilding(true)

	return var_22_0, var_22_1
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._changeFinish, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._tradeLevelUp, arg_23_0)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.SetBuildingColliderEnable, true)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, false)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChange)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, 0, false)
end

function var_0_0.onDestroyView(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._tabDict) do
		iter_24_1.btn:RemoveClickListener()
	end
end

return var_0_0
