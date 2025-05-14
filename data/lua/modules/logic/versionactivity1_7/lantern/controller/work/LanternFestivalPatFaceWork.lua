module("modules.logic.versionactivity1_7.lantern.controller.work.LanternFestivalPatFaceWork", package.seeall)

local var_0_0 = class("LanternFestivalPatFaceWork", PatFaceWorkBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.LanternFestival) then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onShowFinish, arg_1_0)

	if LanternFestivalModel.instance:hasPuzzleCouldGetReward() then
		LanternFestivalController.instance:openLanternFestivalView()
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onShowFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.LanternFestivalView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onShowFinish, arg_3_0)
end

return var_0_0
