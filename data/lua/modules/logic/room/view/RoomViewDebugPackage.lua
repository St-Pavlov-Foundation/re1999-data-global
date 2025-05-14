module("modules.logic.room.view.RoomViewDebugPackage", package.seeall)

local var_0_0 = class("RoomViewDebugPackage", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnpackageidOnClick(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._packageIdItemList[arg_4_1]

	RoomDebugPackageListModel.instance:setFilterPackageId(var_4_0.packageId)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugPackageListModel.instance:clearSelect()
	arg_4_0:_refreshPackageId()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageFilterChanged)

	arg_4_0._scrolldebugpackage.horizontalNormalizedPosition = 0
end

function var_0_0._btnmainresOnClick(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._mainResItemList[arg_5_1]

	RoomDebugPackageListModel.instance:setFilterMainRes(var_5_0.resourceId >= 0 and var_5_0.resourceId or nil)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugPackageListModel.instance:clearSelect()
	arg_5_0:_refreshMainRes()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageFilterChanged)

	arg_5_0._scrolldebugpackage.horizontalNormalizedPosition = 0
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._godebugpackage = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugpackage")
	arg_6_0._btnclose = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_close")
	arg_6_0._gopackageiditem = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugpackage/filterpackageid/viewport/content/go_packageiditem")
	arg_6_0._gomainresitem = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugpackage/filtermainres/go_mainresitem")
	arg_6_0._scrolldebugpackage = gohelper.findChildScrollRect(arg_6_0.viewGO, "go_normalroot/go_debugpackage/scroll_debugpackage")
	arg_6_0._btnpackageidmode = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_packageidmode")
	arg_6_0._goselectpackageidmode = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_packageidmode/go_selectpackageidmode")
	arg_6_0._btnpackageordermode = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_packageordermode")
	arg_6_0._goselectpackageordermode = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_packageordermode/go_selectpackageordermode")
	arg_6_0._btnthemfilter = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_themfilter")
	arg_6_0._goselectthemfilter = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugpackage/btn_themfilter/go_selectthemfilter")

	arg_6_0._btnclose:AddClickListener(arg_6_0._btncloseOnClick, arg_6_0)
	arg_6_0._btnpackageidmode:AddClickListener(arg_6_0._btnpackageidmodeOnClick, arg_6_0)
	arg_6_0._btnpackageordermode:AddClickListener(arg_6_0._btnpackageordermodeOnClick, arg_6_0)
	arg_6_0._btnthemfilter:AddClickListener(arg_6_0._btnthemfilterOnClick, arg_6_0)

	arg_6_0._isShowDebugPackage = false

	gohelper.setActive(arg_6_0._godebugpackage, false)

	arg_6_0._packageIdItemList = {}
	arg_6_0._mainResItemList = {}

	gohelper.setActive(arg_6_0._gopackageiditem, false)
	gohelper.setActive(arg_6_0._gomainresitem, false)
	gohelper.setActive(arg_6_0._goselectthemfilter, false)
	arg_6_0:_initPackageId()
	arg_6_0:_initMainRes()

	arg_6_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0._btncloseOnClick(arg_7_0)
	RoomDebugController.instance:setDebugPackageListShow(false)
end

function var_0_0._btnpackageidmodeOnClick(arg_8_0)
	RoomDebugController.instance:setEditPackageOrder(false)
	arg_8_0:_refreshPackageMode()
end

function var_0_0._btnpackageordermodeOnClick(arg_9_0)
	RoomDebugController.instance:setEditPackageOrder(true)
	arg_9_0:_refreshPackageMode()
end

function var_0_0._btnthemfilterOnClick(arg_10_0)
	ViewMgr.instance:openView(ViewName.RoomDebugThemeFilterView)
end

function var_0_0._refreshPackageMode(arg_11_0)
	local var_11_0 = RoomDebugController.instance:isEditPackageOrder()

	gohelper.setActive(arg_11_0._goselectpackageidmode, not var_11_0)
	gohelper.setActive(arg_11_0._goselectpackageordermode, var_11_0)
end

function var_0_0._refreshUI(arg_12_0)
	arg_12_0:_refreshPackageId()
	arg_12_0:_refreshMainRes()
	arg_12_0:_refreshPackageMode()
end

function var_0_0._initPackageId(arg_13_0)
	local var_13_0 = lua_block_package.configList

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.id < arg_14_1.id
	end)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0._packageIdItemList[iter_13_0]

		if not var_13_1 then
			var_13_1 = arg_13_0:getUserDataTb_()
			var_13_1.index = iter_13_0
			var_13_1.go = gohelper.cloneInPlace(arg_13_0._gopackageiditem, "item" .. iter_13_0)
			var_13_1.gobeselect = gohelper.findChild(var_13_1.go, "go_beselect")
			var_13_1.gounselect = gohelper.findChild(var_13_1.go, "go_unselect")
			var_13_1.txtbeselectname = gohelper.findChildText(var_13_1.go, "go_beselect/txt_name")
			var_13_1.txtunselectname = gohelper.findChildText(var_13_1.go, "go_unselect/txt_name")
			var_13_1.btnclick = gohelper.findChildButtonWithAudio(var_13_1.go, "btn_click")

			var_13_1.btnclick:AddClickListener(arg_13_0._btnpackageidOnClick, arg_13_0, var_13_1.index)
			table.insert(arg_13_0._packageIdItemList, var_13_1)
		end

		var_13_1.packageId = iter_13_1.id
		var_13_1.txtbeselectname.text = iter_13_1.name
		var_13_1.txtunselectname.text = iter_13_1.name

		gohelper.setActive(var_13_1.go, true)
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0._packageIdItemList do
		local var_13_2 = arg_13_0._packageIdItemList[iter_13_2]

		gohelper.setActive(var_13_2.go, false)
	end

	arg_13_0:_refreshPackageId()
end

function var_0_0._refreshPackageId(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._packageIdItemList) do
		gohelper.setActive(iter_15_1.gobeselect, RoomDebugPackageListModel.instance:isFilterPackageId(iter_15_1.packageId))
		gohelper.setActive(iter_15_1.gounselect, not RoomDebugPackageListModel.instance:isFilterPackageId(iter_15_1.packageId))
	end
end

function var_0_0._initMainRes(arg_16_0)
	local var_16_0 = {}

	table.insert(var_16_0, -1)

	for iter_16_0, iter_16_1 in pairs(RoomResourceEnum.ResourceId) do
		if iter_16_1 >= 0 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0 < arg_17_1
	end)

	for iter_16_2, iter_16_3 in ipairs(var_16_0) do
		local var_16_1 = arg_16_0._mainResItemList[iter_16_2]

		if not var_16_1 then
			var_16_1 = arg_16_0:getUserDataTb_()
			var_16_1.index = iter_16_2
			var_16_1.go = gohelper.cloneInPlace(arg_16_0._gomainresitem, "item" .. iter_16_2)
			var_16_1.gobeselect = gohelper.findChild(var_16_1.go, "go_beselect")
			var_16_1.gounselect = gohelper.findChild(var_16_1.go, "go_unselect")
			var_16_1.txtbeselectname = gohelper.findChildText(var_16_1.go, "go_beselect/txt_name")
			var_16_1.txtunselectname = gohelper.findChildText(var_16_1.go, "go_unselect/txt_name")
			var_16_1.txtcount = gohelper.findChildText(var_16_1.go, "txt_count")
			var_16_1.btnclick = gohelper.findChildButtonWithAudio(var_16_1.go, "btn_click")

			var_16_1.btnclick:AddClickListener(arg_16_0._btnmainresOnClick, arg_16_0, var_16_1.index)
			table.insert(arg_16_0._mainResItemList, var_16_1)
		end

		var_16_1.resourceId = iter_16_3

		local var_16_2 = "空"

		if iter_16_3 > 0 then
			local var_16_3 = RoomConfig.instance:getResourceConfig(iter_16_3)

			if var_16_3 then
				var_16_2 = var_16_3.name
			else
				logError(string.format("[X小屋地块包表.xlsx] [export_地块资源] 找不到资源id:[%s]", iter_16_3))

				var_16_2 = "未知:" .. iter_16_3
			end
		elseif iter_16_3 < 0 then
			var_16_2 = "未分类"
		end

		var_16_1.txtbeselectname.text = var_16_2
		var_16_1.txtunselectname.text = var_16_2

		gohelper.setActive(var_16_1.go, true)
	end

	for iter_16_4 = #var_16_0 + 1, #arg_16_0._mainResItemList do
		local var_16_4 = arg_16_0._mainResItemList[iter_16_4]

		gohelper.setActive(var_16_4.go, false)
	end

	arg_16_0:_refreshMainRes()
end

function var_0_0._refreshMainRes(arg_18_0)
	local var_18_0 = RoomDebugPackageListModel.instance:getFilterMainRes()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._mainResItemList) do
		local var_18_1 = var_18_0 == iter_18_1.resourceId or iter_18_1.resourceId < 0 and not var_18_0

		gohelper.setActive(iter_18_1.gobeselect, var_18_1)
		gohelper.setActive(iter_18_1.gounselect, not var_18_1)

		local var_18_2 = RoomDebugPackageListModel.instance:getCountByMainRes(iter_18_1.resourceId)

		iter_18_1.txtcount.text = var_18_2
	end
end

function var_0_0._themeFilterChanged(arg_19_0)
	local var_19_0 = RoomDebugThemeFilterListModel.instance
	local var_19_1 = MaterialEnum.MaterialType.BlockPackage

	for iter_19_0 = 1, #arg_19_0._packageIdItemList do
		local var_19_2 = arg_19_0._packageIdItemList[iter_19_0]

		gohelper.setActive(var_19_2.go, var_19_0:checkSelectByItem(var_19_2.packageId, var_19_1))
	end

	gohelper.setActive(arg_19_0._goselectthemfilter, var_19_0:getIsAll() or var_19_0:getSelectCount() > 0)
end

function var_0_0._debugPackageListViewShowChanged(arg_20_0, arg_20_1)
	local var_20_0

	var_20_0 = arg_20_0._isShowDebugPackage ~= arg_20_1
	arg_20_0._isShowDebugPackage = arg_20_1

	RoomDebugPackageListModel.instance:clearSelect()
	gohelper.setActive(arg_20_0._godebugpackage, arg_20_1)

	if arg_20_1 then
		RoomDebugPackageListModel.instance:setDebugPackageList()

		arg_20_0._scrolldebugpackage.horizontalNormalizedPosition = 0
	end
end

function var_0_0._addBtnAudio(arg_21_0)
	gohelper.addUIClickAudio(arg_21_0._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0:_refreshUI()
	arg_22_0:_addBtnAudio()
	arg_22_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_22_0._debugPackageListViewShowChanged, arg_22_0)
	arg_22_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugSetPackage, arg_22_0._refreshMainRes, arg_22_0)
	arg_22_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_22_0._refreshMainRes, arg_22_0)
	arg_22_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageOrderChanged, arg_22_0._refreshMainRes, arg_22_0)
	arg_22_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageFilterChanged, arg_22_0._refreshMainRes, arg_22_0)
	arg_22_0:addEventCb(RoomDebugController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_22_0._themeFilterChanged, arg_22_0)
	RoomDebugThemeFilterListModel.instance:init()
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._packageIdItemList) do
		iter_24_1.btnclick:RemoveClickListener()
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_0._mainResItemList) do
		iter_24_3.btnclick:RemoveClickListener()
	end

	arg_24_0._btnclose:RemoveClickListener()
	arg_24_0._scrolldebugpackage:RemoveOnValueChanged()
	arg_24_0._btnpackageidmode:RemoveClickListener()
	arg_24_0._btnpackageordermode:RemoveClickListener()
	arg_24_0._btnthemfilter:RemoveClickListener()
end

return var_0_0
