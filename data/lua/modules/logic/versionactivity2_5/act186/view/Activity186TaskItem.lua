module("modules.logic.versionactivity2_5.act186.view.Activity186TaskItem", package.seeall)

slot0 = class("Activity186TaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.txtIndex = gohelper.findChildTextMesh(slot0.viewGO, "txtIndex")
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.viewGO, "txtDesc")
	slot0.goReward = gohelper.findChild(slot0.viewGO, "#go_reward")
	slot0.txtNum = gohelper.findChildTextMesh(slot0.goReward, "#txt_num")
	slot0.btnCanget = gohelper.findChildButtonWithAudio(slot0.goReward, "go_canget")
	slot0.goReceive = gohelper.findChild(slot0.goReward, "go_receive")
	slot0.btnJump = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnJump")
	slot0.goDoing = gohelper.findChild(slot0.viewGO, "goDoing")
	slot0.goLightBg = gohelper.findChild(slot0.goReward, "go_lightbg")
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.isOpen = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnCanget:AddClickListener(slot0.onClickBtnCanget, slot0)
	slot0.btnJump:AddClickListener(slot0.onClickBtnJump, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnCanget:RemoveClickListener()
	slot0.btnJump:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnCanget(slot0)
	if not slot0._mo then
		return
	end

	if not slot0._mo.canGetReward then
		return
	end

	if slot0._mo.isGlobalTask then
		TaskRpc.instance:sendFinishTaskRequest(slot0._mo.config.id)
	else
		Activity186Rpc.instance:sendFinishAct186TaskRequest(slot1.activityId, slot1.id)
	end
end

function slot0.onClickBtnJump(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.config.jumpId and slot2 ~= 0 then
		GameFacade.jump(slot2)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0.config = slot0._mo.config

	slot0:refreshDesc()
	slot0:refreshJump()
	slot0:refreshReward()

	if slot0.isOpen then
		slot0.anim:Play("open", 0, 0)
	else
		slot0.anim:Play("open", 0, 1)
	end

	slot0.isOpen = false
end

function slot0.refreshDesc(slot0)
	slot0.txtIndex.text = tostring(slot0._mo.index)
	slot0.txtDesc.text = string.format("%s\n(%s/%s)", slot0.config and slot0.config.desc or "", Activity173Controller.numberDisplay(slot0._mo.progress), Activity173Controller.numberDisplay(slot0.config and slot0.config.maxProgress or 0))
end

function slot0.refreshJump(slot0)
	slot1 = slot0._mo.canGetReward

	gohelper.setActive(slot0.btnCanget, slot1)
	gohelper.setActive(slot0.goLightBg, slot1)
	gohelper.setActive(slot0.goReceive, slot0._mo.hasGetBonus)

	slot5 = slot0._mo.config.jumpId and slot4 ~= 0 and not slot1 and not slot2

	gohelper.setActive(slot0.btnJump, slot5)
	gohelper.setActive(slot0.goDoing, not slot1 and not slot2 and not slot5)
end

function slot0.refreshReward(slot0)
	slot0.txtNum.text = string.format("×%s", (GameUtil.splitString2(slot0.config and slot0.config.bonus, true) or {})[1] and slot2[3] or 0)
end

function slot0.onDestroyView(slot0)
end

return slot0
