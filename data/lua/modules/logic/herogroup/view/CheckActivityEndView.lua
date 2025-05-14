module("modules.logic.herogroup.view.CheckActivityEndView", package.seeall)

local var_0_0 = class("CheckActivityEndView", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.checkIsActivityFight, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.checkIsActivityFight, arg_3_0)
end

function var_0_0.checkIsActivityFight(arg_4_0, arg_4_1)
	if string.nilorempty(arg_4_1) or arg_4_1 == 0 then
		return
	end

	local var_4_0 = FightModel.instance:getFightParam().chapterId
	local var_4_1 = DungeonConfig.instance:getChapterCO(var_4_0)

	if not var_4_1 or var_4_1.actId ~= arg_4_1 then
		return
	end

	if ActivityHelper.getActivityStatus(arg_4_1) ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

return var_0_0
