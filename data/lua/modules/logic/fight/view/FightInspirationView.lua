module("modules.logic.fight.view.FightInspirationView", package.seeall)

local var_0_0 = class("FightInspirationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._godesc1 = gohelper.findChild(arg_1_0.viewGO, "#go_desc1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_desc1/#simage_icon1")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_desc1/#simage_icon2")
	arg_1_0._godesc2 = gohelper.findChild(arg_1_0.viewGO, "#go_desc2")
	arg_1_0._imagecareer4 = gohelper.findChildImage(arg_1_0.viewGO, "#go_desc2/careers/#image_career4")
	arg_1_0._imagecareer3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_desc2/careers/#image_career3")
	arg_1_0._imagecareer2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_desc2/careers/#image_career2")
	arg_1_0._imagecareer1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_desc2/careers/#image_career1")
	arg_1_0._imagecareer6 = gohelper.findChildImage(arg_1_0.viewGO, "#go_desc2/careers/#image_career6")
	arg_1_0._imagecareer5 = gohelper.findChildImage(arg_1_0.viewGO, "#go_desc2/careers/#image_career5")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._change then
		arg_4_0:closeThis()

		return
	end

	gohelper.setActive(arg_4_0._godesc1, false)
	gohelper.setActive(arg_4_0._godesc2, true)

	arg_4_0._change = true
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._godesc1, true)
	gohelper.setActive(arg_5_0._godesc2, false)
	arg_5_0._simagebg:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_tanchuang") .. ".png")
	arg_5_0._simageicon1:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_kezhi") .. ".png")
	arg_5_0._simageicon2:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_beike") .. ".png")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer1, "lssx_1")
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer2, "lssx_2")
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer3, "lssx_3")
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer4, "lssx_4")
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer5, "lssx_5")
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer6, "lssx_6")

	arg_7_0._change = false
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simageicon1:UnLoadImage()
	arg_9_0._simageicon2:UnLoadImage()
end

return var_0_0
