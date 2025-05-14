module("modules.logic.room.view.record.RoomTradeLevelUpTipsView", package.seeall)

local var_0_0 = class("RoomTradeLevelUpTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagecaidai = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_caidai")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_name")
	arg_1_0._txttype = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_type")
	arg_1_0._scrolllevelup = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_levelup")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#scroll_levelup/Viewport/Content/levelupInfo/#go_info")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goinfo, false)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.tradeLevel = arg_6_0.viewParam.level

	if arg_6_0.tradeLevel then
		arg_6_0:_updateLevelInfo(arg_6_0.tradeLevel)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0.tradeLevel = arg_7_0.viewParam.level
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._updateLevelInfo(arg_10_0, arg_10_1)
	local var_10_0 = ManufactureConfig.instance:getTradeLevelCfg(arg_10_1)

	arg_10_0._txtname.text = var_10_0.dimension
	arg_10_0._txttype.text = var_10_0.job

	local var_10_1 = RoomTradeTaskModel.instance:getLevelUnlock(arg_10_1)
	local var_10_2 = {}

	if var_10_1 then
		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			local var_10_3 = iter_10_1.type
			local var_10_4 = var_10_2[var_10_3]

			if not var_10_4 then
				var_10_4 = {}
				var_10_2[var_10_3] = var_10_4
			end

			table.insert(var_10_4, iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in pairs(var_10_2) do
		local var_10_5 = RoomTradeConfig.instance:getLevelUnlockCo(iter_10_2)

		if var_10_5.itemType == 1 then
			if iter_10_2 == RoomTradeEnum.LevelUnlock.BuildingMaxLevel then
				for iter_10_4, iter_10_5 in ipairs(iter_10_3) do
					arg_10_0:_setBuildingMaxLevelItem(iter_10_5, iter_10_2)
				end
			else
				arg_10_0:_setNewBuildingItem(iter_10_3, iter_10_2)
			end
		elseif var_10_5.itemType == 2 then
			arg_10_0:_setGetBonusItem(iter_10_3, iter_10_2)
		else
			arg_10_0:setNormalItem(iter_10_3, iter_10_2)
		end
	end

	local var_10_6 = arg_10_0:getUserDataTb_()

	if arg_10_0._unlockInfoItems then
		for iter_10_6, iter_10_7 in pairs(arg_10_0._unlockInfoItems) do
			table.insert(var_10_6, iter_10_7)
		end

		table.sort(var_10_6, arg_10_0._sortInfoItem)
		arg_10_0:_sortItem(var_10_6)
	end
end

function var_0_0._sortInfoItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.co
	local var_11_1 = arg_11_1.co

	if var_11_0 and var_11_1 then
		return var_11_0.sort < var_11_1.sort
	end
end

function var_0_0._sortItem(arg_12_0, arg_12_1)
	if arg_12_1 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
			iter_12_1.go.transform:SetSiblingIndex(iter_12_0)
			gohelper.setActive(iter_12_1.bgGo, iter_12_0 % 2 == 0)
		end
	end
end

function var_0_0._setGetBonusItem(arg_13_0, arg_13_1, arg_13_2)
	if not LuaUtil.tableNotEmpty(arg_13_1) then
		return
	end

	local var_13_0 = arg_13_0:_getInfoItem(arg_13_2)

	var_13_0.co = RoomTradeConfig.instance:getLevelUnlockCo(arg_13_2)
	var_13_0.descTxt.text = var_13_0.co.levelupDes
	var_13_0.type = arg_13_2

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1 = iter_13_1.bouns
		local var_13_2 = string.split(var_13_1, "#")
		local var_13_3 = var_13_2[1]
		local var_13_4 = var_13_2[2]
		local var_13_5 = var_13_2[3]

		if not var_13_0.itemList then
			var_13_0.itemList = arg_13_0:getUserDataTb_()
		end

		local var_13_6 = var_13_0.itemList[iter_13_0]

		if not var_13_6 then
			local var_13_7 = gohelper.cloneInPlace(var_13_0.goicon, "item_" .. iter_13_0)

			var_13_6 = arg_13_0:getUserDataTb_()
			var_13_6.go = var_13_7
			var_13_6.icon = IconMgr.instance:getCommonPropItemIcon(var_13_7)

			var_13_6.icon:setMOValue(var_13_3, var_13_4, var_13_5, nil, true)
			var_13_6.icon:setCountFontSize(40)
			var_13_6.icon:showStackableNum2()
			var_13_6.icon:isShowEffect(true)

			var_13_0.itemList[iter_13_0] = var_13_6
		else
			var_13_6.icon:setMOValue(var_13_3, var_13_4, var_13_5, nil, true)
		end

		gohelper.setActive(var_13_6.go, true)
	end

	gohelper.setActive(var_13_0.itemGo, true)
	gohelper.setActive(var_13_0.go, true)
end

function var_0_0._setNewBuildingItem(arg_14_0, arg_14_1, arg_14_2)
	if not LuaUtil.tableNotEmpty(arg_14_1) then
		return
	end

	local var_14_0 = arg_14_0:_getInfoItem(arg_14_2)

	var_14_0.co = RoomTradeConfig.instance:getLevelUnlockCo(arg_14_2)
	var_14_0.descTxt.text = var_14_0.co.levelupDes
	var_14_0.type = arg_14_2

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if not var_14_0.itemList then
			var_14_0.itemList = arg_14_0:getUserDataTb_()
		end

		local var_14_1 = var_14_0.itemList[iter_14_0]

		if not var_14_1 then
			local var_14_2 = gohelper.cloneInPlace(var_14_0.goicon, "item_" .. iter_14_0)

			var_14_1 = arg_14_0:getUserDataTb_()
			var_14_1.go = var_14_2
			var_14_1.icon = IconMgr.instance:getCommonPropItemIcon(var_14_2)

			var_14_1.icon:setMOValue(MaterialEnum.MaterialType.Building, iter_14_1.buildingId, 1, nil, true)
			var_14_1.icon:setCountFontSize(40)
			var_14_1.icon:showStackableNum2()
			var_14_1.icon:isShowEffect(true)
			var_14_1.icon:isShowCount(false)

			var_14_0.itemList[iter_14_0] = var_14_1
		else
			var_14_1.icon:setMOValue(MaterialEnum.MaterialType.Building, iter_14_1.buildingId, 1, nil, true)
		end

		gohelper.setActive(var_14_1.go, true)
	end

	gohelper.setActive(var_14_0.itemGo, true)
	gohelper.setActive(var_14_0.go, true)
end

function var_0_0._setBuildingMaxLevelItem(arg_15_0, arg_15_1, arg_15_2)
	if not LuaUtil.tableNotEmpty(arg_15_1) then
		return
	end

	local var_15_0 = arg_15_0:_getInfoItem(arg_15_2)

	var_15_0.co = RoomTradeConfig.instance:getLevelUnlockCo(arg_15_2)
	var_15_0.descTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_15_0.co.levelupDes, arg_15_1.num.cur - arg_15_1.num.last)
	var_15_0.type = arg_15_2

	if not var_15_0.itemList then
		var_15_0.itemList = arg_15_0:getUserDataTb_()
	end

	local var_15_1 = var_15_0.itemList[1]

	if not var_15_1 then
		local var_15_2 = gohelper.cloneInPlace(var_15_0.goicon, "item_" .. 1)

		var_15_1 = arg_15_0:getUserDataTb_()
		var_15_1.go = var_15_2
		var_15_1.icon = IconMgr.instance:getCommonPropItemIcon(var_15_2, "item_" .. 1)

		var_15_1.icon:setMOValue(MaterialEnum.MaterialType.Building, arg_15_1.buildingId, 1, nil, true)
		var_15_1.icon:setCountFontSize(40)
		var_15_1.icon:showStackableNum2()
		var_15_1.icon:isShowEffect(true)
		var_15_1.icon:isShowCount(false)

		var_15_0.itemList[1] = var_15_1
	else
		var_15_1.icon:setMOValue(MaterialEnum.MaterialType.Building, arg_15_1.buildingId, 1, nil, true)
	end

	gohelper.setActive(var_15_1.go, true)
	gohelper.setActive(var_15_0.itemGo, true)
	gohelper.setActive(var_15_0.go, true)
end

function var_0_0.setNormalItem(arg_16_0, arg_16_1, arg_16_2)
	if not LuaUtil.tableNotEmpty(arg_16_1) then
		return
	end

	local var_16_0 = arg_16_0:_getInfoItem(arg_16_2)

	var_16_0.type = arg_16_2
	var_16_0.co = RoomTradeConfig.instance:getLevelUnlockCo(arg_16_2)
	var_16_0.type = arg_16_2

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_1 = iter_16_1.num
		local var_16_2 = RoomTradeConfig.instance:getLevelUnlockCo(arg_16_2)

		if LuaUtil.tableNotEmpty(var_16_1) then
			var_16_0.descTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_16_2.levelupDes, var_16_1.cur - var_16_1.last)
		else
			var_16_0.descTxt.text = var_16_2.levelupDes
		end
	end

	gohelper.setActive(var_16_0.go, true)
end

function var_0_0._getInfoItem(arg_17_0, arg_17_1)
	if not arg_17_0._unlockInfoItems then
		arg_17_0._unlockInfoItems = arg_17_0:getUserDataTb_()
	end

	local var_17_0 = arg_17_0._unlockInfoItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = {}

		local var_17_1 = gohelper.cloneInPlace(arg_17_0._goinfo, "item_" .. arg_17_1)

		var_17_0.go = var_17_1
		var_17_0.descTxt = gohelper.findChildText(var_17_1, "desc")
		var_17_0.itemGo = gohelper.findChild(var_17_1, "item")
		var_17_0.bgGo = gohelper.findChild(var_17_1, "bg")
		var_17_0.goicon = gohelper.findChild(var_17_1, "item/go_icon")

		gohelper.setActive(var_17_0.goicon, false)

		arg_17_0._unlockInfoItems[arg_17_1] = var_17_0
	end

	return var_17_0
end

return var_0_0
