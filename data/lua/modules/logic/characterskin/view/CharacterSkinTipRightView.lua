module("modules.logic.characterskin.view.CharacterSkinTipRightView", package.seeall)

slot0 = class("CharacterSkinTipRightView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageskinSwitchBg = gohelper.findChildSingleImage(slot0.viewGO, "container/#simage_skinSwitchBg")
	slot0._simageskinicon = gohelper.findChildSingleImage(slot0.viewGO, "container/skinTip/skinSwitch/skinmask/skinicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refreshRightContainer(slot0)
	slot0.goSkinNormalContainer = gohelper.findChild(slot0.viewGO, "container/normal")
	slot0.goSkinTipContainer = gohelper.findChild(slot0.viewGO, "container/skinTip")
	slot0.goSkinStoreContainer = gohelper.findChild(slot0.viewGO, "container/skinStore")

	gohelper.setActive(slot0.goSkinNormalContainer, false)
	gohelper.setActive(slot0.goSkinTipContainer, true)
	gohelper.setActive(slot0.goSkinStoreContainer, false)
end

function slot0._editableInitView(slot0)
	slot0:refreshRightContainer()
	slot0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
end

function slot0.initViewParam(slot0)
	if LuaUtil.isTable(slot0.viewParam) then
		slot0.skinCo = SkinConfig.instance:getSkinCo(slot0.viewParam.skinId)

		slot0.viewContainer:setHomeBtnVisible(slot0.viewParam.isShowHomeBtn)
	else
		slot0.skinCo = SkinConfig.instance:getSkinCo(slot0.viewParam)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
	slot0:refreshView()
end

function slot0.refreshView(slot0)
	slot0:refreshLeftUI()
	slot0:refreshRightUI()
end

function slot0.refreshLeftUI(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, slot0.skinCo, slot0.viewName)
end

function slot0.refreshRightUI(slot0)
	slot0._simageskinicon:LoadImage(ResUrl.getHeadSkinSmall(slot0.skinCo.id))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageskinSwitchBg:UnLoadImage()
	slot0._simageskinicon:UnLoadImage()
end

return slot0
