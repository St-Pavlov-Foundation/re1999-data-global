module("modules.logic.fight.view.FightViewASFDEnergy", package.seeall)

slot0 = class("FightViewASFDEnergy", BaseView)

function slot0.onInitView(slot0)
	slot0.goASFD = gohelper.findChild(slot0.viewGO, "root/asfd_icon")
	slot0.txtASFDEnergy = gohelper.findChildText(slot0.viewGO, "root/asfd_icon/#txt_Num")
	slot0.goClick = gohelper.findChild(slot0.viewGO, "root/asfd_icon/#click")
	slot0.goFlyContainer = gohelper.findChild(slot0.viewGO, "root/asfd_icon/#go_fly_container")
	slot0.goFlyItem = gohelper.findChild(slot0.viewGO, "root/asfd_icon/#go_fly_container/#go_fly_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.goASFD)

	slot0:_hideASFD()

	slot0.flyItemList = {}

	table.insert(slot0.flyItemList, slot0:createFlyItem(slot0.goFlyItem))
	gohelper.setActive(slot0.goFlyItem, false)
	gohelper.setActive(slot0.goClick, false)
	gohelper.setActive(slot0.goFlyContainer, false)

	slot0.rectFlyContainer = slot0.goFlyContainer:GetComponent(gohelper.Type_RectTransform)

	slot0:addEventCb(FightController.instance, FightEvent.ASFD_TeamEnergyChange, slot0.onTeamEnergyChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StageChanged, slot0.stageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, slot0.startAllocateCardEnergy, slot0)

	slot0.handCardView = slot0.viewContainer.fightViewHandCard
	slot0.tweenIdList = {}
end

slot0.FlyDuration = 0.3

function slot0.startAllocateCardEnergy(slot0)
	tabletool.clear(slot0.tweenIdList)

	slot0.flyCount = 0
	slot0.arrivedCount = 0
	slot0.tempVector2 = slot0.tempVector2 or Vector2()

	gohelper.setActive(slot0.goFlyContainer, true)

	for slot5, slot6 in ipairs(FightCardModel.instance:getHandCardData()) do
		if slot6.energy and slot6.energy > 0 and slot0.handCardView:getHandCardItem(slot5) then
			slot0.flyCount = slot0.flyCount + 1
			slot8, slot9 = slot7:getASFDScreenPos()

			slot0.tempVector2:Set(slot8, slot9)

			slot10, slot11 = recthelper.screenPosToAnchorPos2(slot0.tempVector2, slot0.rectFlyContainer)
			slot12 = slot0:getFlyItem(slot0.flyCount)

			recthelper.setAnchor(slot12.rectTr, 0, 0)
			table.insert(slot0.tweenIdList, ZProj.TweenHelper.DOAnchorPos(slot12.rectTr, slot10, slot11, uv0.FlyDuration, slot0.onFlyDone, slot0))
		end
	end

	slot0.animatorPlayer:Play("close", slot0._hideASFD, slot0)

	if slot0.flyCount < 1 then
		FightController.instance:dispatchEvent(FightEvent.ASFD_AllocateCardEnergyDone)
	end
end

function slot0.onFlyDone(slot0)
	slot0.arrivedCount = slot0.arrivedCount + 1

	if slot0.arrivedCount < slot0.flyCount then
		return
	end

	AudioMgr.instance:trigger(20248002)
	tabletool.clear(slot0.tweenIdList)

	for slot4, slot5 in ipairs(slot0.flyItemList) do
		slot0:resetFlyItem(slot5)
	end

	gohelper.setActive(slot0.goFlyContainer, false)
	FightController.instance:dispatchEvent(FightEvent.ASFD_AllocateCardEnergyDone)
end

function slot0.onTeamEnergyChange(slot0, slot1, slot2, slot3)
	if slot1 ~= FightEnum.EntitySide.MySide then
		return
	end

	if slot3 <= 0 then
		return slot0:showASFD()
	end

	AudioMgr.instance:trigger(20248001)

	if slot0.goASFD.activeInHierarchy then
		slot0:playClickAnim()
	else
		slot0:showASFD()
	end

	slot0.txtASFDEnergy.text = slot3
end

function slot0.playClickAnim(slot0)
	gohelper.setActive(slot0.goClick, false)
	gohelper.setActive(slot0.goClick, true)
end

function slot0.hideASFD(slot0)
	if slot0.goASFD.activeInHierarchy then
		gohelper.setActive(slot0.goASFD, false)
		slot0.animatorPlayer:Play("close", slot0._hideASFD, slot0)
	end
end

function slot0._hideASFD(slot0)
	gohelper.setActive(slot0.goASFD, false)
end

function slot0.showASFD(slot0)
	gohelper.setActive(slot0.goASFD, true)
end

function slot0.stageChange(slot0)
	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Enter and slot1 ~= FightStageMgr.StageType.Play then
		slot0:hideASFD()
	end
end

function slot0.createFlyItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.rectTr = slot1:GetComponent(gohelper.Type_RectTransform)

	return slot2
end

function slot0.getFlyItem(slot0, slot1)
	if slot0.flyItemList[slot1] then
		gohelper.setActive(slot2.go, true)

		return slot2
	end

	slot2 = slot0:createFlyItem(gohelper.cloneInPlace(slot0.goFlyItem))

	gohelper.setActive(slot2.go, true)
	table.insert(slot0.flyItemList, slot2)

	return slot2
end

function slot0.resetFlyItem(slot0, slot1)
	recthelper.setAnchor(slot1.rectTr, 0, 0)
	gohelper.setActive(slot1.go, false)
end

function slot0.onUpdateParam(slot0)
	slot0:hideASFD()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.tweenIdList) do
		ZProj.TweenHelper.KillById(slot5)
	end

	tabletool.clear(slot0.tweenIdList)
end

return slot0
