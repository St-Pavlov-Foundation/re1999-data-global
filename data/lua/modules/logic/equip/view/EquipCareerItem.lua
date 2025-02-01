module("modules.logic.equip.view.EquipCareerItem", package.seeall)

slot0 = class("EquipCareerItem", UserDataDispose)

function slot0.onInitView(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.go = slot1
	slot0.selectedBg = gohelper.findChild(slot0.go, "BG")
	slot0.txt = gohelper.findChildText(slot0.go, "txt")
	slot0.icon = gohelper.findChildImage(slot0.go, "icon")
	slot0.clickCallback = slot2
	slot0.clickCallbackObj = slot3
	slot0.click = gohelper.getClick(slot0.go)

	slot0.click:AddClickListener(slot0.onClick, slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)

	if slot0.clickCallback then
		if slot0.clickCallbackObj then
			slot0.clickCallback(slot0.clickCallbackObj, slot0.careerMo)
		else
			slot0.clickCallback(slot0.careerMo)
		end
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.careerMo = slot1

	if slot0.careerMo.txt then
		slot0.txt.text = slot0.careerMo.txt

		gohelper.setActive(slot0.txt.gameObject, true)
	else
		gohelper.setActive(slot0.txt.gameObject, false)
	end

	if slot0.careerMo.iconName then
		UISpriteSetMgr.instance:setCommonSprite(slot0.icon, slot0.careerMo.iconName)
		gohelper.setActive(slot0.icon.gameObject, true)
	else
		gohelper.setActive(slot0.icon.gameObject, false)
	end
end

function slot0.refreshSelect(slot0, slot1)
	slot2 = slot0.careerMo.career == slot1

	gohelper.setActive(slot0.selectedBg, slot2)
	ZProj.UGUIHelper.SetColorAlpha(slot0.icon, slot2 and 1 or 0.4)
end

function slot0.onDestroyView(slot0)
	slot0.click:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
