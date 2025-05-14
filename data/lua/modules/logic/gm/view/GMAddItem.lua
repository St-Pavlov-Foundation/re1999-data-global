module("modules.logic.gm.view.GMAddItem", package.seeall)

local var_0_0 = class("GMAddItem", ListScrollCell)
local var_0_1 = {
	"#319b26",
	"#4d9af9",
	"#a368d1",
	"#fd913b",
	"#e11919"
}

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

	if arg_2_0._mo.itemId then
		arg_2_0._txtId.text = arg_2_0._mo.itemId
	else
		arg_2_0._txtId.text = ""
	end

	local var_2_0 = "#666666"

	if arg_2_0._mo.rare then
		var_2_0 = var_0_1[tonumber(arg_2_0._mo.rare)]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._txtName, var_2_0)

	local var_2_1 = GameUtil.parseColor(var_2_0)

	arg_2_0._txtId.color = var_2_1
end

function var_0_0._onClickItem(arg_3_0)
	if arg_3_0._mo.type == 0 then
		GMController.instance:dispatchEvent(GMAddItemView.Return, arg_3_0._mo)
	else
		GMController.instance:dispatchEvent(GMAddItemView.ClickItem, arg_3_0._mo)
	end
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0._itemClick then
		arg_4_0._itemClick:RemoveClickListener()

		arg_4_0._itemClick = nil
	end
end

return var_0_0
