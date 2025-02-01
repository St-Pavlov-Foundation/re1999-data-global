module("modules.logic.investigate.view.InvestigateView", package.seeall)

slot0 = class("InvestigateView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/Bg/#simage_fullbg1")
	slot0._imagetitle = gohelper.findChildImage(slot0.viewGO, "root/Bg/#image_title")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "root/Role/#go_role1")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "root/Role/#go_role1/#simage_bg")
	slot0._gorole2 = gohelper.findChild(slot0.viewGO, "root/Role/#go_role2")
	slot0._gorole3 = gohelper.findChild(slot0.viewGO, "root/Role/#go_role3")
	slot0._gorole4 = gohelper.findChild(slot0.viewGO, "root/Role/#go_role4")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_reward")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
end

function slot0._btnrewardOnClick(slot0)
	InvestigateController.instance:openInvestigateTaskView()
end

function slot0._editableInitView(slot0)
	slot0:_initRoles()

	slot0._animator = gohelper.findChild(slot0.viewGO, "root/#btn_reward/ani"):GetComponent("Animator")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "root/#btn_reward/reddot")

	gohelper.setActive(slot0._goreddot, true)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.InvestigateTask, nil, slot0._refreshReddot, slot0)
end

function slot0._refreshReddot(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._animator:Play(slot1.show and "loop" or "idle", 0, 0)
end

function slot0._initRoles(slot0)
	for slot5, slot6 in ipairs(InvestigateConfig.instance:getRoleEntranceInfos()) do
		if #InvestigateConfig.instance:getRoleGroupInfoList(slot6.group) > 1 then
			MonoHelper.addNoUpdateLuaComOnceToGo(slot0["_gorole" .. slot5], InvestigateRoleMultiItem):onUpdateMO(slot8)
		else
			MonoHelper.addNoUpdateLuaComOnceToGo(slot7, InvestigateRoleItem):onUpdateMO(slot8[1])
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_mln_day_night)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
