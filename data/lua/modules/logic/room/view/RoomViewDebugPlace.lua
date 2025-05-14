module("modules.logic.room.view.RoomViewDebugPlace", package.seeall)

local var_0_0 = class("RoomViewDebugPlace", BaseView)

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

function var_0_0._btncloseOnClick(arg_4_0)
	RoomDebugController.instance:setDebugPlaceListShow(false)
end

function var_0_0._btncategoryOnClick(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._categoryItemList[arg_5_1].category

	if var_5_0 == "未分类" or string.nilorempty(var_5_0) then
		RoomDebugPlaceListModel.instance:setFilterCategory(nil)
	else
		RoomDebugPlaceListModel.instance:setFilterCategory(var_5_0)
	end

	RoomDebugPlaceListModel.instance:setDebugPlaceList()
	RoomDebugPlaceListModel.instance:clearSelect()
	arg_5_0:_refreshCategory()

	arg_5_0._scrolldebugplace.horizontalNormalizedPosition = 0
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._godebugplace = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugplace")
	arg_6_0._gocategoryitem = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugplace/filtercategory/viewport/content/go_categoryitem")
	arg_6_0._btnclose = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "go_normalroot/go_debugplace/btn_close")
	arg_6_0._scrolldebugplace = gohelper.findChildScrollRect(arg_6_0.viewGO, "go_normalroot/go_debugplace/scroll_debugplace")
	arg_6_0._gopackageiditem = gohelper.findChild(arg_6_0.viewGO, "go_normalroot/go_debugplace/filterpackageid/viewport/content/go_packageiditem")

	arg_6_0._btnclose:AddClickListener(arg_6_0._btncloseOnClick, arg_6_0)

	arg_6_0._isShowDebugPlace = false

	gohelper.setActive(arg_6_0._godebugplace, false)

	arg_6_0._scene = GameSceneMgr.instance:getCurScene()
	arg_6_0._categoryItemList = {}

	gohelper.setActive(arg_6_0._gocategoryitem, false)

	arg_6_0._packageIdItemList = {}

	gohelper.setActive(arg_6_0._gopackageiditem, false)
	arg_6_0:_initCategory()
	arg_6_0:_initPackageId()
	OrthCameraRTMgr.instance:initRT()
	CameraMgr.instance:setOrthCameraActive(true)
end

function var_0_0._initPackageId(arg_7_0)
	local var_7_0 = lua_block_package.configList

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0:getUserDataTb_()

		var_7_1.index = iter_7_0
		var_7_1.go = gohelper.cloneInPlace(arg_7_0._gopackageiditem, "item" .. iter_7_0)
		var_7_1.gobeselect = gohelper.findChild(var_7_1.go, "go_beselect")
		var_7_1.gounselect = gohelper.findChild(var_7_1.go, "go_unselect")
		var_7_1.txtbeselectname = gohelper.findChildText(var_7_1.go, "go_beselect/txt_name")
		var_7_1.txtunselectname = gohelper.findChildText(var_7_1.go, "go_unselect/txt_name")
		var_7_1.btnclick = gohelper.findChildButtonWithAudio(var_7_1.go, "btn_click")

		var_7_1.btnclick:AddClickListener(arg_7_0._btnpackageidOnClick, arg_7_0, var_7_1.index)

		var_7_1.packageId = iter_7_1.id
		var_7_1.txtbeselectname.text = iter_7_1.name
		var_7_1.txtunselectname.text = iter_7_1.name

		table.insert(arg_7_0._packageIdItemList, var_7_1)
		gohelper.setActive(var_7_1.go, true)
	end

	arg_7_0:_refreshPackageId()
end

function var_0_0._initCategory(arg_9_0)
	local var_9_0 = RoomConfig.instance:getBlockDefineConfigDict()
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_3 = iter_9_1.category

		if string.nilorempty(var_9_3) then
			var_9_3 = "未分类"
		end

		if not var_9_2[var_9_3] then
			var_9_2[var_9_3] = {}

			table.insert(var_9_1, var_9_3)
		end
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_1) do
		local var_9_4 = arg_9_0._categoryItemList[iter_9_2]

		if not var_9_4 then
			var_9_4 = arg_9_0:getUserDataTb_()
			var_9_4.index = iter_9_2
			var_9_4.go = gohelper.cloneInPlace(arg_9_0._gocategoryitem, "item" .. iter_9_2)
			var_9_4.gobeselect = gohelper.findChild(var_9_4.go, "go_beselect")
			var_9_4.gounselect = gohelper.findChild(var_9_4.go, "go_unselect")
			var_9_4.txtbeselectname = gohelper.findChildText(var_9_4.go, "go_beselect/txt_name")
			var_9_4.txtunselectname = gohelper.findChildText(var_9_4.go, "go_unselect/txt_name")
			var_9_4.btnclick = gohelper.findChildButtonWithAudio(var_9_4.go, "btn_click")

			var_9_4.btnclick:AddClickListener(arg_9_0._btncategoryOnClick, arg_9_0, var_9_4.index)
			table.insert(arg_9_0._categoryItemList, var_9_4)
		end

		var_9_4.category = iter_9_3
		var_9_4.txtbeselectname.text = var_9_4.category
		var_9_4.txtunselectname.text = var_9_4.category

		gohelper.setActive(var_9_4.go, true)
	end

	for iter_9_4 = #var_9_1 + 1, #arg_9_0._categoryItemList do
		local var_9_5 = arg_9_0._categoryItemList[iter_9_4]

		gohelper.setActive(var_9_5.go, false)
	end

	arg_9_0:_refreshCategory()
end

function var_0_0._refreshCategory(arg_10_0)
	local var_10_0 = RoomDebugPlaceListModel.instance:getFilterCategory()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._categoryItemList) do
		local var_10_1 = var_10_0 == iter_10_1.category

		if string.nilorempty(var_10_0) and iter_10_1.category == "未分类" then
			var_10_1 = true
		end

		gohelper.setActive(iter_10_1.gobeselect, var_10_1)
		gohelper.setActive(iter_10_1.gounselect, not var_10_1)
	end
end

function var_0_0._refreshUI(arg_11_0)
	arg_11_0:_refreshPackageId()
end

function var_0_0._btnpackageidOnClick(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._packageIdItemList[arg_12_1]

	RoomDebugPlaceListModel.instance:setFilterPackageId(var_12_0.packageId)
	RoomDebugPlaceListModel.instance:setDebugPlaceList()
	RoomDebugPlaceListModel.instance:clearSelect()
	arg_12_0:_refreshPackageId()
end

function var_0_0._refreshPackageId(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._packageIdItemList) do
		gohelper.setActive(iter_13_1.gobeselect, RoomDebugPlaceListModel.instance:isFilterPackageId(iter_13_1.packageId))
		gohelper.setActive(iter_13_1.gounselect, not RoomDebugPlaceListModel.instance:isFilterPackageId(iter_13_1.packageId))
	end
end

function var_0_0._debugPlaceListViewShowChanged(arg_14_0, arg_14_1)
	local var_14_0

	var_14_0 = arg_14_0._isShowDebugPlace ~= arg_14_1
	arg_14_0._isShowDebugPlace = arg_14_1

	RoomDebugPlaceListModel.instance:clearSelect()
	gohelper.setActive(arg_14_0._godebugplace, arg_14_1)

	if arg_14_1 then
		RoomDebugPlaceListModel.instance:setDebugPlaceList()

		arg_14_0._scrolldebugplace.horizontalNormalizedPosition = 0
	end
end

function var_0_0._addBtnAudio(arg_15_0)
	gohelper.addUIClickAudio(arg_15_0._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_refreshUI()
	arg_16_0:_addBtnAudio()
	arg_16_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_16_0._debugPlaceListViewShowChanged, arg_16_0)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._categoryItemList) do
		iter_18_1.btnclick:RemoveClickListener()
	end

	arg_18_0._btnclose:RemoveClickListener()
	arg_18_0._scrolldebugplace:RemoveOnValueChanged()
	OrthCameraRTMgr.instance:destroyRT()
	CameraMgr.instance:setOrthCameraActive(false)
end

return var_0_0
