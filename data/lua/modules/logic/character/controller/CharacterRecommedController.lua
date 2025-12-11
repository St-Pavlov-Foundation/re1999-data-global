module("modules.logic.character.controller.CharacterRecommedController", package.seeall)

local var_0_0 = class("CharacterRecommedController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, arg_3_0._respBeginFight, arg_3_0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_3_0._onCurrencyChange, arg_3_0)
	MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, arg_3_0._onFirstEnterMain, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0._onFirstEnterMain(arg_5_0)
	CharacterRecommedModel.instance:initTracedHeroDevelopGoalsMO()

	if not arg_5_0._tradeIcon then
		arg_5_0:loadTrade()
	end
end

function var_0_0._respBeginFight(arg_6_0)
	local var_6_0 = JumpModel.instance:getRecordFarmItem()

	if var_6_0 and not var_6_0.isFormHeroTraced then
		return
	end

	local var_6_1 = FightResultModel.instance:getEpisodeId()
	local var_6_2 = CharacterRecommedModel.instance:getEpisodeOrChapterTracedItem(var_6_1)

	if var_6_2 then
		local var_6_3 = {
			type = var_6_2.materilType,
			id = var_6_2.materilId,
			quantity = var_6_2.quantity,
			sceneType = SceneType.Main,
			openedViewNameList = var_0_0.instance:getRecommedViewDict()
		}

		var_6_3.isFormHeroTraced = true

		JumpModel.instance:setRecordFarmItem(var_6_3)
	end
end

function var_0_0._onCurrencyChange(arg_7_0)
	var_0_0.instance:dispatchEvent(CharacterRecommedEvent.OnRefreshTraced)
end

function var_0_0.openRecommedView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = CharacterRecommedModel.instance:getHeroRecommendMo(arg_8_1)
	local var_8_1 = (var_8_0:isShowTeam() or var_8_0:isShowEquip()) and CharacterRecommedEnum.TabSubType.RecommedGroup or CharacterRecommedEnum.TabSubType.DevelopGoals
	local var_8_2 = {
		heroId = arg_8_1,
		fromView = arg_8_2,
		defaultTabId = var_8_1,
		uiSpine = arg_8_3
	}

	ViewMgr.instance:openView(ViewName.CharacterRecommedView, var_8_2)
	CharacterRecommedHeroListModel.instance:setMoList(arg_8_1)
end

function var_0_0.jump(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_1:getTracedItems()

	if not var_9_0 or #var_9_0 == 0 then
		arg_9_0:jumpLevelUp(arg_9_1)

		return
	end

	arg_9_0:jumpDungeonView()
end

function var_0_0.jumpLevelUp(arg_10_0, arg_10_1)
	if arg_10_1:getDevelopGoalsType() == CharacterRecommedEnum.DevelopGoalsType.RankLevel then
		local var_10_0, var_10_1 = arg_10_1:isCurRankMaxLv()

		if not var_10_1 or not var_10_1:isOwnHero() then
			return
		end

		if var_10_0 then
			var_0_0.instance:dispatchEvent(CharacterRecommedEvent.OnJumpView, CharacterRecommedEnum.JumpView.Rank)
			CharacterController.instance:openCharacterRankUpView(var_10_1)
		else
			CharacterController.instance:openCharacterView(var_10_1)
			CharacterController.instance:openCharacterLevelUpView(var_10_1)
			var_0_0.instance:dispatchEvent(CharacterRecommedEvent.OnJumpView, CharacterRecommedEnum.JumpView.Level)
		end
	else
		local var_10_2, var_10_3 = arg_10_1:isMaxTalentLv()

		if not var_10_3 or not var_10_3:isOwnHero() then
			return
		end

		if not var_10_2 and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			if var_10_3.rank >= CharacterEnum.TalentRank then
				CharacterController.instance:openCharacterTalentView({
					isBack = true,
					heroid = var_10_3.heroId,
					heroMo = var_10_3
				})
			elseif var_10_3.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, var_10_3.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, var_10_3.config.name)
			end
		end
	end
end

function var_0_0.jumpDungeonView(arg_11_0)
	arg_11_0._recommedViewDict = JumpController.instance:getCurrentOpenedView()

	DungeonController.instance:enterDungeonView(true)
	var_0_0.instance:dispatchEvent(CharacterRecommedEvent.OnJumpView, CharacterRecommedEnum.JumpView.Dungeon)
end

function var_0_0.onJumpReturnRecommedView(arg_12_0)
	if not arg_12_0._recommedViewDict then
		arg_12_0._recommedViewDict = {}

		local var_12_0 = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

		if var_12_0 then
			local var_12_1 = {
				viewName = ViewName.CharacterRecommedView,
				viewParam = {
					defaultTabId = CharacterRecommedEnum.TabSubType.DevelopGoals,
					heroId = var_12_0._heroId
				}
			}

			table.insert(arg_12_0._recommedViewDict, var_12_1)
		end
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._recommedViewDict) do
		if iter_12_1.viewName == ViewName.CharacterRecommedView then
			ViewMgr.instance:openView(iter_12_1.viewName, iter_12_1.viewParam)
		end
	end
end

function var_0_0.getRecommedViewDict(arg_13_0)
	return arg_13_0._recommedViewDict
end

function var_0_0.loadTrade(arg_14_0)
	if arg_14_0._loader then
		arg_14_0._loader:dispose()
	end

	arg_14_0._loader = MultiAbLoader.New()

	arg_14_0._loader:addPath(CharacterRecommedEnum.TracedIconPath)
	arg_14_0._loader:startLoad(arg_14_0._onLoadFinish, arg_14_0)
end

function var_0_0._onLoadFinish(arg_15_0)
	arg_15_0._tradeIcon = arg_15_0._loader:getFirstAssetItem():GetResource()

	var_0_0.instance:dispatchEvent(CharacterRecommedEvent.OnLoadFinishTracedIcon)
end

function var_0_0.getTradeIcon(arg_16_0)
	if not arg_16_0._tradeIcon then
		arg_16_0:loadTrade()
	end

	return arg_16_0._tradeIcon
end

function var_0_0.replaceHeroGroup(arg_17_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
