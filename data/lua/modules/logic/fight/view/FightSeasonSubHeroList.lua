module("modules.logic.fight.view.FightSeasonSubHeroList", package.seeall)

local var_0_0 = class("FightSeasonSubHeroList", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scoreText = gohelper.findChildText(arg_1_0.viewGO, "Score/#txt_num")
	arg_1_0._scoreText1 = gohelper.findChildText(arg_1_0.viewGO, "Score/#txt_num1")
	arg_1_0._ani = SLFramework.AnimatorPlayer.Get(gohelper.findChild(arg_1_0.viewGO, "Score"))
	arg_1_0._goScore = gohelper.findChild(arg_1_0.viewGO, "Score")
	arg_1_0._scoreImg = gohelper.findChildImage(arg_1_0.viewGO, "Score/#image_ScoreBG")
	arg_1_0._itemRoot = gohelper.findChild(arg_1_0.viewGO, "List")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "List/#go_Item")
	arg_1_0._itemClassList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.ChangeWaveEnd, arg_2_0._onChangeWaveEnd)
	arg_2_0:com_registFightEvent(FightEvent.OnIndicatorChange, arg_2_0._onIndicatorChange)
	arg_2_0:com_registFightEvent(FightEvent.StageChanged, arg_2_0._onStageChanged)
	arg_2_0:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView)
	arg_2_0:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onCloseView)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onStageChanged(arg_4_0, arg_4_1, arg_4_2)
	gohelper.setActive(arg_4_0._itemRoot, arg_4_1 ~= FightStageMgr.StageType.Play)
end

function var_0_0._enterOperate(arg_5_0)
	arg_5_0.PARENT_VIEW:_enterOperate()
end

function var_0_0._exitOperate(arg_6_0, arg_6_1)
	if arg_6_0._selectItem then
		arg_6_0._selectItem:playAni("select_out", true)

		arg_6_0._selectItem = nil
	end

	if not arg_6_1 then
		arg_6_0:_refreshSubSpine()
	end
end

function var_0_0.sortScoreConfig(arg_7_0, arg_7_1)
	return arg_7_0.level < arg_7_1.level
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = Season166Model.instance:getCurSeasonId()
	local var_8_1 = lua_activity166_score.configDict[var_8_0]

	arg_8_0._scoreConfigList = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		table.insert(arg_8_0._scoreConfigList, iter_8_1)
	end

	table.sort(arg_8_0._scoreConfigList, var_0_0.sortScoreConfig)

	arg_8_0._index2ImageName = {
		"season_scorebg_01",
		"season_scorebg_02",
		"season_scorebg_03",
		"season_scorebg_04"
	}
	arg_8_0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	arg_8_0:_refreshHeroList()

	arg_8_0._score = FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.NewSeasonScore)

	arg_8_0:_refreshScore()
end

function var_0_0._refreshHeroList(arg_9_0)
	local var_9_0 = FightDataHelper.entityMgr:getMySubList()

	table.sort(var_9_0, FightEntityDataHelper.sortSubEntityList)
	gohelper.CreateObjList(arg_9_0, arg_9_0._onItemShow, var_9_0, arg_9_0._itemRoot, arg_9_0._goItem)
end

function var_0_0._onItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0._itemClassList[arg_10_3]

	if not var_10_0 then
		var_10_0 = arg_10_0:com_openSubView(FightSeasonSubHeroItem, arg_10_1)
		arg_10_0._itemClassList[arg_10_3] = var_10_0
	end

	var_10_0:refreshData(arg_10_2.id)
	var_10_0:playAni("normal_in", true)
end

function var_0_0.selectItem(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._itemClassList) do
		if iter_11_1.viewGO.activeInHierarchy and arg_11_0:selecting(iter_11_1) then
			iter_11_1:playAni("select_out", true)
		end
	end

	arg_11_1:playAni("select_in", true)

	arg_11_0._selectItem = arg_11_1

	arg_11_0.PARENT_VIEW:selectItem(arg_11_1)
	arg_11_0:_refreshSubSpine(arg_11_1._entityId)
end

function var_0_0._refreshSubSpine(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1

	if not var_12_0 then
		local var_12_1 = FightDataHelper.entityMgr:getMySubList()

		table.sort(var_12_1, FightEntityDataHelper.sortSubEntityList)

		local var_12_2 = var_12_1[1]

		var_12_0 = var_12_2 and var_12_2.id
	end

	if var_12_0 then
		local var_12_3 = FightDataHelper.entityMgr:getById(var_12_0)

		if var_12_3 then
			local var_12_4 = FightHelper.getSubEntity(FightEnum.EntitySide.MySide)

			if var_12_4 then
				if var_12_4.id ~= var_12_0 then
					arg_12_0.entityMgr:removeUnit(var_12_4:getTag(), var_12_4.id)
					arg_12_0.entityMgr:buildSubSpine(var_12_3)
				end
			else
				arg_12_0.entityMgr:buildSubSpine(var_12_3)
			end
		end
	end
end

function var_0_0.selecting(arg_13_0, arg_13_1)
	return arg_13_0._selectItem == arg_13_1
end

function var_0_0._onIndicatorChange(arg_14_0, arg_14_1)
	if arg_14_1 == FightEnum.IndicatorId.NewSeasonScoreOffset then
		arg_14_0._score = arg_14_0._score + FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.NewSeasonScoreOffset)

		arg_14_0:_refreshScore()
		arg_14_0._ani:Play("up", nil, nil)
	end
end

function var_0_0._refreshScore(arg_15_0)
	gohelper.setActive(arg_15_0._goScore, Season166Model.instance:checkIsBaseSpotEpisode())

	arg_15_0._scoreText.text = arg_15_0._score
	arg_15_0._scoreText1.text = arg_15_0._score

	local var_15_0 = 1

	for iter_15_0 = #arg_15_0._scoreConfigList, 1, -1 do
		if arg_15_0._score >= arg_15_0._scoreConfigList[iter_15_0].needScore then
			var_15_0 = iter_15_0

			break
		end
	end

	if var_15_0 == arg_15_0._lastIndex then
		return
	end

	arg_15_0._lastIndex = var_15_0

	UISpriteSetMgr.instance:setFightSprite(arg_15_0._scoreImg, arg_15_0._index2ImageName[var_15_0])
end

function var_0_0.onOpenView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_16_0._goScore, false)
	end
end

function var_0_0.onCloseView(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_17_0._goScore, Season166Model.instance:checkIsBaseSpotEpisode())
	end
end

function var_0_0._onChangeWaveEnd(arg_18_0)
	arg_18_0:onOpen()
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
