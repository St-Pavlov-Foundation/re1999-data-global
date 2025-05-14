module("modules.logic.investigate.view.InvestigateView", package.seeall)

local var_0_0 = class("InvestigateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Bg/#simage_fullbg1")
	arg_1_0._imagetitle = gohelper.findChildImage(arg_1_0.viewGO, "root/Bg/#image_title")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "root/Role/#go_role1")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Role/#go_role1/#simage_bg")
	arg_1_0._gorole2 = gohelper.findChild(arg_1_0.viewGO, "root/Role/#go_role2")
	arg_1_0._gorole3 = gohelper.findChild(arg_1_0.viewGO, "root/Role/#go_role3")
	arg_1_0._gorole4 = gohelper.findChild(arg_1_0.viewGO, "root/Role/#go_role4")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_reward")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	InvestigateController.instance:openInvestigateTaskView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:_initRoles()

	arg_5_0._animator = gohelper.findChild(arg_5_0.viewGO, "root/#btn_reward/ani"):GetComponent("Animator")
	arg_5_0._goreddot = gohelper.findChild(arg_5_0.viewGO, "root/#btn_reward/reddot")

	gohelper.setActive(arg_5_0._goreddot, true)
	RedDotController.instance:addRedDot(arg_5_0._goreddot, RedDotEnum.DotNode.InvestigateTask, nil, arg_5_0._refreshReddot, arg_5_0)
end

function var_0_0._refreshReddot(arg_6_0, arg_6_1)
	arg_6_1:defaultRefreshDot()

	local var_6_0 = arg_6_1.show

	arg_6_0._animator:Play(var_6_0 and "loop" or "idle", 0, 0)
end

function var_0_0._initRoles(arg_7_0)
	local var_7_0 = InvestigateConfig.instance:getRoleEntranceInfos()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0["_gorole" .. iter_7_0]
		local var_7_2 = InvestigateConfig.instance:getRoleGroupInfoList(iter_7_1.group)

		if #var_7_2 > 1 then
			MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, InvestigateRoleMultiItem):onUpdateMO(var_7_2)
		else
			MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, InvestigateRoleItem):onUpdateMO(var_7_2[1])
		end
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_mln_day_night)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
