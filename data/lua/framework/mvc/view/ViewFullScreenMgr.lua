module("framework.mvc.view.ViewFullScreenMgr", package.seeall)

local var_0_0 = class("ViewFullScreenMgr")

function var_0_0.init(arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, arg_1_0._onOpenFullViewFinish, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_1_0._onCloseFullView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_1_0._reOpenWhileOpen, arg_1_0)
end

function var_0_0._onOpenFullViewFinish(arg_2_0, arg_2_1)
	arg_2_0:_onOpenFullView(arg_2_1)
end

function var_0_0._reOpenWhileOpen(arg_3_0, arg_3_1)
	if ViewMgr.instance:isFull(arg_3_1) then
		arg_3_0:_onOpenFullView(arg_3_1)
	end
end

function var_0_0._onOpenFullView(arg_4_0, arg_4_1)
	local var_4_0 = ViewMgr.instance:getOpenViewNameList()
	local var_4_1 = false

	for iter_4_0 = #var_4_0, 1, -1 do
		local var_4_2 = var_4_0[iter_4_0]

		if arg_4_1 == var_4_2 then
			var_4_1 = true
		elseif var_4_1 then
			local var_4_3 = ViewMgr.instance:getContainer(var_4_2)

			if var_4_3 then
				local var_4_4 = var_4_3:getSetting().layer

				if not (var_4_4 == UILayerName.Guide or var_4_4 == UILayerName.Message or var_4_4 == UILayerName.Top or var_4_4 == UILayerName.IDCanvasPopUp) then
					var_4_3:setVisibleInternal(false)
				end
			end
		end
	end
end

function var_0_0._onCloseFullView(arg_5_0, arg_5_1)
	local var_5_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_5_0 = #var_5_0, 1, -1 do
		local var_5_1 = var_5_0[iter_5_0]
		local var_5_2 = ViewMgr.instance:getContainer(var_5_1)

		if var_5_2 then
			var_5_2:setVisibleInternal(true)
		end

		if ViewMgr.instance:isFull(var_5_1) then
			break
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
