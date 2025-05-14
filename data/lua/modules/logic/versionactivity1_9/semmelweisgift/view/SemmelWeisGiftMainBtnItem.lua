module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftMainBtnItem", package.seeall)

local var_0_0 = class("SemmelWeisGiftMainBtnItem", Activity101SignViewBtnBase)

function var_0_0.onRefresh(arg_1_0)
	arg_1_0:_setMainSprite("v1a6_act_icon3")
end

function var_0_0.onClick(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(var_2_0) then
		return
	end

	SemmelWeisGiftController.instance:openSemmelWeisGiftView()
end

return var_0_0
