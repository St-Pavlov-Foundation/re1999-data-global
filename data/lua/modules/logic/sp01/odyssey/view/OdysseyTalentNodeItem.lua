module("modules.logic.sp01.odyssey.view.OdysseyTalentNodeItem", package.seeall)

local var_0_0 = class("OdysseyTalentNodeItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0._goselect = gohelper.findChild(arg_2_0.go, "#go_select")
	arg_2_0._godark = gohelper.findChild(arg_2_0.go, "#go_dark")
	arg_2_0._imagedarkIcon = gohelper.findChildImage(arg_2_0.go, "#go_dark/#image_darkIcon")
	arg_2_0._golock = gohelper.findChild(arg_2_0.go, "#go_lock")
	arg_2_0._gocanlvup = gohelper.findChild(arg_2_0.go, "#go_canlvup")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_0.go, "#go_canlvup/#image_icon")
	arg_2_0._gomaxEffect = gohelper.findChild(arg_2_0.go, "#go_canlvup/#go_maxEffect")
	arg_2_0._gonum = gohelper.findChild(arg_2_0.go, "#go_canlvup/image_numbg")
	arg_2_0._txtnum = gohelper.findChildText(arg_2_0.go, "#go_canlvup/image_numbg/#txt_num")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_click")
	arg_2_0._golevelUpEffect = gohelper.findChild(arg_2_0.go, "#go_canlvup/vx_glow")
	arg_2_0._godarkbg = gohelper.findChild(arg_2_0.go, "#go_dark/image_talenticonbg")
	arg_2_0._golockbg = gohelper.findChild(arg_2_0.go, "#go_lock/image_talenticonbg")
	arg_2_0._gocanlvupbg = gohelper.findChild(arg_2_0.go, "#go_canlvup/image_talenticonbg")
	arg_2_0._canLvupEffect = gohelper.findChild(arg_2_0.go, "vx_canlvup")
	arg_2_0._lockAnimPlayer = SLFramework.AnimatorPlayer.Get(arg_2_0._golock)

	gohelper.setActive(arg_2_0._golevelUpEffect, false)
	gohelper.setActive(arg_2_0._canLvupEffect, false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
	OdysseyController.instance:registerCallback(OdysseyEvent.RefreshTalentNodeSelect, arg_3_0.refreshSelectState, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	OdysseyController.instance:unregisterCallback(OdysseyEvent.RefreshTalentNodeSelect, arg_4_0.refreshSelectState, arg_4_0)
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0.curSelectNodeId ~= arg_5_0.nodeId then
		OdysseyTalentModel.instance:setCurselectNodeId(arg_5_0.nodeId)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshTalentNodeSelect)
	end
end

function var_0_0.refreshNode(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.config = arg_6_1
	arg_6_0.nodeId = arg_6_1.nodeId
	arg_6_0.isTipNode = arg_6_2
	arg_6_0.talentMo = OdysseyTalentModel.instance:getTalentMo(arg_6_0.nodeId)
	arg_6_0.isUnlock, arg_6_0.unlockConditionData = OdysseyTalentModel.instance:checkTalentCanUnlock(arg_6_0.nodeId)
	arg_6_0.effectList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(arg_6_0.nodeId)

	arg_6_0:setAndPlayUnLockAnimState()
	gohelper.setActive(arg_6_0._gocanlvup, arg_6_0.isUnlock and arg_6_0.talentMo and arg_6_0.talentMo.level > 0)
	gohelper.setActive(arg_6_0._godark, not arg_6_0.talentMo or arg_6_0.talentMo.level == 0)
	gohelper.setActive(arg_6_0._gonum, #arg_6_0.effectList > 1)

	arg_6_0._txtnum.text = arg_6_0.talentMo and string.format("%s/%s", arg_6_0.talentMo.level, #arg_6_0.effectList) or ""

	gohelper.setActive(arg_6_0._gomaxEffect, arg_6_0.isUnlock and arg_6_0.talentMo and arg_6_0.talentMo.level == #arg_6_0.effectList and not arg_6_0.isTipNode)
	gohelper.setActive(arg_6_0._godarkbg, not arg_6_0.isTipNode)
	gohelper.setActive(arg_6_0._golockbg, not arg_6_0.isTipNode)
	gohelper.setActive(arg_6_0._gocanlvupbg, not arg_6_0.isTipNode)

	local var_6_0 = arg_6_0:checkCanConsume()
	local var_6_1 = arg_6_0.isUnlock and (not arg_6_0.talentMo or arg_6_0.talentMo and arg_6_0.talentMo.level > 0 and arg_6_0.talentMo.level < #arg_6_0.effectList) and var_6_0 and not arg_6_0.isTipNode

	gohelper.setActive(arg_6_0._canLvupEffect, var_6_1)
	arg_6_0:refreshSelectState()
	UISpriteSetMgr.instance:setSp01OdysseyTalentSprite(arg_6_0._imageicon, arg_6_0.config.icon)
	UISpriteSetMgr.instance:setSp01OdysseyTalentSprite(arg_6_0._imagedarkIcon, arg_6_0.config.icon)
end

function var_0_0.setAndPlayUnLockAnimState(arg_7_0)
	if arg_7_0.isTipNode then
		arg_7_0:hideLock()

		return
	end

	if arg_7_0.lastLockState == nil then
		gohelper.setActive(arg_7_0._golock, not arg_7_0.isUnlock and not arg_7_0.isTipNode)
	elseif arg_7_0.lastLockState ~= arg_7_0.isUnlock then
		if arg_7_0.isUnlock then
			gohelper.setActive(arg_7_0._golock, true)
			arg_7_0._lockAnimPlayer:Play("open", arg_7_0.hideLock, arg_7_0)
		else
			gohelper.setActive(arg_7_0._golock, true)
			arg_7_0._lockAnimPlayer:Play("idle", nil, arg_7_0)
		end
	end

	arg_7_0.lastLockState = arg_7_0.isUnlock
end

function var_0_0.hideLock(arg_8_0)
	gohelper.setActive(arg_8_0._golock, false)
end

function var_0_0.checkCanConsume(arg_9_0)
	local var_9_0 = OdysseyTalentModel.instance:getCurTalentPoint()
	local var_9_1 = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(arg_9_0.nodeId)
	local var_9_2 = (arg_9_0.talentMo and arg_9_0.talentMo.level or 0) + 1

	return var_9_2 <= #var_9_1 and var_9_0 >= var_9_1[var_9_2].consume
end

function var_0_0.refreshSelectState(arg_10_0)
	arg_10_0.curSelectNodeId = OdysseyTalentModel.instance:getCurSelectNodeId()

	gohelper.setActive(arg_10_0._goselect, arg_10_0.curSelectNodeId == arg_10_0.nodeId and not arg_10_0.isTipNode)
end

function var_0_0.hideBtn(arg_11_0)
	gohelper.setActive(arg_11_0._btnclick.gameObject, false)
end

function var_0_0.playLevelUpEffect(arg_12_0)
	if arg_12_0.isTipNode then
		gohelper.setActive(arg_12_0._golevelUpEffect, false)

		return
	end

	gohelper.setActive(arg_12_0._golevelUpEffect, false)
	gohelper.setActive(arg_12_0._golevelUpEffect, true)
end

function var_0_0.destroy(arg_13_0)
	arg_13_0:__onDispose()
end

return var_0_0
