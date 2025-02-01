module("modules.logic.gm.view.GMSummonView", package.seeall)

slot0 = class("GMSummonView", BaseView)
slot0._Type2Name = {
	AllSummon = 3,
	DiffRarity = 1,
	UpSummon = 2
}

function slot0.onInitView(slot0)
	slot0._goContent = gohelper.findChild(slot0.viewGO, "node/infoScroll/Viewport/#go_Content")
	slot0._click = gohelper.findChildButton(slot0.viewGO, "node/close")
	slot0._itemList = {}
	slot0._paragraphItems = slot0:getUserDataTb_()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._poolId, slot0._totalCount, slot0._star6TotalCount, slot0._star5TotalCount = GMSummonModel.instance:getAllInfo()

	slot0:_initView()
end

function slot0._initView(slot0)
	slot0:cleanParagraphs()

	for slot4 = 1, 3 do
		slot5 = slot0._itemList[slot4] or slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "node/infoScroll/Viewport/#go_Content/#go_infoItem" .. slot4)
		slot5.txtdesctitle = gohelper.findChildText(slot5.go, "desctitle/#txt_desctitle")

		slot0:_createParagraphUI(slot4, slot5)
	end
end

function slot0._createParagraphUI(slot0, slot1, slot2)
	if slot1 == uv0._Type2Name.DiffRarity then
		for slot7, slot8 in ipairs(GMSummonModel.instance:getDiffRaritySummonHeroInfo()) do
			slot0:createParaItem(slot2.go).text = slot8.star .. "星：" .. slot8.per * 100 .. "% (" .. slot8.num .. "/" .. slot0._totalCount .. ")"
		end
	elseif slot1 == uv0._Type2Name.UpSummon then
		slot3, slot4 = GMSummonModel.instance:getUpHeroInfo()
		slot0:createParaItem(slot2.go).text = "UP角色"

		slot0:createUPParaItem(slot2.go, slot3)

		slot0:createParaItem(slot2.go).text = "\n非UP角色"

		slot0:createUPParaItem(slot2.go, slot4)
	elseif slot1 == uv0._Type2Name.AllSummon then
		for slot7, slot8 in ipairs(GMSummonModel.instance:getAllSummonHeroInfo()) do
			slot0:createParaItem(slot2.go).text = "(" .. slot8.star .. "星)" .. GMSummonModel.instance:getTargetName(slot8.id) .. "：" .. slot8.per * 100 .. "% (" .. slot8.num .. "/" .. slot0._totalCount .. ")"
		end
	end
end

function slot0.createUPParaItem(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if slot7.star == 6 then
			slot0:createParaItem(slot1).text = "(" .. slot7.star .. "星)" .. GMSummonModel.instance:getTargetName(slot7.id) .. "：" .. slot7.per * 100 .. "% (" .. slot7.num .. "/" .. slot0._star6TotalCount .. ")"
		elseif slot7.star == 5 then
			slot8.text = "(" .. slot7.star .. "星)" .. slot9 .. "：" .. slot7.per * 100 .. "% (" .. slot7.num .. "/" .. slot0._star5TotalCount .. ")"
		end
	end
end

function slot0.createParaItem(slot0, slot1)
	slot2 = nil
	slot2 = gohelper.cloneInPlace(gohelper.findChild(slot1, "#txt_descContent"), "para_1")

	gohelper.setActive(slot2, true)
	table.insert(slot0._paragraphItems, slot2)

	return slot2:GetComponent(gohelper.Type_TextMesh)
end

function slot0.cleanParagraphs(slot0)
	for slot4 = #slot0._paragraphItems, 1, -1 do
		gohelper.destroy(slot0._paragraphItems[slot4])

		slot0._paragraphItems[slot4] = nil
	end
end

return slot0
