module("modules.logic.fight.view.FightInspirationView", package.seeall)

slot0 = class("FightInspirationView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._godesc1 = gohelper.findChild(slot0.viewGO, "#go_desc1")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_desc1/#simage_icon1")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_desc1/#simage_icon2")
	slot0._godesc2 = gohelper.findChild(slot0.viewGO, "#go_desc2")
	slot0._imagecareer4 = gohelper.findChildImage(slot0.viewGO, "#go_desc2/careers/#image_career4")
	slot0._imagecareer3 = gohelper.findChildImage(slot0.viewGO, "#go_desc2/careers/#image_career3")
	slot0._imagecareer2 = gohelper.findChildImage(slot0.viewGO, "#go_desc2/careers/#image_career2")
	slot0._imagecareer1 = gohelper.findChildImage(slot0.viewGO, "#go_desc2/careers/#image_career1")
	slot0._imagecareer6 = gohelper.findChildImage(slot0.viewGO, "#go_desc2/careers/#image_career6")
	slot0._imagecareer5 = gohelper.findChildImage(slot0.viewGO, "#go_desc2/careers/#image_career5")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._change then
		slot0:closeThis()

		return
	end

	gohelper.setActive(slot0._godesc1, false)
	gohelper.setActive(slot0._godesc2, true)

	slot0._change = true
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._godesc1, true)
	gohelper.setActive(slot0._godesc2, false)
	slot0._simagebg:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_tanchuang") .. ".png")
	slot0._simageicon1:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_kezhi") .. ".png")
	slot0._simageicon2:LoadImage(ResUrl.getFightIcon("bg_zhandouyindao_beike") .. ".png")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer1, "lssx_1")
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer2, "lssx_2")
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer3, "lssx_3")
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer4, "lssx_4")
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer5, "lssx_5")
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer6, "lssx_6")

	slot0._change = false
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageicon1:UnLoadImage()
	slot0._simageicon2:UnLoadImage()
end

return slot0
