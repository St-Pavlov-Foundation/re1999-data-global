module("modules.logic.gm.view.GMFastAddHeroAddItem", package.seeall)

slot0 = class("GMFastAddHeroAddItem", ListScrollCell)
slot1 = {
	"#319b26",
	"#4d9af9",
	"#a368d1",
	"#fd913b",
	"#e11919"
}

function slot0.init(slot0, slot1)
	slot0._itemClick = SLFramework.UGUI.UIClickListener.Get(slot1)

	slot0._itemClick:AddClickListener(slot0._onClickItem, slot0)

	slot0._img1 = gohelper.findChildImage(slot1, "img1")
	slot0._img2 = gohelper.findChildImage(slot1, "img2")
	slot0._txtName = gohelper.findChildText(slot1, "txtName")
	slot0._txtId = gohelper.findChildText(slot1, "txtId")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.characterCo = slot1

	gohelper.setActive(slot0._img1.gameObject, slot1.id % 2 == 1)
	gohelper.setActive(slot0._img2.gameObject, slot1.id % 2 == 0)

	slot0._txtName.text = slot0.characterCo.name
	slot0._txtId.text = slot0.characterCo.id
	slot2 = "#666666"

	if slot0.characterCo.rare then
		slot2 = uv0[tonumber(slot0.characterCo.rare)]
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtName, slot2)

	slot0._txtId.color = GameUtil.parseColor(slot2)
end

function slot0._onClickItem(slot0)
	GMAddItemModel.instance:onOnClickItem(slot0.characterCo)
	GMFastAddHeroHadHeroItemModel.instance:setSelectMo(nil)
end

function slot0.onDestroy(slot0)
	if slot0._itemClick then
		slot0._itemClick:RemoveClickListener()

		slot0._itemClick = nil
	end
end

return slot0
