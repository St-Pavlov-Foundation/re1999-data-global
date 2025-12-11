module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiStoryItem", package.seeall)

local var_0_0 = class("YeShuMeiStoryItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")
	arg_1_0._typeNode = {}

	arg_1_0:_initType()

	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._initType(arg_2_0)
	for iter_2_0 = 1, 2 do
		local var_2_0 = arg_2_0:getUserDataTb_()

		var_2_0.go = gohelper.findChild(arg_2_0.viewGO, "unlock/#go_StageType" .. iter_2_0)
		var_2_0.gounlocked = gohelper.findChild(var_2_0.go, "#go_UnLocked")
		var_2_0.golock = gohelper.findChild(var_2_0.go, "#go_Locked")
		var_2_0.txtlockNum = gohelper.findChildText(var_2_0.go, "#go_Locked/#txt_stageNum")
		var_2_0.txtlockName = gohelper.findChildText(var_2_0.go, "#go_Locked/#txt_StageName")
		var_2_0.txtunlockedNum = gohelper.findChildText(var_2_0.go, "#go_UnLocked/#txt_stageNum")
		var_2_0.txtunlockedName = gohelper.findChildText(var_2_0.go, "#go_UnLocked/#txt_StageName")
		var_2_0.gofinished = gohelper.findChild(var_2_0.go, "#go_Finished")
		var_2_0.txtfinishedNum = gohelper.findChildText(var_2_0.go, "#go_Finished/#txt_stageNum")
		var_2_0.txtfinishedName = gohelper.findChildText(var_2_0.go, "#go_Finished/#txt_StageName")
		var_2_0.gocurrent = gohelper.findChild(var_2_0.go, "#go_Current")
		var_2_0.txtcurrentNum = gohelper.findChildText(var_2_0.go, "#go_Current/#txt_stageNum")
		var_2_0.txtcurrentName = gohelper.findChildText(var_2_0.go, "#go_Current/#txt_StageName")
		var_2_0.gono = gohelper.findChild(var_2_0.go, "Star/no")
		var_2_0.gostar = gohelper.findChild(var_2_0.go, "Star/#go_star")
		var_2_0.gostaranim = gohelper.findChild(var_2_0.go, "Star/#go_star/#image_Star")
		var_2_0.animstar = var_2_0.gostaranim:GetComponent(typeof(UnityEngine.Animation))

		table.insert(arg_2_0._typeNode, var_2_0)
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnOnClick, arg_3_0)
end

function var_0_0._btnOnClick(arg_4_0)
	if arg_4_0._isStoryEpisode then
		if arg_4_0._config.storyBefore > 0 then
			local var_4_0 = {}

			var_4_0.mark = true

			StoryController.instance:playStory(arg_4_0._config.storyBefore, var_4_0, arg_4_0._onGameFinished, arg_4_0)
		else
			arg_4_0:_onGameFinished()
		end
	elseif arg_4_0._config.storyBefore > 0 then
		local var_4_1 = {}

		var_4_1.mark = true

		StoryController.instance:playStory(arg_4_0._config.storyBefore, var_4_1, arg_4_0._enterGame, arg_4_0)
	else
		arg_4_0:_enterGame()
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, arg_4_0._index)
end

function var_0_0.setParam(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._config = arg_5_1
	arg_5_0.id = arg_5_1.episodeId
	arg_5_0._actId = arg_5_3
	arg_5_0._index = arg_5_2
	arg_5_0._isStoryEpisode = arg_5_0._config.gameId == 0

	gohelper.setActive(arg_5_0._typeNode[1].go, arg_5_0._isStoryEpisode)
	gohelper.setActive(arg_5_0._typeNode[2].go, not arg_5_0._isStoryEpisode)

	arg_5_0._node = arg_5_0._isStoryEpisode and arg_5_0._typeNode[1] or arg_5_0._typeNode[2]
	arg_5_0.gameId = arg_5_0._config.gameId

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0._isunlock = YeShuMeiModel.instance:isEpisodeUnlock(arg_6_0.id)
	arg_6_0._ispass = YeShuMeiModel.instance:isEpisodePass(arg_6_0.id)

	local var_6_0 = arg_6_0.id == YeShuMeiModel.instance:getCurEpisode()

	gohelper.setActive(arg_6_0._node.golock, not arg_6_0._isunlock)
	gohelper.setActive(arg_6_0._btnclick.gameObject, arg_6_0._isunlock)
	gohelper.setActive(arg_6_0._node.gofinished, not var_6_0 and arg_6_0._ispass)
	gohelper.setActive(arg_6_0._node.gounlocked, not var_6_0 and not arg_6_0._ispass and arg_6_0._isunlock)
	gohelper.setActive(arg_6_0._node.gocurrent, var_6_0)

	arg_6_0._node.txtunlockedName.text = arg_6_0._config.name
	arg_6_0._node.txtunlockedNum.text = string.format("%02d", arg_6_0._index)
	arg_6_0._node.txtlockName.text = arg_6_0._config.name
	arg_6_0._node.txtlockNum.text = string.format("%02d", arg_6_0._index)
	arg_6_0._node.txtfinishedName.text = arg_6_0._config.name
	arg_6_0._node.txtfinishedNum.text = string.format("%02d", arg_6_0._index)
	arg_6_0._node.txtcurrentName.text = arg_6_0._config.name
	arg_6_0._node.txtcurrentNum.text = string.format("%02d", arg_6_0._index)

	gohelper.setActive(arg_6_0._node.gono, not arg_6_0._ispass)
	gohelper.setActive(arg_6_0._node.gostar, arg_6_0._ispass)
end

function var_0_0._enterGame(arg_7_0)
	if YeShuMeiModel.instance:checkEpisodeFinishGame(arg_7_0.id) and not YeShuMeiModel.instance:isEpisodePass(arg_7_0.id) then
		arg_7_0:_onGameFinished()
	else
		YeShuMeiGameController.instance:enterGame(arg_7_0.id)
	end
end

function var_0_0._onGameFinished(arg_8_0)
	YeShuMeiController.instance:_onGameFinished(arg_8_0._actId, arg_8_0.id)
end

function var_0_0.isUnlock(arg_9_0)
	return arg_9_0._isunlock
end

function var_0_0.playFinish(arg_10_0)
	arg_10_0._ispass = YeShuMeiModel.instance:isEpisodePass(arg_10_0.id)

	gohelper.setActive(arg_10_0._node.gofinished, arg_10_0._ispass)
	gohelper.setActive(arg_10_0._node.gounlocked, false)
	gohelper.setActive(arg_10_0._node.gocurrent, false)

	arg_10_0._anim.enabled = true

	arg_10_0._anim:Play("finish", 0, 0)

	if arg_10_0._isunlock then
		gohelper.setActive(arg_10_0._node.gono, not arg_10_0._ispass)
		gohelper.setActive(arg_10_0._node.gostar, arg_10_0._ispass)
	end
end

function var_0_0.setFocusFlag(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._node.gocurrent, arg_11_1)
end

function var_0_0.playUnlock(arg_12_0)
	arg_12_0._isunlock = YeShuMeiModel.instance:isEpisodeUnlock(arg_12_0.id)

	local var_12_0 = arg_12_0.id == YeShuMeiModel.instance:getCurEpisode()

	gohelper.setActive(arg_12_0._node.gounlocked, false)
	gohelper.setActive(arg_12_0._node.golock, false)
	gohelper.setActive(arg_12_0._node.gofinished, false)
	gohelper.setActive(arg_12_0._node.gocurrent, var_12_0)
	arg_12_0._anim:Play("unlock", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_jiesuo)
end

function var_0_0.playStarAnim(arg_13_0)
	arg_13_0._node.animstar:Play()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function var_0_0.removeEventListeners(arg_14_0)
	YeShuMeiController.instance:unregisterCallback(NuoDiKaEvent.JumpToEpisode, arg_14_0._onJumpToEpisode, arg_14_0)
	arg_14_0._btnclick:RemoveClickListener()
end

return var_0_0
