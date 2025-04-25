module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupListView", package.seeall)

slot0 = class("Act183HeroGroupListView", HeroGroupListView)
slot1 = {
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
slot2 = {
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
slot3 = {
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

function slot0._editableInitView(slot0)
	slot2 = lua_battle.configDict[HeroGroupModel.instance.battleId]
	slot0._playerMax = slot2.playerMax
	slot0._roleNum = slot2.roleNum
	slot0._snapshotType = HeroGroupModel.instance:getHeroGroupSnapshotType()

	slot0:initHeroBgList()
	slot0:initHeroList()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(slot0._heroItemPosList)
end

function slot0.initHeroList(slot0)
	gohelper.setActive(slot0._goheroitem, false)

	slot0._heroItemList = {}
	slot0.heroPosTrList = slot0:getUserDataTb_()
	slot0._heroItemPosList = slot0:getUserDataTb_()
	slot0._cardScale = uv0[slot0._snapshotType]

	for slot4 = 1, slot0._roleNum do
		slot7 = gohelper.cloneInPlace(slot0._goheroitem, "item" .. slot4)
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, slot0:_getHeroItemCls(), slot0)

		slot8:setIndex(slot4)
		slot8:setScale(slot0._cardScale[1], slot0._cardScale[2], slot0._cardScale[3])
		table.insert(slot0.heroPosTrList, gohelper.findChild(slot0:_getOrCreateHeroGO(slot4), "container").transform)
		table.insert(slot0._heroItemList, slot8)
		gohelper.setActive(slot7, true)
		slot0:_setHeroItemPos(slot8, slot4)
		table.insert(slot0._heroItemPosList, slot8.go.transform)
		slot8:setParent(slot0.heroPosTrList[slot4])
		CommonDragHelper.instance:registerDragObj(slot8.go, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._checkCanDrag, slot0, slot4)
	end
end

function slot0._getHeroItemCls(slot0)
	return Act183HeroGroupHeroItem
end

function slot0._calcIndex(slot0, slot1)
	for slot5 = 1, slot0._roleNum do
		if gohelper.isMouseOverGo(slot0.heroPosTrList[slot5] and slot0.heroPosTrList[slot5].parent, slot1) then
			return slot5
		end
	end

	return 0
end

function slot0.canDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if slot0._heroItemList[slot1].isAid then
		return false
	end

	if slot4.isTrialLock then
		return false
	end

	if not slot2 and (slot4.mo:isEmpty() or slot4.mo.aid == -1) then
		return false
	end

	return true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if not slot0:canDrag(slot1) then
		return
	end

	if slot0._nowDragingIndex ~= slot1 then
		return
	end

	slot0._nowDragingIndex = nil
	slot3 = slot0:_calcIndex(slot2.position)
	slot4 = slot0._heroItemList[slot1]

	for slot9, slot10 in ipairs(slot0._heroItemList) do
		slot10:onItemEndDrag(slot1, slot3)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if slot3 == slot1 or slot3 <= 0 then
		slot0._orderList[slot1].text = ""
	end

	if slot3 <= 0 then
		slot0:_setHeroItemPos(slot4, slot5, true, function (slot0, slot1)
			for slot5, slot6 in ipairs(slot0._heroItemList) do
				slot6:onItemCompleteDrag(uv0, uv1, slot1)
			end

			CommonDragHelper.instance:setGlobalEnabled(true)

			for slot5, slot6 in ipairs(slot0._heroItemList) do
				slot6:flowCurrentParent()
			end
		end, slot0)

		return
	end

	if not slot0:canDrag(slot3, true) then
		if slot0._heroItemList[slot3] and slot7.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		return
	end

	if slot3 <= 0 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		return
	end

	slot8 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot7]

	if HeroGroupModel.instance:getBattleRoleNum() and slot9 < slot3 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if slot8 and slot4.mo.aid and slot8.playerMax < slot3 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	if slot0._heroItemList[slot3].mo.aid then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		return
	end

	if slot5 ~= slot3 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(slot10.go)
	gohelper.setAsLastSibling(slot4.go)
	slot10:flowOriginParent()

	slot0._tweenId = slot0:_setHeroItemPos(slot10, slot5, true)

	slot0:_setHeroItemPos(slot4, slot3, true, function ()
		if uv0._tweenId then
			ZProj.TweenHelper.KillById(uv0._tweenId)
		end

		for slot3, slot4 in ipairs(uv0._heroItemList) do
			uv0:_setHeroItemPos(slot4, slot3)
		end

		uv1(uv0, true)

		slot0 = HeroGroupModel.instance:getCurGroupMO()
		slot1 = uv2.mo.id - 1
		slot2 = uv3.mo.id - 1
		slot0.equips[slot1].equipUid = {
			slot0:getPosEquips(slot2).equipUid[1]
		}
		slot0.equips[slot2].equipUid = {
			slot0:getPosEquips(slot1).equipUid[1]
		}

		HeroSingleGroupModel.instance:swap(uv4, uv5)

		for slot9, slot10 in ipairs(slot0.heroList) do
			if HeroSingleGroupModel.instance:getHeroUids()[slot9] ~= slot10 then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				uv0:_updateHeroList()

				break
			end
		end
	end, slot0)
end

function slot0._getOrCreateHeroGO(slot0, slot1)
	if gohelper.isNil(gohelper.findChild(slot0.heroContainer, "pos" .. slot1)) then
		gohelper.setActive(gohelper.cloneInPlace(gohelper.findChild(slot0.heroContainer, "pos_template"), "pos" .. slot1), true)
	end

	slot5 = uv1[slot0._snapshotType]

	if uv0[slot0._snapshotType] and slot3[slot1] and slot5 then
		transformhelper.setLocalScale(slot2.transform, slot5[1], slot5[2], slot5[3])
		recthelper.setAnchor(slot2.transform, slot4[1], slot4[2])
	else
		logError(string.format("编队界面卡牌缺少坐标配置(HeroContainerPostionMap) or 缩放配置(BgAndCardScaleMap) : snapshotType = %s, index = %s", slot0._snapshotType, slot1))
	end

	return slot2
end

function slot0.initHeroBgList(slot0)
	slot0._bgList = slot0:getUserDataTb_()
	slot0._orderList = slot0:getUserDataTb_()
	slot0._openCount = slot0._roleNum

	for slot4 = 1, slot0._roleNum do
		slot5 = slot0:_getOrCreateHeroBg(slot4)

		table.insert(slot0._bgList, gohelper.findChild(slot5, "bg"))

		slot7 = gohelper.findChildTextMesh(slot5, "bg/#txt_order")
		slot7.text = slot4 <= slot0._openCount and tostring(slot4) or ""

		table.insert(slot0._orderList, slot7)
	end
end

function slot0._getOrCreateHeroBg(slot0, slot1)
	if gohelper.isNil(gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg" .. slot1)) then
		slot2 = gohelper.cloneInPlace(gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg1"), "bg" .. slot1)
	end

	slot5 = uv1[slot0._snapshotType]

	if uv0[slot0._snapshotType] and slot3[slot1] and slot5 then
		transformhelper.setLocalScale(slot2.transform, slot5[1], slot5[2], slot5[3])
		recthelper.setAnchor(slot2.transform, slot4[1], slot4[2])
	else
		logError(string.format("编队界面卡牌背景缺少坐标配置(HeroBgPositionMap) or 缩放配置(BgAndCardScaleMap) : snapshotType = %s, index = %s", slot0._snapshotType, slot1))
	end

	return slot2
end

function slot0._onScreenSizeChange(slot0)
	if slot0._heroItemList then
		for slot4, slot5 in ipairs(slot0._heroItemList) do
			slot0:_setHeroItemPos(slot5, slot4)
		end
	end
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)

	if slot0._heroItemList then
		for slot4, slot5 in pairs(slot0._heroItemList) do
			CommonDragHelper.instance:unregisterDragObj(slot5.go)
		end
	end
end

return slot0
