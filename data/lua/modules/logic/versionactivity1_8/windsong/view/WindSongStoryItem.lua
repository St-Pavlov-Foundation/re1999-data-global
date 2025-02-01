module("modules.logic.versionactivity1_8.windsong.view.WindSongStoryItem", package.seeall)

slot0 = class("WindSongStoryItem", LuaCompBase)

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
	if not slot0.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActWindSongController.instance:dispatchEvent(ActWindSongEvent.StoryItemClick, slot0.index)
end

function slot0._btnOnReview(slot0)
	slot0:_btnOnClick()
end

function slot0.setParam(slot0, slot1, slot2)
	slot0.config = slot1
	slot0.id = slot1.id
	slot0.index = slot2

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:refreshStatus()

	slot0._txtname.text = slot0.config.name
	slot0._txtnum.text = "0" .. slot0.index
end

function slot0.refreshStatus(slot0)
	slot0.unlock = ActWindSongModel.instance:isLevelUnlock(slot0.id)

	gohelper.setActive(slot0._golock, not slot0.unlock)

	slot0.isPass = ActWindSongModel.instance:isLevelPass(slot0.id)

	gohelper.setActive(slot0._gostar, slot0.isPass)
	gohelper.setActive(slot0._gostarNo, not slot0.isPass)
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
	if slot0.isPass then
		StoryController.instance:playStory(slot0.config.beforeStory)
	else
		DungeonRpc.instance:sendStartDungeonRequest(slot0.config.chapterId, slot0.id)
		StoryController.instance:playStory(slot0.config.beforeStory, {
			mark = true,
			episodeId = slot0.config.id
		}, slot0.onStoryFinished, slot0)
	end
end

function slot0.onStoryFinished(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function slot0.playFinish(slot0)
	slot0._anim:Play("finish")
end

function slot0.playUnlock(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	slot0._anim:Play("unlock")
end

function slot0.playStarAnim(slot0)
	slot0:refreshStatus()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
	slot0._animStar:Play()
end

return slot0
