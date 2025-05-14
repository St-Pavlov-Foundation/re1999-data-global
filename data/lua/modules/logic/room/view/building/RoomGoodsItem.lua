module("modules.logic.room.view.building.RoomGoodsItem", package.seeall)

local var_0_0 = class("RoomGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._gorarecircle = gohelper.findChild(arg_1_0.viewGO, "#go_rarecircle")
	arg_1_0._gocountbg = gohelper.findChild(arg_1_0.viewGO, "countbg")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "countbg/#txt_count")
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._isEnableClick = true
	arg_4_0._rareCircleTabs = arg_4_0:getUserDataTb_()

	for iter_4_0 = 5, 4, -1 do
		local var_4_0 = gohelper.findChild(arg_4_0._gorarecircle, "#go_rare" .. iter_4_0)
		local var_4_1 = {
			id = iter_4_0,
			go = var_4_0
		}

		table.insert(arg_4_0._rareCircleTabs, var_4_1)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0:setMOValue(arg_5_1.materilType, arg_5_1.materilId, arg_5_1.quantity)
end

function var_0_0.setMOValue(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0._itemType = tonumber(arg_6_1)
	arg_6_0._itemId = arg_6_2
	arg_6_0._itemQuantity = tonumber(arg_6_3)

	local var_6_0, var_6_1 = ItemModel.instance:getItemConfigAndIcon(arg_6_0._itemType, arg_6_0._itemId)

	arg_6_0._config = var_6_0

	arg_6_0._simageicon:LoadImage(var_6_1)

	local var_6_2 = var_6_0.rare and var_6_0.rare or 5

	UISpriteSetMgr.instance:setRoomSprite(arg_6_0._imagerare, "bg_wupindi_" .. tostring(ItemEnum.Color[var_6_2]))

	if var_6_2 >= 4 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._rareCircleTabs) do
			gohelper.setActive(iter_6_1.go, iter_6_1.id == var_6_2)
		end
	end

	arg_6_0._colorStr = arg_6_4

	if string.nilorempty(arg_6_0._colorStr) then
		arg_6_0._txtcount.text = GameUtil.numberDisplay(arg_6_0._itemQuantity)
	else
		arg_6_0._txtcount.text = string.format("<color=%s>%s</color>", arg_6_0._colorStr, GameUtil.numberDisplay(arg_6_0._itemQuantity))
	end
end

function var_0_0.isEnableClick(arg_7_0, arg_7_1)
	arg_7_0._isEnableClick = arg_7_1
end

function var_0_0.setRecordFarmItem(arg_8_0, arg_8_1)
	arg_8_0.needSetRecordFarm = arg_8_1
end

function var_0_0.setConsume(arg_9_0, arg_9_1)
	arg_9_0._isConsume = arg_9_1
end

function var_0_0._onClick(arg_10_0, arg_10_1)
	if not arg_10_0._isEnableClick and not arg_10_1 then
		return
	end

	if arg_10_0._customCallback then
		return arg_10_0._customCallback(arg_10_0.params)
	end

	if arg_10_0.needSetRecordFarm then
		local var_10_0 = {
			type = arg_10_0._itemType,
			id = arg_10_0._itemId,
			quantity = arg_10_0._itemQuantity,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		}

		MaterialTipController.instance:showMaterialInfo(arg_10_0._itemType, arg_10_0._itemId, arg_10_0._inPack, nil, nil, var_10_0, nil, arg_10_0._itemQuantity, arg_10_0._isConsume, arg_10_0.jumpFinishCallback, arg_10_0.jumpFinishCallbackObj, arg_10_0.jumpFinishCallbackParam)
	else
		MaterialTipController.instance:showMaterialInfo(arg_10_0._itemType, arg_10_0._itemId, arg_10_0._inPack, nil, nil)
	end
end

function var_0_0.customOnClickCallback(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._customCallback = arg_11_1
	arg_11_0.params = arg_11_2
end

function var_0_0.setCountText(arg_12_0, arg_12_1)
	arg_12_0._txtcount.text = arg_12_1
end

function var_0_0.canShowRareCircle(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._gorarecircle, arg_13_1)
end

function var_0_0.setIconPos(arg_14_0, arg_14_1, arg_14_2)
	recthelper.setAnchor(arg_14_0._simageicon.transform, arg_14_1, arg_14_2)
end

function var_0_0.setIconScale(arg_15_0, arg_15_1)
	transformhelper.setLocalScale(arg_15_0._simageicon.transform, arg_15_1, arg_15_1, arg_15_1)
end

function var_0_0.setCountPos(arg_16_0, arg_16_1, arg_16_2)
	recthelper.setAnchor(arg_16_0._gocountbg.transform, arg_16_1, arg_16_2)
end

function var_0_0.setCountScale(arg_17_0, arg_17_1)
	transformhelper.setLocalScale(arg_17_0._gocountbg.transform, arg_17_1, arg_17_1, arg_17_1)
end

function var_0_0.isShowCount(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._gocountbg, arg_18_1)
end

function var_0_0.setGrayscale(arg_19_0, arg_19_1)
	ZProj.UGUIHelper.SetGrayscale(arg_19_0._simageicon.gameObject, arg_19_1)
	ZProj.UGUIHelper.SetGrayscale(arg_19_0._imagerare.gameObject, arg_19_1)
end

function var_0_0.setJumpFinishCallback(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0.jumpFinishCallback = arg_20_1
	arg_20_0.jumpFinishCallbackObj = arg_20_2
	arg_20_0.jumpFinishCallbackParam = arg_20_3
end

function var_0_0.onSelect(arg_21_0, arg_21_1)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._simageicon then
		arg_22_0._simageicon:UnLoadImage()
	end
end

return var_0_0
