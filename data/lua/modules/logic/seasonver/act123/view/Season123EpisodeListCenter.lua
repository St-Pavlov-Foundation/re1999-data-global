module("modules.logic.seasonver.act123.view.Season123EpisodeListCenter", package.seeall)

slot0 = class("Season123EpisodeListCenter", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.dispose(slot0)
	slot0:__onDispose()
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:initComponent()
end

function slot0.initComponent(slot0)
	slot0._txtpassround = gohelper.findChildText(slot0.viewGO, "#go_time/#txt_time")
	slot0._txtmapname = gohelper.findChildText(slot0.viewGO, "#txt_mapname")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_time")
	slot0._tftime = slot0._gotime.transform
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "progress")
	slot0._progressActives = slot0:getUserDataTb_()
	slot0._progressDeactives = slot0:getUserDataTb_()
	slot0._progressHard = slot0:getUserDataTb_()

	for slot4 = 1, Activity123Enum.SeasonStageStepCount do
		slot0._progressActives[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/light", slot4))
		slot0._progressDeactives[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/dark", slot4))
		slot0._progressHard[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/red", slot4))
	end
end

function slot0.initData(slot0, slot1, slot2)
	slot0._actId = slot1
	slot0._stageId = slot2
end

function slot0.refreshUI(slot0)
	if not slot0._stageId then
		return
	end

	if Season123Config.instance:getStageCo(slot0._actId, slot0._stageId) then
		slot0._txtmapname.text = slot1.name
	end

	slot0:refreshRound()
	slot0:refreshProgress()
end

function slot0.refreshRound(slot0)
	if Season123Model.instance:getActInfo(slot0._actId) then
		if slot1:getStageMO(slot0._stageId) then
			gohelper.setActive(slot0._gotime, true)

			slot0._txtpassround.text = tostring(slot1:getTotalRound(slot0._stageId))
		else
			gohelper.setActive(slot0._gotime, false)
		end
	else
		gohelper.setActive(slot0._gotime, false)
	end
end

slot0.NoStarTimeAnchorY = -176
slot0.WithStarTimeAnchorY = -86

function slot0.refreshProgress(slot0)
	slot1 = Season123EpisodeListModel.instance:stageIsPassed()

	gohelper.setActive(slot0._goprogress, slot1)

	if slot1 then
		slot3, slot4 = Season123ProgressUtils.getStageProgressStep(slot0._actId, slot0._stageId)
		slot2 = slot1 and slot4 > 0

		for slot8 = 1, Activity123Enum.SeasonStageStepCount do
			slot9 = slot8 <= slot3

			gohelper.setActive(slot0._progressActives[slot8], slot9 and slot8 < slot4)
			gohelper.setActive(slot0._progressDeactives[slot8], not slot9 and slot8 <= slot4)
			gohelper.setActive(slot0._progressHard[slot8], slot8 == slot4 and slot3 == slot4)
		end
	end

	if slot2 then
		recthelper.setAnchorY(slot0._tftime, uv0.WithStarTimeAnchorY)
	else
		recthelper.setAnchorY(slot0._tftime, uv0.NoStarTimeAnchorY)
	end
end

return slot0
