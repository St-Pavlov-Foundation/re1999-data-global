module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardViewTaskItem", package.seeall)

slot0 = class("ArmRewardViewTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Root/#txt_Num")
	slot0._txtTaskDesc = gohelper.findChildText(slot0.viewGO, "Root/#txt_TaskDesc")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Root/#scroll_Rewards/Viewport/#gorewards")
	slot0._goclaimedBG = gohelper.findChild(slot0.viewGO, "Root/image_ClaimedBG")
	slot0._gocollecticon = gohelper.findChild(slot0.viewGO, "Root/#go_collecticon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gocollecticon, false)

	slot0._animator = slot0.viewGO:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._rewardMO = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshUI(slot0)
	if slot0._rewardMO and slot1.config then
		slot2 = slot1.config
		slot0._txtNum.text = slot0:_getNumStr(slot2.episodeId)
		slot0._txtTaskDesc.text = slot2.name
		slot3 = ItemModel.instance:getItemDataListByConfigStr(slot1.config.firstBonus)
		slot0.itemList = slot3
		slot0._isReceived = Activity124Model.instance:isReceived(slot2.activityId, slot2.episodeId)

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot3, slot0._gorewards)
		gohelper.setActive(slot0._goclaimedBG, slot0._isReceived)
	end
end

function slot0._getNumStr(slot0, slot1)
	if slot1 < 10 then
		return "0" .. slot1
	end

	return tostring(slot1)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)

	if not slot1._gocollecticon then
		slot1._gocollecticon = gohelper.clone(slot0._gocollecticon, slot1.viewGO)

		transformhelper.setLocalPos(slot1._gocollecticon.transform, 0, 0, 0)
	end

	gohelper.setActive(slot1._gocollecticon, slot0._isReceived)
end

slot0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armreward_taskitem.prefab"

return slot0
