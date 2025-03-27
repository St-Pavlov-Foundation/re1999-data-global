module("modules.logic.playercard.view.PlayerCardCharacterSwitchCharacterView", package.seeall)

slot0 = class("PlayerCardCharacterSwitchCharacterView", BaseView)

function slot0.onInitView(slot0)
	slot0.goLeft = gohelper.findChild(slot0.viewGO, "#go_characterswitchview/characterswitchview/rightLeft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, slot0._onRefreshSwitchView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onSwitchAnimDone(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._simageskin.gameObject, true)
end

function slot0._onRefreshSwitchView(slot0, slot1)
	slot0:_updateHero(slot1.heroId, slot1.skinId, slot1.isL2d)
end

function slot0.setHeroId(slot0, slot1)
	if slot1 then
		if not slot0._heroIdSet then
			slot0._heroIdSet = {}
		end

		slot0._heroIdSet[slot1] = true

		if tabletool.len(slot0._heroIdSet) >= 5 then
			slot0._heroIdSet = {}

			GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.5, slot0)
		end
	end
end

function slot0._updateHero(slot0, slot1, slot2, slot3)
	slot4 = HeroModel.instance:getByHeroId(slot1)

	if not SkinConfig.instance:getSkinCo(slot2 or slot4 and slot4.skin) then
		gohelper.setActive(slot0.goLeft, false)

		return
	end

	gohelper.setActive(slot0.goLeft, true)

	slot0.skinCo = slot5
	slot0.heroCo = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId)

	slot0:refreshSkin(slot3)
end

function slot0.refreshSkin(slot0, slot1)
	slot0:resetRes()
	slot0:refreshBigVertical(slot1)
end

function slot0.resetRes(slot0)
	slot0._simageskin:UnLoadImage()
end

function slot0.refreshBigVertical(slot0, slot1)
	slot0._simageskin:LoadImage(ResUrl.getHeadIconImg(slot0.skinCo.id), slot0._loadedImage, slot0)
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageskin.gameObject)

	if string.nilorempty(slot0.skinCo.playercardViewImgOffset) then
		slot1 = slot0.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(slot1) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._simageskin.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._simageskin.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	end
end

function slot0.onClose(slot0)
	slot0._simageskin:UnLoadImage()
end

function slot0.setShaderKeyWord(slot0, slot1)
	if slot1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function slot0.onDestroyView(slot0)
	slot0._simageskin:UnLoadImage()
end

return slot0
