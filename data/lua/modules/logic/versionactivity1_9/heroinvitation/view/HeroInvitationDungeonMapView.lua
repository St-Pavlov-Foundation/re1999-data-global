module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapView", package.seeall)

slot0 = class("HeroInvitationDungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnInvitation = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_invitation")
	slot0.goNormal = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_invitation/reward/normal")
	slot0._animTipsReward = slot0.goNormal:GetComponent(typeof(UnityEngine.Animation))
	slot0._goEffect = gohelper.findChild(slot0.goNormal, "huan")
	slot0.txtNormalTotal = gohelper.findChildTextMesh(slot0.goNormal, "layout/#txt_Total")
	slot0.txtNormalNum = gohelper.findChildTextMesh(slot0.goNormal, "layout/#txt_Num")
	slot0.goFinish = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_invitation/reward/finished")
	slot0.goRed = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_invitation/#go_reddot")
	slot0.txtFinishTotal = gohelper.findChildTextMesh(slot0.goFinish, "layout/#txt_Total")
	slot0.txtFinishNum = gohelper.findChildTextMesh(slot0.goFinish, "layout/#txt_Num")

	RedDotController.instance:addRedDot(slot0.goRed, RedDotEnum.DotNode.HeroInvitationReward, 0, slot0.refreshRed, slot0)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnInvitation, slot0.onClickBtnInvitation, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.refreshInvitation, slot0)
	slot0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, slot0.refreshInvitation, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnInvitation(slot0)
	ViewMgr.instance:openView(ViewName.HeroInvitationView)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshView()
	TaskDispatcher.runDelay(slot0._loadMap, slot0, 0.1)
end

function slot0._loadMap(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
		DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)
	})
end

function slot0.onClose(slot0)
end

function slot0.refreshView(slot0)
	slot0:refreshInvitation()
end

function slot0.refreshInvitation(slot0)
	slot1 = HeroInvitationModel.instance.finalReward

	gohelper.setActive(slot0.goNormal, not slot1)
	gohelper.setActive(slot0.goFinish, slot1)

	slot2, slot3 = HeroInvitationModel.instance:getInvitationFinishCount()
	slot0.txtNormalTotal.text = slot3
	slot0.txtNormalNum.text = slot2
	slot0.txtFinishTotal.text = slot3
	slot0.txtFinishNum.text = slot2
end

function slot0.refreshRed(slot0, slot1)
	if slot1 then
		slot1:defaultRefreshDot()
		gohelper.setActive(slot0._goEffect, slot1.show)

		if slot1.show then
			slot0._animTipsReward:Play("btn_tipreward_loop")
		else
			slot0._animTipsReward:Play("btn_tipreward")
		end
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._loadMap, slot0)
end

return slot0
