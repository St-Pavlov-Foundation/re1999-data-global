module("modules.logic.versionactivity1_3.va3chess.config.Va3ChessConfig", package.seeall)

slot0 = class("Va3ChessConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0._registerConfigIns(slot0)
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Config.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Config.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Config.instance
	}
end

function slot0._getConfigIns(slot0, slot1)
	if not slot0._configMap then
		slot0._configMap = slot0:_registerConfigIns()
		slot2 = {
			"getInteractObjectCo",
			"getMapCo",
			"getEpisodeCo"
		}

		for slot6, slot7 in pairs(slot0._configMap) do
			for slot11, slot12 in ipairs(slot2) do
				if not slot7[slot12] or type(slot7[slot12]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", slot7.__cname, slot12))
				end
			end
		end
	end

	if not slot0._configMap[slot1] then
		logError(string.format("version activity Id[%s] 没注册", slot1))
	end

	return slot0._configMap[slot1]
end

function slot0.getInteractObjectCo(slot0, slot1, slot2)
	if slot0:_getConfigIns(slot1) then
		if slot3.getInteractObjectCo then
			return slot3:getInteractObjectCo(slot1, slot2)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getInteractObjectCo接口", slot1, slot3.__cname))
		end
	end

	return nil
end

function slot0.getMapCo(slot0, slot1, slot2)
	if slot0:_getConfigIns(slot1) then
		if slot3.getMapCo then
			return slot3:getMapCo(slot1, slot2)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", slot1, slot3.__cname))
		end
	end

	return nil
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	if slot0:_getConfigIns(slot1) then
		if slot3.getEpisodeCo then
			return slot3:getEpisodeCo(slot1, slot2)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", slot1, slot3.__cname))
		end
	end

	return nil
end

function slot0.isStoryEpisode(slot0, slot1, slot2)
	if slot0:_getConfigIns(slot1) and slot3.isStoryEpisode then
		return slot3:isStoryEpisode(slot1, slot2)
	end

	return false
end

function slot0.getTipsCfg(slot0, slot1, slot2)
	if slot0:_getConfigIns(slot1) and slot3.getTipsCfg then
		return slot3:getTipsCfg(slot1, slot2)
	end

	return nil
end

function slot0.getChapterEpisodeId(slot0, slot1)
	if slot0:_getConfigIns(slot1) then
		if slot2.getChapterEpisodeId then
			return slot2:getChapterEpisodeId(slot1)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getChapterEpisodeId 接口", slot1, slot2.__cname))
		end
	end

	return nil
end

function slot0.getEffectCo(slot0, slot1, slot2)
	if slot0:_getConfigIns(slot1) and slot3.getEffectCo then
		return slot3:getEffectCo(slot1, slot2)
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
