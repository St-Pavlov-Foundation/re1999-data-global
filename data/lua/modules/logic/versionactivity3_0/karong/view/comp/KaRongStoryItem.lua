module("modules.logic.versionactivity3_0.karong.view.comp.KaRongStoryItem", package.seeall)

local var_0_0 = class("KaRongStoryItem", LuaCompBase)
local var_0_1 = 1.5
local var_0_2 = "KaRongDrawController;KaRongDrawEvent;OnGameFinished"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/info/star1/#go_star")
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

	arg_1_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.StoryItemClick, arg_1_0.onStoryItemClick, arg_1_0)
	arg_1_0:setFocusFlag(false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
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

function var_0_0.setParam(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.config = arg_6_1
	arg_6_0.id = arg_6_1.id
	arg_6_0.actId = arg_6_3
	arg_6_0.index = arg_6_2

	arg_6_0:_refreshUI()
end

local var_0_3 = "#F3F3DC"
local var_0_4 = "AEAEAE"

function var_0_0._refreshUI(arg_7_0)
	arg_7_0:refreshStatus()

	arg_7_0._txtname.text = arg_7_0.config.name

	if arg_7_0.unlock then
		arg_7_0._txtstageNum.text = string.format("<color=#A6AD82>0%s</color>", arg_7_0.index)
	else
		arg_7_0._txtstageNum.text = string.format("<color=#AEAEAE>0%s</color>", arg_7_0.index)
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtname, arg_7_0.unlock and var_0_4 or var_0_3)
end

function var_0_0.refreshStatus(arg_8_0)
	arg_8_0.unlock = RoleActivityModel.instance:isLevelUnlock(arg_8_0.actId, arg_8_0.id)
	arg_8_0.isPass = RoleActivityModel.instance:isLevelPass(arg_8_0.actId, arg_8_0.id)

	gohelper.setActive(arg_8_0._gostar, arg_8_0.isPass)
	gohelper.setActive(arg_8_0._gostarNo, not arg_8_0.isPass)

	arg_8_0.hasElement = Activity176Config.instance:getElementCo(arg_8_0.actId, arg_8_0.id) ~= nil

	gohelper.setActive(arg_8_0._gostagenormal, not arg_8_0.unlock and not arg_8_0.hasElement)
	gohelper.setActive(arg_8_0._gostagenormal2, not arg_8_0.unlock and arg_8_0.hasElement)
	gohelper.setActive(arg_8_0._gostagefinish, arg_8_0.unlock and not arg_8_0.hasElement)
	gohelper.setActive(arg_8_0._gostagefinish2, arg_8_0.unlock and arg_8_0.hasElement)
end

function var_0_0.lockStatus(arg_9_0)
	gohelper.setActive(arg_9_0._gostagefinish, true)
	gohelper.setActive(arg_9_0._gostar, false)
	gohelper.setActive(arg_9_0._gostarNo, true)
end

function var_0_0.isUnlock(arg_10_0)
	return arg_10_0.unlock
end

function var_0_0.playStory(arg_11_0)
	arg_11_0:destroyWorkFlow()

	arg_11_0._flow = FlowSequence.New()

	if not arg_11_0.isPass then
		arg_11_0._flow:addWork(FunctionWork.New(arg_11_0.onStartEpisode, arg_11_0))
	end

	if arg_11_0.config.beforeStory ~= 0 then
		arg_11_0._flow:addWork(PlayStoryWork.New(arg_11_0.config.beforeStory))
	end

	local var_11_0 = Activity176Config.instance:getElementCo(arg_11_0.actId, arg_11_0.id)

	if var_11_0 then
		arg_11_0._flow:addWork(FunctionWork.New(KaRongDrawController.openGame, KaRongDrawController.instance, var_11_0))
		arg_11_0._flow:addWork(WaitEventWork.New(var_0_2))
	end

	if not arg_11_0.isPass then
		arg_11_0._flow:addWork(FunctionWork.New(arg_11_0.onFinishedEpisode, arg_11_0))
	end

	if var_11_0 then
		arg_11_0._flow:addWork(FunctionWork.New(arg_11_0._lockScreen, arg_11_0, true))
		arg_11_0._flow:addWork(WorkWaitSeconds.New(var_0_1))
		arg_11_0._flow:addWork(BpCloseViewWork.New(ViewName.KaRongDrawView))
		arg_11_0._flow:addWork(FunctionWork.New(arg_11_0._lockScreen, arg_11_0, false))
	end

	if arg_11_0.config.afterStory ~= 0 then
		arg_11_0._flow:addWork(PlayStoryWork.New(arg_11_0.config.afterStory))
	end

	arg_11_0._flow:start()
end

function var_0_0._lockScreen(arg_12_0, arg_12_1)
	if arg_12_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("KaRongStoryItem")
	else
		UIBlockMgr.instance:endBlock("KaRongStoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.onStartEpisode(arg_13_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_13_0.config.chapterId, arg_13_0.id)
end

function var_0_0.onFinishedEpisode(arg_14_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_14_0.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function var_0_0.destroyWorkFlow(arg_15_0)
	if arg_15_0._flow then
		arg_15_0._flow:destroy()

		arg_15_0._flow = nil
	end
end

function var_0_0.playFinish(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_karong_finish)
	arg_16_0._anim:Play("finish")
end

function var_0_0.playUnlock(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_karong_unlock)
	arg_17_0._anim:Play("unlock")
	gohelper.setActive(arg_17_0._gostagefinish, not arg_17_0.hasElement)
	gohelper.setActive(arg_17_0._gostagefinish2, arg_17_0.hasElement)
end

function var_0_0.playStarAnim(arg_18_0)
	arg_18_0:refreshStatus()
	arg_18_0._animStar:Play()
end

function var_0_0.setFocusFlag(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goCurrent, arg_19_1)
end

function var_0_0.getFocusFlagTran(arg_20_0)
	return arg_20_0._goCurrent.transform
end

function var_0_0.onDestroy(arg_21_0)
	arg_21_0:destroyWorkFlow()
	arg_21_0:_lockScreen(false)
end

return var_0_0
