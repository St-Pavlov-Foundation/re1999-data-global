module("modules.logic.rouge.view.RougeCollectionListDropdownItem", package.seeall)

local var_0_0 = class("RougeCollectionListDropdownItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageruanpan = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_ruanpan")
	arg_1_0._imageruanpan = gohelper.findChildImage(arg_1_0.viewGO, "simage_ruanpan")
	arg_1_0._color = arg_1_0._imageruanpan.color
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click = gohelper.getClickWithDefaultAudio(arg_2_0.viewGO)

	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._editableRemoveEvents(arg_4_0)
	return
end

function var_0_0._onClick(arg_5_0)
	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionDropItem, arg_5_0._mo)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0._simageruanpan:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_6_0._mo.id), arg_6_0._onLoadImage, arg_6_0)
	arg_6_0:_onLoadImage()
end

function var_0_0._onLoadImage(arg_7_0)
	local var_7_0 = RougeFavoriteModel.instance:collectionIsUnlock(arg_7_0._mo.id)

	arg_7_0._color.a = var_7_0 and 1 or 0.8
	arg_7_0._imageruanpan.color = arg_7_0._color
end

return var_0_0
