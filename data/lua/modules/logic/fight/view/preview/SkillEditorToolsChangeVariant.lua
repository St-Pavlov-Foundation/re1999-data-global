module("modules.logic.fight.view.preview.SkillEditorToolsChangeVariant", package.seeall)

slot0 = class("SkillEditorToolsChangeVariant", BaseViewExtended)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onBtnClick(slot0)
	slot0:getParentView():hideToolsBtnList()
	gohelper.setActive(slot0._btn, true)
end

function slot0.onOpen(slot0)
	slot0:getParentView():addToolBtn("换变体", slot0._onBtnClick, slot0)

	slot0._btn = slot0:getParentView():addToolViewObj("换变体")
	slot0._item = gohelper.findChild(slot0._btn, "variant")

	slot0:_showData()
end

function slot0._showData(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(FightVariantHeartComp.VariantKey) do
		table.insert(slot1, slot5)
	end

	table.insert(slot1, 1, -1)
	slot0:com_createObjList(slot0._onItemShow, slot1, slot0._btn, slot0._item)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "Text").text = slot2

	if slot2 == -1 then
		slot4.text = "还原"
	end

	slot0:addClickCb(gohelper.getClick(slot1), slot0._onItemClick, slot0, slot2)
end

function slot0._onItemClick(slot0, slot1)
	slot2 = nil
	slot3 = GameSceneMgr.instance:getCurScene().entityMgr

	if ((not SkillEditorMgr.instance.cur_select_entity_id or slot3:getEntity(SkillEditorMgr.instance.cur_select_entity_id)) and slot3:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])).variantHeart then
		for slot7, slot8 in pairs(FightVariantHeartComp.VariantKey) do
			if slot1 ~= slot7 then
				if not slot2.spineRenderer:getReplaceMat() then
					return
				end

				slot9:DisableKeyword(slot8)
			end
		end

		if slot1 == -1 then
			return
		end

		slot2.variantHeart:_changeVariant(slot1)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
