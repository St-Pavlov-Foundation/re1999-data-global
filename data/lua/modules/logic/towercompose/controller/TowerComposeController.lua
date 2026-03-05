-- chunkname: @modules/logic/towercompose/controller/TowerComposeController.lua

module("modules.logic.towercompose.controller.TowerComposeController", package.seeall)

local TowerComposeController = class("TowerComposeController", BaseController)

function TowerComposeController:onInit()
	self.jumpFlow = nil
end

function TowerComposeController:reInit()
	if self.jumpFlow then
		self.jumpFlow:onDestroyInternal()
	end

	self.jumpFlow = nil
end

function TowerComposeController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.onSetTaskList, self)
	self:registerCallback(TowerEvent.DailyReresh, self.dailyReddotRefresh, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function TowerComposeController:jumpView(param)
	if param.jumpId == TowerComposeEnum.JumpId.TowerModeSelect then
		if not ViewMgr.instance:isOpen(ViewName.TowerMainSelectView) then
			self:openTowerMainSelectView(param)

			return
		end
	elseif param.jumpId == TowerComposeEnum.JumpId.TowerComposeMain and not ViewMgr.instance:isOpen(ViewName.TowerComposeMainView) then
		self:openTowerComposeMainView(param)

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.TowerComposeMainView) then
		self.jumpFlow = FlowSequence.New()

		if not ViewMgr.instance:isOpen(ViewName.TowerMainSelectView) then
			self.jumpFlow:addWork(TowerMainSelectEnterWork.New())
		end

		local towerEnterWork = TowerEnterWork.New(nil, ViewName.TowerComposeMainView)

		self.jumpFlow:addWork(towerEnterWork)
		self.jumpFlow:addWork(FunctionWork.New(self.realJumpTowerView, self, param))
		self.jumpFlow:registerDoneListener(self.flowDone, self)
		self.jumpFlow:start()
	else
		self:realJumpTowerView(param)
	end
end

function TowerComposeController:realJumpTowerView(param)
	local themeId, layerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local curThemeId = param and param.themeId or themeId
	local curLayerId = param and param.layerId or layerId

	if param.jumpId == TowerComposeEnum.JumpId.TowerComposePlane then
		local curPassLayerId = TowerComposeModel.instance:getThemePassLayer(curThemeId)

		curLayerId = TowerComposeModel.instance:getCurUnlockPlaneLayerId(curThemeId, curPassLayerId)
	end

	TowerComposeModel.instance:setCurThemeIdAndLayer(curThemeId, curLayerId)
	self:openTowerThemeView(param)

	if self.jumpFlow then
		self.jumpFlow:onDone(true)
	end
end

function TowerComposeController:jumpToModEquipView(taskConfig)
	if taskConfig.jumpId == 0 and (taskConfig.taskType == TowerComposeEnum.TaskType.LimitTime or taskConfig.taskType == TowerComposeEnum.TaskType.Research) and not string.nilorempty(taskConfig.params) then
		local paramInfo = string.split(taskConfig.params, "|")
		local themeId = tonumber(paramInfo[1])
		local passLayerId = TowerComposeModel.instance:getThemePassLayer(themeId)
		local curUnlockPlaneLayerId = TowerComposeModel.instance:getCurUnlockPlaneLayerId(themeId, passLayerId)

		if curUnlockPlaneLayerId > 0 then
			local modList = string.splitToNumber(paramInfo[2], "#")
			local param = {}

			param.themeId = themeId
			param.layerId = curUnlockPlaneLayerId
			param.jumpId = TowerComposeEnum.JumpId.TowerComposeModEquip

			self:dropTypeAllModAndEquip(param, modList)
			self:jumpView(param)

			return true
		else
			GameFacade.showToast(ToastEnum.TowerComposeNotOpen)

			return false
		end
	end

	return false
end

function TowerComposeController:dropTypeAllModAndEquip(param, modList)
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(param.themeId, param.layerId)

	if towerEpisodeConfig.plane > 0 then
		local themeMo = TowerComposeModel.instance:getThemeMo(param.themeId)
		local modTypeMap = self:getModTypeMap(modList)
		local modSlotNumMap = TowerComposeConfig.instance:getModSlotNumMap(param.themeId)

		for planeId = 1, towerEpisodeConfig.plane do
			local planeMo = themeMo:getPlaneMo(planeId)

			for modType, modList in pairs(modTypeMap) do
				planeMo:dropAllSlotMod(modType)
			end
		end

		local equipPlaneMo = themeMo:getPlaneMo(1)

		for modType, modList in pairs(modTypeMap) do
			local slotNum = modSlotNumMap[modType]

			for slot, modId in ipairs(modList) do
				if slot <= slotNum then
					local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)
					local equipSlot = modConfig.slot > 0 and modConfig.slot or slot

					equipPlaneMo:setEquipModId(modType, equipSlot, modId)
				end
			end
		end

		TowerComposeModel.instance:sendSetModsRequest(param.themeId, param.layerId)
	end
end

function TowerComposeController:getModTypeMap(modList)
	local modTypeMap = {}

	for index, modId in ipairs(modList) do
		local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)

		if not modTypeMap[modConfig.type] then
			modTypeMap[modConfig.type] = {}
		end

		table.insert(modTypeMap[modConfig.type], modId)
	end

	return modTypeMap
end

function TowerComposeController:openTowerMainSelectView(param)
	self._mainviewParam = param

	TowerRpc.instance:sendGetTowerInfoRequest(self._openMainSelectView, self)
end

function TowerComposeController:_openMainSelectView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	TowerComposeRpc.instance:sendTowerComposeGetInfoRequest(true, function(_, infoCode, _)
		if infoCode == 0 then
			TaskRpc.instance:sendGetTaskInfoRequest({
				TaskEnum.TaskType.Tower,
				TaskEnum.TaskType.TowerCompose
			}, function(_, taskCode, _)
				if taskCode == 0 then
					ViewMgr.instance:openView(ViewName.TowerMainSelectView, self._mainviewParam)
				end
			end)
		end
	end)
end

function TowerComposeController:openTowerThemeView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeThemeView, param)
end

function TowerComposeController:openTowerModeChangeView(param)
	ViewMgr.instance:openView(ViewName.TowerModeChangeView, param)
end

function TowerComposeController:openTowerComposeMainView(param)
	self._mainviewParam = param

	TowerRpc.instance:sendGetTowerInfoRequest(self._openTowerComposeMainView, self)
end

function TowerComposeController:_openTowerComposeMainView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	self.enterFlow = FlowSequence.New()

	if not ViewMgr.instance:isOpen(ViewName.TowerMainSelectView) then
		self.enterFlow:addWork(TowerMainSelectEnterWork.New())
	end

	self.enterFlow:addWork(TowerEnterWork.New(self._mainviewParam, ViewName.TowerComposeMainView))
	self.enterFlow:registerDoneListener(self.flowDone, self)
	self.enterFlow:start()
end

function TowerComposeController:flowDone(isSuccess)
	self.jumpFlow = nil
end

function TowerComposeController:openTowerComposeEnvView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeEnvView, param)
end

function TowerComposeController:openTowerComposeRoleView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeRoleView, param)
end

function TowerComposeController:openTowerComposeResearchView(param)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerCompose
	}, function()
		TowerComposeTaskModel.instance:setSelectTaskType(TowerComposeEnum.TaskType.Research)
		TowerComposeTaskModel.instance:refreshList(TowerComposeEnum.TaskType.Research)
		ViewMgr.instance:openView(ViewName.TowerComposeResearchView, param)
	end)
end

function TowerComposeController:openTowerComposeResultView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeResultView, param)
end

function TowerComposeController:openTowerComposeNormalResultView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeNormalResultView, param)
end

function TowerComposeController:openTowerComposeTaskView(param)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerCompose
	}, function()
		local taskType = param and param.taskType or TowerComposeEnum.TaskType.Normal

		TowerComposeTaskModel.instance:setSelectTaskType(taskType)
		TowerComposeTaskModel.instance:refreshList(taskType)
		ViewMgr.instance:openView(ViewName.TowerComposeTaskView, param)
	end)
end

function TowerComposeController:onUpdateTaskList(msg)
	local isChange = TowerComposeTaskModel.instance:updateTaskInfo(msg.taskInfo)

	if isChange then
		TowerComposeTaskModel.instance:refreshList()
	end

	self:dispatchEvent(TowerComposeEvent.TowerComposeTaskUpdated)
end

function TowerComposeController:onSetTaskList()
	local towerTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.TowerCompose) or {}

	TowerComposeTaskModel.instance:setTaskInfoList(towerTasks)

	local curTaskSelectType = TowerComposeTaskModel.instance.curSelectTaskType

	TowerComposeTaskModel.instance:refreshList(curTaskSelectType)
	self:dispatchEvent(TowerComposeEvent.TowerComposeTaskUpdated)
end

function TowerComposeController:dailyReddotRefresh()
	TowerController.instance:checkMopUpReddotShow()
end

function TowerComposeController:_onDailyRefresh()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TowerComposeRpc.instance:sendTowerComposeGetInfoRequest(false, self.towerTaskDataRequest, self)
	end
end

function TowerComposeController:towerTaskDataRequest()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerCompose
	}, self.dailyRefresh, self)
end

function TowerComposeController:dailyRefresh()
	self:dispatchEvent(TowerComposeEvent.DailyReresh)
end

function TowerComposeController:enterFight(param)
	if not param then
		return
	end

	self.enterFightParam = param
	self.enterFightParam.episodeId = param.towerEpisodeConfig.episodeId

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal

	if self.enterFightParam and self.enterFightParam.towerEpisodeConfig and self.enterFightParam.towerEpisodeConfig.plane > 0 then
		snapshotId = ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss
	end

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, self._enterFight, self)
end

function TowerComposeController:_enterFight()
	local param = self.enterFightParam

	if not param then
		return
	end

	local episodeId = param.episodeId

	TowerComposeModel.instance:setRecordFightParam(param.towerEpisodeConfig.themeId, param.towerEpisodeConfig.layerId, param.episodeId, false)

	local speed = param.speed or 1
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	TowerComposeModel.instance:setCurFightPlaneId()
	DungeonFightController.instance:enterFight(config.chapterId, episodeId, speed)
end

function TowerComposeController:openTowerComposeModEquipView(param)
	if not param.towerEpisodeConfig then
		local themeId, layerId = TowerComposeModel.instance:getCurThemeIdAndLayer()

		param.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	end

	TowerComposeModel.instance:setCurSelectPlaneId(param.planeId or 1)
	ViewMgr.instance:openView(ViewName.TowerComposeModEquipView, param)
end

function TowerComposeController:openTowerComposeHeroGroupBuffView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeHeroGroupBuffView, param)
end

function TowerComposeController:startDungeonRequest()
	local result = FightController.instance:setFightHeroSingleGroup()

	if result then
		local param = {}
		local fightParam = FightModel.instance:getFightParam()

		param.fightParam = fightParam
		param.chapterId = fightParam.chapterId
		param.episodeId = fightParam.episodeId
		fightParam.multiplication = 1
		param.multiplication = fightParam.multiplication

		self:setFightParamsEquipsAndHero(fightParam)
		DungeonModel.instance:SetSendChapterEpisodeId(param.chapterId, param.episodeId)
		DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	end
end

function TowerComposeController:setFightParamsEquipsAndHero(fightParam)
	local curFightPlaneId = TowerComposeModel.instance:getCurFightPlaneId()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local fightParamEquips = {}
	local fightParamHeroList = {}
	local startPos = curFightPlaneId < 2 and 1 or 5
	local endPos = curFightPlaneId < 2 and 4 or 8
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local saveStr = curGroupMO:getSaveParams()
	local saveData = string.nilorempty(saveStr) and {} or cjson.decode(saveStr)
	local saveHeroList = saveData.heroList
	local curHeroList = recordFightParam.isReconnect and saveHeroList and #saveHeroList > 0 and saveHeroList or curGroupMO.heroList

	for index = startPos, endPos do
		table.insert(fightParamEquips, fightParam.equips[index])
		table.insert(fightParamHeroList, curHeroList[index])
	end

	fightParam.equips = fightParamEquips
	fightParam.mySideUids = fightParamHeroList

	local themeId = recordFightParam.themeId

	fightParam.clothId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(themeId, curFightPlaneId, TowerComposeEnum.TeamBuffType.Cloth) or 0
end

function TowerComposeController:openTowerComposeModTipView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeModTipView, param)
end

function TowerComposeController:openTowerComposeModDescTipView(param)
	ViewMgr.instance:openView(ViewName.TowerComposeModDescTipView, param)
end

function TowerComposeController:setModDescColor(desc, notSetNumColor, bracketColor, numColor)
	local curBracketColor = bracketColor or "#4e6698"
	local bracketColorFormat = string.format("<color=%s>%s</color>", curBracketColor, "%1")

	desc = string.gsub(desc, "%「.-%」", bracketColorFormat)

	if not notSetNumColor then
		desc = self:setModDescNumColor(desc, numColor)
	end

	return desc
end

function TowerComposeController:setModDescNumColor(desc, numColor)
	local richTextList = {}
	local curNumColor = numColor or "#deaa79"
	local replaceTxt = "▩rich_replace▩"

	desc = string.gsub(desc, "(<.->)", function(richText)
		table.insert(richTextList, richText)

		return replaceTxt
	end)

	local colorFormat = string.format("<color=%s>%s</color>", curNumColor, "%1")

	desc = string.gsub(desc, "[+-]?[%d%.%%]+", colorFormat)

	local replaceRichIndex = 0

	desc = string.gsub(desc, replaceTxt, function()
		replaceRichIndex = replaceRichIndex + 1

		return richTextList[replaceRichIndex] or ""
	end)
	richTextList = {}

	return desc
end

function TowerComposeController:showPlaneTrialLimitToast(planeId)
	local fighRecordParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = fighRecordParam.themeId
	local layerId = fighRecordParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)

	if towerEpisodeConfig.plane > 0 then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(towerEpisodeConfig.episodeId)
		local planeName = luaLang("towercompose_plane" .. planeId) or ""

		GameFacade.showToast(ToastEnum.TowerComposePlaneTrialLimit, episodeConfig.name, planeName)
	else
		GameFacade.showToast(ToastEnum.TrialJoinLimit, 1)
	end
end

TowerComposeController.instance = TowerComposeController.New()

return TowerComposeController
