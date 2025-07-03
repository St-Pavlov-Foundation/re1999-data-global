module("modules.logic.versionactivity2_7.act191.view.Act191CollectionEditView", package.seeall)

local var_0_0 = class("Act191CollectionEditView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCollectionTip = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_CollectionTip")
	arg_1_0._txtCollectionName = gohelper.findChildText(arg_1_0.viewGO, "left_container/#go_CollectionTip/scroll_tips/viewport/content/Title/#txt_CollectionName")
	arg_1_0._txtCollectionDec = gohelper.findChildText(arg_1_0.viewGO, "left_container/#go_CollectionTip/scroll_tips/viewport/content/#txt_CollectionDec")
	arg_1_0._goListEmpty = gohelper.findChild(arg_1_0.viewGO, "right_container/CollectionList/#go_ListEmpty")
	arg_1_0._btnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_Equip")
	arg_1_0._btnUnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_UnEquip")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEquip:AddClickListener(arg_2_0._btnEquipOnClick, arg_2_0)
	arg_2_0._btnUnEquip:AddClickListener(arg_2_0._btnUnEquipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEquip:RemoveClickListener()
	arg_3_0._btnUnEquip:RemoveClickListener()
end

function var_0_0._btnEquipOnClick(arg_4_0)
	local var_4_0 = arg_4_0._itemMo.uid

	arg_4_0.equipping = true

	arg_4_0.gameInfo:replaceItemInTeam(var_4_0, arg_4_0.curSlotIndex)
end

function var_0_0._btnUnEquipOnClick(arg_5_0)
	local var_5_0 = Activity191Helper.getWithBuildBattleHeroInfo(arg_5_0.teamInfo.battleHeroInfo, arg_5_0.curSlotIndex).itemUid1

	if var_5_0 and var_5_0 ~= 0 then
		arg_5_0.gameInfo:removeItemInTeam(var_5_0)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.heroItemList = {}
	arg_6_0.slotItemList = {}

	for iter_6_0 = 1, 4 do
		local var_6_0 = gohelper.findChild(arg_6_0.viewGO, string.format("left_container/%s/Hero", iter_6_0))

		arg_6_0.heroItemList[iter_6_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, Act191HeroGroupItem1)

		local var_6_1 = arg_6_0:getUserDataTb_()
		local var_6_2 = gohelper.findChild(arg_6_0.viewGO, string.format("left_container/%s/Collection", iter_6_0))

		var_6_1.goEmpty = gohelper.findChild(var_6_2, "go_Empty")
		var_6_1.goCollection = gohelper.findChild(var_6_2, "go_Collection")
		var_6_1.imageRare = gohelper.findChildImage(var_6_2, "go_Collection/image_Rare")
		var_6_1.simageIcon = gohelper.findChildSingleImage(var_6_2, "go_Collection/simage_Icon")
		var_6_1.goSelect = gohelper.findChild(var_6_2, "go_Select")

		local var_6_3 = gohelper.findChildButtonWithAudio(var_6_2, "btn_Click")

		arg_6_0:addClickCb(var_6_3, arg_6_0.onSlotClick, arg_6_0, iter_6_0)

		arg_6_0.slotItemList[iter_6_0] = var_6_1
	end

	arg_6_0.itemUidDic = {}
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, arg_7_0.onUpdateTeam, arg_7_0)
	arg_7_0:addEventCb(Activity191Controller.instance, Activity191Event.OnClickCollectionGroupItem, arg_7_0._onItemClick, arg_7_0)

	arg_7_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_7_0.teamInfo = arg_7_0.gameInfo:getTeamInfo()
	arg_7_0.curSlotIndex = arg_7_0.viewParam.index

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	for iter_8_0 = 1, 4 do
		local var_8_0 = Activity191Helper.matchKeyInArray(arg_8_0.teamInfo.battleHeroInfo, iter_8_0)
		local var_8_1 = var_8_0 and var_8_0.heroId or 0

		arg_8_0.heroItemList[iter_8_0]:setData(var_8_1)

		arg_8_0.itemUidDic[iter_8_0] = var_8_0 and var_8_0.itemUid1 or 0
	end

	arg_8_0:refreshSlotItem()

	local var_8_2 = arg_8_0.itemUidDic[arg_8_0.curSlotIndex]

	Act191CollectionEditListModel.instance:initData(var_8_2)
end

function var_0_0.refreshSlotItem(arg_9_0)
	for iter_9_0 = 1, 4 do
		local var_9_0 = arg_9_0.slotItemList[iter_9_0]
		local var_9_1 = arg_9_0.itemUidDic[iter_9_0]

		gohelper.setActive(var_9_0.goSelect, iter_9_0 == arg_9_0.curSlotIndex)

		if var_9_1 ~= 0 then
			local var_9_2 = arg_9_0.gameInfo:getItemInfoInWarehouse(var_9_1)
			local var_9_3 = Activity191Config.instance:getCollectionCo(var_9_2.itemId)

			UISpriteSetMgr.instance:setAct174Sprite(var_9_0.imageRare, "act174_propitembg_" .. var_9_3.rare)
			var_9_0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_9_3.icon))

			if arg_9_0.equipping and iter_9_0 == arg_9_0.curSlotIndex then
				AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_equip_creation)
				gohelper.setActive(var_9_0.goCollection, false)
				gohelper.setActive(var_9_0.goCollection, true)
			else
				gohelper.setActive(var_9_0.goCollection, true)
			end

			gohelper.setActive(var_9_0.goEmpty, false)
		else
			gohelper.setActive(var_9_0.goCollection, false)
			gohelper.setActive(var_9_0.goEmpty, true)
		end
	end
end

function var_0_0.onSlotClick(arg_10_0, arg_10_1)
	arg_10_0.curSlotIndex = arg_10_1

	for iter_10_0 = 1, 4 do
		gohelper.setActive(arg_10_0.slotItemList[iter_10_0].goSelect, iter_10_0 == arg_10_1)
	end

	local var_10_0 = arg_10_0.itemUidDic[arg_10_0.curSlotIndex]

	if var_10_0 == 0 then
		if arg_10_0._itemMo then
			Act191CollectionEditListModel.instance:selectItem(arg_10_0._itemMo.uid, false)
		else
			arg_10_0:refreshBtnStatus()
		end
	else
		Act191CollectionEditListModel.instance:selectItem(var_10_0, true)
	end
end

function var_0_0._onItemClick(arg_11_0, arg_11_1)
	arg_11_0._itemMo = arg_11_1

	arg_11_0:refreshItemTip()
	arg_11_0:refreshBtnStatus()
end

function var_0_0.refreshBtnStatus(arg_12_0)
	local var_12_0 = arg_12_0.itemUidDic[arg_12_0.curSlotIndex]

	if arg_12_0._itemMo then
		if arg_12_0._itemMo.uid == var_12_0 then
			gohelper.setActive(arg_12_0._btnEquip, false)
			gohelper.setActive(arg_12_0._btnUnEquip, true)
		else
			gohelper.setActive(arg_12_0._btnEquip, true)
			gohelper.setActive(arg_12_0._btnUnEquip, false)
		end
	else
		gohelper.setActive(arg_12_0._btnEquip, false)
		gohelper.setActive(arg_12_0._btnUnEquip, var_12_0 ~= 0)
	end
end

function var_0_0.refreshItemTip(arg_13_0)
	if arg_13_0._itemMo then
		local var_13_0 = Activity191Config.instance:getCollectionCo(arg_13_0._itemMo.itemId)

		arg_13_0._txtCollectionName.text = var_13_0.title

		local var_13_1 = arg_13_0.gameInfo:isItemEnhance(var_13_0.id)

		arg_13_0._txtCollectionDec.text = var_13_1 and var_13_0.replaceDesc or var_13_0.desc

		gohelper.setActive(arg_13_0._goCollectionTip, true)
	else
		gohelper.setActive(arg_13_0._goCollectionTip, false)
	end
end

function var_0_0.onUpdateTeam(arg_14_0)
	arg_14_0.teamInfo = arg_14_0.gameInfo:getTeamInfo()

	if arg_14_0.equipping then
		GameFacade.showToast(ToastEnum.Act191EquipTip)
	end

	arg_14_0:refreshUI()
	arg_14_0:selectEmptySlot()

	arg_14_0.equipping = false
end

function var_0_0.selectEmptySlot(arg_15_0)
	for iter_15_0 = 1, 4 do
		if arg_15_0.itemUidDic[iter_15_0] == 0 then
			arg_15_0:onSlotClick(iter_15_0)

			break
		end
	end
end

return var_0_0
