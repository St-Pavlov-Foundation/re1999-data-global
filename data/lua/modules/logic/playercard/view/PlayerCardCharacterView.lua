module("modules.logic.playercard.view.PlayerCardCharacterView", package.seeall)

local var_0_0 = class("PlayerCardCharacterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLeft = gohelper.findChild(arg_1_0.viewGO, "Left")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#simage_skin")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#simage_l2d")
	arg_1_0._spineContainer = gohelper.findChild(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer")
	arg_1_0._gobigspine = gohelper.findChild(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "#btn_switch/#simage_signature")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, arg_2_0.refreshSkin, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.PlayerCardCharacterSwitchView and arg_4_0.bigSpine then
		arg_4_0.bigSpine:setModelVisible(false)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.PlayerCardCharacterSwitchView and arg_5_0.bigSpine then
		arg_5_0.bigSpine:setModelVisible(true)
	end
end

function var_0_0._btnswitchOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchView, {
		userId = arg_6_0.userId
	})
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_updateParam()
	arg_8_0:refreshSkin()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_updateParam()
	arg_9_0:refreshSkin()
end

function var_0_0._updateParam(arg_10_0)
	arg_10_0.userId = arg_10_0.viewParam.userId
end

function var_0_0.refreshSignature(arg_11_0)
	arg_11_0._simagesignature:LoadImage(ResUrl.getSignature(arg_11_0.heroCo.signature))
end

function var_0_0.refreshSkin(arg_12_0)
	local var_12_0 = PlayerCardModel.instance:getCardInfo(arg_12_0.userId)

	if not var_12_0 then
		gohelper.setActive(arg_12_0.goLeft, false)
		gohelper.setActive(arg_12_0._btnswitch, false)

		return
	end

	local var_12_1, var_12_2, var_12_3, var_12_4 = var_12_0:getMainHero()

	arg_12_0:_updateHero(var_12_1, var_12_2, var_12_4)
end

function var_0_0._updateHero(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = HeroModel.instance:getByHeroId(arg_13_1)
	local var_13_1 = SkinConfig.instance:getSkinCo(arg_13_2 or var_13_0 and var_13_0.skin)

	if not var_13_1 then
		gohelper.setActive(arg_13_0.goLeft, false)

		return
	end

	gohelper.setActive(arg_13_0.goLeft, true)

	arg_13_0.skinCo = var_13_1
	arg_13_0.heroCo = HeroConfig.instance:getHeroCO(arg_13_0.skinCo.characterId)

	arg_13_0:resetRes()
	arg_13_0:refreshSignature()
	arg_13_0:refreshBigVertical(arg_13_3)
	arg_13_0:_refreshSkinInfo()
end

function var_0_0.resetRes(arg_14_0)
	arg_14_0._simageskin:UnLoadImage()
	arg_14_0._simagel2d:UnLoadImage()
end

function var_0_0.refreshBigVertical(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._spineContainer, arg_15_1)
	gohelper.setActive(arg_15_0._simageskin.gameObject, not arg_15_1)

	if arg_15_1 then
		if arg_15_0.bigSpine == nil then
			arg_15_0.bigSpine = GuiModelAgent.Create(arg_15_0._gobigspine, true)
		end

		arg_15_0.bigSpine:setResPath(arg_15_0.skinCo, arg_15_0.onBigSpineLoaded, arg_15_0)
	else
		arg_15_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_15_0.skinCo.id), arg_15_0._loadedImage, arg_15_0)
	end

	local var_15_0 = arg_15_0.skinCo.live2dbg

	if not string.nilorempty(var_15_0) then
		gohelper.setActive(arg_15_0._simagel2d.gameObject, arg_15_1)
		arg_15_0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(var_15_0))
	else
		gohelper.setActive(arg_15_0._simagel2d.gameObject, false)
	end
end

function var_0_0._refreshSkinInfo(arg_16_0)
	gohelper.setActive(arg_16_0._btnswitch, PlayerModel.instance:isPlayerSelf(arg_16_0.userId))
end

function var_0_0.onBigSpineLoaded(arg_17_0)
	arg_17_0.bigSpine:setAllLayer(UnityLayer.SceneEffect)

	local var_17_0 = arg_17_0.skinCo.playercardViewLive2dOffset

	if string.nilorempty(var_17_0) then
		var_17_0 = arg_17_0.skinCo.characterViewOffset
	end

	local var_17_1 = SkinConfig.instance:getSkinOffset(var_17_0)

	recthelper.setAnchor(arg_17_0._gobigspine.transform, tonumber(var_17_1[1]), tonumber(var_17_1[2]))
	transformhelper.setLocalScale(arg_17_0._gobigspine.transform, tonumber(var_17_1[3]), tonumber(var_17_1[3]), tonumber(var_17_1[3]))
	arg_17_0.bigSpine:setModelVisible(not ViewMgr.instance:isOpen(ViewName.PlayerCardCharacterSwitchView))
end

function var_0_0._loadedImage(arg_18_0)
	ZProj.UGUIHelper.SetImageSize(arg_18_0._simageskin.gameObject)

	local var_18_0 = arg_18_0.skinCo.playercardViewImgOffset

	if string.nilorempty(var_18_0) then
		var_18_0 = arg_18_0.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(var_18_0) then
		local var_18_1 = string.splitToNumber(var_18_0, "#")

		recthelper.setAnchor(arg_18_0._simageskin.transform, tonumber(var_18_1[1]), tonumber(var_18_1[2]))
		transformhelper.setLocalScale(arg_18_0._simageskin.transform, tonumber(var_18_1[3]), tonumber(var_18_1[3]), tonumber(var_18_1[3]))
	else
		recthelper.setAnchor(arg_18_0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(arg_18_0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function var_0_0.onClose(arg_19_0)
	arg_19_0._simageskin:UnLoadImage()
	arg_19_0._simagesignature:UnLoadImage()
	arg_19_0._simagel2d:UnLoadImage()

	if arg_19_0.bigSpine then
		arg_19_0.bigSpine:setModelVisible(false)
	end
end

function var_0_0.setShaderKeyWord(arg_20_0, arg_20_1)
	if arg_20_1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onDestroyView(arg_21_0)
	if arg_21_0.bigSpine then
		arg_21_0.bigSpine:onDestroy()

		arg_21_0.bigSpine = nil
	end

	arg_21_0._simagesignature:UnLoadImage()
	arg_21_0._simagel2d:UnLoadImage()
	arg_21_0._simageskin:UnLoadImage()
end

return var_0_0
