module("modules.logic.season.view1_2.Season1_2FightSuccView", package.seeall)

local var_0_0 = class("Season1_2FightSuccView", FightSuccView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnData = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnData")
	arg_1_0._simagecharacterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_characterbg")
	arg_1_0._simagemaskImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskImage")
	arg_1_0._godetails = gohelper.findChild(arg_1_0.viewGO, "#go_details")
	arg_1_0._gocoverrecordpart = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part")
	arg_1_0._btncoverrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cover_record_part/#btn_cover_record")
	arg_1_0._txtcurroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	arg_1_0._txtmaxroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	arg_1_0._goCoverLessThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	arg_1_0._goCoverMuchThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	arg_1_0._goCoverEqual = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	arg_1_0._bonusItemGo = gohelper.findChild(arg_1_0.viewGO, "scroll/item")
	arg_1_0._favorIcon = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/content/favor")
	arg_1_0._txtFbName = gohelper.findChildText(arg_1_0.viewGO, "txtFbName")
	arg_1_0._txtFbNameEn = gohelper.findChildText(arg_1_0.viewGO, "txtFbNameen")
	arg_1_0._goallist = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist")
	arg_1_0._txtLv = gohelper.findChildText(arg_1_0.viewGO, "goalcontent/txtLv")
	arg_1_0._sliderExp = gohelper.findChildSlider(arg_1_0.viewGO, "goalcontent/txtLv/progress")
	arg_1_0._txtExp = gohelper.findChildText(arg_1_0.viewGO, "goalcontent/txtLv/txtExp")
	arg_1_0._txtAddExp = gohelper.findChildText(arg_1_0.viewGO, "goalcontent/txtLv/progress/txtAddExp")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "spineContainer/spine")
	arg_1_0._uiSpine = GuiModelAgent.Create(arg_1_0._gospine, true)
	arg_1_0._goCondition = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/fightgoal")
	arg_1_0._goPlatCondition = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinum")
	arg_1_0._goPlatCondition2 = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinum2")
	arg_1_0._bonusItemContainer = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/content")
	arg_1_0._bonusItemGo = gohelper.findChild(arg_1_0.viewGO, "scroll/item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._onClickData, arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btncoverrecord:AddClickListener(arg_2_0._onBtnCoverRecordClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, arg_2_0._onCoverDungeonRecordReply, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnData:RemoveClickListener()
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btncoverrecord:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClick(arg_4_0.viewGO)
end

function var_0_0._onClickClose(arg_5_0)
	if arg_5_0._showEquipCard then
		return
	end

	var_0_0.super._onClickClose(arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)
	gohelper.setActive(arg_6_0._bonusItemContainer, false)
	arg_6_0:_dealGetCard()
	arg_6_0:_showGoal()
end

function var_0_0._dealGetCard(arg_7_0)
	local var_7_0 = {}

	tabletool.addValues(var_7_0, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(var_7_0, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(var_7_0, FightResultModel.instance:getMaterialDataList())

	local var_7_1 = {}

	for iter_7_0 = #var_7_0, 1, -1 do
		if var_7_0[iter_7_0].materilType == MaterialEnum.MaterialType.EquipCard then
			local var_7_2 = table.remove(var_7_0, iter_7_0)

			table.insert(var_7_1, var_7_2.materilId)
		end
	end

	arg_7_0._showEquipCard = {}
	arg_7_0._choiceCards = {}
	arg_7_0._newCardDic = {}

	for iter_7_1, iter_7_2 in ipairs(var_7_1) do
		if SeasonConfig.instance:getEquipIsOptional(iter_7_2) then
			table.insert(arg_7_0._choiceCards, iter_7_2)
		elseif Activity104Model.instance:isNew104Equip(iter_7_2) then
			table.insert(arg_7_0._showEquipCard, iter_7_2)

			arg_7_0._newCardDic[iter_7_2] = true
		end
	end

	if #arg_7_0._showEquipCard > 0 then
		local var_7_3 = {}

		for iter_7_3 = #arg_7_0._showEquipCard, 1, -1 do
			local var_7_4 = arg_7_0._showEquipCard[iter_7_3]

			if var_7_3[var_7_4] then
				table.remove(arg_7_0._showEquipCard, iter_7_3)
			else
				var_7_3[var_7_4] = true
			end
		end

		TaskDispatcher.runDelay(arg_7_0._showGetCardView, arg_7_0, 2)
	elseif #arg_7_0._choiceCards > 0 then
		TaskDispatcher.runDelay(arg_7_0._showChoiceCardView, arg_7_0, 2)
	else
		arg_7_0:_showRewardPart()
	end
end

function var_0_0._loadBonusItems(arg_8_0)
	return
end

function var_0_0._showGetCardView(arg_9_0)
	Activity104Controller.instance:openSeasonCelebrityCardGetlView({
		is_item_id = true,
		data = arg_9_0._showEquipCard
	})
end

function var_0_0._onTipsClose(arg_10_0)
	arg_10_0:_showRewardPart()
	arg_10_0:_showPlayerLevelUpView()
end

function var_0_0._showRewardPart(arg_11_0)
	arg_11_0._showEquipCard = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_11_0._onCloseViewFinish, arg_11_0)
	gohelper.setActive(arg_11_0._bonusItemContainer, true)
	var_0_0.super._loadBonusItems(arg_11_0)
end

function var_0_0._onCloseViewFinish(arg_12_0, arg_12_1)
	if arg_12_1 == SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView) then
		if arg_12_0:_showChoiceCardView() then
			return
		end

		arg_12_0:_onTipsClose()
	end
end

function var_0_0._showChoiceCardView(arg_13_0)
	if arg_13_0._choiceCards and #arg_13_0._choiceCards > 0 then
		local var_13_0 = table.remove(arg_13_0._choiceCards, 1)
		local var_13_1 = Activity104Model.instance:getItemEquipUid(var_13_0)

		if var_13_1 then
			local var_13_2 = {
				actId = Activity104Model.instance:getCurSeasonId(),
				costItemUid = var_13_1
			}

			Activity104Controller.instance:openSeasonEquipSelectChoiceView(var_13_2)

			return true
		end
	end
end

function var_0_0._addItem(arg_14_0, arg_14_1)
	local var_14_0 = gohelper.clone(arg_14_0._bonusItemGo, arg_14_0._bonusItemContainer, arg_14_1.id)
	local var_14_1 = gohelper.findChild(var_14_0, "container/tag")
	local var_14_2 = gohelper.findChild(var_14_0, "container/tag/imgFirst")
	local var_14_3 = gohelper.findChild(var_14_0, "container/tag/imgFirstHard")
	local var_14_4 = gohelper.findChild(var_14_0, "container/tag/imgNormal")
	local var_14_5 = gohelper.findChild(var_14_0, "container/tag/imgAdvance")
	local var_14_6 = gohelper.findChild(var_14_0, "container/tag/imgEquipDaily")
	local var_14_7 = gohelper.findChild(var_14_0, "container")

	gohelper.setActive(var_14_7, false)
	gohelper.setActive(var_14_1, arg_14_1.bonusTag)

	if arg_14_1.bonusTag then
		gohelper.setActive(var_14_2, arg_14_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and not arg_14_0._hardMode)
		gohelper.setActive(var_14_3, arg_14_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_14_0._hardMode)
		gohelper.setActive(var_14_4, false)
		gohelper.setActive(var_14_5, arg_14_1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(var_14_6, arg_14_1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
	end

	arg_14_1.isIcon = true

	if arg_14_1.materilType == MaterialEnum.MaterialType.EquipCard then
		local var_14_8 = arg_14_0._newCardDic[arg_14_1.materilId]

		if not arg_14_0._equipCards then
			arg_14_0._equipCards = {}
		end

		local var_14_9 = Season1_2CelebrityCardItem.New()

		var_14_9:init(gohelper.findChild(var_14_0, "container/cardicon"), arg_14_1.materilId)
		var_14_9:showNewFlag(var_14_8)
		table.insert(arg_14_0._equipCards, var_14_9)

		for iter_14_0 = 1, 5 do
			local var_14_10 = gohelper.findChild(var_14_0, "container/cardicon/#vx_glow/" .. iter_14_0)
			local var_14_11 = SeasonConfig.instance:getSeasonEquipCo(arg_14_1.materilId)

			gohelper.setActive(var_14_10, iter_14_0 == var_14_11.rare)
		end
	else
		local var_14_12 = gohelper.findChild(var_14_0, "container/itemIcon")
		local var_14_13 = IconMgr.instance:getCommonPropItemIcon(var_14_12)

		var_14_13:onUpdateMO(arg_14_1)
		var_14_13:setCantJump(true)
		var_14_13:setCountFontSize(40)
		var_14_13:setAutoPlay(true)
		var_14_13:isShowEquipRefineLv(true)
	end

	gohelper.setActive(var_14_0, false)

	var_14_1:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	arg_14_0:applyBonusVfx(arg_14_1, var_14_0)

	return var_14_7, var_14_0
end

function var_0_0._setFbName(arg_15_0, arg_15_1)
	if arg_15_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		local var_15_0 = math.min(Activity104Model.instance:getAct104CurStage(), 6)
		local var_15_1 = Activity104Model.instance.curBattleRetail
		local var_15_2 = Activity104Model.instance:getCurSeasonId()
		local var_15_3 = SeasonConfig.instance:getSeasonTagDesc(var_15_2, var_15_1.tag)

		arg_15_0._txtFbName.text = string.format("%s %s", var_15_3 and var_15_3.name, GameUtil.getRomanNums(var_15_0))
	else
		arg_15_0._txtFbName.text = arg_15_1.name
	end
end

function var_0_0._showGoal(arg_16_0)
	gohelper.setActive(arg_16_0._goallist, false)

	local var_16_0 = lua_episode.configDict[arg_16_0._curEpisodeId]

	if var_16_0 and var_16_0.type == DungeonEnum.EpisodeType.SeasonRetail then
		local var_16_1 = Activity104Model.instance.curBattleRetail
		local var_16_2 = var_16_1.advancedId
		local var_16_3 = lua_condition.configDict[var_16_2]

		if var_16_3 then
			gohelper.setActive(arg_16_0._goallist, true)
			gohelper.setActive(gohelper.findChild(arg_16_0._goallist, "fightgoal"), true)

			gohelper.findChildText(arg_16_0._goallist, "fightgoal/condition").text = var_16_3.desc

			local var_16_4 = "#87898C"

			if var_16_1.star >= 2 then
				if var_16_1.advancedRare == 1 then
					var_16_4 = "#A3F14C"
				elseif var_16_1.advancedRare == 2 then
					var_16_4 = "#FF423F"
				end
			end

			local var_16_5 = gohelper.findChildImage(arg_16_0._goallist, "fightgoal/star")

			SLFramework.UGUI.GuiHelper.SetColor(var_16_5, var_16_4)
		end
	end
end

function var_0_0._checkTypeDetails(arg_17_0)
	return
end

function var_0_0._hideGoDemand(arg_18_0)
	return
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._showGetCardView, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._showChoiceCardView, arg_19_0)

	if arg_19_0._equipCards then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._equipCards) do
			iter_19_1:destroy()
		end

		arg_19_0._equipCards = nil
	end

	var_0_0.super.onClose(arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	var_0_0.super.onDestroyView(arg_20_0)
end

return var_0_0
