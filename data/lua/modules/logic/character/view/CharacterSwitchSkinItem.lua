module("modules.logic.character.view.CharacterSwitchSkinItem", package.seeall)

slot0 = class("CharacterSwitchSkinItem", LuaCompBase)

function slot0.showSkin(slot0, slot1, slot2)
	slot0._heroId = slot1
	slot0._skinId = slot2

	gohelper.setActive(slot0.viewGO, true)

	slot0._image = slot0._singleImg:GetComponent(gohelper.Type_Image)
	slot0._image.enabled = false

	slot0._singleImg:LoadImage(ResUrl.getHeadIconMiddle(slot2), slot0._loadCallback, slot0)
end

function slot0._loadCallback(slot0)
	slot0._image.enabled = true
end

function slot0.setSelected(slot0, slot1)
	slot0._selected = slot1

	gohelper.setActive(slot0._selectGo, slot1)
	gohelper.setActive(slot0._unselectGo, not slot1)

	slot0._canvas.alpha = slot1 and 1 or 0.75
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._singleImg = gohelper.findChildSingleImage(slot0.viewGO, "heroskin")
	slot0._selectGo = gohelper.findChild(slot0.viewGO, "heroskin/select")
	slot0._unselectGo = gohelper.findChild(slot0.viewGO, "heroskin/unselect")
	slot0._canvas = gohelper.findChildComponent(slot0.viewGO, "heroskin", typeof(UnityEngine.CanvasGroup))
end

function slot0.addEventListeners(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO, AudioEnum.UI.play_ui_character_switch)

	if slot0._click then
		slot0._click:AddClickListener(slot0._onClick, slot0)
	end

	CharacterController.instance:registerCallback(CharacterEvent.SwitchHeroSkin, slot0._switchHeroSkin, slot0)
end

function slot0.removeEventListeners(slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.SwitchHeroSkin, slot0._switchHeroSkin, slot0)

	if slot0._click then
		slot0._click:RemoveClickListener()
	end
end

function slot0._switchHeroSkin(slot0, slot1, slot2)
	slot0:setSelected(slot1 == slot0._heroId and slot0._skinId == slot2)
end

function slot0._onClick(slot0)
	if slot0._selected then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.SwitchHeroSkin, slot0._heroId, slot0._skinId)
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
	slot0._singleImg:UnLoadImage()
end

return slot0
