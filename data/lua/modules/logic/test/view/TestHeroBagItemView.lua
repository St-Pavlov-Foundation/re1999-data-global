module("modules.logic.test.view.TestHeroBagItemView", package.seeall)

local var_0_0 = class("TestHeroBagItemView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onScrollItemRefreshData(arg_3_0, arg_3_1)
	arg_3_0._data = arg_3_1

	if arg_3_0._heroItem then
		arg_3_0._heroItem:onUpdateMO(arg_3_0._data)
	end
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:com_loadAsset("ui/viewres/common/item/commonheroitemnew.prefab", arg_4_0._loaded)
end

function var_0_0._loaded(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetResource()
	local var_5_1 = gohelper.clone(var_5_0, arg_5_0.viewGO)

	arg_5_0._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, CommonHeroItem)

	arg_5_0._heroItem:addClickListener(arg_5_0._onItemClick, arg_5_0)
end

function var_0_0._onItemClick(arg_6_0)
	logError("点击了英雄id:" .. arg_6_0._data.heroId)
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0._heroItem then
		arg_7_0._heroItem:onDestroy()

		arg_7_0._heroItem = nil
	end
end

return var_0_0
