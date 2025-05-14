module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementDoor", package.seeall)

local var_0_0 = class("FairyLandElementDoor", FairyLandElementBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.animator = arg_1_0._go:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:addEventCb(FairyLandController.instance, FairyLandEvent.DoStairAnim, arg_1_0.onDoStairAnim, arg_1_0)
end

function var_0_0.getState(arg_2_0)
	local var_2_0 = arg_2_0:getElementId() - 1

	if not FairyLandConfig.instance:getElementConfig(var_2_0) or FairyLandModel.instance:isFinishElement(var_2_0) then
		return FairyLandEnum.ShapeState.CanClick
	end

	return FairyLandEnum.ShapeState.LockClick
end

function var_0_0.onClick(arg_3_0)
	if arg_3_0:getState() == FairyLandEnum.ShapeState.CanClick and not arg_3_0._elements:isMoveing() then
		arg_3_0:setFinish()
	end
end

function var_0_0.finish(arg_4_0)
	FairyLandModel.instance:setPos(arg_4_0:getPos(), true)
	arg_4_0._elements:characterMove()
	arg_4_0:onDestroy()
end

function var_0_0.onDoStairAnim(arg_5_0, arg_5_1)
	if arg_5_1 == 46 then
		arg_5_0.animator:Play("door_01", 0, 0)
	elseif arg_5_1 == 48 then
		arg_5_0.animator:Play("door_02", 0, 0)
	end
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:onDestroyElement()

	if arg_6_0.click then
		arg_6_0.click:RemoveClickListener()
	end

	arg_6_0:__onDispose()
end

function var_0_0.onDestroyElement(arg_7_0)
	return
end

return var_0_0
