module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelItem", package.seeall)

slot0 = class("ActDuDuGuLevelItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gogameicon = gohelper.findChild(slot0.go, "unlock/#go_gameicon")
	slot0._imagegameicon = gohelper.findChildImage(slot0.go, "unlock/#go_gameicon")
	slot0._gostagenormal = gohelper.findChild(slot0.go, "unlock/#go_stagenormal")
	slot0._gostageunlock = gohelper.findChild(slot0.go, "unlock/#go_stageunlock")
	slot0._gostagefinish = gohelper.findChild(slot0.go, "unlock/#go_stagefinish")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "unlock/#btn_click")
	slot0._txtname = gohelper.findChildText(slot0.go, "unlock/info/#txt_stagename")
	slot0._txtnum = gohelper.findChildText(slot0.go, "unlock/info/#txt_stageNum")
	slot0._txtstage = gohelper.findChildText(slot0.go, "unlock/info/txt_stage")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.go, "unlock/info/#btn_review")
	slot0._gostarno = gohelper.findChild(slot0.go, "unlock/info/star1/no")
	slot0._imagestarno = gohelper.findChildImage(slot0.go, "unlock/info/star1/no")
	slot0._gostar = gohelper.findChild(slot0.go, "unlock/info/star1/#go_star")
	slot0._anim = slot0.go:GetComponent(gohelper.Type_Animator)
	slot0._goimagestar = gohelper.findChild(slot0._gostar, "#image_Star")
	slot0._animStar = slot0._goimagestar:GetComponent(gohelper.Type_Animation)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnOnClick, slot0)
	slot0._btnreview:AddClickListener(slot0._btnOnReview, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnreview:RemoveClickListener()
end

function slot0.onDestroy(slot0)
end

function slot0._btnOnClick(slot0)
	if not slot0._islvunlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActDuDuGuModel.instance:setCurLvIndex(slot0._index)
	slot0:_playBeforeStory()
end

function slot0._playBeforeStory(slot0)
	if slot0._config.beforeStory > 0 then
		slot1 = {
			mark = true,
			episodeId = slot0._config.id
		}

		if slot0._config.battleId <= 0 then
			DungeonRpc.instance:sendStartDungeonRequest(slot0._config.chapterId, slot0._config.id)
		end

		StoryController.instance:playStory(slot0._config.beforeStory, slot1, slot0._enterFight, slot0)
	else
		slot0:_enterFight()
	end
end

function slot0._enterFight(slot0)
	if slot0._config.battleId and slot0._config.battleId > 0 then
		DungeonRpc.instance:sendStartDungeonRequest(slot0._config.chapterId, slot0._config.id)
		DungeonFightController.instance:enterFightByBattleId(slot0._config.chapterId, slot0._config.id, slot0._config.battleId)
	else
		slot0:_enterAfterStory()
	end
end

function slot0._enterAfterStory(slot0)
	if slot0._config.afterStory > 0 then
		StoryController.instance:playStory(slot0._config.afterStory, {
			mark = true,
			episodeId = slot0._config.id
		}, slot0._onLevelFinished, slot0)
	else
		slot0:_onLevelFinished()
	end
end

function slot0._onLevelFinished(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function slot0._btnOnReview(slot0)
end

function slot0.setParam(slot0, slot1, slot2, slot3)
	slot0._config = slot1
	slot0.id = slot1.id
	slot0._episodeInfo = DungeonModel.instance:getEpisodeInfo(slot0.id)
	slot0._actId = slot3
	slot0._index = slot2

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0._txtname.text = slot0._config.name
	slot0._txtnum.text = "0" .. slot0._index

	gohelper.setActive(slot0._gogameicon, slot0._config.battleId > 0)
	slot0:refreshStatus()
end

function slot0.refreshStatus(slot0)
	slot0._islvunlock = ActDuDuGuModel.instance:isLevelUnlock(slot0._actId, slot0.id)
	slot0._islvpass = ActDuDuGuModel.instance:isLevelPass(slot0._actId, slot0.id)

	if slot0._islvunlock then
		slot0._anim:Play(slot0._islvpass and "finishidle" or "normalidle")
	else
		slot0._anim:Play("lockidle")
	end
end

function slot0.lockStatus(slot0)
	slot0._anim:Play("finishidle")
end

function slot0.isUnlock(slot0)
	return slot0._islvunlock
end

function slot0.playFinish(slot0)
	slot0._anim:Play("finish", 0, 0)
end

function slot0.playUnlock(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	slot0._anim:Play("unlock", 0, 0)
end

function slot0.playStarAnim(slot0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
	slot0._animStar:Play()
end

return slot0
