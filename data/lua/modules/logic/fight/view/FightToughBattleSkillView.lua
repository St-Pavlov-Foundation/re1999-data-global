module("modules.logic.fight.view.FightToughBattleSkillView", package.seeall)

local var_0_0 = class("FightToughBattleSkillView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._item = gohelper.findChild(arg_1_0.viewGO, "#scroll_List/Viewport/Content/#go_Items")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_2_0._onRoundSequenceStart, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, arg_2_0._onRoundSequenceStart, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onRoundSequenceStart(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.CharSupport)
end

function var_0_0._onRoundSequenceFinish(arg_5_0)
	gohelper.setActive(arg_5_0.viewGO, true)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.CharSupport, arg_5_0.height)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = FightModel.instance:getFightParam()
	local var_6_1 = var_6_0.chapterId
	local var_6_2 = DungeonConfig.instance:getChapterCO(var_6_1)

	if not var_6_2 or var_6_2.type ~= DungeonEnum.ChapterType.ToughBattle then
		return
	end

	local var_6_3 = var_6_0.episodeId

	if not var_6_3 then
		return
	end

	arg_6_0._isAct = ToughBattleConfig.instance:isActEpisodeId(var_6_3)

	arg_6_0:refreshView()
end

function var_0_0.refreshView(arg_7_0)
	local var_7_0 = arg_7_0:getInfo()

	if not var_7_0 then
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.CharSupport)

		return
	end

	local var_7_1 = var_7_0.passChallengeIds
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = FightModel.instance.last_fightGroup

	if var_7_4 then
		for iter_7_0, iter_7_1 in ipairs(var_7_4.trialHeroList) do
			var_7_3[iter_7_1.trialId] = true
		end
	end

	if arg_7_0._isAct then
		for iter_7_2, iter_7_3 in ipairs(var_7_1) do
			local var_7_5 = lua_activity158_challenge.configDict[iter_7_3]

			if var_7_5 then
				arg_7_0:addHeroId(var_7_2, var_7_5.heroId, var_7_3)
			end
		end
	else
		for iter_7_4, iter_7_5 in ipairs(var_7_1) do
			local var_7_6 = lua_siege_battle.configDict[iter_7_5]

			if var_7_6 then
				arg_7_0:addHeroId(var_7_2, var_7_6.heroId, var_7_3)
			end
		end
	end

	local var_7_7 = FightRightElementEnum.ElementsSizeDict[FightRightElementEnum.Elements.CharSupport]

	arg_7_0.height = #var_7_2 * var_7_7.y

	gohelper.CreateObjList(arg_7_0, arg_7_0.createItem, var_7_2, arg_7_0._item.transform.parent.gameObject, arg_7_0._item, FightToughBattleSkillItem)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.CharSupport, arg_7_0.height)
end

function var_0_0.addHeroId(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = lua_siege_battle_hero.configDict[arg_8_2]

	if not var_8_0 then
		return
	end

	if var_8_0.type == ToughBattleEnum.HeroType.Hero and not arg_8_3[tonumber(var_8_0.param)] then
		return
	end

	table.insert(arg_8_1, var_8_0)
end

function var_0_0.createItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1:setCo(arg_9_2)
end

function var_0_0.getInfo(arg_10_0)
	if arg_10_0._isAct then
		local var_10_0 = ToughBattleModel.instance:getActInfo()

		if var_10_0 then
			return var_10_0
		end

		Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, arg_10_0.onRecvMsg, arg_10_0)
	else
		local var_10_1 = ToughBattleModel.instance:getStoryInfo()

		if var_10_1 then
			return var_10_1
		end

		SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(arg_10_0.onRecvMsg, arg_10_0)
	end
end

function var_0_0.onRecvMsg(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 ~= 0 then
		return
	end

	arg_11_0:refreshView()
end

return var_0_0
