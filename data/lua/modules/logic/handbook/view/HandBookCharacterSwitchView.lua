module("modules.logic.handbook.view.HandBookCharacterSwitchView", package.seeall)

local var_0_0 = class("HandBookCharacterSwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagecentericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_centericon")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._gocharacterswitch = gohelper.findChild(arg_1_0.viewGO, "#go_characterswitch")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_line")
	arg_1_0._simageswitchbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg1")
	arg_1_0._simageswitchbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg2")
	arg_1_0._simageswitchbg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg3")
	arg_1_0._simageswitchbg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg4")
	arg_1_0._simageswitchbg5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg5")
	arg_1_0._simageswitchbg6 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg6")
	arg_1_0._btncharacter1 = gohelper.findChildClick(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg1/clickarea")
	arg_1_0._btncharacter2 = gohelper.findChildClick(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg2/clickarea")
	arg_1_0._btncharacter3 = gohelper.findChildClick(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg3/clickarea")
	arg_1_0._btncharacter4 = gohelper.findChildClick(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg4/clickarea")
	arg_1_0._btncharacter5 = gohelper.findChildClick(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg5/clickarea")
	arg_1_0._btncharacter6 = gohelper.findChildClick(arg_1_0.viewGO, "#go_characterswitch/#simage_switchbg6/clickarea")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btncollection = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_characterswitch/#btn_collection")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncharacter1:AddClickListener(arg_2_0._btncharacter1OnClick, arg_2_0)
	arg_2_0._btncharacter2:AddClickListener(arg_2_0._btncharacter2OnClick, arg_2_0)
	arg_2_0._btncharacter3:AddClickListener(arg_2_0._btncharacter3OnClick, arg_2_0)
	arg_2_0._btncharacter4:AddClickListener(arg_2_0._btncharacter4OnClick, arg_2_0)
	arg_2_0._btncharacter5:AddClickListener(arg_2_0._btncharacter5OnClick, arg_2_0)
	arg_2_0._btncharacter6:AddClickListener(arg_2_0._btncharacter6OnClick, arg_2_0)
	arg_2_0._btncollection:AddClickListener(arg_2_0._btncollectionOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncharacter1:RemoveClickListener()
	arg_3_0._btncharacter2:RemoveClickListener()
	arg_3_0._btncharacter3:RemoveClickListener()
	arg_3_0._btncharacter4:RemoveClickListener()
	arg_3_0._btncharacter5:RemoveClickListener()
	arg_3_0._btncharacter6:RemoveClickListener()
	arg_3_0._btncollection:RemoveClickListener()
end

function var_0_0._btncollectionOnClick(arg_4_0)
	arg_4_0:_openSubCharacterView(HandbookEnum.HeroType.AllHero)
end

function var_0_0._btncharacter1OnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	arg_5_0:_openSubCharacterView(3)
end

function var_0_0._btncharacter2OnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	arg_6_0:_openSubCharacterView(2)
end

function var_0_0._btncharacter3OnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	arg_7_0:_openSubCharacterView(1)
end

function var_0_0._btncharacter4OnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	arg_8_0:_openSubCharacterView(5)
end

function var_0_0._btncharacter5OnClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	arg_9_0:_openSubCharacterView(4)
end

function var_0_0._btncharacter6OnClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	arg_10_0:_openSubCharacterView(6)
end

function var_0_0._openSubCharacterView(arg_11_0, arg_11_1)
	HandbookController.instance:dispatchEvent(HandbookController.EventName.OnShowSubCharacterView, arg_11_1)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_12_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	arg_12_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_12_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_12_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_12_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_12_0._simageline:LoadImage(ResUrl.getHandbookCharacterIcon("line"))
	arg_12_0._simageswitchbg1:LoadImage(ResUrl.getHandbookCharacterImage("zz3"))
	arg_12_0._simageswitchbg2:LoadImage(ResUrl.getHandbookCharacterImage("zz1"))
	arg_12_0._simageswitchbg3:LoadImage(ResUrl.getHandbookCharacterImage("zz2"))
	arg_12_0._simageswitchbg4:LoadImage(ResUrl.getHandbookCharacterImage("zz4"))
	arg_12_0._simageswitchbg5:LoadImage(ResUrl.getHandbookCharacterImage("zz5"))
	arg_12_0._simageswitchbg6:LoadImage(ResUrl.getHandbookCharacterImage("zz6"))
end

function var_0_0._playViewOpenAnim(arg_13_0)
	arg_13_0._anim:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:addEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, arg_15_0._playViewOpenAnim, arg_15_0)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()
	arg_17_0._simagecentericon:UnLoadImage()
	arg_17_0._simagelefticon:UnLoadImage()
	arg_17_0._simagerighticon:UnLoadImage()
	arg_17_0._simagerighticon2:UnLoadImage()
	arg_17_0._simagemask:UnLoadImage()
	arg_17_0._simageline:UnLoadImage()
	arg_17_0._simageswitchbg1:UnLoadImage()
	arg_17_0._simageswitchbg2:UnLoadImage()
	arg_17_0._simageswitchbg3:UnLoadImage()
	arg_17_0._simageswitchbg4:UnLoadImage()
	arg_17_0._simageswitchbg5:UnLoadImage()
	arg_17_0._simageswitchbg6:UnLoadImage()
	arg_17_0:removeEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, arg_17_0._playViewOpenAnim, arg_17_0)
end

return var_0_0
