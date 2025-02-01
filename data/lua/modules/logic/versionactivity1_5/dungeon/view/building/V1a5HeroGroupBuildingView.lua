module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5HeroGroupBuildingView", package.seeall)

slot0 = class("V1a5HeroGroupBuildingView", BaseView)

function slot0.onInitView(slot0)
	slot0._gototem = gohelper.findChild(slot0.viewGO, "#go_totem")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, slot0.switchReplay, slot0)
end

function slot0.removeEvents(slot0)
end

slot0.PrefabPath = "ui/viewres/herogroup/herogroupviewtotem.prefab"

function slot0.onOpen(slot0)
	slot3 = false

	if FightModel.instance:getFightParam().chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story1 or slot2 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story2 or slot2 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story3 or slot2 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story4 or slot2 == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId) then
			return
		end

		slot3 = true
	end

	if not slot3 then
		return
	end

	slot0.loader = PrefabInstantiate.Create(slot0._gototem)

	slot0.loader:startLoad(uv0.PrefabPath, slot0.onLoadFinish, slot0)
	VersionActivity1_5DungeonRpc.instance:sendGet140InfosRequest(slot0.onReceiveMsg, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.loadFinishDone = true
	slot0.go = slot0.loader:getInstGO()
	slot0.goPointContainer = gohelper.findChild(slot0.go, "#go_totem/totem/point_container/")
	slot0.pointItemList = slot0:getUserDataTb_()

	table.insert(slot0.pointItemList, slot0:createPointItem(gohelper.findChild(slot0.go, "#go_totem/totem/point_container/#go_pointitem1")))
	table.insert(slot0.pointItemList, slot0:createPointItem(gohelper.findChild(slot0.go, "#go_totem/totem/point_container/#go_pointitem2")))
	table.insert(slot0.pointItemList, slot0:createPointItem(gohelper.findChild(slot0.go, "#go_totem/totem/point_container/#go_pointitem3")))

	slot0._singleBg = gohelper.findChildSingleImage(slot0.go, "#go_totem/totem/bg")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#go_totem/#btn_click")

	slot0._btnclick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0:refreshPoint()
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, slot0.onUpdateSelectBuild, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0.createPointItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.image = slot1:GetComponent(gohelper.Type_Image)
	slot2.effectGo1 = gohelper.findChild(slot1, "#effect_green")
	slot2.effectGo2 = gohelper.findChild(slot1, "#effect_yellow")

	return slot2
end

function slot0.onReceiveMsg(slot0)
	slot0.receiveMsgDone = true

	slot0:refreshPoint()
end

function slot0.refreshPoint(slot0)
	if not slot0.receiveMsgDone then
		return
	end

	if not slot0.loadFinishDone then
		return
	end

	gohelper.setActive(slot0._gototem, true)
	gohelper.setActive(slot0.goPointContainer, not slot0.isReplay)

	if not slot0.isReplay then
		for slot4 = 1, VersionActivity1_5DungeonEnum.BuildCount do
			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot0.pointItemList[slot4].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[VersionActivity1_5BuildModel.instance:getSelectType(slot4)])
		end
	end
end

function slot0.switchReplay(slot0, slot1)
	slot0.isReplay = slot1

	slot0:refreshPoint()
end

function slot0._btnClickOnClick(slot0)
	if slot0.isReplay then
		return
	end

	for slot4, slot5 in ipairs(slot0.pointItemList) do
		gohelper.setActive(slot5.effectGo1, false)
		gohelper.setActive(slot5.effectGo2, false)
	end

	slot0.preSelectTypeList = tabletool.copy(VersionActivity1_5BuildModel.instance:getSelectTypeList())

	ViewMgr.instance:openView(ViewName.V1a5BuildingSkillView)
end

function slot0.playPointChangeAnim(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if not slot0.preSelectTypeList then
		return
	end

	for slot5, slot6 in ipairs(VersionActivity1_5BuildModel.instance:getSelectTypeList()) do
		if slot6 ~= slot0.preSelectTypeList[slot5] then
			if slot6 == VersionActivity1_5DungeonEnum.BuildType.First then
				gohelper.setActive(slot0.pointItemList[slot5].effectGo1, true)
			else
				gohelper.setActive(slot7.effectGo2, true)
			end
		end
	end

	slot0.preSelectTypeList = nil
end

function slot0.onCloseViewFinish(slot0)
	slot0:playPointChangeAnim()
end

function slot0.onUpdateSelectBuild(slot0)
	slot0:refreshPoint()
	slot0:playPointChangeAnim()
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
