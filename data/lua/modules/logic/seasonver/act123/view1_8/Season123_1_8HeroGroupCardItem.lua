module("modules.logic.seasonver.act123.view1_8.Season123_1_8HeroGroupCardItem", package.seeall)

slot0 = class("Season123_1_8HeroGroupCardItem", UserDataDispose)
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

function slot0.setData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._equipId = slot3
	slot0._equipUid = slot4
	slot0._layer = slot2 or Season123HeroGroupModel.instance.layer
	slot0.id = slot1.id
	slot0._hasUseSeasonEquipCard = false
	slot0.hasTrialEquip = slot5

	slot0:updateView()
end

function slot0.setActive(slot0, slot1)
	slot0.isActive = slot1
end

function slot0.updateView(slot0)
	if not Season123Model.instance:getActInfo(Season123HeroGroupModel.instance.activityId) then
		return
	end

	slot0.posUnlock = Season123HeroGroupModel.instance:isEquipCardPosUnlock(slot0.slot, slot0.id - 1)
	slot0.slotUnlock = Season123HeroGroupModel.instance:isSlotNeedShow(slot0.slot)

	if slot0.hasTrialEquip and slot0:getEquipId(slot1, slot2.heroGroupSnapshotSubId) == 0 then
		slot0.posUnlock = false
		slot0.slotUnlock = false
	end

	gohelper.setActive(slot0._gocardlock, not slot0.posUnlock)
	gohelper.setActive(slot0._gocardempty, slot0.posUnlock)
	gohelper.setActive(slot0.go, slot0.slotUnlock)

	if slot0.posUnlock then
		if slot0:getEquipId(slot1, slot3) ~= nil and slot4 ~= 0 then
			if not slot0._seasonCardItem then
				slot0._seasonCardItem = Season123_1_8CelebrityCardItem.New()

				slot0._seasonCardItem:init(slot0._gocardicon, slot4, {
					noClick = true
				})
			else
				gohelper.setActive(slot0._seasonCardItem.go, true)
				slot0._seasonCardItem:reset(slot4)
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
	slot1 = Season123HeroGroupModel.instance.activityId

	if Season123HeroGroupModel.instance:isContainGroupCardUnlockTweenPos(Season123Model.instance:getUnlockCardIndex(slot0.id - 1, slot0.slot)) then
		return
	end

	if not slot0._animcardempty then
		slot0._animcardempty = slot0._gocardempty:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._animcardempty:Play("lock")
	Season123HeroGroupModel.instance:saveGroupCardUnlockTweenPos(slot4)
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

	if not Season123Model.instance:getActInfo(slot1) then
		return
	end

	return Season123HeroGroupUtils.getHeroGroupEquipCardId(slot4, slot2 or slot4.heroGroupSnapshotSubId, slot0.slot, slot0.id - 1)
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

	if not Season123Model.instance:getActInfo(Season123HeroGroupModel.instance.activityId) then
		return
	end

	slot3 = slot2.heroGroupSnapshotSubId

	if not Season123HeroGroupModel.instance:isEquipCardPosUnlock(slot0.slot, slot0.id - 1) then
		GameFacade.showToast(ToastEnum.SeasonEquipSlotNotUnlock)

		return
	end

	Season123Controller.instance:openSeasonEquipView({
		group = slot3,
		actId = slot1,
		pos = slot0.id - 1,
		slot = slot0.slot or 1,
		layer = slot0._layer,
		stage = Season123HeroGroupModel.instance.stage
	})
end

function slot0.canDrag(slot0)
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
			for slot12 = 1, Season123EquipItemListModel.instance:getEquipMaxCount(slot6 - 1) do
				if slot7[string.format("_cardItem%s", slot12)] ~= slot0 then
					slot14 = slot13.trsRect

					if math.abs(recthelper.screenPosToAnchorPos(slot1, slot14).x) * 2 < recthelper.getWidth(slot14) and math.abs(slot15.y) * 2 < recthelper.getHeight(slot14) then
						return slot13
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

	if slot1.hasTrialEquip or slot0.hasTrialEquip then
		return false
	end

	if not slot1.isActive or not slot0.isActive then
		return false
	end

	slot3 = slot1.id - 1
	slot4 = slot1.slot
	slot5 = Season123Config.instance:getSeasonEquipCo(slot1:getEquipId())
	slot8 = slot0.slot
	slot9 = Season123Config.instance:getSeasonEquipCo(slot0:getEquipId())
	slot10 = Season123EquipItemListModel.instance:getEquipMaxCount(slot0.id - 1)

	if not Season123Model.instance:getActInfo(Season123HeroGroupModel.instance.activityId) then
		return
	end

	for slot17 = 1, slot10 do
		if slot17 ~= slot8 then
			slot19 = Season123Config.instance:getSeasonEquipCo(Season123HeroGroupUtils.getHeroGroupEquipCardId(slot12, slot12.heroGroupSnapshotSubId, slot17, slot7))

			if slot5 and slot19 and slot19.group == slot5.group and slot3 ~= slot7 then
				GameFacade.showToast(Season123_1_8EquipItem.Toast_Same_Card)

				return false
			end
		end

		if slot17 ~= slot4 then
			slot19 = Season123Config.instance:getSeasonEquipCo(Season123HeroGroupUtils.getHeroGroupEquipCardId(slot12, slot13, slot17, slot3))

			if slot9 and slot19 and slot19.group == slot9.group and slot3 ~= slot7 then
				GameFacade.showToast(Season123_1_8EquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	slot14, slot15 = Season123HeroGroupModel.instance:isCardPosLimit(slot2, slot7)
	slot16, slot17 = Season123HeroGroupModel.instance:isCardPosLimit(slot6, slot3)

	if slot14 or slot16 then
		if slot14 then
			GameFacade.showToast(Season123_1_8EquipItem.Toast_Pos_Wrong, slot15)
		end

		if slot16 then
			GameFacade.showToast(Season123_1_8EquipItem.Toast_Pos_Wrong, slot17)
		end

		return false
	end

	return true
end

function slot0.canMoveToPos(slot0, slot1)
	if not slot0:getEquipId() then
		return true
	else
		slot3, slot4 = Season123HeroGroupModel.instance:isCardPosLimit(slot2, slot1)

		return not Season123HeroGroupModel.instance:isCardPosLimit(slot2, slot1), slot4
	end
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
	slot4 = slot1.id - 1
	slot5 = slot1.slot
	slot6, slot7 = slot0:getEquipId()
	slot8 = slot0.id - 1
	slot9 = slot0.slot

	if not Season123Model.instance:getActInfo(Season123HeroGroupModel.instance.activityId) then
		return
	end

	Season123EquipController.instance:exchangeEquip(slot8, slot9, slot7, slot4, slot5, slot3, slot11.heroGroupSnapshotSubId)
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
