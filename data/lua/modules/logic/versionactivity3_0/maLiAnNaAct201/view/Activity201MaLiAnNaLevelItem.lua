module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaLevelItem", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gopointnormal = gohelper.findChild(arg_1_1, "#image_point_normal")
	arg_1_0._gppointfinish = gohelper.findChild(arg_1_1, "#image_point_finish")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_1, "unlock/#go_stagenormal")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_1, "unlock/#go_stagefinish")
	arg_1_0._imagestagenum = gohelper.findChildImage(arg_1_1, "unlock/info/#image_Num")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_1, "unlock/info/#txt_stagename")
	arg_1_0._gobattletag = gohelper.findChild(arg_1_1, "unlock/info/#txt_stagename/#go_Battle")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_1, "unlock/info/#txt_stageNum")
	arg_1_0._gostar = gohelper.findChild(arg_1_1, "unlock/info/#go_star")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_1, "unlock/#btn_click")
	arg_1_0._goCurrent = gohelper.findChild(arg_1_1, "unlock/#go_Current")
	arg_1_0._gofinish = gohelper.findChild(arg_1_1, "unlock/finish")
	arg_1_0._gounlock = gohelper.findChild(arg_1_1, "unlock")
	arg_1_0._stars = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 2 do
		local var_1_0 = {
			go = gohelper.findChild(arg_1_1, "unlock/info/#go_star/star" .. iter_1_0)
		}

		var_1_0.has = gohelper.findChild(var_1_0.go, "has")
		var_1_0.no = gohelper.findChild(var_1_0.go, "no")

		table.insert(arg_1_0._stars, var_1_0)
	end

	arg_1_0._govxunlockeff = gohelper.setActive(arg_1_1, "vx_unlock")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
end

function var_0_0._btnOnClick(arg_3_0)
	if arg_3_0._isStoryEpisode then
		if arg_3_0._config.storyBefore > 0 then
			local var_3_0 = {}

			var_3_0.mark = true

			Activity201MaLiAnNaController.instance:stopBurnAudio()
			StoryController.instance:playStory(arg_3_0._config.storyBefore, var_3_0, arg_3_0._onGameFinished, arg_3_0)
		else
			arg_3_0:_onGameFinished()
		end
	elseif arg_3_0._config.storyBefore > 0 then
		local var_3_1 = {}

		var_3_1.mark = true

		Activity201MaLiAnNaController.instance:stopBurnAudio()
		StoryController.instance:playStory(arg_3_0._config.storyBefore, var_3_1, arg_3_0._enterGame, arg_3_0)
	else
		arg_3_0:_enterGame()
	end
end

function var_0_0.setParam(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._config = arg_4_1
	arg_4_0.id = arg_4_1.episodeId
	arg_4_0._actId = arg_4_3
	arg_4_0._index = arg_4_2
	arg_4_0._isStoryEpisode = arg_4_0._config.gameId == 0

	gohelper.setActive(arg_4_0._gobattletag, not arg_4_0._isStoryEpisode)

	arg_4_0.gameId = arg_4_0._config.gameId

	arg_4_0:refreshUI()
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0._isunlock = Activity201MaLiAnNaModel.instance:isEpisodeUnlock(arg_5_0.id)
	arg_5_0._ispass = Activity201MaLiAnNaModel.instance:isEpisodePass(arg_5_0.id)

	gohelper.setActive(arg_5_0._gopointnormal, not arg_5_0._ispass)
	gohelper.setActive(arg_5_0._gppointfinish, arg_5_0._ispass)
	gohelper.setActive(arg_5_0._gounlock, arg_5_0._isunlock)

	if arg_5_0._isunlock then
		gohelper.setActive(arg_5_0._gostagenormal, not arg_5_0._ispass)
		gohelper.setActive(arg_5_0._gostagefinish, arg_5_0._ispass)

		arg_5_0._txtstagename.text = arg_5_0._config.name
		arg_5_0._txtstagenum.text = string.format("STAGE %02d", arg_5_0._index)

		local var_5_0 = string.format("v3a0_malianna_level_stage%02d", arg_5_0._index)

		UISpriteSetMgr.instance:setMaliAnNaSprite(arg_5_0._imagestagenum, var_5_0)

		for iter_5_0, iter_5_1 in ipairs(arg_5_0._stars) do
			gohelper.setActive(iter_5_1.no, not arg_5_0._ispass)
			gohelper.setActive(iter_5_1.has, arg_5_0._ispass)
		end
	end

	local var_5_1 = arg_5_0.id == Activity201MaLiAnNaModel.instance:getCurEpisode()

	gohelper.setActive(arg_5_0._goCurrent, var_5_1)
end

function var_0_0._enterGame(arg_6_0)
	Activity201MaLiAnNaController.instance:startBurnAudio()

	if Activity201MaLiAnNaModel.instance:checkEpisodeFinishGame(arg_6_0.id) and not Activity201MaLiAnNaModel.instance:isEpisodePass(arg_6_0.id) then
		arg_6_0:_onGameFinished()
	else
		Activity201MaLiAnNaGameController.instance:enterGame(arg_6_0.gameId, arg_6_0.id)
	end
end

function var_0_0._onGameFinished(arg_7_0)
	Activity201MaLiAnNaController.instance:_onGameFinished(arg_7_0._actId, arg_7_0.id)
end

function var_0_0.isUnlock(arg_8_0)
	return arg_8_0._islvunlock
end

function var_0_0.playFinish(arg_9_0)
	arg_9_0._ispass = Activity201MaLiAnNaModel.instance:isEpisodePass(arg_9_0.id)

	gohelper.setActive(arg_9_0._gopointnormal, not arg_9_0._ispass)
	gohelper.setActive(arg_9_0._gppointfinish, arg_9_0._ispass)
	gohelper.setActive(arg_9_0._gostagenormal, not arg_9_0._ispass)
	gohelper.setActive(arg_9_0._gostagefinish, arg_9_0._ispass)
	gohelper.setActive(arg_9_0._goCurrent, false)

	arg_9_0._anim.enabled = true

	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_finish)
	arg_9_0._anim:Play("finish", 0, 0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._stars) do
		gohelper.setActive(iter_9_1.no, not arg_9_0._ispass)
		gohelper.setActive(iter_9_1.has, arg_9_0._ispass)
	end
end

function var_0_0.playUnlock(arg_10_0)
	arg_10_0._isunlock = Activity201MaLiAnNaModel.instance:isEpisodeUnlock(arg_10_0.id)

	gohelper.setActive(arg_10_0._gounlock, arg_10_0._isunlock)

	local var_10_0 = arg_10_0.id == Activity201MaLiAnNaModel.instance:getCurEpisode()

	gohelper.setActive(arg_10_0._goCurrent, var_10_0)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_appear)
	arg_10_0._anim:Play("unlock", 0, 0)
end

function var_0_0.playStarAnim(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function var_0_0.removeEventListeners(arg_12_0)
	Activity201MaLiAnNaController.instance:unregisterCallback(NuoDiKaEvent.JumpToEpisode, arg_12_0._onJumpToEpisode, arg_12_0)
	arg_12_0._btnclick:RemoveClickListener()
end

return var_0_0
