module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelItem", package.seeall)

slot0 = class("LiangYueLevelItem", LuaCompBase)

function slot0.onInit(slot0, slot1)
	slot0._go = slot1
	slot0._goGet = gohelper.findChild(slot0._go, "unlock/#go_afterPuzzleEpisode/#go_Get")
	slot0._gostagenormal = gohelper.findChild(slot0._go, "unlock/#go_stagenormal")
	slot0._gostagefinished = gohelper.findChild(slot0._go, "unlock/#go_stagefinished")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0._go, "unlock/#btn_click")
	slot0._gostagelock = gohelper.findChild(slot0._go, "unlock/#go_stagelock")
	slot0._txtstagename = gohelper.findChildText(slot0._go, "unlock/#txt_stagename")
	slot0._txtstageNum = gohelper.findChildText(slot0._go, "unlock/#txt_stageNum")
	slot0._goAfterPuzzleItem = gohelper.findChild(slot0._go, "unlock/#go_afterPuzzleEpisode")
	slot0._btnAfterPuzzle = gohelper.findChildButton(slot0._go, "unlock/#go_afterPuzzleEpisode/#btn_puzzle")
	slot0._goStarFinish1 = gohelper.findChild(slot0._go, "unlock/star1/#go_star")
	slot0._goStarFinish2 = gohelper.findChild(slot0._go, "unlock/star2/#go_star")
	slot0._episodeAnim = gohelper.findChildAnim(slot0._go, "")
	slot0._episodeGameAnim = gohelper.findChildAnim(slot0._go, "unlock/#go_afterPuzzleEpisode")
	slot0._episodeGameFinishAnim = gohelper.findChildAnim(slot0._go, "unlock/#go_afterPuzzleEpisode/#go_Get/go_hasget")
end

function slot0.setInfo(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.actId = slot2.activityId
	slot0.episodeId = slot2.episodeId
	slot0.config = slot2
	slot0.preEpisodeId = slot2.preEpisodeId
	slot0.gameEpisodeId = LiangYueConfig.instance:getAfterGameEpisodeId(slot0.actId, slot2.episodeId)

	slot0:refreshUI()
	slot0:refreshStoryState(true)
	slot0:refreshGameState(true)
end

function slot0.refreshUI(slot0)
	slot1 = slot0.config
	slot2 = slot0.actId
	slot0._txtstagename.text = slot1.name
	slot0._txtstageNum.text = string.format("0%s", slot0.index)
	slot0.isFinish = LiangYueModel.instance:isEpisodeFinish(slot2, slot1.episodeId)
	slot0.isPreFinish = slot1.preEpisodeId == 0 or LiangYueModel.instance:isEpisodeFinish(slot2, slot1.preEpisodeId)
end

function slot0.refreshStoryState(slot0, slot1)
	slot2 = slot0.isFinish
	slot3 = slot0.isPreFinish

	gohelper.setActive(slot0._gostagelock, not slot3)
	gohelper.setActive(slot0._gostagenormal, slot3 and not slot2)
	gohelper.setActive(slot0._gostagefinished, slot2)
	gohelper.setActive(slot0._goStarFinish1, slot2)
	gohelper.setActive(slot0._goStarFinish2, slot2)

	if not slot1 then
		return
	end

	if slot2 then
		slot0:playEpisodeAnim(LiangYueEnum.EpisodeAnim.FinishIdle, 1)
	elseif slot3 then
		slot0:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, slot4)
	else
		slot0:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Empty, slot4)
	end
end

function slot0.setLockState(slot0)
	gohelper.setActive(slot0._gostagelock, true)
	gohelper.setActive(slot0._gostagenormal, false)
	gohelper.setActive(slot0._gostagefinished, false)
	gohelper.setActive(slot0._goStarFinish1, false)
	gohelper.setActive(slot0._goStarFinish2, false)
end

function slot0.refreshGameState(slot0, slot1)
	slot3 = slot0.gameEpisodeId ~= nil

	gohelper.setActive(slot0._goAfterPuzzleItem, slot3 and slot0.isFinish)
	gohelper.setActive(slot0._goGet, LiangYueModel.instance:isEpisodeFinish(slot0.actId, slot0.gameEpisodeId))

	slot5 = 1

	if not slot3 or not slot1 then
		return
	end

	slot0:playGameEpisodeRewardAnim(LiangYueEnum.EpisodeGameFinishAnim.Idle, slot5)

	if slot4 then
		slot0:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.FinishIdle, slot5)
	elseif slot2 then
		slot0:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Open, slot5)
	else
		slot0:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Idle, slot5)
	end
end

function slot0.playGameEpisodeAnim(slot0, slot1, slot2)
	slot0._episodeGameAnim:Play(slot1, 0, slot2)
end

function slot0.playEpisodeAnim(slot0, slot1, slot2)
	slot0._episodeAnim:Play(slot1, 0, slot2)
end

function slot0.playGameEpisodeRewardAnim(slot0, slot1, slot2)
	slot0._episodeGameFinishAnim:Play(slot1, 0, slot2)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnAfterPuzzle:AddClickListener(slot0._btnafterPuzzleOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnAfterPuzzle:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if ActivityModel.instance:getActMO(slot0.actId) == nil then
		logError("not such activity id: " .. slot1)

		return
	end

	if not slot2:isOpen() or slot2:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if slot0.config.preEpisodeId ~= 0 and not LiangYueModel.instance:isEpisodeFinish(slot1, slot0.config.preEpisodeId) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotOpen)

		return
	end

	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnClickStoryItem, slot0.index, slot0.config.episodeId, false)
end

function slot0._btnafterPuzzleOnClick(slot0)
	if ActivityModel.instance:getActMO(slot0.actId) == nil then
		logError("not such activity id: " .. slot1)

		return
	end

	if not slot2:isOpen() or slot2:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if not slot0.gameEpisodeId then
		logError("have no gameEpisodeId")

		return
	end

	if not LiangYueModel.instance:isEpisodeFinish(slot1, slot0.config.episodeId) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotOpen)

		return
	end

	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnClickStoryItem, slot0.index, slot0.gameEpisodeId, true)
end

function slot0.onDestroy(slot0)
end

return slot0
