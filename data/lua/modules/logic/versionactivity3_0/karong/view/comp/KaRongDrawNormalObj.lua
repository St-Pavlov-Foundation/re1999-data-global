module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawNormalObj", package.seeall)

local var_0_0 = class("KaRongDrawNormalObj", KaRongDrawBaseObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._gochecked = gohelper.findChild(arg_1_0.go, "#go_checked")

	gohelper.setActive(arg_1_0._gochecked, false)
end

return var_0_0
