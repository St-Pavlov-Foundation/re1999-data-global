module("modules.logic.guide.view.GuideViewMgr", package.seeall)

local var_0_0 = class("GuideViewMgr")

function var_0_0.open(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.guideId = arg_1_1
	arg_1_0.stepId = arg_1_2
	arg_1_0.viewParam = GuideViewParam.New()

	arg_1_0.viewParam:setStep(arg_1_0.guideId, arg_1_0.stepId)

	if string.find(arg_1_0.viewParam.goPath, "/MESSAGE") then
		ViewMgr.instance:openView(ViewName.GuideView2, arg_1_0.viewParam, true)
	else
		ViewMgr.instance:openView(ViewName.GuideView, arg_1_0.viewParam, true)
	end
end

function var_0_0.close(arg_2_0)
	arg_2_0.viewParam = nil

	ViewMgr.instance:closeView(ViewName.GuideView, true)
	ViewMgr.instance:closeView(ViewName.GuideView2, true)
end

function var_0_0.enableHoleClick(arg_3_0)
	if arg_3_0.viewParam then
		arg_3_0.viewParam.enableHoleClick = true

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function var_0_0.disableHoleClick(arg_4_0)
	if arg_4_0.viewParam then
		arg_4_0.viewParam.enableHoleClick = false

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function var_0_0.setHoleClickCallback(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._clickCallback = arg_5_1
	arg_5_0._clickCallbackTarget = arg_5_2
end

function var_0_0.enableClick(arg_6_0, arg_6_1)
	if arg_6_0.viewParam then
		arg_6_0.viewParam.enableClick = arg_6_1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function var_0_0.enablePress(arg_7_0, arg_7_1)
	if arg_7_0.viewParam then
		arg_7_0.viewParam.enablePress = arg_7_1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function var_0_0.enableDrag(arg_8_0, arg_8_1)
	if arg_8_0.viewParam then
		arg_8_0.viewParam.enableDrag = arg_8_1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function var_0_0.setMaskAlpha(arg_9_0, arg_9_1)
	if arg_9_0.viewParam then
		arg_9_0.viewParam.maskAlpha = arg_9_1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function var_0_0.enableSpaceBtn(arg_10_0, arg_10_1)
	if arg_10_0.viewParam then
		arg_10_0.viewParam.enableSpaceBtn = arg_10_1
	end
end

function var_0_0.onClickCallback(arg_11_0, arg_11_1)
	if arg_11_0._clickCallback then
		if GuideController.EnableLog then
			local var_11_0 = (arg_11_0.guideId or "nil") .. "_" .. (arg_11_0.stepId or "nil")

			logNormal("guidelog: " .. var_11_0 .. " GuideViewMgr.onClickCallback inside " .. (arg_11_1 and "true" or "false") .. debug.traceback("", 2))
		end

		if arg_11_0._clickCallbackTarget then
			arg_11_0._clickCallback(arg_11_0._clickCallbackTarget, arg_11_1)
		else
			arg_11_0._clickCallback(arg_11_1)
		end
	elseif GuideController.EnableLog then
		local var_11_1 = (arg_11_0.guideId or "nil") .. "_" .. (arg_11_0.stepId or "nil")

		logNormal("guidelog: " .. var_11_1 .. "GuideViewMgr.onClickCallback callback not exist inside " .. (arg_11_1 and "true" or "false") .. debug.traceback("", 2))
	end
end

function var_0_0.isGuidingGO(arg_12_0, arg_12_1)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		local var_12_0 = var_0_0.instance.viewParam
		local var_12_1 = var_12_0 and var_12_0.goPath

		return gohelper.find(var_12_1) == arg_12_1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
