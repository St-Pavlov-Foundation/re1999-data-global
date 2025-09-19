module("modules.logic.fight.view.FightViewCheckActivityEnd", package.seeall)

local var_0_0 = class("FightViewCheckActivityEnd", BaseView)

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

	if DungeonController.closePreviewChapterViewActEnd(arg_4_1, var_4_0) then
		arg_4_0:_checkAct(arg_4_1)

		return
	end

	if not var_4_1 or var_4_1.actId ~= arg_4_1 then
		return
	end

	arg_4_0:_checkAct(arg_4_1)
end

function var_0_0._checkAct(arg_5_0, arg_5_1)
	if ActivityHelper.getActivityStatus(arg_5_1) ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		FightSystem.instance:dispose()
		FightModel.instance:clearRecordMO()
		FightController.instance:exitFightScene()

		return
	end

	FightRpc.instance:sendEndFightRequest(true)
end

return var_0_0
