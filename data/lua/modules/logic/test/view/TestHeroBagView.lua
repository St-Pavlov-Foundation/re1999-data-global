module("modules.logic.test.view.TestHeroBagView", package.seeall)

local var_0_0 = class("TestHeroBagView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_card")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.definePrefabUrl(arg_3_0)
	arg_3_0.internal_pre_url = "ui/viewres/character/characterbackpackheroview.prefab"
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = HeroModel.instance:getList()

	arg_4_0._scroll_view = arg_4_0:com_registSimpleScrollView(arg_4_0._scrollcard.gameObject, ScrollEnum.ScrollDirV, 6)

	arg_4_0._scroll_view:setClass(TestHeroBagItemView)
	arg_4_0._scroll_view:setData(var_4_0)
end

function var_0_0.onClose(arg_5_0)
	return
end

return var_0_0
