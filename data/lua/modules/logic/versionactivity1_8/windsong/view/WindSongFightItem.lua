module("modules.logic.versionactivity1_8.windsong.view.WindSongFightItem", package.seeall)

slot0 = class("WindSongFightItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "#go_UnSelected")
	slot0._btnclick = gohelper.findChildButton(slot0.viewGO, "#go_UnSelected/#btn_click")
	slot0._txtstageNumN = gohelper.findChildText(slot0.viewGO, "#go_UnSelected/info/#txt_stageNum")
	slot0._gostar1N = gohelper.findChild(slot0.viewGO, "#go_UnSelected/info/#go_star/star1/#go_star1")
	slot0._gostar2N = gohelper.findChild(slot0.viewGO, "#go_UnSelected/info/#go_star/star2/#go_star2")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "#go_UnSelected/#go_Lock")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._txtstagenameS = gohelper.findChildText(slot0.viewGO, "#go_Selected/info/#txt_stagename")
	slot0._txtstageNumS = gohelper.findChildText(slot0.viewGO, "#go_Selected/info/#txt_stagename/#txt_stageNum")
	slot0._gostar1S = gohelper.findChild(slot0.viewGO, "#go_Selected/info/#txt_stagename/star1/#go_star1")
	slot0._gostar2S = gohelper.findChild(slot0.viewGO, "#go_Selected/info/#txt_stagename/star2/#go_star2")
	slot0._btnNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Selected/#btn_Normal")
	slot0._btnHard = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Selected/#btn_Hard")
	slot0._goHardLock = gohelper.findChild(slot0.viewGO, "#go_Selected/#btn_Hard/#go_Lock")
	slot0._selectAnim = slot0._goSelected:GetComponent(gohelper.Type_Animator)
	slot0._animLock = slot0._goLock:GetComponent(gohelper.Type_Animator)
	slot0._animStar1S = slot0._gostar1S:GetComponent(gohelper.Type_Animation)
	slot0._animStar2S = slot0._gostar2S:GetComponent(gohelper.Type_Animation)
	slot0._animHardLock = slot0._goHardLock:GetComponent(gohelper.Type_Animator)
	slot0._gostar1Nno = gohelper.findChild(slot0.viewGO, "#go_UnSelected/info/#go_star/star1/no")
	slot0._gostar2Nno = gohelper.findChild(slot0.viewGO, "#go_UnSelected/info/#go_star/star2/no")
	slot0._gostar1Sno = gohelper.findChild(slot0.viewGO, "#go_Selected/info/#txt_stagename/star1/no")
	slot0._gostar2Sno = gohelper.findChild(slot0.viewGO, "#go_Selected/info/#txt_stagename/star2/no")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnOnClick, slot0)
	slot0._btnNormal:AddClickListener(slot0._btnOnNormal, slot0)
	slot0._btnHard:AddClickListener(slot0._btnOnHard, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnNormal:RemoveClickListener()
	slot0._btnHard:RemoveClickListener()
end

function slot0.onDestroy(slot0)
end

function slot0._btnOnClick(slot0)
	if not slot0.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActWindSongController.instance:dispatchEvent(ActWindSongEvent.FightItemClick, slot0.index)
end

function slot0._btnOnNormal(slot0)
	slot0:enterFight(slot0.config)
end

function slot0._btnOnHard(slot0)
	if not ActWindSongModel.instance:isLevelUnlock(slot0.hardConfig.id) then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	slot0:enterFight(slot0.hardConfig)
end

function slot0.setParam(slot0, slot1, slot2)
	slot0.config = slot1
	slot0.id = slot1.id
	slot0.hardConfig = DungeonConfig.instance:getEpisodeCO(slot0.id + 1)
	slot0.index = slot2

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:refreshStatus()

	slot0._txtstageNumN.text = "0" .. slot0.index
	slot0._txtstageNumS.text = "0" .. slot0.index
	slot0._txtstagenameS.text = slot0.config.name
end

function slot0.refreshStatus(slot0)
	slot0.unlock = ActWindSongModel.instance:isLevelUnlock(slot0.id)

	gohelper.setActive(slot0._goLock, not slot0.unlock)
	gohelper.setActive(slot0._goHardLock, not ActWindSongModel.instance:isLevelUnlock(slot0.hardConfig.id))
	slot0:refreshStar()
end

function slot0.refreshStar(slot0)
	slot1 = ActWindSongModel.instance:isLevelPass(slot0.id)
	slot2 = ActWindSongModel.instance:isLevelPass(slot0.hardConfig.id)

	gohelper.setActive(slot0._gostar1N, slot1)
	gohelper.setActive(slot0._gostar1S, slot1)
	gohelper.setActive(slot0._gostar2N, slot2)
	gohelper.setActive(slot0._gostar2S, slot2)
	gohelper.setActive(slot0._gostar1Nno, not slot1)
	gohelper.setActive(slot0._gostar1Sno, not slot1)
	gohelper.setActive(slot0._gostar2Nno, not slot2)
	gohelper.setActive(slot0._gostar2Sno, not slot2)
end

function slot0.refreshSelect(slot0, slot1)
	slot1 = slot1 or slot0.index

	gohelper.setActive(slot0._goNormal, slot0.index ~= slot1)
	gohelper.setActive(slot0._goSelected, slot0.index == slot1)

	if slot1 and slot0._goSelected.activeInHierarchy then
		slot0._selectAnim:Play("open")
	end
end

function slot0.isUnlock(slot0)
	return slot0.unlock
end

function slot0.enterFight(slot0, slot1)
	slot3 = slot1.id
	slot4 = slot1.battleId

	if slot1.chapterId and slot3 and slot4 > 0 then
		ActWindSongModel.instance:setEnterFightIndex(slot0.index)
		DungeonFightController.instance:enterFightByBattleId(slot2, slot3, slot4)
	end
end

function slot0.playUnlock(slot0)
	slot0._animLock:Play("unlock")
end

function slot0.playHardUnlock(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	slot0._animHardLock:Play("unlock")
end

function slot0.playStarAnim(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)

	if slot1 then
		slot0._animStar1S:Play()
	else
		slot0._animStar2S:Play()
	end
end

return slot0
