module("modules.ugui.icon.common.CommonRedDotIconNoEvent", package.seeall)

local var_0_0 = class("CommonRedDotIconNoEvent", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, arg_1_1)
	arg_1_0.typeGoDict = arg_1_0:getUserDataTb_()
	arg_1_0.isShowRedDot = false

	for iter_1_0, iter_1_1 in pairs(RedDotEnum.Style) do
		arg_1_0.typeGoDict[iter_1_1] = gohelper.findChild(arg_1_0.go, "type" .. iter_1_1)

		gohelper.setActive(arg_1_0.typeGoDict[iter_1_1], false)
	end
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:refreshRedDot()
end

function var_0_0.setCheckShowRedDotFunc(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.checkFunc = arg_3_1
	arg_3_0.checkFuncObj = arg_3_2

	arg_3_0:refreshRedDot()
end

function var_0_0.setShowType(arg_4_0, arg_4_1)
	arg_4_0.showType = arg_4_1 or RedDotEnum.Style.Normal
end

function var_0_0.refreshRedDot(arg_5_0)
	if not arg_5_0.checkFunc then
		gohelper.setActive(arg_5_0.go, false)

		return
	end

	local var_5_0 = arg_5_0.checkFunc(arg_5_0.checkFuncObj)

	arg_5_0.isShowRedDot = var_5_0

	gohelper.setActive(arg_5_0.go, var_5_0)

	if var_5_0 then
		for iter_5_0, iter_5_1 in pairs(RedDotEnum.Style) do
			gohelper.setActive(arg_5_0.typeGoDict[iter_5_1], arg_5_0.showType == iter_5_1)
		end
	end
end

function var_0_0.setScale(arg_6_0, arg_6_1)
	transformhelper.setLocalScale(arg_6_0.go.transform, arg_6_1, arg_6_1, arg_6_1)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0.checkFunc = nil
	arg_7_0.checkFuncObj = nil
end

return var_0_0
