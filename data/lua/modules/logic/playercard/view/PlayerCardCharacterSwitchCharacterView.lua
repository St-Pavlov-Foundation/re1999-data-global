module("modules.logic.playercard.view.PlayerCardCharacterSwitchCharacterView", package.seeall)

slot0 = class("PlayerCardCharacterSwitchCharacterView", BaseView)

function slot0.onInitView(slot0)
	slot0.goLeft = gohelper.findChild(slot0.viewGO, "Left")
	slot0._simageskin = gohelper.findChildSingleImage(slot0.viewGO, "Left/characterSpine/#go_skincontainer/#simage_skin")
	slot0._simagel2d = gohelper.findChildSingleImage(slot0.viewGO, "Left/characterSpine/#go_skincontainer/#simage_l2d")
	slot0._spineContainer = gohelper.findChild(slot0.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer")
	slot0._gobigspine = gohelper.findChild(slot0.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_switch")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "#btn_switch/#txt_switch")
	slot0._animator = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, slot0._onRefreshSwitchView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswitch:RemoveClickListener()
end

function slot0._btnswitchOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)
	slot0._animator:Play("switch", slot0.onSwitchAnimDone, slot0)
	TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
	TaskDispatcher.runDelay(slot0._delaySwitch, slot0, 0.233)
end

function slot0.onSwitchAnimDone(slot0)
end

function slot0._delaySwitch(slot0)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchHeroL2d)
end

function slot0._editableInitView(slot0)
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

function slot0.refreshTxtSwitch(slot0, slot1)
	slot0._txtswitch.text = slot1 and luaLang("storeskinpreviewview_btnswitch") or "L2D"
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
	slot0:_refreshSkinInfo()
	slot0:refreshTxtSwitch(slot1)
end

function slot0.resetRes(slot0)
	if slot0.bigSpine then
		slot0.bigSpine:onDestroy()
	end

	slot0._simageskin:UnLoadImage()
	slot0._simagel2d:UnLoadImage()
end

function slot0.refreshBigVertical(slot0, slot1)
	gohelper.setActive(slot0._spineContainer, slot1)
	gohelper.setActive(slot0._simageskin.gameObject, not slot1)

	if slot1 then
		if slot0.bigSpine == nil then
			slot0.bigSpine = GuiModelAgent.Create(slot0._gobigspine, true)
		end

		slot0.bigSpine:setResPath(slot0.skinCo, slot0.onBigSpineLoaded, slot0)
	else
		slot0._simageskin:LoadImage(ResUrl.getHeadIconImg(slot0.skinCo.id), slot0._loadedImage, slot0)
	end

	if not string.nilorempty(slot0.skinCo.live2dbg) then
		gohelper.setActive(slot0._simagel2d.gameObject, slot1)
		slot0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(slot2))
	else
		gohelper.setActive(slot0._simagel2d.gameObject, false)
	end
end

function slot0._refreshSkinInfo(slot0)
	gohelper.setActive(slot0._btnswitch, PlayerModel.instance:isPlayerSelf(slot0.userId))
end

function slot0.onBigSpineLoaded(slot0)
	slot0.bigSpine:setAllLayer(UnityLayer.SceneEffect)

	if string.nilorempty(slot0.skinCo.playercardViewLive2dOffset) then
		slot1 = slot0.skinCo.characterViewOffset
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0._gobigspine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._gobigspine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
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
	else
		recthelper.setAnchor(slot0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(slot0._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function slot0.onClose(slot0)
	slot0._simageskin:UnLoadImage()
	slot0._simagel2d:UnLoadImage()

	if slot0.bigSpine then
		slot0.bigSpine:setModelVisible(false)
	end
end

function slot0.setShaderKeyWord(slot0, slot1)
	if slot1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function slot0.onDestroyView(slot0)
	if slot0.bigSpine then
		slot0.bigSpine:onDestroy()

		slot0.bigSpine = nil
	end

	slot0._simagel2d:UnLoadImage()
	slot0._simageskin:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
end

return slot0
