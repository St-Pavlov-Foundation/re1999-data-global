module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelItem", package.seeall)

slot0 = class("WuErLiXiLevelItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._anim = slot0.go:GetComponent(gohelper.Type_Animator)
	slot0._gostagenormal1 = gohelper.findChild(slot0.go, "unlock/#go_stagenormal1")
	slot0._txtnum1 = gohelper.findChildText(slot0.go, "unlock/#go_stagenormal1/info/#txt_stageNum")
	slot0._txtname1 = gohelper.findChildText(slot0.go, "unlock/#go_stagenormal1/info/#txt_stagename")
	slot0._gostarno1 = gohelper.findChild(slot0.go, "unlock/#go_stagenormal1/info/star1/no")
	slot0._imagestarno1 = gohelper.findChildImage(slot0.go, "unlock/#go_stagenormal1/info/star1/no")
	slot0._gostar1 = gohelper.findChild(slot0.go, "unlock/#go_stagenormal1/info/star1/#go_star")
	slot0._goimagestar1 = gohelper.findChild(slot0._gostar1, "#image_Star")
	slot0._animStar1 = slot0._goimagestar1:GetComponent(gohelper.Type_Animation)
	slot0._gostagenormal2 = gohelper.findChild(slot0.go, "unlock/#go_stagenormal2")
	slot0._txtnum2 = gohelper.findChildText(slot0.go, "unlock/#go_stagenormal2/info/#txt_stageNum")
	slot0._txtname2 = gohelper.findChildText(slot0.go, "unlock/#go_stagenormal2/info/#txt_stagename")
	slot0._gostarno2 = gohelper.findChild(slot0.go, "unlock/#go_stagenormal2/info/star1/no")
	slot0._imagestarno2 = gohelper.findChildImage(slot0.go, "unlock/#go_stagenormal2/info/star1/no")
	slot0._gostar2 = gohelper.findChild(slot0.go, "unlock/#go_stagenormal2/info/star1/#go_star")
	slot0._goimagestar2 = gohelper.findChild(slot0._gostar2, "#image_Star")
	slot0._animStar2 = slot0._goimagestar2:GetComponent(gohelper.Type_Animation)
	slot0._gostageunlock = gohelper.findChild(slot0.go, "unlock/#go_stageunlock")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "unlock/#btn_click")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnOnClick, slot0)
end

function slot0._btnOnClick(slot0)
	if not slot0._islvunlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(slot0._actId, slot0.id, slot0._startEpisodeFinished, slot0)
end

function slot0._startEpisodeFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	WuErLiXiModel.instance:setCurEpisodeIndex(slot0._index)
	slot0:_playBeforeStory()
end

function slot0._playBeforeStory(slot0)
	slot0._startTime = ServerTime.now()

	if WuErLiXiModel.instance:isEpisodePass(slot0.id) then
		if slot0._config.beforeStory > 0 then
			StoryController.instance:playStory(slot0._config.beforeStory, {
				mark = true
			}, slot0._enterGame, slot0)
		else
			slot0:_enterGame()
		end

		return
	end

	if WuErLiXiModel.instance:getEpisodeStatus(slot0.id) == WuErLiXiEnum.EpisodeStatus.BeforeStory then
		if slot0._config.beforeStory > 0 then
			StoryController.instance:playStory(slot0._config.beforeStory, {
				mark = true
			}, slot0._onBeforeStoryFinished, slot0)
		else
			slot0:_enterGame()
		end
	else
		slot0:_enterGame()
	end
end

function slot0._onBeforeStoryFinished(slot0)
	Activity180Rpc.instance:sendAct180StoryRequest(slot0._actId, slot0.id, slot0._onStartUnlockBeforeStory, slot0)
end

function slot0._onStartUnlockBeforeStory(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if slot0._isStoryEpisode and slot0._config.afterStory == 0 then
		WuErLiXiModel.instance:setNewFinishEpisode(slot0.id)
	end

	slot0:_enterGame()
end

function slot0._enterGame(slot0)
	if WuErLiXiModel.instance:isEpisodePass(slot0.id) then
		if not slot0._isStoryEpisode then
			WuErLiXiController.instance:enterGameView({
				episodeId = slot0.id,
				callback = slot0._enterAfterStory,
				callbackObj = slot0
			})
		else
			slot0:_enterAfterStory()
		end

		return
	end

	if WuErLiXiModel.instance:getEpisodeStatus(slot0.id) == WuErLiXiEnum.EpisodeStatus.MapGame then
		WuErLiXiController.instance:enterGameView({
			episodeId = slot0.id,
			callback = slot0._onGameFinished,
			callbackObj = slot0
		})
	else
		slot0:_enterAfterStory()
	end
end

function slot0._onGameFinished(slot0)
	Activity180Rpc.instance:sendAct180GameFinishRequest(slot0._actId, slot0.id, slot0._onStartUnlockGame, slot0)
end

function slot0._onStartUnlockGame(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if slot0._config.afterStory == 0 then
		WuErLiXiModel.instance:setNewFinishEpisode(slot0.id)
	end

	slot0:_enterAfterStory()
end

function slot0._enterAfterStory(slot0)
	if WuErLiXiModel.instance:isEpisodePass(slot0.id) then
		if slot0._config.afterStory > 0 then
			StoryController.instance:playStory(slot0._config.afterStory, nil, slot0._levelFinished, slot0)
		else
			slot0:_levelFinished()
		end

		return
	end

	if WuErLiXiModel.instance:getEpisodeStatus(slot0.id) == WuErLiXiEnum.EpisodeStatus.AfterStory then
		if slot0._config.afterStory > 0 then
			StoryController.instance:playStory(slot0._config.afterStory, {
				mark = true
			}, slot0._onAfterStoryFinished, slot0)
		else
			slot0:_levelFinished()
		end
	else
		slot0:_levelFinished()
	end
end

function slot0._onAfterStoryFinished(slot0)
	Activity180Rpc.instance:sendAct180StoryRequest(slot0._actId, slot0.id, slot0._onStartUnlockAfterStory, slot0)
end

function slot0._onStartUnlockAfterStory(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	WuErLiXiModel.instance:setNewFinishEpisode(slot0.id)
	slot0:_levelFinished()
end

function slot0._levelFinished(slot0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiDungeonFinish, {
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.id),
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - slot0._startTime
	})
	TaskDispatcher.runDelay(slot0._backToLevel, slot0, 0.5)
end

function slot0._backToLevel(slot0)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnBackToLevel)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.EpisodeFinished)
end

function slot0.setParam(slot0, slot1, slot2, slot3)
	slot0._config = slot1
	slot0.id = slot1.episodeId
	slot0._actId = slot3
	slot0._index = slot2
	slot0._isStoryEpisode = slot0._config.mapId == 0

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._islvunlock = WuErLiXiModel.instance:isEpisodeUnlock(slot0.id)
	slot0._islvpass = WuErLiXiModel.instance:isEpisodePass(slot0.id)
	slot0._txtname1.text = slot0._config.name
	slot0._txtname2.text = slot0._config.name
	slot0._txtnum1.text = "0" .. slot0._index
	slot0._txtnum2.text = "0" .. slot0._index

	if not slot0._islvunlock then
		slot0._anim.enabled = true

		slot0._anim:Play("lockidle", 0, 0)
	elseif not slot0._islvpass then
		slot0._anim.enabled = true

		slot0._anim:Play("normalidle", 0, 0)
	else
		slot0._anim:Play("finishidle", 0, 0)
	end

	gohelper.setActive(slot0._gostagenormal1, slot0._islvunlock and slot0._isStoryEpisode)
	gohelper.setActive(slot0._gostagenormal2, slot0._islvunlock and not slot0._isStoryEpisode)
end

function slot0.isUnlock(slot0)
	return slot0._islvunlock
end

function slot0.playFinish(slot0)
	slot0._anim.enabled = true

	slot0._anim:Play("finish", 0, 0)
end

function slot0.playUnlock(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	gohelper.setActive(slot0._gostagenormal1, slot0._isStoryEpisode)
	gohelper.setActive(slot0._gostagenormal2, not slot0._isStoryEpisode)

	slot0._anim.enabled = true

	slot0._anim:Play("unlock", 0, 0)
end

function slot0.playStarAnim(slot0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.onDestroy(slot0)
end

return slot0
