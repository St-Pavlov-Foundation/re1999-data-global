module("modules.logic.enemyinfo.view.EnemyInfoEnterView", package.seeall)

slot0 = class("EnemyInfoEnterView", BaseViewExtended)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.simageRightBg = gohelper.findChildSingleImage(slot0.viewGO, "bg_container/#simage_rightbg")

	slot0.simageRightBg:LoadImage("singlebg/dungeon/bg_battledetail.png")

	slot4 = "#go_tab_container"
	slot0.trTabContainer = gohelper.findChildComponent(slot0.viewGO, slot4, gohelper.Type_Transform)

	for slot4 = 0, slot0.trTabContainer.childCount - 1 do
		gohelper.setActive(slot0.trTabContainer:GetChild(slot4).gameObject, false)
	end
end

function slot0.initHandleDict(slot0)
	if slot0.tabEnum2HandleFunc then
		return
	end

	slot0.tabEnum2HandleFunc = {
		[EnemyInfoEnum.TabEnum.Normal] = slot0.refreshNormal,
		[EnemyInfoEnum.TabEnum.WeekWalk] = slot0.refreshWeekWalk,
		[EnemyInfoEnum.TabEnum.Season123] = slot0.refreshSeason,
		[EnemyInfoEnum.TabEnum.BossRush] = slot0.refreshBossRush
	}
end

function slot0.onOpen(slot0)
	slot1 = slot0.enemyInfoMo

	slot1:setTabEnum(slot0.viewParam.tabEnum)
	slot0:initHandleDict()
	slot0.tabEnum2HandleFunc[slot1.tabEnum] or slot0.refreshNormal(slot0)
end

function slot0.refreshNormal(slot0)
	slot1 = slot0.enemyInfoMo

	slot1:setShowLeftTab(false)
	slot1:updateBattleId(slot0.viewParam.battleId)
end

function slot0.refreshWeekWalk(slot0)
	slot0.tabView = slot0:createTabView(EnemyInfoWeekWalkTabView)

	slot0.tabView:onOpen()
end

function slot0.refreshSeason(slot0)
	if slot0.viewParam.showLeftTab then
		slot0.enemyInfoMo:setShowLeftTab(true)

		slot0.tabView = slot0:createTabView(EnemyInfoSeason123TabView)

		slot0.tabView:onOpen()
	else
		slot1:setShowLeftTab(false)
		slot1:updateBattleId(slot0.viewParam.battleId)
	end
end

function slot0.refreshBossRush(slot0)
	slot1 = slot0.enemyInfoMo

	slot1:setShowLeftTab(false)
	slot1:updateBattleId(DungeonConfig.instance:getEpisodeCO(lua_activity128_episode.configDict[slot0.viewParam.activityId][slot0.viewParam.stage][slot0.viewParam.layer].episodeId).battleId)
end

function slot0.createTabView(slot0, slot1)
	slot2 = slot1.New()

	slot2:__onInit()

	slot2.viewGO = slot0.viewGO
	slot2.viewContainer = slot0.viewContainer
	slot2.viewName = slot0.viewName

	slot2:onInitView()
	slot2:addEvents()

	slot2.layoutMo = slot0.layoutMo
	slot2.enemyInfoMo = slot0.enemyInfoMo
	slot2.viewParam = slot0.viewParam

	return slot2
end

function slot0.onClose(slot0)
	if slot0.tabView then
		slot0.tabView:onClose()
	end
end

function slot0.onDestroyView(slot0)
	if slot0.tabView then
		slot0.tabView:removeEvents()
		slot0.tabView:onDestroyView()
		slot0.tabView:__onDispose()
	end

	slot0.simageRightBg:UnLoadImage()
end

return slot0
