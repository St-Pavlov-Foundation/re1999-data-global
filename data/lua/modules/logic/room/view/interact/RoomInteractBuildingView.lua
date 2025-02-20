module("modules.logic.room.view.interact.RoomInteractBuildingView", package.seeall)

slot0 = class("RoomInteractBuildingView", BaseView)

function slot0.onInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._simagebuildingIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_left/headerInfo/#simage_buildingIcon")
	slot0._txtbuildingname = gohelper.findChildText(slot0.viewGO, "#go_left/headerInfo/#txt_buildingname")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_left/layout/#txt_tips")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "#go_left/layout/hero/#go_heroitem")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_right")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#go_right/#go_hero")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_right/#go_hero/#simage_rightbg")
	slot0._scrollhero = gohelper.findChildScrollRect(slot0.viewGO, "#go_right/#go_hero/#scroll_hero")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_right/#go_hero/#go_empty")
	slot0._btnsort = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#go_hero/sort/#drop_sort/#btn_sort")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#go_hero/#btn_confirm")
	slot0._btnconfirmgrey = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#go_hero/#btn_confirm_grey")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#go_right/#btn_skip/#image_skip")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#btn_hide")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsort:AddClickListener(slot0._btnsortOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnconfirmgrey:AddClickListener(slot0._btnconfirmgreyOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsort:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnconfirmgrey:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0._btnhide:RemoveClickListener()
end

function slot0._btnsortOnClick(slot0)
	slot2 = RoomInteractCharacterListModel.instance

	slot2:setOrder(slot0:_isRareDown() and RoomCharacterEnum.CharacterOrderType.RareUp or RoomCharacterEnum.CharacterOrderType.RareDown)
	slot2:setCharacterList()
	slot0:_refreshArrowUI()
end

function slot0._btnconfirmOnClick(slot0)
	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	if slot1.buildingmgr:getBuildingEntity(slot0._buildingUid) and slot2.interactComp then
		RoomStatController.instance:roomInteractBuildingInvite(slot0._interactBuildingMO.config.buildingId, slot0._interactBuildingMO:getHeroIdList())
		slot2.interactComp:startInteract()

		slot0._isInteractShow = true

		slot0:_refreshShowHide()
		TaskDispatcher.cancelTask(slot0._onInteractShowtimeFinish, slot0)
		TaskDispatcher.runDelay(slot0._onInteractShowtimeFinish, slot0, slot0._interactBuildingMO.config.showTime * 0.001 + 0.1)
	end
end

function slot0._btnconfirmgreyOnClick(slot0)
	GameFacade.showToast(ToastEnum.RoomInteractBuildingNoHero)
end

function slot0._btnskipOnClick(slot0)
end

function slot0._btnhideOnClick(slot0)
	RoomMapController.instance:setUIHide(true)
end

function slot0._onValueChanged(slot0, slot1)
	if slot1 == 0 then
		RoomInteractCharacterListModel.instance:setFilterCareer()
	else
		RoomInteractCharacterListModel.instance:setFilterCareer({
			slot1
		})
	end

	RoomInteractCharacterListModel.instance:setCharacterList()
end

function slot0._editableInitView(slot0)
	slot0._selectItemList = {}

	gohelper.setActive(slot0._btnskip, false)
	gohelper.setActive(slot0._goheroitem, false)

	slot0._golayout = gohelper.findChildText(slot0.viewGO, "#go_left/layout")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_right/#go_hero/sort/#drop_sort/arrow")
	slot0._goarrowTrs = slot0._goarrow.transform
	slot0._dropfilter = gohelper.findChildDropdown(slot0.viewGO, "#go_right/#go_hero/sort/#drop_filter")
	slot5 = slot0

	slot0._dropfilter:AddOnValueChanged(slot0._onValueChanged, slot5)

	slot1 = {
		luaLang("all_language_filter_option")
	}

	for slot5 = 1, 6 do
		table.insert(slot1, luaLang("career" .. slot5))
	end

	slot0._dropfilter:AddOptions(slot1)

	slot0._isInteractShow = false
	slot0._isHidAllUI = false
end

function slot0.goBackClose(slot0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return false
	end

	slot0:closeThis()

	return true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, RoomEvent.InteractBuildingSelectHero, slot0._onSelectHero, slot0)
	end

	slot0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, slot0._refreshShowHide, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, slot0._refreshShowHide, slot0)

	slot0._buildingUid = slot0.viewParam.buildingUid
	slot0._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid)
	slot0._interactBuildingMO = slot0._buildingMO:getInteractMO()

	RoomInteractBuildingModel.instance:setSelectBuildingMO(slot0._buildingMO)
	RoomInteractCharacterListModel.instance:initOrder()
	RoomInteractCharacterListModel.instance:setCharacterList()
	NavigateMgr.instance:addEscape(slot0.viewName, slot0.goBackClose, slot0)
	slot0:_refreshUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.InteractBuildingShowChanged)
end

function slot0.onClose(slot0)
	RoomCameraController.instance:resetCameraStateByKey(ViewName.RoomInteractBuildingView)
	RoomMapController.instance:dispatchEvent(RoomEvent.InteractBuildingShowChanged)
end

function slot0.onDestroyView(slot0)
	if slot0._selectItemList then
		for slot4, slot5 in ipairs(slot0._selectItemList) do
			slot5:onDestroy()
		end

		slot0._selectItemList = nil
	end

	slot0._dropfilter:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0._onInteractShowtimeFinish, slot0)
end

function slot0._onSelectHero(slot0, slot1)
	if slot0._isInteractShow == true then
		return
	end

	if slot0._interactBuildingMO:isHasHeroId(slot1) then
		RoomInteractBuildingModel.instance:removeInteractHeroId(slot0._buildingUid, slot1)
	else
		if slot0._interactBuildingMO:isHeroMax() then
			GameFacade.showToast(ToastEnum.RoomInteractBuildingHeroMax)

			return
		end

		RoomInteractBuildingModel.instance:addInteractHeroId(slot0._buildingUid, slot1)
	end

	slot0:_refreshSelectHeroList()
	RoomInteractCharacterListModel.instance:updateCharacterList()
end

function slot0._onInteractShowtimeFinish(slot0)
	slot0._isInteractShow = false

	slot0:_refreshShowHide()
end

function slot0._refreshShowHide(slot0)
	slot1 = not RoomMapController.instance:isUIHide()

	gohelper.setActive(slot0._golayout, not slot0._isInteractShow and slot1)
	gohelper.setActive(slot0._gohero, not slot0._isInteractShow and slot1)
	gohelper.setActive(slot0._goleft, slot1)
	gohelper.setActive(slot0._goright, slot1)
	gohelper.setActive(slot0._goBackBtns, slot1)
end

function slot0._refreshUI(slot0)
	if slot0._buildingMO then
		slot0._txtbuildingname.text = slot0._buildingMO.config.name
	end

	if slot0._interactBuildingMO then
		slot0._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_interactbuilding_slotnum_txt"), slot0._interactBuildingMO:getHeroMax())
	end

	slot0:_refreshArrowUI()
	slot0:_refreshSelectHeroList()
end

function slot0._refreshArrowUI(slot0)
	transformhelper.setLocalScale(slot0._goarrowTrs, 1, slot0:_isRareDown() and -1 or 1, 1)
end

function slot0._refreshSelectHeroList(slot0)
	if not slot0._selectItemList then
		return
	end

	slot1 = slot0._interactBuildingMO and slot0._interactBuildingMO:getHeroIdList()

	for slot6 = 1, slot0._interactBuildingMO and slot0._interactBuildingMO:getHeroMax() or 0 do
		if not slot0._selectItemList[slot6] then
			slot8 = gohelper.cloneInPlace(slot0._goheroitem)

			gohelper.setActive(slot8, true)

			slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot8, RoomInteractSelectItem, slot0)
			slot7._view = slot0

			table.insert(slot0._selectItemList, slot7)
		end

		slot7:onUpdateMO(slot1[slot6] and RoomCharacterModel.instance:getCharacterMOById(slot8))
	end

	slot3 = slot1 and #slot1 > 0

	gohelper.setActive(slot0._btnconfirm, slot3)
	gohelper.setActive(slot0._btnconfirmgrey, not slot3)
end

function slot0._isRareDown(slot0)
	if RoomInteractCharacterListModel.instance:getOrder() == RoomCharacterEnum.CharacterOrderType.RareDown then
		return true
	end

	return false
end

return slot0
