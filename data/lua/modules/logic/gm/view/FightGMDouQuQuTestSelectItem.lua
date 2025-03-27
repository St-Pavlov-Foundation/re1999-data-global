module("modules.logic.gm.view.FightGMDouQuQuTestSelectItem", package.seeall)

slot0 = class("FightGMDouQuQuTestSelectItem", FightBaseView)

function slot0.onInitView(slot0)
	slot0._btnSelect = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "btn")
	slot0._selected = gohelper.findChild(slot0.viewGO, "select")
	slot0._text = gohelper.findChildText(slot0.viewGO, "Text")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0._btnSelect, slot0._onBtnSelect)
end

function slot0._onBtnSelect(slot0)
	if slot0.listType == "_enemySelectedList" or slot0.listType == "_playerSelectedList" then
		slot0.PARENT_VIEW[slot0.listType]:removeIndex(slot0:getItemIndex())

		slot2 = slot0.listType == "_enemySelectedList" and slot0.PARENT_VIEW._enemySelectList or slot0.PARENT_VIEW._playerSelectList

		for slot7, slot8 in ipairs(slot2) do
			if slot8.config.robotId < slot0.config.robotId then
				slot3 = 0 + 1
			end
		end

		slot3 = slot3 + 1

		gohelper.setSibling(slot2:addIndex(slot3, slot0.config).keyword_gameObject, slot3 - 1)
	else
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and slot0.ITEM_LIST_MGR.lastSelectIndex and slot2 < #slot0.ITEM_LIST_MGR and slot2 > 0 then
			for slot8 = math.min(slot2, slot1), math.max(slot2, slot1) do
				if not slot0.ITEM_LIST_MGR[slot8].selecting then
					slot0.ITEM_LIST_MGR[slot8].selecting = true

					gohelper.setActive(slot0.ITEM_LIST_MGR[slot8]._selected, true)
				end
			end

			slot0.ITEM_LIST_MGR.lastSelectIndex = slot1

			return
		end

		slot0.selecting = not slot0.selecting

		gohelper.setActive(slot0._selected, slot0.selecting)

		slot0.ITEM_LIST_MGR.lastSelectIndex = slot1
	end
end

function slot0.refreshItemData(slot0, slot1)
	gohelper.setSibling(slot0.viewGO, slot0:getItemIndex() - 1)

	slot0.listType = slot0.ITEM_LIST_MGR.listType
	slot0.selecting = false

	gohelper.setActive(slot0._selected, slot0.selecting)

	slot0.config = slot1

	for slot6 = 1, 4 do
		if slot1["role" .. slot6] ~= 0 then
			slot8 = lua_activity174_test_role.configDict[slot7]

			if slot6 > 1 then
				slot2 = "" .. "+"
			end

			if slot8 then
				slot2 = slot2 .. slot8.name
			else
				logError("测试人物表 找不到id:" .. slot7)
			end
		end
	end

	slot0._text.text = slot1.robotId .. " " .. slot2
end

function slot0.onDestructor(slot0)
end

return slot0
