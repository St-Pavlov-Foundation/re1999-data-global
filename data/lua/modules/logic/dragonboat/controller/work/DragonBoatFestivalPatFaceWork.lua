module("modules.logic.dragonboat.controller.work.DragonBoatFestivalPatFaceWork", package.seeall)

local var_0_0 = class("DragonBoatFestivalPatFaceWork", PatFaceWorkBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.DragonBoatFestival) then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onShowFinish, arg_1_0)

	if DragonBoatFestivalModel.instance:hasRewardNotGet() then
		DragonBoatFestivalController.instance:openDragonBoatFestivalView()
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onShowFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.DragonBoatFestivalView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onShowFinish, arg_3_0)
end

return var_0_0
