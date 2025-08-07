module("framework.mvc.view.ViewModalMaskMgr", package.seeall)

local var_0_0 = class("ViewModalMaskMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0.DefaultMaskAlpha = 0
	arg_1_0._maskGO = nil
	arg_1_0._imgMask = nil
end

function var_0_0.init(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_2_0._onReOpenWhileOpen, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0._onOpenView(arg_3_0, arg_3_1, arg_3_2)
	if ViewMgr.instance:isModal(arg_3_1) then
		arg_3_0:_adjustMask(arg_3_1)
	elseif ViewMgr.instance:isFull(arg_3_1) then
		arg_3_0:_hideModalMask()
	end
end

function var_0_0._onReOpenWhileOpen(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:_onOpenView(arg_4_1, arg_4_2)
end

function var_0_0._onCloseViewFinish(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ViewMgr.instance:isModal(arg_5_1)

	if var_5_0 then
		arg_5_0:_hideModalMask()
	end

	if ViewMgr.instance:isFull(arg_5_1) or var_5_0 then
		local var_5_1 = ViewMgr.instance:getOpenViewNameList()

		for iter_5_0 = #var_5_1, 1, -1 do
			local var_5_2 = var_5_1[iter_5_0]

			if ViewMgr.instance:isModal(var_5_2) and ViewMgr.instance:isOpenFinish(var_5_2) then
				arg_5_0:_adjustMask(var_5_2)

				break
			elseif ViewMgr.instance:isFull(var_5_2) then
				break
			end
		end
	end
end

function var_0_0._checkCreateMask(arg_6_0)
	if not arg_6_0._maskGO then
		arg_6_0._maskGO = gohelper.find("UIRoot/POPUP/ViewMask")
		arg_6_0._imgMask = arg_6_0._maskGO:GetComponent(gohelper.Type_Image)
		arg_6_0.DefaultMaskAlpha = arg_6_0._imgMask.color.a

		gohelper.setActive(arg_6_0._maskGO, true)
		SLFramework.UGUI.UIClickListener.Get(arg_6_0._maskGO):AddClickListener(arg_6_0._onClickModalMask, arg_6_0)
	end
end

function var_0_0._adjustMask(arg_7_0, arg_7_1)
	arg_7_0:_checkCreateMask()

	local var_7_0 = ViewMgr.instance:getContainer(arg_7_1)
	local var_7_1 = var_7_0:getSetting()
	local var_7_2 = ViewMgr.instance:getUILayer(var_7_1.layer)

	gohelper.addChild(var_7_2, arg_7_0._maskGO)
	gohelper.setActive(arg_7_0._maskGO, true)
	gohelper.setSiblingBefore(arg_7_0._maskGO, var_7_0.viewGO)

	local var_7_3

	if var_7_0.getCustomViewMaskAlpha then
		var_7_3 = var_7_0:getCustomViewMaskAlpha()
	end

	local var_7_4

	var_7_4.a, var_7_4 = var_7_3 or var_7_1.maskAlpha or arg_7_0.DefaultMaskAlpha, arg_7_0._imgMask.color
	arg_7_0._imgMask.color = var_7_4
end

function var_0_0._hideModalMask(arg_8_0)
	gohelper.setActive(arg_8_0._maskGO, false)
end

function var_0_0._onClickModalMask(arg_9_0)
	local var_9_0
	local var_9_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_9_0 = #var_9_1, 1, -1 do
		local var_9_2 = var_9_1[iter_9_0]

		if ViewMgr.instance:isModal(var_9_2) then
			var_9_0 = var_9_2

			break
		elseif ViewMgr.instance:isFull(var_9_2) then
			break
		end
	end

	if var_9_0 then
		if ViewMgr.instance:isOpenFinish(var_9_0) then
			ViewMgr.instance:getContainer(var_9_0):onClickModalMaskInternal()
		else
			logNormal("modal view not open finish: " .. var_9_0)
		end
	else
		arg_9_0:_hideModalMask()
		logError("no modal view belong to mask")
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
