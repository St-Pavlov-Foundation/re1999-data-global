module("modules.logic.playercard.view.PlayerCardCharacterSwitchCharacterView", package.seeall)

local var_0_0 = class("PlayerCardCharacterSwitchCharacterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLeft = gohelper.findChild(arg_1_0.viewGO, "#go_characterswitchview/characterswitchview/rightLeft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, arg_2_0._onRefreshSwitchView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onSwitchAnimDone(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._simageskin.gameObject, true)
end

function var_0_0._onRefreshSwitchView(arg_6_0, arg_6_1)
	arg_6_0:_updateHero(arg_6_1.heroId, arg_6_1.skinId, arg_6_1.isL2d)
end

function var_0_0.setHeroId(arg_7_0, arg_7_1)
	if arg_7_1 then
		if not arg_7_0._heroIdSet then
			arg_7_0._heroIdSet = {}
		end

		arg_7_0._heroIdSet[arg_7_1] = true

		if tabletool.len(arg_7_0._heroIdSet) >= 5 then
			arg_7_0._heroIdSet = {}

			GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.5, arg_7_0)
		end
	end
end

function var_0_0._updateHero(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HeroModel.instance:getByHeroId(arg_8_1)
	local var_8_1 = SkinConfig.instance:getSkinCo(arg_8_2 or var_8_0 and var_8_0.skin)

	if not var_8_1 then
		gohelper.setActive(arg_8_0.goLeft, false)

		return
	end

	gohelper.setActive(arg_8_0.goLeft, true)

	arg_8_0.skinCo = var_8_1
	arg_8_0.heroCo = HeroConfig.instance:getHeroCO(arg_8_0.skinCo.characterId)

	arg_8_0:refreshSkin(arg_8_3)
end

function var_0_0.refreshSkin(arg_9_0, arg_9_1)
	arg_9_0:resetRes()
	arg_9_0:refreshBigVertical(arg_9_1)
end

function var_0_0.resetRes(arg_10_0)
	arg_10_0._simageskin:UnLoadImage()
end

function var_0_0.refreshBigVertical(arg_11_0, arg_11_1)
	arg_11_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_11_0.skinCo.id), arg_11_0._loadedImage, arg_11_0)
end

function var_0_0._loadedImage(arg_12_0)
	ZProj.UGUIHelper.SetImageSize(arg_12_0._simageskin.gameObject)

	local var_12_0 = arg_12_0.skinCo.playercardViewImgOffset

	if string.nilorempty(var_12_0) then
		var_12_0 = arg_12_0.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(var_12_0) then
		local var_12_1 = string.splitToNumber(var_12_0, "#")

		recthelper.setAnchor(arg_12_0._simageskin.transform, tonumber(var_12_1[1]), tonumber(var_12_1[2]))
		transformhelper.setLocalScale(arg_12_0._simageskin.transform, tonumber(var_12_1[3]), tonumber(var_12_1[3]), tonumber(var_12_1[3]))
	end
end

function var_0_0.onClose(arg_13_0)
	arg_13_0._simageskin:UnLoadImage()
end

function var_0_0.setShaderKeyWord(arg_14_0, arg_14_1)
	if arg_14_1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simageskin:UnLoadImage()
end

return var_0_0
