module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementBase", package.seeall)

local var_0_0 = class("FairyLandElementBase", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._config = arg_1_2
	arg_1_0._elements = arg_1_1
end

function var_0_0.getElementId(arg_2_0)
	return arg_2_0._config.id
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._go = arg_3_1
	arg_3_0._transform = arg_3_1.transform

	arg_3_0:updatePos()
	arg_3_0:onInitView()
	arg_3_0:onRefresh()

	local var_3_0 = arg_3_0:getClickGO()

	if var_3_0 then
		arg_3_0.click = gohelper.getClickWithAudio(var_3_0)

		if arg_3_0.click then
			arg_3_0.click:AddClickListener(arg_3_0.onClick, arg_3_0)
		end
	end
end

function var_0_0.refresh(arg_4_0)
	arg_4_0:onRefresh()
end

function var_0_0.finish(arg_5_0)
	arg_5_0:onFinish()
	arg_5_0:onDestroy()
end

function var_0_0.getPos(arg_6_0)
	return tonumber(arg_6_0._config.pos)
end

function var_0_0.updatePos(arg_7_0)
	local var_7_0 = 244
	local var_7_1 = 73
	local var_7_2 = arg_7_0:getPos()
	local var_7_3 = var_7_2 * var_7_0
	local var_7_4 = -(var_7_2 * var_7_1)

	recthelper.setAnchor(arg_7_0._transform, var_7_3, var_7_4)
end

function var_0_0.hide(arg_8_0)
	gohelper.setActive(arg_8_0._go, false)
end

function var_0_0.show(arg_9_0)
	gohelper.setActive(arg_9_0._go, true)
end

function var_0_0.getVisible(arg_10_0)
	return not gohelper.isNil(arg_10_0._go) and arg_10_0._go.activeSelf
end

function var_0_0.isValid(arg_11_0)
	return not gohelper.isNil(arg_11_0._go)
end

function var_0_0.onClick(arg_12_0)
	return
end

function var_0_0.getTransform(arg_13_0)
	return arg_13_0._transform
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0:onDestroyElement()

	if arg_14_0.click then
		arg_14_0.click:RemoveClickListener()
	end

	if not gohelper.isNil(arg_14_0._go) then
		gohelper.destroy(arg_14_0._go)

		arg_14_0._go = nil
	end

	arg_14_0:__onDispose()
end

function var_0_0.getClickGO(arg_15_0)
	return arg_15_0._go
end

function var_0_0.setFinish(arg_16_0)
	local var_16_0 = arg_16_0:getElementId()

	FairyLandRpc.instance:sendRecordElementRequest(var_16_0)
end

function var_0_0.onInitView(arg_17_0)
	return
end

function var_0_0.onRefresh(arg_18_0)
	return
end

function var_0_0.onFinish(arg_19_0)
	return
end

function var_0_0.onDestroyElement(arg_20_0)
	return
end

return var_0_0
