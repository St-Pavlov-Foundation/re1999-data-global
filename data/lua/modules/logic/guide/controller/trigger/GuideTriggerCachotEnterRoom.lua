module("modules.logic.guide.controller.trigger.GuideTriggerCachotEnterRoom", package.seeall)

local var_0_0 = class("GuideTriggerCachotEnterRoom", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_1_0._onUpdateRogueInfo, arg_1_0)
end

function var_0_0._onUpdateRogueInfo(arg_2_0)
	arg_2_0:checkStartGuide()
end

function var_0_0.assertGuideSatisfy(arg_3_0, arg_3_1, arg_3_2)
	if not ViewMgr.instance:isOpen(ViewName.V1a6_CachotRoomView) then
		return
	end

	local var_3_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_3_0 then
		return
	end

	local var_3_1, var_3_2 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(var_3_0.room)
	local var_3_3 = string.splitToNumber(arg_3_2, "_")
	local var_3_4 = var_3_3[1]
	local var_3_5 = var_3_3[2]

	return var_3_4 == var_3_0.layer and var_3_5 == var_3_1
end

function var_0_0._onOpenView(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ViewName.V1a6_CachotRoomView then
		arg_4_0:checkStartGuide()
	end
end

return var_0_0
