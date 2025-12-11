module("modules.logic.versionactivity2_7.act191.view.item.Act191TeamComp", package.seeall)

local var_0_0 = class("Act191TeamComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handleViewName = arg_1_1.viewName
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goHeroTeam = gohelper.findChild(arg_2_1, "#go_HeroTeam")
	arg_2_0.goCollectionTeam = gohelper.findChild(arg_2_1, "#go_CollectionTeam")
	arg_2_0.imageLevel = gohelper.findChildImage(arg_2_1, "level/#image_Level")
	arg_2_0.goRoleS = gohelper.findChild(arg_2_1, "switch/role/select")
	arg_2_0.goRoleU = gohelper.findChild(arg_2_1, "switch/role/unselect")
	arg_2_0.goCollectionS = gohelper.findChild(arg_2_1, "switch/collection/select")
	arg_2_0.goCollectionU = gohelper.findChild(arg_2_1, "switch/collection/unselect")
	arg_2_0.btnSwitch = gohelper.findChildButtonWithAudio(arg_2_1, "switch/btn_Switch")
	arg_2_0.scrollFetter = gohelper.findChildScrollRect(arg_2_1, "#scroll_Fetter")
	arg_2_0.goFetterContent = gohelper.findChild(arg_2_1, "#scroll_Fetter/Viewport/#go_FetterContent")
	arg_2_0.btnEnhance = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_Enhance")

	arg_2_0:addClickCb(arg_2_0.btnEnhance, arg_2_0._btnEnhanceOnClick, arg_2_0)

	arg_2_0.groupItem1List = {}
	arg_2_0.subGroupItem1List = {}
	arg_2_0.groupItem2List = {}
	arg_2_0.fetterItemList = {}
	arg_2_0.heroPosTrList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 8 do
		local var_2_0 = gohelper.findChild(arg_2_0.go, "recordPos/hero" .. iter_2_0)

		arg_2_0.heroPosTrList[iter_2_0] = var_2_0.transform

		local var_2_1 = gohelper.findChild(arg_2_0.goHeroTeam, "hero" .. iter_2_0)

		arg_2_0.groupItem1List[iter_2_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, Act191HeroGroupItem1)

		arg_2_0.groupItem1List[iter_2_0]:setIndex(iter_2_0)
		arg_2_0.groupItem1List[iter_2_0]:setExtraParam({
			type = "justHero",
			fromView = arg_2_0.handleViewName
		})
		CommonDragHelper.instance:registerDragObj(var_2_1, arg_2_0._onBeginDrag, nil, arg_2_0._onEndDrag, arg_2_0._checkDrag, arg_2_0, iter_2_0)

		if iter_2_0 <= 4 then
			local var_2_2 = gohelper.findChild(arg_2_0.goCollectionTeam, "hero" .. iter_2_0)

			arg_2_0.subGroupItem1List[iter_2_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_2, Act191HeroGroupItem1)

			arg_2_0.subGroupItem1List[iter_2_0]:setIndex(iter_2_0)
			arg_2_0.subGroupItem1List[iter_2_0]:setClickEnable(false)
			arg_2_0.subGroupItem1List[iter_2_0]:setExtraParam({
				type = "heroItem",
				fromView = arg_2_0.handleViewName
			})

			local var_2_3 = gohelper.findChild(arg_2_0.goCollectionTeam, "collection" .. iter_2_0)

			arg_2_0.groupItem2List[iter_2_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, Act191HeroGroupItem2)

			arg_2_0.groupItem2List[iter_2_0]:setIndex(iter_2_0)
			arg_2_0.groupItem2List[iter_2_0]:setExtraParam({
				type = "heroItem",
				fromView = arg_2_0.handleViewName
			})
		end
	end

	arg_2_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_2_0._loader = MultiAbLoader.New()

	arg_2_0._loader:addPath(Activity191Enum.PrefabPath.FetterItem)
	arg_2_0._loader:startLoad(arg_2_0._loadFinish, arg_2_0)

	arg_2_0._anim = arg_2_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnSwitch, arg_3_0.onClickSwitch, arg_3_0)
	arg_3_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, arg_3_0.refreshTeam, arg_3_0)
	arg_3_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, arg_3_0.refreshTeam, arg_3_0)
end

function var_0_0.onStart(arg_4_0)
	arg_4_0:refreshTeam()
	arg_4_0:refreshStatus()

	local var_4_0 = #arg_4_0.gameInfo.warehouseInfo.enhanceId

	gohelper.setActive(arg_4_0.btnEnhance, var_4_0 ~= 0)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end

	TaskDispatcher.cancelTask(arg_5_0.refreshStatus, arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.groupItem1List) do
		CommonDragHelper.instance:unregisterDragObj(iter_5_1.go)
	end
end

function var_0_0._loadFinish(arg_6_0)
	arg_6_0.canFreshFetter = true

	if arg_6_0.needFreshFetter then
		arg_6_0:refreshFetter()

		arg_6_0.needFreshFetter = false
	end
end

function var_0_0.onClickSwitch(arg_7_0, arg_7_1)
	arg_7_0.editCollection = not arg_7_0.editCollection

	if arg_7_1 then
		arg_7_0:refreshStatus()
	else
		arg_7_0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_7_0.refreshStatus, arg_7_0, 0.16)
	end

	if not arg_7_1 then
		local var_7_0 = arg_7_0.editCollection and "Collection" or "Hero"

		Act191StatController.instance:statButtonClick(arg_7_0.handleViewName, string.format("onClickSwitch_%s", var_7_0))
	end
end

function var_0_0.refreshStatus(arg_8_0)
	gohelper.setActive(arg_8_0.goRoleS, not arg_8_0.editCollection)
	gohelper.setActive(arg_8_0.goRoleU, arg_8_0.editCollection)
	gohelper.setActive(arg_8_0.goCollectionS, arg_8_0.editCollection)
	gohelper.setActive(arg_8_0.goCollectionU, not arg_8_0.editCollection)
	gohelper.setActive(arg_8_0.goHeroTeam, not arg_8_0.editCollection)
	gohelper.setActive(arg_8_0.goCollectionTeam, arg_8_0.editCollection)
end

function var_0_0.refreshTeam(arg_9_0)
	local var_9_0 = arg_9_0.gameInfo:getTeamInfo()
	local var_9_1 = lua_activity191_rank.configDict[arg_9_0.gameInfo.rank].fightLevel

	UISpriteSetMgr.instance:setAct174Sprite(arg_9_0.imageLevel, "act191_level_" .. string.lower(var_9_1))

	for iter_9_0 = 1, 4 do
		arg_9_0:_setHeroItemPos(arg_9_0.groupItem1List[iter_9_0], iter_9_0)
		arg_9_0:_setHeroItemPos(arg_9_0.groupItem1List[iter_9_0 + 4], iter_9_0 + 4)

		local var_9_2 = Activity191Helper.matchKeyInArray(var_9_0.battleHeroInfo, iter_9_0)
		local var_9_3 = var_9_2 and var_9_2.heroId
		local var_9_4 = Activity191Helper.matchKeyInArray(var_9_0.subHeroInfo, iter_9_0)
		local var_9_5 = var_9_4 and var_9_4.heroId

		arg_9_0.groupItem1List[iter_9_0]:setData(var_9_3)
		arg_9_0.groupItem1List[iter_9_0 + 4]:setData(var_9_5)
		arg_9_0.subGroupItem1List[iter_9_0]:setData(var_9_3)

		local var_9_6 = var_9_2 and var_9_2.itemUid1

		arg_9_0.groupItem2List[iter_9_0]:setData(var_9_6)
	end

	if arg_9_0.canFreshFetter then
		arg_9_0:refreshFetter()
	else
		arg_9_0.needFreshFetter = true
	end
end

function var_0_0.refreshFetter(arg_10_0)
	local var_10_0 = arg_10_0.gameInfo:getTeamFetterCntDic()
	local var_10_1 = Activity191Helper.getActiveFetterInfoList(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = arg_10_0.fetterItemList[iter_10_0]

		if not var_10_2 then
			local var_10_3 = arg_10_0._loader:getFirstAssetItem():GetResource()
			local var_10_4 = gohelper.clone(var_10_3, arg_10_0.goFetterContent)

			var_10_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_4, Act191FetterItem)

			var_10_2:setExtraParam({
				fromView = arg_10_0.handleViewName,
				index = iter_10_0
			})

			arg_10_0.fetterItemList[iter_10_0] = var_10_2
		end

		var_10_2:setData(iter_10_1.config, iter_10_1.count)
		gohelper.setActive(var_10_2.go, true)
	end

	for iter_10_2 = #var_10_1 + 1, #arg_10_0.fetterItemList do
		local var_10_5 = arg_10_0.fetterItemList[iter_10_2]

		gohelper.setActive(var_10_5.go, false)
	end

	gohelper.setActive(arg_10_0._goFetterContent, #var_10_1 ~= 0)

	arg_10_0.scrollFetter.horizontalNormalizedPosition = 0
	arg_10_0.needFreshFetter = false
end

function var_0_0._checkDrag(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.groupItem1List[arg_11_1]

	if not var_11_0.heroId or var_11_0.heroId == 0 then
		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.groupItem1List[arg_12_1]

	if not var_12_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	var_12_0:setDrag(true)
end

function var_0_0._onEndDrag(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.groupItem1List[arg_13_1]

	if not var_13_0 then
		return
	end

	var_13_0:setDrag(false)

	local var_13_1 = Activity191Helper.calcIndex(arg_13_2.position, arg_13_0.heroPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not var_13_1 or var_13_1 == arg_13_1 then
		arg_13_0:_setHeroItemPos(var_13_0, arg_13_1, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local var_13_2 = arg_13_0.groupItem1List[var_13_1]

	gohelper.setAsLastSibling(var_13_2.go)

	arg_13_0._tweenId = arg_13_0:_setHeroItemPos(var_13_2, arg_13_1, true)

	arg_13_0:_setHeroItemPos(var_13_0, var_13_1, true, function()
		if arg_13_0._tweenId then
			ZProj.TweenHelper.KillById(arg_13_0._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		arg_13_0.gameInfo:exchangeHero(arg_13_1, var_13_1)
	end, arg_13_0)
end

function var_0_0._setHeroItemPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = arg_16_0.heroPosTrList[arg_16_2]
	local var_16_1 = recthelper.rectToRelativeAnchorPos(var_16_0.position, arg_16_0.goHeroTeam.transform)

	if arg_16_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_16_1.go.transform, var_16_1.x, var_16_1.y, 0.2, arg_16_4, arg_16_5)
	else
		recthelper.setAnchor(arg_16_1.go.transform, var_16_1.x, var_16_1.y)

		if arg_16_4 then
			arg_16_4(arg_16_5)
		end
	end
end

function var_0_0._btnEnhanceOnClick(arg_17_0)
	Act191StatController.instance:statButtonClick(arg_17_0.handleViewName, "_btnEnhanceOnClick")
	ViewMgr.instance:openView(ViewName.Act191EnhanceView, {
		isDown = true,
		pos = Vector2(380, -735)
	})
end

return var_0_0
