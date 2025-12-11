module("modules.logic.versionactivity2_7.act191.view.Act191CollectionView", package.seeall)

local var_0_0 = class("Act191CollectionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Empty")
	arg_1_0._goInfo = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Info")
	arg_1_0._goCTag1 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Info/#go_CTag1")
	arg_1_0._txtCTag1 = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_Info/#go_CTag1/#txt_CTag1")
	arg_1_0._goCTag2 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Info/#go_CTag2")
	arg_1_0._txtCTag2 = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_Info/#go_CTag2/#txt_CTag2")
	arg_1_0._simageCIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#go_Info/#simage_CIcon")
	arg_1_0._txtCName = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_Info/#txt_CName")
	arg_1_0._txtCDesc = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_Info/scroll_desc/Viewport/go_desccontent/#txt_CDesc")
	arg_1_0._btnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#go_Info/#btn_Equip")
	arg_1_0._btnUnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#go_Info/#btn_UnEquip")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "bg/#scroll_ItemList")
	arg_1_0._goItemContent = gohelper.findChild(arg_1_0.viewGO, "bg/#scroll_ItemList/Viewport/#go_ItemContent")
	arg_1_0._goTeam = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Team")
	arg_1_0._imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "bg/#go_Team/level/#image_Level")
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
	arg_4_0.equipping = true

	arg_4_0.gameInfo:replaceItemInTeam(arg_4_0.showItemUid, arg_4_0.curSlotIndex)
end

function var_0_0._btnUnEquipOnClick(arg_5_0)
	arg_5_0.gameInfo:removeItemInTeam(arg_5_0.showItemUid)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.animLevel = gohelper.findChild(arg_6_0._goTeam, "level"):GetComponent(gohelper.Type_Animator)
	arg_6_0.animInfo = arg_6_0._goInfo:GetComponent(gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(arg_6_0._txtCDesc)

	arg_6_0._goItemList = arg_6_0._scrollItemList.gameObject
	arg_6_0.equipItemList = {}
	arg_6_0.showItemUid = nil
	arg_6_0.equipPosTrList = {}
	arg_6_0.slotItemList = {}

	for iter_6_0 = 1, 4 do
		arg_6_0.equipPosTrList[iter_6_0] = gohelper.findChild(arg_6_0._goTeam, "Team/bg/mask" .. iter_6_0 .. "/image").transform

		local var_6_0 = arg_6_0:getUserDataTb_()

		var_6_0.go = gohelper.findChild(arg_6_0._goTeam, "Team/collection" .. iter_6_0)
		var_6_0.transform = var_6_0.go.transform
		var_6_0.goEmpty = gohelper.findChild(var_6_0.go, "go_Empty")
		var_6_0.goCollection = gohelper.findChild(var_6_0.go, "go_Collection")
		var_6_0.imageRare = gohelper.findChildImage(var_6_0.go, "go_Collection/image_Rare")
		var_6_0.simageIcon = gohelper.findChildSingleImage(var_6_0.go, "go_Collection/simage_Icon")
		var_6_0.goSelect = gohelper.findChild(var_6_0.go, "go_Collection/go_Select")
		var_6_0.goAddEffect = gohelper.findChild(var_6_0.go, "go_AddEffect")
		var_6_0.goPreAdd = gohelper.findChild(var_6_0.go, "go_PreAdd")

		local var_6_1 = gohelper.findChildButtonWithAudio(var_6_0.go, "btn_Click")

		arg_6_0:addClickCb(var_6_1, arg_6_0.onClickSlot, arg_6_0, iter_6_0)
		CommonDragHelper.instance:registerDragObj(var_6_0.go, arg_6_0._beginDrag, nil, arg_6_0._endDrag, arg_6_0._checkDrag, arg_6_0, iter_6_0)

		arg_6_0.slotItemList[iter_6_0] = var_6_0
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(Activity191Controller.instance, Activity191Event.ClickCollectionItem, arg_7_0.onClickCollectionItem, arg_7_0)
	arg_7_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, arg_7_0.onUpdateTeam, arg_7_0)

	arg_7_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_7_0.teamInfo = arg_7_0.gameInfo:getTeamInfo()

	arg_7_0:refreshUI()
	arg_7_0:refreshHeroInfo()

	local var_7_0 = arg_7_0.viewParam.index or 1

	arg_7_0:onClickSlot(var_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.slotItemList) do
		CommonDragHelper.instance:unregisterDragObj(iter_8_1.go)
	end

	TaskDispatcher.cancelTask(arg_8_0.delayRefreshInfo, arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0.heroIdMap = {}
	arg_9_0.itemUIdMap = {}

	for iter_9_0 = 1, 4 do
		local var_9_0 = Activity191Helper.matchKeyInArray(arg_9_0.teamInfo.battleHeroInfo, iter_9_0)

		arg_9_0.heroIdMap[iter_9_0] = var_9_0 and var_9_0.heroId or 0
		arg_9_0.itemUIdMap[iter_9_0] = var_9_0 and var_9_0.itemUid1 or 0
	end

	local var_9_1 = lua_activity191_rank.configDict[arg_9_0.gameInfo.rank].fightLevel

	UISpriteSetMgr.instance:setAct174Sprite(arg_9_0._imageLevel, "act191_level_" .. string.lower(var_9_1))
	arg_9_0:refreshItemList()
	arg_9_0:refreshInfo()
	arg_9_0:refreshEquipInfo()
	arg_9_0:refreshEquipSelect()
end

function var_0_0.onClickCollectionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.showItemUid and arg_10_0.showItemUid ~= arg_10_1

	arg_10_0.showItemUid = arg_10_1

	arg_10_0:refreshInfo(var_10_0)
	arg_10_0:refreshEquipSelect()
end

function var_0_0.onClickSlot(arg_11_0, arg_11_1)
	if arg_11_0.dragging then
		return
	end

	arg_11_0.curSlotIndex = arg_11_1

	local var_11_0 = arg_11_0.itemUIdMap[arg_11_1]

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.slotItemList) do
		gohelper.setActive(iter_11_1.goPreAdd, iter_11_0 == arg_11_1 and var_11_0 == 0)
	end

	if var_11_0 ~= 0 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.ClickCollectionItem, var_11_0)
	end
end

function var_0_0.refreshItemList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.gameInfo.warehouseInfo.item) do
		local var_12_1 = iter_12_1.uid

		if not arg_12_0.gameInfo:isItemInTeam(var_12_1) then
			var_12_0[#var_12_0 + 1] = iter_12_1
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = Activity191Config.instance:getCollectionCo(arg_13_0.itemId)
		local var_13_1 = Activity191Config.instance:getCollectionCo(arg_13_1.itemId)

		return var_13_0.rare > var_13_1.rare
	end)

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		if not arg_12_0.equipItemList[iter_12_2] then
			local var_12_2 = arg_12_0:getResInst(Activity191Enum.PrefabPath.CollectionItem, arg_12_0._goItemContent)

			arg_12_0.equipItemList[iter_12_2] = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_2, Act191CollectionItem)
		end

		arg_12_0.equipItemList[iter_12_2]:setData(iter_12_3)
	end

	for iter_12_4 = #var_12_0 + 1, #arg_12_0.equipItemList do
		arg_12_0.equipItemList[iter_12_4]:setActive(false)
	end
end

function var_0_0.refreshInfo(arg_14_0, arg_14_1)
	TaskDispatcher.cancelTask(arg_14_0.delayRefreshInfo, arg_14_0)

	if arg_14_1 then
		arg_14_0.animInfo:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_14_0.delayRefreshInfo, arg_14_0, 0.16)
	elseif arg_14_0.showItemUid then
		arg_14_0:delayRefreshInfo()
	end

	gohelper.setActive(arg_14_0._goEmpty, not arg_14_0.showItemUid)
	gohelper.setActive(arg_14_0._goInfo, arg_14_0.showItemUid)
end

function var_0_0.delayRefreshInfo(arg_15_0)
	local var_15_0 = arg_15_0.gameInfo:getItemInfoInWarehouse(arg_15_0.showItemUid)
	local var_15_1 = Activity191Config.instance:getCollectionCo(var_15_0.itemId)

	arg_15_0._simageCIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_15_1.icon))

	local var_15_2 = Activity191Enum.CollectionColor[var_15_1.rare]

	arg_15_0._txtCName.text = string.format("<#%s>%s</color>", var_15_2, var_15_1.title)
	arg_15_0._txtCDesc.text = Activity191Helper.replaceSymbol(SkillHelper.buildDesc(var_15_1.desc))

	if string.nilorempty(var_15_1.label) then
		gohelper.setActive(arg_15_0._goCTag1, false)
		gohelper.setActive(arg_15_0._goCTag2, false)
	else
		local var_15_3 = string.split(var_15_1.label, "#")

		for iter_15_0 = 1, 2 do
			local var_15_4 = var_15_3[iter_15_0]

			arg_15_0["_txtCTag" .. iter_15_0].text = var_15_4

			gohelper.setActive(arg_15_0["_goCTag" .. iter_15_0], var_15_4)
		end
	end

	local var_15_5 = arg_15_0.gameInfo:isItemInTeam(arg_15_0.showItemUid)

	gohelper.setActive(arg_15_0._btnEquip, not var_15_5)
	gohelper.setActive(arg_15_0._btnUnEquip, var_15_5)
end

function var_0_0.refreshHeroInfo(arg_16_0)
	for iter_16_0 = 1, 4 do
		local var_16_0 = gohelper.findChild(arg_16_0._goTeam, "Team/hero" .. iter_16_0)
		local var_16_1 = gohelper.findChild(var_16_0, "go_Empty")
		local var_16_2 = gohelper.findChild(var_16_0, "go_Hero")
		local var_16_3 = arg_16_0.heroIdMap[iter_16_0]

		if var_16_3 ~= 0 then
			local var_16_4 = arg_16_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_16_2)

			MonoHelper.addNoUpdateLuaComOnceToGo(var_16_4, Act191HeroHeadItem):setData(var_16_3)
		end

		gohelper.setActive(var_16_1, var_16_3 == 0)
		gohelper.setActive(var_16_2, var_16_3 ~= 0)
	end
end

function var_0_0.refreshEquipInfo(arg_17_0)
	for iter_17_0 = 1, 4 do
		local var_17_0 = arg_17_0.slotItemList[iter_17_0]
		local var_17_1 = arg_17_0.itemUIdMap[iter_17_0]

		if var_17_1 ~= 0 then
			if arg_17_0.equipping and iter_17_0 == arg_17_0.curSlotIndex then
				gohelper.setActive(var_17_0.goAddEffect, false)
				gohelper.setActive(var_17_0.goAddEffect, true)
				AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_equip_creation)
			end

			local var_17_2 = arg_17_0.gameInfo:getItemInfoInWarehouse(var_17_1)
			local var_17_3 = Activity191Config.instance:getCollectionCo(var_17_2.itemId)

			UISpriteSetMgr.instance:setAct174Sprite(var_17_0.imageRare, "act174_propitembg_" .. var_17_3.rare)
			var_17_0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_17_3.icon))
			gohelper.setActive(var_17_0.goCollection, true)
			gohelper.setActive(var_17_0.goEmpty, false)
		else
			gohelper.setActive(var_17_0.goCollection, false)
			gohelper.setActive(var_17_0.goEmpty, true)
		end
	end
end

function var_0_0.refreshEquipSelect(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.equipItemList) do
		local var_18_0 = iter_18_1.itemInfo.uid

		iter_18_1:setSelect(var_18_0 == arg_18_0.showItemUid)
	end

	for iter_18_2 = 1, 4 do
		local var_18_1 = arg_18_0.slotItemList[iter_18_2]

		if var_18_1 then
			gohelper.setActive(var_18_1.goSelect, arg_18_0.itemUIdMap[iter_18_2] == arg_18_0.showItemUid)
		end
	end
end

function var_0_0._beginDrag(arg_19_0)
	arg_19_0.dragging = true

	gohelper.setAsLastSibling(arg_19_0._goTeam)
end

function var_0_0._endDrag(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.dragging = false

	local var_20_0 = arg_20_0.slotItemList[arg_20_1]

	ZProj.TweenHelper.KillByObj(var_20_0.transform)

	local var_20_1 = arg_20_2.position
	local var_20_2

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.equipPosTrList) do
		if gohelper.isMouseOverGo(iter_20_1, var_20_1) then
			var_20_2 = iter_20_0

			break
		end
	end

	if var_20_2 and var_20_2 ~= arg_20_1 then
		arg_20_0.equipping = true

		arg_20_0.gameInfo:exchangeItem(arg_20_1, var_20_2)
		gohelper.setActive(var_20_0.goCollection, false)
	end

	local var_20_3 = arg_20_0.equipPosTrList[arg_20_1].position

	transformhelper.setPos(var_20_0.transform, var_20_3.x + 0.65, var_20_3.y, var_20_3.z)
end

function var_0_0._checkDrag(arg_21_0, arg_21_1)
	return not arg_21_0.itemUIdMap[arg_21_1]
end

function var_0_0.onUpdateTeam(arg_22_0)
	arg_22_0.showItemUid = nil
	arg_22_0.teamInfo = arg_22_0.gameInfo:getTeamInfo()

	if arg_22_0.equipping then
		GameFacade.showToast(ToastEnum.Act191EquipTip)
	end

	arg_22_0:refreshUI()
	arg_22_0:selectEmptySlot()

	arg_22_0.equipping = false

	local var_22_0 = arg_22_0.gameInfo.rankMark

	if var_22_0 > 0 then
		arg_22_0.animLevel:Play("levelup", 0, 0)
	elseif var_22_0 < 0 then
		arg_22_0.animLevel:Play("swicth", 0, 0)
	end

	arg_22_0.gameInfo:clearRankMark()
end

function var_0_0.selectEmptySlot(arg_23_0)
	for iter_23_0 = 1, 4 do
		if arg_23_0.itemUIdMap[iter_23_0] == 0 then
			arg_23_0:onClickSlot(iter_23_0)

			return
		end
	end

	arg_23_0:onClickSlot(4)
end

return var_0_0
