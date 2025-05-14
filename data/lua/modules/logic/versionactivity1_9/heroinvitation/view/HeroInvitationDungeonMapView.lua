module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapView", package.seeall)

local var_0_0 = class("HeroInvitationDungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnInvitation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_invitation")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_invitation/reward/normal")
	arg_1_0._animTipsReward = arg_1_0.goNormal:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._goEffect = gohelper.findChild(arg_1_0.goNormal, "huan")
	arg_1_0.txtNormalTotal = gohelper.findChildTextMesh(arg_1_0.goNormal, "layout/#txt_Total")
	arg_1_0.txtNormalNum = gohelper.findChildTextMesh(arg_1_0.goNormal, "layout/#txt_Num")
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_invitation/reward/finished")
	arg_1_0.goRed = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_invitation/#go_reddot")
	arg_1_0.txtFinishTotal = gohelper.findChildTextMesh(arg_1_0.goFinish, "layout/#txt_Total")
	arg_1_0.txtFinishNum = gohelper.findChildTextMesh(arg_1_0.goFinish, "layout/#txt_Num")

	RedDotController.instance:addRedDot(arg_1_0.goRed, RedDotEnum.DotNode.HeroInvitationReward, 0, arg_1_0.refreshRed, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnInvitation, arg_2_0.onClickBtnInvitation, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.refreshInvitation, arg_2_0)
	arg_2_0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, arg_2_0.refreshInvitation, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnInvitation(arg_5_0)
	ViewMgr.instance:openView(ViewName.HeroInvitationView)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshView()
	TaskDispatcher.runDelay(arg_7_0._loadMap, arg_7_0, 0.1)
end

function var_0_0._loadMap(arg_8_0)
	local var_8_0 = DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
		var_8_0
	})
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0:refreshInvitation()
end

function var_0_0.refreshInvitation(arg_11_0)
	local var_11_0 = HeroInvitationModel.instance.finalReward

	gohelper.setActive(arg_11_0.goNormal, not var_11_0)
	gohelper.setActive(arg_11_0.goFinish, var_11_0)

	local var_11_1, var_11_2 = HeroInvitationModel.instance:getInvitationFinishCount()

	arg_11_0.txtNormalTotal.text = var_11_2
	arg_11_0.txtNormalNum.text = var_11_1
	arg_11_0.txtFinishTotal.text = var_11_2
	arg_11_0.txtFinishNum.text = var_11_1
end

function var_0_0.refreshRed(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_1:defaultRefreshDot()
		gohelper.setActive(arg_12_0._goEffect, arg_12_1.show)

		if arg_12_1.show then
			arg_12_0._animTipsReward:Play("btn_tipreward_loop")
		else
			arg_12_0._animTipsReward:Play("btn_tipreward")
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._loadMap, arg_13_0)
end

return var_0_0
