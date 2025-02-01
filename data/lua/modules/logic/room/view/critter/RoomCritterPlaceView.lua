module("modules.logic.room.view.critter.RoomCritterPlaceView", package.seeall)

slot0 = class("RoomCritterPlaceView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocritterview1 = gohelper.findChild(slot0.viewGO, "#go_critterview1")
	slot0._btnunfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterview1/critterscroll/#btn_unfold")
	slot0._gocritterview2 = gohelper.findChild(slot0.viewGO, "#go_critterview2")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterview2/critterscroll/#btn_fold")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnunfold:AddClickListener(slot0._btnunfoldOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnfoldOnClick, slot0, true)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterListOnDragBeginListener, slot0._onListDragBeginListener, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterListOnDragListener, slot0._onListDragListener, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterListOnDragEndListener, slot0._onListDragEndListener, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._onRestingCritterChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, slot0._onChangeRestBuilding, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnunfold:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterListOnDragBeginListener, slot0._onListDragBeginListener, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterListOnDragListener, slot0._onListDragListener, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterListOnDragEndListener, slot0._onListDragEndListener, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._onRestingCritterChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, slot0._onChangeRestBuilding, slot0)
end

function slot0._btnunfoldOnClick(slot0)
	slot0._isFold = false
	slot0._canvasGroup1.blocksRaycasts = false
	slot0._canvasGroup2.blocksRaycasts = true
	slot0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	slot0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	slot0:playAnim("switchup")
	RoomCritterPlaceListModel.instance:setCritterPlaceList(slot0:getViewBuilding())

	slot0._scrollRect = slot0._critterView2.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingSetCanOperateRestingCritter, false)
end

function slot0._btnfoldOnClick(slot0, slot1)
	slot0._isFold = true
	slot0._canvasGroup1.blocksRaycasts = true
	slot0._canvasGroup2.blocksRaycasts = false
	slot0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	slot0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	if slot1 then
		slot0:playAnim("switchdown")
	end

	RoomCritterPlaceListModel.instance:setCritterPlaceList(slot0:getViewBuilding())

	slot0._scrollRect = slot0._critterView1.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingSetCanOperateRestingCritter, true)
end

function slot0._btnsortOnClick(slot0, slot1)
	slot2 = slot1.orderDown

	if RoomCritterPlaceListModel.instance:getOrder() == slot1.orderDown then
		slot2 = slot1.orderUp
	end

	RoomCritterPlaceListModel.instance:setOrder(slot2)
	RoomCritterPlaceListModel.instance:setCritterPlaceList(slot0:getViewBuilding())
	slot0:refreshSort()
end

function slot0._onListDragBeginListener(slot0, slot1)
	slot0._scrollRect:OnBeginDrag(slot1)
end

function slot0._onListDragListener(slot0, slot1)
	slot0._scrollRect:OnDrag(slot1)
end

function slot0._onListDragEndListener(slot0, slot1)
	slot0._scrollRect:OnEndDrag(slot1)
end

function slot0._onRestingCritterChange(slot0)
	RoomCritterPlaceListModel.instance:setCritterPlaceList(slot0:getViewBuilding())
end

function slot0._onChangeRestBuilding(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.viewContainer:setContainerViewBuildingUid(slot1)
	slot0:playAnim(UIAnimationName.Close)
	TaskDispatcher.cancelTask(slot0._changeFinish, slot0)
	TaskDispatcher.runDelay(slot0._changeFinish, slot0, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function slot0._changeFinish(slot0)
	RoomCritterPlaceListModel.instance:setCritterPlaceList(slot0:getViewBuilding())
	slot0:playAnim(UIAnimationName.Open)
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup1 = slot0._gocritterview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._canvasGroup2 = slot0._gocritterview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._critterView1 = slot0:getUserDataTb_()
	slot0._critterView2 = slot0:getUserDataTb_()

	slot0:initCritterView(slot0._critterView1, slot0._gocritterview1, 1)
	slot0:initCritterView(slot0._critterView2, slot0._gocritterview2, 2)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.initCritterView(slot0, slot1, slot2, slot3)
	slot1.scrollCritter = gohelper.findChildScrollRect(slot2, "critterscroll")
	slot1.gomood = gohelper.findChild(slot2, "crittersort/leftbtn/#btn_moodrank")
	slot1.gorare = gohelper.findChild(slot2, "crittersort/leftbtn/#btn_rarerank")
	slot1.sortMoodItem = slot0:getUserDataTb_()
	slot1.sortRareItem = slot0:getUserDataTb_()

	slot0:_initSortItem(slot1.sortMoodItem, slot1.gomood, CritterEnum.OrderType.MoodUp, CritterEnum.OrderType.MoodDown)
	slot0:_initSortItem(slot1.sortRareItem, slot1.gorare, CritterEnum.OrderType.RareUp, CritterEnum.OrderType.RareDown)
end

function slot0._initSortItem(slot0, slot1, slot2, slot3, slot4)
	slot1.btnsort = gohelper.findChildButtonWithAudio(slot2, "")
	slot1.go1 = gohelper.findChild(slot2, "btn1")
	slot1.go2 = gohelper.findChild(slot2, "btn2")
	slot1.goarrow = gohelper.findChild(slot2, "btn2/arrow")
	slot1.orderUp = slot3
	slot1.orderDown = slot4

	slot1.btnsort:AddClickListener(slot0._btnsortOnClick, slot0, slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_btnfoldOnClick()
	slot0:refreshSort()
end

function slot0.refreshSort(slot0)
	slot0:_refreshSortItemSort(slot0._critterView1.sortMoodItem)
	slot0:_refreshSortItemSort(slot0._critterView1.sortRareItem)
	slot0:_refreshSortItemSort(slot0._critterView2.sortMoodItem)
	slot0:_refreshSortItemSort(slot0._critterView2.sortRareItem)
end

function slot0._refreshSortItemSort(slot0, slot1)
	slot0:_setSort(slot1, RoomCritterPlaceListModel.instance:getOrder() == slot1.orderUp or slot2 == slot1.orderDown, slot2 == slot1.orderUp)
end

function slot0._setSort(slot0, slot1, slot2, slot3)
	if slot2 then
		gohelper.setActive(slot1.go1, false)
		gohelper.setActive(slot1.go2, true)
		slot0:_setReverse(slot1.goarrow.transform, slot3)
	else
		gohelper.setActive(slot1.go1, true)
		gohelper.setActive(slot1.go2, false)
	end
end

function slot0._setReverse(slot0, slot1, slot2)
	slot3, slot4, slot5 = transformhelper.getLocalScale(slot1)

	if slot2 then
		transformhelper.setLocalScale(slot1, slot3, -math.abs(slot4), slot5)
	else
		transformhelper.setLocalScale(slot1, slot3, math.abs(slot4), slot5)
	end
end

function slot0.playAnim(slot0, slot1)
	slot0._animator.enabled = true

	slot0._animator:Play(slot1)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = slot0.viewContainer:getContainerViewBuilding(true)

	return slot1, slot2
end

function slot0.onClose(slot0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
	RoomCritterPlaceListModel.instance:clearData()
	TaskDispatcher.cancelTask(slot0._changeFinish, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_critterViewOnDestroy(slot0._critterView1)
	slot0:_critterViewOnDestroy(slot0._critterView2)
end

function slot0._critterViewOnDestroy(slot0, slot1)
	slot0:_sortItemOnDestroy(slot1.sortMoodItem)
	slot0:_sortItemOnDestroy(slot1.sortRareItem)
end

function slot0._sortItemOnDestroy(slot0, slot1)
	slot1.btnsort:RemoveClickListener()
end

return slot0
