module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpSuccessView", package.seeall)

local var_0_0 = class("AssassinBuildingLevelUpSuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._simagebuildingicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_buildingicon")
	arg_1_0._goprops = gohelper.findChild(arg_1_0.viewGO, "root/#go_props")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_props/prop/#image_icon")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.buildingType
	local var_7_1 = AssassinOutsideModel.instance:getBuildingMo(var_7_0)

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_1:getLv()
	local var_7_3 = var_7_1:getConfig()
	local var_7_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassinbuildinglevelupsuccessview_tips"), var_7_2, var_7_3.desc)

	arg_7_0._txtdesc.text = var_7_4

	arg_7_0._simagebuildingicon:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. var_7_3.levelupPic))
	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_7_0._imageicon, var_7_3.itemIcon)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._simagebuildingicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
