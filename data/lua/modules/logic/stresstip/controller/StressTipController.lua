module("modules.logic.stresstip.controller.StressTipController", package.seeall)

local var_0_0 = class("StressTipController", BaseController)

function var_0_0.openMonsterStressTip(arg_1_0, arg_1_1, arg_1_2)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Monster,
		co = arg_1_1,
		clickPosition = arg_1_2 or UnityEngine.Input.mousePosition
	})
end

function var_0_0.openHeroStressTip(arg_2_0, arg_2_1, arg_2_2)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Hero,
		co = arg_2_1,
		clickPosition = arg_2_2 or UnityEngine.Input.mousePosition
	})
end

function var_0_0.openAct183StressTip(arg_3_0, arg_3_1, arg_3_2)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Act183,
		identityIdList = arg_3_1,
		clickPosition = arg_3_2 or UnityEngine.Input.mousePosition
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
