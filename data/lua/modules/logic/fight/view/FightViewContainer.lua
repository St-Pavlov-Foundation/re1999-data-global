module("modules.logic.fight.view.FightViewContainer", package.seeall)

slot0 = class("FightViewContainer", BaseViewContainer)
slot0.hanCardClass = FightViewHandCard
slot0.operationClass = FightViewPlayCard
slot0.playCardClass = FightViewWaitingAreaVersion1

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/#scroll_effecttips"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "root/#scroll_effecttips/Viewport/#go_item"
	slot1.cellClass = FightViewTechniqueCell
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 150
	slot1.cellHeight = 145
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 25.1
	slot1.startSpace = 0
	slot0.fightView = FightView.New()
	slot0.fightViewHandCard = uv0.hanCardClass.New()
	slot0.fightViewPlayCard = uv0.operationClass.New()
	slot0.waitingArea = nil

	if FightModel.instance:getVersion() and slot2 >= 1 then
		slot0.waitingArea = uv0.playCardClass.New()
	else
		slot0.waitingArea = FightViewWaitingArea.New()
	end

	slot3 = {
		slot0.fightView,
		FightViewPartVisible.New(),
		slot0.fightViewHandCard,
		slot0.fightViewPlayCard,
		FightViewExPoint.New(),
		slot0.waitingArea,
		FightViewClothSkillMgrView.New(),
		FightViewTips.New(),
		FightViewSkillFrame.New(),
		FightViewTechnique.New(),
		LuaListScrollView.New(FightViewTechniqueListModel.instance, slot1),
		FightViewDialog.New(),
		FightViewEnemyCard.New(),
		FightHideUIView.New(),
		FightEnemyInfoView.New(),
		FightViewTeachNote.New(),
		FightViewCheckActivityEnd.New(),
		FightIndicatorMgrView.New(),
		FightDreamlandTaskView.New(),
		FightPreDisplayView.New(),
		FightShuZhenView.New(),
		FightPlayerOperateMgr.New(),
		FightViewRougeMgr.New(),
		FightViewAssistBoss.New(),
		FightViewDissolveCard.New(),
		FightViewASFDEnergy.New(),
		FightViewRedAndBlueArea.New()
	}

	table.insert(slot3, FightViewBossHpMgr.New())
	table.insert(slot3, FightViewMgr.New())

	return slot3
end

function slot0.openFightFocusView(slot0)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Cachot then
		slot2 = V1a6_CachotHeroGroupController.instance

		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = V1a6_CachotHeroGroupModel.instance:getCurGroupMO(),
			setEquipInfo = {
				slot2.getFightFocusEquipInfo,
				slot2
			}
		})

		return
	end

	if slot1 and slot1.type == DungeonEnum.EpisodeType.Rouge then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = RougeHeroGroupModel.instance:getCurGroupMO(),
			balanceHelper = RougeHeroGroupBalanceHelper
		})

		return
	end

	ViewMgr.instance:openView(ViewName.FightFocusView)
end

return slot0
