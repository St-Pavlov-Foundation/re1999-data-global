module("modules.logic.popup.model.PopupCacheModel", package.seeall)

local var_0_0 = class("PopupCacheModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._viewNameIgnoreGetProp = {}
end

function var_0_0.recordCachePopupParam(arg_4_0, arg_4_1)
	arg_4_0:addAtLast(arg_4_1)
end

function var_0_0.popNextPopupParam(arg_5_0)
	return (arg_5_0:removeFirst())
end

function var_0_0.setViewIgnoreGetPropView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 then
		arg_6_0._viewNameIgnoreGetProp[arg_6_1] = arg_6_3 or true
	else
		arg_6_0._viewNameIgnoreGetProp[arg_6_1] = nil
	end
end

function var_0_0.isIgnoreGetPropView(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._viewNameIgnoreGetProp) do
		if ViewMgr.instance:isOpen(iter_7_0) and (type(iter_7_1) == "boolean" or iter_7_1 == arg_7_1) then
			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
