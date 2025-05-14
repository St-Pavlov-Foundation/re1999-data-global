module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErStoryItem", package.seeall)

local var_0_0 = class("ZhiXinQuanErStoryItem", LuaCompBase)
local var_0_1 = 1.5
local var_0_2 = "PuzzleMazeDrawController;PuzzleEvent;OnGameFinished"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._gounLock = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stageNum")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/info/star1/#go_star")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/info/#btn_review")
	arg_1_0._anim = arg_1_1:GetComponent(gohelper.Type_Animator)
	arg_1_0._gostarAnim = gohelper.findChild(arg_1_0._gostar, "#image_Star")
	arg_1_0._animStar = arg_1_0._gostarAnim:GetComponent(gohelper.Type_Animation)
	arg_1_0._gostarNo = gohelper.findChild(arg_1_0.viewGO, "unlock/info/star1/no")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal")
	arg_1_0._gostagenormal2 = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal2")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._gostagefinish2 = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish2")
	arg_1_0._txtstageNum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stageNum")
	arg_1_0._goCurrent = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_Current")
	arg_1_0._focusFlagPosX, arg_1_0._focusFlagPosY = recthelper.getAnchor(arg_1_0._goCurrent.transform)
	arg_1_0._focusFlagAngleX, arg_1_0._focusFlagAngleY, arg_1_0._focusFlagAngleZ = transformhelper.getEulerAngles(arg_1_0._goCurrent.transform)

	arg_1_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, arg_1_0.onStoryItemClick, arg_1_0)
	arg_1_0:setFocusFlag(false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
	arg_2_0._btnreview:AddClickListener(arg_2_0._btnOnReview, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnreview:RemoveClickListener()
end

function var_0_0._btnOnClick(arg_4_0)
	if not arg_4_0.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, arg_4_0.index)
end

function var_0_0.onStoryItemClick(arg_5_0, arg_5_1)
	if arg_5_0.index == arg_5_1 then
		return
	end

	arg_5_0:destroyWorkFlow()
end

function var_0_0._btnOnReview(arg_6_0)
	arg_6_0:_btnOnClick()
end

function var_0_0.setParam(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.config = arg_7_1
	arg_7_0.id = arg_7_1.id
	arg_7_0.actId = arg_7_3
	arg_7_0.index = arg_7_2

	arg_7_0:_refreshUI()
end

local var_0_3 = "#F3F3DC"
local var_0_4 = "#F3F3DC"
local var_0_5 = 0.5
local var_0_6 = 1

function var_0_0._refreshUI(arg_8_0)
	arg_8_0:refreshStatus()

	arg_8_0._txtname.text = arg_8_0.config.name
	arg_8_0._txtnum.text = "0" .. arg_8_0.index
	arg_8_0._txtstageNum.text = "0" .. arg_8_0.index

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtname, arg_8_0.unlock and var_0_4 or var_0_3)
	ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txtname, arg_8_0.unlock and var_0_6 or var_0_5)
end

function var_0_0.refreshStatus(arg_9_0)
	arg_9_0.unlock = RoleActivityModel.instance:isLevelUnlock(arg_9_0.actId, arg_9_0.id)

	gohelper.setActive(arg_9_0._golock, not arg_9_0.unlock)

	arg_9_0.isPass = RoleActivityModel.instance:isLevelPass(arg_9_0.actId, arg_9_0.id)

	gohelper.setActive(arg_9_0._gostar, arg_9_0.isPass)
	gohelper.setActive(arg_9_0._gostarNo, not arg_9_0.isPass)

	arg_9_0.hasElement = Activity176Config.instance:getElementCo(arg_9_0.actId, arg_9_0.id) ~= nil

	gohelper.setActive(arg_9_0._gostagenormal, not arg_9_0.unlock and not arg_9_0.hasElement)
	gohelper.setActive(arg_9_0._gostagenormal2, not arg_9_0.unlock and arg_9_0.hasElement)
	gohelper.setActive(arg_9_0._gostagefinish, arg_9_0.unlock and not arg_9_0.hasElement)
	gohelper.setActive(arg_9_0._gostagefinish2, arg_9_0.unlock and arg_9_0.hasElement)
end

function var_0_0.lockStatus(arg_10_0)
	gohelper.setActive(arg_10_0._golock, true)
	gohelper.setActive(arg_10_0._gostar, false)
	gohelper.setActive(arg_10_0._gostarNo, true)
end

function var_0_0.isUnlock(arg_11_0)
	return arg_11_0.unlock
end

function var_0_0.playStory(arg_12_0)
	arg_12_0:destroyWorkFlow()

	arg_12_0._flow = FlowSequence.New()

	if not arg_12_0.isPass then
		arg_12_0._flow:addWork(FunctionWork.New(arg_12_0.onStartEpisode, arg_12_0))
	end

	if arg_12_0.config.beforeStory ~= 0 then
		arg_12_0._flow:addWork(PlayStoryWork.New(arg_12_0.config.beforeStory))
	end

	local var_12_0 = Activity176Config.instance:getElementCo(arg_12_0.actId, arg_12_0.id)

	if var_12_0 then
		arg_12_0._flow:addWork(FunctionWork.New(PuzzleMazeDrawController.openGame, PuzzleMazeDrawController.instance, var_12_0))
		arg_12_0._flow:addWork(WaitEventWork.New(var_0_2))
	end

	if not arg_12_0.isPass then
		arg_12_0._flow:addWork(FunctionWork.New(arg_12_0.onFinishedEpisode, arg_12_0))
	end

	if var_12_0 then
		arg_12_0._flow:addWork(FunctionWork.New(arg_12_0._lockScreen, arg_12_0, true))
		arg_12_0._flow:addWork(WorkWaitSeconds.New(var_0_1))
		arg_12_0._flow:addWork(BpCloseViewWork.New(ViewName.PuzzleMazeDrawView))
		arg_12_0._flow:addWork(FunctionWork.New(arg_12_0._lockScreen, arg_12_0, false))
	end

	if arg_12_0.config.afterStory ~= 0 then
		arg_12_0._flow:addWork(PlayStoryWork.New(arg_12_0.config.afterStory))
	end

	arg_12_0._flow:start()
end

function var_0_0._lockScreen(arg_13_0, arg_13_1)
	if arg_13_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("ZhiXinQuanErStoryItem")
	else
		UIBlockMgr.instance:endBlock("ZhiXinQuanErStoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.onStartEpisode(arg_14_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_14_0.config.chapterId, arg_14_0.id)
end

function var_0_0.onFinishedEpisode(arg_15_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_15_0.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function var_0_0.destroyWorkFlow(arg_16_0)
	if arg_16_0._flow then
		arg_16_0._flow:destroy()

		arg_16_0._flow = nil
	end
end

function var_0_0.playFinish(arg_17_0)
	arg_17_0._anim:Play("finish")
end

function var_0_0.playUnlock(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_UnlockNewEpisode)
	arg_18_0._anim:Play("unlock")
	gohelper.setActive(arg_18_0._gostagefinish, not arg_18_0.hasElement)
	gohelper.setActive(arg_18_0._gostagefinish2, arg_18_0.hasElement)
end

function var_0_0.playStarAnim(arg_19_0)
	arg_19_0:refreshStatus()
	arg_19_0._animStar:Play()
end

function var_0_0.setFocusFlag(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._goCurrent, arg_20_1)
	recthelper.setAnchor(arg_20_0._goCurrent.transform, arg_20_0._focusFlagPosX, arg_20_0._focusFlagPosY)
end

function var_0_0.setFocusFlagDir(arg_21_0, arg_21_1)
	transformhelper.setEulerAngles(arg_21_0._goCurrent.transform, arg_21_0._focusFlagAngleX, arg_21_1 and 180 or 0, arg_21_0._focusFlagAngleZ)
end

function var_0_0.getFocusFlagTran(arg_22_0)
	return arg_22_0._goCurrent.transform
end

function var_0_0.onDestroy(arg_23_0)
	arg_23_0:destroyWorkFlow()
	arg_23_0:_lockScreen(false)
end

return var_0_0
