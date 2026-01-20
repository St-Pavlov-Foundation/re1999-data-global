-- chunkname: @modules/logic/activity/model/ActivityNoviceSignItemListModel.lua

module("modules.logic.activity.model.ActivityNoviceSignItemListModel", package.seeall)

local ActivityNoviceSignItemListModel = class("ActivityNoviceSignItemListModel", ListScrollModel)

function ActivityNoviceSignItemListModel:setDayList(Infos)
	self._moList = Infos and Infos or {}

	self:setList(self._moList)
end

ActivityNoviceSignItemListModel.instance = ActivityNoviceSignItemListModel.New()

return ActivityNoviceSignItemListModel
