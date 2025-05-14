module("modules.logic.versionactivity1_8.weila.view.WeilaStoryItem", package.seeall)

local var_0_0 = class("WeilaStoryItem", LuaCompBase)

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
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
	arg_2_0._btnreview:AddClickListener(arg_2_0._btnOnReview, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnreview:RemoveClickListener()
end

function var_0_0.onDestroy(arg_4_0)
	return
end

function var_0_0._btnOnClick(arg_5_0)
	if not arg_5_0.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActWeilaController.instance:dispatchEvent(ActWeilaEvent.StoryItemClick, arg_5_0.index)
end

function var_0_0._btnOnReview(arg_6_0)
	arg_6_0:_btnOnClick()
end

function var_0_0.setParam(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.config = arg_7_1
	arg_7_0.id = arg_7_1.id
	arg_7_0.index = arg_7_2

	arg_7_0:_refreshUI()
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0:refreshStatus()

	arg_8_0._txtname.text = arg_8_0.config.name
	arg_8_0._txtnum.text = "0" .. arg_8_0.index
end

function var_0_0.refreshStatus(arg_9_0)
	arg_9_0.unlock = ActWeilaModel.instance:isLevelUnlock(arg_9_0.id)

	gohelper.setActive(arg_9_0._golock, not arg_9_0.unlock)

	arg_9_0.isPass = ActWeilaModel.instance:isLevelPass(arg_9_0.id)

	gohelper.setActive(arg_9_0._gostar, arg_9_0.isPass)
	gohelper.setActive(arg_9_0._gostarNo, not arg_9_0.isPass)
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
	if arg_12_0.isPass then
		StoryController.instance:playStory(arg_12_0.config.beforeStory)
	else
		DungeonRpc.instance:sendStartDungeonRequest(arg_12_0.config.chapterId, arg_12_0.id)

		local var_12_0 = {}

		var_12_0.mark = true
		var_12_0.episodeId = arg_12_0.config.id

		StoryController.instance:playStory(arg_12_0.config.beforeStory, var_12_0, arg_12_0.onStoryFinished, arg_12_0)
	end
end

function var_0_0.onStoryFinished(arg_13_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_13_0.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function var_0_0.playFinish(arg_14_0)
	arg_14_0._anim:Play("finish")
end

function var_0_0.playUnlock(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_15_0._anim:Play("unlock")
end

function var_0_0.playStarAnim(arg_16_0)
	arg_16_0:refreshStatus()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
	arg_16_0._animStar:Play()
end

return var_0_0
