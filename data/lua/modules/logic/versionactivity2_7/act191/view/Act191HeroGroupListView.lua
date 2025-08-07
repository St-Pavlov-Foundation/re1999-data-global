module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupListView", package.seeall)

local var_0_0 = class("Act191HeroGroupListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "herogroupcontain/mainTitle/TeamLvl/image_Level")
	arg_1_0.heroContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/heroContainer")
	arg_1_0.scrollFetter = gohelper.findChildScrollRect(arg_1_0.viewGO, "herogroupcontain/scroll_Fetter")
	arg_1_0.goFetterContent = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/scroll_Fetter/Viewport/go_FetterContent")
	arg_1_0.fetterItemList = {}

	arg_1_0:initHeroInfoItem()
	arg_1_0:initHeroAndEquipItem()

	arg_1_0.animSwitch = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain"):GetComponent(gohelper.Type_Animator)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, arg_4_0.refreshTeam, arg_4_0)

	arg_4_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	arg_4_0:refreshTeam()
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.heroItemList) do
		CommonDragHelper.instance:unregisterDragObj(iter_5_1.go)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.equipItemList) do
		CommonDragHelper.instance:unregisterDragObj(iter_5_3.go)
	end

	TaskDispatcher.cancelTask(arg_5_0.refreshTeam, arg_5_0)
end

function var_0_0.initHeroInfoItem(arg_6_0)
	arg_6_0.heroInfoItemList = {}

	for iter_6_0 = 1, 4 do
		local var_6_0 = arg_6_0:getUserDataTb_()
		local var_6_1 = gohelper.findChild(arg_6_0.heroContainer, "bg" .. iter_6_0)

		var_6_0.goIndex = gohelper.findChild(var_6_1, "Index")
		var_6_0.txtName = gohelper.findChildText(var_6_1, "Name")
		arg_6_0.heroInfoItemList[iter_6_0] = var_6_0
	end
end

function var_0_0.initHeroAndEquipItem(arg_7_0)
	arg_7_0.heroPosTrList = arg_7_0:getUserDataTb_()
	arg_7_0.equipPosTrList = arg_7_0:getUserDataTb_()

	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "herogroupcontain/recordPos")

	for iter_7_0 = 1, 8 do
		local var_7_1 = gohelper.findChild(var_7_0, "heroPos" .. iter_7_0)

		arg_7_0.heroPosTrList[iter_7_0] = var_7_1.transform

		if iter_7_0 <= 4 then
			local var_7_2 = gohelper.findChild(var_7_0, "equipPos" .. iter_7_0)

			arg_7_0.equipPosTrList[iter_7_0] = var_7_2.transform
		end
	end

	local var_7_3 = gohelper.findChild(arg_7_0.heroContainer, "go_HeroItem")
	local var_7_4 = gohelper.findChild(arg_7_0.heroContainer, "go_EquipItem")

	arg_7_0.heroItemList = {}
	arg_7_0.equipItemList = {}

	for iter_7_1 = 1, 8 do
		local var_7_5 = gohelper.cloneInPlace(var_7_3, "hero" .. iter_7_1)
		local var_7_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_5, Act191HeroGroupItem1, arg_7_0)

		var_7_6:setIndex(iter_7_1)

		arg_7_0.heroItemList[iter_7_1] = var_7_6

		CommonDragHelper.instance:registerDragObj(var_7_5, arg_7_0._onBeginDrag, nil, arg_7_0._onEndDrag, arg_7_0._checkDrag, arg_7_0, iter_7_1)

		if iter_7_1 <= 4 then
			local var_7_7 = gohelper.cloneInPlace(var_7_4, "equip" .. iter_7_1)
			local var_7_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_7, Act191HeroGroupItem2, arg_7_0)

			var_7_8:setIndex(iter_7_1)

			arg_7_0.equipItemList[iter_7_1] = var_7_8

			CommonDragHelper.instance:registerDragObj(var_7_7, arg_7_0._onBeginDrag1, nil, arg_7_0._onEndDrag1, arg_7_0._checkDrag1, arg_7_0, iter_7_1)
		end
	end

	gohelper.setActive(var_7_3, false)
	gohelper.setActive(var_7_4, false)
end

function var_0_0.refreshTeam(arg_8_0)
	local var_8_0 = arg_8_0.gameInfo.rank
	local var_8_1 = lua_activity191_rank.configDict[var_8_0].fightLevel

	UISpriteSetMgr.instance:setAct174Sprite(arg_8_0.imageLevel, "act191_level_" .. string.lower(var_8_1))

	for iter_8_0 = 1, 8 do
		arg_8_0:_setHeroItemPos(arg_8_0.heroItemList[iter_8_0], iter_8_0)

		if iter_8_0 <= 4 then
			arg_8_0:_setEquipItemPos(arg_8_0.equipItemList[iter_8_0], iter_8_0)
		end
	end

	local var_8_2 = arg_8_0.gameInfo:getTeamInfo()

	for iter_8_1 = 1, 4 do
		local var_8_3 = Activity191Helper.matchKeyInArray(var_8_2.battleHeroInfo, iter_8_1)
		local var_8_4
		local var_8_5

		if var_8_3 then
			var_8_4 = var_8_3.heroId
			var_8_5 = var_8_3.itemUid1
		end

		arg_8_0.heroItemList[iter_8_1]:setData(var_8_4)
		arg_8_0.equipItemList[iter_8_1]:setData(var_8_5)

		local var_8_6 = arg_8_0.heroInfoItemList[iter_8_1]

		if var_8_4 and var_8_4 ~= 0 then
			local var_8_7 = arg_8_0.gameInfo:getHeroInfoInWarehouse(var_8_4)
			local var_8_8 = Activity191Config.instance:getRoleCoByNativeId(var_8_4, var_8_7.star)

			var_8_6.txtName.text = var_8_8.name

			gohelper.setActive(var_8_6.goIndex, false)
			gohelper.setActive(var_8_6.txtName, true)
		else
			gohelper.setActive(var_8_6.goIndex, true)
			gohelper.setActive(var_8_6.txtName, false)
		end

		local var_8_9 = iter_8_1 + 4
		local var_8_10 = Activity191Helper.matchKeyInArray(var_8_2.subHeroInfo, iter_8_1)
		local var_8_11 = var_8_10 and var_8_10.heroId or 0

		arg_8_0.heroItemList[var_8_9]:setData(var_8_11)
	end

	arg_8_0:refreshFetter()
end

function var_0_0._checkDrag(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.heroItemList[arg_9_1]

	if not var_9_0.heroId or var_9_0.heroId == 0 then
		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_10_0, arg_10_1)
	if arg_10_0._nowDragingIndex then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)

	arg_10_0._nowDragingIndex = arg_10_1

	local var_10_0 = arg_10_0.heroItemList[arg_10_1]

	gohelper.setAsLastSibling(var_10_0.go)
end

function var_0_0._onEndDrag(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._nowDragingIndex ~= arg_11_1 then
		return
	end

	arg_11_0._nowDragingIndex = nil

	local var_11_0 = arg_11_0.heroItemList[arg_11_1]
	local var_11_1 = Activity191Helper.calcIndex(arg_11_2.position, arg_11_0.heroPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not var_11_1 or var_11_1 == arg_11_1 then
		arg_11_0:_setHeroItemPos(var_11_0, arg_11_1, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local var_11_2 = arg_11_0.heroItemList[var_11_1]

	gohelper.setAsLastSibling(var_11_2.go)

	arg_11_0._tweenId = arg_11_0:_setHeroItemPos(var_11_2, arg_11_1, true)

	arg_11_0:_setHeroItemPos(var_11_0, var_11_1, true, function()
		if arg_11_0._tweenId then
			ZProj.TweenHelper.KillById(arg_11_0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		arg_11_0.gameInfo:exchangeHero(arg_11_1, var_11_1)
	end, arg_11_0)
end

function var_0_0._setHeroItemPos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = arg_14_0.heroPosTrList[arg_14_2]
	local var_14_1 = recthelper.rectToRelativeAnchorPos(var_14_0.position, arg_14_0.heroContainer.transform)

	if arg_14_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_14_1.go.transform, var_14_1.x, var_14_1.y, 0.2, arg_14_4, arg_14_5)
	else
		recthelper.setAnchor(arg_14_1.go.transform, var_14_1.x, var_14_1.y)

		if arg_14_4 then
			arg_14_4(arg_14_5)
		end
	end
end

function var_0_0._checkDrag1(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.equipItemList[arg_15_1]

	if not var_15_0.itemUid or var_15_0.itemUid == 0 then
		return true
	end

	return false
end

function var_0_0._onBeginDrag1(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._nowDragingIndex then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)

	arg_16_0._nowDragingIndex = arg_16_1

	local var_16_0 = arg_16_0.equipItemList[arg_16_1]

	gohelper.setAsLastSibling(var_16_0.go)
end

function var_0_0._onEndDrag1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._nowDragingIndex ~= arg_17_1 then
		return
	end

	arg_17_0._nowDragingIndex = nil

	local var_17_0 = arg_17_0.equipItemList[arg_17_1]
	local var_17_1 = Activity191Helper.calcIndex(arg_17_2.position, arg_17_0.equipPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not var_17_1 or var_17_1 == arg_17_1 then
		arg_17_0:_setEquipItemPos(var_17_0, arg_17_1, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local var_17_2 = arg_17_0.equipItemList[var_17_1]

	gohelper.setAsLastSibling(var_17_2.go)

	arg_17_0._tweenId = arg_17_0:_setEquipItemPos(var_17_2, arg_17_1, true)

	arg_17_0:_setEquipItemPos(var_17_0, var_17_1, true, function()
		if arg_17_0._tweenId then
			ZProj.TweenHelper.KillById(arg_17_0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		arg_17_0.gameInfo:exchangeItem(arg_17_1, var_17_1)
	end, arg_17_0)
end

function var_0_0._setEquipItemPos(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = arg_20_0.equipPosTrList[arg_20_2]
	local var_20_1 = recthelper.rectToRelativeAnchorPos(var_20_0.position, arg_20_0.heroContainer.transform)

	if arg_20_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_20_1.go.transform, var_20_1.x, var_20_1.y, 0.2, arg_20_4, arg_20_5)
	else
		recthelper.setAnchor(arg_20_1.go.transform, var_20_1.x, var_20_1.y)

		if arg_20_4 then
			arg_20_4(arg_20_5)
		end
	end
end

function var_0_0.refreshFetter(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.fetterItemList) do
		gohelper.setActive(iter_21_1.go, false)
	end

	local var_21_0 = arg_21_0.gameInfo:getTeamFetterCntDic()
	local var_21_1 = Activity191Helper.getActiveFetterInfoList(var_21_0)

	for iter_21_2, iter_21_3 in ipairs(var_21_1) do
		local var_21_2 = arg_21_0.fetterItemList[iter_21_2]

		if not var_21_2 then
			local var_21_3 = arg_21_0:getResInst(Activity191Enum.PrefabPath.FetterItem, arg_21_0.goFetterContent)

			var_21_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_3, Act191FetterItem)
			arg_21_0.fetterItemList[iter_21_2] = var_21_2
		end

		var_21_2:setData(iter_21_3.config, iter_21_3.count)
		var_21_2:setExtraParam({
			fromView = arg_21_0.viewName,
			index = iter_21_2
		})
		gohelper.setActive(var_21_2.go, true)
	end

	arg_21_0.scrollFetter.horizontalNormalizedPosition = 0
end

return var_0_0
