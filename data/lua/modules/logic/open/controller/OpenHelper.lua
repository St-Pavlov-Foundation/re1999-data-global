module("modules.logic.open.controller.OpenHelper", package.seeall)

slot0 = class("OpenHelper")

function slot0.getToastIdAndParam(slot0)
	return uv0.ToastId2FuncDict[OpenConfig.instance:getOpenCo(slot0).dec] or uv0.defaultGetToast(slot1)
end

function slot0.defaultGetToast(slot0)
	return slot0 and slot0.dec
end

function slot0.getDungeonToast(slot0)
	slot1 = slot0.dec

	if (not VersionValidator.instance:isInReviewing() or not slot0.verifingEpisodeId) and not slot0.episodeId or slot2 == 0 then
		return slot1
	end

	return slot1, {
		DungeonConfig.instance:getEpisodeDisplay(slot2)
	}
end

function slot0.getActivityDungeonToast(slot0)
	return slot0.dec, {
		ActivityConfig.instance:getActivityCo(DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot0.episodeId) and slot2.chapterId) and slot3.actId) and slot4.name,
		DungeonConfig.instance:getEpisodeDisplay(slot0.episodeId)
	}
end

function slot0.getActivityDungeon1Toast(slot0)
	return slot0.dec, {
		luaLang("v1a2_enterview_activitytip"),
		DungeonConfig.instance:getEpisodeDisplay(slot0.episodeId)
	}
end

function slot0.getActivityUnlockTxt(slot0)
	return string.format(luaLang("versionactivity1_3_hardlocktip"), DungeonConfig.instance:getEpisodeDisplay(OpenConfig.instance:getOpenCo(slot0).episodeId))
end

slot0.ToastId2FuncDict = {
	[ToastEnum.DungeonMapLevel] = slot0.getDungeonToast,
	[ToastEnum.ActivityDungeon] = slot0.getActivityDungeonToast,
	[ToastEnum.ActivityDungeon1] = slot0.getActivityDungeon1Toast
}

return slot0
