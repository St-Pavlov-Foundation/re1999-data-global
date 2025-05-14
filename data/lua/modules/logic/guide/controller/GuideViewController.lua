module("modules.logic.guide.controller.GuideViewController", package.seeall)

local var_0_0 = class("GuideViewController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.FadeView, arg_3_0._onReceiveFadeView, arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_3_0._onFinishGuide, arg_3_0)
end

function var_0_0._onFinishGuide(arg_4_0, arg_4_1)
	if arg_4_0._isShow == false and arg_4_1 == 501 then
		arg_4_0._isShow = nil

		arg_4_0:_fadeView(true)
	end
end

function var_0_0._onReceiveFadeView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 == "1"

	arg_5_0._isShow = var_5_0

	arg_5_0:_fadeView(var_5_0)
end

function var_0_0._fadeView(arg_6_0, arg_6_1)
	local var_6_0 = {
		ViewName.DungeonMapView,
		ViewName.MainView
	}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = ViewMgr.instance:getContainer(iter_6_1)

		if var_6_1 and var_6_1:isOpen() and var_6_1.viewGO then
			if arg_6_1 then
				var_6_1:_setVisible(true)
				gohelper.setActive(var_6_1.viewGO, false)
				gohelper.setActive(var_6_1.viewGO, true)

				break
			end

			var_6_1:_setVisible(false)

			break
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
