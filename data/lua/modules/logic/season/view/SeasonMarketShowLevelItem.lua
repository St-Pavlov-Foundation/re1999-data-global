module("modules.logic.season.view.SeasonMarketShowLevelItem", package.seeall)

slot0 = class("SeasonMarketShowLevelItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.go = slot1
	slot0.index = slot2
	slot0.targetIndex = slot3
	slot0.maxIndex = slot4
	slot0._goline = gohelper.findChild(slot1, "#go_line")
	slot0._goselected = gohelper.findChild(slot1, "#go_selected")
	slot0._txtselectindex = gohelper.findChildText(slot1, "#go_selected/#txt_selectindex")
	slot0._gopass = gohelper.findChild(slot1, "#go_pass")
	slot0._animatorPass = slot0._gopass:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtpassindex = gohelper.findChildText(slot1, "#go_pass/#txt_passindex")
	slot0._gounpass = gohelper.findChild(slot1, "#go_unpass")
	slot0._txtunpassindex = gohelper.findChildText(slot1, "#go_unpass/#txt_unpassindex")
	slot0.point = gohelper.findChild(slot1, "#go_unpass/point")

	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._goline, false)
	gohelper.setActive(slot0._gopass, false)
	gohelper.setActive(slot0._gounpass, false)
	gohelper.setActive(slot0._goselected, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0._goline, slot0.index < slot0.maxIndex)
	gohelper.setActive(slot0._gopass, slot0.index < slot0.targetIndex)
	gohelper.setActive(slot0._gounpass, slot0.targetIndex < slot0.index)
	gohelper.setActive(slot0._goselected, slot0.targetIndex == slot0.index)

	slot0._txtselectindex.text = string.format("%02d", slot0.index)
	slot0._txtpassindex.text = string.format("%02d", slot0.index)
	slot0._txtunpassindex.text = string.format("%02d", slot0.index)

	if slot0.index + 1 == slot0.targetIndex or slot0.targetIndex == slot0.index then
		slot0._animatorPass:Play(UIAnimationName.Open, 0, 0)
	else
		slot0._animatorPass:Play(UIAnimationName.Idle, 0, 0)
	end
end

function slot0.destroy(slot0)
end

return slot0
