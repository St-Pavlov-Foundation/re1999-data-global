-- chunkname: @modules/logic/dungeon/rpc/DungeonPackStartDungeonRequestHelper.lua

module("modules.logic.dungeon.rpc.DungeonPackStartDungeonRequestHelper", package.seeall)

local DungeonPackStartDungeonRequestHelper = _M

function DungeonPackStartDungeonRequestHelper.initHandle()
	if DungeonPackStartDungeonRequestHelper.handleDict then
		return
	end

	DungeonPackStartDungeonRequestHelper.handleDict = {
		[DungeonEnum.EpisodeType.Rouge] = DungeonPackStartDungeonRequestHelper.packRougeCustomParam,
		[DungeonEnum.EpisodeType.WeekWalk_2] = DungeonPackStartDungeonRequestHelper.packWeekWalkCustomParam,
		[DungeonEnum.EpisodeType.Act183] = DungeonPackStartDungeonRequestHelper.packAct183CustomParam,
		[DungeonEnum.EpisodeType.TowerCompose] = DungeonPackStartDungeonRequestHelper.packTowerComposeCustomParam
	}
end

function DungeonPackStartDungeonRequestHelper.packRequestCustomParams(request, episodeConfig)
	if not episodeConfig then
		return
	end

	DungeonPackStartDungeonRequestHelper.initHandle()

	local handle = DungeonPackStartDungeonRequestHelper.handleDict[episodeConfig.type]

	if handle then
		handle(request, episodeConfig)
	end
end

function DungeonPackStartDungeonRequestHelper.packRougeCustomParam(request, episodeConfig)
	request.params = tostring(RougeConfig1.instance:season())
end

function DungeonPackStartDungeonRequestHelper.packWeekWalkCustomParam(request, episodeConfig)
	request.params = WeekWalk_2Model.instance:getFightParam()
end

function DungeonPackStartDungeonRequestHelper.packAct183CustomParam(request, episodeConfig)
	request.params = Act183Helper.generateStartDungeonParams(episodeConfig.id)
end

function DungeonPackStartDungeonRequestHelper.packTowerComposeCustomParam(request, episodeConfig)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local extraParams = {}
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(recordFightParam.themeId, recordFightParam.layerId)

	extraParams.themeId = recordFightParam.themeId
	extraParams.layerId = recordFightParam.layerId
	extraParams.planeId = TowerComposeModel.instance:getCurFightPlaneId()
	extraParams.supportId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(extraParams.themeId, extraParams.planeId, TowerComposeEnum.TeamBuffType.Support)
	extraParams.researchId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(extraParams.themeId, extraParams.planeId, TowerComposeEnum.TeamBuffType.Research)
	request.params = cjson.encode(extraParams)
end

return DungeonPackStartDungeonRequestHelper
