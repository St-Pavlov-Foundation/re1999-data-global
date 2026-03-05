-- chunkname: @modules/logic/herogroup/controller/HeroGroupController.lua

module("modules.logic.herogroup.controller.HeroGroupController", package.seeall)

local HeroGroupController = class("HeroGroupController", BaseController)

function HeroGroupController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function HeroGroupController:reInit()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function HeroGroupController:_onGetInfoFinish()
	HeroGroupModel.instance:setParam()
end

function HeroGroupController:_checkCommonHeroGroup(episodeId)
	if episodeId ~= 10101 then
		return
	end

	if not GuideModel.instance:isGuideRunning(102) then
		return
	end

	local firstSubId = 1
	local heroGroupMo = HeroGroupModel.instance:getCommonGroupList(firstSubId)

	if not heroGroupMo then
		logError("HeroGroupController:_checkCommonHeroGroup heroGroupMo nil")

		return
	end

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroId = heroGroupMo:getHeroByIndex(i)
		local heroMo = HeroModel.instance:getById(heroId)

		if heroMo then
			return
		end
	end

	local appleHeroMo = HeroModel.instance:getByHeroId(3028)

	if not appleHeroMo then
		logError("HeroGroupController:_checkCommonHeroGroup appleHeroMo nil")

		return
	end

	local uid = appleHeroMo.uid

	heroGroupMo.heroList[1] = tostring(uid)

	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMo.clothId, heroGroupMo:getMainList(), heroGroupMo:getSubList(), heroGroupMo:getAllHeroEquips(), heroGroupMo:getAllHeroActivity104Equips(), heroGroupMo:getAssistBossId())

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Common
	local snapshotSubId = firstSubId

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req)
end

function HeroGroupController:openGroupFightView(battleId, episodeId, adventure)
	callWithCatch(self._checkCommonHeroGroup, self, episodeId)

	self._groupFightName = self:_getGroupFightViewName(episodeId)

	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(battleId, episodeId, adventure)

	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(episodeId)] then
			FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
			FightRpc.instance:sendGetFightRecordGroupRequest(episodeId)

			return
		end
	end

	local currentGroupMo = HeroGroupModel.instance:getCurGroupMO()

	if self:changeToDefaultEquip() and currentGroupMo and not currentGroupMo.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			self:_openGroupView()
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial and currentGroupMo then
		currentGroupMo:saveData()
	end

	self:_openGroupView()
end

function HeroGroupController:_openGroupView()
	if self._groupFightName == ViewName.VersionActivity2_8HeroGroupBossView and self:_bossEnterFight() then
		return
	end

	ViewMgr.instance:openView(self._groupFightName)
end

function HeroGroupController:_bossEnterFight()
	local episodeId = HeroGroupModel.instance.episodeId
	local heroGroupId = episodeId and VersionActivity2_8BossConfig.instance:getHeroGroupId(episodeId)
	local heroGroupConfig = heroGroupId and lua_hero_group_type.configDict[heroGroupId]
	local changeForbiddenEpisode = heroGroupConfig and heroGroupConfig.changeForbiddenEpisode

	if not changeForbiddenEpisode or changeForbiddenEpisode == 0 then
		logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s changeForbiddenEpisode nil", episodeId, heroGroupId))

		return
	end

	local pass = DungeonModel.instance:hasPassLevelAndStory(changeForbiddenEpisode)

	if not pass then
		return
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)

	local result = FightController.instance:setFightHeroSingleGroup()

	if result then
		local fightParam = FightModel.instance:getFightParam()

		fightParam.isReplay = false
		fightParam.multiplication = 1

		DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)

		return true
	else
		logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s setFightHeroSingleGroup failed", episodeId, heroGroupId))
	end
end

function HeroGroupController:_getGroupFightViewName(episodeId)
	if not self.ActivityIdToHeroGroupView then
		self.ActivityIdToHeroGroupView = {
			[VersionActivity1_2Enum.ActivityId.Dungeon] = ViewName.V1a2_HeroGroupFightView,
			[VersionActivity1_3Enum.ActivityId.Dungeon] = ViewName.V1a3_HeroGroupFightView,
			[VersionActivity1_5Enum.ActivityId.Dungeon] = ViewName.V1a5_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.Dungeon] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.DungeonBossRush] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity2_9Enum.ActivityId.Dungeon] = ViewName.VersionActivity2_9HeroGroupFightView
		}
		self.ChapterTypeToHeroGroupView = {
			[DungeonEnum.ChapterType.WeekWalk] = ViewName.HeroGroupFightWeekwalkView,
			[DungeonEnum.ChapterType.WeekWalk_2] = ViewName.HeroGroupFightWeekwalk_2View,
			[DungeonEnum.ChapterType.TowerPermanent] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBoss] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerLimited] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBossTeach] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerDeep] = ViewName.TowerDeepHeroGroupFightView,
			[DungeonEnum.ChapterType.Act183] = ViewName.Act183HeroGroupFightView,
			[DungeonEnum.ChapterType.Odyssey] = ViewName.OdysseyHeroGroupView,
			[DungeonEnum.ChapterType.Survival] = ViewName.SurvivalHeroGroupFightView,
			[DungeonEnum.ChapterType.Shelter] = ViewName.ShelterHeroGroupFightView,
			[DungeonEnum.ChapterType.Act191] = ViewName.Act191HeroGroupView,
			[DungeonEnum.ChapterType.Rouge2] = ViewName.Rouge2_HeroGroupFightView,
			[DungeonEnum.ChapterType.TowerCompose] = ViewName.TowerComposeHeroGroupView
		}
		self.ChapterIdToHeroGroupView = {
			[DungeonEnum.ChapterId.BossStory] = ViewName.VersionActivity2_8HeroGroupBossView
		}
	end

	if DungeonController.checkEpisodeFiveHero(episodeId) then
		return ViewName.HeroGroupFightFiveHeroView
	end

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.BossRush then
		local viewName = BossRushController.instance:getGroupFightViewName(episodeId)

		if viewName then
			return viewName
		end
	end

	local chapterConfig = episodeConfig and DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	if chapterConfig then
		return self.ActivityIdToHeroGroupView[chapterConfig.actId] or self.ChapterTypeToHeroGroupView[chapterConfig.type] or self.ChapterIdToHeroGroupView[chapterConfig.id] or ViewName.HeroGroupFightView
	end

	return ViewName.HeroGroupFightView
end

function HeroGroupController:changeToDefaultEquip()
	local groupMo = HeroGroupModel.instance:getCurGroupMO()
	local equipMoList = groupMo and groupMo.equips or {}
	local heroUidList = groupMo and groupMo.heroList or {}
	local heroMo, equipIndex
	local changed = false

	for index, heroUid in ipairs(heroUidList) do
		heroMo = HeroModel.instance:getById(heroUid)
		equipIndex = index - 1

		if heroMo and heroMo:hasDefaultEquip() and equipMoList[equipIndex] and heroMo.defaultEquipUid ~= equipMoList[equipIndex].equipUid[1] then
			local preFindIndex = self:_checkEquipInPreviousEquip(equipIndex - 1, heroMo.defaultEquipUid, equipMoList)

			if equipIndex <= preFindIndex then
				local findIndex = self:_checkEquipInBehindEquip(equipIndex + 1, heroMo.defaultEquipUid, equipMoList)

				if findIndex > 0 then
					equipMoList[findIndex].equipUid[1] = equipMoList[equipIndex].equipUid[1]
				end

				equipMoList[equipIndex].equipUid[1] = heroMo.defaultEquipUid
			elseif equipMoList[equipIndex].equipUid[1] == heroMo.defaultEquipUid then
				equipMoList[equipIndex].equipUid[1] = "0"
			end

			changed = true
		end
	end

	return changed
end

function HeroGroupController:_checkEquipInBehindEquip(startIndex, equipUid, equipMoList)
	if not EquipModel.instance:getEquip(equipUid) then
		return -1
	end

	for i = startIndex, #equipMoList do
		if equipUid == equipMoList[i].equipUid[1] then
			return i
		end
	end

	return -1
end

function HeroGroupController:_checkEquipInPreviousEquip(endIndex, equipUid, equipMoList)
	if not EquipModel.instance:getEquip(equipUid) then
		return endIndex + 1
	end

	for i = endIndex, 0, -1 do
		if equipUid == equipMoList[i].equipUid[1] then
			return i
		end
	end

	return endIndex + 1
end

function HeroGroupController:_onGetFightRecordGroupReply(fightGroupMO)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	HeroGroupModel.instance:setReplayParam(fightGroupMO)
	self:_openGroupView()
end

function HeroGroupController:onReceiveHeroGroupSnapshot(msg)
	local snapshotId = msg.snapshotId
	local subId = msg.snapshotSubId
	local groupInfo = msg.groupInfo
end

HeroGroupController.instance = HeroGroupController.New()

return HeroGroupController
