module("modules.logic.versionactivity1_4.act136.view.Activity136MainBtnItem", package.seeall)

local var_0_0 = class("Activity136MainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0.go, "bg")
	arg_1_0._btnitem = gohelper.findChildClick(arg_1_0.go, "bg")
	arg_1_0._redDotParent = gohelper.findChild(arg_1_0.go, "go_activityreddot")

	local var_1_0 = ActivityModel.showActivityEffect()
	local var_1_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_1_2 = var_1_0 and var_1_1.mainViewActBtnPrefix .. "icon_5" or "icon_5"

	UISpriteSetMgr.instance:setMainSprite(arg_1_0._imgitem, var_1_2, true)

	if not var_1_0 then
		local var_1_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_1_3 then
			for iter_1_0, iter_1_1 in ipairs(var_1_3.mainViewActBtn) do
				local var_1_4 = gohelper.findChild(arg_1_0.go, iter_1_1)

				if var_1_4 then
					gohelper.setActive(var_1_4, var_1_0)
				end
			end
		end
	end

	arg_1_0.redDot = RedDotController.instance:addNotEventRedDot(arg_1_0._redDotParent, Activity136Model.isShowRedDot, Activity136Model.instance)

	gohelper.setActive(arg_1_0.go, true)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, arg_2_0.refreshRedDot, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, arg_3_0.refreshRedDot, arg_3_0)
end

function var_0_0._onItemClick(arg_4_0)
	Activity136Controller.instance:openActivity136View()
end

function var_0_0.refreshRedDot(arg_5_0)
	if not arg_5_0.redDot then
		return
	end

	arg_5_0.redDot:refreshRedDot()
end

function var_0_0.destroy(arg_6_0)
	gohelper.setActive(arg_6_0.go, false)
	gohelper.destroy(arg_6_0.go)

	arg_6_0.go = nil
	arg_6_0._imgitem = nil
	arg_6_0._btnitem = nil
	arg_6_0.redDot = nil
end

return var_0_0
