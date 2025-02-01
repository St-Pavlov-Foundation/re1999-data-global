module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationItem", package.seeall)

slot0 = class("HeroInvitationItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goLocked = gohelper.findChild(slot0.viewGO, "Locked")
	slot0.txtLocked = gohelper.findChildTextMesh(slot0.viewGO, "Locked/txt_locked")
	slot0.goNormal = gohelper.findChild(slot0.viewGO, "Normal")
	slot0.goNormalBg = gohelper.findChild(slot0.goNormal, "NormalBg")
	slot0.goSelectedBg = gohelper.findChild(slot0.goNormal, "SelectedBg")
	slot0.simageNormalRoleHead = gohelper.findChildSingleImage(slot0.goNormalBg, "#simage_rolehead")
	slot0.simageSelectRoleHead = gohelper.findChildSingleImage(slot0.goSelectedBg, "#simage_rolehead")
	slot0.btnGoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "Normal/#btn_goto")
	slot0.goIcon = gohelper.findChild(slot0.viewGO, "Normal/#go_reward/#go_rewarditem/go_icon")
	slot0.goCanGet = gohelper.findChild(slot0.viewGO, "Normal/#go_reward/#go_rewarditem/go_canget")
	slot0.goHasGet = gohelper.findChild(slot0.viewGO, "Normal/#go_reward/#go_rewarditem/go_receive")
	slot0.btnCanGet = gohelper.findChildButtonWithAudio(slot0.viewGO, "Normal/#go_reward/#go_rewarditem/go_canget")
	slot0.goBg = gohelper.findChild(slot0.viewGO, "Normal/bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnGoto, slot0.onClickBtnGoto, slot0)
	slot0:addClickCb(slot0.btnCanGet, slot0.onClickBtnCanGet, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnCanGet(slot0)
	if not slot0._mo then
		return
	end

	if HeroInvitationModel.instance:getInvitationState(slot0._mo.id) == HeroInvitationEnum.InvitationState.CanGet then
		HeroInvitationRpc.instance:sendGainInviteRewardRequest(slot0._mo.id)
	end
end

function slot0.onClickBtnGoto(slot0)
	if not slot0._mo then
		return
	end

	ViewMgr.instance:closeView(ViewName.HeroInvitationView)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, slot0._mo.elementId)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refresHead()
	slot0:refreshState()
end

function slot0.refresHead(slot0)
	slot0.simageNormalRoleHead:LoadImage(ResUrl.getHeadIconSmall(slot0._mo.head))
	slot0.simageSelectRoleHead:LoadImage(ResUrl.getHeadIconSmall(slot0._mo.head))
end

function slot0.refreshState(slot0)
	TaskDispatcher.cancelTask(slot0.refreshFrameTime, slot0)

	slot2 = HeroInvitationModel.instance:getInvitationState(slot0._mo.id) == HeroInvitationEnum.InvitationState.TimeLocked or slot1 == HeroInvitationEnum.InvitationState.ElementLocked

	gohelper.setActive(slot0.goLocked, slot2)
	gohelper.setActive(slot0.goNormal, not slot2)
	gohelper.setActive(slot0.goBg, slot1 == HeroInvitationEnum.InvitationState.Normal)
	gohelper.setActive(slot0.goSelectedBg, slot1 == HeroInvitationEnum.InvitationState.Normal)
	gohelper.setActive(slot0.goNormalBg, not slot2 and slot1 ~= HeroInvitationEnum.InvitationState.Normal)

	if slot1 == HeroInvitationEnum.InvitationState.ElementLocked then
		slot0.txtLocked.text = luaLang("p_v1a9_invitationview_txt_dec2")
	elseif slot1 == HeroInvitationEnum.InvitationState.TimeLocked then
		slot0:refreshFrameTime()
		TaskDispatcher.runRepeat(slot0.refreshFrameTime, slot0, 1)
	else
		slot4 = GameUtil.splitString2(slot0._mo.rewardDisplayList, true)[1]

		if not slot0.itemIcon then
			slot0.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0.goIcon)
		end

		slot0.itemIcon:setMOValue(slot4[1], slot4[2], slot4[3], nil, true)
		slot0.itemIcon:setScale(0.6)
		slot0.itemIcon:setCountTxtSize(36)
		gohelper.setActive(slot0.goHasGet, slot1 == HeroInvitationEnum.InvitationState.Finish)
		gohelper.setActive(slot0.goCanGet, slot1 == HeroInvitationEnum.InvitationState.CanGet)
	end
end

function slot0.refreshFrameTime(slot0)
	if not slot0._mo then
		return
	end

	if HeroInvitationMo.stringToTimestamp(slot0._mo.openTime) - ServerTime.now() < 0 then
		slot0:refreshState()

		return
	end

	slot0.txtLocked.text = formatLuaLang("test_task_unlock_time", string.format("%s%s", TimeUtil.secondToRoughTime2(slot2)))
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshFrameTime, slot0)

	if slot0.simageNormalRoleHead then
		slot0.simageNormalRoleHead:UnLoadImage()
	end

	if slot0.simageSelectRoleHead then
		slot0.simageSelectRoleHead:UnLoadImage()
	end
end

return slot0
