module("modules.logic.rouge.view.RougeCollectionBagItem", package.seeall)

local var_0_0 = class("RougeCollectionBagItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.parentViewInst = arg_1_1
	arg_1_0.viewGO = arg_1_2
	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "go_pos")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "right/txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/Scroll View/Viewport/Content/txt_desc")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_equip")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_0.viewGO, "#go_selectframe")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0:AddDragListeners()
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)

	arg_2_0._canvasgroup = gohelper.onceAddComponent(arg_2_0.viewGO, gohelper.Type_CanvasGroup)

	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, arg_2_0.failed2PlaceSlotCollection, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_2_0._updateCollectionEnchant, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateCollectionAttr, arg_2_0.updateCollectionAttr, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_2_0._onSwitchCollectionInfoType, arg_2_0)
	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SelectCollection, arg_2_0._selectCollection, arg_2_0)
end

function var_0_0.AddDragListeners(arg_3_0)
	arg_3_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_3_0.viewGO)

	arg_3_0._drag:AddDragBeginListener(arg_3_0._onDragBegin, arg_3_0)
	arg_3_0._drag:AddDragListener(arg_3_0._onDrag, arg_3_0)
	arg_3_0._drag:AddDragEndListener(arg_3_0._onDragEnd, arg_3_0)
end

function var_0_0.releaseDragListeners(arg_4_0)
	if arg_4_0._drag then
		arg_4_0._drag:RemoveDragBeginListener()
		arg_4_0._drag:RemoveDragEndListener()
		arg_4_0._drag:RemoveDragListener()

		arg_4_0._drag = nil
	end
end

function var_0_0._btndetailOnClick(arg_5_0)
	local var_5_0 = {
		useCloseBtn = false,
		collectionId = arg_5_0._mo.id,
		viewPosition = RougeEnum.CollectionTipPos.Bag,
		source = RougeEnum.OpenCollectionTipSource.BagArea
	}

	RougeController.instance:openRougeCollectionTipView(var_5_0)
	RougeCollectionChessController.instance:selectCollection(arg_5_0._mo.id)
end

function var_0_0._btnequipOnClick(arg_6_0)
	RougeCollectionChessController.instance:autoPlaceCollection2SlotArea(arg_6_0._mo.id)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = RougeCollectionHelper.isCanDragCollection()

	arg_7_0._isDraging = var_7_0

	if not var_7_0 then
		return
	end

	arg_7_0:setCanvasGroupVisible(false)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, arg_7_0._mo, arg_7_2)
end

function var_0_0._onDrag(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, arg_8_2)
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, arg_9_2)
end

local var_0_1 = 160
local var_0_2 = 160

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	if not arg_10_0._itemIcon then
		local var_10_0 = ViewMgr.instance:getSetting(ViewName.RougeCollectionChessView)
		local var_10_1 = arg_10_0.parentViewInst:getResInst(var_10_0.otherRes[1], arg_10_0._gopos, "itemicon")

		arg_10_0._itemIcon = RougeCollectionEnchantIconItem.New(var_10_1)

		arg_10_0._itemIcon:setCollectionIconSize(var_0_1, var_0_2)
	end

	arg_10_0._itemIcon:onUpdateMO(arg_10_0._mo)

	local var_10_2 = arg_10_0._mo:getAllEnchantCfgId()

	arg_10_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(arg_10_0._mo.cfgId, var_10_2)

	arg_10_0:refreshCollectionDesc()
	gohelper.setActive(arg_10_0._goselectframe, false)
	arg_10_0:setItemVisible(true)
end

function var_0_0.refreshCollectionDesc(arg_11_0)
	if not arg_11_0._mo then
		return
	end

	local var_11_0 = RougeCollectionDescHelper.getShowDescTypesWithoutText()
	local var_11_1 = RougeCollectionDescHelper.getExtraParams_KeepAllActive()

	RougeCollectionDescHelper.setCollectionDescInfos4(arg_11_0._mo.id, arg_11_0._txtdesc, var_11_0, var_11_1)
end

function var_0_0.setItemVisible(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0.viewGO, arg_12_1)
	arg_12_0:setCanvasGroupVisible(arg_12_1)
end

function var_0_0.setCanvasGroupVisible(arg_13_0, arg_13_1)
	arg_13_0._canvasgroup.alpha = arg_13_1 and 1 or 0
	arg_13_0._canvasgroup.interactable = arg_13_1
	arg_13_0._canvasgroup.blocksRaycasts = arg_13_1
end

function var_0_0.failed2PlaceSlotCollection(arg_14_0, arg_14_1)
	if arg_14_0._mo and arg_14_0._mo.id == arg_14_1 then
		arg_14_0:setItemVisible(true)
	end
end

function var_0_0._selectCollection(arg_15_0)
	local var_15_0 = arg_15_0._mo and arg_15_0._mo.id
	local var_15_1 = RougeCollectionBagListModel.instance:isCollectionSelect(var_15_0)

	gohelper.setActive(arg_15_0._goselectframe, var_15_1)
end

function var_0_0.updateCollectionAttr(arg_16_0, arg_16_1)
	if (arg_16_0._mo and arg_16_0._mo.id) == arg_16_1 then
		arg_16_0:refreshCollectionDesc()
	end
end

function var_0_0._onSwitchCollectionInfoType(arg_17_0)
	arg_17_0:refreshCollectionDesc()
end

function var_0_0._updateCollectionEnchant(arg_18_0, arg_18_1)
	if not arg_18_0._mo or arg_18_0._mo.id ~= arg_18_1 then
		return
	end

	arg_18_0:refreshCollectionDesc()
end

function var_0_0.reset(arg_19_0)
	arg_19_0._mo = nil
	arg_19_0._isDraging = false

	arg_19_0:setItemVisible(false)
end

function var_0_0.destroy(arg_20_0)
	arg_20_0:releaseDragListeners()

	if arg_20_0._itemIcon then
		arg_20_0._itemIcon:destroy()

		arg_20_0._itemIcon = nil
	end

	arg_20_0._btndetail:RemoveClickListener()
	arg_20_0._btnequip:RemoveClickListener()
	arg_20_0:__onDispose()
end

return var_0_0
