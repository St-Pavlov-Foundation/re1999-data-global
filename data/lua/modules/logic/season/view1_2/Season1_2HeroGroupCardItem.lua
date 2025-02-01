module("modules.logic.season.view1_2.Season1_2HeroGroupCardItem", package.seeall)

slot0 = class("Season1_2HeroGroupCardItem", UserDataDispose)
slot0.TweenDuration = 0.16
slot0.DragOffset = Vector2(0, 40)
slot0.ZeroPos = Vector2(-2.7, -5)
slot0.ZeroScale = 0.39

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.go = slot1
	slot0.parent = slot2
	slot0.transform = slot1.transform
	slot0.param = slot3
	slot0.slot = slot3.slot

	slot0:init()
end

function slot0.init(slot0)
	slot0._gocardempty = gohelper.findChild(slot0.go, "go_empty")
	slot0._gocardicon = gohelper.findChild(slot0.go, "go_card")
	slot0._trscard = slot0._gocardicon.transform
	slot0._gocardlock = gohelper.findChild(slot0.go, "go_lock")
	slot0._btncardclick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
	slot0.trsRect = slot0._btncardclick.transform

	slot0:addClickCb(slot0._btncardclick, slot0._btnCardClick, slot0)
	slot0:AddDrag(slot0._btncardclick.gameObject)

	slot1, slot2, slot0.orignRoteZ = transformhelper.getLocalRotation(slot0._trscard)
end

function slot0.AddDrag(slot0, slot1)
	if slot0._drag then
		return
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0, slot1.transform)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0, slot1.transform)
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4)
	slot0._equipId = slot3
	slot0._equipUid = slot4
	slot0._layer = slot2 or Activity104Model.instance:getAct104CurLayer()
	slot0.id = slot1.id
	slot0._hasUseSeasonEquipCard = false

	slot0:updateView()
end

function slot0.setActive(slot0, slot1)
	slot0.isActive = slot1
end

function slot0.updateView(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()
	slot2 = Activity104Model.instance:getSeasonCurSnapshotSubId(slot1)
	slot0.posUnlock = Activity104Model.instance:isSeasonLayerPosUnlock(slot1, slot2, slot0._layer, slot0.slot, slot0.id - 1)
	slot0.slotUnlock = Activity104Model.instance:isSeasonLayerSlotUnlock(slot1, slot2, slot0._layer, slot0.slot)

	gohelper.setActive(slot0._gocardlock, not slot0.posUnlock)
	gohelper.setActive(slot0._gocardempty, slot0.posUnlock)
	gohelper.setActive(slot0.go, slot0.slotUnlock)

	if slot0.posUnlock then
		if slot0:getEquipId(slot1, slot2) ~= 0 then
			if not slot0._seasonCardItem then
				slot0._seasonCardItem = Season1_2CelebrityCardItem.New()

				slot0._seasonCardItem:init(slot0._gocardicon, slot3, {
					noClick = true
				})
			else
				gohelper.setActive(slot0._seasonCardItem.go, true)
				slot0._seasonCardItem:reset(slot3)
			end

			slot0._hasUseSeasonEquipCard = true
		else
			if slot0._seasonCardItem then
				gohelper.setActive(slot0._seasonCardItem.go, false)
			end

			slot0:playEmptyUnlockAnim()
		end
	elseif slot0._seasonCardItem then
		gohelper.setActive(slot0._seasonCardItem.go, false)
	end
end

function slot0.playEmptyUnlockAnim(slot0)
	if Activity104Model.instance:isContainGroupCardUnlockTweenPos(Activity104Model.instance:getCurSeasonId(), slot0._layer - 1, slot0.id - 1 == 4 and 9 or slot2 + 1 + 4 * (slot0.slot - 1)) then
		return
	end

	if not slot0._animcardempty then
		slot0._animcardempty = slot0._gocardempty:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._animcardempty:Play("lock")
	Activity104Model.instance:setGroupCardUnlockTweenPos(slot1, slot4)
end

function slot0.getEquipId(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO() and slot3.isReplay then
		return slot0._equipId, slot0._equipUid
	end

	if slot0._equipId ~= 0 then
		return slot0._equipId, slot0._equipUid
	end

	if not slot0.slot or not slot0.id then
		return 0
	end

	slot1 = slot1 or Activity104Model.instance:getCurSeasonId()

	return Activity104Model.instance:getSeasonHeroGroupEquipId(slot1, slot2 or Activity104Model.instance:getSeasonCurSnapshotSubId(slot1), slot0.slot, slot0.id - 1)
end

function slot0.hasUseSeasonEquipCard(slot0)
	return slot0._hasUseSeasonEquipCard
end

function slot0._btnCardClick(slot0)
	if slot0.inDrag then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not slot0.id then
		return
	end

	slot1 = Activity104Model.instance:getCurSeasonId()

	if not Activity104Model.instance:isSeasonPosUnlock(slot1, Activity104Model.instance:getSeasonCurSnapshotSubId(slot1), slot0.slot, slot0.id - 1) then
		GameFacade.showToast(ToastEnum.SeasonEquipSlotNotUnlock)

		return
	end

	Activity104Controller.instance:openSeasonEquipView({
		group = slot2,
		actId = slot1,
		pos = slot0.id - 1,
		slot = slot0.slot or 1
	})
end

function slot0.canDrag(slot0)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if not slot0.posUnlock then
		return false
	end

	if not slot0:getEquipId() or slot1 == 0 then
		return false
	end

	return true
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:killTweenId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setAsLastSibling(slot0.parent.go)
	gohelper.setAsLastSibling(slot0.go)
	slot0:_tweenToPos(slot0._trscard, recthelper.screenPosToAnchorPos(slot2.position, slot0.transform) + uv0.DragOffset, true)

	slot4 = uv0.ZeroScale * 1.7
	slot0.tweenId = ZProj.TweenHelper.DOScale(slot0._trscard, slot4, slot4, slot4, uv0.TweenDuration)
	slot0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(slot0._trscard, 0, 0, 0, uv0.TweenDuration)
	slot0.inDrag = true
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:_tweenToPos(slot0._trscard, recthelper.screenPosToAnchorPos(slot2.position, slot0.transform) + uv0.DragOffset)

	slot0.inDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0.inDrag = false

	if not slot0:canDrag() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	slot0:killTweenId()

	slot3 = uv0.ZeroScale * 1
	slot0.tweenId = ZProj.TweenHelper.DOScale(slot0._trscard, slot3, slot3, slot3, uv0.TweenDuration)

	slot0:_setDragEnabled(false)

	if not slot0:_moveToTarget(slot2.position) or not slot4:canExchange(slot0) then
		slot0:_setToPos(slot0._trscard, uv0.ZeroPos, true, slot0._onDragFailTweenEnd, slot0)

		slot0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(slot0._trscard, 0, 0, slot0.orignRoteZ, uv0.TweenDuration)

		return
	end

	slot0:_setToPos(slot0._trscard, recthelper.rectToRelativeAnchorPos(slot4.transform.position, slot0.transform), true, slot0._onDragSuccessTweenEnd, slot0, slot4)

	slot0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(slot0._trscard, 0, 0, slot4.orignRoteZ, uv0.TweenDuration)
end

function slot0._tweenToPos(slot0, slot1, slot2)
	if slot0.posTweenId then
		ZProj.TweenHelper.KillById(slot0.posTweenId)

		slot0.posTweenId = nil
	end

	slot3, slot4 = recthelper.getAnchor(slot1)

	if math.abs(slot3 - slot2.x) > 10 or math.abs(slot4 - slot2.y) > 10 then
		slot0.posTweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, uv0.TweenDuration)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)
	end
end

function slot0._setToPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7, slot8 = recthelper.getAnchor(slot1)

	if slot3 then
		slot0.moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, uv0.TweenDuration, slot4, slot5, slot6)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot4 then
			slot4(slot5, slot6)
		end
	end
end

function slot0._moveToTarget(slot0, slot1)
	if slot0.parent:getHeroItemList() then
		for slot6, slot7 in pairs(slot2) do
			for slot11 = 1, 2 do
				if slot7[string.format("_cardItem%s", slot11)] ~= slot0 then
					slot13 = slot12.trsRect

					if math.abs(recthelper.screenPosToAnchorPos(slot1, slot13).x) * 2 < recthelper.getWidth(slot13) and math.abs(slot14.y) * 2 < recthelper.getHeight(slot13) then
						return slot12
					end
				end
			end
		end
	end

	return nil
end

function slot0._setDragEnabled(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.parent:getHeroItemList()) do
		for slot11 = 1, 2 do
			if slot7[string.format("_cardItem%s", slot11)] then
				slot12:setDragEnabled(slot1)
			end
		end
	end
end

function slot0.setDragEnabled(slot0, slot1)
	if slot0._drag then
		slot0._drag.enabled = slot1
	end
end

function slot0.canExchange(slot0, slot1)
	if slot1 == slot0 then
		return false
	end

	if not slot1.posUnlock or not slot0.posUnlock then
		return false
	end

	if not slot1.isActive or not slot0.isActive then
		return false
	end

	slot4 = slot1.slot
	slot5 = SeasonConfig.instance:getSeasonEquipCo(slot1:getEquipId())
	slot9 = SeasonConfig.instance:getSeasonEquipCo(slot0:getEquipId())

	for slot16 = 1, Activity104EquipItemListModel.instance:getEquipMaxCount(slot0.id - 1) do
		if slot16 ~= slot0.slot then
			slot18 = SeasonConfig.instance:getSeasonEquipCo(Activity104Model.instance:getSeasonHeroGroupEquipId(slot11, Activity104Model.instance:getSeasonCurSnapshotSubId(Activity104Model.instance:getCurSeasonId()), slot16, slot7))

			if slot5 and slot18 and slot18.group == slot5.group and slot1.id - 1 ~= slot7 then
				GameFacade.showToast(Season1_2EquipItem.Toast_Same_Card)

				return false
			end
		end

		if slot16 ~= slot4 then
			slot18 = SeasonConfig.instance:getSeasonEquipCo(Activity104Model.instance:getSeasonHeroGroupEquipId(slot11, slot12, slot16, slot3))

			if slot9 and slot18 and slot18.group == slot9.group and slot3 ~= slot7 then
				GameFacade.showToast(Season1_2EquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	return true
end

function slot0._onDragFailTweenEnd(slot0)
	slot0:_setDragEnabled(true)
	gohelper.setAsLastSibling(slot0.parent._cardItem1.go)
end

function slot0._onDragSuccessTweenEnd(slot0, slot1)
	slot0:killTweenId()
	slot0:_setToPos(slot0._trscard, uv0.ZeroPos)
	slot0:_setToPos(slot1._trscard, uv0.ZeroPos)
	transformhelper.setLocalRotation(slot0._trscard, 0, 0, slot0.orignRoteZ)
	slot0:_setDragEnabled(true)
	gohelper.setAsLastSibling(slot0.parent._cardItem1.go)

	slot2, slot3 = slot1:getEquipId()
	slot6, slot7 = slot0:getEquipId()

	Activity104EquipController.instance:exchangeEquip(slot0.id - 1, slot0.slot, slot7, slot1.id - 1, slot1.slot, slot3, Activity104Model.instance:getSeasonCurSnapshotSubId())
end

function slot0.killTweenId(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if slot0.rotaTweenId then
		ZProj.TweenHelper.KillById(slot0.rotaTweenId)

		slot0.rotaTweenId = nil
	end

	if slot0.moveTweenId then
		ZProj.TweenHelper.KillById(slot0.moveTweenId)

		slot0.moveTweenId = nil
	end

	if slot0.posTweenId then
		ZProj.TweenHelper.KillById(slot0.posTweenId)

		slot0.posTweenId = nil
	end
end

function slot0.destory(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0:killTweenId()
	slot0:__onDispose()
end

return slot0
