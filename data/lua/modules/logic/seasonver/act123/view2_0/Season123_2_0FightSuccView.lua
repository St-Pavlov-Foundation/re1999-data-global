module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightSuccView", package.seeall)

local var_0_0 = class("Season123_2_0FightSuccView", FightSuccView)

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
	arg_1_0._txtSayCn = gohelper.findChildText(arg_1_0.viewGO, "txtSayCn")
	arg_1_0._txtSayEn = gohelper.findChildText(arg_1_0.viewGO, "SayEn/txtSayEn")

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
	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0._onClickClose, arg_6_0)
end

function var_0_0._dealGetCard(arg_7_0)
	local var_7_0 = {}

	tabletool.addValues(var_7_0, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(var_7_0, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(var_7_0, FightResultModel.instance:getMaterialDataList())

	local var_7_1 = {}

	for iter_7_0 = #var_7_0, 1, -1 do
		if var_7_0[iter_7_0].materilType == MaterialEnum.MaterialType.Season123EquipCard then
			local var_7_2 = table.remove(var_7_0, iter_7_0)

			table.insert(var_7_1, var_7_2.materilId)
		end
	end

	arg_7_0._showEquipCard = {}
	arg_7_0._newCardDic = {}

	for iter_7_1, iter_7_2 in ipairs(var_7_1) do
		if Season123Model.instance:isNewEquipBookCard(iter_7_2) then
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
	else
		arg_7_0:_showRewardPart()
	end
end

function var_0_0._loadBonusItems(arg_8_0)
	return
end

function var_0_0._showGetCardView(arg_9_0)
	Season123Controller.instance:openSeasonCelebrityCardGetView({
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
	if arg_12_1 == ViewName.Season123_2_0CelebrityCardGetView then
		arg_12_0:_onTipsClose()
	end
end

function var_0_0._addItem(arg_13_0, arg_13_1)
	local var_13_0 = gohelper.clone(arg_13_0._bonusItemGo, arg_13_0._bonusItemContainer, arg_13_1.id)
	local var_13_1 = gohelper.findChild(var_13_0, "container/tag")
	local var_13_2 = gohelper.findChild(var_13_0, "container/tag/imgFirst")
	local var_13_3 = gohelper.findChild(var_13_0, "container/tag/imgFirstHard")
	local var_13_4 = gohelper.findChild(var_13_0, "container/tag/imgNormal")
	local var_13_5 = gohelper.findChild(var_13_0, "container/tag/imgAdvance")
	local var_13_6 = gohelper.findChild(var_13_0, "container/tag/imgEquipDaily")
	local var_13_7 = gohelper.findChild(var_13_0, "container")

	gohelper.setActive(var_13_7, false)
	gohelper.setActive(var_13_1, arg_13_1.bonusTag)

	if arg_13_1.bonusTag then
		gohelper.setActive(var_13_2, arg_13_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and not arg_13_0._hardMode)
		gohelper.setActive(var_13_3, arg_13_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_13_0._hardMode)
		gohelper.setActive(var_13_4, false)
		gohelper.setActive(var_13_5, arg_13_1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(var_13_6, arg_13_1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
	end

	arg_13_1.isIcon = true

	if arg_13_1.materilType == MaterialEnum.MaterialType.Season123EquipCard then
		local var_13_8 = arg_13_0._newCardDic[arg_13_1.materilId]

		if not arg_13_0._equipCards then
			arg_13_0._equipCards = {}
		end

		local var_13_9 = Season123_2_0CelebrityCardItem.New()

		var_13_9:init(gohelper.findChild(var_13_0, "container/cardicon"), arg_13_1.materilId)
		var_13_9:showNewFlag(var_13_8)
		table.insert(arg_13_0._equipCards, var_13_9)

		for iter_13_0 = 1, 5 do
			local var_13_10 = gohelper.findChild(var_13_0, "container/cardicon/#vx_glow/" .. iter_13_0)
			local var_13_11 = Season123Config.instance:getSeasonEquipCo(arg_13_1.materilId)

			gohelper.setActive(var_13_10, iter_13_0 == var_13_11.rare)
		end
	else
		local var_13_12 = gohelper.findChild(var_13_0, "container/itemIcon")
		local var_13_13 = IconMgr.instance:getCommonPropItemIcon(var_13_12)

		var_13_13:onUpdateMO(arg_13_1)
		var_13_13:setCantJump(true)
		var_13_13:setCountFontSize(40)
		var_13_13:setAutoPlay(true)
		var_13_13:isShowEquipRefineLv(true)
	end

	gohelper.setActive(var_13_0, false)

	var_13_1:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	arg_13_0:applyBonusVfx(arg_13_1, var_13_0)

	return var_13_7, var_13_0
end

function var_0_0._setFbName(arg_14_0, arg_14_1)
	arg_14_0._txtFbName.text = arg_14_1.name
	arg_14_0._txtFbNameEn.text = arg_14_1.name_En
end

function var_0_0._showGoal(arg_15_0)
	gohelper.setActive(arg_15_0._goallist, false)
end

function var_0_0._checkTypeDetails(arg_16_0)
	return
end

function var_0_0._hideGoDemand(arg_17_0)
	return
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showGetCardView, arg_18_0)

	if arg_18_0._equipCards then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._equipCards) do
			iter_18_1:destroy()
		end

		arg_18_0._equipCards = nil
	end

	var_0_0.super.onClose(arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	var_0_0.super.onDestroyView(arg_19_0)
end

return var_0_0
