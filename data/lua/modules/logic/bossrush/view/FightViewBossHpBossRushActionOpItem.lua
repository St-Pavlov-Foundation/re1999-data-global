module("modules.logic.bossrush.view.FightViewBossHpBossRushActionOpItem", package.seeall)

local var_0_0 = class("FightViewBossHpBossRushActionOpItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ForbidBossRushHpChannelSkillOpItem, arg_2_0._onForbidBossRushHpChannelSkillOpItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0._onForbidBossRushHpChannelSkillOpItem(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._data then
		arg_7_0:refreshUI(arg_7_0.viewGO, arg_7_1)
	end
end

function var_0_0.refreshUI(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.viewGO = arg_8_1
	arg_8_0._data = arg_8_2

	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "root/noAct")
	local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "root/act")
	local var_8_2 = arg_8_2.skillId

	gohelper.setActive(var_8_1, var_8_2 ~= 0)
	gohelper.setActive(var_8_0, var_8_2 == 0)

	if var_8_2 == 0 then
		return
	end

	local var_8_3 = gohelper.findChild(arg_8_0.viewGO, "root/act/round")
	local var_8_4 = gohelper.findChildText(arg_8_0.viewGO, "root/act/round/num")
	local var_8_5 = gohelper.findChild(arg_8_0.viewGO, "root/act/forbid")

	gohelper.setActive(var_8_5, arg_8_2.isChannelPosedSkill and arg_8_2.forbidden)
	gohelper.setActive(var_8_3, arg_8_2.isChannelSkill)

	var_8_4.text = arg_8_2.round or 0

	MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, FightOpItem):updateCardInfoMO({
		uid = arg_8_0:getParentView()._bossEntityMO.uid,
		skillId = arg_8_2.skillId
	})
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
