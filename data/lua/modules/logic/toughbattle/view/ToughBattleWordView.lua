module("modules.logic.toughbattle.view.ToughBattleWordView", package.seeall)

slot0 = class("ToughBattleWordView", BaseView)

function slot0.onInitView(slot0)
	slot0._root = gohelper.findChild(slot0.viewGO, "root/#go_words")
	slot0._item = gohelper.findChild(slot0.viewGO, "root/#go_words/item")
end

function slot0.onOpen(slot0)
	slot0._wordRes = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.word, slot0._root)

	gohelper.setActive(slot0._item, false)
	gohelper.setActive(slot0._wordRes, false)
	TaskDispatcher.runRepeat(slot0._createWord, slot0, ToughBattleEnum.WordInterval, -1)
	slot0:_createWord()
end

function slot0._createWord(slot0)
	if not slot0._nowPosIndex then
		slot0._nowPosIndex = math.random(1, #ToughBattleEnum.WordPlace)
	else
		if slot0._nowPosIndex <= math.random(1, #ToughBattleEnum.WordPlace - 1) then
			slot1 = slot1 + 1
		end

		slot0._nowPosIndex = slot1
	end

	slot0._coIndexSort = slot0._coIndexSort or {}

	if slot0._coIndexSort[1] then
		slot0._nowCoIndex = table.remove(slot0._coIndexSort, 1)
	else
		for slot4 = 1, #lua_siege_battle_word.configList do
			slot0._coIndexSort[slot4] = slot4
		end

		slot0._coIndexSort = GameUtil.randomTable(slot0._coIndexSort)

		if slot0._nowCoIndex == slot0._coIndexSort[1] then
			slot0._nowCoIndex = table.remove(slot0._coIndexSort, 2)
		else
			slot0._nowCoIndex = table.remove(slot0._coIndexSort, 1)
		end
	end

	slot1 = gohelper.cloneInPlace(slot0._item)

	gohelper.setActive(slot1, true)

	slot2 = ToughBattleEnum.WordPlace[slot0._nowPosIndex]

	recthelper.setAnchor(slot1.transform, slot2.x, slot2.y)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot1, ToughBattleWordComp, {
		co = lua_siege_battle_word.configList[slot0._nowCoIndex],
		res = slot0._wordRes
	})
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._createWord, slot0)
end

return slot0
