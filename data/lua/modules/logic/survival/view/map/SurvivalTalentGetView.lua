module("modules.logic.survival.view.map.SurvivalTalentGetView", package.seeall)

local var_0_0 = class("SurvivalTalentGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_close")
	arg_1_0._imageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Reward/#image_reward")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Reward/#txt_name")
	arg_1_0._txtskill = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Reward/#txt_skill")
	arg_1_0._txtdec = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Reward/#txt_dec")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_skip")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0.onClickSkip, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_ask)

	arg_4_0._curIndex = 0

	arg_4_0:nextStep()
end

function var_0_0.onClickSkip(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.nextStep(arg_6_0)
	arg_6_0._curIndex = arg_6_0._curIndex + 1

	local var_6_0 = arg_6_0.viewParam.talents[arg_6_0._curIndex]
	local var_6_1 = lua_survival_talent.configDict[var_6_0]

	if not var_6_1 then
		arg_6_0:closeThis()

		return
	end

	local var_6_2 = var_6_1.groupId
	local var_6_3 = lua_survival_talent_group.configDict[var_6_2]

	if not var_6_3 then
		logError("没有天赋分支配置" .. tostring(var_6_2))

		return
	end

	arg_6_0._imageicon:LoadImage(ResUrl.getSurvivalTalentIcon(var_6_3.folder .. "/icon_tianfu_" .. var_6_1.pos))

	arg_6_0._txtname.text = var_6_1.name
	arg_6_0._txtskill.text = var_6_1.desc1
	arg_6_0._txtdec.text = var_6_1.desc2

	UIBlockHelper.instance:startBlock("SurvivalTalentGetView_onOpen", 0.2)
	gohelper.setActive(arg_6_0._btnSkip, arg_6_0._curIndex ~= #arg_6_0.viewParam.talents)

	if arg_6_0._curIndex ~= 1 then
		arg_6_0._anim:Play("open", 0, 0)
	end
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:nextStep()
end

return var_0_0
