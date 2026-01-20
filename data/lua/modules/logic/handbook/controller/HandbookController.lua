-- chunkname: @modules/logic/handbook/controller/HandbookController.lua

module("modules.logic.handbook.controller.HandbookController", package.seeall)

local HandbookController = class("HandbookController", BaseController)

HandbookController.EventName = {
	PlayCharacterSwitchCloseAnim = 3,
	PlayCharacterSwitchOpenAnim = 2,
	OnShowSubCharacterView = 1
}
HandbookController.OpenViewNameEnum = {
	HandbookCharacterView = 1,
	HandbookStoryView = 3,
	HandbookEquipView = 2
}

function HandbookController:onInit()
	self._openViewName = 0
end

function HandbookController:reInit()
	self._openViewName = 0
end

function HandbookController:addConstEvents()
	return
end

function HandbookController:jumpView(param)
	local remainViewNames = {}

	self:openView()

	if #param <= 1 then
		return remainViewNames
	end

	local viewType = tonumber(param[2])

	if viewType == JumpEnum.HandbookType.Character then
		self:openCharacterView()
		table.insert(remainViewNames, ViewName.HandBookCharacterSwitchView)
	elseif viewType == JumpEnum.HandbookType.Equip then
		self:openEquipView()
		table.insert(remainViewNames, HandbookEquipView)
	elseif viewType == JumpEnum.HandbookType.Story then
		local chapter = tonumber(param[3])

		if chapter then
			self:openStoryView(chapter)
		else
			self:openStoryView()
		end

		table.insert(remainViewNames, HandbookStoryView)
	elseif viewType == JumpEnum.HandbookType.CG then
		self:openCGView()
		table.insert(remainViewNames, HandbookCGView)
	end

	return remainViewNames
end

function HandbookController:openView(param)
	self:markNotFirstHandbook()
	ViewMgr.instance:openView(ViewName.HandbookView, param)
end

function HandbookController:openCharacterView(param)
	self._openViewParam = param
	self._openViewName = HandbookController.OpenViewNameEnum.HandbookCharacterView

	HandbookRpc.instance:sendGetHandbookInfoRequest(self._getHandbookInfoReply, self)
end

function HandbookController:openEquipView(param)
	self._openViewParam = param
	self._openViewName = HandbookController.OpenViewNameEnum.HandbookEquipView

	HandbookRpc.instance:sendGetHandbookInfoRequest(self._getHandbookInfoReply, self)
end

function HandbookController:openStoryView(param)
	self._openViewParam = param
	self._openViewName = HandbookController.OpenViewNameEnum.HandbookStoryView

	HandbookRpc.instance:sendGetHandbookInfoRequest(self._getHandbookInfoReply, self)
end

function HandbookController:_getHandbookInfoReply()
	if not self.viewNameDict then
		self.viewNameDict = {
			[HandbookController.OpenViewNameEnum.HandbookCharacterView] = ViewName.HandBookCharacterSwitchView,
			[HandbookController.OpenViewNameEnum.HandbookEquipView] = ViewName.HandbookEquipView,
			[HandbookController.OpenViewNameEnum.HandbookStoryView] = ViewName.HandbookStoryView
		}
	end

	ViewMgr.instance:openView(self.viewNameDict[self._openViewName], self._openViewParam)

	self._openViewParam = nil
end

function HandbookController:openCGView(param)
	ViewMgr.instance:openView(ViewName.HandbookCGView, param)
end

function HandbookController:openCGDetailView(param)
	ViewMgr.instance:openView(ViewName.HandbookCGDetailView, param)
end

function HandbookController:markNotFirstHandbook()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstHandbook .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, 1)
end

function HandbookController:isFirstHandbook()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstHandbook .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, 0) <= 0
end

function HandbookController:markNotFirstHandbookSkin()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbook3_0 .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, 1)
	self:dispatchEvent(HandbookEvent.EnterHandbookSkin)
end

function HandbookController:isFirstHandbookSkin()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbook3_0 .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, 0) <= 0
end

function HandbookController:hasAnyHandBookSkinGroupRedDot()
	for groupId, _ in pairs(HandbookEnum.HandbookSkinShowRedDotMap) do
		if self:isHandbookSkinRedDotShow(groupId) then
			return true
		end
	end

	return false
end

function HandbookController:markHandbookSkinRedDotShow(skinGroupId)
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbookSuit .. tostring(skinGroupId) .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, 1)
	self:dispatchEvent(HandbookEvent.MarkHandbookSkinSuitRedDot)
end

function HandbookController:isHandbookSkinRedDotShow(skinGroupId)
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbookSuit .. tostring(skinGroupId) .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, 0) <= 0
end

function HandbookController:openHandbookWeekWalkMapView(param)
	self._openViewParam = param

	WeekwalkRpc.instance:sendGetWeekwalkEndRequest(self._getWeekWalkEndReply, self)
end

function HandbookController:_getWeekWalkEndReply()
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkMapView, self._openViewParam)

	self._openViewParam = nil
end

function HandbookController:openHandbookSkinView(param)
	ViewMgr.instance:openView(ViewName.HandbookSkinView, param)
end

function HandbookController:statSkinTab(tabId)
	StatController.instance:track(StatEnum.EventName.SkinCollectionTab, {
		[StatEnum.EventProperties.Skin_TabId] = tabId
	})
end

function HandbookController:statSkinSuiteId(suiteId)
	StatController.instance:track(StatEnum.EventName.SkinCollectionTab, {
		[StatEnum.EventProperties.Skin_SuiteId] = suiteId
	})
end

function HandbookController:statSkinSuitDetail(suitId)
	local skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(suitId)

	if skinSuitCfg then
		StatViewController.instance:track(string.format("%s-%s", StatViewNameEnum.OtherViewName.HandbookSkinSuitDetailView, skinSuitCfg.name or suitId), StatViewNameEnum.OtherViewName.HandbookSkinView)
	end
end

HandbookController.instance = HandbookController.New()

return HandbookController
