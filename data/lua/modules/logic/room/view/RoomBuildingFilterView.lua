module("modules.logic.room.view.RoomBuildingFilterView", package.seeall)

local var_0_0 = class("RoomBuildingFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goraredownselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/rare/go_raredown/beselected")
	arg_1_0._goraredownunselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/rare/go_raredown/unselected")
	arg_1_0._gorareupselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/rare/go_rareup/beselected")
	arg_1_0._gorareupunselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/rare/go_rareup/unselected")
	arg_1_0._goplacedselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/placingstate/go_placed/beselected")
	arg_1_0._goplacedunselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/placingstate/go_placed/unselected")
	arg_1_0._gonotplacedselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/beselected")
	arg_1_0._gonotplacedunselect = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/unselected")
	arg_1_0._gorange = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/go_range")
	arg_1_0._gorangeitem = gohelper.findChild(arg_1_0.viewGO, "#scrollview/viewport/content/go_range/go_rangeitem")
	arg_1_0._btnraredown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scrollview/viewport/content/rare/go_raredown/click")
	arg_1_0._btnrareup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scrollview/viewport/content/rare/go_rareup/click")
	arg_1_0._btnplaced = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scrollview/viewport/content/placingstate/go_placed/click")
	arg_1_0._btnnotplaced = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnraredown:AddClickListener(arg_2_0._btnraredownOnClick, arg_2_0)
	arg_2_0._btnrareup:AddClickListener(arg_2_0._btnrareupOnClick, arg_2_0)
	arg_2_0._btnplaced:AddClickListener(arg_2_0._btnplacedOnClick, arg_2_0)
	arg_2_0._btnnotplaced:AddClickListener(arg_2_0._btnnotplacedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnraredown:RemoveClickListener()
	arg_3_0._btnrareup:RemoveClickListener()
	arg_3_0._btnplaced:RemoveClickListener()
	arg_3_0._btnnotplaced:RemoveClickListener()
end

function var_0_0._btnraredownOnClick(arg_4_0)
	if not RoomShowBuildingListModel.instance:isRareDown() then
		RoomShowBuildingListModel.instance:setRareDown(true)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	arg_4_0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function var_0_0._btnrareupOnClick(arg_5_0)
	if RoomShowBuildingListModel.instance:isRareDown() then
		RoomShowBuildingListModel.instance:setRareDown(false)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	arg_5_0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function var_0_0._btnnotplacedOnClick(arg_6_0)
	arg_6_0:_setFilterUse(0)
end

function var_0_0._btnplacedOnClick(arg_7_0)
	arg_7_0:_setFilterUse(1)
end

function var_0_0._setFilterUse(arg_8_0, arg_8_1)
	if RoomShowBuildingListModel.instance:isFilterUse(arg_8_1) then
		RoomShowBuildingListModel.instance:removeFilterUse(arg_8_1)
	else
		RoomShowBuildingListModel.instance:addFilterUse(arg_8_1)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	arg_8_0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function var_0_0._btnrangeOnClick(arg_9_0, arg_9_1)
	if RoomShowBuildingListModel.instance:isFilterOccupy(arg_9_1) then
		RoomShowBuildingListModel.instance:removeFilterOccupy(arg_9_1)
	else
		RoomShowBuildingListModel.instance:addFilterOccupy(arg_9_1)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	arg_9_0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function var_0_0._editableInitView(arg_10_0)
	gohelper.setActive(arg_10_0._gorangeitem, false)

	arg_10_0._rangeItemList = {}

	local var_10_0 = RoomConfig.instance:getBuildingOccupyList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:_createTbItem(arg_10_0._gorange, "rangeitem" .. iter_10_1)

		var_10_1.occupyId = iter_10_1

		local var_10_2 = RoomConfig.instance:getBuildingOccupyNum(iter_10_1)
		local var_10_3 = RoomConfig.instance:getBuildingOccupyIcon(iter_10_1)

		var_10_1.txtnum.text = var_10_2

		UISpriteSetMgr.instance:setRoomSprite(var_10_1.imageicon, var_10_3)
		var_10_1.btnclick:AddClickListener(arg_10_0._btnrangeOnClick, arg_10_0, var_10_1.occupyId)
		table.insert(arg_10_0._rangeItemList, var_10_1)
	end
end

function var_0_0._createTbItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = gohelper.clone(arg_11_0._gorangeitem, arg_11_1, arg_11_2)
	var_11_0.goselect = gohelper.findChild(var_11_0.go, "beselected")
	var_11_0.gounselect = gohelper.findChild(var_11_0.go, "unselected")
	var_11_0.imageicon = gohelper.findChildImage(var_11_0.go, "layout/num/icon")
	var_11_0.txtnum = gohelper.findChildText(var_11_0.go, "layout/num")
	var_11_0.btnclick = gohelper.findChildButtonWithAudio(var_11_0.go, "click")

	gohelper.addUIClickAudio(var_11_0.btnclick.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.setActive(var_11_0.go, true)

	return var_11_0
end

function var_0_0._refreshFilter(arg_12_0)
	gohelper.setActive(arg_12_0._goraredownselect, RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(arg_12_0._goraredownunselect, not RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(arg_12_0._gorareupselect, not RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(arg_12_0._gorareupunselect, RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(arg_12_0._goplacedselect, RoomShowBuildingListModel.instance:isFilterUse(1))
	gohelper.setActive(arg_12_0._goplacedunselect, not RoomShowBuildingListModel.instance:isFilterUse(1))
	gohelper.setActive(arg_12_0._gonotplacedselect, RoomShowBuildingListModel.instance:isFilterUse(0))
	gohelper.setActive(arg_12_0._gonotplacedunselect, not RoomShowBuildingListModel.instance:isFilterUse(0))

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._rangeItemList) do
		local var_12_0 = RoomShowBuildingListModel.instance:isFilterOccupy(iter_12_1.occupyId)

		SLFramework.UGUI.GuiHelper.SetColor(iter_12_1.imageicon, var_12_0 and "#EC7E4B" or "#E5E5E5")
		SLFramework.UGUI.GuiHelper.SetColor(iter_12_1.txtnum, var_12_0 and "#EC7E4B" or "#E5E5E5")
		gohelper.setActive(iter_12_1.goselect, var_12_0)
		gohelper.setActive(iter_12_1.gounselect, not var_12_0)
	end
end

function var_0_0._addBtnAudio(arg_13_0)
	gohelper.addUIClickAudio(arg_13_0._btnraredown.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(arg_13_0._btnrareup.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(arg_13_0._btnplaced.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(arg_13_0._btnnotplaced.gameObject, AudioEnum.UI.play_ui_role_open)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_addBtnAudio()
	arg_14_0:_refreshFilter()
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._rangeItemList) do
		iter_16_1.btnclick:RemoveClickListener()
	end
end

return var_0_0
