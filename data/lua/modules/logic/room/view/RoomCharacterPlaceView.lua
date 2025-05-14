module("modules.logic.room.view.RoomCharacterPlaceView", package.seeall)

local var_0_0 = class("RoomCharacterPlaceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomaskbg = gohelper.findChild(arg_1_0.viewGO, "#go_maskbg")
	arg_1_0._goroleview1 = gohelper.findChild(arg_1_0.viewGO, "#go_roleview1")
	arg_1_0._btnunfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_roleview1/rolescroll/#btn_unfold")
	arg_1_0._goroleview2 = gohelper.findChild(arg_1_0.viewGO, "#go_roleview2")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_roleview2/rolescroll/#btn_fold")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnunfold:AddClickListener(arg_2_0._btnunfoldOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnfoldOnClick, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfold:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurScene()

	if var_4_0.camera:isTweening() or not var_4_0.fsm:getCurStateName() then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		RoomCharacterController.instance:setCharacterListShow(false)
	end
end

function var_0_0._btnunfoldOnClick(arg_5_0)
	arg_5_0:_setCramerFoucs(true)
	arg_5_0:_unfold(true)
	arg_5_0:_tweentCramerFoucs()
end

function var_0_0._btnfoldOnClick(arg_6_0)
	arg_6_0:_setCramerFoucs(false)
	arg_6_0:_fold(true)
	arg_6_0:_tweentCramerFoucs()
end

function var_0_0._unfold(arg_7_0, arg_7_1)
	RoomCharacterModel.instance:setCanDragCharacter(false)

	arg_7_0._isFold = false
	arg_7_0._canvasGroup1.blocksRaycasts = false
	arg_7_0._canvasGroup2.blocksRaycasts = true
	arg_7_0._roleViewItem1.scrollrole.horizontalNormalizedPosition = 0
	arg_7_0._roleViewItem2.scrollrole.verticalNormalizedPosition = 1

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	arg_7_0._animator.enabled = true

	if arg_7_1 then
		arg_7_0._animator:Play("switchup", 0, 0)
	else
		arg_7_0._animator:Play("switchup", 0, 1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)

	arg_7_0._scrollRect = arg_7_0._roleViewItem2.scrollrole.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function var_0_0._fold(arg_8_0, arg_8_1)
	RoomCharacterModel.instance:setCanDragCharacter(true)

	arg_8_0._isFold = true
	arg_8_0._canvasGroup1.blocksRaycasts = true
	arg_8_0._canvasGroup2.blocksRaycasts = false
	arg_8_0._roleViewItem1.scrollrole.horizontalNormalizedPosition = 0
	arg_8_0._roleViewItem2.scrollrole.verticalNormalizedPosition = 1

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	arg_8_0._animator.enabled = true

	if arg_8_1 then
		arg_8_0._animator:Play("switchdown", 0, 0)
	else
		arg_8_0._animator:Play("switchdown", 0, 1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)

	arg_8_0._scrollRect = arg_8_0._roleViewItem1.scrollrole.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function var_0_0._btnbirthdayfilterOnClick(arg_9_0)
	local var_9_0 = not RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()

	if RoomCharacterController.instance:setFilterOnBirthday(var_9_0) then
		arg_9_0:_refreshBirthdayFilter()
	end
end

function var_0_0._onDailyRefresh(arg_10_0)
	local var_10_0 = RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()
	local var_10_1 = false

	if var_10_0 and not RoomCharacterPlaceListModel.instance:hasHeroOnBirthday() then
		var_10_1 = true
	end

	if var_10_1 then
		arg_10_0:_btnbirthdayfilterOnClick()
	else
		RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	end
end

function var_0_0._setCramerFoucs(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and RoomCharacterEnum.CameraFocus.MoreShowList or RoomCharacterEnum.CameraFocus.Normal

	RoomCharacterController.instance:setCharacterFocus(var_11_0)
end

function var_0_0._tweentCramerFoucs(arg_12_0)
	local var_12_0 = RoomCharacterModel.instance:getTempCharacterMO()

	if var_12_0 and var_12_0.currentPosition then
		local var_12_1 = RoomCharacterController.instance:getCharacterFocus()
		local var_12_2 = var_12_0.currentPosition
		local var_12_3 = var_12_2.x
		local var_12_4 = var_12_2.z

		RoomCharacterController.instance:tweenCameraFocus(var_12_3, var_12_4, var_12_1)
	end
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._scene = GameSceneMgr.instance:getCurScene()
	arg_13_0._canvasGroup1 = arg_13_0._goroleview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._canvasGroup2 = arg_13_0._goroleview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._goarrowTrs1 = gohelper.findChild(arg_13_0.viewGO, "#go_roleview1/rolesort/#drop_equipclassify1/go_arrow").transform
	arg_13_0._goarrowTrs2 = gohelper.findChild(arg_13_0.viewGO, "#go_roleview2/rolescroll/rolesort/#drop_equipclassify2/go_arrow").transform
	arg_13_0._birthdayFilterBtn1 = arg_13_0:getUserDataTb_()
	arg_13_0._birthdayFilterBtn2 = arg_13_0:getUserDataTb_()

	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "#go_roleview1/rolesort/#btn_birthdayfilter1")
	local var_13_1 = gohelper.findChild(arg_13_0.viewGO, "#go_roleview2/rolescroll/rolesort/#btn_birthdayfilter2")

	arg_13_0:_initBirthdayFilterBtn(var_13_0, arg_13_0._birthdayFilterBtn1)
	arg_13_0:_initBirthdayFilterBtn(var_13_1, arg_13_0._birthdayFilterBtn2)

	arg_13_0._animator = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._roleViewItem1 = arg_13_0:getUserDataTb_()
	arg_13_0._roleViewItem2 = arg_13_0:getUserDataTb_()

	arg_13_0:_initRoleViewItem(arg_13_0._roleViewItem1, arg_13_0._goroleview1, 1)
	arg_13_0:_initRoleViewItem(arg_13_0._roleViewItem2, arg_13_0._goroleview2, 2)
	TaskDispatcher.runRepeat(arg_13_0._checkDropList1Exist, arg_13_0, 0.2)
	TaskDispatcher.runRepeat(arg_13_0._checkDropList2Exist, arg_13_0, 0.2)
end

function var_0_0._initBirthdayFilterBtn(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_2 or gohelper.isNil(arg_14_1) then
		return
	end

	arg_14_2.btn = gohelper.findButtonWithAudio(arg_14_1)

	arg_14_2.btn:AddClickListener(arg_14_0._btnbirthdayfilterOnClick, arg_14_0)

	arg_14_2.gonormal = gohelper.findChild(arg_14_1, "normal")
	arg_14_2.goselect = gohelper.findChild(arg_14_1, "select")
end

function var_0_0._initRoleViewItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1.gorare = gohelper.findChild(arg_15_2, "rolesort/leftbtn/#btn_rarerank" .. arg_15_3) or gohelper.findChild(arg_15_2, "rolescroll/rolesort/leftbtn/#btn_rarerank" .. arg_15_3)
	arg_15_1.gofaith = gohelper.findChild(arg_15_2, "rolesort/leftbtn/#btn_faithrank" .. arg_15_3) or gohelper.findChild(arg_15_2, "rolescroll/rolesort/leftbtn/#btn_faithrank" .. arg_15_3)
	arg_15_1.sortRareItem = arg_15_0:getUserDataTb_()
	arg_15_1.sortFaithItem = arg_15_0:getUserDataTb_()

	arg_15_0:_initSortItem(arg_15_1.sortRareItem, arg_15_1.gorare, RoomCharacterEnum.CharacterOrderType.RareUp, RoomCharacterEnum.CharacterOrderType.RareDown)
	arg_15_0:_initSortItem(arg_15_1.sortFaithItem, arg_15_1.gofaith, RoomCharacterEnum.CharacterOrderType.FaithUp, RoomCharacterEnum.CharacterOrderType.FaithDown)

	arg_15_1.scrollrole = gohelper.findChildScrollRect(arg_15_2, "rolescroll")
	arg_15_1.dropClassify = gohelper.findChildDropdown(arg_15_2, "rolesort/#drop_equipclassify" .. arg_15_3) or gohelper.findChildDropdown(arg_15_2, "rolescroll/rolesort/#drop_equipclassify" .. arg_15_3)

	gohelper.addUIClickAudio(arg_15_1.dropClassify.gameObject, AudioEnum.UI.play_ui_callfor_open)

	arg_15_1.dropClassifyClick = gohelper.getClick(arg_15_1.dropClassify.gameObject)

	arg_15_1.dropClassifyClick:AddClickListener(arg_15_0._onClicked, arg_15_0, arg_15_1.dropClassify)
	arg_15_1.dropClassify:AddOnValueChanged(arg_15_0._onValueChanged, arg_15_0)

	local var_15_0 = {}

	for iter_15_0 = 1, 6 do
		table.insert(var_15_0, luaLang("career" .. iter_15_0))
	end

	arg_15_1.dropClassify:AddOptions(var_15_0)
end

function var_0_0._onValueChanged(arg_16_0, arg_16_1)
	if arg_16_1 == 0 then
		RoomCharacterPlaceListModel.instance:setFilterCareer()
	else
		RoomCharacterPlaceListModel.instance:setFilterCareer({
			arg_16_1
		})
	end

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	arg_16_0:_refreshCareer()
	arg_16_0:_refreshBirthdayFilter()
end

function var_0_0._onClicked(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.dropDown
	local var_17_1 = RoomCharacterPlaceListModel.instance:getFilterCareer()
	local var_17_2 = gohelper.findChild(var_17_0.gameObject, "Dropdown List/Viewport/Content").transform
	local var_17_3 = {}

	if var_17_1 then
		var_17_3 = var_17_2:GetChild(var_17_1 + 1).gameObject
	else
		var_17_3 = var_17_2:GetChild(1).gameObject
	end

	gohelper.findChildText(var_17_3, "Text").color = GameUtil.parseColor("#EFB785")

	arg_17_0:_addAudioToBlock()
	arg_17_0:_addAudioToToggles(var_17_2)
end

function var_0_0._refreshCareer(arg_18_0)
	arg_18_0:_refreshRoleViewItemCareer(arg_18_0._roleViewItem1)
	arg_18_0:_refreshRoleViewItemCareer(arg_18_0._roleViewItem2)
end

function var_0_0._refreshRoleViewItemCareer(arg_19_0, arg_19_1)
	if RoomCharacterPlaceListModel.instance:isFilterCareerEmpty() then
		arg_19_1.dropClassify:SetValue(0)
	else
		for iter_19_0 = 1, 6 do
			if RoomCharacterPlaceListModel.instance:isFilterCareer(iter_19_0) then
				arg_19_1.dropClassify:SetValue(iter_19_0)

				break
			end
		end
	end
end

function var_0_0._roleViewItemOnDestroy(arg_20_0, arg_20_1)
	arg_20_0:_sortItemOnDestroy(arg_20_1.sortRareItem)
	arg_20_0:_sortItemOnDestroy(arg_20_1.sortFaithItem)
	arg_20_1.dropClassify:RemoveOnValueChanged()
	arg_20_1.dropClassifyClick:RemoveClickListener()
end

function var_0_0._initSortItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_1.btnsort = gohelper.findChildButtonWithAudio(arg_21_2, "")
	arg_21_1.go1 = gohelper.findChild(arg_21_2, "btn1")
	arg_21_1.go2 = gohelper.findChild(arg_21_2, "btn2")
	arg_21_1.goarrow = gohelper.findChild(arg_21_2, "btn2/arrow")
	arg_21_1.orderUp = arg_21_3
	arg_21_1.orderDown = arg_21_4

	arg_21_1.btnsort:AddClickListener(arg_21_0._btnsortOnClick, arg_21_0, arg_21_1)
end

function var_0_0._btnsortOnClick(arg_22_0, arg_22_1)
	if RoomCharacterPlaceListModel.instance:getOrder() == arg_22_1.orderDown then
		RoomCharacterPlaceListModel.instance:setOrder(arg_22_1.orderUp)
	else
		RoomCharacterPlaceListModel.instance:setOrder(arg_22_1.orderDown)
	end

	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	arg_22_0:_refreshSort()
end

function var_0_0._setSort(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 then
		gohelper.setActive(arg_23_1.go1, false)
		gohelper.setActive(arg_23_1.go2, true)
		arg_23_0:_setReverse(arg_23_1.goarrow.transform, arg_23_3)
	else
		gohelper.setActive(arg_23_1.go1, true)
		gohelper.setActive(arg_23_1.go2, false)
	end
end

function var_0_0._setReverse(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0, var_24_1, var_24_2 = transformhelper.getLocalScale(arg_24_1)

	if arg_24_2 then
		transformhelper.setLocalScale(arg_24_1, var_24_0, -math.abs(var_24_1), var_24_2)
	else
		transformhelper.setLocalScale(arg_24_1, var_24_0, math.abs(var_24_1), var_24_2)
	end
end

function var_0_0._sortItemOnDestroy(arg_25_0, arg_25_1)
	arg_25_1.btnsort:RemoveClickListener()
end

function var_0_0._refreshSort(arg_26_0)
	arg_26_0:_refreshRoleViewItemSort(arg_26_0._roleViewItem1)
	arg_26_0:_refreshRoleViewItemSort(arg_26_0._roleViewItem2)
end

function var_0_0._refreshRoleViewItemSort(arg_27_0, arg_27_1)
	arg_27_0:_refreshSortItemSort(arg_27_1.sortRareItem)
	arg_27_0:_refreshSortItemSort(arg_27_1.sortFaithItem)
end

function var_0_0._refreshSortItemSort(arg_28_0, arg_28_1)
	local var_28_0 = RoomCharacterPlaceListModel.instance:getOrder()

	arg_28_0:_setSort(arg_28_1, var_28_0 == arg_28_1.orderUp or var_28_0 == arg_28_1.orderDown, var_28_0 == arg_28_1.orderUp)
end

function var_0_0._refreshBirthdayFilter(arg_29_0)
	local var_29_0 = RoomCharacterPlaceListModel.instance:getIsFilterOnBirthday()

	gohelper.setActive(arg_29_0._birthdayFilterBtn1.goselect, var_29_0)
	gohelper.setActive(arg_29_0._birthdayFilterBtn2.goselect, var_29_0)
	gohelper.setActive(arg_29_0._birthdayFilterBtn1.gonormal, not var_29_0)
	gohelper.setActive(arg_29_0._birthdayFilterBtn2.gonormal, not var_29_0)
end

function var_0_0._addBtnAudio(arg_30_0)
	gohelper.addUIClickAudio(arg_30_0._btnunfold.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(arg_30_0._btnfold.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0._onEscape(arg_31_0)
	arg_31_0:_btncloseviewOnClick()
end

function var_0_0._clientPlaceCharacter(arg_32_0)
	return
end

function var_0_0._onListDragBeginListener(arg_33_0, arg_33_1)
	arg_33_0._scrollRect:OnBeginDrag(arg_33_1)
end

function var_0_0._onListDragListener(arg_34_0, arg_34_1)
	arg_34_0._scrollRect:OnDrag(arg_34_1)
end

function var_0_0._onListDragEndListener(arg_35_0, arg_35_1)
	arg_35_0._scrollRect:OnEndDrag(arg_35_1)
end

function var_0_0.onOpen(arg_36_0)
	arg_36_0:_setCramerFoucs(false)
	arg_36_0:_fold()
	arg_36_0._animator:Play(UIAnimationName.Open, 0, 0)
	arg_36_0:_refreshSort()
	arg_36_0:_refreshCareer()
	arg_36_0:_addBtnAudio()
	arg_36_0:_refreshBirthdayFilter()
	NavigateMgr.instance:addEscape(ViewName.RoomCharacterPlaceView, arg_36_0._onEscape, arg_36_0)
	arg_36_0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceCharacter, arg_36_0._clientPlaceCharacter, arg_36_0)
	arg_36_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListOnDragBeginListener, arg_36_0._onListDragBeginListener, arg_36_0)
	arg_36_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListOnDragListener, arg_36_0._onListDragListener, arg_36_0)
	arg_36_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListOnDragEndListener, arg_36_0._onListDragEndListener, arg_36_0)
end

function var_0_0._addAudioToBlock(arg_37_0)
	local var_37_0 = ViewMgr.instance:getUIRoot()
	local var_37_1 = gohelper.findChild(var_37_0, "Blocker")

	if var_37_1 then
		gohelper.addUIClickAudio(var_37_1, AudioEnum.UI.play_ui_callfor_open)
	end
end

function var_0_0._addAudioToToggles(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Toggle), false)

	if var_38_0 then
		local var_38_1 = var_38_0:GetEnumerator()

		while var_38_1:MoveNext() do
			local var_38_2 = var_38_1.Current

			gohelper.addUIClickAudio(var_38_2.gameObject, AudioEnum.UI.play_ui_callfor_open)
		end
	end
end

function var_0_0._checkDropList1Exist(arg_39_0)
	local var_39_0 = arg_39_0._roleViewItem1.dropClassify

	if gohelper.findChild(var_39_0.gameObject, "Dropdown List") then
		if not arg_39_0.dropShow1 then
			transformhelper.setLocalRotation(arg_39_0._goarrowTrs1, 0, 0, 180)

			arg_39_0.dropShow1 = true
		end
	elseif arg_39_0.dropShow1 then
		transformhelper.setLocalRotation(arg_39_0._goarrowTrs1, 0, 0, 0)

		arg_39_0.dropShow1 = false
	end
end

function var_0_0._checkDropList2Exist(arg_40_0)
	local var_40_0 = arg_40_0._roleViewItem2.dropClassify

	if gohelper.findChild(var_40_0.gameObject, "Dropdown List") then
		if not arg_40_0.dropShow2 then
			transformhelper.setLocalRotation(arg_40_0._goarrowTrs2, 0, 0, 0)

			arg_40_0.dropShow2 = true
		end
	elseif arg_40_0.dropShow2 then
		transformhelper.setLocalRotation(arg_40_0._goarrowTrs2, 0, 0, 180)

		arg_40_0.dropShow2 = false
	end
end

function var_0_0.onClose(arg_41_0)
	RoomCharacterController.instance:onCloseRoomCharacterPlaceView()
end

function var_0_0.onDestroyView(arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._checkDropList1Exist, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._checkDropList2Exist, arg_42_0)
	arg_42_0:_roleViewItemOnDestroy(arg_42_0._roleViewItem1)
	arg_42_0:_roleViewItemOnDestroy(arg_42_0._roleViewItem2)
	arg_42_0._birthdayFilterBtn1.btn:RemoveClickListener()
	arg_42_0._birthdayFilterBtn2.btn:RemoveClickListener()
	arg_42_0:_setCramerFoucs(false)
end

return var_0_0
