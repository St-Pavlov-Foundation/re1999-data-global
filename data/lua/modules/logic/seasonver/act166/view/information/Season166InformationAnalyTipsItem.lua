module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyTipsItem", package.seeall)

local var_0_0 = class("Season166InformationAnalyTipsItem", Season166InformationAnalyDetailItemBase)

function var_0_0.onInit(arg_1_0)
	arg_1_0.goCanReveal = gohelper.findChild(arg_1_0.go, "#go_CanReveal")
	arg_1_0.goNoReveal = gohelper.findChild(arg_1_0.go, "#go_NoReveal")
	arg_1_0.goLine = gohelper.findChild(arg_1_0.go, "image_Line")
end

function var_0_0.onUpdate(arg_2_0)
	local var_2_0 = arg_2_0.data.config.stage == arg_2_0.data.info.stage + 1

	gohelper.setActive(arg_2_0.goCanReveal, var_2_0)
	gohelper.setActive(arg_2_0.goNoReveal, not var_2_0)
end

return var_0_0
