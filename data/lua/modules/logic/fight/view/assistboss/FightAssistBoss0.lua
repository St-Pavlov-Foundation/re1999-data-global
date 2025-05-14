module("modules.logic.fight.view.assistboss.FightAssistBoss0", package.seeall)

local var_0_0 = class("FightAssistBoss0", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss0.prefab"
end

function var_0_0.initView(arg_2_0)
	arg_2_0.txtValue = gohelper.findChildText(arg_2_0.viewGo, "txt_value")
	arg_2_0.txtCD = gohelper.findChildText(arg_2_0.viewGo, "txt_cd")
	arg_2_0.goCDMask = gohelper.findChild(arg_2_0.viewGo, "go_cdmask")
	arg_2_0.click = gohelper.findChildClickWithDefaultAudio(arg_2_0.viewGo, "image")

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
end

function var_0_0.onClickSelf(arg_3_0)
	arg_3_0:playAssistBossCard()
end

function var_0_0.refreshPower(arg_4_0)
	var_0_0.super.refreshPower(arg_4_0)

	arg_4_0.txtValue.text = FightDataHelper.paTaMgr:getAssistBossPower()
end

function var_0_0.refreshCD(arg_5_0)
	local var_5_0 = FightDataHelper.paTaMgr:getCurCD()

	arg_5_0.txtCD.text = string.format("CD:%s", var_5_0)

	gohelper.setActive(arg_5_0.goCDMask, var_5_0 and var_5_0 > 0)
end

function var_0_0.destroy(arg_6_0)
	if arg_6_0.click then
		arg_6_0.click:RemoveClickListener()
	end

	var_0_0.super.destroy(arg_6_0)
end

return var_0_0
