module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogItem", package.seeall)

local var_0_0 = class("AergusiDialogItem", AergusiDialogRoleItemBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.CreateItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = AergusiEnum.DialogItemCls[arg_2_3]

	if not var_2_0 then
		logError("un support type dialogue type : " .. tostring(arg_2_3))

		return nil
	end

	local var_2_1 = var_2_0.New()

	var_2_1:init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return var_2_1
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.stepCo = arg_3_1
	arg_3_0.go = arg_3_2
	arg_3_0.type = arg_3_4
	arg_3_0.transform = arg_3_0.go.transform

	recthelper.setAnchorY(arg_3_0.transform, -arg_3_3)
	gohelper.setActive(arg_3_2, true)
	arg_3_0:initView()
	arg_3_0:refresh()
	arg_3_0:calculateHeight()
end

function var_0_0.initView(arg_4_0)
	return
end

function var_0_0.refresh(arg_5_0)
	return
end

function var_0_0.calculateHeight(arg_6_0)
	return
end

function var_0_0.getHeight(arg_7_0)
	return arg_7_0.height
end

function var_0_0.onDestroy(arg_8_0)
	return
end

function var_0_0.destroy(arg_9_0)
	arg_9_0:onDestroy()
	var_0_0.super.destroy(arg_9_0)
end

return var_0_0
