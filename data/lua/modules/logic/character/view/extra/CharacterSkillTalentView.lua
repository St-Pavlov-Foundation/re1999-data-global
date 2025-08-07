module("modules.logic.character.view.extra.CharacterSkillTalentView", package.seeall)

local var_0_0 = class("CharacterSkillTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._txtremainTalentPoint = gohelper.findChildText(arg_1_0.viewGO, "talentpoint/#txt_remainTalentPoint")
	arg_1_0._txtremainTalentPointEffect = gohelper.findChildText(arg_1_0.viewGO, "talentpoint/#txt_effect")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_title")
	arg_1_0._imageTagIcon = gohelper.findChildImage(arg_1_0.viewGO, "bottom/#txt_title/#image_TagIcon")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "bottom/#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "bottom/#scroll_desc/Viewport/#txt_desc")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_2_0._refreshView, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, arg_2_0._refreshView, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_3_0._refreshView, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, arg_3_0._refreshView, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_3_0._refreshView, arg_3_0)
end

function var_0_0._btnresetOnClick(arg_4_0)
	if not arg_4_0.heroMo:isOwnHero() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.ResetTalentSkillTree, MsgBoxEnum.BoxType.Yes_No, arg_4_0.sendResetTalentTree, nil, nil, arg_4_0)
end

function var_0_0.sendResetTalentTree(arg_5_0)
	HeroRpc.instance:setResetHero3124TalentTreeRequest(arg_5_0.heroMo.heroId)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._gobottom = gohelper.findChild(arg_6_0.viewGO, "bottom")

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "talentpoint")

	arg_6_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO.gameObject)
	arg_6_0._talentPointAnim = var_6_0:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.heroMo = arg_8_0.viewParam
	arg_8_0.skillTalentMo = arg_8_0.heroMo.extraMo:getSkillTalentMo()
	arg_8_0._isOpen = true

	arg_8_0:_refreshView()
end

function var_0_0._refreshView(arg_9_0)
	local var_9_0 = arg_9_0.skillTalentMo:getMainFieldMo()

	arg_9_0:_refreshDetail(var_9_0)
	arg_9_0:_refreshNode()
end

function var_0_0._refreshNode(arg_10_0)
	if arg_10_0._talentpoint and arg_10_0._talentpoint ~= arg_10_0.skillTalentMo:getTalentpoint() then
		arg_10_0._talentPointAnim:Play(CharacterExtraEnum.SkillTreeAnimName.Click, 0, 0)
	end

	arg_10_0._talentpoint = arg_10_0.skillTalentMo:getTalentpoint()
	arg_10_0._txtremainTalentPoint.text = arg_10_0._talentpoint
	arg_10_0._txtremainTalentPointEffect.text = arg_10_0._talentpoint

	gohelper.setActive(arg_10_0._btnreset.gameObject, not arg_10_0.skillTalentMo:isNotLight())
end

function var_0_0._refreshDetail(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_1 then
		local var_11_1 = arg_11_0.heroMo.exSkillLevel
		local var_11_2 = arg_11_1.co
		local var_11_3 = var_11_2.sub
		local var_11_4 = arg_11_1:getFieldDesc(var_11_1)

		arg_11_0._txttitle.text = var_11_2.fieldName
		arg_11_0._fieldDesc = arg_11_0._fieldDesc or MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._txtdesc.gameObject, SkillDescComp)

		local var_11_5 = var_11_4 .. arg_11_0.skillTalentMo:getLightNodeAdditionalDesc(var_11_1)

		arg_11_0._fieldDesc:updateInfo(arg_11_0._txtdesc, var_11_5, arg_11_0.heroMo.heroId)
		arg_11_0._fieldDesc:setTipParam(nil, Vector2(250, -365))
		arg_11_0._fieldDesc:setBuffTipPivot(CommonBuffTipEnum.Pivot.Down)
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_11_0._imageTagIcon, arg_11_0.skillTalentMo:getSmallSubIconPath(var_11_3))

		if arg_11_0._isOpen then
			var_11_0 = CharacterExtraEnum.SkillTreeAnimName.OpenBottom
		elseif not arg_11_0.isShowBottom then
			var_11_0 = CharacterExtraEnum.SkillTreeAnimName.Bottom
		end

		arg_11_0.isShowBottom = true
	else
		if arg_11_0._isOpen then
			var_11_0 = CharacterExtraEnum.SkillTreeAnimName.OpenNomal
		elseif arg_11_0.isShowBottom then
			var_11_0 = CharacterExtraEnum.SkillTreeAnimName.Normal
		end

		arg_11_0.isShowBottom = false
	end

	if not string.nilorempty(var_11_0) then
		gohelper.setActive(arg_11_0._gobottom, true)
		arg_11_0._animPlayer:Play(var_11_0, arg_11_0._playAnimCallback, arg_11_0)
	end

	arg_11_0._isOpen = false
end

function var_0_0._playAnimCallback(arg_12_0)
	if not arg_12_0.isShowBottom then
		gohelper.setActive(arg_12_0._gobottom, false)
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
