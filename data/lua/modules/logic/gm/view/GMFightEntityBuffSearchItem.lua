module("modules.logic.gm.view.GMFightEntityBuffSearchItem", package.seeall)

local var_0_0 = class("GMFightEntityBuffSearchItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._mo = nil
	arg_1_0._itemClick = SLFramework.UGUI.UIClickListener.Get(arg_1_1)

	arg_1_0._itemClick:AddClickListener(arg_1_0._onClickItem, arg_1_0)

	arg_1_0._img1 = gohelper.findChildImage(arg_1_1, "img1")
	arg_1_0._img2 = gohelper.findChildImage(arg_1_1, "img2")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "txtName")
	arg_1_0._txtId = gohelper.findChildText(arg_1_1, "txtId")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1

	gohelper.setActive(arg_2_0._img1.gameObject, arg_2_1.id % 2 == 1)
	gohelper.setActive(arg_2_0._img2.gameObject, arg_2_1.id % 2 == 0)

	arg_2_0._txtName.text = arg_2_0._mo.name
	arg_2_0._txtId.text = arg_2_0._mo.buffId
end

function var_0_0._onClickItem(arg_3_0)
	GMController.instance:dispatchEvent(GMFightEntityBuffView.ClickSearchItem, arg_3_0._mo)
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0._itemClick then
		arg_4_0._itemClick:RemoveClickListener()

		arg_4_0._itemClick = nil
	end
end

return var_0_0
