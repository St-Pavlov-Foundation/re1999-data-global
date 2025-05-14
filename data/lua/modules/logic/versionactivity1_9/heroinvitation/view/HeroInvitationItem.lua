module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationItem", package.seeall)

local var_0_0 = class("HeroInvitationItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLocked = gohelper.findChild(arg_1_0.viewGO, "Locked")
	arg_1_0.txtLocked = gohelper.findChildTextMesh(arg_1_0.viewGO, "Locked/txt_locked")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "Normal")
	arg_1_0.goNormalBg = gohelper.findChild(arg_1_0.goNormal, "NormalBg")
	arg_1_0.goSelectedBg = gohelper.findChild(arg_1_0.goNormal, "SelectedBg")
	arg_1_0.simageNormalRoleHead = gohelper.findChildSingleImage(arg_1_0.goNormalBg, "#simage_rolehead")
	arg_1_0.simageSelectRoleHead = gohelper.findChildSingleImage(arg_1_0.goSelectedBg, "#simage_rolehead")
	arg_1_0.btnGoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Normal/#btn_goto")
	arg_1_0.goIcon = gohelper.findChild(arg_1_0.viewGO, "Normal/#go_reward/#go_rewarditem/go_icon")
	arg_1_0.goCanGet = gohelper.findChild(arg_1_0.viewGO, "Normal/#go_reward/#go_rewarditem/go_canget")
	arg_1_0.goHasGet = gohelper.findChild(arg_1_0.viewGO, "Normal/#go_reward/#go_rewarditem/go_receive")
	arg_1_0.btnCanGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Normal/#go_reward/#go_rewarditem/go_canget")
	arg_1_0.goBg = gohelper.findChild(arg_1_0.viewGO, "Normal/bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnGoto, arg_2_0.onClickBtnGoto, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCanGet, arg_2_0.onClickBtnCanGet, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnCanGet(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	if HeroInvitationModel.instance:getInvitationState(arg_5_0._mo.id) == HeroInvitationEnum.InvitationState.CanGet then
		HeroInvitationRpc.instance:sendGainInviteRewardRequest(arg_5_0._mo.id)
	end
end

function var_0_0.onClickBtnGoto(arg_6_0)
	if not arg_6_0._mo then
		return
	end

	ViewMgr.instance:closeView(ViewName.HeroInvitationView)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, arg_6_0._mo.elementId)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	arg_7_0:refresHead()
	arg_7_0:refreshState()
end

function var_0_0.refresHead(arg_8_0)
	arg_8_0.simageNormalRoleHead:LoadImage(ResUrl.getHeadIconSmall(arg_8_0._mo.head))
	arg_8_0.simageSelectRoleHead:LoadImage(ResUrl.getHeadIconSmall(arg_8_0._mo.head))
end

function var_0_0.refreshState(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.refreshFrameTime, arg_9_0)

	local var_9_0 = HeroInvitationModel.instance:getInvitationState(arg_9_0._mo.id)
	local var_9_1 = var_9_0 == HeroInvitationEnum.InvitationState.TimeLocked or var_9_0 == HeroInvitationEnum.InvitationState.ElementLocked

	gohelper.setActive(arg_9_0.goLocked, var_9_1)
	gohelper.setActive(arg_9_0.goNormal, not var_9_1)
	gohelper.setActive(arg_9_0.goBg, var_9_0 == HeroInvitationEnum.InvitationState.Normal)
	gohelper.setActive(arg_9_0.goSelectedBg, var_9_0 == HeroInvitationEnum.InvitationState.Normal)
	gohelper.setActive(arg_9_0.goNormalBg, not var_9_1 and var_9_0 ~= HeroInvitationEnum.InvitationState.Normal)

	if var_9_0 == HeroInvitationEnum.InvitationState.ElementLocked then
		arg_9_0.txtLocked.text = luaLang("p_v1a9_invitationview_txt_dec2")
	elseif var_9_0 == HeroInvitationEnum.InvitationState.TimeLocked then
		arg_9_0:refreshFrameTime()
		TaskDispatcher.runRepeat(arg_9_0.refreshFrameTime, arg_9_0, 1)
	else
		local var_9_2 = GameUtil.splitString2(arg_9_0._mo.rewardDisplayList, true)[1]

		if not arg_9_0.itemIcon then
			arg_9_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_9_0.goIcon)
		end

		arg_9_0.itemIcon:setMOValue(var_9_2[1], var_9_2[2], var_9_2[3], nil, true)
		arg_9_0.itemIcon:setScale(0.6)
		arg_9_0.itemIcon:setCountTxtSize(36)
		gohelper.setActive(arg_9_0.goHasGet, var_9_0 == HeroInvitationEnum.InvitationState.Finish)
		gohelper.setActive(arg_9_0.goCanGet, var_9_0 == HeroInvitationEnum.InvitationState.CanGet)
	end
end

function var_0_0.refreshFrameTime(arg_10_0)
	if not arg_10_0._mo then
		return
	end

	local var_10_0 = HeroInvitationMo.stringToTimestamp(arg_10_0._mo.openTime) - ServerTime.now()

	if var_10_0 < 0 then
		arg_10_0:refreshState()

		return
	end

	local var_10_1 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_10_0))

	arg_10_0.txtLocked.text = formatLuaLang("test_task_unlock_time", var_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshFrameTime, arg_11_0)

	if arg_11_0.simageNormalRoleHead then
		arg_11_0.simageNormalRoleHead:UnLoadImage()
	end

	if arg_11_0.simageSelectRoleHead then
		arg_11_0.simageSelectRoleHead:UnLoadImage()
	end
end

return var_0_0
