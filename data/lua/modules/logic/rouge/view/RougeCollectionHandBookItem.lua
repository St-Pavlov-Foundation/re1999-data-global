module("modules.logic.rouge.view.RougeCollectionHandBookItem", package.seeall)

local var_0_0 = class("RougeCollectionHandBookItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.viewGO, "normal/#image_bg")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "normal/#txt_index")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "normal/#simage_collection")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "go_selected")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_click")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._editableRemoveEvents(arg_4_0)
	return
end

function var_0_0._btnclickOnClick(arg_5_0)
	RougeController.instance:dispatchEvent(RougeEvent.OnSelectCollectionHandBookItem, arg_5_0._mo.id)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_7_0._mo.product)

	UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imagebg, "rouge_episode_collectionbg_" .. tostring(var_7_0.showRare))

	local var_7_1 = RougeCollectionHandBookListModel.instance:isCurSelectTargetId(arg_7_0._mo.id)

	gohelper.setActive(arg_7_0._goselected, var_7_1)
	arg_7_0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_7_0._mo.product))

	arg_7_0._txtindex.text = arg_7_0._index
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goselected, arg_8_1)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagecollection:UnLoadImage()
end

return var_0_0
