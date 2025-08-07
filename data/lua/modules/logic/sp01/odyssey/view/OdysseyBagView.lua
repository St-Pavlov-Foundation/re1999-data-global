module("modules.logic.sp01.odyssey.view.OdysseyBagView", package.seeall)

local var_0_0 = class("OdysseyBagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_fullbg")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Top/#btn_equip")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Top/#btn_task")
	arg_1_0._goequipReddot = gohelper.findChild(arg_1_0.viewGO, "root/Top/#btn_equip/go_reddot")
	arg_1_0._gotaskReddot = gohelper.findChild(arg_1_0.viewGO, "root/Top/#btn_task/go_reddot")
	arg_1_0._scrollLeftTab = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Equip/#scroll_LeftTab")
	arg_1_0._goTabItem = gohelper.findChild(arg_1_0.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem/#image_icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem/#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem/#btn_click")
	arg_1_0._scrollEquip = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Equip/#scroll_Equip")
	arg_1_0._goDetailEquip = gohelper.findChild(arg_1_0.viewGO, "root/Equip/#go_DetailEquip")
	arg_1_0._goDetailItem = gohelper.findChild(arg_1_0.viewGO, "root/Equip/#go_DetailItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, arg_2_0.onItemSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, arg_2_0.OnEquipSuitSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_2_0.refreshList, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshBagReddot, arg_2_0.refreshReddot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, arg_3_0.onItemSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, arg_3_0.OnEquipSuitSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_3_0.refreshList, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnRefreshBagReddot, arg_3_0.refreshReddot, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	OdysseyEquipSuitTabListModel.instance:initList()

	arg_4_0._goEquipUnSelect = gohelper.findChild(arg_4_0.viewGO, "root/Top/#btn_equip/unselect")
	arg_4_0._goEquipSelected = gohelper.findChild(arg_4_0.viewGO, "root/Top/#btn_equip/selected")
	arg_4_0._goItemUnSelect = gohelper.findChild(arg_4_0.viewGO, "root/Top/#btn_task/unselect")
	arg_4_0._goItemSelected = gohelper.findChild(arg_4_0.viewGO, "root/Top/#btn_task/selected")
	arg_4_0._equipDetailItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goDetailEquip, OdysseyBagEquipDetailItem)
	arg_4_0._itemDetailItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goDetailItem, OdysseyBagItemDetailItem)
	arg_4_0._animView = gohelper.findChildComponent(arg_4_0.viewGO, "", gohelper.Type_Animator)
	arg_4_0._animEquip = gohelper.findChildComponent(arg_4_0.viewGO, "root/Equip/#go_DetailEquip", gohelper.Type_Animator)
	arg_4_0._animItem = gohelper.findChildComponent(arg_4_0.viewGO, "root/Equip/#go_DetailItem", gohelper.Type_Animator)
	arg_4_0._animScroll = gohelper.findChildComponent(arg_4_0.viewGO, "root/Equip/#scroll_Equip", gohelper.Type_Animator)
end

function var_0_0._btnequipOnClick(arg_5_0)
	arg_5_0:switchList(OdysseyEnum.ItemType.Equip)
end

function var_0_0._btntaskOnClick(arg_6_0)
	if not OdysseyItemModel.instance:haveTaskItem() then
		logError("奥德赛下半角色活动 暂无任务道具")

		return
	end

	arg_6_0:switchList(OdysseyEnum.ItemType.Item)
end

function var_0_0.switchList(arg_7_0, arg_7_1)
	if arg_7_0._itemType == arg_7_1 then
		return
	end

	arg_7_0._itemType = arg_7_1
	arg_7_0._equipFilterType = nil

	OdysseyEquipSuitTabListModel.instance:clearSelect()

	if arg_7_1 == OdysseyEnum.ItemType.Equip then
		OdysseyEquipSuitTabListModel.instance:selectAllTag()
	end

	arg_7_0:refreshList()
	arg_7_0:refreshItemBtnState()

	local var_7_0 = OdysseyEquipListModel.instance:getFirstMo()

	if var_7_0 then
		OdysseyEquipListModel.instance:setSelect(var_7_0.itemMo.uid)
	else
		arg_7_0:onItemSelect(nil)
	end
end

function var_0_0.refreshItemBtnState(arg_8_0)
	local var_8_0 = arg_8_0._itemType == OdysseyEnum.ItemType.Equip
	local var_8_1 = OdysseyItemModel.instance:haveTaskItem()

	gohelper.setActive(arg_8_0._btntask, var_8_1)
	gohelper.setActive(arg_8_0._goItemSelected, not var_8_0)
	gohelper.setActive(arg_8_0._goItemUnSelect, var_8_0)
	gohelper.setActive(arg_8_0._goEquipSelected, var_8_0)
	gohelper.setActive(arg_8_0._goEquipUnSelect, not var_8_0)
	gohelper.setActive(arg_8_0._scrollLeftTab, var_8_0)
end

function var_0_0._btnclickOnClick(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam
	local var_11_1 = var_11_0 and var_11_0.itemType and var_11_0.itemType or OdysseyEnum.ItemType.Equip

	if var_11_1 == OdysseyEnum.ItemType.Item and not OdysseyItemModel.instance:haveTaskItem() then
		logError("奥德赛下半角色活动 暂无任务道具")

		var_11_1 = OdysseyEnum.ItemType.Equip
	end

	arg_11_0:switchList(var_11_1)
	OdysseyStatHelper.instance:initViewStartTime()
end

function var_0_0.refreshList(arg_12_0)
	OdysseyEquipListModel.instance:copyListFromEquipModel(arg_12_0._itemType, arg_12_0._equipFilterType, OdysseyEnum.BagType.Bag)
	arg_12_0:refreshReddot()
	arg_12_0._animScroll:Play("flash", 0, 0)
end

function var_0_0.onItemSelect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 ~= nil
	local var_13_1 = arg_13_0._itemType == OdysseyEnum.ItemType.Equip

	gohelper.setActive(arg_13_0._goDetailEquip, var_13_0 and var_13_1)
	gohelper.setActive(arg_13_0._goDetailItem, var_13_0 and not var_13_1)

	if var_13_0 and var_13_1 then
		arg_13_0._animEquip:Play("open", 0, 0)
	elseif var_13_0 and not var_13_1 then
		arg_13_0._animItem:Play("open", 0, 0)
	end

	if var_13_0 then
		(var_13_1 and arg_13_0._equipDetailItem or arg_13_0._itemDetailItem):setInfo(arg_13_1.itemMo)
	end

	arg_13_0:refreshReddot()
end

function var_0_0.OnEquipSuitSelect(arg_14_0, arg_14_1)
	local var_14_0

	if arg_14_1.type == OdysseyEnum.EquipSuitType.All then
		-- block empty
	else
		var_14_0 = arg_14_1 and arg_14_1.suitId

		if arg_14_0._equipFilterType == var_14_0 then
			return
		end
	end

	arg_14_0._equipFilterType = var_14_0

	local var_14_1 = OdysseyEquipListModel.instance:getSelectMo()

	arg_14_0:refreshList()
	OdysseyEquipListModel.instance:setSelect(var_14_1.uid)
end

function var_0_0.refreshReddot(arg_15_0)
	local var_15_0 = OdysseyItemModel.instance:checkBagTagShowReddot(OdysseyEnum.ItemType.Equip)

	gohelper.setActive(arg_15_0._goequipReddot, var_15_0)

	local var_15_1 = OdysseyItemModel.instance:checkBagTagShowReddot(OdysseyEnum.ItemType.Item)

	gohelper.setActive(arg_15_0._gotaskReddot, var_15_1)
end

function var_0_0.onClose(arg_16_0)
	local var_16_0 = OdysseyItemModel.instance:getHasClickItemList()

	if #var_16_0 > 0 then
		OdysseyRpc.instance:sendOdysseyBagUpdateItemNewFlagRequest(var_16_0)
	end

	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyBagView")
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
