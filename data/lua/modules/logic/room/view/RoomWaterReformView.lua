module("modules.logic.room.view.RoomWaterReformView", package.seeall)

local var_0_0 = class("RoomWaterReformView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_save")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_reset")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_tip")
	arg_1_0._goblockContent = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent")
	arg_1_0._gowater = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_water")
	arg_1_0._btnwater = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_water")
	arg_1_0._goselectwater = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_water/#go_select")
	arg_1_0._gounselectwater = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_water/#go_unselect")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_block")
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_block")
	arg_1_0._goselectblock = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_block/#go_select")
	arg_1_0._gounselectblock = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_block/#go_unselect")
	arg_1_0._goblockMode = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_blockMode")
	arg_1_0._dropblockselectmode = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#drop_filter")
	arg_1_0._goclear = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#go_clear")
	arg_1_0._btnblockclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#go_clear/#btn_clear")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._simagecostitem = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_topright/container/resource/icon")
	arg_1_0._txtcostitem = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/container/resource/txt_quantity")
	arg_1_0._txtchangenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/container/resource/txt_quantity/txt_change")
	arg_1_0._btncostclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/container/resource/#btn_click")
	arg_1_0._btninitblockcolor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottom/#go_blockContent/layout/#btn_initial")
	arg_1_0._goinitblockcolornum = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent/layout/#btn_initial/#go_num")
	arg_1_0._txtinitblockcolornum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_bottom/#go_blockContent/layout/#btn_initial/#go_num/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnblockclear:AddClickListener(arg_2_0._btnblockClearOnClick, arg_2_0)
	arg_2_0._dropblockselectmode:AddOnValueChanged(arg_2_0.onBlockSelectModeValueChange, arg_2_0)
	arg_2_0._btncostclick:AddClickListener(arg_2_0._onCostItemClick, arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnModeOnClick, arg_2_0, RoomEnum.ReformMode.Block)
	arg_2_0._btnwater:AddClickListener(arg_2_0._btnModeOnClick, arg_2_0, RoomEnum.ReformMode.Water)
	arg_2_0._btninitblockcolor:AddClickListener(arg_2_0._btninitblockcolorOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_2_0._waterReformShowChanged, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.OnReformChangeSelectedEntity, arg_2_0._onSelectedChange, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, arg_2_0._onRoomBlockReform, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.OnChangReformMode, arg_2_0._onChangeReformMode, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnblockclear:RemoveClickListener()
	arg_3_0._dropblockselectmode:RemoveOnValueChanged()
	arg_3_0._btncostclick:RemoveClickListener()
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnwater:RemoveClickListener()
	arg_3_0._btninitblockcolor:RemoveClickListener()
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_3_0._waterReformShowChanged, arg_3_0)
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.OnReformChangeSelectedEntity, arg_3_0._onSelectedChange, arg_3_0)
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, arg_3_0._onRoomBlockReform, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.OnChangReformMode, arg_3_0._onChangeReformMode, arg_3_0)
end

function var_0_0._btnsaveOnClick(arg_4_0)
	RoomWaterReformController.instance:saveReform()
end

function var_0_0._btnresetOnClick(arg_5_0)
	local var_5_0 = RoomWaterReformModel.instance:hasChangedWaterType()
	local var_5_1 = RoomWaterReformModel.instance:hasChangedBlockColor()

	if var_5_0 or var_5_1 then
		GameFacade.showMessageBox(MessageBoxIdDefine.WaterReformResetConfirm, MsgBoxEnum.BoxType.Yes_No, arg_5_0._confirmReset, nil, nil, arg_5_0)
	else
		GameFacade.showToast(ToastEnum.NoWaterReform)
	end
end

function var_0_0._confirmReset(arg_6_0)
	RoomWaterReformController.instance:resetReform()
end

function var_0_0._btnblockClearOnClick(arg_7_0)
	RoomWaterReformController.instance:clearSelectBlock()
end

function var_0_0.onBlockSelectModeShow(arg_8_0)
	transformhelper.setLocalScale(arg_8_0._transblockDropArrow, 1, -1, 1)
end

function var_0_0.onBlockSelectModeValueChange(arg_9_0, arg_9_1)
	if not arg_9_0.initBlockSelectModeDrop then
		return
	end

	local var_9_0 = arg_9_0.blockSelectModeList and arg_9_0.blockSelectModeList[arg_9_1 + 1]

	RoomWaterReformController.instance:changeBlockSelectMode(var_9_0)
end

function var_0_0.onBlockSelectModeHide(arg_10_0)
	transformhelper.setLocalScale(arg_10_0._transblockDropArrow, 1, 1, 1)
end

function var_0_0._onCostItemClick(arg_11_0)
	MaterialTipController.instance:showMaterialInfo(arg_11_0._costItemType, arg_11_0._costItemId)
end

function var_0_0._btnModeOnClick(arg_12_0, arg_12_1)
	RoomWaterReformController.instance:changeReformMode(arg_12_1)
end

function var_0_0._btninitblockcolorOnClick(arg_13_0)
	RoomWaterReformController.instance:selectBlockColorType(RoomWaterReformModel.InitBlockColor)
end

function var_0_0._waterReformShowChanged(arg_14_0)
	if RoomWaterReformModel.instance:isWaterReform() then
		arg_14_0._animatorPlayer:Play("open")
		arg_14_0:refreshUI()
	else
		arg_14_0._animatorPlayer:Play("close", arg_14_0._showBackBlock, arg_14_0)
	end
end

function var_0_0._showBackBlock(arg_15_0)
	arg_15_0.viewContainer:selectBlockOpTab(RoomEnum.RoomViewBlockOpMode.BackBlock)
end

function var_0_0._onSelectedChange(arg_16_0)
	arg_16_0:refreshSelectTip()
	arg_16_0:refreshDefaultSelect()
end

function var_0_0._onRoomBlockReform(arg_17_0)
	arg_17_0:refreshCostItemQuantity()
end

function var_0_0._onItemChanged(arg_18_0)
	arg_18_0:refreshCostItemQuantity()
end

function var_0_0._onChangeReformMode(arg_19_0)
	arg_19_0:refreshReformMode()
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_20_0.viewGO)
	arg_20_0._contentAnimator = arg_20_0._goblockContent:GetComponent(RoomEnum.ComponentType.Animator)
	arg_20_0._contentAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_20_0._goblockContent)
	arg_20_0._transblockDropArrow = gohelper.findChild(arg_20_0.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#drop_filter/Arrow").transform

	arg_20_0:initBlockSelectModeDropFilter()

	local var_20_0 = UnlockVoucherConfig.instance:getRoomColorConst(UnlockVoucherEnum.ConstId.RoomBlockColorReformCostItem, "#", true)

	arg_20_0._costItemType = var_20_0[1]
	arg_20_0._costItemId = var_20_0[2]

	local var_20_1, var_20_2 = ItemModel.instance:getItemConfigAndIcon(arg_20_0._costItemType, arg_20_0._costItemId)

	arg_20_0._simagecostitem:LoadImage(var_20_2)
	gohelper.setActive(arg_20_0._goinitblockcolornum, false)
end

function var_0_0.initBlockSelectModeDropFilter(arg_21_0)
	arg_21_0.dropBlockSelectModeExtend = DropDownExtend.Get(arg_21_0._dropblockselectmode.gameObject)

	arg_21_0.dropBlockSelectModeExtend:init(arg_21_0.onBlockSelectModeShow, arg_21_0.onBlockSelectModeHide, arg_21_0)

	arg_21_0.blockSelectModeList = {
		RoomEnum.BlockColorReformSelectMode.Single,
		RoomEnum.BlockColorReformSelectMode.Multiple,
		RoomEnum.BlockColorReformSelectMode.All
	}

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.blockSelectModeList) do
		local var_21_1 = RoomEnum.BlockColorReformSelectModeName[iter_21_1]
		local var_21_2 = luaLang(var_21_1)

		table.insert(var_21_0, var_21_2)
	end

	arg_21_0._dropblockselectmode:ClearOptions()
	arg_21_0._dropblockselectmode:AddOptions(var_21_0)

	arg_21_0.initBlockSelectModeDrop = true
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0.onOpen(arg_23_0)
	arg_23_0._contentAnimatorPlayer:Play("open")

	local var_23_0 = 0
	local var_23_1 = RoomWaterReformModel.instance:getBlockColorReformSelectMode()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.blockSelectModeList) do
		if var_23_1 == iter_23_1 then
			var_23_0 = iter_23_0 - 1

			break
		end
	end

	arg_23_0._dropblockselectmode:SetValue(var_23_0)
	arg_23_0:refreshUI()
end

function var_0_0.refreshUI(arg_24_0)
	arg_24_0:refreshReformMode()
	arg_24_0:refreshDefaultSelect()
	arg_24_0:refreshSelectTip()
	arg_24_0:refreshCostItemQuantity()
end

function var_0_0.refreshReformMode(arg_25_0)
	local var_25_0 = RoomWaterReformModel.instance:getReformMode()
	local var_25_1 = var_25_0 == RoomEnum.ReformMode.Water
	local var_25_2 = var_25_0 == RoomEnum.ReformMode.Block

	gohelper.setActive(arg_25_0._goselectwater, var_25_1)
	gohelper.setActive(arg_25_0._gounselectwater, not var_25_1)
	gohelper.setActive(arg_25_0._btninitblockcolor, var_25_2)
	gohelper.setActive(arg_25_0._goblockMode, var_25_2)
	gohelper.setActive(arg_25_0._goselectblock, var_25_2)
	gohelper.setActive(arg_25_0._gounselectblock, not var_25_2)
end

function var_0_0.refreshDefaultSelect(arg_26_0)
	local var_26_0 = RoomWaterReformModel.instance:getReformMode()
	local var_26_1 = var_26_0 == RoomEnum.ReformMode.Water
	local var_26_2 = var_26_0 == RoomEnum.ReformMode.Block

	if var_26_1 then
		local var_26_3 = RoomWaterReformListModel.instance:getDefaultSelectWaterType()

		RoomWaterReformListModel.instance:setSelectWaterType(var_26_3)
	elseif var_26_2 then
		local var_26_4 = RoomWaterReformListModel.instance:getDefaultSelectBlockColor()

		RoomWaterReformListModel.instance:setSelectBlockColor(var_26_4)
	end
end

function var_0_0.refreshSelectTip(arg_27_0)
	local var_27_0 = false
	local var_27_1 = RoomWaterReformModel.instance:getReformMode()

	if var_27_1 == RoomEnum.ReformMode.Water then
		var_27_0 = RoomWaterReformModel.instance:hasSelectWaterArea()
	elseif var_27_1 == RoomEnum.ReformMode.Block then
		var_27_0 = RoomWaterReformModel.instance:hasSelectedBlock()
	end

	gohelper.setActive(arg_27_0._goclear, var_27_0)
	gohelper.setActive(arg_27_0._gotip, not var_27_0)
end

function var_0_0.refreshCostItemQuantity(arg_28_0)
	local var_28_0 = ItemModel.instance:getItemQuantity(arg_28_0._costItemType, arg_28_0._costItemId)

	arg_28_0._txtcostitem.text = var_28_0

	local var_28_1 = RoomWaterReformModel.instance:getChangedBlockColorCount(nil, RoomWaterReformModel.InitBlockColor)

	arg_28_0._txtchangenum.text = string.format("-%s", var_28_1)

	gohelper.setActive(arg_28_0._txtchangenum, var_28_1 > 0)
end

function var_0_0.onClose(arg_29_0)
	return
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0._simagecostitem:UnLoadImage()

	if arg_30_0.dropBlockSelectModeExtend then
		arg_30_0.dropBlockSelectModeExtend:dispose()
	end
end

return var_0_0
