module("modules.logic.room.view.critter.RoomCritterPlaceView", package.seeall)

local var_0_0 = class("RoomCritterPlaceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocritterview1 = gohelper.findChild(arg_1_0.viewGO, "#go_critterview1")
	arg_1_0._btnunfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterview1/critterscroll/#btn_unfold")
	arg_1_0._gocritterview2 = gohelper.findChild(arg_1_0.viewGO, "#go_critterview2")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterview2/critterscroll/#btn_fold")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnunfold:AddClickListener(arg_2_0._btnunfoldOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnfoldOnClick, arg_2_0, true)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterListOnDragBeginListener, arg_2_0._onListDragBeginListener, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterListOnDragListener, arg_2_0._onListDragListener, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterListOnDragEndListener, arg_2_0._onListDragEndListener, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_2_0._onRestingCritterChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, arg_2_0._onChangeRestBuilding, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfold:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterListOnDragBeginListener, arg_3_0._onListDragBeginListener, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterListOnDragListener, arg_3_0._onListDragListener, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterListOnDragEndListener, arg_3_0._onListDragEndListener, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, arg_3_0._onRestingCritterChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, arg_3_0._onChangeRestBuilding, arg_3_0)
end

function var_0_0._btnunfoldOnClick(arg_4_0)
	arg_4_0._isFold = false
	arg_4_0._canvasGroup1.blocksRaycasts = false
	arg_4_0._canvasGroup2.blocksRaycasts = true
	arg_4_0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	arg_4_0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	arg_4_0:playAnim("switchup")

	local var_4_0 = arg_4_0:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(var_4_0)

	arg_4_0._scrollRect = arg_4_0._critterView2.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingSetCanOperateRestingCritter, false)
end

function var_0_0._btnfoldOnClick(arg_5_0, arg_5_1)
	arg_5_0._isFold = true
	arg_5_0._canvasGroup1.blocksRaycasts = true
	arg_5_0._canvasGroup2.blocksRaycasts = false
	arg_5_0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	arg_5_0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	if arg_5_1 then
		arg_5_0:playAnim("switchdown")
	end

	local var_5_0 = arg_5_0:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(var_5_0)

	arg_5_0._scrollRect = arg_5_0._critterView1.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingSetCanOperateRestingCritter, true)
end

function var_0_0._btnsortOnClick(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.orderDown

	if RoomCritterPlaceListModel.instance:getOrder() == arg_6_1.orderDown then
		var_6_0 = arg_6_1.orderUp
	end

	local var_6_1 = arg_6_0:getViewBuilding()

	RoomCritterPlaceListModel.instance:setOrder(var_6_0)
	RoomCritterPlaceListModel.instance:setCritterPlaceList(var_6_1)
	arg_6_0:refreshSort()
end

function var_0_0._onListDragBeginListener(arg_7_0, arg_7_1)
	arg_7_0._scrollRect:OnBeginDrag(arg_7_1)
end

function var_0_0._onListDragListener(arg_8_0, arg_8_1)
	arg_8_0._scrollRect:OnDrag(arg_8_1)
end

function var_0_0._onListDragEndListener(arg_9_0, arg_9_1)
	arg_9_0._scrollRect:OnEndDrag(arg_9_1)
end

function var_0_0._onRestingCritterChange(arg_10_0)
	local var_10_0 = arg_10_0:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(var_10_0)
end

function var_0_0._onChangeRestBuilding(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	arg_11_0.viewContainer:setContainerViewBuildingUid(arg_11_1)
	arg_11_0:playAnim(UIAnimationName.Close)
	TaskDispatcher.cancelTask(arg_11_0._changeFinish, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._changeFinish, arg_11_0, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function var_0_0._changeFinish(arg_12_0)
	local var_12_0 = arg_12_0:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(var_12_0)
	arg_12_0:playAnim(UIAnimationName.Open)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._canvasGroup1 = arg_13_0._gocritterview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._canvasGroup2 = arg_13_0._gocritterview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._critterView1 = arg_13_0:getUserDataTb_()
	arg_13_0._critterView2 = arg_13_0:getUserDataTb_()

	arg_13_0:initCritterView(arg_13_0._critterView1, arg_13_0._gocritterview1, 1)
	arg_13_0:initCritterView(arg_13_0._critterView2, arg_13_0._gocritterview2, 2)

	arg_13_0._animator = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.initCritterView(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1.scrollCritter = gohelper.findChildScrollRect(arg_14_2, "critterscroll")
	arg_14_1.gomood = gohelper.findChild(arg_14_2, "crittersort/leftbtn/#btn_moodrank")
	arg_14_1.gorare = gohelper.findChild(arg_14_2, "crittersort/leftbtn/#btn_rarerank")
	arg_14_1.sortMoodItem = arg_14_0:getUserDataTb_()
	arg_14_1.sortRareItem = arg_14_0:getUserDataTb_()

	arg_14_0:_initSortItem(arg_14_1.sortMoodItem, arg_14_1.gomood, CritterEnum.OrderType.MoodUp, CritterEnum.OrderType.MoodDown)
	arg_14_0:_initSortItem(arg_14_1.sortRareItem, arg_14_1.gorare, CritterEnum.OrderType.RareUp, CritterEnum.OrderType.RareDown)
end

function var_0_0._initSortItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1.btnsort = gohelper.findChildButtonWithAudio(arg_15_2, "")
	arg_15_1.go1 = gohelper.findChild(arg_15_2, "btn1")
	arg_15_1.go2 = gohelper.findChild(arg_15_2, "btn2")
	arg_15_1.goarrow = gohelper.findChild(arg_15_2, "btn2/arrow")
	arg_15_1.orderUp = arg_15_3
	arg_15_1.orderDown = arg_15_4

	arg_15_1.btnsort:AddClickListener(arg_15_0._btnsortOnClick, arg_15_0, arg_15_1)
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:_btnfoldOnClick()
	arg_17_0:refreshSort()
end

function var_0_0.refreshSort(arg_18_0)
	arg_18_0:_refreshSortItemSort(arg_18_0._critterView1.sortMoodItem)
	arg_18_0:_refreshSortItemSort(arg_18_0._critterView1.sortRareItem)
	arg_18_0:_refreshSortItemSort(arg_18_0._critterView2.sortMoodItem)
	arg_18_0:_refreshSortItemSort(arg_18_0._critterView2.sortRareItem)
end

function var_0_0._refreshSortItemSort(arg_19_0, arg_19_1)
	local var_19_0 = RoomCritterPlaceListModel.instance:getOrder()

	arg_19_0:_setSort(arg_19_1, var_19_0 == arg_19_1.orderUp or var_19_0 == arg_19_1.orderDown, var_19_0 == arg_19_1.orderUp)
end

function var_0_0._setSort(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 then
		gohelper.setActive(arg_20_1.go1, false)
		gohelper.setActive(arg_20_1.go2, true)
		arg_20_0:_setReverse(arg_20_1.goarrow.transform, arg_20_3)
	else
		gohelper.setActive(arg_20_1.go1, true)
		gohelper.setActive(arg_20_1.go2, false)
	end
end

function var_0_0._setReverse(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1, var_21_2 = transformhelper.getLocalScale(arg_21_1)

	if arg_21_2 then
		transformhelper.setLocalScale(arg_21_1, var_21_0, -math.abs(var_21_1), var_21_2)
	else
		transformhelper.setLocalScale(arg_21_1, var_21_0, math.abs(var_21_1), var_21_2)
	end
end

function var_0_0.playAnim(arg_22_0, arg_22_1)
	arg_22_0._animator.enabled = true

	arg_22_0._animator:Play(arg_22_1)
end

function var_0_0.getViewBuilding(arg_23_0)
	local var_23_0, var_23_1 = arg_23_0.viewContainer:getContainerViewBuilding(true)

	return var_23_0, var_23_1
end

function var_0_0.onClose(arg_24_0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
	RoomCritterPlaceListModel.instance:clearData()
	TaskDispatcher.cancelTask(arg_24_0._changeFinish, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0:_critterViewOnDestroy(arg_25_0._critterView1)
	arg_25_0:_critterViewOnDestroy(arg_25_0._critterView2)
end

function var_0_0._critterViewOnDestroy(arg_26_0, arg_26_1)
	arg_26_0:_sortItemOnDestroy(arg_26_1.sortMoodItem)
	arg_26_0:_sortItemOnDestroy(arg_26_1.sortRareItem)
end

function var_0_0._sortItemOnDestroy(arg_27_0, arg_27_1)
	arg_27_1.btnsort:RemoveClickListener()
end

return var_0_0
