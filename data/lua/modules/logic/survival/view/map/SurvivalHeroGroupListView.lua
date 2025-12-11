module("modules.logic.survival.view.map.SurvivalHeroGroupListView", package.seeall)

local var_0_0 = class("SurvivalHeroGroupListView", HeroGroupListView)
local var_0_1 = {
	{
		-1097.6,
		166.6
	},
	{
		-874.0001,
		85.79997
	},
	{
		-649.4001,
		120.9
	},
	{
		-425.1,
		165.9
	},
	{
		-199.9,
		122.6
	}
}
local var_0_2 = {
	{
		-1089.6,
		147.13
	},
	{
		-866.0001,
		66.32997
	},
	{
		-641.4001,
		101.43
	},
	{
		-417.1001,
		146.43
	},
	{
		-191.8999,
		103.13
	}
}
local var_0_3 = {
	0.9,
	0.9,
	0.9
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._episodeId = HeroGroupModel.instance.episodeId
	arg_1_0._roleNum = 5

	arg_1_0:initHeroBgList()
	arg_1_0:initHeroList()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(arg_1_0._heroItemPosList)
end

function var_0_0.initHeroList(arg_2_0)
	gohelper.setActive(arg_2_0._goheroitem, false)

	arg_2_0._heroItemList = {}
	arg_2_0.heroPosTrList = arg_2_0:getUserDataTb_()
	arg_2_0._heroItemPosList = arg_2_0:getUserDataTb_()
	arg_2_0._cardScale = var_0_3

	for iter_2_0 = 1, arg_2_0._roleNum do
		local var_2_0 = arg_2_0:_getOrCreateHeroGO(iter_2_0)
		local var_2_1 = gohelper.findChild(var_2_0, "container")
		local var_2_2 = gohelper.cloneInPlace(arg_2_0._goheroitem, "item" .. iter_2_0)
		local var_2_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_2, arg_2_0:_getHeroItemCls(), arg_2_0)

		var_2_3:setIndex(iter_2_0)
		var_2_3:setScale(arg_2_0._cardScale[1] or 1, arg_2_0._cardScale[2] or 1, arg_2_0._cardScale[3] or 1)
		table.insert(arg_2_0.heroPosTrList, var_2_1.transform)
		table.insert(arg_2_0._heroItemList, var_2_3)
		gohelper.setActive(var_2_2, true)
		arg_2_0:_setHeroItemPos(var_2_3, iter_2_0)
		table.insert(arg_2_0._heroItemPosList, var_2_3.go.transform)
		var_2_3:setParent(arg_2_0.heroPosTrList[iter_2_0])
		CommonDragHelper.instance:registerDragObj(var_2_3.go, arg_2_0._onBeginDrag, nil, arg_2_0._onEndDrag, arg_2_0._checkCanDrag, arg_2_0, iter_2_0)
	end
end

function var_0_0._getHeroItemCls(arg_3_0)
	return SurvivalHeroGroupHeroItem
end

function var_0_0._calcIndex(arg_4_0, arg_4_1)
	for iter_4_0 = 1, arg_4_0._roleNum do
		local var_4_0 = arg_4_0.heroPosTrList[iter_4_0] and arg_4_0.heroPosTrList[iter_4_0].parent

		if gohelper.isMouseOverGo(var_4_0, arg_4_1) then
			return iter_4_0
		end
	end

	return 0
end

function var_0_0.canDrag(arg_5_0, arg_5_1, arg_5_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_0._heroItemList[var_5_0]

	if var_5_1.isAid then
		return false
	end

	if var_5_1.isTrialLock then
		return false
	end

	if not arg_5_2 and (var_5_1.mo:isEmpty() or var_5_1.mo.aid == -1) then
		return false
	end

	return true
end

function var_0_0._onEndDrag(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0:canDrag(arg_6_1) then
		return
	end

	if arg_6_0._nowDragingIndex ~= arg_6_1 then
		return
	end

	arg_6_0._nowDragingIndex = nil

	local var_6_0 = arg_6_0:_calcIndex(arg_6_2.position)
	local var_6_1 = arg_6_0._heroItemList[arg_6_1]
	local var_6_2 = arg_6_1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._heroItemList) do
		iter_6_1:onItemEndDrag(var_6_2, var_6_0)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if var_6_0 == arg_6_1 or var_6_0 <= 0 then
		arg_6_0._orderList[arg_6_1].text = ""
	end

	local function var_6_3(arg_7_0, arg_7_1)
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._heroItemList) do
			iter_7_1:onItemCompleteDrag(var_6_2, var_6_0, arg_7_1)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)

		for iter_7_2, iter_7_3 in ipairs(arg_7_0._heroItemList) do
			iter_7_3:flowCurrentParent()
		end
	end

	if var_6_0 <= 0 then
		arg_6_0:_setHeroItemPos(var_6_1, var_6_2, true, var_6_3, arg_6_0)

		return
	end

	if not arg_6_0:canDrag(var_6_0, true) then
		local var_6_4 = arg_6_0._heroItemList[var_6_0]

		if var_6_4 and var_6_4.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		arg_6_0:_setHeroItemPos(var_6_1, var_6_2, true, var_6_3, arg_6_0)

		return
	end

	if var_6_0 <= 0 then
		arg_6_0:_setHeroItemPos(var_6_1, var_6_2, true, var_6_3, arg_6_0)

		return
	end

	local var_6_5 = HeroGroupModel.instance.battleId
	local var_6_6 = var_6_5 and lua_battle.configDict[var_6_5]
	local var_6_7 = HeroGroupModel.instance:getBattleRoleNum()

	if var_6_7 and var_6_7 < var_6_0 then
		arg_6_0:_setHeroItemPos(var_6_1, var_6_2, true, var_6_3, arg_6_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_6_6 and var_6_1.mo.aid and var_6_0 > var_6_6.playerMax then
		arg_6_0:_setHeroItemPos(var_6_1, var_6_2, true, var_6_3, arg_6_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_6_8 = arg_6_0._heroItemList[var_6_0]

	if var_6_8.mo.aid then
		arg_6_0:_setHeroItemPos(var_6_1, var_6_2, true, var_6_3, arg_6_0)

		return
	end

	if var_6_2 ~= var_6_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_6_8.go)
	gohelper.setAsLastSibling(var_6_1.go)
	var_6_8:flowOriginParent()

	arg_6_0._tweenId = arg_6_0:_setHeroItemPos(var_6_8, var_6_2, true)

	arg_6_0:_setHeroItemPos(var_6_1, var_6_0, true, function()
		if arg_6_0._tweenId then
			ZProj.TweenHelper.KillById(arg_6_0._tweenId)
		end

		for iter_8_0, iter_8_1 in ipairs(arg_6_0._heroItemList) do
			arg_6_0:_setHeroItemPos(iter_8_1, iter_8_0)
		end

		var_6_3(arg_6_0, true)

		local var_8_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_8_1 = var_6_1.mo.id - 1
		local var_8_2 = var_6_8.mo.id - 1
		local var_8_3 = var_8_0:getPosEquips(var_8_1).equipUid[1]
		local var_8_4 = var_8_0:getPosEquips(var_8_2).equipUid[1]

		var_8_0.equips[var_8_1].equipUid = {
			var_8_4
		}
		var_8_0.equips[var_8_2].equipUid = {
			var_8_3
		}

		HeroSingleGroupModel.instance:swap(var_6_2, var_6_0)

		local var_8_5 = HeroSingleGroupModel.instance:getHeroUids()

		for iter_8_2, iter_8_3 in ipairs(var_8_0.heroList) do
			if var_8_5[iter_8_2] ~= iter_8_3 then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				arg_6_0:_updateHeroList()

				break
			end
		end
	end, arg_6_0)
end

function var_0_0._getOrCreateHeroGO(arg_9_0, arg_9_1)
	local var_9_0 = gohelper.findChild(arg_9_0.heroContainer, "pos" .. arg_9_1)

	if gohelper.isNil(var_9_0) then
		local var_9_1 = gohelper.findChild(arg_9_0.heroContainer, "pos_template")

		var_9_0 = gohelper.cloneInPlace(var_9_1, "pos" .. arg_9_1)

		gohelper.setActive(var_9_0, true)
	end

	local var_9_2 = var_0_1[arg_9_1]
	local var_9_3 = var_0_3

	transformhelper.setLocalScale(var_9_0.transform, var_9_3[1], var_9_3[2], var_9_3[3])
	recthelper.setAnchor(var_9_0.transform, var_9_2[1], var_9_2[2])

	return var_9_0
end

function var_0_0._checkRestrictHero(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_10_2 = SurvivalMapModel.instance:getSceneMo()

	for iter_10_0 = 1, 5 do
		local var_10_3 = HeroSingleGroupModel.instance:getById(iter_10_0)

		if var_10_3 then
			local var_10_4 = var_10_3:getHeroMO()

			if var_10_4 then
				local var_10_5 = var_10_1:getHeroMo(var_10_4.heroId)

				if HeroGroupModel.instance:isRestrict(var_10_3.heroUid) or var_10_5.health <= 0 or not var_10_2.teamInfo:getHeroMo(var_10_3.heroUid) then
					var_10_0[var_10_3.heroUid] = true
				end
			else
				var_10_3:setEmpty()
			end
		end
	end

	if tabletool.len(var_10_0) <= 0 then
		return
	end

	local var_10_6 = HeroGroupModel.instance:getCurrentBattleConfig()
	local var_10_7 = var_10_6 and var_10_6.restrictReason

	if not string.nilorempty(var_10_7) then
		ToastController.instance:showToastWithString(var_10_7)
	end

	for iter_10_1, iter_10_2 in ipairs(arg_10_0._heroItemList) do
		iter_10_2:playRestrictAnimation(var_10_0)
	end

	arg_10_0.needRemoveHeroUidDict = var_10_0

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_10_0._removeRestrictHero, arg_10_0, 1.5)
end

function var_0_0.initHeroBgList(arg_11_0)
	arg_11_0._bgList = arg_11_0:getUserDataTb_()
	arg_11_0._orderList = arg_11_0:getUserDataTb_()
	arg_11_0._openCount = arg_11_0._roleNum

	for iter_11_0 = 1, arg_11_0._roleNum do
		local var_11_0 = arg_11_0:_getOrCreateHeroBg(iter_11_0)
		local var_11_1 = gohelper.findChild(var_11_0, "bg")

		table.insert(arg_11_0._bgList, var_11_1)

		local var_11_2 = gohelper.findChildTextMesh(var_11_0, "bg/#txt_order")

		var_11_2.text = iter_11_0 <= arg_11_0._openCount and tostring(iter_11_0) or ""

		table.insert(arg_11_0._orderList, var_11_2)
	end
end

function var_0_0._getOrCreateHeroBg(arg_12_0, arg_12_1)
	local var_12_0 = gohelper.findChild(arg_12_0.viewGO, "herogroupcontain/hero/bg" .. arg_12_1)

	if gohelper.isNil(var_12_0) then
		local var_12_1 = gohelper.findChild(arg_12_0.viewGO, "herogroupcontain/hero/bg1")

		var_12_0 = gohelper.cloneInPlace(var_12_1, "bg" .. arg_12_1)
	end

	local var_12_2 = var_0_2
	local var_12_3 = var_12_2 and var_12_2[arg_12_1] or {
		0,
		0
	}
	local var_12_4 = var_0_3

	transformhelper.setLocalScale(var_12_0.transform, var_12_4[1], var_12_4[2], var_12_4[3])
	recthelper.setAnchor(var_12_0.transform, var_12_3[1], var_12_3[2])

	return var_12_0
end

function var_0_0._onScreenSizeChange(arg_13_0)
	if arg_13_0._heroItemList then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._heroItemList) do
			arg_13_0:_setHeroItemPos(iter_13_1, iter_13_0)
		end
	end
end

function var_0_0.onDestroyView(arg_14_0)
	if arg_14_0._heroItemList then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._heroItemList) do
			CommonDragHelper.instance:unregisterDragObj(iter_14_1.go)
		end
	end

	var_0_0.super.onDestroyView(arg_14_0)
end

return var_0_0
