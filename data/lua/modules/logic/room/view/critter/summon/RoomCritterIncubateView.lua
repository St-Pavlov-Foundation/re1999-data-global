module("modules.logic.room.view.critter.summon.RoomCritterIncubateView", package.seeall)

local var_0_0 = class("RoomCritterIncubateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/top/#simage_title")
	arg_1_0._gocritter = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critter")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/#go_critter/#simage_rightbg")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critter/#go_empty")
	arg_1_0._scrollcritter = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#go_critter/#scroll_critter")
	arg_1_0._gocritterItem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critter/#scroll_critter/viewport/content/#go_critterItem")
	arg_1_0._btnsort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_critter/sort/#drop_sort/#btn_sort")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_critter/sort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critter/sort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critter/sort/#btn_filter/#go_filter")
	arg_1_0._gocritter1 = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_critter1")
	arg_1_0._btnclickarea1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/middle/#go_critter1/#btn_clickarea1")
	arg_1_0._gocritter2 = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_critter2")
	arg_1_0._btnclickarea2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/middle/#go_critter2/#btn_clickarea2")
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottom/#btn_summon")
	arg_1_0._simagecurrency = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bottom/#btn_summon/currency/#simage_currency")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#btn_summon/currency/#txt_currency")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottom/#btn_overview")
	arg_1_0._imageselect = gohelper.findChildImage(arg_1_0.viewGO, "root/bottom/#image_select")
	arg_1_0._txtselect = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#image_select/#txt_select")
	arg_1_0._imagetips1 = gohelper.findChildImage(arg_1_0.viewGO, "root/bottom/#image_tips1")
	arg_1_0._txttips1 = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#image_tips1/#txt_tips1")
	arg_1_0._imagetips2 = gohelper.findChildImage(arg_1_0.viewGO, "root/bottom/#image_tips2")
	arg_1_0._txttips2 = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#image_tips2/#txt_tips2")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "root/#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsort:AddClickListener(arg_2_0._btnsortOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btnsummon:AddClickListener(arg_2_0._btnsummonOnClick, arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._btnoverviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsort:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btnclickarea1:RemoveClickListener()
	arg_3_0._btnclickarea2:RemoveClickListener()
	arg_3_0._btnsummon:RemoveClickListener()
	arg_3_0._btnoverview:RemoveClickListener()
end

function var_0_0._btnsortOnClick(arg_4_0)
	arg_4_0._curSortWay = not arg_4_0._curSortWay

	CritterIncubateModel.instance:setSortWay(arg_4_0._curSortWay)
	arg_4_0:_setSortWay()
end

function var_0_0._btnfilterOnClick(arg_5_0)
	local var_5_0 = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(var_5_0, arg_5_0.viewName)
end

function var_0_0._btnsummonOnClick(arg_6_0)
	local var_6_0, var_6_1 = CritterIncubateModel.instance:notSummonToast()

	if string.nilorempty(var_6_0) then
		CritterIncubateController.instance:onIncubateCritter()
	else
		GameFacade.showToast(var_6_0, var_6_1)
	end
end

function var_0_0._btnoverviewOnClick(arg_7_0)
	CritterIncubateController.instance:openRoomCritterDetailView()
end

function var_0_0._addEvents(arg_8_0)
	arg_8_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSelectParentCritter, arg_8_0._onSelectParentCritter, arg_8_0)
	arg_8_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onRemoveParentCritter, arg_8_0._onRemoveParentCritter, arg_8_0)
	arg_8_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0._onRefreshBtn, arg_8_0)
	arg_8_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_8_0._onStartSummon, arg_8_0)
	arg_8_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_8_0._onCloseGetCritter, arg_8_0)
	arg_8_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onIncubateCritterPreviewReply, arg_8_0._showPreview, arg_8_0)
	arg_8_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_8_0.onCritterFilterTypeChange, arg_8_0)
end

function var_0_0._removeEvents(arg_9_0)
	arg_9_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSelectParentCritter, arg_9_0._onSelectParentCritter, arg_9_0)
	arg_9_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onRemoveParentCritter, arg_9_0._onRemoveParentCritter, arg_9_0)
	arg_9_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_9_0._onRefreshBtn, arg_9_0)
	arg_9_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_9_0._onStartSummon, arg_9_0)
	arg_9_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onIncubateCritterPreviewReply, arg_9_0._showPreview, arg_9_0)
	arg_9_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_9_0.onCritterFilterTypeChange, arg_9_0)

	if arg_9_0._parentCritterItem then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._parentCritterItem) do
			iter_9_1.btn:RemoveClickListener()
		end
	end

	if arg_9_0._dropSort then
		arg_9_0._dropSort:RemoveOnValueChanged()
	end
end

function var_0_0._onSelectParentCritter(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_refreshParentCritter(arg_10_1, arg_10_2)
end

function var_0_0._onRemoveParentCritter(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:_refreshParentCritter(arg_11_1, arg_11_2)
end

function var_0_0._onStartSummon(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.viewContainer:getContainerViewBuilding()

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
	CritterSummonController.instance:openSummonView(var_12_0, arg_12_1)

	if arg_12_0.root then
		gohelper.setActive(arg_12_0.root, false)
	end
end

function var_0_0._showPreview(arg_13_0)
	local var_13_0, var_13_1 = CritterIncubateModel.instance:getSelectParentCritterCount()

	if var_13_1 <= var_13_0 then
		local var_13_2 = CritterIncubateModel.instance:getChildMOList()
		local var_13_3
		local var_13_4 = {}

		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			local var_13_5 = iter_13_1:getAdditionAttr()

			var_13_3 = var_13_3 or next(var_13_5) ~= nil
		end

		for iter_13_2 = 1, var_13_1 do
			local var_13_6 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(iter_13_2)

			if var_13_6 then
				local var_13_7 = CritterModel.instance:getCritterMOByUid(var_13_6)

				if var_13_7:getIsHighQuality() and not LuaUtil.tableContains(var_13_4, var_13_7:getCatalogueName()) then
					table.insert(var_13_4, var_13_7:getCatalogueName())
				end
			end

			gohelper.setActive(arg_13_0._btnoverview.gameObject, true)
			gohelper.setActive(arg_13_0._imageselect.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(arg_13_0._btnsummon.gameObject, false)
		end

		arg_13_0:_refreshTip(var_13_3, var_13_4)
	end
end

function var_0_0._hidePreview(arg_14_0)
	gohelper.setActive(arg_14_0._btnoverview.gameObject, false)
	gohelper.setActive(arg_14_0._imageselect.gameObject, true)
	ZProj.UGUIHelper.SetGrayscale(arg_14_0._btnsummon.gameObject, true)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._tipItem) do
		gohelper.setActive(iter_14_1.go, false)
	end
end

function var_0_0.onCritterFilterTypeChange(arg_15_0, arg_15_1)
	if arg_15_1 ~= arg_15_0.viewName then
		return
	end

	arg_15_0:refreshCritterList()
end

function var_0_0.refreshCritterList(arg_16_0)
	local var_16_0 = CritterIncubateListModel.instance:setMoList(arg_16_0.filterMO)

	gohelper.setActive(arg_16_0._goEmpty.gameObject, var_16_0 <= 0)
	gohelper.setActive(arg_16_0._scrollcritter.gameObject, var_16_0 > 0)
	arg_16_0:refreshFilterBtn()
end

function var_0_0.refreshFilterBtn(arg_17_0)
	local var_17_0 = arg_17_0.filterMO:isFiltering()

	gohelper.setActive(arg_17_0._gonotfilter, not var_17_0)
	gohelper.setActive(arg_17_0._gofilter, var_17_0)
end

function var_0_0._onCloseGetCritter(arg_18_0)
	if arg_18_0.root then
		gohelper.setActive(arg_18_0.root, true)
	end
end

function var_0_0._editableInitView(arg_19_0)
	arg_19_0._dropSort = gohelper.findChildDropdown(arg_19_0.viewGO, "root/right/#go_critter/sort/#drop_sort")
	arg_19_0._goSortWay = gohelper.findChild(arg_19_0.viewGO, "root/right/#go_critter/sort/#drop_sort/arrow")
	arg_19_0._canvasGroup = arg_19_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_19_0._tipItem = arg_19_0:getUserDataTb_()
	arg_19_0._tipItem = {
		{
			go = arg_19_0._imagetips1.gameObject,
			txt = arg_19_0._txttips1
		},
		{
			go = arg_19_0._imagetips2.gameObject,
			txt = arg_19_0._txttips2
		}
	}
end

function var_0_0.onUpdateParam(arg_20_0)
	return
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:_addEvents()

	arg_21_0.filterMO = CritterFilterModel.instance:generateFilterMO(arg_21_0.viewName)

	arg_21_0:_refreshParentCritter()
	arg_21_0:_initSortFilter()
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:_removeEvents()
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simagecurrency:UnLoadImage()
end

function var_0_0._onRefreshBtn(arg_24_0)
	local var_24_0 = CritterIncubateModel.instance:notSummonToast()
	local var_24_1 = string.nilorempty(var_24_0)

	ZProj.UGUIHelper.SetGrayscale(arg_24_0._btnsummon.gameObject, not var_24_1)

	local var_24_2, var_24_3 = CritterIncubateModel.instance:getPoolCurrency()

	if string.nilorempty(var_24_2) then
		return
	end

	arg_24_0._simagecurrency:LoadImage(var_24_2)

	arg_24_0._txtcurrency.text = var_24_3 or ""
end

function var_0_0._refreshParentCritter(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = CritterIncubateModel.instance:getSelectParentCritterCount()
	local var_25_2 = 0

	if arg_25_1 and arg_25_0:_getParentCritterItem(arg_25_1) then
		arg_25_0:_playParentCritterEffect(arg_25_1)
	end

	for iter_25_0 = 1, var_25_1 do
		local var_25_3 = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(iter_25_0)
		local var_25_4 = arg_25_0:_getParentCritterItem(iter_25_0)

		if var_25_4 then
			if var_25_3 then
				local var_25_5 = CritterModel.instance:getCritterMOByUid(var_25_3)

				if not var_25_4._critterIcon then
					var_25_4._critterIcon = IconMgr.instance:getCommonCritterIcon(var_25_4.icon)
				end

				var_25_4._critterIcon:onUpdateMO(var_25_5)
				var_25_4._critterIcon:hideMood()
				var_25_4._critterIcon:setCustomClick(arg_25_0._onClickParentCritter, arg_25_0, var_25_5)
				gohelper.setActive(var_25_4._critterIcon.viewGO.gameObject, true)

				local var_25_6 = var_25_5:getAdditionAttr()

				var_25_4._critterIcon:showUpTip(next(var_25_6) ~= nil)

				var_25_2 = var_25_2 + 1
			elseif var_25_4._critterIcon then
				gohelper.setActive(var_25_4._critterIcon.viewGO.gameObject, false)
			end
		end
	end

	arg_25_0:_onRefreshBtn()

	if var_25_1 <= var_25_2 then
		CritterIncubateController.instance:onIncubateCritterPreview()
	else
		arg_25_0:_hidePreview()

		arg_25_0._txtselect.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_incubate_select_count"), var_25_2, var_25_1)
	end
end

function var_0_0._refreshTip(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = 1

	if arg_26_1 then
		local var_26_1 = arg_26_0._tipItem[var_26_0]

		var_26_1.txt.text = luaLang("room_critter_incubate_tip_1")

		gohelper.setActive(var_26_1.go, true)

		var_26_0 = var_26_0 + 1
	end

	if LuaUtil.tableNotEmpty(arg_26_2) then
		local var_26_2 = arg_26_0._tipItem[var_26_0]
		local var_26_3 = #arg_26_2

		if var_26_3 == 1 then
			local var_26_4 = luaLang("room_critter_incubate_tip_2")

			var_26_2.txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_26_4, arg_26_2[1])
		elseif var_26_3 == 2 then
			local var_26_5 = luaLang("room_critter_incubate_tip_3")

			var_26_2.txt.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_26_5, arg_26_2[1], arg_26_2[2])
		end

		gohelper.setActive(var_26_2.go, true)

		var_26_0 = var_26_0 + 1
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._tipItem) do
		gohelper.setActive(iter_26_1.go, iter_26_0 < var_26_0)
	end
end

function var_0_0._onClickParentCritter(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.uid

	CritterIncubateModel.instance:removeSelectParentCritter(var_27_0)
end

function var_0_0._getParentCritterItem(arg_28_0, arg_28_1)
	if not arg_28_0._parentCritterItem then
		arg_28_0._parentCritterItem = arg_28_0:getUserDataTb_()
	end

	local var_28_0 = arg_28_0._parentCritterItem[arg_28_1]

	if not var_28_0 then
		var_28_0 = {}

		local var_28_1 = arg_28_0["_gocritter" .. arg_28_1]
		local var_28_2 = arg_28_0["_btnclickarea" .. arg_28_1]

		var_28_0.go = var_28_1
		var_28_0.icon = gohelper.findChild(var_28_1, "go_crittericon")
		var_28_0.btn = var_28_2

		if var_28_0.btn then
			gohelper.setActive(var_28_0.btn.gameObject, false)
		end

		var_28_0.effect = gohelper.findChild(var_28_1, "#add_effect"):GetComponent(typeof(UnityEngine.Animation))

		table.insert(arg_28_0._parentCritterItem, var_28_0)
	end

	return var_28_0
end

function var_0_0._playParentCritterEffect(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_getParentCritterItem(arg_29_1)

	if var_29_0 then
		var_29_0.effect:Stop()
		gohelper.setActive(var_29_0.effect.gameObject, true)
		var_29_0.effect:Play()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_put)
	end
end

function var_0_0._initSortFilter(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(lua_critter_attribute.configList) do
		table.insert(var_30_0, iter_30_1.name)
	end

	arg_30_0._curSelectOpetion = CritterIncubateModel.instance:getSortType()
	arg_30_0._curSortWay = CritterIncubateModel.instance:getSortWay()

	arg_30_0._dropSort:ClearOptions()
	arg_30_0._dropSort:AddOptions(var_30_0)
	arg_30_0._dropSort:AddOnValueChanged(arg_30_0.onDropValueChanged, arg_30_0)
	arg_30_0._dropSort:SetValue(arg_30_0._curSelectOpetion - 1)
	arg_30_0:_setSortWay()
	arg_30_0:refreshCritterList()
end

function var_0_0.onDropValueChanged(arg_31_0, arg_31_1)
	CritterIncubateModel.instance:setSortType(arg_31_1 + 1)
	CritterIncubateListModel.instance:sortMoList(arg_31_0.filterMO)
end

function var_0_0._setSortWay(arg_32_0)
	local var_32_0 = CritterIncubateModel.instance:getSortWay()

	transformhelper.setLocalRotation(arg_32_0._goSortWay.transform, 0, 0, var_32_0 and 180 or 0)
	CritterIncubateListModel.instance:sortMoList(arg_32_0.filterMO)
end

return var_0_0
