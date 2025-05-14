module("modules.logic.rouge.view.RougeCollectionOverListItem", package.seeall)

local var_0_0 = class("RougeCollectionOverListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = {
		interactable = false,
		collectionId = arg_4_0._mo.id,
		viewPosition = RougeEnum.CollectionTipViewPlacePos,
		source = RougeEnum.OpenCollectionTipSource.SlotArea
	}

	RougeController.instance:openRougeCollectionTipView(var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_Animator)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	if RougeCollectionConfig.instance:getCollectionCfg(arg_7_0._mo.cfgId) then
		arg_7_0:refreshCollectionIcon()

		local var_7_0 = arg_7_0._mo:getAllEnchantCfgId()

		arg_7_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(arg_7_0._mo.cfgId, var_7_0)

		local var_7_1 = RougeCollectionDescHelper.getShowDescTypesWithoutText()
		local var_7_2 = RougeCollectionDescHelper.getExtraParams_KeepAllActive()

		RougeCollectionDescHelper.setCollectionDescInfos4(arg_7_0._mo.id, arg_7_0._txtdec, var_7_1, var_7_2)
	end
end

local var_0_1 = 160
local var_0_2 = 160

function var_0_0.refreshCollectionIcon(arg_8_0)
	if not arg_8_0._itemIcon then
		local var_8_0 = ViewMgr.instance:getSetting(ViewName.RougeCollectionOverView)
		local var_8_1 = arg_8_0._view:getResInst(var_8_0.otherRes[1], arg_8_0._goicon, "itemicon")

		arg_8_0._itemIcon = RougeCollectionEnchantIconItem.New(var_8_1)

		arg_8_0._itemIcon:setCollectionIconSize(var_0_1, var_0_2)
	end

	arg_8_0._itemIcon:onUpdateMO(arg_8_0._mo)
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0._animator
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._itemIcon then
		arg_10_0._itemIcon:destroy()

		arg_10_0._itemIcon = nil
	end
end

return var_0_0
