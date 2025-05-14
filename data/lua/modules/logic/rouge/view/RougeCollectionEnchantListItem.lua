module("modules.logic.rouge.view.RougeCollectionEnchantListItem", package.seeall)

local var_0_0 = class("RougeCollectionEnchantListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "image_rare")
	arg_1_0._simagecollectionicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_collectionicon")
	arg_1_0._goenchant = gohelper.findChild(arg_1_0.viewGO, "go_enchant")
	arg_1_0._simageenchanticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_enchant/simage_enchanticon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "btn_click")

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
	local var_4_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()
	local var_4_1 = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	RougeCollectionEnchantController.instance:onSelectEnchantItem(var_4_1, arg_4_0._mo.id, var_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.CollectionEnchant)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_7_0._mo.cfgId)

	if var_7_0 then
		arg_7_0._simagecollectionicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_7_0._mo.cfgId))
		UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imagerare, string.format("rouge_collection_grid_big_%s", var_7_0.showRare))
		arg_7_0:refreshCollectionUI()
	end
end

function var_0_0.refreshCollectionUI(arg_8_0)
	local var_8_0 = arg_8_0._mo:getEnchantTargetId()
	local var_8_1 = RougeCollectionModel.instance:getCollectionByUid(var_8_0)

	gohelper.setActive(arg_8_0._goenchant, var_8_1 ~= nil)

	if var_8_1 then
		arg_8_0._simageenchanticon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_8_1.cfgId))
	end
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagecollectionicon:UnLoadImage()
	arg_10_0._simageenchanticon:UnLoadImage()
end

return var_0_0
