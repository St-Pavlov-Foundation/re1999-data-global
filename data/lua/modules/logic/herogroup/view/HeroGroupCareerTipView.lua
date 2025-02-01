module("modules.logic.herogroup.view.HeroGroupCareerTipView", package.seeall)

slot0 = class("HeroGroupCareerTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnmask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_mask")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._imagecareer1 = gohelper.findChildImage(slot0.viewGO, "#go_bg/container/#image_career1")
	slot0._imagecareer2 = gohelper.findChildImage(slot0.viewGO, "#go_bg/container/#image_career2")
	slot0._imagecareer3 = gohelper.findChildImage(slot0.viewGO, "#go_bg/container/#image_career3")
	slot0._imagecareer4 = gohelper.findChildImage(slot0.viewGO, "#go_bg/container/#image_career4")
	slot0._imagecareer5 = gohelper.findChildImage(slot0.viewGO, "#go_bg/restrain2/#image_career5")
	slot0._imagecareer6 = gohelper.findChildImage(slot0.viewGO, "#go_bg/restrain2/#image_career6")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmask:AddClickListener(slot0._btnmaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmask:RemoveClickListener()
end

function slot0._btnmaskOnClick(slot0)
	if slot0._closing then
		return
	end

	if not slot0._isGuide then
		slot0:closeThis()

		return
	end

	if not gohelper.find("UIRoot/HUD/FightView/root/btnRestraintInfo") then
		slot0:closeThis()

		return
	end

	slot0:_clearTween()

	slot0._closing = true
	slot3 = 0.5
	slot4 = recthelper.rectToRelativeAnchorPos(slot2.transform.position, slot0.viewGO.transform)
	slot0._anchorPosId = ZProj.TweenHelper.DOAnchorPos(slot0._gobg.transform, slot4.x, slot4.y, slot3, function ()
		gohelper.setActive(uv0, true)
		ViewMgr.instance:closeView(uv1.viewName, true)
	end, nil)
	slot5 = 0.2
	slot0._scaleId = ZProj.TweenHelper.DOScale(slot0._gobg.transform, slot5, slot5, slot5, slot3)
end

function slot0._editableInitView(slot0)
	slot0._fightBlurMask = gohelper.findChild(slot0.viewGO, "#go_bg/uiblurmask_infightscene")
	slot0._normalBlurMask = gohelper.findChild(slot0.viewGO, "#go_bg/uiblurmask")
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
	slot0:_onGuide()
	gohelper.setActive(slot0._fightBlurMask, GameSceneMgr.instance:getCurScene() == SceneType.Fight)
	gohelper.setActive(slot0._normalBlurMask, slot1 ~= SceneType.Fight)
end

function slot0._onGuide(slot0)
	if slot0.viewParam then
		slot0._isGuide = slot0.viewParam.isGuide
	end

	if not slot0._isGuide then
		return
	end

	recthelper.setAnchorX(slot0._gobg.transform, -220)
end

function slot0.onClose(slot0)
	slot0:_clearTween()
end

function slot0._clearTween(slot0)
	if slot0._anchorPosId then
		ZProj.TweenHelper.KillById(slot0._anchorPosId)

		slot0._anchorPosId = nil
	end

	if slot0._scaleId then
		ZProj.TweenHelper.KillById(slot0._scaleId)

		slot0._scaleId = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
