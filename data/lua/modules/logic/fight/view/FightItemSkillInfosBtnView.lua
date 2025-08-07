module("modules.logic.fight.view.FightItemSkillInfosBtnView", package.seeall)

local var_0_0 = class("FightItemSkillInfosBtnView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "Root/bottomLeft/#btn_skill")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onClick)
	arg_2_0:com_registMsg(FightMsgId.CheckGuideFightItemPlayerSkillGroup, arg_2_0.onCheckGuideFightItemPlayerSkillGroup)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onCheckGuideFightItemPlayerSkillGroup(arg_4_0)
	GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.FightItemPlayerSkillGroup)
end

function var_0_0.onClick(arg_5_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightItemSkillInfosView)
end

function var_0_0.onOpen(arg_6_0)
	return
end

return var_0_0
