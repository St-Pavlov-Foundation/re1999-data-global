module("modules.logic.room.view.common.RoomThemeTipItem", package.seeall)

local var_0_0 = class("RoomThemeTipItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._hideSourcesShowTypeMap = {
		[RoomEnum.SourcesShowType.Cobrand] = true
	}

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gobuildingicon = gohelper.findChild(arg_4_0.viewGO, "go_buildingicon")
	arg_4_0._goplaneicon = gohelper.findChild(arg_4_0.viewGO, "go_planeicon")
	arg_4_0._txtname = gohelper.findChildText(arg_4_0.viewGO, "txt_name")
	arg_4_0._txtstate = gohelper.findChildText(arg_4_0.viewGO, "txt_state")
	arg_4_0._gosource = gohelper.findChild(arg_4_0.viewGO, "go_source")
	arg_4_0._gosourceItem = gohelper.findChild(arg_4_0.viewGO, "go_source/go_sourceItem")
	arg_4_0._sourceTab = arg_4_0:getUserDataTb_()

	gohelper.setActive(arg_4_0._gosourceItem, false)
end

function var_0_0._refreshUI(arg_5_0)
	local var_5_0 = arg_5_0._themeItemMO:getItemQuantity()
	local var_5_1 = var_5_0 >= arg_5_0._themeItemMO.itemNum

	gohelper.setActive(arg_5_0._gobuildingicon, arg_5_0._themeItemMO.materialType == MaterialEnum.MaterialType.Building)
	gohelper.setActive(arg_5_0._goplaneicon, arg_5_0._themeItemMO.materialType == MaterialEnum.MaterialType.BlockPackage)

	local var_5_2 = arg_5_0._themeItemMO:getItemConfig()

	for iter_5_0, iter_5_1 in pairs(arg_5_0._sourceTab) do
		gohelper.setActive(iter_5_1.go, false)
	end

	arg_5_0._txtname.text = var_5_2 and var_5_2.name or ""
	arg_5_0._txtstate.text = arg_5_0:_getStateStr(arg_5_0._themeItemMO.itemNum, var_5_0)

	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._txtstate, var_5_1 and "#65B96F" or "#D97373")

	if not string.nilorempty(var_5_2.sourcesType) then
		local var_5_3 = string.splitToNumber(var_5_2.sourcesType, "#")

		arg_5_0:_sortSource(var_5_3)

		for iter_5_2, iter_5_3 in pairs(var_5_3) do
			local var_5_4 = RoomConfig.instance:getSourcesTypeConfig(iter_5_3)

			if var_5_4 and (not var_5_4.showType or not arg_5_0._hideSourcesShowTypeMap[var_5_4.showType]) then
				local var_5_5 = arg_5_0:_getSourceItem(iter_5_3)

				gohelper.setActive(var_5_5.go, true)

				var_5_5.txt.text = string.format("<color=%s>%s</color>", var_5_4.nameColor, var_5_4.name)

				UISpriteSetMgr.instance:setRoomSprite(var_5_5.bg, var_5_4.bgIcon)
				SLFramework.UGUI.GuiHelper.SetColor(var_5_5.bg, string.nilorempty(var_5_4.bgColor) and "#FFFFFF" or var_5_4.bgColor)
			elseif var_5_4 == nil then
				logError(string.format("小屋主题\"export_获得类型\"缺少配置。id:%s", iter_5_3))
			end
		end
	end
end

function var_0_0._getSourceItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._sourceTab[arg_6_1]

	if not var_6_0 then
		var_6_0 = arg_6_0:getUserDataTb_()
		var_6_0.go = gohelper.clone(arg_6_0._gosourceItem, arg_6_0._gosource, "source" .. arg_6_1)
		var_6_0.txt = gohelper.findChildText(var_6_0.go, "txt")
		var_6_0.bg = gohelper.findChildImage(var_6_0.go, "bg")

		gohelper.setActive(var_6_0.go, false)

		arg_6_0._sourceTab[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0._sortSource(arg_7_0, arg_7_1)
	table.sort(arg_7_1, var_0_0._sortFunc)
end

function var_0_0._sortFunc(arg_8_0, arg_8_1)
	local var_8_0 = RoomConfig.instance:getSourcesTypeConfig(arg_8_0).order
	local var_8_1 = RoomConfig.instance:getSourcesTypeConfig(arg_8_1).order

	if var_8_0 ~= var_8_1 then
		return var_8_0 < var_8_1
	end
end

function var_0_0._getStateStr(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	var_9_0 = arg_9_1 <= arg_9_2

	return string.format("%s/%s", arg_9_2, arg_9_1)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._themeItemMO = arg_10_1

	arg_10_0:_refreshUI()
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
