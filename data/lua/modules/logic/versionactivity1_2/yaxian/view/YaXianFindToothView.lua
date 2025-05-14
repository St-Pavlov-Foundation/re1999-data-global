module("modules.logic.versionactivity1_2.yaxian.view.YaXianFindToothView", package.seeall)

local var_0_0 = class("YaXianFindToothView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "main/#txt_name")
	arg_1_0._txtunlockskill = gohelper.findChildText(arg_1_0.viewGO, "main/unlockbg/#txt_unlockskill")
	arg_1_0._txtup = gohelper.findChildText(arg_1_0.viewGO, "main/#txt_up/")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onFullClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getYaXianImage("img_huode_bg_2"))

	arg_5_0.fullClick = gohelper.getClick(arg_5_0._simagebg.gameObject)

	arg_5_0.fullClick:AddClickListener(arg_5_0.onFullClick, arg_5_0)

	arg_5_0.toothIcon = gohelper.findChildSingleImage(arg_5_0.viewGO, "main/iconbg/icon")
	arg_5_0.goUnlockSkill = gohelper.findChild(arg_5_0.viewGO, "main/unlockbg")
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:onOpen()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.toothId = arg_7_0.viewParam.toothId
	arg_7_0.toothConfig = YaXianConfig.instance:getToothConfig(arg_7_0.toothId)

	arg_7_0.toothIcon:LoadImage(ResUrl.getYaXianImage(arg_7_0.toothConfig.icon))

	arg_7_0._txtname.text = arg_7_0.toothConfig.name

	local var_7_0 = YaXianConfig.instance:getToothUnlockSkill(arg_7_0.toothId)

	gohelper.setActive(arg_7_0.goUnlockSkill, var_7_0)

	if var_7_0 then
		arg_7_0._txtunlockskill.text = luaLang("versionactivity_1_2_yaxian_unlock_skill_" .. var_7_0)
	end

	local var_7_1 = YaXianConfig.instance:getToothUnlockHeroTemplate(arg_7_0.toothId)
	local var_7_2 = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][var_7_1]
	local var_7_3 = HeroConfig.instance:getCommonLevelDisplay(var_7_2 and var_7_2.level or 0)

	arg_7_0._txtup.text = string.format(luaLang("versionactivity_1_2_yaxian_up_to_level"), var_7_3)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0.toothIcon:UnLoadImage()
	arg_9_0.fullClick:RemoveClickListener()
end

return var_0_0
