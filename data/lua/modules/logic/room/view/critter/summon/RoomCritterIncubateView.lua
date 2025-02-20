module("modules.logic.room.view.critter.summon.RoomCritterIncubateView", package.seeall)

slot0 = class("RoomCritterIncubateView", BaseView)

function slot0.onInitView(slot0)
	slot0.root = gohelper.findChild(slot0.viewGO, "root")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/top/#simage_title")
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "root/right/#go_critter")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#go_critter/#simage_rightbg")
	slot0._goEmpty = gohelper.findChild(slot0.viewGO, "root/right/#go_critter/#go_empty")
	slot0._scrollcritter = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#go_critter/#scroll_critter")
	slot0._gocritterItem = gohelper.findChild(slot0.viewGO, "root/right/#go_critter/#scroll_critter/viewport/content/#go_critterItem")
	slot0._btnsort = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_critter/sort/#drop_sort/#btn_sort")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_critter/sort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "root/right/#go_critter/sort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "root/right/#go_critter/sort/#btn_filter/#go_filter")
	slot0._gocritter1 = gohelper.findChild(slot0.viewGO, "root/middle/#go_critter1")
	slot0._btnclickarea1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/middle/#go_critter1/#btn_clickarea1")
	slot0._gocritter2 = gohelper.findChild(slot0.viewGO, "root/middle/#go_critter2")
	slot0._btnclickarea2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/middle/#go_critter2/#btn_clickarea2")
	slot0._btnsummon = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/bottom/#btn_summon")
	slot0._simagecurrency = gohelper.findChildSingleImage(slot0.viewGO, "root/bottom/#btn_summon/currency/#simage_currency")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "root/bottom/#btn_summon/currency/#txt_currency")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/bottom/#btn_overview")
	slot0._imageselect = gohelper.findChildImage(slot0.viewGO, "root/bottom/#image_select")
	slot0._txtselect = gohelper.findChildText(slot0.viewGO, "root/bottom/#image_select/#txt_select")
	slot0._imagetips1 = gohelper.findChildImage(slot0.viewGO, "root/bottom/#image_tips1")
	slot0._txttips1 = gohelper.findChildText(slot0.viewGO, "root/bottom/#image_tips1/#txt_tips1")
	slot0._imagetips2 = gohelper.findChildImage(slot0.viewGO, "root/bottom/#image_tips2")
	slot0._txttips2 = gohelper.findChildText(slot0.viewGO, "root/bottom/#image_tips2/#txt_tips2")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "root/#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsort:AddClickListener(slot0._btnsortOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btnsummon:AddClickListener(slot0._btnsummonOnClick, slot0)
	slot0._btnoverview:AddClickListener(slot0._btnoverviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsort:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
	slot0._btnclickarea1:RemoveClickListener()
	slot0._btnclickarea2:RemoveClickListener()
	slot0._btnsummon:RemoveClickListener()
	slot0._btnoverview:RemoveClickListener()
end

function slot0._btnsortOnClick(slot0)
	slot0._curSortWay = not slot0._curSortWay

	CritterIncubateModel.instance:setSortWay(slot0._curSortWay)
	slot0:_setSortWay()
end

function slot0._btnfilterOnClick(slot0)
	CritterController.instance:openCritterFilterView({
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}, slot0.viewName)
end

function slot0._btnsummonOnClick(slot0)
	slot1, slot2 = CritterIncubateModel.instance:notSummonToast()

	if string.nilorempty(slot1) then
		CritterIncubateController.instance:onIncubateCritter()
	else
		GameFacade.showToast(slot1, slot2)
	end
end

function slot0._btnoverviewOnClick(slot0)
	CritterIncubateController.instance:openRoomCritterDetailView()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSelectParentCritter, slot0._onSelectParentCritter, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onRemoveParentCritter, slot0._onRemoveParentCritter, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onRefreshBtn, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0._onStartSummon, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0._onCloseGetCritter, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onIncubateCritterPreviewReply, slot0._showPreview, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSelectParentCritter, slot0._onSelectParentCritter, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onRemoveParentCritter, slot0._onRemoveParentCritter, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onRefreshBtn, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0._onStartSummon, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onIncubateCritterPreviewReply, slot0._showPreview, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)

	if slot0._parentCritterItem then
		for slot4, slot5 in pairs(slot0._parentCritterItem) do
			slot5.btn:RemoveClickListener()
		end
	end

	if slot0._dropSort then
		slot0._dropSort:RemoveOnValueChanged()
	end
end

function slot0._onSelectParentCritter(slot0, slot1, slot2)
	slot0:_refreshParentCritter(slot1, slot2)
end

function slot0._onRemoveParentCritter(slot0, slot1, slot2)
	slot0:_refreshParentCritter(slot1, slot2)
end

function slot0._onStartSummon(slot0, slot1)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
	CritterSummonController.instance:openSummonView(slot0.viewContainer:getContainerViewBuilding(), slot1)

	if slot0.root then
		gohelper.setActive(slot0.root, false)
	end
end

function slot0._showPreview(slot0)
	slot1, slot2 = CritterIncubateModel.instance:getSelectParentCritterCount()

	if slot2 <= slot1 then
		slot6 = {}

		for slot10, slot11 in ipairs(CritterIncubateModel.instance:getChildMOList()) do
			slot5 = nil or next(slot11:getAdditionAttr()) ~= nil
		end

		for slot10 = 1, slot2 do
			if CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(slot10) and CritterModel.instance:getCritterMOByUid(slot11):getIsHighQuality() and not LuaUtil.tableContains(slot6, slot12:getCatalogueName()) then
				table.insert(slot6, slot12:getCatalogueName())
			end

			gohelper.setActive(slot0._btnoverview.gameObject, true)
			gohelper.setActive(slot0._imageselect.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon.gameObject, false)
		end

		slot0:_refreshTip(slot5, slot6)
	end
end

function slot0._hidePreview(slot0)
	gohelper.setActive(slot0._btnoverview.gameObject, false)
	gohelper.setActive(slot0._imageselect.gameObject, true)

	slot4 = true

	ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon.gameObject, slot4)

	for slot4, slot5 in ipairs(slot0._tipItem) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0.onCritterFilterTypeChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	slot0:refreshCritterList()
end

function slot0.refreshCritterList(slot0)
	gohelper.setActive(slot0._goEmpty.gameObject, CritterIncubateListModel.instance:setMoList(slot0.filterMO) <= 0)
	gohelper.setActive(slot0._scrollcritter.gameObject, slot1 > 0)
	slot0:refreshFilterBtn()
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMO:isFiltering()

	gohelper.setActive(slot0._gonotfilter, not slot1)
	gohelper.setActive(slot0._gofilter, slot1)
end

function slot0._onCloseGetCritter(slot0)
	if slot0.root then
		gohelper.setActive(slot0.root, true)
	end
end

function slot0._editableInitView(slot0)
	slot0._dropSort = gohelper.findChildDropdown(slot0.viewGO, "root/right/#go_critter/sort/#drop_sort")
	slot0._goSortWay = gohelper.findChild(slot0.viewGO, "root/right/#go_critter/sort/#drop_sort/arrow")
	slot0._canvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._tipItem = slot0:getUserDataTb_()
	slot0._tipItem = {
		{
			go = slot0._imagetips1.gameObject,
			txt = slot0._txttips1
		},
		{
			go = slot0._imagetips2.gameObject,
			txt = slot0._txttips2
		}
	}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(slot0.viewName)

	slot0:_refreshParentCritter()
	slot0:_initSortFilter()
end

function slot0.onClose(slot0)
	slot0:_removeEvents()
end

function slot0.onDestroyView(slot0)
	slot0._simagecurrency:UnLoadImage()
end

function slot0._onRefreshBtn(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon.gameObject, not string.nilorempty(CritterIncubateModel.instance:notSummonToast()))

	slot3, slot4 = CritterIncubateModel.instance:getPoolCurrency()

	if string.nilorempty(slot3) then
		return
	end

	slot0._simagecurrency:LoadImage(slot3)

	slot0._txtcurrency.text = slot4 or ""
end

function slot0._refreshParentCritter(slot0, slot1, slot2)
	slot3, slot4 = CritterIncubateModel.instance:getSelectParentCritterCount()
	slot5 = 0

	if slot1 and slot0:_getParentCritterItem(slot1) then
		slot0:_playParentCritterEffect(slot1)
	end

	for slot9 = 1, slot4 do
		slot10 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(slot9)

		if slot0:_getParentCritterItem(slot9) then
			if slot10 then
				slot12 = CritterModel.instance:getCritterMOByUid(slot10)

				if not slot11._critterIcon then
					slot11._critterIcon = IconMgr.instance:getCommonCritterIcon(slot11.icon)
				end

				slot11._critterIcon:onUpdateMO(slot12)
				slot11._critterIcon:hideMood()
				slot11._critterIcon:setCustomClick(slot0._onClickParentCritter, slot0, slot12)
				gohelper.setActive(slot11._critterIcon.viewGO.gameObject, true)
				slot11._critterIcon:showUpTip(next(slot12:getAdditionAttr()) ~= nil)

				slot5 = slot5 + 1
			elseif slot11._critterIcon then
				gohelper.setActive(slot11._critterIcon.viewGO.gameObject, false)
			end
		end
	end

	slot0:_onRefreshBtn()

	if slot4 <= slot5 then
		CritterIncubateController.instance:onIncubateCritterPreview()
	else
		slot0:_hidePreview()

		slot0._txtselect.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_incubate_select_count"), slot5, slot4)
	end
end

function slot0._refreshTip(slot0, slot1, slot2)
	slot3 = 1

	if slot1 then
		slot4 = slot0._tipItem[slot3]
		slot4.txt.text = luaLang("room_critter_incubate_tip_1")

		gohelper.setActive(slot4.go, true)

		slot3 = slot3 + 1
	end

	if LuaUtil.tableNotEmpty(slot2) then
		if #slot2 == 1 then
			slot0._tipItem[slot3].txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_critter_incubate_tip_2"), slot2[1])
		elseif slot5 == 2 then
			slot4.txt.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_incubate_tip_3"), slot2[1], slot2[2])
		end

		gohelper.setActive(slot4.go, true)

		slot3 = slot3 + 1
	end

	for slot7, slot8 in ipairs(slot0._tipItem) do
		gohelper.setActive(slot8.go, slot7 < slot3)
	end
end

function slot0._onClickParentCritter(slot0, slot1)
	CritterIncubateModel.instance:removeSelectParentCritter(slot1.uid)
end

function slot0._getParentCritterItem(slot0, slot1)
	if not slot0._parentCritterItem then
		slot0._parentCritterItem = slot0:getUserDataTb_()
	end

	if not slot0._parentCritterItem[slot1] then
		slot3 = slot0["_gocritter" .. slot1]

		if ({
			go = slot3,
			icon = gohelper.findChild(slot3, "go_crittericon"),
			btn = slot0["_btnclickarea" .. slot1]
		}).btn then
			gohelper.setActive(slot2.btn.gameObject, false)
		end

		slot2.effect = gohelper.findChild(slot3, "#add_effect"):GetComponent(typeof(UnityEngine.Animation))

		table.insert(slot0._parentCritterItem, slot2)
	end

	return slot2
end

function slot0._playParentCritterEffect(slot0, slot1)
	if slot0:_getParentCritterItem(slot1) then
		slot2.effect:Stop()
		gohelper.setActive(slot2.effect.gameObject, true)
		slot2.effect:Play()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_put)
	end
end

function slot0._initSortFilter(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_critter_attribute.configList) do
		table.insert(slot1, slot6.name)
	end

	slot0._curSelectOpetion = CritterIncubateModel.instance:getSortType()
	slot0._curSortWay = CritterIncubateModel.instance:getSortWay()

	slot0._dropSort:ClearOptions()
	slot0._dropSort:AddOptions(slot1)
	slot0._dropSort:AddOnValueChanged(slot0.onDropValueChanged, slot0)
	slot0._dropSort:SetValue(slot0._curSelectOpetion - 1)
	slot0:_setSortWay()
	slot0:refreshCritterList()
end

function slot0.onDropValueChanged(slot0, slot1)
	CritterIncubateModel.instance:setSortType(slot1 + 1)
	CritterIncubateListModel.instance:sortMoList(slot0.filterMO)
end

function slot0._setSortWay(slot0)
	transformhelper.setLocalRotation(slot0._goSortWay.transform, 0, 0, CritterIncubateModel.instance:getSortWay() and 180 or 0)
	CritterIncubateListModel.instance:sortMoList(slot0.filterMO)
end

return slot0
