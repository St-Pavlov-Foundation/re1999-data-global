module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievement", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScoreTaskAchievement", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "Left/#go_AssessIcon")
	arg_1_0._txtScoreNum = gohelper.findChildText(arg_1_0.viewGO, "Left/Score/#txt_ScoreNum")
	arg_1_0._scrollScoreList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_ScoreList")
	arg_1_0._goBlock = gohelper.findChild(arg_1_0.viewGO, "#go_Block")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtScoreNum.text = ""

	arg_4_0._simageFullBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_score_fullbg"))
	arg_4_0:_initAssessIcon()
end

function var_0_0._initAssessIcon(arg_5_0)
	local var_5_0 = V1a4_BossRush_Task_AssessIcon
	local var_5_1 = arg_5_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, arg_5_0._goAssessIcon, var_5_0.__cname)

	arg_5_0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, var_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:setActiveBlock(false)

	arg_7_0._isStartBlockOnce = nil
	arg_7_0._isEndBlockOnce = nil

	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setStaticData(false)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_7_0._refreshRight, arg_7_0)
	BossRushController.instance:sendGetTaskInfoRequest()
	arg_7_0:_refreshLeft()
end

function var_0_0.onClose(arg_8_0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, arg_8_0._refreshRight, arg_8_0)
end

function var_0_0._refresh(arg_9_0)
	arg_9_0:_refreshLeft()
	arg_9_0:_refreshRight()
end

function var_0_0._refreshLeft(arg_10_0)
	local var_10_0 = arg_10_0.viewParam.stage
	local var_10_1 = BossRushModel.instance:getHighestPoint(var_10_0)

	arg_10_0._assessIcon:setData(var_10_0, var_10_1)

	arg_10_0._txtScoreNum.text = BossRushConfig.instance:getScoreStr(var_10_1)
end

function var_0_0._refreshRight(arg_11_0)
	local var_11_0 = arg_11_0.viewParam.stage
	local var_11_1 = BossRushModel.instance:getTaskMoListByStage(var_11_0)

	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setList(var_11_1)
end

function var_0_0.setActiveBlock(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 then
		if arg_12_1 then
			if arg_12_0._isStartBlockOnce then
				return
			end

			arg_12_0._isStartBlockOnce = true
		else
			if arg_12_0._isEndBlockOnce then
				return
			end

			arg_12_0._isEndBlockOnce = true
		end
	end

	gohelper.setActive(arg_12_0._goBlock, arg_12_1)
end

return var_0_0
