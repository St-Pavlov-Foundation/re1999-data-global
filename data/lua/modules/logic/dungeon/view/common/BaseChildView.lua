module("modules.logic.dungeon.view.common.BaseChildView", package.seeall)

local var_0_0 = class("BaseChildView", UserDataDispose)

function var_0_0.initView(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.viewParam = arg_1_2
	arg_1_0.viewGO = arg_1_1

	arg_1_0:onInitView()
	arg_1_0:addEvents()
	arg_1_0:onOpen()
end

function var_0_0.updateParam(arg_2_0, arg_2_1)
	arg_2_0.viewParam = arg_2_1

	arg_2_0:onUpdateParam()
end

function var_0_0.onOpenFinish(arg_3_0)
	return
end

function var_0_0.destroyView(arg_4_0)
	arg_4_0:onClose()
	arg_4_0:removeEvents()
	arg_4_0:onDestroyView()

	if arg_4_0.viewGO then
		gohelper.destroy(arg_4_0.viewGO)

		arg_4_0.viewGO = nil
	end

	arg_4_0:__onDispose()
end

return var_0_0
