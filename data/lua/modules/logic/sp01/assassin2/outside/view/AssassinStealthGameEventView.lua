module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEventView", package.seeall)

local var_0_0 = class("AssassinStealthGameEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_icon")
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/name/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/eff/txt_desc")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._dirGOList = arg_5_0:getUserDataTb_()
	arg_5_0._dirGOList[#arg_5_0._dirGOList + 1] = gohelper.findChild(arg_5_0.viewGO, "root/moveDir/Dir/up/#go_upLight")
	arg_5_0._dirGOList[#arg_5_0._dirGOList + 1] = gohelper.findChild(arg_5_0.viewGO, "root/moveDir/Dir/down/#go_downLigth")
	arg_5_0._dirGOList[#arg_5_0._dirGOList + 1] = gohelper.findChild(arg_5_0.viewGO, "root/moveDir/Dir/left/#go_leftLight")
	arg_5_0._dirGOList[#arg_5_0._dirGOList + 1] = gohelper.findChild(arg_5_0.viewGO, "root/moveDir/Dir/right/#go_rightLight")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = AssassinStealthGameModel.instance:getEventId()
	local var_7_1 = AssassinConfig.instance:getEventImg(var_7_0)

	if not string.nilorempty(var_7_1) then
		local var_7_2 = ResUrl.getSp01AssassinSingleBg("stealth/" .. var_7_1)

		arg_7_0._simageicon:LoadImage(var_7_2)
	end

	local var_7_3 = AssassinConfig.instance:getEventName(var_7_0)

	arg_7_0._txtname.text = var_7_3

	local var_7_4 = AssassinConfig.instance:getEventDesc(var_7_0)

	arg_7_0._txtdesc.text = var_7_4

	local var_7_5 = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._dirGOList) do
		gohelper.setActive(iter_7_1, iter_7_0 == var_7_5)
	end

	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_openmap)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simageicon:UnLoadImage()
end

return var_0_0
