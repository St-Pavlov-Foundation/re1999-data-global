module("modules.logic.versionactivity1_6.dungeon.view.fight.V1a6HeroGroupSkillView", package.seeall)

slot0 = class("V1a6HeroGroupSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._gototem = gohelper.findChild(slot0.viewGO, "#go_totem")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, slot0.switchReplay, slot0)
end

function slot0.removeEvents(slot0)
end

slot0.PrefabPath = "ui/viewres/herogroup/herogroupviewtalent.prefab"

function slot0.onOpen(slot0)
	slot3 = false

	if FightModel.instance:getFightParam().chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Story1 or slot2 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story2 or slot2 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story3 or slot2 == VersionActivity1_6DungeonEnum.DungeonChapterId.Story4 or slot2 == VersionActivity1_6DungeonEnum.DungeonChapterId.ElementFight or slot2 == VersionActivity1_6DungeonEnum.DungeonChapterId.BossFight then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
			return
		end

		slot3 = true
	end

	if not slot3 then
		return
	end

	slot0.loader = PrefabInstantiate.Create(slot0._gototem)

	slot0.loader:startLoad(uv0.PrefabPath, slot0.onLoadFinish, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.loadFinishDone = true
	slot0.go = slot0.loader:getInstGO()
	slot0._singleBg = gohelper.findChildSingleImage(slot0.go, "#go_Talent/Talent/image_TalentIcon")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#go_Talent/#btn_click")

	slot0._btnclick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0:refreshPoint()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0.onReceiveMsg(slot0)
	slot0.receiveMsgDone = true

	slot0:refreshPoint()
end

function slot0.refreshPoint(slot0)
	if not slot0.loadFinishDone then
		return
	end

	gohelper.setActive(slot0._gototem, true)
end

function slot0.switchReplay(slot0, slot1)
	slot0.isReplay = slot1

	slot0:refreshPoint()
end

function slot0._btnClickOnClick(slot0)
	if slot0.isReplay then
		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillView)
end

function slot0.onCloseViewFinish(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
	end

	if slot0._singleBg then
		slot0._singleBg:UnLoadImage()
	end

	if slot0.loader then
		slot0.loader:dispose()
	end
end

return slot0
