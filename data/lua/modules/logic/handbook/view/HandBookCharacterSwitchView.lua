module("modules.logic.handbook.view.HandBookCharacterSwitchView", package.seeall)

slot0 = class("HandBookCharacterSwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagecentericon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_centericon")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._gocharacterswitch = gohelper.findChild(slot0.viewGO, "#go_characterswitch")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_line")
	slot0._simageswitchbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_characterswitch/#simage_switchbg1")
	slot0._simageswitchbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_characterswitch/#simage_switchbg2")
	slot0._simageswitchbg3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_characterswitch/#simage_switchbg3")
	slot0._simageswitchbg4 = gohelper.findChildSingleImage(slot0.viewGO, "#go_characterswitch/#simage_switchbg4")
	slot0._simageswitchbg5 = gohelper.findChildSingleImage(slot0.viewGO, "#go_characterswitch/#simage_switchbg5")
	slot0._simageswitchbg6 = gohelper.findChildSingleImage(slot0.viewGO, "#go_characterswitch/#simage_switchbg6")
	slot0._btncharacter1 = gohelper.findChildClick(slot0.viewGO, "#go_characterswitch/#simage_switchbg1/clickarea")
	slot0._btncharacter2 = gohelper.findChildClick(slot0.viewGO, "#go_characterswitch/#simage_switchbg2/clickarea")
	slot0._btncharacter3 = gohelper.findChildClick(slot0.viewGO, "#go_characterswitch/#simage_switchbg3/clickarea")
	slot0._btncharacter4 = gohelper.findChildClick(slot0.viewGO, "#go_characterswitch/#simage_switchbg4/clickarea")
	slot0._btncharacter5 = gohelper.findChildClick(slot0.viewGO, "#go_characterswitch/#simage_switchbg5/clickarea")
	slot0._btncharacter6 = gohelper.findChildClick(slot0.viewGO, "#go_characterswitch/#simage_switchbg6/clickarea")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._btncollection = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_characterswitch/#btn_collection")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncharacter1:AddClickListener(slot0._btncharacter1OnClick, slot0)
	slot0._btncharacter2:AddClickListener(slot0._btncharacter2OnClick, slot0)
	slot0._btncharacter3:AddClickListener(slot0._btncharacter3OnClick, slot0)
	slot0._btncharacter4:AddClickListener(slot0._btncharacter4OnClick, slot0)
	slot0._btncharacter5:AddClickListener(slot0._btncharacter5OnClick, slot0)
	slot0._btncharacter6:AddClickListener(slot0._btncharacter6OnClick, slot0)
	slot0._btncollection:AddClickListener(slot0._btncollectionOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncharacter1:RemoveClickListener()
	slot0._btncharacter2:RemoveClickListener()
	slot0._btncharacter3:RemoveClickListener()
	slot0._btncharacter4:RemoveClickListener()
	slot0._btncharacter5:RemoveClickListener()
	slot0._btncharacter6:RemoveClickListener()
	slot0._btncollection:RemoveClickListener()
end

function slot0._btncollectionOnClick(slot0)
	slot0:_openSubCharacterView(HandbookEnum.HeroType.AllHero)
end

function slot0._btncharacter1OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	slot0:_openSubCharacterView(3)
end

function slot0._btncharacter2OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	slot0:_openSubCharacterView(2)
end

function slot0._btncharacter3OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	slot0:_openSubCharacterView(1)
end

function slot0._btncharacter4OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	slot0:_openSubCharacterView(5)
end

function slot0._btncharacter5OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	slot0:_openSubCharacterView(4)
end

function slot0._btncharacter6OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_notice_open)
	slot0:_openSubCharacterView(6)
end

function slot0._openSubCharacterView(slot0, slot1)
	HandbookController.instance:dispatchEvent(HandbookController.EventName.OnShowSubCharacterView, slot1)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_2_ciecle.png"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	slot0._simageline:LoadImage(ResUrl.getHandbookCharacterIcon("line"))
	slot0._simageswitchbg1:LoadImage(ResUrl.getHandbookCharacterImage("zz3"))
	slot0._simageswitchbg2:LoadImage(ResUrl.getHandbookCharacterImage("zz1"))
	slot0._simageswitchbg3:LoadImage(ResUrl.getHandbookCharacterImage("zz2"))
	slot0._simageswitchbg4:LoadImage(ResUrl.getHandbookCharacterImage("zz4"))
	slot0._simageswitchbg5:LoadImage(ResUrl.getHandbookCharacterImage("zz5"))
	slot0._simageswitchbg6:LoadImage(ResUrl.getHandbookCharacterImage("zz6"))
end

function slot0._playViewOpenAnim(slot0)
	slot0._anim:Play(UIAnimationName.Open, 0, 0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, slot0._playViewOpenAnim, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagecentericon:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simageswitchbg1:UnLoadImage()
	slot0._simageswitchbg2:UnLoadImage()
	slot0._simageswitchbg3:UnLoadImage()
	slot0._simageswitchbg4:UnLoadImage()
	slot0._simageswitchbg5:UnLoadImage()
	slot0._simageswitchbg6:UnLoadImage()
	slot0:removeEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchOpenAnim, slot0._playViewOpenAnim, slot0)
end

return slot0
