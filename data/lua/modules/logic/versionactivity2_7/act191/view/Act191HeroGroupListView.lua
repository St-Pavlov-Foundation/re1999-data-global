module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupListView", package.seeall)

local var_0_0 = class("Act191HeroGroupListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "herogroupcontain/mainTitle/TeamLvl/image_Level")
	arg_1_0.btnEnhance = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/mainTitle/btn_Enhance")
	arg_1_0.heroContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/heroContainer")
	arg_1_0.scrollFetter = gohelper.findChildScrollRect(arg_1_0.viewGO, "herogroupcontain/scroll_Fetter")
	arg_1_0.goFetterContent = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/scroll_Fetter/Viewport/go_FetterContent")
	arg_1_0.fetterItemList = {}

	arg_1_0:initHeroInfoItem()
	arg_1_0:initHeroAndEquipItem()

	arg_1_0.animSwitch = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain"):GetComponent(gohelper.Type_Animator)
	arg_1_0.goBoss = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/go_Boss")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.goBoss, "simage_Boss")
	arg_1_0.txtBossName = gohelper.findChildText(arg_1_0.goBoss, "name/txt_BossName")
	arg_1_0.imageBossCareer = gohelper.findChildImage(arg_1_0.goBoss, "attribute/image_BossCareer")
	arg_1_0.btnBoss = gohelper.findChildButtonWithAudio(arg_1_0.goBoss, "btn_Boss")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBoss, arg_2_0._btnBossOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnEnhance, arg_2_0._btnEnhanceOnClick, arg_2_0)
end

function var_0_0._btnBossOnClick(arg_3_0)
	Act191StatController.instance:statButtonClick(arg_3_0.viewName, "_btnBossOnClick")
	ViewMgr.instance:openView(ViewName.Act191AssistantView, arg_3_0.summonIdList)
end

function var_0_0._btnEnhanceOnClick(arg_4_0)
	Act191StatController.instance:statButtonClick(arg_4_0.viewName, "_btnEnhanceOnClick")
	ViewMgr.instance:openView(ViewName.Act191EnhanceView, {
		pos = Vector2(310, -80)
	})
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, arg_5_0.refreshTeam, arg_5_0)

	arg_5_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	arg_5_0:refreshTeam()

	local var_5_0 = #arg_5_0.gameInfo.warehouseInfo.enhanceId

	gohelper.setActive(arg_5_0.btnEnhance, var_5_0 ~= 0)
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroItemList) do
		CommonDragHelper.instance:unregisterDragObj(iter_6_1.go)
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.equipItemList) do
		CommonDragHelper.instance:unregisterDragObj(iter_6_3.go)
	end

	TaskDispatcher.cancelTask(arg_6_0.refreshTeam, arg_6_0)
end

function var_0_0.initHeroInfoItem(arg_7_0)
	arg_7_0.heroInfoItemList = {}

	for iter_7_0 = 1, 4 do
		local var_7_0 = arg_7_0:getUserDataTb_()
		local var_7_1 = gohelper.findChild(arg_7_0.heroContainer, "bg" .. iter_7_0)

		var_7_0.goIndex = gohelper.findChild(var_7_1, "Index")
		var_7_0.txtName = gohelper.findChildText(var_7_1, "Name")
		arg_7_0.heroInfoItemList[iter_7_0] = var_7_0
	end
end

function var_0_0.initHeroAndEquipItem(arg_8_0)
	arg_8_0.heroPosTrList = arg_8_0:getUserDataTb_()
	arg_8_0.equipPosTrList = arg_8_0:getUserDataTb_()

	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "herogroupcontain/recordPos")

	for iter_8_0 = 1, 8 do
		local var_8_1 = gohelper.findChild(var_8_0, "heroPos" .. iter_8_0)

		arg_8_0.heroPosTrList[iter_8_0] = var_8_1.transform

		if iter_8_0 <= 4 then
			local var_8_2 = gohelper.findChild(var_8_0, "equipPos" .. iter_8_0)

			arg_8_0.equipPosTrList[iter_8_0] = var_8_2.transform
		end
	end

	local var_8_3 = gohelper.findChild(arg_8_0.heroContainer, "go_HeroItem")
	local var_8_4 = gohelper.findChild(arg_8_0.heroContainer, "go_EquipItem")

	arg_8_0.heroItemList = {}
	arg_8_0.equipItemList = {}

	for iter_8_1 = 1, 8 do
		local var_8_5 = gohelper.cloneInPlace(var_8_3, "hero" .. iter_8_1)
		local var_8_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_5, Act191HeroGroupItem1)

		var_8_6:setIndex(iter_8_1)

		arg_8_0.heroItemList[iter_8_1] = var_8_6

		CommonDragHelper.instance:registerDragObj(var_8_5, arg_8_0._onBeginDrag, nil, arg_8_0._onEndDrag, arg_8_0._checkDrag, arg_8_0, iter_8_1)

		if iter_8_1 <= 4 then
			local var_8_7 = gohelper.cloneInPlace(var_8_4, "equip" .. iter_8_1)
			local var_8_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_7, Act191HeroGroupItem2)

			var_8_8:setIndex(iter_8_1)

			arg_8_0.equipItemList[iter_8_1] = var_8_8

			CommonDragHelper.instance:registerDragObj(var_8_7, arg_8_0._onBeginDrag1, nil, arg_8_0._onEndDrag1, arg_8_0._checkDrag1, arg_8_0, iter_8_1)
		end
	end

	gohelper.setActive(var_8_3, false)
	gohelper.setActive(var_8_4, false)
end

function var_0_0.refreshTeam(arg_9_0)
	local var_9_0 = arg_9_0.gameInfo.rank
	local var_9_1 = lua_activity191_rank.configDict[var_9_0].fightLevel

	UISpriteSetMgr.instance:setAct174Sprite(arg_9_0.imageLevel, "act191_level_" .. string.lower(var_9_1))

	for iter_9_0 = 1, 8 do
		arg_9_0:_setHeroItemPos(arg_9_0.heroItemList[iter_9_0], iter_9_0)

		if iter_9_0 <= 4 then
			arg_9_0:_setEquipItemPos(arg_9_0.equipItemList[iter_9_0], iter_9_0)
		end
	end

	local var_9_2 = arg_9_0.gameInfo:getTeamInfo()

	for iter_9_1 = 1, 4 do
		local var_9_3 = Activity191Helper.matchKeyInArray(var_9_2.battleHeroInfo, iter_9_1)
		local var_9_4
		local var_9_5

		if var_9_3 then
			var_9_4 = var_9_3.heroId
			var_9_5 = var_9_3.itemUid1
		end

		arg_9_0.heroItemList[iter_9_1]:setData(var_9_4)
		arg_9_0.equipItemList[iter_9_1]:setData(var_9_5)

		local var_9_6 = arg_9_0.heroInfoItemList[iter_9_1]

		if var_9_4 and var_9_4 ~= 0 then
			local var_9_7 = arg_9_0.gameInfo:getHeroInfoInWarehouse(var_9_4)
			local var_9_8 = Activity191Config.instance:getRoleCoByNativeId(var_9_4, var_9_7.star)

			var_9_6.txtName.text = var_9_8.name

			gohelper.setActive(var_9_6.goIndex, false)
			gohelper.setActive(var_9_6.txtName, true)
		else
			gohelper.setActive(var_9_6.goIndex, true)
			gohelper.setActive(var_9_6.txtName, false)
		end

		local var_9_9 = iter_9_1 + 4
		local var_9_10 = Activity191Helper.matchKeyInArray(var_9_2.subHeroInfo, iter_9_1)
		local var_9_11 = var_9_10 and var_9_10.heroId or 0

		arg_9_0.heroItemList[var_9_9]:setData(var_9_11)
	end

	arg_9_0:refreshFetter()

	arg_9_0.summonIdList = arg_9_0.gameInfo:getActiveSummonIdList()

	if next(arg_9_0.summonIdList) then
		local var_9_12 = lua_activity191_summon.configDict[arg_9_0.summonIdList[1]]

		arg_9_0.txtBossName.text = var_9_12.name

		UISpriteSetMgr.instance:setCommonSprite(arg_9_0.imageBossCareer, "lssx_" .. var_9_12.career)
		arg_9_0.simageBoss:LoadImage(ResUrl.monsterHeadIcon(var_9_12.headIcon))
		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31503)
	end

	gohelper.setActive(arg_9_0.goBoss, next(arg_9_0.summonIdList))
end

function var_0_0._checkDrag(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.heroItemList[arg_10_1]

	if not var_10_0.heroId or var_10_0.heroId == 0 then
		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.heroItemList[arg_11_1]

	if not var_11_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	var_11_0:setDrag(true)
end

function var_0_0._onEndDrag(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.heroItemList[arg_12_1]

	if not var_12_0 then
		return
	end

	var_12_0:setDrag(false)

	local var_12_1 = Activity191Helper.calcIndex(arg_12_2.position, arg_12_0.heroPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not var_12_1 or var_12_1 == arg_12_1 then
		arg_12_0:_setHeroItemPos(var_12_0, arg_12_1, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local var_12_2 = arg_12_0.heroItemList[var_12_1]

	gohelper.setAsLastSibling(var_12_2.go)

	arg_12_0._tweenId = arg_12_0:_setHeroItemPos(var_12_2, arg_12_1, true)

	arg_12_0:_setHeroItemPos(var_12_0, var_12_1, true, function()
		if arg_12_0._tweenId then
			ZProj.TweenHelper.KillById(arg_12_0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		arg_12_0.gameInfo:exchangeHero(arg_12_1, var_12_1)
	end, arg_12_0)
end

function var_0_0._setHeroItemPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_0.heroPosTrList[arg_15_2]
	local var_15_1 = recthelper.rectToRelativeAnchorPos(var_15_0.position, arg_15_0.heroContainer.transform)

	if arg_15_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_15_1.go.transform, var_15_1.x, var_15_1.y, 0.2, arg_15_4, arg_15_5)
	else
		recthelper.setAnchor(arg_15_1.go.transform, var_15_1.x, var_15_1.y)

		if arg_15_4 then
			arg_15_4(arg_15_5)
		end
	end
end

function var_0_0._checkDrag1(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.equipItemList[arg_16_1]

	if not var_16_0.itemUid or var_16_0.itemUid == 0 then
		return true
	end

	return false
end

function var_0_0._onBeginDrag1(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.equipItemList[arg_17_1]

	if not var_17_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	var_17_0:setDrag(true)
end

function var_0_0._onEndDrag1(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.equipItemList[arg_18_1]

	if not var_18_0 then
		return
	end

	var_18_0:setDrag(false)

	local var_18_1 = Activity191Helper.calcIndex(arg_18_2.position, arg_18_0.equipPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not var_18_1 or var_18_1 == arg_18_1 then
		arg_18_0:_setEquipItemPos(var_18_0, arg_18_1, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local var_18_2 = arg_18_0.equipItemList[var_18_1]

	gohelper.setAsLastSibling(var_18_2.go)

	arg_18_0._tweenId = arg_18_0:_setEquipItemPos(var_18_2, arg_18_1, true)

	arg_18_0:_setEquipItemPos(var_18_0, var_18_1, true, function()
		if arg_18_0._tweenId then
			ZProj.TweenHelper.KillById(arg_18_0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		arg_18_0.gameInfo:exchangeItem(arg_18_1, var_18_1)
	end, arg_18_0)
end

function var_0_0._setEquipItemPos(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = arg_21_0.equipPosTrList[arg_21_2]
	local var_21_1 = recthelper.rectToRelativeAnchorPos(var_21_0.position, arg_21_0.heroContainer.transform)

	if arg_21_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_21_1.go.transform, var_21_1.x, var_21_1.y, 0.2, arg_21_4, arg_21_5)
	else
		recthelper.setAnchor(arg_21_1.go.transform, var_21_1.x, var_21_1.y)

		if arg_21_4 then
			arg_21_4(arg_21_5)
		end
	end
end

function var_0_0.refreshFetter(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.fetterItemList) do
		gohelper.setActive(iter_22_1.go, false)
	end

	local var_22_0 = arg_22_0.gameInfo:getTeamFetterCntDic()
	local var_22_1 = Activity191Helper.getActiveFetterInfoList(var_22_0)

	for iter_22_2, iter_22_3 in ipairs(var_22_1) do
		local var_22_2 = arg_22_0.fetterItemList[iter_22_2]

		if not var_22_2 then
			local var_22_3 = arg_22_0:getResInst(Activity191Enum.PrefabPath.FetterItem, arg_22_0.goFetterContent)

			var_22_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_3, Act191FetterItem)
			arg_22_0.fetterItemList[iter_22_2] = var_22_2
		end

		var_22_2:setData(iter_22_3.config, iter_22_3.count)
		var_22_2:setExtraParam({
			fromView = arg_22_0.viewName,
			index = iter_22_2
		})
		gohelper.setActive(var_22_2.go, true)
	end

	arg_22_0.scrollFetter.horizontalNormalizedPosition = 0
end

return var_0_0
