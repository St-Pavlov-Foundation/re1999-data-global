module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErStoryItem", package.seeall)

slot0 = class("ZhiXinQuanErStoryItem", LuaCompBase)
slot1 = 1.5
slot2 = "PuzzleMazeDrawController;PuzzleEvent;OnGameFinished"

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.transform = slot1.transform
	slot0._golock = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._gounLock = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#btn_click")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stagename")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stageNum")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "unlock/info/star1/#go_star")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/info/#btn_review")
	slot0._anim = slot1:GetComponent(gohelper.Type_Animator)
	slot0._gostarAnim = gohelper.findChild(slot0._gostar, "#image_Star")
	slot0._animStar = slot0._gostarAnim:GetComponent(gohelper.Type_Animation)
	slot0._gostarNo = gohelper.findChild(slot0.viewGO, "unlock/info/star1/no")
	slot0._gostagenormal = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal")
	slot0._gostagenormal2 = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal2")
	slot0._gostagefinish = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._gostagefinish2 = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish2")
	slot0._txtstageNum = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stageNum")
	slot0._goCurrent = gohelper.findChild(slot0.viewGO, "unlock/#go_Current")
	slot0._focusFlagPosX, slot0._focusFlagPosY = recthelper.getAnchor(slot0._goCurrent.transform)
	slot0._focusFlagAngleX, slot0._focusFlagAngleY, slot0._focusFlagAngleZ = transformhelper.getEulerAngles(slot0._goCurrent.transform)

	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, slot0.onStoryItemClick, slot0)
	slot0:setFocusFlag(false)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnOnClick, slot0)
	slot0._btnreview:AddClickListener(slot0._btnOnReview, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnreview:RemoveClickListener()
end

function slot0._btnOnClick(slot0)
	if not slot0.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, slot0.index)
end

function slot0.onStoryItemClick(slot0, slot1)
	if slot0.index == slot1 then
		return
	end

	slot0:destroyWorkFlow()
end

function slot0._btnOnReview(slot0)
	slot0:_btnOnClick()
end

function slot0.setParam(slot0, slot1, slot2, slot3)
	slot0.config = slot1
	slot0.id = slot1.id
	slot0.actId = slot3
	slot0.index = slot2

	slot0:_refreshUI()
end

slot3 = "#F3F3DC"
slot4 = "#F3F3DC"
slot5 = 0.5
slot6 = 1

function slot0._refreshUI(slot0)
	slot0:refreshStatus()

	slot0._txtname.text = slot0.config.name
	slot0._txtnum.text = "0" .. slot0.index
	slot0._txtstageNum.text = "0" .. slot0.index

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, slot0.unlock and uv0 or uv1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtname, slot0.unlock and uv2 or uv3)
end

function slot0.refreshStatus(slot0)
	slot0.unlock = RoleActivityModel.instance:isLevelUnlock(slot0.actId, slot0.id)

	gohelper.setActive(slot0._golock, not slot0.unlock)

	slot0.isPass = RoleActivityModel.instance:isLevelPass(slot0.actId, slot0.id)

	gohelper.setActive(slot0._gostar, slot0.isPass)
	gohelper.setActive(slot0._gostarNo, not slot0.isPass)

	slot0.hasElement = Activity176Config.instance:getElementCo(slot0.actId, slot0.id) ~= nil

	gohelper.setActive(slot0._gostagenormal, not slot0.unlock and not slot0.hasElement)
	gohelper.setActive(slot0._gostagenormal2, not slot0.unlock and slot0.hasElement)
	gohelper.setActive(slot0._gostagefinish, slot0.unlock and not slot0.hasElement)
	gohelper.setActive(slot0._gostagefinish2, slot0.unlock and slot0.hasElement)
end

function slot0.lockStatus(slot0)
	gohelper.setActive(slot0._golock, true)
	gohelper.setActive(slot0._gostar, false)
	gohelper.setActive(slot0._gostarNo, true)
end

function slot0.isUnlock(slot0)
	return slot0.unlock
end

function slot0.playStory(slot0)
	slot0:destroyWorkFlow()

	slot0._flow = FlowSequence.New()

	if not slot0.isPass then
		slot0._flow:addWork(FunctionWork.New(slot0.onStartEpisode, slot0))
	end

	if slot0.config.beforeStory ~= 0 then
		slot0._flow:addWork(PlayStoryWork.New(slot0.config.beforeStory))
	end

	if Activity176Config.instance:getElementCo(slot0.actId, slot0.id) then
		slot0._flow:addWork(FunctionWork.New(PuzzleMazeDrawController.openGame, PuzzleMazeDrawController.instance, slot1))
		slot0._flow:addWork(WaitEventWork.New(uv0))
	end

	if not slot0.isPass then
		slot0._flow:addWork(FunctionWork.New(slot0.onFinishedEpisode, slot0))
	end

	if slot1 then
		slot0._flow:addWork(FunctionWork.New(slot0._lockScreen, slot0, true))
		slot0._flow:addWork(WorkWaitSeconds.New(uv1))
		slot0._flow:addWork(BpCloseViewWork.New(ViewName.PuzzleMazeDrawView))
		slot0._flow:addWork(FunctionWork.New(slot0._lockScreen, slot0, false))
	end

	if slot0.config.afterStory ~= 0 then
		slot0._flow:addWork(PlayStoryWork.New(slot0.config.afterStory))
	end

	slot0._flow:start()
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("ZhiXinQuanErStoryItem")
	else
		UIBlockMgr.instance:endBlock("ZhiXinQuanErStoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.onStartEpisode(slot0)
	DungeonRpc.instance:sendStartDungeonRequest(slot0.config.chapterId, slot0.id)
end

function slot0.onFinishedEpisode(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function slot0.destroyWorkFlow(slot0)
	if slot0._flow then
		slot0._flow:destroy()

		slot0._flow = nil
	end
end

function slot0.playFinish(slot0)
	slot0._anim:Play("finish")
end

function slot0.playUnlock(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_UnlockNewEpisode)
	slot0._anim:Play("unlock")
	gohelper.setActive(slot0._gostagefinish, not slot0.hasElement)
	gohelper.setActive(slot0._gostagefinish2, slot0.hasElement)
end

function slot0.playStarAnim(slot0)
	slot0:refreshStatus()
	slot0._animStar:Play()
end

function slot0.setFocusFlag(slot0, slot1)
	gohelper.setActive(slot0._goCurrent, slot1)
	recthelper.setAnchor(slot0._goCurrent.transform, slot0._focusFlagPosX, slot0._focusFlagPosY)
end

function slot0.setFocusFlagDir(slot0, slot1)
	transformhelper.setEulerAngles(slot0._goCurrent.transform, slot0._focusFlagAngleX, slot1 and 180 or 0, slot0._focusFlagAngleZ)
end

function slot0.getFocusFlagTran(slot0)
	return slot0._goCurrent.transform
end

function slot0.onDestroy(slot0)
	slot0:destroyWorkFlow()
	slot0:_lockScreen(false)
end

return slot0
