-- chunkname: @modules/logic/activity/model/show/ActivityGuestBindViewListModel.lua

module("modules.logic.activity.model.show.ActivityGuestBindViewListModel", package.seeall)

local ActivityGuestBindViewListModel = class("ActivityGuestBindViewListModel", ListScrollModel)

ActivityGuestBindViewListModel.instance = ActivityGuestBindViewListModel.New()

return ActivityGuestBindViewListModel
