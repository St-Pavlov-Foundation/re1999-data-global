module("modules.logic.herogroup.view.HeroGroupBalanceTipView", package.seeall)

local var_0_0 = class("HeroGroupBalanceTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtroleLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "lv/#txt_roleLv")
	arg_1_0._txtequipLv = gohelper.findChildTextMesh(arg_1_0.viewGO, "equipLv/#txt_equipLv")
	arg_1_0._txttalent = gohelper.findChildTextMesh(arg_1_0.viewGO, "talent/#txt_talent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._rankGo = gohelper.findChild(arg_4_0.viewGO, "lv/rankobj")
	arg_4_0._ranks = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 3 do
		arg_4_0._ranks[iter_4_0] = gohelper.findChild(arg_4_0._rankGo, "rank" .. iter_4_0)
	end
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = HeroGroupBalanceHelper.getBalanceLv()
	local var_5_3, var_5_4 = HeroConfig.instance:getShowLevel(var_5_0)

	for iter_5_0 = 1, 3 do
		gohelper.setActive(arg_5_0._ranks[iter_5_0], var_5_4 - 1 == iter_5_0)
	end

	arg_5_0._txtroleLv.text = "Lv.<size=38>" .. var_5_3
	arg_5_0._txtequipLv.text = "Lv.<size=38>" .. var_5_2
	arg_5_0._txttalent.text = "Lv.<size=38>" .. var_5_1

	if var_5_4 == 1 then
		arg_5_0._txtroleLv.alignment = TMPro.TextAlignmentOptions.Center

		recthelper.setAnchorX(arg_5_0._txtroleLv.transform, 0)
	end
end

return var_0_0
