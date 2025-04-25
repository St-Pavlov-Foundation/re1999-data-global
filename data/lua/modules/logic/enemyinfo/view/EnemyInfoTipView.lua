module("modules.logic.enemyinfo.view.EnemyInfoTipView", package.seeall)

slot0 = class("EnemyInfoTipView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gotipconatiner = gohelper.findChild(slot0.viewGO, "#go_tip_container")
	slot0._goruletip = gohelper.findChild(slot0.viewGO, "#go_tip_container/#go_ruletip")

	gohelper.setActive(slot0._goruletip, false)

	slot0._gobufftip = gohelper.findChild(slot0.viewGO, "#go_tip_container/#go_bufftip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickCloseTip(slot0)
	slot0.showTip = nil

	slot0:hideAllTip()
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.HideTip)
end

function slot0._editableInitView(slot0)
	slot0.closeTipClick = gohelper.findChildClickWithDefaultAudio(slot0._gotipconatiner, "#go_tipclose")

	slot0.closeTipClick:AddClickListener(slot0.onClickCloseTip, slot0)
	slot0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.ShowTip, slot0.onShowTip, slot0)
end

function slot0.onShowTip(slot0, slot1)
	gohelper.setActive(slot0._gotipconatiner, true)

	if slot0.showTip == slot1 then
		return
	end

	slot0.showTip = slot1

	gohelper.setActive(slot0._gobufftip, slot0.showTip == EnemyInfoEnum.Tip.BuffTip)
end

function slot0.hideAllTip(slot0)
	gohelper.setActive(slot0._gotipconatiner, false)
	gohelper.setActive(slot0._gobufftip, false)
end

function slot0.onOpen(slot0)
	slot0:hideAllTip()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.closeTipClick:RemoveClickListener()
end

return slot0
