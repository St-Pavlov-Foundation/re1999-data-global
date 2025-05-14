module("modules.logic.room.view.RoomBlockPackageView", package.seeall)

local var_0_0 = class("RoomBlockPackageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._godetailedItem = gohelper.findChild(arg_1_0.viewGO, "middle/cloneItem/#go_detailedItem")
	arg_1_0._gosimpleItem = gohelper.findChild(arg_1_0.viewGO, "middle/cloneItem/#go_simpleItem")
	arg_1_0._scrolldetailed = gohelper.findChildScrollRect(arg_1_0.viewGO, "middle/#scroll_detailed")
	arg_1_0._scrollsimple = gohelper.findChildScrollRect(arg_1_0.viewGO, "middle/#scroll_simple")
	arg_1_0._btnnumber = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/left/#btn_number")
	arg_1_0._btnrare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/left/#btn_rare")
	arg_1_0._btntheme = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/left/#btn_theme")
	arg_1_0._btndetailed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#btn_detailed")
	arg_1_0._btnsimple = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#btn_simple")
	arg_1_0._gonavigatebuttonscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_navigatebuttonscontainer")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnnumber:AddClickListener(arg_2_0._btnnumberOnClick, arg_2_0)
	arg_2_0._btnrare:AddClickListener(arg_2_0._btnrareOnClick, arg_2_0)
	arg_2_0._btndetailed:AddClickListener(arg_2_0._btndetailedOnClick, arg_2_0)
	arg_2_0._btnsimple:AddClickListener(arg_2_0._btnsimpleOnClick, arg_2_0)
	arg_2_0._btntheme:AddClickListener(arg_2_0._btnthemeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnumber:RemoveClickListener()
	arg_3_0._btnrare:RemoveClickListener()
	arg_3_0._btndetailed:RemoveClickListener()
	arg_3_0._btnsimple:RemoveClickListener()
	arg_3_0._btntheme:RemoveClickListener()
end

function var_0_0._btnthemeOnClick(arg_4_0)
	RoomController.instance:openThemeFilterView(false)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnrareOnClick(arg_6_0)
	arg_6_0:_setSortRate(true)
end

function var_0_0._btnnumberOnClick(arg_7_0)
	arg_7_0:_setSortRate(false)
end

function var_0_0._btndetailedOnClick(arg_8_0)
	if arg_8_0._isDetailed ~= true then
		arg_8_0:_toFirsePage(true)
	end
end

function var_0_0._btnsimpleOnClick(arg_9_0)
	if arg_9_0._isDetailed ~= false then
		arg_9_0:_toFirsePage(false)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._selectPackageId = nil
	arg_10_0._isDetailed = true

	local var_10_0 = {
		arg_10_0._btnrare.gameObject,
		arg_10_0._btnnumber.gameObject
	}

	arg_10_0._stateInfoGos = {}

	for iter_10_0 = 1, #var_10_0 do
		local var_10_1 = var_10_0[iter_10_0]
		local var_10_2 = {
			normalGO = gohelper.findChild(var_10_1, "go_normal"),
			selectGO = gohelper.findChild(var_10_1, "go_select"),
			arrowGO = gohelper.findChild(var_10_1, "go_select/txt/go_arrow")
		}

		table.insert(arg_10_0._stateInfoGos, var_10_2)
	end

	arg_10_0._gothemeSelect = gohelper.findChild(arg_10_0.viewGO, "top/left/#btn_theme/go_select")
	arg_10_0._gothemeUnSelect = gohelper.findChild(arg_10_0.viewGO, "top/left/#btn_theme/go_unselect")

	gohelper.setActive(arg_10_0._gosimpleItem, false)
	gohelper.setActive(arg_10_0._godetailedItem, false)
	gohelper.setActive(arg_10_0._gopageItem, false)
	arg_10_0:_setDetailed(true)
	gohelper.addUIClickAudio(arg_10_0._btnclose.gameObject, AudioEnum.UI.UI_Team_close)
end

function var_0_0._setSortRate(arg_11_0, arg_11_1)
	if arg_11_0._isSortOrder ~= nil and arg_11_0._isSortRate == arg_11_1 then
		arg_11_0._isSortOrder = arg_11_0._isSortOrder == false
	else
		arg_11_0._isSortOrder = false
	end

	arg_11_0._isSortRate = arg_11_1

	local var_11_0 = arg_11_0._isSortRate and 1 or 2

	for iter_11_0 = 1, #arg_11_0._stateInfoGos do
		local var_11_1 = iter_11_0 == var_11_0
		local var_11_2 = arg_11_0._stateInfoGos[iter_11_0]

		gohelper.setActive(var_11_2.selectGO, var_11_1 == true)
		gohelper.setActive(var_11_2.normalGO, var_11_1 == false)

		if var_11_1 then
			transformhelper.setLocalScale(var_11_2.arrowGO.transform, 1, arg_11_0._isSortOrder and -1 or 1, 1)
		end
	end

	arg_11_0:_sortPackageIds()
	arg_11_0:_toFirsePage()
end

function var_0_0._setDetailed(arg_12_0, arg_12_1)
	arg_12_0._isDetailed = arg_12_1 and true or false

	gohelper.setActive(arg_12_0._scrollsimple.gameObject, arg_12_0._isDetailed == false)
	gohelper.setActive(arg_12_0._btndetailed.gameObject, arg_12_0._isDetailed == false)
	gohelper.setActive(arg_12_0._scrolldetailed.gameObject, arg_12_0._isDetailed == true)
	gohelper.setActive(arg_12_0._btnsimple.gameObject, arg_12_0._isDetailed == true)
end

function var_0_0._toFirsePage(arg_13_0, arg_13_1)
	if arg_13_1 ~= nil then
		arg_13_0:_setDetailed(arg_13_1)
	end

	if arg_13_0._isDetailed then
		arg_13_0._scrolldetailed.horizontalNormalizedPosition = 0
	else
		arg_13_0._scrollsimple.verticalNormalizedPosition = 1
	end
end

function var_0_0._sortPackageIds(arg_14_0)
	RoomShowBlockPackageListModel.instance:setSortParam(arg_14_0._isSortRate, arg_14_0._isSortOrder)
end

function var_0_0._refreshItemListUI(arg_15_0)
	return
end

function var_0_0._onSelectBlockPackage(arg_16_0, arg_16_1)
	arg_16_0._selectPackageId = arg_16_1

	RoomShowBlockPackageListModel.instance:setSelect(arg_16_0._selectPackageId)

	if arg_16_0._selectPackageId and arg_16_0._selectPackageId ~= arg_16_0:_getCurUsePacageId() then
		RoomInventoryBlockModel.instance:setSelectBlockPackageIds({
			arg_16_0._selectPackageId
		})
		RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmSelectBlockPackage)
	end
end

function var_0_0._onThemeFilterChanged(arg_17_0)
	RoomShowBlockPackageListModel.instance:setShowBlockList()
	RoomShowBlockPackageListModel.instance:setSelect(arg_17_0._selectPackageId)
	arg_17_0:_refreshFilterState()
end

function var_0_0._refreshFilterState(arg_18_0)
	local var_18_0 = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if arg_18_0._isLastThemeOpen ~= var_18_0 then
		arg_18_0._isLastThemeOpen = var_18_0

		gohelper.setActive(arg_18_0._gothemeUnSelect, not var_18_0)
		gohelper.setActive(arg_18_0._gothemeSelect, var_18_0)
	end
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:addEventCb(RoomMapController.instance, RoomEvent.SelectBlockPackage, arg_20_0._onSelectBlockPackage, arg_20_0)
	arg_20_0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_20_0._onThemeFilterChanged, arg_20_0)

	arg_20_0._selectPackageId = arg_20_0:_getCurUsePacageId()

	RoomShowBlockPackageListModel.instance:initShow(arg_20_0._selectPackageId)
	RoomShowBlockPackageListModel.instance:setSelect(arg_20_0._selectPackageId)
	arg_20_0:_setSortRate(true)
	arg_20_0:_refreshFilterState()
end

function var_0_0.onClickModalMask(arg_21_0)
	arg_21_0:closeThis()
end

function var_0_0._getCurUsePacageId(arg_22_0)
	local var_22_0 = RoomInventoryBlockModel.instance:getCurPackageMO()

	return var_22_0 and var_22_0.id or nil
end

return var_0_0
