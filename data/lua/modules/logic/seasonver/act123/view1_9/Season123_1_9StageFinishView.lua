module("modules.logic.seasonver.act123.view1_9.Season123_1_9StageFinishView", package.seeall)

slot0 = class("Season123_1_9StageFinishView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtmapname = gohelper.findChildText(slot0.viewGO, "#go_progress/#txt_mapname")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_time/#txt_time")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_time/#txt_time/#go_new")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.userId = PlayerModel.instance:getMyUserId()
	slot0._progressActives = slot0:getUserDataTb_()
	slot0._progressDeactives = slot0:getUserDataTb_()
	slot0._progressHard = slot0:getUserDataTb_()
	slot0._animProgress = slot0:getUserDataTb_()

	for slot4 = 1, Activity123Enum.SeasonStageStepCount do
		slot5 = gohelper.findChild(slot0.viewGO, "#go_progress/progress/#go_progress" .. slot4)
		slot0._progressActives[slot4] = gohelper.findChild(slot5, "light")
		slot0._progressDeactives[slot4] = gohelper.findChild(slot5, "dark")
		slot0._progressHard[slot4] = gohelper.findChild(slot5, "red")
		slot0._animProgress[slot4] = slot5:GetComponent(gohelper.Type_Animator)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.handleDelayAnimTransition, slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId
	slot0._stageId = slot0.viewParam.stage

	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0.lightStar, slot0, 0.1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.lightStar, slot0)
	TaskDispatcher.cancelTask(slot0.light, slot0)
	TaskDispatcher.cancelTask(slot0.handleDelayAnimTransition, slot0)
end

function slot0.refreshUI(slot0)
	if Season123Config.instance:getStageCo(slot0._actId, slot0._stageId) then
		slot0._txtmapname.text = slot1.name
	end

	if Season123Model.instance:getActInfo(slot0._actId) then
		slot0._txttime.text = tostring(slot2:getTotalRound(slot0._stageId))
	end
end

function slot0.handleDelayAnimTransition(slot0)
	if slot0:firstPassStage(slot0._actId, slot0._stageId) then
		Season123Controller.instance:openSeasonStoryPagePopView(slot0._actId, slot0._stageId)
		slot0:setAlreadyPass(slot0._actId, slot0._stageId)
	else
		Season123Controller.instance:dispatchEvent(Season123Event.StageFinishWithoutStory)
	end

	slot0:closeThis()
end

function slot0.lightStar(slot0)
	slot4 = slot0._stageId
	slot0.curStageStep, slot0.maxStep = Season123ProgressUtils.getStageProgressStep(slot0._actId, slot4)
	slot0.lightCnt = 1

	for slot4 = 1, #slot0._progressDeactives do
		gohelper.setActive(slot0._progressDeactives[slot4], slot4 <= slot0.maxStep)
	end

	TaskDispatcher.runRepeat(slot0.light, slot0, 0.1, slot0.curStageStep)
	TaskDispatcher.runDelay(slot0.handleDelayAnimTransition, slot0, 2)
end

function slot0.light(slot0)
	slot0._animProgress[slot0.lightCnt]:Play("unlock")
	gohelper.setActive(slot0._progressActives[slot0.lightCnt], slot0.lightCnt <= slot0.curStageStep and slot0.lightCnt < slot0.maxStep)
	gohelper.setActive(slot0._progressHard[slot0.lightCnt], slot0.lightCnt == slot0.maxStep)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_star)

	if slot0.lightCnt < slot0.curStageStep then
		slot0.lightCnt = slot0.lightCnt + 1
	elseif slot0.lightCnt == slot0.curStageStep then
		slot0.lightCnt = nil
	end
end

function slot0.firstPassStage(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getPassKey(slot1, slot2)) then
		return string.nilorempty(PlayerPrefsHelper.getString(slot3, ""))
	end
end

function slot0.setAlreadyPass(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getPassKey(slot1, slot2)) then
		PlayerPrefsHelper.setString(slot3, "1")
	end
end

function slot0.getPassKey(slot0, slot1, slot2)
	return "FirstPassStage" .. tostring(slot0.userId) .. "#" .. tostring(slot1) .. tostring(slot2)
end

return slot0
