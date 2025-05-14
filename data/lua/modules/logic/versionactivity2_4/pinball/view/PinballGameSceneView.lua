module("modules.logic.versionactivity2_4.pinball.view.PinballGameSceneView", package.seeall)

local var_0_0 = class("PinballGameSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "mask/#go_root")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "mask/#go_root/item")
	arg_1_0._gotopitem = gohelper.findChild(arg_1_0.viewGO, "#go_root_top/item")
	arg_1_0._gonumitem = gohelper.findChild(arg_1_0.viewGO, "#go_root_num/item")
end

function var_0_0.onOpen(arg_2_0)
	PinballStatHelper.instance:resetGameDt()
	gohelper.setActive(arg_2_0._goitem, false)
	gohelper.setActive(arg_2_0._gotopitem, false)
	gohelper.setActive(arg_2_0._gonumitem, false)

	arg_2_0._layers = arg_2_0:getUserDataTb_()

	for iter_2_0 in ipairs(PinballEnum.UnitLayers) do
		arg_2_0._layers[iter_2_0] = gohelper.create2d(arg_2_0._goroot, "Layer" .. iter_2_0)
	end

	PinballEntityMgr.instance:setRoot(arg_2_0._goitem, arg_2_0._gotopitem, arg_2_0._gonumitem, arg_2_0._layers)
end

function var_0_0.onClose(arg_3_0)
	PinballEntityMgr.instance:clear()
end

return var_0_0
