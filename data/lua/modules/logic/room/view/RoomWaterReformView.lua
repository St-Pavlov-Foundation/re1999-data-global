module("modules.logic.room.view.RoomWaterReformView", package.seeall)

slot0 = class("RoomWaterReformView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnsave = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_save")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_reset")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_bottom/#go_tip")
	slot0._goblockContent = gohelper.findChild(slot0.viewGO, "#go_bottom/#go_blockContent")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._contentAnimator = slot0._goblockContent:GetComponent(RoomEnum.ComponentType.Animator)
	slot0._contentAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._goblockContent)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsave:AddClickListener(slot0._btnsaveOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._waterReformShowChanged, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformSelectWaterChange, slot0.refreshSelectWater, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsave:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._waterReformShowChanged, slot0)
	slot0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformSelectWaterChange, slot0.refreshSelectWater, slot0)
end

function slot0._btnsaveOnClick(slot0)
	RoomWaterReformController.instance:saveReform()
end

function slot0._btnresetOnClick(slot0)
	if RoomWaterReformModel.instance:hasChangedWaterType() then
		GameFacade.showMessageBox(MessageBoxIdDefine.WaterReformResetConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._confirmReset, nil, , slot0)
	else
		GameFacade.showToast(ToastEnum.NoWaterReform)
	end
end

function slot0._confirmReset(slot0)
	RoomWaterReformController.instance:resetReform()
end

function slot0._waterReformShowChanged(slot0)
	if RoomWaterReformModel.instance:isWaterReform() then
		slot0._animatorPlayer:Play("open")
		slot0:refreshUI()
	else
		slot0._animatorPlayer:Play("close", slot0._showBackBlock, slot0)
	end
end

function slot0._showBackBlock(slot0)
	slot0.viewContainer:selectBlockOpTab(RoomEnum.RoomViewBlockOpMode.BackBlock)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.showWaterType = nil

	gohelper.setActive(slot0._gotip, false)
	slot0:refreshUI(true)
end

function slot0.refreshUI(slot0, slot1)
	slot0:refreshSelectWater(slot1)
end

function slot0.refreshSelectWater(slot0, slot1)
	RoomWaterReformListModel.instance:setSelectWaterType(RoomWaterReformListModel.instance:getDefaultSelectWaterType())

	slot3 = RoomWaterReformModel.instance:hasSelectWaterArea()

	if slot0.showWaterType ~= nil and slot0.showWaterType == slot3 then
		return
	end

	if slot3 then
		gohelper.setActive(slot0._gotip, false)
		slot0._contentAnimatorPlayer:Play("open")
	elseif slot1 then
		slot0:showTip()
		slot0._contentAnimator:Play("close", 0, 1)
	else
		slot0._contentAnimatorPlayer:Play("close", slot0.showTip, slot0)
	end

	slot0.showWaterType = slot3
end

function slot0.showTip(slot0)
	gohelper.setActive(slot0._gotip, true)
end

function slot0.onClose(slot0)
	slot0.showWaterType = nil
end

function slot0.onDestroyView(slot0)
end

return slot0
