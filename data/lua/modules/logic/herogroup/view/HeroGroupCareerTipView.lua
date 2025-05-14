module("modules.logic.herogroup.view.HeroGroupCareerTipView", package.seeall)

local var_0_0 = class("HeroGroupCareerTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnmask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_mask")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._imagecareer1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/container/#image_career1")
	arg_1_0._imagecareer2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/container/#image_career2")
	arg_1_0._imagecareer3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/container/#image_career3")
	arg_1_0._imagecareer4 = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/container/#image_career4")
	arg_1_0._imagecareer5 = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/restrain2/#image_career5")
	arg_1_0._imagecareer6 = gohelper.findChildImage(arg_1_0.viewGO, "#go_bg/restrain2/#image_career6")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmask:AddClickListener(arg_2_0._btnmaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmask:RemoveClickListener()
end

function var_0_0._btnmaskOnClick(arg_4_0)
	if arg_4_0._closing then
		return
	end

	if not arg_4_0._isGuide then
		arg_4_0:closeThis()

		return
	end

	local var_4_0 = "UIRoot/HUD/FightView/root/btnRestraintInfo"
	local var_4_1 = gohelper.find(var_4_0)

	if not var_4_1 then
		arg_4_0:closeThis()

		return
	end

	arg_4_0:_clearTween()

	arg_4_0._closing = true

	local var_4_2 = 0.5
	local var_4_3 = recthelper.rectToRelativeAnchorPos(var_4_1.transform.position, arg_4_0.viewGO.transform)

	arg_4_0._anchorPosId = ZProj.TweenHelper.DOAnchorPos(arg_4_0._gobg.transform, var_4_3.x, var_4_3.y, var_4_2, function()
		gohelper.setActive(var_4_1, true)
		ViewMgr.instance:closeView(arg_4_0.viewName, true)
	end, nil)

	local var_4_4 = 0.2

	arg_4_0._scaleId = ZProj.TweenHelper.DOScale(arg_4_0._gobg.transform, var_4_4, var_4_4, var_4_4, var_4_2)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._fightBlurMask = gohelper.findChild(arg_6_0.viewGO, "#go_bg/uiblurmask_infightscene")
	arg_6_0._normalBlurMask = gohelper.findChild(arg_6_0.viewGO, "#go_bg/uiblurmask")
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer1, "lssx_1")
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer2, "lssx_2")
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer3, "lssx_3")
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer4, "lssx_4")
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer5, "lssx_5")
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer6, "lssx_6")
	arg_8_0:_onGuide()

	local var_8_0 = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(arg_8_0._fightBlurMask, var_8_0 == SceneType.Fight)
	gohelper.setActive(arg_8_0._normalBlurMask, var_8_0 ~= SceneType.Fight)
end

function var_0_0._onGuide(arg_9_0)
	if arg_9_0.viewParam then
		arg_9_0._isGuide = arg_9_0.viewParam.isGuide
	end

	if not arg_9_0._isGuide then
		return
	end

	recthelper.setAnchorX(arg_9_0._gobg.transform, -220)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:_clearTween()
end

function var_0_0._clearTween(arg_11_0)
	if arg_11_0._anchorPosId then
		ZProj.TweenHelper.KillById(arg_11_0._anchorPosId)

		arg_11_0._anchorPosId = nil
	end

	if arg_11_0._scaleId then
		ZProj.TweenHelper.KillById(arg_11_0._scaleId)

		arg_11_0._scaleId = nil
	end
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
