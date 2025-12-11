module("modules.logic.fight.view.FightViewContainer", package.seeall)

local var_0_0 = class("FightViewContainer", BaseViewContainer)

var_0_0.hanCardClass = FightViewHandCard
var_0_0.operationClass = FightViewPlayCard
var_0_0.playCardClass = FightViewWaitingAreaVersion1

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "root/#scroll_effecttips"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "root/#scroll_effecttips/Viewport/#go_item"
	var_1_0.cellClass = FightViewTechniqueCell
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 150
	var_1_0.cellHeight = 145
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 25.1
	var_1_0.startSpace = 0
	arg_1_0.fightView = FightView.New()
	arg_1_0.fightViewHandCard = var_0_0.hanCardClass.New()
	arg_1_0.fightViewPlayCard = var_0_0.operationClass.New()
	arg_1_0.waitingArea = nil

	local var_1_1 = FightModel.instance:getVersion()

	if var_1_1 and var_1_1 >= 1 then
		arg_1_0.waitingArea = var_0_0.playCardClass.New()
	else
		arg_1_0.waitingArea = FightViewWaitingArea.New()
	end

	arg_1_0.rightElementLayoutView = FightViewRightElementsLayout.New()
	arg_1_0.rightBottomElementLayoutView = FightViewRightBottomElementsLayout.New()

	local var_1_2 = {
		arg_1_0.rightElementLayoutView,
		arg_1_0.rightBottomElementLayoutView,
		arg_1_0.fightView,
		FightViewPartVisible.New(),
		arg_1_0.fightViewHandCard,
		arg_1_0.fightViewPlayCard,
		FightViewExPoint.New(),
		arg_1_0.waitingArea,
		FightViewClothSkillMgrView.New(),
		FightViewTips.New(),
		FightViewSkillFrame.New(),
		FightViewTechnique.New(),
		LuaListScrollView.New(FightViewTechniqueListModel.instance, var_1_0),
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

	table.insert(var_1_2, FightViewBossHpMgr.New())
	table.insert(var_1_2, FightViewMgr.New())
	table.insert(var_1_2, FightViewBuffId2Behaviour.New())

	return var_1_2
end

function var_0_0.openFightFocusView(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_2_0 and var_2_0.type == DungeonEnum.EpisodeType.Cachot then
		local var_2_1 = V1a6_CachotHeroGroupController.instance

		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = V1a6_CachotHeroGroupModel.instance:getCurGroupMO(),
			setEquipInfo = {
				var_2_1.getFightFocusEquipInfo,
				var_2_1
			}
		})

		return
	end

	if var_2_0 and var_2_0.type == DungeonEnum.EpisodeType.Rouge then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			group = RougeHeroGroupModel.instance:getCurGroupMO(),
			balanceHelper = RougeHeroGroupBalanceHelper
		})

		return
	end

	ViewMgr.instance:openView(ViewName.FightFocusView)
end

return var_0_0
