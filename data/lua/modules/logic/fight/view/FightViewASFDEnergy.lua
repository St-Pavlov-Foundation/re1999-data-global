module("modules.logic.fight.view.FightViewASFDEnergy", package.seeall)

local var_0_0 = class("FightViewASFDEnergy", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goASFD = gohelper.findChild(arg_1_0.viewGO, "root/asfd_container")
	arg_1_0.txtASFDEnergy = gohelper.findChildText(arg_1_0.viewGO, "root/asfd_container/asfd_icon/#txt_Num")
	arg_1_0.goClick = gohelper.findChild(arg_1_0.viewGO, "root/asfd_container/asfd_icon/#click")
	arg_1_0.goFlyContainer = gohelper.findChild(arg_1_0.viewGO, "root/asfd_container/asfd_icon/#go_fly_container")
	arg_1_0.goFlyItem = gohelper.findChild(arg_1_0.viewGO, "root/asfd_container/asfd_icon/#go_fly_container/#go_fly_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.ASFD)

	gohelper.addChild(var_4_0, arg_4_0.goASFD)

	local var_4_1 = arg_4_0.goASFD:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(var_4_1, 0, 0)

	arg_4_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.goASFD)

	arg_4_0:_hideASFD()

	arg_4_0.flyItemList = {}

	table.insert(arg_4_0.flyItemList, arg_4_0:createFlyItem(arg_4_0.goFlyItem))
	gohelper.setActive(arg_4_0.goFlyItem, false)
	gohelper.setActive(arg_4_0.goClick, false)
	gohelper.setActive(arg_4_0.goFlyContainer, false)

	arg_4_0.rectFlyContainer = arg_4_0.goFlyContainer:GetComponent(gohelper.Type_RectTransform)

	arg_4_0:addEventCb(FightController.instance, FightEvent.ASFD_TeamEnergyChange, arg_4_0.onTeamEnergyChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_4_0.stageChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, arg_4_0.startAllocateCardEnergy, arg_4_0)

	arg_4_0.handCardView = arg_4_0.viewContainer.fightViewHandCard
	arg_4_0.tweenIdList = {}
end

var_0_0.FlyDuration = 0.3

function var_0_0.startAllocateCardEnergy(arg_5_0)
	local var_5_0 = FightDataHelper.handCardMgr.handCard

	tabletool.clear(arg_5_0.tweenIdList)

	arg_5_0.flyCount = 0
	arg_5_0.arrivedCount = 0
	arg_5_0.tempVector2 = arg_5_0.tempVector2 or Vector2()

	gohelper.setActive(arg_5_0.goFlyContainer, true)

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.energy and iter_5_1.energy > 0 then
			local var_5_1 = arg_5_0.handCardView:getHandCardItem(iter_5_0)

			if var_5_1 then
				arg_5_0.flyCount = arg_5_0.flyCount + 1

				local var_5_2, var_5_3 = var_5_1:getASFDScreenPos()

				arg_5_0.tempVector2:Set(var_5_2, var_5_3)

				local var_5_4, var_5_5 = recthelper.screenPosToAnchorPos2(arg_5_0.tempVector2, arg_5_0.rectFlyContainer)
				local var_5_6 = arg_5_0:getFlyItem(arg_5_0.flyCount)

				recthelper.setAnchor(var_5_6.rectTr, 0, 0)

				local var_5_7 = ZProj.TweenHelper.DOAnchorPos(var_5_6.rectTr, var_5_4, var_5_5, var_0_0.FlyDuration / FightModel.instance:getUISpeed(), arg_5_0.onFlyDone, arg_5_0)

				table.insert(arg_5_0.tweenIdList, var_5_7)
			end
		end
	end

	arg_5_0.animatorPlayer:Play("close", arg_5_0._hideASFD, arg_5_0)

	if arg_5_0.flyCount < 1 then
		FightController.instance:dispatchEvent(FightEvent.ASFD_AllocateCardEnergyDone)
	end
end

function var_0_0.onFlyDone(arg_6_0)
	arg_6_0.arrivedCount = arg_6_0.arrivedCount + 1

	if arg_6_0.arrivedCount < arg_6_0.flyCount then
		return
	end

	AudioMgr.instance:trigger(20248002)
	tabletool.clear(arg_6_0.tweenIdList)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.flyItemList) do
		arg_6_0:resetFlyItem(iter_6_1)
	end

	gohelper.setActive(arg_6_0.goFlyContainer, false)
	FightController.instance:dispatchEvent(FightEvent.ASFD_AllocateCardEnergyDone)
end

function var_0_0.onTeamEnergyChange(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 ~= FightEnum.EntitySide.MySide then
		return
	end

	if arg_7_3 <= 0 then
		return arg_7_0:showASFD()
	end

	AudioMgr.instance:trigger(20248001)

	if arg_7_0.goASFD.activeInHierarchy then
		arg_7_0:playClickAnim()
	else
		arg_7_0:showASFD()
	end

	arg_7_0.txtASFDEnergy.text = arg_7_3
end

function var_0_0.playClickAnim(arg_8_0)
	gohelper.setActive(arg_8_0.goClick, false)
	gohelper.setActive(arg_8_0.goClick, true)
end

function var_0_0.hideASFD(arg_9_0)
	if arg_9_0.goASFD.activeInHierarchy then
		gohelper.setActive(arg_9_0.goASFD, false)
		arg_9_0.animatorPlayer:Play("close", arg_9_0._hideASFD, arg_9_0)
	end
end

function var_0_0._hideASFD(arg_10_0)
	gohelper.setActive(arg_10_0.goASFD, false)
	FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, FightRightBottomElementEnum.Elements.ASFD)
end

function var_0_0.showASFD(arg_11_0)
	gohelper.setActive(arg_11_0.goASFD, true)
	FightController.instance:dispatchEvent(FightEvent.RightBottomElements_ShowElement, FightRightBottomElementEnum.Elements.ASFD)
end

function var_0_0.stageChange(arg_12_0)
	local var_12_0 = FightDataHelper.stageMgr:getCurStage()

	if var_12_0 ~= FightStageMgr.StageType.Enter and var_12_0 ~= FightStageMgr.StageType.Play then
		arg_12_0:hideASFD()
	end
end

function var_0_0.createFlyItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = arg_13_1
	var_13_0.rectTr = arg_13_1:GetComponent(gohelper.Type_RectTransform)

	return var_13_0
end

function var_0_0.getFlyItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.flyItemList[arg_14_1]

	if var_14_0 then
		gohelper.setActive(var_14_0.go, true)

		return var_14_0
	end

	local var_14_1 = gohelper.cloneInPlace(arg_14_0.goFlyItem)
	local var_14_2 = arg_14_0:createFlyItem(var_14_1)

	gohelper.setActive(var_14_2.go, true)
	table.insert(arg_14_0.flyItemList, var_14_2)

	return var_14_2
end

function var_0_0.resetFlyItem(arg_15_0, arg_15_1)
	recthelper.setAnchor(arg_15_1.rectTr, 0, 0)
	gohelper.setActive(arg_15_1.go, false)
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:hideASFD()
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.tweenIdList) do
		ZProj.TweenHelper.KillById(iter_17_1)
	end

	tabletool.clear(arg_17_0.tweenIdList)
end

return var_0_0
