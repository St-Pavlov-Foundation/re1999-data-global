module("modules.logic.dungeon.view.DungeonExploreLevelItem", package.seeall)

slot0 = class("DungeonExploreLevelItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._goselected = gohelper.findChild(slot1, "#go_selected")
	slot0._btnclick = gohelper.findChildButton(slot1, "#btn_click")
	slot0._txtindex = gohelper.findChildText(slot1, "#txt_index")
	slot0._goline = gohelper.findChild(slot1, "line")
	slot0._goexploring = gohelper.findChild(slot1, "#go_exploring")
	slot0._golock = gohelper.findChild(slot1, "#go_lock")

	slot0._btnclick:AddClickListener(slot0._click, slot0)

	slot5 = UnityEngine.Animator
	slot0._anim = slot1:GetComponent(typeof(slot5))
	slot0._progressItems = {}

	for slot5 = 1, 3 do
		slot0._progressItems[slot5] = {
			dark = gohelper.findChild(slot1, "progress/#go_progressitem" .. slot5 .. "/dark"),
			light = gohelper.findChild(slot1, "progress/#go_progressitem" .. slot5 .. "/light"),
			unlockEffect = gohelper.findChild(slot1, "progress/#go_progressitem" .. slot5 .. "/click_light")
		}
	end

	ExploreController.instance:registerCallback(ExploreEvent.OnLevelClick, slot0.onLevelClick, slot0)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0._index = slot2
	slot0._config = slot1
	slot0._txtindex.text = slot2

	gohelper.setActive(slot0._goline, not slot3)

	slot0._lock = false

	if not lua_explore_scene.configDict[slot1.chapterId][slot1.id] then
		logError("缺失密室地图配置" .. slot1.chapterId .. " + " .. slot1.id)

		return
	end

	gohelper.setActive(slot0._goexploring, slot4.id == ExploreSimpleModel.instance.nowMapId)
	gohelper.setActive(slot0._golock, not ExploreSimpleModel.instance:getMapIsUnLock(slot4.id))

	if not ExploreSimpleModel.instance:getMapIsUnLock(slot4.id) then
		slot0._txtindex.text = ""
		slot0._lock = true
	end

	slot5 = true

	if not slot0._lock then
		slot5 = ExploreSimpleModel.instance:getEpisodeIsShowUnlock(slot1.chapterId, slot1.id)
	end

	slot6, slot7, slot8, slot9, slot10, slot11 = ExploreSimpleModel.instance:getCoinCountByMapId(slot4.id)
	slot12 = slot8 == slot11
	slot13 = slot7 == slot10
	slot14 = slot6 == slot9

	gohelper.setActive(slot0._progressItems[1].dark, not slot12)
	gohelper.setActive(slot0._progressItems[1].light, slot12)
	gohelper.setActive(slot0._progressItems[2].dark, not slot13)
	gohelper.setActive(slot0._progressItems[2].light, slot13)
	gohelper.setActive(slot0._progressItems[3].dark, not slot14)
	gohelper.setActive(slot0._progressItems[3].light, slot14)

	if not slot5 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		slot0._anim:Play("unlock", 0, 0)
		ExploreSimpleModel.instance:markEpisodeShowUnlock(slot1.chapterId, slot1.id)
	else
		slot0._anim:Play("idle", 0, 0)
	end

	slot0:_hideUnlockEffect()

	slot15 = false

	if slot14 and not ExploreSimpleModel.instance:getCollectFullIsShow(slot1.chapterId, ExploreEnum.CoinType.Bonus, slot1.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(slot1.chapterId, ExploreEnum.CoinType.Bonus, slot1.id)
		gohelper.setActive(slot0._progressItems[3].unlockEffect, true)

		slot15 = true
	end

	if slot13 and not ExploreSimpleModel.instance:getCollectFullIsShow(slot1.chapterId, ExploreEnum.CoinType.GoldCoin, slot1.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(slot1.chapterId, ExploreEnum.CoinType.GoldCoin, slot1.id)
		gohelper.setActive(slot0._progressItems[2].unlockEffect, true)

		slot15 = true
	end

	if slot12 and not ExploreSimpleModel.instance:getCollectFullIsShow(slot1.chapterId, ExploreEnum.CoinType.PurpleCoin, slot1.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(slot1.chapterId, ExploreEnum.CoinType.PurpleCoin, slot1.id)
		gohelper.setActive(slot0._progressItems[1].unlockEffect, true)

		slot15 = true
	end

	TaskDispatcher.cancelTask(slot0._hideUnlockEffect, slot0)

	if slot15 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		TaskDispatcher.runDelay(slot0._hideUnlockEffect, slot0, 1.5)
	end
end

function slot0._hideUnlockEffect(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0._progressItems[slot4].unlockEffect, false)
	end
end

function slot0._click(slot0)
	if slot0._lock then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreLock)

		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnLevelClick, slot0._index)
end

function slot0.onLevelClick(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1 == slot0._index)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._hideUnlockEffect, slot0)

	slot4 = slot0.onLevelClick

	ExploreController.instance:unregisterCallback(ExploreEvent.OnLevelClick, slot4, slot0)
	slot0._btnclick:RemoveClickListener()

	slot0._index = 0
	slot0._config = nil
	slot0._goselected = nil
	slot0._btnclick = nil
	slot0._txtindex = nil
	slot0._goline = nil
	slot0._goexploring = nil
	slot0._golock = nil

	for slot4 in pairs(slot0._progressItems) do
		for slot8 in pairs(slot0._progressItems[slot4]) do
			slot0._progressItems[slot4][slot8] = nil
		end

		slot0._progressItems[slot4] = nil
	end
end

return slot0
