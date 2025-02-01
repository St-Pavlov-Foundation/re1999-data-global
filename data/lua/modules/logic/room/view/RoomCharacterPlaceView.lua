module("modules.logic.room.view.RoomCharacterPlaceView", package.seeall)

slot0 = class("RoomCharacterPlaceView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomaskbg = gohelper.findChild(slot0.viewGO, "#go_maskbg")
	slot0._goroleview1 = gohelper.findChild(slot0.viewGO, "#go_roleview1")
	slot0._btnunfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_roleview1/rolescroll/#btn_unfold")
	slot0._goroleview2 = gohelper.findChild(slot0.viewGO, "#go_roleview2")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_roleview2/rolescroll/#btn_fold")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnunfold:AddClickListener(slot0._btnunfoldOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnfoldOnClick, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnunfold:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._btncloseviewOnClick(slot0)
	if GameSceneMgr.instance:getCurScene().camera:isTweening() or not slot1.fsm:getCurStateName() then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		RoomCharacterController.instance:setCharacterListShow(false)
	end
end

function slot0._btnunfoldOnClick(slot0)
	slot0:_setCramerFoucs(true)
	slot0:_unfold(true)
	slot0:_tweentCramerFoucs()
end

function slot0._btnfoldOnClick(slot0)
	slot0:_setCramerFoucs(false)
	slot0:_fold(true)
	slot0:_tweentCramerFoucs()
end

function slot0._unfold(slot0, slot1)
	RoomCharacterModel.instance:setCanDragCharacter(false)

	slot0._isFold = false
	slot0._canvasGroup1.blocksRaycasts = false
	slot0._canvasGroup2.blocksRaycasts = true
	slot0._roleViewItem1.scrollrole.horizontalNormalizedPosition = 0
	slot0._roleViewItem2.scrollrole.verticalNormalizedPosition = 1

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	slot0._animator.enabled = true

	if slot1 then
		slot0._animator:Play("switchup", 0, 0)
	else
		slot0._animator:Play("switchup", 0, 1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)

	slot0._scrollRect = slot0._roleViewItem2.scrollrole.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function slot0._fold(slot0, slot1)
	RoomCharacterModel.instance:setCanDragCharacter(true)

	slot0._isFold = true
	slot0._canvasGroup1.blocksRaycasts = true
	slot0._canvasGroup2.blocksRaycasts = false
	slot0._roleViewItem1.scrollrole.horizontalNormalizedPosition = 0
	slot0._roleViewItem2.scrollrole.verticalNormalizedPosition = 1

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	slot0._animator.enabled = true

	if slot1 then
		slot0._animator:Play("switchdown", 0, 0)
	else
		slot0._animator:Play("switchdown", 0, 1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)

	slot0._scrollRect = slot0._roleViewItem1.scrollrole.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function slot0._btnbirthdayfilterOnClick(slot0)
	if RoomCharacterController.instance:setFilterOnBirthday(not RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()) then
		slot0:_refreshBirthdayFilter()
	end
end

function slot0._onDailyRefresh(slot0)
	slot2 = false

	if RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday() and not RoomCharacterPlaceListModel.instance:hasHeroOnBirthday() then
		slot2 = true
	end

	if slot2 then
		slot0:_btnbirthdayfilterOnClick()
	else
		RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	end
end

function slot0._setCramerFoucs(slot0, slot1)
	RoomCharacterController.instance:setCharacterFocus(slot1 and RoomCharacterEnum.CameraFocus.MoreShowList or RoomCharacterEnum.CameraFocus.Normal)
end

function slot0._tweentCramerFoucs(slot0)
	if RoomCharacterModel.instance:getTempCharacterMO() and slot1.currentPosition then
		slot3 = slot1.currentPosition

		RoomCharacterController.instance:tweenCameraFocus(slot3.x, slot3.z, RoomCharacterController.instance:getCharacterFocus())
	end
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._canvasGroup1 = slot0._goroleview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._canvasGroup2 = slot0._goroleview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._goarrowTrs1 = gohelper.findChild(slot0.viewGO, "#go_roleview1/rolesort/#drop_equipclassify1/go_arrow").transform
	slot0._goarrowTrs2 = gohelper.findChild(slot0.viewGO, "#go_roleview2/rolescroll/rolesort/#drop_equipclassify2/go_arrow").transform
	slot0._birthdayFilterBtn1 = slot0:getUserDataTb_()
	slot0._birthdayFilterBtn2 = slot0:getUserDataTb_()

	slot0:_initBirthdayFilterBtn(gohelper.findChild(slot0.viewGO, "#go_roleview1/rolesort/#btn_birthdayfilter1"), slot0._birthdayFilterBtn1)
	slot0:_initBirthdayFilterBtn(gohelper.findChild(slot0.viewGO, "#go_roleview2/rolescroll/rolesort/#btn_birthdayfilter2"), slot0._birthdayFilterBtn2)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._roleViewItem1 = slot0:getUserDataTb_()
	slot0._roleViewItem2 = slot0:getUserDataTb_()

	slot0:_initRoleViewItem(slot0._roleViewItem1, slot0._goroleview1, 1)
	slot0:_initRoleViewItem(slot0._roleViewItem2, slot0._goroleview2, 2)
	TaskDispatcher.runRepeat(slot0._checkDropList1Exist, slot0, 0.2)
	TaskDispatcher.runRepeat(slot0._checkDropList2Exist, slot0, 0.2)
end

function slot0._initBirthdayFilterBtn(slot0, slot1, slot2)
	if not slot2 or gohelper.isNil(slot1) then
		return
	end

	slot2.btn = gohelper.findButtonWithAudio(slot1)

	slot2.btn:AddClickListener(slot0._btnbirthdayfilterOnClick, slot0)

	slot2.gonormal = gohelper.findChild(slot1, "normal")
	slot2.goselect = gohelper.findChild(slot1, "select")
end

function slot0._initRoleViewItem(slot0, slot1, slot2, slot3)
	slot1.gorare = gohelper.findChild(slot2, "rolesort/leftbtn/#btn_rarerank" .. slot3) or gohelper.findChild(slot2, "rolescroll/rolesort/leftbtn/#btn_rarerank" .. slot3)
	slot1.gofaith = gohelper.findChild(slot2, "rolesort/leftbtn/#btn_faithrank" .. slot3) or gohelper.findChild(slot2, "rolescroll/rolesort/leftbtn/#btn_faithrank" .. slot3)
	slot1.sortRareItem = slot0:getUserDataTb_()
	slot1.sortFaithItem = slot0:getUserDataTb_()

	slot0:_initSortItem(slot1.sortRareItem, slot1.gorare, RoomCharacterEnum.CharacterOrderType.RareUp, RoomCharacterEnum.CharacterOrderType.RareDown)
	slot0:_initSortItem(slot1.sortFaithItem, slot1.gofaith, RoomCharacterEnum.CharacterOrderType.FaithUp, RoomCharacterEnum.CharacterOrderType.FaithDown)

	slot1.scrollrole = gohelper.findChildScrollRect(slot2, "rolescroll")
	slot1.dropClassify = gohelper.findChildDropdown(slot2, "rolesort/#drop_equipclassify" .. slot3) or gohelper.findChildDropdown(slot2, "rolescroll/rolesort/#drop_equipclassify" .. slot3)

	gohelper.addUIClickAudio(slot1.dropClassify.gameObject, AudioEnum.UI.play_ui_callfor_open)

	slot1.dropClassifyClick = gohelper.getClick(slot1.dropClassify.gameObject)

	slot1.dropClassifyClick:AddClickListener(slot0._onClicked, slot0, slot1.dropClassify)
	slot1.dropClassify:AddOnValueChanged(slot0._onValueChanged, slot0)

	slot4 = {}

	for slot8 = 1, 6 do
		table.insert(slot4, luaLang("career" .. slot8))
	end

	slot1.dropClassify:AddOptions(slot4)
end

function slot0._onValueChanged(slot0, slot1)
	if slot1 == 0 then
		RoomCharacterPlaceListModel.instance:setFilterCareer()
	else
		RoomCharacterPlaceListModel.instance:setFilterCareer({
			slot1
		})
	end

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	slot0:_refreshCareer()
	slot0:_refreshBirthdayFilter()
end

function slot0._onClicked(slot0, slot1)
	slot4 = gohelper.findChild(slot1.dropDown.gameObject, "Dropdown List/Viewport/Content").transform
	slot5 = {}
	gohelper.findChildText((not RoomCharacterPlaceListModel.instance:getFilterCareer() or slot4:GetChild(slot3 + 1).gameObject) and slot4:GetChild(1).gameObject, "Text").color = GameUtil.parseColor("#EFB785")

	slot0:_addAudioToBlock()
	slot0:_addAudioToToggles(slot4)
end

function slot0._refreshCareer(slot0)
	slot0:_refreshRoleViewItemCareer(slot0._roleViewItem1)
	slot0:_refreshRoleViewItemCareer(slot0._roleViewItem2)
end

function slot0._refreshRoleViewItemCareer(slot0, slot1)
	if RoomCharacterPlaceListModel.instance:isFilterCareerEmpty() then
		slot1.dropClassify:SetValue(0)
	else
		for slot5 = 1, 6 do
			if RoomCharacterPlaceListModel.instance:isFilterCareer(slot5) then
				slot1.dropClassify:SetValue(slot5)

				break
			end
		end
	end
end

function slot0._roleViewItemOnDestroy(slot0, slot1)
	slot0:_sortItemOnDestroy(slot1.sortRareItem)
	slot0:_sortItemOnDestroy(slot1.sortFaithItem)
	slot1.dropClassify:RemoveOnValueChanged()
	slot1.dropClassifyClick:RemoveClickListener()
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

function slot0._btnsortOnClick(slot0, slot1)
	if RoomCharacterPlaceListModel.instance:getOrder() == slot1.orderDown then
		RoomCharacterPlaceListModel.instance:setOrder(slot1.orderUp)
	else
		RoomCharacterPlaceListModel.instance:setOrder(slot1.orderDown)
	end

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	slot0:_refreshSort()
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

function slot0._sortItemOnDestroy(slot0, slot1)
	slot1.btnsort:RemoveClickListener()
end

function slot0._refreshSort(slot0)
	slot0:_refreshRoleViewItemSort(slot0._roleViewItem1)
	slot0:_refreshRoleViewItemSort(slot0._roleViewItem2)
end

function slot0._refreshRoleViewItemSort(slot0, slot1)
	slot0:_refreshSortItemSort(slot1.sortRareItem)
	slot0:_refreshSortItemSort(slot1.sortFaithItem)
end

function slot0._refreshSortItemSort(slot0, slot1)
	slot0:_setSort(slot1, RoomCharacterPlaceListModel.instance:getOrder() == slot1.orderUp or slot2 == slot1.orderDown, slot2 == slot1.orderUp)
end

function slot0._refreshBirthdayFilter(slot0)
	slot1 = RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()

	gohelper.setActive(slot0._birthdayFilterBtn1.goselect, slot1)
	gohelper.setActive(slot0._birthdayFilterBtn2.goselect, slot1)
	gohelper.setActive(slot0._birthdayFilterBtn1.gonormal, not slot1)
	gohelper.setActive(slot0._birthdayFilterBtn2.gonormal, not slot1)
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnunfold.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(slot0._btnfold.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0._onEscape(slot0)
	slot0:_btncloseviewOnClick()
end

function slot0._clientPlaceCharacter(slot0)
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

function slot0.onOpen(slot0)
	slot0:_setCramerFoucs(false)
	slot0:_fold()
	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	slot0:_refreshSort()
	slot0:_refreshCareer()
	slot0:_addBtnAudio()
	slot0:_refreshBirthdayFilter()
	NavigateMgr.instance:addEscape(ViewName.RoomCharacterPlaceView, slot0._onEscape, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceCharacter, slot0._clientPlaceCharacter, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListOnDragBeginListener, slot0._onListDragBeginListener, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListOnDragListener, slot0._onListDragListener, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListOnDragEndListener, slot0._onListDragEndListener, slot0)
end

function slot0._addAudioToBlock(slot0)
	if gohelper.findChild(ViewMgr.instance:getUIRoot(), "Blocker") then
		gohelper.addUIClickAudio(slot2, AudioEnum.UI.play_ui_callfor_open)
	end
end

function slot0._addAudioToToggles(slot0, slot1)
	if slot1.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Toggle), false) then
		slot3 = slot2:GetEnumerator()

		while slot3:MoveNext() do
			gohelper.addUIClickAudio(slot3.Current.gameObject, AudioEnum.UI.play_ui_callfor_open)
		end
	end
end

function slot0._checkDropList1Exist(slot0)
	if gohelper.findChild(slot0._roleViewItem1.dropClassify.gameObject, "Dropdown List") then
		if not slot0.dropShow1 then
			transformhelper.setLocalRotation(slot0._goarrowTrs1, 0, 0, 180)

			slot0.dropShow1 = true
		end
	elseif slot0.dropShow1 then
		transformhelper.setLocalRotation(slot0._goarrowTrs1, 0, 0, 0)

		slot0.dropShow1 = false
	end
end

function slot0._checkDropList2Exist(slot0)
	if gohelper.findChild(slot0._roleViewItem2.dropClassify.gameObject, "Dropdown List") then
		if not slot0.dropShow2 then
			transformhelper.setLocalRotation(slot0._goarrowTrs2, 0, 0, 0)

			slot0.dropShow2 = true
		end
	elseif slot0.dropShow2 then
		transformhelper.setLocalRotation(slot0._goarrowTrs2, 0, 0, 180)

		slot0.dropShow2 = false
	end
end

function slot0.onClose(slot0)
	RoomCharacterController.instance:onCloseRoomCharacterPlaceView()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._checkDropList1Exist, slot0)
	TaskDispatcher.cancelTask(slot0._checkDropList2Exist, slot0)
	slot0:_roleViewItemOnDestroy(slot0._roleViewItem1)
	slot0:_roleViewItemOnDestroy(slot0._roleViewItem2)
	slot0._birthdayFilterBtn1.btn:RemoveClickListener()
	slot0._birthdayFilterBtn2.btn:RemoveClickListener()
	slot0:_setCramerFoucs(false)
end

return slot0
