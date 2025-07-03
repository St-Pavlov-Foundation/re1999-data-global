module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupListView", package.seeall)

local var_0_0 = class("Act183HeroGroupListView", HeroGroupListView)
local var_0_1 = {
	[ModuleEnum.HeroGroupSnapshotType.Act183Normal] = {
		{
			-967.6,
			140.47
		},
		{
			-717.86,
			50.8
		},
		{
			-468.9,
			90.63
		},
		{
			-219.8,
			140.2
		}
	},
	[ModuleEnum.HeroGroupSnapshotType.Act183Boss] = {
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
}
local var_0_2 = {
	[ModuleEnum.HeroGroupSnapshotType.Act183Normal] = {
		{
			-959.6,
			121
		},
		{
			-709.9,
			31.2
		},
		{
			-461,
			71
		},
		{
			-211.75,
			121
		}
	},
	[ModuleEnum.HeroGroupSnapshotType.Act183Boss] = {
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
}
local var_0_3 = {
	[ModuleEnum.HeroGroupSnapshotType.Act183Normal] = {
		1,
		1,
		1
	},
	[ModuleEnum.HeroGroupSnapshotType.Act183Boss] = {
		0.9,
		0.9,
		0.9
	}
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._episodeId = HeroGroupModel.instance.episodeId
	arg_1_0._roleNum = Act183Helper.getEpisodeBattleNum(arg_1_0._episodeId)
	arg_1_0._snapshotType = Act183Helper.getEpisodeSnapShotType(arg_1_0._episodeId)

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
	arg_2_0._cardScale = var_0_3[arg_2_0._snapshotType]

	if not arg_2_0._cardScale then
		logError(string.format("卡牌缩放配置(BgAndCardScaleMap)不存在 snapshotType = %s", arg_2_0._snapshotType))
	end

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

		local var_2_4 = gohelper.findChild(var_2_0, "go_leader")

		var_2_3:setBgLeaderTran(var_2_4.transform)
	end
end

function var_0_0._getHeroItemCls(arg_3_0)
	return Act183HeroGroupHeroItem
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

	local var_9_2 = var_0_1[arg_9_0._snapshotType]
	local var_9_3 = var_9_2 and var_9_2[arg_9_1]
	local var_9_4 = var_0_3[arg_9_0._snapshotType]

	if var_9_3 and var_9_4 then
		transformhelper.setLocalScale(var_9_0.transform, var_9_4[1], var_9_4[2], var_9_4[3])
		recthelper.setAnchor(var_9_0.transform, var_9_3[1], var_9_3[2])
	else
		logError(string.format("编队界面卡牌缺少坐标配置(HeroContainerPostionMap) or 缩放配置(BgAndCardScaleMap) : snapshotType = %s, index = %s", arg_9_0._snapshotType, arg_9_1))
	end

	return var_9_0
end

function var_0_0.initHeroBgList(arg_10_0)
	arg_10_0._bgList = arg_10_0:getUserDataTb_()
	arg_10_0._orderList = arg_10_0:getUserDataTb_()
	arg_10_0._openCount = arg_10_0._roleNum

	for iter_10_0 = 1, arg_10_0._roleNum do
		local var_10_0 = arg_10_0:_getOrCreateHeroBg(iter_10_0)
		local var_10_1 = gohelper.findChild(var_10_0, "bg")

		table.insert(arg_10_0._bgList, var_10_1)

		local var_10_2 = gohelper.findChildTextMesh(var_10_0, "bg/#txt_order")

		var_10_2.text = iter_10_0 <= arg_10_0._openCount and tostring(iter_10_0) or ""

		table.insert(arg_10_0._orderList, var_10_2)
	end
end

function var_0_0._getOrCreateHeroBg(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "herogroupcontain/hero/bg" .. arg_11_1)

	if gohelper.isNil(var_11_0) then
		local var_11_1 = gohelper.findChild(arg_11_0.viewGO, "herogroupcontain/hero/bg1")

		var_11_0 = gohelper.cloneInPlace(var_11_1, "bg" .. arg_11_1)
	end

	local var_11_2 = var_0_2[arg_11_0._snapshotType]
	local var_11_3 = var_11_2 and var_11_2[arg_11_1]
	local var_11_4 = var_0_3[arg_11_0._snapshotType]

	if var_11_3 and var_11_4 then
		transformhelper.setLocalScale(var_11_0.transform, var_11_4[1], var_11_4[2], var_11_4[3])
		recthelper.setAnchor(var_11_0.transform, var_11_3[1], var_11_3[2])
	else
		logError(string.format("编队界面卡牌背景缺少坐标配置(HeroBgPositionMap) or 缩放配置(BgAndCardScaleMap) : snapshotType = %s, index = %s", arg_11_0._snapshotType, arg_11_1))
	end

	return var_11_0
end

function var_0_0._onScreenSizeChange(arg_12_0)
	if arg_12_0._heroItemList then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._heroItemList) do
			arg_12_0:_setHeroItemPos(iter_12_1, iter_12_0)
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._heroItemList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._heroItemList) do
			CommonDragHelper.instance:unregisterDragObj(iter_13_1.go)
		end
	end

	var_0_0.super.onDestroyView(arg_13_0)
end

return var_0_0
