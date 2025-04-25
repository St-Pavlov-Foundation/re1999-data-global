module("modules.logic.room.view.manufacture.RoomCritterRestView", package.seeall)

slot0 = class("RoomCritterRestView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "content")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/leftbtn/#btn_overview")
	slot0._goOverviewReddot = gohelper.findChild(slot0.viewGO, "content/leftbtn/#btn_overview/#go_reddot")
	slot0._btnwarehouse = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/leftbtn/#btn_warehouse")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/rightbtn/#btn_hide")
	slot0._btnseat = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/rightbtn/#btn_seat")
	slot0._btnreplaceAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/quickbtn/#btn_replaceAll")
	slot0._btnunloadAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/quickbtn/#btn_unloadAll")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_arrow/#btn_left")
	slot0._txtleftIndex = gohelper.findChildText(slot0.viewGO, "#go_arrow/#btn_left/#txt_leftIndex")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_arrow/#btn_right")
	slot0._goselectedArrow = gohelper.findChild(slot0.viewGO, "content/#go_select")
	slot0._goselectedMood = gohelper.findChild(slot0.viewGO, "content/#go_select/mood")
	slot0._txtrightIndex = gohelper.findChildText(slot0.viewGO, "#go_arrow/#btn_right/#txt_rightIndex")
	slot0._contentAnimator = gohelper.findChildComponent(slot0.viewGO, "content", typeof(UnityEngine.Animator))
	slot0._txttopName = gohelper.findChildText(slot0.viewGO, "content/top/tips/#txt_name")
	slot0._gotopmood = gohelper.findChild(slot0.viewGO, "content/top/tips/#txt_name/mood")
	slot0._gotopcrittericon = gohelper.findChild(slot0.viewGO, "content/top/tips/#txt_name/crittericon")
	slot0._goseatSlotBtnRoot = gohelper.findChild(slot0.viewGO, "#go_seatSlotBtns")
	slot0._transseatSlotBtnRoot = slot0._goseatSlotBtnRoot.transform
	slot0._goseatSlotBtn = gohelper.findChild(slot0.viewGO, "#go_seatSlotBtns/#btn_seatSlot")
	slot0._btnShowView = gohelper.findChildClickWithAudio(slot0.viewGO, "#btn_show")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoverview:AddClickListener(slot0._btnoverviewOnClick, slot0)
	slot0._btnwarehouse:AddClickListener(slot0._btnwarehouseOnClick, slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
	slot0._btnseat:AddClickListener(slot0._btnseatOnClick, slot0)
	slot0._btnreplaceAll:AddClickListener(slot0._btnreplaceAllOnClick, slot0)
	slot0._btnunloadAll:AddClickListener(slot0._btnunloadAllOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnShowView:AddClickListener(slot0._btnShowViewOnClick, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSelectCritter, slot0.refreshSelectCritter, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, slot0._canOperateCritter, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, slot0.refreshSeatSlotBtns, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._checkSelectedCritter, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, slot0._checkSelectedCritter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoverview:RemoveClickListener()
	slot0._btnwarehouse:RemoveClickListener()
	slot0._btnhide:RemoveClickListener()
	slot0._btnseat:RemoveClickListener()
	slot0._btnreplaceAll:RemoveClickListener()
	slot0._btnunloadAll:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnShowView:RemoveClickListener()

	if slot0._seatSlotBtnDict then
		for slot4, slot5 in pairs(slot0._seatSlotBtnDict) do
			slot5.click:RemoveClickListener()
			slot5.drag:RemoveDragBeginListener()
			slot5.drag:RemoveDragListener()
			slot5.drag:RemoveDragEndListener()
		end
	end

	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingSelectCritter, slot0.refreshSelectCritter, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, slot0._canOperateCritter, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, slot0.refreshSeatSlotBtns, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._checkSelectedCritter, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, slot0._checkSelectedCritter, slot0)
end

function slot0._btnreplaceAllOnClick(slot0)
	if slot0:getViewBuilding() then
		RoomRpc.instance:sendReplaceRestBuildingCrittersRequest(slot1)
	end
end

function slot0._btnunloadAllOnClick(slot0)
	if slot0:getViewBuilding() then
		RoomRpc.instance:sendUnloadRestBuildingCrittersRequest(slot1)
	end
end

function slot0._btnoverviewOnClick(slot0)
	ManufactureController.instance:openOverView(true)
end

function slot0._btnwarehouseOnClick(slot0)
	ManufactureController.instance:openRoomBackpackView()
end

function slot0._btnhideOnClick(slot0)
	CritterController.instance:clearSelectedCritterSeatSlot()
	slot0:playAnim(UIAnimationName.Close)
	gohelper.setActive(slot0._goShowViewBtn, true)
	slot0:_canOperateCritter(false)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
end

function slot0._btnseatOnClick(slot0)
	slot0:playAnim("hide")
	ManufactureController.instance:openCritterPlaceView(slot0:getViewBuilding())
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView, true, true)
end

function slot0._btnleftOnClick(slot0)
	slot1 = nil
	slot3 = ManufactureModel.instance:getCritterBuildingListInOrder()

	if not (slot0.index <= 1) and slot3 then
		slot0.viewContainer:setContainerViewBuildingUid(slot3[slot0.index - 1].buildingUid)
		CritterController.instance:clearSelectedCritterSeatSlot()
	end

	slot0:updateBuildingIndex()
	slot0:refreshCamera(slot0.refreshSeatSlotBtns, slot0)
	slot0:_playSwitchBuildingAnim()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChangeBuilding, slot1)
end

function slot0._btnrightOnClick(slot0)
	slot1 = nil

	if ManufactureModel.instance:getCritterBuildingListInOrder() and slot0.index < #slot2 then
		slot0.viewContainer:setContainerViewBuildingUid(slot2[slot0.index + 1].buildingUid)
		CritterController.instance:clearSelectedCritterSeatSlot()
	end

	slot0:updateBuildingIndex()
	slot0:refreshCamera(slot0.refreshSeatSlotBtns, slot0)
	slot0:_playSwitchBuildingAnim()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChangeBuilding, slot1)
end

function slot0._playSwitchBuildingAnim(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		slot0:refreshArrow()

		return
	end

	slot0:playAnim(UIAnimationName.Close)
	TaskDispatcher.cancelTask(slot0._switchFinish, slot0)
	TaskDispatcher.runDelay(slot0._switchFinish, slot0, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function slot0._switchFinish(slot0)
	slot0:refreshArrow()
	slot0:playAnim(UIAnimationName.Open)
end

function slot0._btnShowViewOnClick(slot0)
	slot0:playAnim(UIAnimationName.Open)
	gohelper.setActive(slot0._goShowViewBtn, false)
	slot0:_canOperateCritter(true)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
end

function slot0._onClickSeatSlot(slot0, slot1)
	if slot0._dragCritterEntity then
		return
	end

	slot2, slot3 = slot0:getViewBuilding()

	if not slot2 or not slot3 then
		return
	end

	if slot3:getRestingCritter(slot1) and (not ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) or true) then
		CritterController.instance:clickCritterInCritterBuilding(slot2, slot6)
	elseif slot3:getSeatSlotMO(slot1) then
		if not slot4 then
			slot0:_btnseatOnClick()
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		end
	else
		ViewMgr.instance:openView(ViewName.RoomCritterRestTipsView, {
			buildingUid = slot2,
			seatSlotId = slot1
		})
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0._dragCritterEntity or not slot0._scene then
		return
	end

	slot3, slot4 = slot0:getViewBuilding()

	if not slot0._scene.buildingcrittermgr:getCritterEntity(slot4 and slot4:getRestingCritter(slot1)) then
		return
	end

	if gohelper.isNil(slot0._scene.buildingmgr:getBuildingEntity(slot3, SceneTag.RoomBuilding) and slot7:getCritterPoint(slot1)) then
		logError(string.format("RoomCritterRestView:_onDragBegin error, no critter point, buildingUid:%s,index:%s", slot3, slot1 + 1))

		return
	end

	CritterController.instance:clearSelectedCritterSeatSlot()

	slot0._critterPointPos = slot8.transform.position
	slot0._dragCritterEntity = slot6

	slot0._dragCritterEntity:tweenUp()
end

slot1 = 0.02

function slot0._onDragIng(slot0, slot1, slot2)
	if not slot0._dragCritterEntity then
		return
	end

	slot4 = RoomBendingHelper.screenPosToRay(slot2.position)
	slot5, slot6 = UnityEngine.Physics.Raycast(slot4.origin, slot4.direction, nil, 10, LayerMask.GetMask("UI3D"))

	if not slot5 then
		return
	end

	slot0._dragCritterEntity:setLocalPos(slot6.point.x, slot6.point.y + uv0, slot6.point.z)
	slot0.viewContainer:dispatchEvent(CritterEvent.UICritterDragIng)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0._dragCritterEntity then
		return
	end

	slot4, slot5 = recthelper.screenPosToAnchorPos2(slot2.position, slot0._transseatSlotBtnRoot)
	slot6 = nil

	if slot0._seatSlotBtnDict then
		for slot10, slot11 in pairs(slot0._seatSlotBtnDict) do
			slot12, slot13 = recthelper.getAnchor(slot11.trans)

			if slot4 >= slot12 - recthelper.getWidth(slot11.trans) / 2 and slot4 <= slot12 + slot14 and slot13 <= slot5 and slot5 <= slot13 + recthelper.getHeight(slot11.trans) then
				slot6 = slot10
			end
		end
	end

	if slot6 then
		CritterController.instance:exchangeSeatSlot(slot0:getViewBuilding(), slot1, slot6)
	else
		slot0._scene.buildingcrittermgr:refreshAllCritterEntityPos()
	end

	slot0._dragCritterEntity:tweenDown()

	slot0._dragCritterEntity = nil
	slot0._critterPointPos = nil

	slot0.viewContainer:dispatchEvent(CritterEvent.UICritterDragEnd)
end

function slot0._canOperateCritter(slot0, slot1)
	gohelper.setActive(slot0._goseatSlotBtnRoot, slot1)
	gohelper.setActive(slot0._goarrow, slot1)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.RoomCritterPlaceView then
		slot0:playAnim(UIAnimationName.Open)
		slot0:_canOperateCritter(true)
		slot0:_checkQuickbtnActive()
	end
end

function slot0._onOpenView(slot0, slot1)
	slot0:_checkQuickbtnActive()
end

function slot0._checkSelectedCritter(slot0)
	slot1 = nil
	slot2, slot3 = slot0:getViewBuilding()
	slot4, slot5 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if slot4 == slot2 then
		slot1 = slot3:getRestingCritter(slot5)
	end

	if not slot1 then
		CritterController.instance:clearSelectedCritterSeatSlot()
	end
end

function slot0._editableInitView(slot0)
	slot0._goquickbtn = gohelper.findChild(slot0.viewGO, "content/quickbtn")
	slot0._transcontent = slot0._gocontent.transform
	slot0._transselectedArrow = slot0._goselectedArrow.transform
	slot0._gobtnLeft = slot0._btnleft.gameObject
	slot0._gobtnright = slot0._btnright.gameObject
	slot0._goShowViewBtn = slot0._btnShowView.gameObject
	slot0._scene = RoomCameraController.instance:getRoomScene()

	slot0:initSeatSlotBtns()
	slot0:refreshSeatSlotBtns()

	slot0._topMoodItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gotopmood, CritterMoodItem)
	slot0._selectMoodItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goselectedMood, CritterMoodItem)
	slot0._topCritterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gotopcrittericon)

	slot0._selectMoodItem:setShowMoodRestore(false)
end

function slot0.initSeatSlotBtns(slot0)
	for slot5 = 1, CritterEnum.CritterMaxSeatCount do
	end

	slot0._seatSlotBtnDict = {}

	gohelper.CreateObjList(slot0, slot0.onSetSeatSlotBtn, {
		[slot5] = slot5 - 1
	}, slot0._goseatSlotBtnRoot, slot0._goseatSlotBtn)
end

function slot0.onSetSeatSlotBtn(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.trans = slot1.transform
	slot4.seatSlotId = slot2
	slot4.click = SLFramework.UGUI.UIClickListener.Get(slot4.go)

	slot4.click:AddClickListener(slot0._onClickSeatSlot, slot0, slot2)

	slot4.drag = SLFramework.UGUI.UIDragListener.Get(slot4.go)

	slot4.drag:AddDragBeginListener(slot0._onDragBegin, slot0, slot2)
	slot4.drag:AddDragListener(slot0._onDragIng, slot0, slot2)
	slot4.drag:AddDragEndListener(slot0._onDragEnd, slot0, slot2)

	slot0._seatSlotBtnDict[slot2] = slot4
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:updateBuildingIndex()
	slot0:refresh(true)
	gohelper.setActive(slot0._goShowViewBtn, false)
	RedDotController.instance:addRedDot(slot0._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	slot0:_checkQuickbtnActive()
end

function slot0._checkQuickbtnActive(slot0)
	gohelper.setActive(slot0._goquickbtn, ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView))
end

function slot0.refresh(slot0, slot1)
	slot0:refreshArrow()
	slot0:refreshSelectCritter(slot1)
end

function slot0.refreshArrow(slot0)
	if not (slot0.index <= 1) then
		slot0._txtleftIndex.text = slot0.index - 1
	end

	gohelper.setActive(slot0._gobtnLeft, not slot1)

	slot2 = true

	if ManufactureModel.instance:getCritterBuildingListInOrder() then
		slot2 = slot0.index >= #slot3
	end

	if not slot2 then
		slot0._txtrightIndex.text = slot0.index + 1
	end

	gohelper.setActive(slot0._gobtnright, not slot2)
end

function slot0.refreshCamera(slot0, slot1, slot2)
	slot3, slot4 = slot0:getViewBuilding()

	if not slot4 then
		return
	end

	slot6 = ManufactureConfig.instance:getBuildingCameraIdByIndex(slot4.buildingId)

	if RoomCameraController.instance:getRoomCamera() and slot6 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot3, slot6, slot1, slot2)
	end
end

function slot0.refreshSelectCritter(slot0, slot1)
	slot2, slot3 = slot0:getViewBuilding()
	slot4 = nil
	slot5, slot6 = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if slot5 == slot2 then
		slot4 = CritterModel.instance:getCritterMOByUid(slot3:getRestingCritter(slot6))
	end

	if slot4 then
		slot0._txttopName.text = slot4:getName()

		slot0._topCritterIcon:onUpdateMO(slot4)
		slot0._topMoodItem:setCritterUid(slot7)
		slot0._selectMoodItem:setCritterUid(slot7)
		slot0:refreshSelectArrow(slot6)
		slot0:refreshCritterFood(slot4:getDefineId())
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_value)
	end

	gohelper.setActive(slot0._gotop, slot4)

	if slot1 then
		slot0._contentAnimator:Play(UIAnimationName.Close, 0, 1)
	else
		slot0._contentAnimator:Play(slot4 and UIAnimationName.Open or UIAnimationName.Close)

		if slot4 and not ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
			slot0:_btnseatOnClick()
		end
	end
end

function slot0.refreshSelectArrow(slot0, slot1)
	slot2, slot3 = slot0:getViewBuilding()

	if not slot0._scene or not slot3 then
		return
	end

	if gohelper.isNil(slot0._scene.buildingcrittermgr:getCritterEntity(slot3:getRestingCritter(slot1)) and slot5.critterspine:getMountheadGOTrs()) then
		return
	end

	if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(slot6.position), slot0._transcontent) then
		recthelper.setAnchor(slot0._transselectedArrow, slot9.x, slot9.y)
	end
end

function slot0.refreshCritterFood(slot0, slot1)
	RoomCritterFoodListModel.instance:setCritterFoodList(slot1)
end

slot2 = -15

function slot0.refreshSeatSlotBtns(slot0)
	if not slot0._seatSlotBtnDict or not slot0._scene then
		return
	end

	slot2 = slot0._scene.buildingmgr:getBuildingEntity(slot0:getViewBuilding(), SceneTag.RoomBuilding)

	for slot6, slot7 in pairs(slot0._seatSlotBtnDict) do
		if not gohelper.isNil(slot2 and slot2:getCritterPoint(slot6)) then
			if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(slot8.transform.position), slot0._transseatSlotBtnRoot) then
				recthelper.setAnchor(slot7.trans, slot11.x, slot11.y + uv0)
			end
		else
			logError(string.format("RoomCritterRestView:refreshSeatSlotBtns error, no critter point, buildingUid:%s, index:%s", slot1, slot6 + 1))
		end
	end
end

function slot0.updateBuildingIndex(slot0)
	slot0.index = 0
	slot2 = slot0:getViewBuilding()

	if not ManufactureModel.instance:getCritterBuildingListInOrder() then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot2 == slot7.buildingUid then
			slot0.index = slot6
		end
	end
end

function slot0.playAnim(slot0, slot1)
	slot0._animator.enabled = true

	slot0._animator:Play(slot1, 0, 0)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = slot0.viewContainer:getContainerViewBuilding()

	return slot1, slot2
end

function slot0.onClose(slot0)
	if slot0._dragCritterEntity then
		slot0._scene.buildingcrittermgr:refreshAllCritterEntityPos()
		slot0._dragCritterEntity:tweenDown()

		slot0._dragCritterEntity = nil
		slot0._critterPointPos = nil
	end

	CritterController.instance:clearSelectedCritterSeatSlot()
	TaskDispatcher.cancelTask(slot0._switchFinish, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
