module("modules.common.others.FullScreenViewLimitMgr", package.seeall)

local var_0_0 = class("FullScreenViewLimitMgr")

var_0_0.enableLimit = true
var_0_0.limitCount = 5

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, arg_2_0._onOpenFullView, arg_2_0)
end

function var_0_0._onOpenFullView(arg_3_0, arg_3_1)
	if not var_0_0.enableLimit then
		return
	end

	local var_3_0 = 0
	local var_3_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_3_0 = #var_3_1, 1, -1 do
		if ViewMgr.instance:isFull(var_3_1[iter_3_0]) then
			if var_3_0 >= var_0_0.limitCount then
				logNormal("全屏界面数量超出限制, 关闭界面: " .. var_3_1[iter_3_0])
				ViewMgr.instance:closeView(var_3_1[iter_3_0])
			end

			var_3_0 = var_3_0 + 1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
