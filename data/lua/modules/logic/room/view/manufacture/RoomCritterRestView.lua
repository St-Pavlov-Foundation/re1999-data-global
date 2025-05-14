module("modules.logic.room.view.manufacture.RoomCritterRestView", package.seeall)

local var_0_0 = class("RoomCritterRestView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "content")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/leftbtn/#btn_overview")
	arg_1_0._goOverviewReddot = gohelper.findChild(arg_1_0.viewGO, "content/leftbtn/#btn_overview/#go_reddot")
	arg_1_0._btnwarehouse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/leftbtn/#btn_warehouse")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/rightbtn/#btn_hide")
	arg_1_0._btnseat = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/rightbtn/#btn_seat")
	arg_1_0._btnreplaceAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/quickbtn/#btn_replaceAll")
	arg_1_0._btnunloadAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/quickbtn/#btn_unloadAll")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_arrow/#btn_left")
	arg_1_0._txtleftIndex = gohelper.findChildText(arg_1_0.viewGO, "#go_arrow/#btn_left/#txt_leftIndex")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_arrow/#btn_right")
	arg_1_0._goselectedArrow = gohelper.findChild(arg_1_0.viewGO, "content/#go_select")
	arg_1_0._goselectedMood = gohelper.findChild(arg_1_0.viewGO, "content/#go_select/mood")
	arg_1_0._txtrightIndex = gohelper.findChildText(arg_1_0.viewGO, "#go_arrow/#btn_right/#txt_rightIndex")
	arg_1_0._contentAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "content", typeof(UnityEngine.Animator))
	arg_1_0._txttopName = gohelper.findChildText(arg_1_0.viewGO, "content/top/tips/#txt_name")
	arg_1_0._gotopmood = gohelper.findChild(arg_1_0.viewGO, "content/top/tips/#txt_name/mood")
	arg_1_0._gotopcrittericon = gohelper.findChild(arg_1_0.viewGO, "content/top/tips/#txt_name/crittericon")
	arg_1_0._goseatSlotBtnRoot = gohelper.findChild(arg_1_0.viewGO, "#go_seatSlotBtns")
	arg_1_0._transseatSlotBtnRoot = arg_1_0._goseatSlotBtnRoot.transform
	arg_1_0._goseatSlotBtn = gohelper.findChild(arg_1_0.viewGO, "#go_seatSlotBtns/#btn_seatSlot")
	arg_1_0._btnShowView = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_show")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._btnoverviewOnClick, arg_2_0)
	arg_2_0._btnwarehouse:AddClickListener(arg_2_0._btnwarehouseOnClick, arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
	arg_2_0._btnseat:AddClickListener(arg_2_0._btnseatOnClick, arg_2_0)
	arg_2_0._btnreplaceAll:AddClickListener(arg_2_0._btnreplaceAllOnClick, arg_2_0)
	arg_2_0._btnunloadAll:AddClickListener(arg_2_0._btnunloadAllOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnShowView:AddClickListener(arg_2_0._btnShowViewOnClick, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSelectCritter, arg_2_0.refreshSelectCritter, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, arg_2_0._canOperateCritter, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, arg_2_0.refreshSeatSlotBtns, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_2_0._checkSelectedCritter, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, arg_2_0._checkSelectedCritter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0._btnwarehouse:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnseat:RemoveClickListener()
	arg_3_0._btnreplaceAll:RemoveClickListener()
	arg_3_0._btnunloadAll:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnShowView:RemoveClickListener()

	if arg_3_0._seatSlotBtnDict then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._seatSlotBtnDict) do
			iter_3_1.click:RemoveClickListener()
			iter_3_1.drag:RemoveDragBeginListener()
			iter_3_1.drag:RemoveDragListener()
			iter_3_1.drag:RemoveDragEndListener()
		end
	end

	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingSelectCritter, arg_3_0.refreshSelectCritter, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, arg_3_0._canOperateCritter, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, arg_3_0.refreshSeatSlotBtns, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_3_0._checkSelectedCritter, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, arg_3_0._checkSelectedCritter, arg_3_0)
end

function var_0_0._btnreplaceAllOnClick(arg_4_0)
	local var_4_0 = arg_4_0:getViewBuilding()

	if var_4_0 then
		RoomRpc.instance:sendReplaceRestBuildingCrittersRequest(var_4_0)
	end
end

function var_0_0._btnunloadAllOnClick(arg_5_0)
	local var_5_0 = arg_5_0:getViewBuilding()

	if var_5_0 then
		RoomRpc.instance:sendUnloadRestBuildingCrittersRequest(var_5_0)
	end
end

function var_0_0._btnoverviewOnClick(arg_6_0)
	ManufactureController.instance:openOverView(true)
end

function var_0_0._btnwarehouseOnClick(arg_7_0)
	ManufactureController.instance:openRoomBackpackView()
end

function var_0_0._btnhideOnClick(arg_8_0)
	CritterController.instance:clearSelectedCritterSeatSlot()
	arg_8_0:playAnim(UIAnimationName.Close)
	gohelper.setActive(arg_8_0._goShowViewBtn, true)
	arg_8_0:_canOperateCritter(false)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
end

function var_0_0._btnseatOnClick(arg_9_0)
	arg_9_0:playAnim("hide")

	local var_9_0 = arg_9_0:getViewBuilding()

	ManufactureController.instance:openCritterPlaceView(var_9_0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView, true, true)
end

function var_0_0._btnleftOnClick(arg_10_0)
	local var_10_0
	local var_10_1 = arg_10_0.index <= 1
	local var_10_2 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if not var_10_1 and var_10_2 then
		var_10_0 = var_10_2[arg_10_0.index - 1].buildingUid

		arg_10_0.viewContainer:setContainerViewBuildingUid(var_10_0)
		CritterController.instance:clearSelectedCritterSeatSlot()
	end

	arg_10_0:updateBuildingIndex()
	arg_10_0:refreshCamera(arg_10_0.refreshSeatSlotBtns, arg_10_0)
	arg_10_0:_playSwitchBuildingAnim()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChangeBuilding, var_10_0)
end

function var_0_0._btnrightOnClick(arg_11_0)
	local var_11_0
	local var_11_1 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if var_11_1 and arg_11_0.index < #var_11_1 then
		var_11_0 = var_11_1[arg_11_0.index + 1].buildingUid

		arg_11_0.viewContainer:setContainerViewBuildingUid(var_11_0)
		CritterController.instance:clearSelectedCritterSeatSlot()
	end

	arg_11_0:updateBuildingIndex()
	arg_11_0:refreshCamera(arg_11_0.refreshSeatSlotBtns, arg_11_0)
	arg_11_0:_playSwitchBuildingAnim()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChangeBuilding, var_11_0)
end

function var_0_0._playSwitchBuildingAnim(arg_12_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		arg_12_0:refreshArrow()

		return
	end

	arg_12_0:playAnim(UIAnimationName.Close)
	TaskDispatcher.cancelTask(arg_12_0._switchFinish, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._switchFinish, arg_12_0, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function var_0_0._switchFinish(arg_13_0)
	arg_13_0:refreshArrow()
	arg_13_0:playAnim(UIAnimationName.Open)
end

function var_0_0._btnShowViewOnClick(arg_14_0)
	arg_14_0:playAnim(UIAnimationName.Open)
	gohelper.setActive(arg_14_0._goShowViewBtn, false)
	arg_14_0:_canOperateCritter(true)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
end

function var_0_0._onClickSeatSlot(arg_15_0, arg_15_1)
	if arg_15_0._dragCritterEntity then
		return
	end

	local var_15_0, var_15_1 = arg_15_0:getViewBuilding()

	if not var_15_0 or not var_15_1 then
		return
	end

	local var_15_2 = ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView)
	local var_15_3 = true
	local var_15_4 = var_15_1:getRestingCritter(arg_15_1)

	if var_15_4 and (not var_15_2 or var_15_3) then
		CritterController.instance:clickCritterInCritterBuilding(var_15_0, var_15_4)
	elseif var_15_1:getSeatSlotMO(arg_15_1) then
		if not var_15_2 then
			arg_15_0:_btnseatOnClick()
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		end
	else
		ViewMgr.instance:openView(ViewName.RoomCritterRestTipsView, {
			buildingUid = var_15_0,
			seatSlotId = arg_15_1
		})
	end
end

function var_0_0._onDragBegin(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._dragCritterEntity or not arg_16_0._scene then
		return
	end

	local var_16_0, var_16_1 = arg_16_0:getViewBuilding()
	local var_16_2 = var_16_1 and var_16_1:getRestingCritter(arg_16_1)
	local var_16_3 = arg_16_0._scene.buildingcrittermgr:getCritterEntity(var_16_2)

	if not var_16_3 then
		return
	end

	local var_16_4 = arg_16_0._scene.buildingmgr:getBuildingEntity(var_16_0, SceneTag.RoomBuilding)
	local var_16_5 = var_16_4 and var_16_4:getCritterPoint(arg_16_1)

	if gohelper.isNil(var_16_5) then
		logError(string.format("RoomCritterRestView:_onDragBegin error, no critter point, buildingUid:%s,index:%s", var_16_0, arg_16_1 + 1))

		return
	end

	CritterController.instance:clearSelectedCritterSeatSlot()

	arg_16_0._critterPointPos = var_16_5.transform.position
	arg_16_0._dragCritterEntity = var_16_3

	arg_16_0._dragCritterEntity:tweenUp()
end

local var_0_1 = 0.02

function var_0_0._onDragIng(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._dragCritterEntity then
		return
	end

	local var_17_0 = arg_17_2.position
	local var_17_1 = RoomBendingHelper.screenPosToRay(var_17_0)
	local var_17_2, var_17_3 = UnityEngine.Physics.Raycast(var_17_1.origin, var_17_1.direction, nil, 10, LayerMask.GetMask("UI3D"))

	if not var_17_2 then
		return
	end

	local var_17_4 = var_17_3.point.x
	local var_17_5 = var_17_3.point.y + var_0_1
	local var_17_6 = var_17_3.point.z

	arg_17_0._dragCritterEntity:setLocalPos(var_17_4, var_17_5, var_17_6)
	arg_17_0.viewContainer:dispatchEvent(CritterEvent.UICritterDragIng)
end

function var_0_0._onDragEnd(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._dragCritterEntity then
		return
	end

	local var_18_0 = arg_18_2.position
	local var_18_1, var_18_2 = recthelper.screenPosToAnchorPos2(var_18_0, arg_18_0._transseatSlotBtnRoot)
	local var_18_3

	if arg_18_0._seatSlotBtnDict then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._seatSlotBtnDict) do
			local var_18_4, var_18_5 = recthelper.getAnchor(iter_18_1.trans)
			local var_18_6 = recthelper.getWidth(iter_18_1.trans) / 2
			local var_18_7 = recthelper.getHeight(iter_18_1.trans)

			if var_18_1 >= var_18_4 - var_18_6 and var_18_1 <= var_18_4 + var_18_6 and var_18_5 <= var_18_2 and var_18_2 <= var_18_5 + var_18_7 then
				var_18_3 = iter_18_0
			end
		end
	end

	if var_18_3 then
		local var_18_8 = arg_18_0:getViewBuilding()

		CritterController.instance:exchangeSeatSlot(var_18_8, arg_18_1, var_18_3)
	else
		arg_18_0._scene.buildingcrittermgr:refreshAllCritterEntityPos()
	end

	arg_18_0._dragCritterEntity:tweenDown()

	arg_18_0._dragCritterEntity = nil
	arg_18_0._critterPointPos = nil

	arg_18_0.viewContainer:dispatchEvent(CritterEvent.UICritterDragEnd)
end

function var_0_0._canOperateCritter(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goseatSlotBtnRoot, arg_19_1)
	gohelper.setActive(arg_19_0._goarrow, arg_19_1)
end

function var_0_0._onCloseView(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.RoomCritterPlaceView then
		arg_20_0:playAnim(UIAnimationName.Open)
		arg_20_0:_canOperateCritter(true)
		arg_20_0:_checkQuickbtnActive()
	end
end

function var_0_0._onOpenView(arg_21_0, arg_21_1)
	arg_21_0:_checkQuickbtnActive()
end

function var_0_0._checkSelectedCritter(arg_22_0)
	local var_22_0
	local var_22_1, var_22_2 = arg_22_0:getViewBuilding()
	local var_22_3, var_22_4 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if var_22_3 == var_22_1 then
		var_22_0 = var_22_2:getRestingCritter(var_22_4)
	end

	if not var_22_0 then
		CritterController.instance:clearSelectedCritterSeatSlot()
	end
end

function var_0_0._editableInitView(arg_23_0)
	arg_23_0._goquickbtn = gohelper.findChild(arg_23_0.viewGO, "content/quickbtn")
	arg_23_0._transcontent = arg_23_0._gocontent.transform
	arg_23_0._transselectedArrow = arg_23_0._goselectedArrow.transform
	arg_23_0._gobtnLeft = arg_23_0._btnleft.gameObject
	arg_23_0._gobtnright = arg_23_0._btnright.gameObject
	arg_23_0._goShowViewBtn = arg_23_0._btnShowView.gameObject
	arg_23_0._scene = RoomCameraController.instance:getRoomScene()

	arg_23_0:initSeatSlotBtns()
	arg_23_0:refreshSeatSlotBtns()

	arg_23_0._topMoodItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_23_0._gotopmood, CritterMoodItem)
	arg_23_0._selectMoodItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_23_0._goselectedMood, CritterMoodItem)
	arg_23_0._topCritterIcon = IconMgr.instance:getCommonCritterIcon(arg_23_0._gotopcrittericon)

	arg_23_0._selectMoodItem:setShowMoodRestore(false)
end

function var_0_0.initSeatSlotBtns(arg_24_0)
	local var_24_0 = {}

	for iter_24_0 = 1, CritterEnum.CritterMaxSeatCount do
		var_24_0[iter_24_0] = iter_24_0 - 1
	end

	arg_24_0._seatSlotBtnDict = {}

	gohelper.CreateObjList(arg_24_0, arg_24_0.onSetSeatSlotBtn, var_24_0, arg_24_0._goseatSlotBtnRoot, arg_24_0._goseatSlotBtn)
end

function var_0_0.onSetSeatSlotBtn(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.go = arg_25_1
	var_25_0.trans = arg_25_1.transform
	var_25_0.seatSlotId = arg_25_2
	var_25_0.click = SLFramework.UGUI.UIClickListener.Get(var_25_0.go)

	var_25_0.click:AddClickListener(arg_25_0._onClickSeatSlot, arg_25_0, arg_25_2)

	var_25_0.drag = SLFramework.UGUI.UIDragListener.Get(var_25_0.go)

	var_25_0.drag:AddDragBeginListener(arg_25_0._onDragBegin, arg_25_0, arg_25_2)
	var_25_0.drag:AddDragListener(arg_25_0._onDragIng, arg_25_0, arg_25_2)
	var_25_0.drag:AddDragEndListener(arg_25_0._onDragEnd, arg_25_0, arg_25_2)

	arg_25_0._seatSlotBtnDict[arg_25_2] = var_25_0
end

function var_0_0.onUpdateParam(arg_26_0)
	return
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0:updateBuildingIndex()
	arg_27_0:refresh(true)
	gohelper.setActive(arg_27_0._goShowViewBtn, false)
	RedDotController.instance:addRedDot(arg_27_0._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	arg_27_0:_checkQuickbtnActive()
end

function var_0_0._checkQuickbtnActive(arg_28_0)
	gohelper.setActive(arg_28_0._goquickbtn, ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView))
end

function var_0_0.refresh(arg_29_0, arg_29_1)
	arg_29_0:refreshArrow()
	arg_29_0:refreshSelectCritter(arg_29_1)
end

function var_0_0.refreshArrow(arg_30_0)
	local var_30_0 = arg_30_0.index <= 1

	if not var_30_0 then
		local var_30_1 = arg_30_0.index - 1

		arg_30_0._txtleftIndex.text = var_30_1
	end

	gohelper.setActive(arg_30_0._gobtnLeft, not var_30_0)

	local var_30_2 = true
	local var_30_3 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if var_30_3 then
		var_30_2 = arg_30_0.index >= #var_30_3
	end

	if not var_30_2 then
		local var_30_4 = arg_30_0.index + 1

		arg_30_0._txtrightIndex.text = var_30_4
	end

	gohelper.setActive(arg_30_0._gobtnright, not var_30_2)
end

function var_0_0.refreshCamera(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0, var_31_1 = arg_31_0:getViewBuilding()

	if not var_31_1 then
		return
	end

	local var_31_2 = var_31_1.buildingId
	local var_31_3 = ManufactureConfig.instance:getBuildingCameraIdByIndex(var_31_2)

	if RoomCameraController.instance:getRoomCamera() and var_31_3 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(var_31_0, var_31_3, arg_31_1, arg_31_2)
	end
end

function var_0_0.refreshSelectCritter(arg_32_0, arg_32_1)
	local var_32_0, var_32_1 = arg_32_0:getViewBuilding()
	local var_32_2
	local var_32_3, var_32_4 = ManufactureModel.instance:getSelectedCritterSeatSlot()
	local var_32_5 = var_32_1:getRestingCritter(var_32_4)

	if var_32_3 == var_32_0 then
		var_32_2 = CritterModel.instance:getCritterMOByUid(var_32_5)
	end

	if var_32_2 then
		local var_32_6 = var_32_2:getDefineId()

		arg_32_0._txttopName.text = var_32_2:getName()

		arg_32_0._topCritterIcon:onUpdateMO(var_32_2)
		arg_32_0._topMoodItem:setCritterUid(var_32_5)
		arg_32_0._selectMoodItem:setCritterUid(var_32_5)
		arg_32_0:refreshSelectArrow(var_32_4)
		arg_32_0:refreshCritterFood(var_32_6)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_value)
	end

	gohelper.setActive(arg_32_0._gotop, var_32_2)

	if arg_32_1 then
		arg_32_0._contentAnimator:Play(UIAnimationName.Close, 0, 1)
	else
		arg_32_0._contentAnimator:Play(var_32_2 and UIAnimationName.Open or UIAnimationName.Close)

		if var_32_2 and not ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
			arg_32_0:_btnseatOnClick()
		end
	end
end

function var_0_0.refreshSelectArrow(arg_33_0, arg_33_1)
	local var_33_0, var_33_1 = arg_33_0:getViewBuilding()

	if not arg_33_0._scene or not var_33_1 then
		return
	end

	local var_33_2 = var_33_1:getRestingCritter(arg_33_1)
	local var_33_3 = arg_33_0._scene.buildingcrittermgr:getCritterEntity(var_33_2)
	local var_33_4 = var_33_3 and var_33_3.critterspine:getMountheadGOTrs()

	if gohelper.isNil(var_33_4) then
		return
	end

	local var_33_5 = var_33_4.position
	local var_33_6 = RoomBendingHelper.worldToBendingSimple(var_33_5)
	local var_33_7 = RoomBendingHelper.worldPosToAnchorPos(var_33_6, arg_33_0._transcontent)

	if var_33_7 then
		recthelper.setAnchor(arg_33_0._transselectedArrow, var_33_7.x, var_33_7.y)
	end
end

function var_0_0.refreshCritterFood(arg_34_0, arg_34_1)
	RoomCritterFoodListModel.instance:setCritterFoodList(arg_34_1)
end

local var_0_2 = -15

function var_0_0.refreshSeatSlotBtns(arg_35_0)
	if not arg_35_0._seatSlotBtnDict or not arg_35_0._scene then
		return
	end

	local var_35_0 = arg_35_0:getViewBuilding()
	local var_35_1 = arg_35_0._scene.buildingmgr:getBuildingEntity(var_35_0, SceneTag.RoomBuilding)

	for iter_35_0, iter_35_1 in pairs(arg_35_0._seatSlotBtnDict) do
		local var_35_2 = var_35_1 and var_35_1:getCritterPoint(iter_35_0)

		if not gohelper.isNil(var_35_2) then
			local var_35_3 = var_35_2.transform.position
			local var_35_4 = RoomBendingHelper.worldToBendingSimple(var_35_3)
			local var_35_5 = RoomBendingHelper.worldPosToAnchorPos(var_35_4, arg_35_0._transseatSlotBtnRoot)

			if var_35_5 then
				recthelper.setAnchor(iter_35_1.trans, var_35_5.x, var_35_5.y + var_0_2)
			end
		else
			logError(string.format("RoomCritterRestView:refreshSeatSlotBtns error, no critter point, buildingUid:%s, index:%s", var_35_0, iter_35_0 + 1))
		end
	end
end

function var_0_0.updateBuildingIndex(arg_36_0)
	arg_36_0.index = 0

	local var_36_0 = ManufactureModel.instance:getCritterBuildingListInOrder()
	local var_36_1 = arg_36_0:getViewBuilding()

	if not var_36_0 then
		return
	end

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if var_36_1 == iter_36_1.buildingUid then
			arg_36_0.index = iter_36_0
		end
	end
end

function var_0_0.playAnim(arg_37_0, arg_37_1)
	arg_37_0._animator.enabled = true

	arg_37_0._animator:Play(arg_37_1, 0, 0)
end

function var_0_0.getViewBuilding(arg_38_0)
	local var_38_0, var_38_1 = arg_38_0.viewContainer:getContainerViewBuilding()

	return var_38_0, var_38_1
end

function var_0_0.onClose(arg_39_0)
	if arg_39_0._dragCritterEntity then
		arg_39_0._scene.buildingcrittermgr:refreshAllCritterEntityPos()
		arg_39_0._dragCritterEntity:tweenDown()

		arg_39_0._dragCritterEntity = nil
		arg_39_0._critterPointPos = nil
	end

	CritterController.instance:clearSelectedCritterSeatSlot()
	TaskDispatcher.cancelTask(arg_39_0._switchFinish, arg_39_0)
end

function var_0_0.onDestroyView(arg_40_0)
	return
end

return var_0_0
