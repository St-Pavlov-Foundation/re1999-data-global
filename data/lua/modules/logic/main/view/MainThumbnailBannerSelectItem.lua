module("modules.logic.main.view.MainThumbnailBannerSelectItem", package.seeall)

local var_0_0 = class("MainThumbnailBannerSelectItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1.go
	arg_1_0._pageIndex = arg_1_1.index
	arg_1_0._normalGo = gohelper.findChild(arg_1_0._go, "#go_nomalstar")
	arg_1_0._selectedGo = gohelper.findChild(arg_1_0._go, "#go_lightstar")

	transformhelper.setLocalPos(arg_1_0._go.transform, arg_1_1.pos, 0, 0)
end

function var_0_0.updateItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._pageIndex == arg_2_1

	gohelper.setActive(arg_2_0._selectedGo, var_2_0 and arg_2_2 > 1)
	gohelper.setActive(arg_2_0._normalGo, not var_2_0 and arg_2_2 > 1)
end

function var_0_0.destroy(arg_3_0)
	return
end

return var_0_0
