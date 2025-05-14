module("modules.logic.room.view.interact.RoomInteractBuildingView", package.seeall)

local var_0_0 = class("RoomInteractBuildingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._simagebuildingIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_left/headerInfo/#simage_buildingIcon")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "#go_left/headerInfo/#txt_buildingname")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#go_left/layout/#txt_tips")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "#go_left/layout/hero/#go_heroitem")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_right")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_hero")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_right/#go_hero/#simage_rightbg")
	arg_1_0._scrollhero = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_right/#go_hero/#scroll_hero")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_hero/#go_empty")
	arg_1_0._btnsort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#go_hero/sort/#drop_sort/#btn_sort")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#go_hero/#btn_confirm")
	arg_1_0._btnconfirmgrey = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#go_hero/#btn_confirm_grey")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#go_right/#btn_skip/#image_skip")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/#btn_hide")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsort:AddClickListener(arg_2_0._btnsortOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnconfirmgrey:AddClickListener(arg_2_0._btnconfirmgreyOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsort:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnconfirmgrey:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
end

function var_0_0._btnsortOnClick(arg_4_0)
	local var_4_0 = arg_4_0:_isRareDown() and RoomCharacterEnum.CharacterOrderType.RareUp or RoomCharacterEnum.CharacterOrderType.RareDown
	local var_4_1 = RoomInteractCharacterListModel.instance

	var_4_1:setOrder(var_4_0)
	var_4_1:setCharacterList()
	arg_4_0:_refreshArrowUI()
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	local var_5_0 = RoomCameraController.instance:getRoomScene()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.buildingmgr:getBuildingEntity(arg_5_0._buildingUid)

	if var_5_1 and var_5_1.interactComp then
		RoomStatController.instance:roomInteractBuildingInvite(arg_5_0._interactBuildingMO.config.buildingId, arg_5_0._interactBuildingMO:getHeroIdList())
		var_5_1.interactComp:startInteract()

		arg_5_0._isInteractShow = true

		arg_5_0:_refreshShowHide()

		local var_5_2 = arg_5_0._interactBuildingMO.config.showTime * 0.001

		TaskDispatcher.cancelTask(arg_5_0._onInteractShowtimeFinish, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._onInteractShowtimeFinish, arg_5_0, var_5_2 + 0.1)
	end
end

function var_0_0._btnconfirmgreyOnClick(arg_6_0)
	GameFacade.showToast(ToastEnum.RoomInteractBuildingNoHero)
end

function var_0_0._btnskipOnClick(arg_7_0)
	return
end

function var_0_0._btnhideOnClick(arg_8_0)
	RoomMapController.instance:setUIHide(true)
end

function var_0_0._onValueChanged(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		RoomInteractCharacterListModel.instance:setFilterCareer()
	else
		RoomInteractCharacterListModel.instance:setFilterCareer({
			arg_9_1
		})
	end

	RoomInteractCharacterListModel.instance:setCharacterList()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._selectItemList = {}

	gohelper.setActive(arg_10_0._btnskip, false)
	gohelper.setActive(arg_10_0._goheroitem, false)

	arg_10_0._golayout = gohelper.findChildText(arg_10_0.viewGO, "#go_left/layout")
	arg_10_0._goarrow = gohelper.findChild(arg_10_0.viewGO, "#go_right/#go_hero/sort/#drop_sort/arrow")
	arg_10_0._goarrowTrs = arg_10_0._goarrow.transform
	arg_10_0._dropfilter = gohelper.findChildDropdown(arg_10_0.viewGO, "#go_right/#go_hero/sort/#drop_filter")

	arg_10_0._dropfilter:AddOnValueChanged(arg_10_0._onValueChanged, arg_10_0)

	local var_10_0 = {
		luaLang("all_language_filter_option")
	}

	for iter_10_0 = 1, 6 do
		table.insert(var_10_0, luaLang("career" .. iter_10_0))
	end

	arg_10_0._dropfilter:AddOptions(var_10_0)

	arg_10_0._isInteractShow = false
	arg_10_0._isHidAllUI = false
end

function var_0_0.goBackClose(arg_11_0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return false
	end

	arg_11_0:closeThis()

	return true
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	if arg_13_0.viewContainer then
		arg_13_0:addEventCb(arg_13_0.viewContainer, RoomEvent.InteractBuildingSelectHero, arg_13_0._onSelectHero, arg_13_0)
	end

	arg_13_0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, arg_13_0._refreshShowHide, arg_13_0)
	arg_13_0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, arg_13_0._refreshShowHide, arg_13_0)

	arg_13_0._buildingUid = arg_13_0.viewParam.buildingUid
	arg_13_0._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(arg_13_0._buildingUid)
	arg_13_0._interactBuildingMO = arg_13_0._buildingMO:getInteractMO()

	RoomInteractBuildingModel.instance:setSelectBuildingMO(arg_13_0._buildingMO)
	RoomInteractCharacterListModel.instance:initOrder()
	RoomInteractCharacterListModel.instance:setCharacterList()
	NavigateMgr.instance:addEscape(arg_13_0.viewName, arg_13_0.goBackClose, arg_13_0)
	arg_13_0:_refreshUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.InteractBuildingShowChanged)
end

function var_0_0.onClose(arg_14_0)
	RoomCameraController.instance:resetCameraStateByKey(ViewName.RoomInteractBuildingView)
	RoomMapController.instance:dispatchEvent(RoomEvent.InteractBuildingShowChanged)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._selectItemList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._selectItemList) do
			iter_15_1:onDestroy()
		end

		arg_15_0._selectItemList = nil
	end

	arg_15_0._dropfilter:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_15_0._onInteractShowtimeFinish, arg_15_0)
end

function var_0_0._onSelectHero(arg_16_0, arg_16_1)
	if arg_16_0._isInteractShow == true then
		return
	end

	if arg_16_0._interactBuildingMO:isHasHeroId(arg_16_1) then
		RoomInteractBuildingModel.instance:removeInteractHeroId(arg_16_0._buildingUid, arg_16_1)
	else
		if arg_16_0._interactBuildingMO:isHeroMax() then
			GameFacade.showToast(ToastEnum.RoomInteractBuildingHeroMax)

			return
		end

		RoomInteractBuildingModel.instance:addInteractHeroId(arg_16_0._buildingUid, arg_16_1)
	end

	arg_16_0:_refreshSelectHeroList()
	RoomInteractCharacterListModel.instance:updateCharacterList()
end

function var_0_0._onInteractShowtimeFinish(arg_17_0)
	arg_17_0._isInteractShow = false

	arg_17_0:_refreshShowHide()
end

function var_0_0._refreshShowHide(arg_18_0)
	local var_18_0 = not RoomMapController.instance:isUIHide()

	gohelper.setActive(arg_18_0._golayout, not arg_18_0._isInteractShow and var_18_0)
	gohelper.setActive(arg_18_0._gohero, not arg_18_0._isInteractShow and var_18_0)
	gohelper.setActive(arg_18_0._goleft, var_18_0)
	gohelper.setActive(arg_18_0._goright, var_18_0)
	gohelper.setActive(arg_18_0._goBackBtns, var_18_0)
end

function var_0_0._refreshUI(arg_19_0)
	if arg_19_0._buildingMO then
		arg_19_0._txtbuildingname.text = arg_19_0._buildingMO.config.name
	end

	if arg_19_0._interactBuildingMO then
		arg_19_0._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_interactbuilding_slotnum_txt"), arg_19_0._interactBuildingMO:getHeroMax())
	end

	arg_19_0:_refreshArrowUI()
	arg_19_0:_refreshSelectHeroList()
end

function var_0_0._refreshArrowUI(arg_20_0)
	local var_20_0 = arg_20_0:_isRareDown() and -1 or 1

	transformhelper.setLocalScale(arg_20_0._goarrowTrs, 1, var_20_0, 1)
end

function var_0_0._refreshSelectHeroList(arg_21_0)
	if not arg_21_0._selectItemList then
		return
	end

	local var_21_0 = arg_21_0._interactBuildingMO and arg_21_0._interactBuildingMO:getHeroIdList()
	local var_21_1 = arg_21_0._interactBuildingMO and arg_21_0._interactBuildingMO:getHeroMax() or 0

	for iter_21_0 = 1, var_21_1 do
		local var_21_2 = arg_21_0._selectItemList[iter_21_0]

		if not var_21_2 then
			local var_21_3 = gohelper.cloneInPlace(arg_21_0._goheroitem)

			gohelper.setActive(var_21_3, true)

			var_21_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_3, RoomInteractSelectItem, arg_21_0)
			var_21_2._view = arg_21_0

			table.insert(arg_21_0._selectItemList, var_21_2)
		end

		local var_21_4 = var_21_0[iter_21_0]
		local var_21_5 = var_21_4 and RoomCharacterModel.instance:getCharacterMOById(var_21_4)

		var_21_2:onUpdateMO(var_21_5)
	end

	local var_21_6 = var_21_0 and #var_21_0 > 0

	gohelper.setActive(arg_21_0._btnconfirm, var_21_6)
	gohelper.setActive(arg_21_0._btnconfirmgrey, not var_21_6)
end

function var_0_0._isRareDown(arg_22_0)
	if RoomInteractCharacterListModel.instance:getOrder() == RoomCharacterEnum.CharacterOrderType.RareDown then
		return true
	end

	return false
end

return var_0_0
