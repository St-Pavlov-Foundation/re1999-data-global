module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnchantBagItem", package.seeall)

local var_0_0 = class("V1a6_CachotEnchantBagItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")

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
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = arg_6_0:getOrCreateCollectionItem()

	if var_6_0 then
		var_6_0:onUpdateMO(arg_6_0._mo)
	end
end

function var_0_0.getOrCreateCollectionItem(arg_7_0)
	if not arg_7_0._bagItem then
		local var_7_0 = arg_7_0._view.viewContainer._viewSetting.otherRes[1]
		local var_7_1 = arg_7_0._view:getResInst(var_7_0, arg_7_0._goscale, "collectionitem")

		arg_7_0._bagItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, V1a6_CachotCollectionBagItem)

		arg_7_0._bagItem:setClickCallBack(arg_7_0.clikCallBack, arg_7_0)
	end

	return arg_7_0._bagItem
end

function var_0_0.clikCallBack(arg_8_0)
	V1a6_CachotCollectionEnchantController.instance:onSelectBagItem(arg_8_0._index)
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	if arg_9_0._bagItem then
		arg_9_0._bagItem:onSelect(arg_9_1)
	end
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._bagItem then
		arg_10_0._bagItem:onDestroyView()

		arg_10_0._bagItem = nil
	end
end

return var_0_0
