module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDestinyItem", package.seeall)

slot0 = class("VersionActivity2_3NewCultivationDestinyItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._simagestone = gohelper.findChildSingleImage(slot1, "#simage_stone")
	slot0._txttitle = gohelper.findChildText(slot1, "title/#txt_title")
	slot0._godecitem = gohelper.findChild(slot1, "#go_decitem")
	slot0._descItemList = {}
	slot0._descCompList = {}
end

function slot0.setData(slot0, slot1, slot2)
	slot0._destinyId = slot2
	slot0._roleId = slot1

	slot0:refreshUI(slot1, slot2)
end

function slot0.SetActive(slot0, slot1)
	gohelper.setActive(slot0._go, slot1)
end

function slot0.refreshUI(slot0, slot1, slot2)
	slot4 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(slot2)
	slot0._txttitle.text = slot4.name

	slot0._simagestone:LoadImage(ResUrl.getDestinyIcon(slot4.icon))

	slot5 = 0
	slot6 = #slot0._descItemList

	for slot10, slot11 in pairs(CharacterDestinyConfig.instance:getDestinyFacetCo(slot2)) do
		slot12, slot13 = nil

		if slot6 < slot5 + 1 then
			slot14 = gohelper.clone(slot0._godecitem, slot0._go)

			gohelper.setActive(slot14, true)

			slot12 = gohelper.findChildTextMesh(slot14, "#txt_dec")

			gohelper.setAsLastSibling(slot14)
			table.insert(slot0._descItemList, slot12)
			table.insert(slot0._descCompList, MonoHelper.addNoUpdateLuaComOnceToGo(slot12.gameObject, SkillDescComp))
		else
			slot12 = slot0._descItemList[slot5]
			slot13 = slot0._descCompList[slot5]
		end

		gohelper.setActive(slot12.transform.parent.gameObject, true)
		slot13:updateInfo(slot12, slot11.desc, slot1)
		slot13:setTipParam(0, Vector2(380, 100))
	end

	if slot5 < slot6 then
		for slot10 = slot5 + 1, slot6 do
			gohelper.setActive(slot0._descItemList[slot10].transform.parent.gameObject, false)
		end
	end
end

function slot0.onDestroy(slot0)
	if not slot0._isDisposed then
		slot0._isDisposed = true
	end
end

return slot0
