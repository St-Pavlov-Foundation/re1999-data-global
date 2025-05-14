module("modules.logic.seasonver.act123.view1_9.Season123_1_9StageFinishView", package.seeall)

local var_0_0 = class("Season123_1_9StageFinishView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtmapname = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/#txt_mapname")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_time/#txt_time")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_time/#txt_time/#go_new")

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
	arg_4_0.userId = PlayerModel.instance:getMyUserId()
	arg_4_0._progressActives = arg_4_0:getUserDataTb_()
	arg_4_0._progressDeactives = arg_4_0:getUserDataTb_()
	arg_4_0._progressHard = arg_4_0:getUserDataTb_()
	arg_4_0._animProgress = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, Activity123Enum.SeasonStageStepCount do
		local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "#go_progress/progress/#go_progress" .. iter_4_0)

		arg_4_0._progressActives[iter_4_0] = gohelper.findChild(var_4_0, "light")
		arg_4_0._progressDeactives[iter_4_0] = gohelper.findChild(var_4_0, "dark")
		arg_4_0._progressHard[iter_4_0] = gohelper.findChild(var_4_0, "red")
		arg_4_0._animProgress[iter_4_0] = var_4_0:GetComponent(gohelper.Type_Animator)
	end
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.handleDelayAnimTransition, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._actId = arg_6_0.viewParam.actId
	arg_6_0._stageId = arg_6_0.viewParam.stage

	arg_6_0:refreshUI()
	TaskDispatcher.runDelay(arg_6_0.lightStar, arg_6_0, 0.1)
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.lightStar, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.light, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.handleDelayAnimTransition, arg_7_0)
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = Season123Config.instance:getStageCo(arg_8_0._actId, arg_8_0._stageId)

	if var_8_0 then
		arg_8_0._txtmapname.text = var_8_0.name
	end

	local var_8_1 = Season123Model.instance:getActInfo(arg_8_0._actId)

	if var_8_1 then
		local var_8_2 = var_8_1:getTotalRound(arg_8_0._stageId)

		arg_8_0._txttime.text = tostring(var_8_2)
	end
end

function var_0_0.handleDelayAnimTransition(arg_9_0)
	if arg_9_0:firstPassStage(arg_9_0._actId, arg_9_0._stageId) then
		Season123Controller.instance:openSeasonStoryPagePopView(arg_9_0._actId, arg_9_0._stageId)
		arg_9_0:setAlreadyPass(arg_9_0._actId, arg_9_0._stageId)
	else
		Season123Controller.instance:dispatchEvent(Season123Event.StageFinishWithoutStory)
	end

	arg_9_0:closeThis()
end

function var_0_0.lightStar(arg_10_0)
	arg_10_0.curStageStep, arg_10_0.maxStep = Season123ProgressUtils.getStageProgressStep(arg_10_0._actId, arg_10_0._stageId)
	arg_10_0.lightCnt = 1

	for iter_10_0 = 1, #arg_10_0._progressDeactives do
		gohelper.setActive(arg_10_0._progressDeactives[iter_10_0], iter_10_0 <= arg_10_0.maxStep)
	end

	TaskDispatcher.runRepeat(arg_10_0.light, arg_10_0, 0.1, arg_10_0.curStageStep)
	TaskDispatcher.runDelay(arg_10_0.handleDelayAnimTransition, arg_10_0, 2)
end

function var_0_0.light(arg_11_0)
	arg_11_0._animProgress[arg_11_0.lightCnt]:Play("unlock")
	gohelper.setActive(arg_11_0._progressActives[arg_11_0.lightCnt], arg_11_0.lightCnt <= arg_11_0.curStageStep and arg_11_0.lightCnt < arg_11_0.maxStep)
	gohelper.setActive(arg_11_0._progressHard[arg_11_0.lightCnt], arg_11_0.lightCnt == arg_11_0.maxStep)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_star)

	if arg_11_0.lightCnt < arg_11_0.curStageStep then
		arg_11_0.lightCnt = arg_11_0.lightCnt + 1
	elseif arg_11_0.lightCnt == arg_11_0.curStageStep then
		arg_11_0.lightCnt = nil
	end
end

function var_0_0.firstPassStage(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getPassKey(arg_12_1, arg_12_2)

	if not string.nilorempty(var_12_0) then
		local var_12_1 = PlayerPrefsHelper.getString(var_12_0, "")

		return string.nilorempty(var_12_1)
	end
end

function var_0_0.setAlreadyPass(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getPassKey(arg_13_1, arg_13_2)

	if not string.nilorempty(var_13_0) then
		PlayerPrefsHelper.setString(var_13_0, "1")
	end
end

function var_0_0.getPassKey(arg_14_0, arg_14_1, arg_14_2)
	return "FirstPassStage" .. tostring(arg_14_0.userId) .. "#" .. tostring(arg_14_1) .. tostring(arg_14_2)
end

return var_0_0
