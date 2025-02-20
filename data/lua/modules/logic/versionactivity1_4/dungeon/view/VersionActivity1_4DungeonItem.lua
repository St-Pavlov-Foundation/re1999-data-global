module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonItem", package.seeall)

slot0 = class("VersionActivity1_4DungeonItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "#image_line")
	slot0._goUnlock = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._imagestagefinish = gohelper.findChildImage(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stagename")
	slot5 = "unlock/info/#txt_stageNum"
	slot0._txtstagenum = gohelper.findChildText(slot0.viewGO, slot5)
	slot0._stars = {}

	for slot5 = 1, 1 do
		slot6 = slot0:getUserDataTb_()
		slot6.index = slot5
		slot6.go = gohelper.findChild(slot0.viewGO, "unlock/info/#go_star" .. slot5)
		slot6.has = gohelper.findChild(slot6.go, "has")
		slot6.no = gohelper.findChild(slot6.go, "no")

		table.insert(slot0._stars, slot6)
	end

	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#btn_click")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not slot0._config then
		return
	end

	if DungeonModel.instance:isCanChallenge(slot0._config) then
		VersionActivity1_4DungeonModel.instance:setSelectEpisodeId(slot0._config.id)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonEpisodeView, {
			episodeId = slot0._config.id
		})
	else
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)
	end
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot0._config = slot1

	if not slot1 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	TaskDispatcher.cancelTask(slot0.playAnim, slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot3 = DungeonModel.instance:isCanChallenge(slot1)

	gohelper.setActive(slot0._goUnlock, slot3)
	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0._imagepoint, slot3 and "v1a4_dungeon_stagebase2" or "v1a4_dungeon_stagebase1")
	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0._imageline, "v1a4_dungeon_stagebaseline2")
	gohelper.setActive(slot0._imageline, slot3)

	slot4 = false

	if slot3 then
		slot0._txtstagename.text = slot1.name
		slot0._txtstagenum.text = GameUtil.fillZeroInLeft(slot2, 2)
		slot6 = DungeonModel.instance:getEpisodeInfo(slot1.id) and slot5.star or 0

		for slot10, slot11 in pairs(slot0._stars) do
			gohelper.setActive(slot11.has, slot11.index <= slot6)
			gohelper.setActive(slot11.no, slot6 < slot11.index)
		end

		slot7 = DungeonModel.instance:hasPassLevel(slot1.id)
		slot8 = "v1a4_dungeon_stagebg1"

		UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0._imagestagefinish, slot2 == 5 and (slot7 and "v1a4_dungeon_stagebg3" or "v1a4_dungeon_stagebg4") or slot7 and "v1a4_dungeon_stagebg1" or "v1a4_dungeon_stagebg2")

		if slot7 then
			if VersionActivity1_4DungeonModel.instance:getEpisodeState(slot1.id) < 2 then
				slot0.animName = "finish"

				slot0:playAnim()
			else
				slot0.animName = "open"

				slot0:playAnim()
			end
		elseif slot9 < 1 then
			gohelper.setActive(slot0.viewGO, false)

			slot0.animName = "unlock"

			TaskDispatcher.runDelay(slot0.playAnim, slot0, 1.67)

			slot4 = true
		else
			slot0.animName = "open"

			slot0:playAnim()
		end
	end

	return slot4, slot3
end

function slot0.playAnim(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0._animator:Play(slot0.animName)

	if slot0.animName == "unlock" then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_deblockingmap)
		VersionActivity1_4DungeonModel.instance:setEpisodeState(slot0._config.id, 1)
	elseif slot0.animName == "finish" then
		VersionActivity1_4DungeonModel.instance:setEpisodeState(slot0._config.id, 2)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.playAnim, slot0)
	slot0:removeEventListeners()
	slot0:__onDispose()
end

return slot0
