module("modules.logic.fight.system.work.FightWorkGuideAfterPlay", package.seeall)

local var_0_0 = class("FightWorkGuideAfterPlay", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		arg_1_0:onDone(true)

		return
	end

	if FightReplayModel.instance:isReplay() then
		arg_1_0:onDone(true)

		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card and FightModel.instance:getCurStage() ~= FightEnum.Stage.AutoCard then
		arg_1_0:onDone(true)

		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		arg_1_0:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		arg_1_0:onDone(true)

		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		arg_1_0:onDone(true)

		return
	end

	FightMsgMgr.sendMsg(FightMsgId.CheckGuideFightItemPlayerSkillGroup)
	arg_1_0:onDone(true)
end

return var_0_0
