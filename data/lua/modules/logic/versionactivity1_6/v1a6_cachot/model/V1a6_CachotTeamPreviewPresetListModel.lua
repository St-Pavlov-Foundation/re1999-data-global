-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotTeamPreviewPresetListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamPreviewPresetListModel", package.seeall)

local V1a6_CachotTeamPreviewPresetListModel = class("V1a6_CachotTeamPreviewPresetListModel")

function V1a6_CachotTeamPreviewPresetListModel:getEquip(mo)
	return self._equipMap[mo]
end

function V1a6_CachotTeamPreviewPresetListModel:initList()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo
	local heroList = teamInfo:getGroupHeros()
	local equipList = teamInfo:getGroupEquips()

	self._equipMap = {}

	local list = {}

	for i = 1, V1a6_CachotEnum.HeroCountInGroup do
		local mo = heroList[i] or HeroSingleGroupMO.New()

		table.insert(list, mo)

		local equipMo = equipList[i]

		self._equipMap[mo] = equipMo

		V1a6_CachotTeamModel.instance:setSeatInfo(i, V1a6_CachotTeamModel.instance:getSeatLevel(i), mo)
	end

	return list
end

V1a6_CachotTeamPreviewPresetListModel.instance = V1a6_CachotTeamPreviewPresetListModel.New()

return V1a6_CachotTeamPreviewPresetListModel
